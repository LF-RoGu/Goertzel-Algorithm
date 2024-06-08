function [coeff, state] = goertzel_init(N, f_target, f_sample)
    k = round(N * f_target / f_sample);
    omega = 2 * pi * k / N;
    coeff = 2 * cos(omega);
    state = zeros(1, 3); % Initialize state buffer (s[n-2], s[n-1], s[n])
end
