function impulse = force_profile(t,forces)
    impulses = zeros(length(t),1);
    impulses(1) = abs(forces(1))*t(1);
    for i = 2:length(t)
        impulses(i) = abs(forces(i))*(t(i)-t(i-1)) + impulses(i-1);
    end
    impulse = impulses(end);
end