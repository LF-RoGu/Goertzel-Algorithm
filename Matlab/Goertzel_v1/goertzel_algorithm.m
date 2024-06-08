function [real_part, imag_part, magnitude2] = goertzel_algorithm(signal, fs, target_freq, N)
    % Constants
    k = round(((target_freq * N) / fs) + 0.5);
    omega = ((2 * pi)/N * k);
    cosine = cos(omega);
    sine = sin(omega);
    coeff = 2 * cosine;

    % Initialization
    s_prev1 = 0;
    s_prev2 = 0;

    % Processing
    for n = 1:N
        s = coeff * s_prev1 - s_prev2 + signal(n);
        s_prev2 = s_prev1;
        s_prev1 = s;
    end

    % Final computation
    real_part = s_prev1 - s_prev2 * cosine ;
    imag_part = s_prev2 * sin(omega);
    magnitude2 = real_part^2 + imag_part^2;
end
