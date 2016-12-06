function force_profile()

initial_time  = 0;
final_time = 10;
length_p = 3; % m
width = .3; % m
timestep = .001; % s
mass_person = 70; % kg

[t,~,~,~,forces] = run_pendulum(initial_time, final_time, length_p, width, mass_person, timestep, 9600, 2000, 1100);

impulses = zeros(length(t),1);
impulses(1) = abs(forces(1))*timestep;

% plots force applied versus time 
subplot(2,1,1)

    plot(t,forces)
    
subplot(2,1,2)
    for i = 2:length(t)
        impulses(i) = abs(forces(i))*timestep + impulses(i-1);
    end
    plot(t,impulses)
    
impulses(end)
end