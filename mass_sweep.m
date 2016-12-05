function res = mass_sweep()
initial_time  = 0;
final_time = 10;
length_p = 3; % m
width = .3; % m
timestep = .001; % s
k_p = 8000;
k_i = 5000;
k_d = 0;

mass_person_range = 45:5:90;
mass_length = length(mass_person_range);

for i = 1:mass_length
    hold on;
    [t, res] = run_pendulum(initial_time, final_time, length_p, width, mass_person_range(i), timestep, k_p,k_i,k_d);
    theta = res(:,2);
    theta = theta - pi;
    plot(t, theta);
    
end

end