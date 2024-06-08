clc;
clear all;
close all;
% Specifications
N = 135;
f_sample = 4e6; % 4 MHz
f_target = 150e3; % 150 kHz
signal_duration = 0.01; % Duration in seconds
threshold = 1000; % Define a detection threshold

% Generate a clean test input signal (a 150 kHz sine wave)
t = (0:signal_duration*f_sample-1) / f_sample;
clean_signal = 2048 + 2047 * sin(2 * pi * f_target * t); % 12-bit unsigned offset binary

% Add Gaussian noise to the signal
noise = randn(size(t)) * 200; % Adjust the noise level as needed
noisy_signal = clean_signal + noise;

% Apply Gaussian filter to the noisy signal
sigma = 10; % Standard deviation of the Gaussian filter
filtered_signal = gaussian_filter(noisy_signal, sigma);

% Simulate real-time monitoring by processing signal in chunks
chunk_size = N; % Size of each chunk
num_chunks = floor(length(noisy_signal) / chunk_size);

% Initialize results storage
magnitudes = zeros(1, num_chunks);

% Process each chunk
alert_triggered = false;

for chunk = 1:num_chunks
    start_index = (chunk - 1) * chunk_size + 1;
    end_index = chunk * chunk_size;
    signal_chunk = noisy_signal(start_index:end_index);
    
    % Run Goertzel algorithm on the current chunk
    magnitudes(chunk) = goertzel_main(signal_chunk, chunk_size, f_target, f_sample);
    
    % Check if magnitude exceeds the threshold
    if magnitudes(chunk) > threshold
        fprintf('ALERT! High magnitude detected at %.2f kHz, Magnitude: %.2f\n', f_target / 1000, magnitudes(chunk));
        alert_triggered = true;
    else
        fprintf('Chunk %d: Frequency %.2f kHz, Magnitude: %.2f\n', chunk, f_target / 1000, magnitudes(chunk));
    end
end

if ~alert_triggered
    fprintf('No alerts triggered during monitoring period.\n');
end

% Plot the magnitudes over time
time_chunks = (1:num_chunks) * chunk_size / f_sample;
figure;
plot(time_chunks, magnitudes);
title('Magnitude of 150 kHz Frequency Component Over Time');
xlabel('Time (seconds)');
ylabel('Magnitude');
grid on;

%% Plot the signals for comparison
figure;
subplot(3, 1, 1);
plot(t(1:N), clean_signal(1:N));
title('Clean Signal');
xlabel('Time (s)');
ylabel('Amplitude');

subplot(3, 1, 2);
plot(t(1:N), noisy_signal(1:N));
title('Noisy Signal');
xlabel('Time (s)');
ylabel('Amplitude');

subplot(3, 1, 3);
plot(t(1:N), filtered_signal(1:N));
title('Filtered Signal');
xlabel('Time (s)');
ylabel('Amplitude');
