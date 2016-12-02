function animate_data()
    clf;
    w = 1; % 1/2 Width of cart (m)
    h = .2; % 1/2 Height of cart (m)
    
    w_p = .05; % 1/2 width of pendulum (m)
    h_p = .6; % height of pendulum (m)
    
    
    [t,out] = run_pendulum(0,20, h_p,w_p,.001);
    display(t(end));
    x_vals = out(:,1);
    thetas = out(:,2)-pi/2; % Gets the out angles as standardized angles
    
    
    x_center = 0; % X center of the cart
    y_center = .2; % Y center of the cart
    x = [x_center-w x_center+w x_center+w x_center-w]; % X points for the cart
    y = [y_center+h y_center+h y_center-h y_center-h];  % Y points for the cart
    
    % X and Y values of rotation point
    xp_center = x_center;
    yp_center = y_center + h + w_p;
%     x_p = [xp_center - w_p, xp_center - w_p, xp_center + w_p, xp_center + w_p];
%     y_p = [yp_center, yp_center + h_p, yp_center + h_p, yp_center];
    x_p = [xp_center xp_center];
    y_p = [yp_center yp_center + h_p];
    
    hold on;
    cart = fill(x,y,'r');
    pendulum = fill(x_p,y_p,'b','LineWidth',0.01);
    hold off;
    min_max = [min(x_vals)-w,max(x_vals)+w,0,6];
    axis(min_max);

    % Iterate across the time interval, animating the shapes
    for j = 1:length(t)-1
          x_center = x_vals(j);
          % Calculate new vertices for this frame
          x = [x_center-w x_center+w x_center+w x_center-w];
          y = [y_center+h y_center+h y_center-h y_center-h];
          new_vertices = transpose(vertcat(x,y));
          cart.Vertices = new_vertices;
          
          % Calculate the new pendulum vertex values
          theta = thetas(j);
          xp_center = x_center;
          x_p = [xp_center xp_center+h_p*cos(theta)];
          y_p = [yp_center yp_center+h_p*sin(theta)];
%           x_p = [xp_center-w*cos(theta),xp_center+h_p*cos(theta)-w*cos(theta), ...
%               xp_center+h_p*cos(theta)+w*cos(theta),xp_center+w*cos(theta)];
%           y_p = [yp_center+w*sin(theta),yp_center+h_p*sin(theta)+w*sin(theta), ...
%               yp_center+h_p*sin(theta)-w*sin(theta),yp_center-w*sin(theta)];
          new_pen_vertices = transpose(vertcat(x_p,y_p));
          pendulum.Vertices = new_pen_vertices;
          drawnow limitrate
          pause(t(j+1)-t(j));
    end
    
end
    