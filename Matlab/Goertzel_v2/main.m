
clc;
clear all;
close all;
% Specifications
N = 135;
f_sample = 4e6; % 4 MHz
f_target = 150e3; % 150 kHz

% Generate a test input signal (for example, a 150 kHz sine wave)
t = (0:N-1) / f_sample;
input_signal = 2048 + 2047 * sin(2 * pi * f_target * t); % 12-bit unsigned offset binary

% Run Goertzel algorithm
magnitude = goertzel_main(input_signal, N, f_target, f_sample);

% Display result in kHz
target_frequency_kHz = f_target / 1000;
fprintf('Detected Frequency: %.2f kHz, Magnitude: %.2f\n', target_frequency_kHz, magnitude);
