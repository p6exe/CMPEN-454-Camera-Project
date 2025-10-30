
%% Task 3.2: Project 3D mocap points into both images
fprintf('--- Task 3.2 ---\n');

% Load
mocap = load('data/mocapPoints3D.mat');
X = mocap.pts3D;  % Nx3
X = double(X); if size(X,2)~=3, X = X'; end

cam_params = load("data/camera_params.mat")

Image1 = imread('data/im1corrected.jpg'); 
Image2 = imread('data/im2corrected.jpg');

% Project
XC = (cam_params.R1 * (X' - cam_params.C1')); % 3xN
XP = cam_params.K1 * XC;              % 3xN
xy = (XP(1:2,:) ./ XP(3,:))'; % Nx2
mask = XP(3,:)>0; % in front of camera
xy1 = xy(mask',:);

XC = (cam_params.R2 * (X' - cam_params.C2')); % 3xN
XP = cam_params.K2 * XC;              % 3xN
xy = (XP(1:2,:) ./ XP(3,:))'; % Nx2
mask = XP(3,:)>0; % in front of camera
xy2 = xy(mask',:);

% Visualize
figure; imshow(Image1); hold on; plot(xy1(:,1),xy1(:,2),'r.','MarkerSize',12);
title('Task 3.2: Projected mocap points (View 1)'); hold off;
saveas(gcf, 'outputs/t3_2_proj_view1.png');
figure; imshow(Image2); hold on; plot(xy2(:,1),xy2(:,2),'r.','MarkerSize',12);
title('Task 3.2: Projected mocap points (View 2)'); hold off;
saveas(gcf, 'outputs//t3_2_proj_view2.png');

% Save data for later tasks
save('data\2d_points.mat', 'xy1','xy2','X');
