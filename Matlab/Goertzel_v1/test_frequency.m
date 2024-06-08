function test_frequency(desired_freq, phase_deg, signal_type)
    % Parameters
    fs = 4e6;              % Sample frequency in Hz
    N = 135;               % Number of samples

    % Generate test signal
    t = (0:N-1) / fs;
    t_signal = 0:0.01:2*pi;
    phase_rad = phase_deg * pi / 180;
    signal = generate_signal(t_signal, desired_freq, phase_rad, signal_type);
    
    % Center the signal around zero
    signal = signal - mean(signal);

    % Apply Goertzel algorithm
    [real_part, imag_part, magnitude2] = goertzel_algorithm(signal, fs, desired_freq, N);
    fprintf('Signal: %s, Frequency: %d Hz, Phase: %d deg\n', signal_type, desired_freq, phase_deg);
    fprintf('Real = %f, Imag = %f\n', real_part, imag_part);
    fprintf('Magnitude squared = %f\n', magnitude2);
    fprintf('Magnitude = %f\n', sqrt(magnitude2));

    % Plot frequency response
    %plot_frequency_response(signal, fs, N, signal_type, desired_freq, phase_rad);
end
