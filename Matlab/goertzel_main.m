function goertzel_main()
    % Parameters
    fs = 4e6;              % Sample frequency in Hz
    N = 135;               % Number of samples
    target_freq = 150e3;   % Target frequency in Hz

    % Generate test signals
    t = (0:N-1) / fs;
    frequencies = [150e3, 149e3, 151e3, 5e3, 200e3];
    phases = [0, 30, 45, 90, 120] * pi / 180;

    signal_types = {'sine', 'square', 'triangle'};
    
    for signal_type = signal_types
        for freq = frequencies
            for phase = phases
                signal = generate_signal(t, freq, phase, signal_type{1});
                result = goertzel_algorithm(signal, fs, target_freq, N);
                fprintf('Signal: %s, Frequency: %d Hz, Phase: %d deg, Result: %f\n', signal_type{1}, freq, round(phase * 180 / pi), result);
                %plot_frequency_response(signal, fs, N, signal_type{1}, freq, phase);
            end
        end
    end
end
