function result = goertzel_algorithm(signal, fs, target_freq, N)
    % Constants
    k = round(target_freq * N / fs);
    omega = 2 * pi * k / N;
    coeff = 2 * cos(omega);
    fprintf("Precomputed constants... \n" + ...
    "k = %f\n" + ...
    "omega = %f\n" + ...
    "coeff = %f\n", k, omega, coeff);

    % Initialization
    s_prev1 = 0;
    s_prev2 = 0;

    % Processing
    for n = 1:N
        s = signal(n) + coeff * s_prev1 - s_prev2;
        s_prev2 = s_prev1;
        s_prev1 = s;
    end

    % Final computation
    real_part = s_prev1 - cos(omega) * s_prev2;
    imag_part = sin(omega) * s_prev2;
    result = real_part^2 + imag_part^2;
end
