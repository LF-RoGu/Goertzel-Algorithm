function magnitude = goertzel_final(state, coeff, scalingFactor, omega)
    cosine = cos(omega);
    sine = sin(omega);
    % Calculate the real and imaginary parts
    real_part = ((state(1) * cosine) - state(2)) / scalingFactor;
    imag_part = (state(1) * sine) / scalingFactor;
    magnitude = sqrt(real_part^2 + imag_part^2);
end
