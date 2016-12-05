function res = mass_sweep()
initial_time  = 0;
final_time = 10;
length_p = 3; % m
width = .3; % m
timestep = .001; % s
k_p = 9600;
k_i = 100;
k_d = 1100;

mass_person_range = 45:15:90;
mass_length = length(mass_person_range);

for i = 1:mass_length
    hold on;
    [t, res] = run_pendulum(initial_time, final_time, length_p, width, mass_person_range(i), timestep, k_p,k_i,k_d);
    theta = res(:,2);
    theta = theta - pi;
    plot(t, theta);
    xlabel('Time (s)');
    ylabel('Deviation from upright (rad)');
    legend('45 kg', '60 kg', '75 kg', '90 kg', 'location', 'Best');
    title('Deviation from upright over range of masses');
    
end

end