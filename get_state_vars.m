function vars = get_state_vars(~, state_vars, M, m, b, l, I, F)
g = 9.8; % m/s^2;

x = state_vars(1); % m
theta = state_vars(2); % rad
v_x = state_vars(3); % m/s
v_theta = state_vars(4); % rad/s

a_x = (F - b*v_x + m*l*v_theta^2*sin(theta))/(M + m - ((m*l*cos(theta))^2)/(I + m*l^2));
a_theta = (m*l*a_x^2*cos(theta) - m*g*l*sin(theta))/(I + m*l^2);

vars = [v_x; v_theta; a_x; a_theta];
end