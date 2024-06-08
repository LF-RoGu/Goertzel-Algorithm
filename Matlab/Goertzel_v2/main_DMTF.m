clc;
clear all;
close all;
% Specifications
N = 135;
f_sample = 4e6; % 4 MHz
threshold = 1000; % Define a detection threshold

% Generate a test input signal (for example, a DTMF tone for '5' which is 770 Hz and 1336 Hz)
f_target1 = 770;
f_target2 = 1336;
t = (0:N-1) / f_sample;
input_signal = 2048 + 2047 * (sin(2 * pi * f_target1 * t) + sin(2 * pi * f_target2 * t)); % 12-bit unsigned offset binary

% DTMF Frequencies
dtmf_frequencies = [697, 770, 852, 941, 1209, 1336, 1477, 1633];
detected = false;

% Check each DTMF frequency
for i = 1:length(dtmf_frequencies)
    f_target = dtmf_frequencies(i);
    magnitude = goertzel_main(input_signal, N, f_target, f_sample);
    
    if magnitude > threshold
        fprintf('Detected DTMF Frequency: %.2f Hz, Magnitude: %.2f\n', f_target, magnitude);
        detected = true;
    end
end

if ~detected
    fprintf('No DTMF frequency detected.\n');
end
