% Parameters
Fs = 1000; % Sampling frequency in Hz
T = 1; % Duration in seconds
frequencies = [5, 15, 30]; % Frequencies of the triangle waves in Hz
phases = [0, 30, 45, 90, 120]; % Phase angles in degrees
A = 1; % Amplitude of the analog signal
nBits = 12; % Number of bits for quantization (12-bit ADC)
outputFile = 'digital_signal.hex'; % Output file name

% Generate the analog signal (sum of multiple triangle waves with different phases)
t = 0:1/Fs:T-(1/Fs); % Time vector
analogSignal = zeros(size(t));
for i = 1:length(frequencies)
    for j = 1:length(phases)
        % Convert phase to radians
        phaseRad = deg2rad(phases(j));
        analogSignal = analogSignal + A * sawtooth(2 * pi * frequencies(i) * t + phaseRad, 0.5); % 0.5 makes it a triangle wave
    end
end
analogSignal = analogSignal / (length(frequencies) * length(phases)); % Normalize the amplitude

% Quantization
maxVal = 2^(nBits-1) - 1; % Maximum positive value for a signed 12-bit number
minVal = -2^(nBits-1); % Minimum negative value for a signed 12-bit number
digitalSignal = round((analogSignal / max(abs(analogSignal))) * maxVal); % Normalize and quantize the signal

% Clip the values to the range of the ADC
digitalSignal(digitalSignal > maxVal) = maxVal;
digitalSignal(digitalSignal < minVal) = minVal;

% Convert to hexadecimal
hexSignal = dec2hex(digitalSignal + 2^(nBits-1), 3); % Adjust to unsigned and convert to hex, 3 digits for 12-bit

% Save the hexadecimal values to a file
fid = fopen(outputFile, 'w');
for i = 1:length(hexSignal)
    fprintf(fid, '%s\n', hexSignal(i, :));
end
fclose(fid);

disp(['Digital signal saved to ', outputFile]);

% Plotting the signals
figure;
subplot(2, 1, 1);
plot(t, analogSignal);
title('Analog Signal');
xlabel('Time (s)');
ylabel('Amplitude');

subplot(2, 1, 2);
stairs(t, digitalSignal);
title('Digital Signal');
xlabel('Time (s)');
ylabel('Quantized Amplitude');

% Optional: Display the hex values in the command window
disp('Hexadecimal values:');
disp(hexSignal);
