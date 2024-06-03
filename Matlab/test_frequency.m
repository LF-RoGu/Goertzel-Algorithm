function test_frequency(desired_freq, phase_deg, signal_type)
    % Parameters
    fs = 8000;              % Sample frequency in Hz
    N = 205;               % Number of samples

    % Generate test signal
    t = (0:N-1) / fs;
    phase_rad = phase_deg * pi / 180;
    signal = generate_signal(t, desired_freq, phase_rad, signal_type);

    % Apply Goertzel algorithm
    result = goertzel_algorithm(signal, fs, desired_freq, N);
    fprintf('Signal: %s, Frequency: %d Hz, Phase: %d deg, Goertzel Result: %f\n', signal_type, desired_freq, phase_deg, result);

    % Plot frequency response
    %plot_frequency_response(signal, fs, N, signal_type, desired_freq, phase_rad);
end
