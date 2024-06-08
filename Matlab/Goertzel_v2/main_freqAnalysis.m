clc;
clear all;
close all;
% Compare multiple frequencies by running the Goertzel algorithm for each target frequency and comparing their magnitudes

% Specifications
N = 135;
f_sample = 4e6; % 4 MHz
f_target = 150e3; % 150 kHz

% Generate a test input signal (for example, a 150 kHz sine wave)
t = (0:N-1) / f_sample;
input_signal = 2048 + 2047 * sin(2 * pi * f_target * t); % 12-bit unsigned offset binary

% Run Goertzel algorithm
magnitude = goertzel_main(input_signal, N, f_target, f_sample);

% Define multiple target frequencies
target_frequencies = [150e3, 300e3, 450e3]; % in Hz

% Initialize an array to store magnitudes
magnitudes = zeros(size(target_frequencies));

% Run Goertzel algorithm for each target frequency
for i = 1:length(target_frequencies)
    f_target = target_frequencies(i);
    magnitudes(i) = goertzel_main(input_signal, N, f_target, f_sample);
end

% Display the results
for i = 1:length(target_frequencies)
    fprintf('Frequency %.2f kHz, Magnitude: %.2f\n', target_frequencies(i) / 1000, magnitudes(i));
end

% Compare magnitudes
[max_magnitude, max_index] = max(magnitudes);
fprintf('Highest magnitude: %.2f at frequency %.2f kHz\n', max_magnitude, target_frequencies(max_index) / 1000);

