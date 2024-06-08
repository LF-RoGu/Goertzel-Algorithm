function magnitude = goertzel_main(input_signal, N, f_target, f_sample)
    [coeff, state] = goertzel_init(N, f_target, f_sample);
    for n = 1:N
        state = goertzel_process(input_signal(n), coeff, state);
    end
    magnitude = goertzel_final(state, coeff);
end
