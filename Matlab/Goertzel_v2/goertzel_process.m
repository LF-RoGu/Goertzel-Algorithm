function state = goertzel_process(input_sample, coeff, state)
    % Update the state with the new sample
    q0 = coeff * state(1) - state(2) + input_sample;
    % Update state array
    state(2) = state(1);
    state(1) = q0;
end