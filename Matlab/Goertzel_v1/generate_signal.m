function signal = generate_signal(t, freq, phase, signal_type)
    % Generates different types of signals with an offset
    amplitude = 1.0; % Adjust amplitude as needed
    offset = 0.0; % Adjust offset if needed
    
    switch signal_type
        case 'sine'
            signal = amplitude * sin(2 * pi * freq * t + phase) + offset; % Sine wave
        case 'square'
            signal = amplitude * square(2 * pi * freq * t + phase) + offset; % Square wave
        case 'triangle'
            signal = amplitude * sawtooth(2 * pi * freq * t + phase, 0.5) + offset; % Triangle wave
        otherwise
            error('Unknown signal type');
    end
    % Plot the generated signal
    figure;
    plot(t, signal);
    xlabel('Time (s)');
    ylabel('Amplitude');
    title(sprintf('Generated %s Signal: Frequency = %d Hz, Phase = %d°', signal_type, freq, round(phase * 180 / pi)));
    xlim([0 2*pi]); % Set x-axis limits from 0 to 2π
    grid on;
end
