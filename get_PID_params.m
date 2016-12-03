function [i,d] = get_PID_params(t,error_vals)
    d = 0;
    if (size(t,1) > 1)
        d = (error_vals(end)-error_vals(end-1))/(t(end)-t(end-1));
    end
    i = 0;
    for j=1:size(t,1)-1
        i = i + error_vals(j)*(t(j+1)-t(j));
    end
end
    
        