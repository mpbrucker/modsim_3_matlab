function res = get_heat_map()
clf;
initial_time  = 0;
final_time = 5;
length_p = 3; % m
width = .3; % m

k_p_range = 500:500:8000;
k_i_range = 500:500:5000;

time_length = length(k_p_range)
mass_length = length(k_i_range)

matrix = zeros(time_length,mass_length);

for i = 1:time_length
    for j =  1:mass_length
        [t, res,event_time,failState] = run_pendulum(initial_time, final_time, length_p, width, 80.7, .01, k_p_range(i),k_i_range(j),0);
        thetas = res(:,2);
        display(size(thetas));
        settle_time = get_settle_time(t,thetas);
        matrix(i,j) = settle_time;
    end
end

pcolor(k_i_range,k_p_range,matrix);
colorbar;
end