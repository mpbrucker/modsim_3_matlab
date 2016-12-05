% Returns the settling time of the system, in seconds
function time = get_settle_time(t,thetas)
    time = t(end); % Default - if it doesn't settle
    if (abs(thetas(end)-pi) < 0.05) % If the system does settle
        for i=size(thetas):-1:1
            if (abs(thetas(i)-pi) > 0.05) % find the last time it went out of an arbitrary equilibrium range
                time = t(i);
                break;
            end
        end
    end
end