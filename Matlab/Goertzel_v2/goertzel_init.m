function [coeff, state, scalingFactor] = goertzel_init(N, f_target, f_sample)
    k = round(N * f_target / f_sample);
    omega = 2 * pi * k / N;
    coeff = 2 * cos(omega);
    state = zeros(1, 2); % Initialize state buffer (q1, q2)
    scalingFactor = N / 2;
end