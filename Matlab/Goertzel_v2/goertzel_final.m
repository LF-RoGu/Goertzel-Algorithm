function magnitude = goertzel_final(state, coeff)
    % Calculate the final magnitude
    real_part = state(2) - state(1) * cos(2 * pi * coeff);
    imag_part = state(1) * sin(2 * pi * coeff);
    magnitude = real_part^2 + imag_part^2;
end
