function animate_data(t,state_vars)
    clf;
    w = 1;
    h = .2;
    
    
    
    x_center = 0;
    y_center = .2;
    x = [x_center-w x_center+w x_center+w x_center-w];
    y = [y_center+h y_center+h y_center-h y_center-h];
    hold on;
    cart = fill(x,y,'r');
    hold off;
    axis([-3 3 0 6]);

    for j = 1:length(t)
          x_center = state_vars(j);
          x = [x_center-w x_center+w x_center+w x_center-w];
          y = [y_center+h y_center+h y_center-h y_center-h];
          new_vertices = transpose(vertcat(x,y));
          cart.Vertices = new_vertices;
          drawnow 
    end
    
end
    