% This script runs heliometric stereo reconstructions on simulated sphere
% data for 2 different sizes of sphere.
%
% The script may be used as is to create figures for the paper. The
% reconstruction requires access to code not publically available. For more
% information about the code `run_hs_datafromfile` that performs the 
% reconstruction contact Sam Lambrick (sml59@cantab.ac.uk).
addpath('datafiles')

clc;clear;close all;

if false
    % Sphere A
    [Axx, Ayy, AZ] = run_hs_datafromfile('dataPath', '0024_sphere_A_final_final_simulation', ...
        'OutputPath', 'simulated_reconstruction', ...
        'rotations_present', false, ...
        'reconstruction_method', 'Dirichlet', ...
        'is_scripted', true);
    
    % Sphere B
    [Bxx, Byy, BZ] = run_hs_datafromfile('dataPath', '0025_sphere_B_final_final_simulation', ...
        'OutputPath', 'simulated_reconstruction', ...
        'rotations_present', false, ...
        'reconstruction_method', 'Dirichlet', ...
        'is_scripted', true);
else
    load('simulated_reconstructions.mat')
end

[Axx2, Ayy2, AZ2] = rotate_surface(Axx, Ayy, AZ, 4.3);
Axx2 = Axx2/cosd(30);
standard_surf(Axx2, Ayy2, AZ2);
AZ3 = embedded_sphere(Axx2, Ayy2, 1, 0.72);
standard_surf(Axx2, Ayy2, AZ3);
Aheight = 2 - 1.28;
Apercent_error = 100*(AZ2 - AZ3)/Aheight;

[Bxx2, Byy2, BZ2] = rotate_surface(Bxx, Byy, BZ, 3.6);
Bxx2 = Bxx2/cosd(30);
standard_surf(Bxx2, Byy2, BZ2);
BZ3 = embedded_sphere(Bxx2, Byy2, 1, 1.04);
standard_surf(Bxx2, Byy2, BZ3);
Bheight = 2 - 0.96;
Bpercent_error = 100*(BZ2 - BZ3)/Bheight;

if false
    save('simulated_reconstructions.mat')
end



%% Plot of the percentage errors
figure;

% Subplot 1
f1 = figure();
ax1 = axes(f1);%subplot(2, 2, 1);
imagesc(Axx2(1,:), Ayy2(:,1), Apercent_error, 'Parent', ax1);
colormap(ax1, 'parula') 
colorbar(ax1, 'Ticks', [-50, -25, 0, 25, 50])
axis equal
xlim(ax1, [-1.5, 1.5])
ylim(ax1, [-1.5, 1.5])
set(ax1, 'Visible', 'off');
clim(ax1, [-50, 50])
fontsize(f1, 9,"points")


% Subplot 2
f2 = figure();
ax2 = axes(f2);%ax2 = subplot(2, 2, 2);
imagesc(Bxx2(1,:), Byy2(:,1), Bpercent_error, 'Parent', ax2);
colormap(ax2, 'parula')
colorbar(ax2, 'Ticks', [-50, -25, 0, 25, 50])
colorbar(ax2)
axis equal
xlim(ax2, [-1.5, 1.5])
ylim(ax2, [-1.5, 1.5])
set(ax2, 'Visible', 'off');
clim(ax2, [-50, 50])
fontsize(f2, 9,"points")

% Subplot 3
f3 = figure();
ax3 = axes(f3);%ax3 = subplot(2, 2, 3);
surfl(ax3, Axx2, Ayy2, AZ2)
xlabel(ax3, 'x/mm')
ylabel(ax3, 'y/mm')
zlabel(ax3, 'z/mm')
axis equal
zlim(ax3, [-0.1, 1])
xlim(ax3, [-1.5, 1.5])
ylim(ax3, [-1.5, 1.5])
colormap(ax3, pink)
view(ax3, 60, 20)
shading(ax3, 'interp')
fontsize(f3, 9,"points")


% Subplot 4
f4 = figure();
ax4 = axes(f4);%ax4 = subplot(2, 2, 4);
surfl(ax4, Bxx2, Byy2, BZ2)
xlabel(ax4, 'x/mm')
ylabel(ax4, 'y/mm')
zlabel(ax4, 'z/mm')
axis equal
zlim(ax4, [-0.1, 1])
xlim(ax4, [-1.5, 1.5])
ylim(ax4, [-1.5, 1.5])
colormap(ax4, pink)
view(ax4, 60, 20)
shading(ax4, 'interp')
fontsize(f4, 9,"points")


disp(sqrt(mean(Apercent_error(:).^2)))
disp(sqrt(mean(Bpercent_error(:).^2)))
print(gcf, 'simulated_reconstruction.png', '-dpng', '-r300');
