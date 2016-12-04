function [t,res,eventTime] = run_pendulum(initial_time, final_time, length, width, mass_person, timestep)


    tspan = initial_time:timestep:final_time; % Builds the set of times

    x_init = 0; % m

    theta_init = pi+.2; % rad
    
    v_x_init = 0; % m/s
    v_theta_init = 0; % rad/s
    
    state_vars_init = [x_init; theta_init; v_x_init; v_theta_init];
    
    M = 500; % mass of cart, kg
    
    mass_ladder = 136/2; % kg, http://www.wernerco.com/us/support/ladder-safety-tips/how-to-choose-a-ladder
    m = mass_ladder + mass_person; % mass of pendulum, kg
    
    b = 1; % coefficient of friction for cart, N/m/sec

    l = length/2; % length to pendulum center of mass, m
    w = width; % Width of pendulum cuboid, m
    
    % Note: length is multipled by 2 because the actual length is twice the
    % length to the center of mass
    I = get_inertia_moment(l*2,w,m); % moment of inertia of the pendulum, kg*m^2
    
    % Ode options: event stops sim when pendulum hits cart, rel tol
    % increases tolerance 
    
    maxRange = .5; % radians, range of theta (centered around 0) for 
    % pendulum to be considered stable
    diff = maxRange/2;
    pos_value = pi - diff; % radians, values for event function
    neg_value = pi + diff;
    
%     function [value,isterminal,direction] = events(~, state_vars)
%         value = [state_vars(2) - pos_value; state_vars(2) - neg_value];
%         isterminal = [0; 0]; 
%         direction = [0; 0];
%     end
    function [value,isterminal,direction] = events(~, state_vars)
        value = state_vars(2) - pi;
        isterminal = 1;
        direction = 0;
    end
    options = odeset('Events', @events, 'RelTol', 1e-4);

    % The state vars to represent the system state after every timestep
    curr_theta = 0; % records the angle of the pendulum after each timestep
    state_vars = [];

    t = [0]; % The vector of times after each timestep
    
    error_vals = [pi-theta_init]; % The vector of errors
    k_p = 10000; % Proportional constant (P term)
    k_i = 6000; % Integral constant (I term)
    k_d = 4000; % Derivative constant (D term)
    
    size_time = size(tspan,2);
    eventTime = 0;
    for j = 1:size_time-1
        [i,d] = get_PID_params(t,error_vals);
%         if (abs(j-round(size_time/2))<5)
%             F=22;
%         else
            F = error_vals(end)*k_p+i*k_i+d*k_d; % Proportional outside force
%         end
        dxdt = @(ti, vars) get_state_vars(ti, vars, M, m, b, l, I,F);
        [t_out, out_vars, timeEvents] = ode45(dxdt, [0 timestep], state_vars_init, options);
        
        
        curr_theta = out_vars(end,2); % The pendulum angle after each timestep
        state_vars_init = out_vars(end,:); % The state vars to plug in to the next timestep function
        
        error_vals = cat(1,error_vals,pi-curr_theta);
        
        if isempty(timeEvents) ==  1
            thisEventTime = 0;
        else
            thisEventTime = timeEvents(1);
        end
        eventTime = thisEventTime + eventTime; 
        
        % Builds the vectors of times and state vars after each timestep
        t = vertcat(t,t(end)+t_out(end));
        state_vars = cat(1,state_vars,out_vars(end,:));
        
        % Stops the simulation if the system fails
%         if (curr_theta <= pi/2 || curr_theta >= (3*pi)/2)
%             break;
%         end
        if (curr_theta <= pos_value || curr_theta >= neg_value)
            break;
        end
    end
    
    t(end)
    res = state_vars;
    
end