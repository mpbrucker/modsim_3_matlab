function [t,res] = run_pendulum(initial_time, final_time, length, width, timestep)

    tspan = initial_time:timestep:final_time; % Builds the set of times

    x_init = 0; % m
    theta_init = pi+.1; % rad
    
    v_x_init = 0; % m/s
    v_theta_init = 0; % rad/s
    
    state_vars_init = [x_init; theta_init; v_x_init; v_theta_init];
    
    M = .5; % mass of cart, kg
    m = .2; % mass of pendulum, kg
    b = 0; % coefficient of friction for cart, N/m/sec
    l = length/2; % length to pendulum center of mass, m
    w = width; % Width of pendulum cuboid, m
    
    % Note: length is multipled by 2 because the actual length is twice the
    % length to the center of mass
    I = get_inertia_moment(l*2,w,m); % moment of inertia of the pendulum, kg*m^2
    
    % Ode options: event stops sim when pendulum hits cart, rel tol
    % increases tolerance 
    
    function [value,isterminal,direction] = events(~, state_vars)
        value = [state_vars(2) - pi/2; state_vars(2) - 3*pi/2];
        isterminal = [1; 1]; 
        direction = [0; 0];
    end
    options = odeset('Events', @events, 'RelTol', 1e-4);

    curr_theta = 0;
    state_vars = [];
    t = [0];
    size_time = size(tspan);
    for j = 1:size_time(2)-1
        F = (curr_theta-pi)*-10;
        dxdt = @(ti, vars) get_state_vars(ti, vars, M, m, b, l, I,F);
        times = [0;timestep];
        [t_out, out_vars] = ode45(dxdt, times, state_vars_init, options);
        curr_theta = out_vars(end,2);
        state_vars_init = out_vars(end,:);
        t = vertcat(t,t(end)+t_out(end));
        state_vars = cat(1,state_vars,out_vars(end,:));
        if (curr_theta <= pi/2 | curr_theta >= (3*pi)/2)
            break;
        end
    end
   
    res = state_vars;
end