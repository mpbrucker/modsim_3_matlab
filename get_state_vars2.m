function  [X,theta] = get_state_vars2(M,m,l,u,b,I)
g = 9.81; % m/s^2

p = I*(M+m)+M*m*l^2; % Denominator for the A and B matrices

A = [0  1   0   0;
    0   -(I+m*l^2)*b/p  (m^2*g*l^2)/p   0;
    0   0   0   1;
    0   -(m*l*b)/p  m*g*l*(M+m)/p   0];

B = [0;
     (I+m*l^2)/p;
     0;
     m*l/p];
 
C = [0 1 0 0;
    0 0 0 1];

D = [0;
    0];

states = {'x' 'x_dot' 'phi' 'phi_dot'};
inputs = {'u'};
outputs = {'x_dot' 'phi_dot'};

sys_ss = ss(A,B,C,D,'statename',states,'inputname',inputs,'outputname',outputs);


end