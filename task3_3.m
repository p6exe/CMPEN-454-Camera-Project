
%% Task 3.3: Triangulation from two views; compare to ground truth
fprintf('--- Task 3.3 ---\n');
addpath('helpers');

cam_params = load("data/camera_params.mat")
Param1= struct('K',cam_params.K1,'R',cam_params.R1,'C',cam_params.C1','P',cam_params.P1);
Param2= struct('K',cam_params.K2,'R',cam_params.R2,'C',cam_params.C2','P',cam_params.P2);
data = load('data\2d_points.mat');

xy1 = data.xy1
xy2 = data.xy2
X = data.X

% Rays
[C1,u1] = pixel_to_ray(xy1, Param1);
[C2,u2] = pixel_to_ray(xy2, Param2);

% Triangulate each pair
Xrec = triangulate_from_rays(C1,u1,C2,u2); % Nx3
disp((Xrec - X))
mse = mean(sum((Xrec - X).^2,2));
rmse = sqrt(mse);
fprintf('Reconstruction RMSE (mm): %.4f\n', rmse);
disp(rmse)


% Simple visualization in 3D
figure; plot3(X(:,1),X(:,2),X(:,3),'k.'); hold on; 
plot3(Xrec(:,1),Xrec(:,2),Xrec(:,3),'ro');
grid on; axis equal;
title('Task 3.3: Triangluated 3D points');
saveas(gcf, 'outputs/t3_3_3d_compare.png');
