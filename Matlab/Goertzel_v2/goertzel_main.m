function magnitude = goertzel_main(input_signal, N, f_target, f_sample)
    [coeff, state, scalingFactor] = goertzel_init(N, f_target, f_sample);
    omega = 2 * pi * round(N * f_target / f_sample) / N; % Recalculate omega

    for i = 1:N
        state = goertzel_process(input_signal(i), coeff, state);
    end

    magnitude = goertzel_final(state, coeff, scalingFactor, omega);
end