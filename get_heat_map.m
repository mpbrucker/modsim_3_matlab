function res = get_heat_map()
clf;
initial_time  = 0;
final_time = 20;
length_p = 3; % m
width = .3; % m

k_p_range = 100:1000:10000;
k_i_range = 100:1000:5000;
k_d = 2000;

matrix = zeros(length(k_p_range),length(k_i_range));

for i = 1:length(k_p_range)
    for j =  1:length(k_i_range)
        [t,res,failState,forces] = run_pendulum(initial_time,  ...
            final_time, length_p, width, 80.7, .01, k_p_range(i),k_i_range(j),k_d);
        if (failState == 0)
            impulse = force_profile(t,forces);
        else
            impulse = 400;
        end
        matrix(i,j) = impulse;
    end
end

red = [255 0 0]/255;

[M,I] = min(matrix(:));
display(I);
[I_1,I_2] = ind2sub(size(matrix),I);

display(k_p_range(I_1));
display(k_i_range(I_2));

cmap = colormap;
cmap(1,:) = red;
colormap(cmap);

pcolor(k_i_range,k_p_range,matrix);
shading flat
color = colorbar('Ticks',[400],'TickLabels',{'Failure'});
color.Label.String = 'Total force (N s)';
xlabel('k_i constant value');
ylabel('k_p conatant value');
end