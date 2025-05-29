% For sphere A
load("datafiles/albedo_sphereA.mat")
figure
imagesc(fliplr(flipud(rho)))
colormap default
axis off
axis equal
colorbar
clim([0.5, 1])
saveas(gcf,'sphereA_albedo.pdf')

% For sphere B
load("datafiles/albedo_sphereB.mat")
figure
imagesc(fliplr(flipud(rho)))
colormap default
axis off
axis equal
colorbar
clim([0.5, 1])
saveas(gcf,'sphereB_albedo.pdf')
