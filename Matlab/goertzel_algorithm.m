function result = goertzel_algorithm(signal, fs, target_freq, N)
    % Constants
    k = round(target_freq * N / fs);
    omega = (2 * pi * k) / N;
    cosine = cos(omega);
    sine = sin(omega);
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
        s = coeff * s_prev1 - s_prev2 + signal(n);
        s_prev2 = s_prev1;
        s_prev1 = s;
    end

    % Final computation
    real_part = s_prev1 - s_prev2 * cos(omega) ;
    imag_part = s_prev2 * sin(omega);
    result = real_part^2 + imag_part^2;

    fprintf("Real = %f\n" + ...
    "Img = %f\n", real_part, imag_part);
end
