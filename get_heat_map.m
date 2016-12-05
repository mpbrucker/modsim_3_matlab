function res = get_heat_map()
clf;
initial_time  = 0;
final_time = 20;
length_p = 3; % m
width = .3; % m

k_p_range = 100:500:10000;
k_i_range = 100:500:10000;
k_d_range = 100:500:10000;

matrix = zeros(length(k_p_range),length(k_i_range),length(k_d_range));

for i = 1:length(k_p_range)
    for j =  1:length(k_i_range)
        for k = 1:length(k_d_range)
            [t, res,event_time,failState] = run_pendulum(initial_time,  ...
                final_time, length_p, width, 80.7, .01, k_p_range(i),k_i_range(j),k_d_range(k));
            thetas = res(:,2);
            if (failState == 0)
                settle_time = get_settle_time(t,thetas);
            else
                settle_time = final_time;
            end
            matrix(i,j,k) = settle_time;
        end
    end
end

[M,I] = min(matrix(:));
[I_1,I_2,I_3] = ind2sub(size(matrix),I);

display(k_p_range(I_1));
display(k_i_range(I_2));
display(k_d_range(I_3));


% pcolor(k_i_range,k_p_range,matrix);
% colorbar;
end