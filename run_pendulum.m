function [t,res] = run_pendulum(initial_time, final_time, length, width, timestep)

    tspan = initial_time:timestep:final_time; % Builds the set of times

    x_init = 0; % m
    theta_init = pi; % rad
    
    v_x_init = 1; % m/s
    v_theta_init = 0; % rad/s
    
    state_vars_init = [x_init; theta_init; v_x_init; v_theta_init];
    
    M = 1000; % mass of cart, kg
    m = 300; % mass of pendulum, kg
    b = .1; % coefficient of friction for cart, N/m/sec
    l = length; % length to pendulum center of mass, m
    w = width; % Width of pendulum cuboid, m
    
    % Note: length is multipled by 2 because the actual length is twice the
    % length to the center of mass
    I = get_inertia_moment(l*2,w,m); % moment of inertia of the pendulum, kg*m^2
    F = 0; % force applied to cart, N
    
    dxdt = @(ti, state_vars) get_state_vars(ti, state_vars, M, m, b, l, I, F);
    

    [t, state_vars] = ode45(dxdt, tspan, state_vars_init);
    
    res = state_vars;
end