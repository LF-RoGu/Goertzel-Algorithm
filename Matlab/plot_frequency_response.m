function plot_frequency_response(signal, fs, N, signal_type, freq, phase)
    % Calculate the frequency response using Goertzel Algorithm
    freq_range = linspace(0, fs/2, 500);
    magnitude_response = zeros(size(freq_range));
    
    for i = 1:length(freq_range)
        magnitude_response(i) = goertzel_algorithm(signal, fs, freq_range(i), N);
    end
    
    % Compute DFT
    dft_result = fft(signal);
    dft_freq = (0:N-1)*(fs/N);
    
    % Plot the Goertzel Algorithm Frequency Response
    figure;
    subplot(3,1,1);
    plot(freq_range, magnitude_response);
    xlabel('Frequency (Hz)');
    ylabel('Magnitude');
    title(sprintf('Goertzel Frequency Response of %s, f=%dHz, phase=%d°', signal_type, freq, round(phase*180/pi)));
    grid on;
    
    % Plot DFT Real Part
    subplot(3,1,2);
    plot(dft_freq, real(dft_result));
    xlabel('Frequency (Hz)');
    ylabel('Real Part');
    title('DFT Real Part');
    grid on;
    
    % Plot DFT Imaginary Part
    subplot(3,1,3);
    plot(dft_freq, imag(dft_result));
    xlabel('Frequency (Hz)');
    ylabel('Imaginary Part');
    title('DFT Imaginary Part');
    grid on;
end
