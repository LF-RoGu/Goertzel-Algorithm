clc;
clear all;
close all;
% Specifications
N = 135;
f_sample = 4e6; % 4 MHz
threshold = 1000; % Define a detection threshold

% Generate a test input signal (for example, a motor operating with a harmonic at 100 Hz)
f_target = 200;
t = (0:N-1) / f_sample;
input_signal = 2048 + 2047 * sin(2 * pi * f_target * t); % 12-bit unsigned offset binary

% Harmonic Frequencies to Monitor
harmonic_frequencies = [100, 200, 300]; % Example harmonic frequencies in Hz
fault_detected = false;

% Check each harmonic frequency
for i = 1:length(harmonic_frequencies)
    f_target = harmonic_frequencies(i);
    magnitude = goertzel_main(input_signal, N, f_target, f_sample);
    
    if magnitude > threshold
        fprintf('Potential Fault Detected at %.2f Hz, Magnitude: %.2f\n', f_target, magnitude);
        % Normalize magnitude
        normalized_magnitude = magnitude / (N * 2047); % Assuming maximum possible amplitude of 2047 for 12-bit unsigned
        fprintf('Normalized Magnitude: %.2f\n', normalized_magnitude);
        % Convert magnitude to decibels (dB)
        magnitude_dB = 10 * log10(magnitude);
        fprintf('Magnitude in dB: %.2f dB\n', magnitude_dB);
        fault_detected = true;
    end
end

if ~fault_detected
    fprintf('Motor operating normally.\n');
end
