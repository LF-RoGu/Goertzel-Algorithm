function filtered_signal = gaussian_filter(signal, sigma)
    % GAUSSIAN_FILTER Applies a Gaussian filter to the input signal
    %   filtered_signal = gaussian_filter(signal, sigma) returns the filtered
    %   version of the input signal using a Gaussian filter with standard deviation sigma.

    % Create the Gaussian kernel
    kernel_size = 6 * sigma + 1; % Usually, a kernel size of 6 * sigma is sufficient
    half_size = floor(kernel_size / 2);
    x = -half_size:half_size;
    gauss_kernel = exp(-x.^2 / (2 * sigma^2));
    gauss_kernel = gauss_kernel / sum(gauss_kernel); % Normalize the kernel

    % Apply the Gaussian filter to the signal using convolution
    filtered_signal = conv(signal, gauss_kernel, 'same');
end
