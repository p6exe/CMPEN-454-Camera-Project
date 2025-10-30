%% Task 3.5: Fundamental matrix from calibration
fprintf('--- Task 3.5 ---\n');
addpath('helpers');

cam_params = load('data/camera_params.mat');

Image1 = imread('data/im1corrected.jpg'); 
Image2 = imread('data/im2corrected.jpg');

% Visual check with some points (use projected mocap pts from task 3.2)
data = load('data\2d_points.mat');
xy1 = data.xy1;
xy2 = data.xy2;

[F, pts1, pts2] = eightpoint(Image1, Image2, xy1, xy2);
disp(F)
save('data/Fundamental.mat','F','pts1','pts2');