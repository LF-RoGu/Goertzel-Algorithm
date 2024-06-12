function q = goertzel_process(input_sample, coeff, q)
    % Update the state with the new sample
    q0 = coeff * q(1) - q(2) + input_sample;
    % Update state array
    q(1) = q(2);
    q(2) = q0;
end
