function magnitude = goertzel_final(state, coeff, scalingFactor, omega)
    cosine = cos(omega);
    sine = sin(omega);
    % Calculate the real and imaginary parts
    real_part = (state(1) - state(2) * cosine) / scalingFactor;
    imag_part = (state(2) * sine) / scalingFactor;
    magnitude = sqrt(real_part^2 + imag_part^2);
end