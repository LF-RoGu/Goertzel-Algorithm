function signal = generate_signal(t, freq, phase, signal_type)
    % Generates different types of signals
    switch signal_type
        case 'sine'
            signal = 2047.5 * (sin(2 * pi * freq * t + phase) + 1); % 12-bit offset binary
        case 'square'
            signal = 2047.5 * (square(2 * pi * freq * t + phase) + 1); % 12-bit offset binary
        case 'triangle'
            signal = 2047.5 * (sawtooth(2 * pi * freq * t + phase, 0.5) + 1); % 12-bit offset binary
        otherwise
            error('Unknown signal type');
    end
end
