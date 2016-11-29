function [value,isterminal,direction] = get_timestep(t,~,timestep)
    value = mod(t.*1000,timestep);
    display(value);
    direction = 0;
    isterminal = 0;
end