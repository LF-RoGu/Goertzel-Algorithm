function state = goertzel_process(input_sample, coeff, state)
    % Update the state with the new sample
    s_new = coeff * state(1) - state(2) + input_sample;
    % Update state array
    state(1) = state(2);
    state(2) = s_new;
end
