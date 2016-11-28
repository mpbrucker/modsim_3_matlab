function [t,res] = run_pendulum(initial_time, final_time)
    x_init = 0; % m
    theta_init = pi; % rad
    
    v_x_init = 1; % m/s
    v_theta_init = 0; % rad/s
    
    state_vars_init = [x_init; theta_init; v_x_init; v_theta_init];
    
    M = 10; % mass of cart, kg
    m = 5; % mass of pendulum, kg
    b = .1; % coefficient of friction for cart, N/m/sec
    l = .3; % length toi pendulum center of mass, m
    I = .006; % moment of inertia of the pendulum, kg*m^2
    F = 0; % force applied to cart, N
    
    dxdt = @(ti, state_vars) get_state_vars(ti, state_vars, M, m, b, l, I, F);
    [t, state_vars] = ode45(dxdt, [initial_time final_time], state_vars_init);
    
    res = state_vars;
end