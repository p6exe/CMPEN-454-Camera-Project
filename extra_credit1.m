fprintf('--- Extra Credit 1: Cropped views ---\n'); 
addpath('helpers'); 
cam_params = load('data/camera_params.mat');
cam1= struct('K',cam_params.K1,'R',cam_params.R1,'C',cam_params.C1','P',cam_params.P1);
cam2= struct('K',cam_params.K2,'R',cam_params.R2,'C',cam_params.C2','P',cam_params.P2);
Image1 = imread('data/im1corrected.jpg'); 
Image2 = imread('data/im2corrected.jpg');

rect1=[450 300 300 500]; 
rect2=[850 300 400 500]; 
Image1c=imcrop(Image1,rect1); 
Image2c=imcrop(Image2,rect2); 
K1c=adjust_K_for_crop(cam_params.K1,rect1); 
K2c=adjust_K_for_crop(cam_params.K2,rect2); 
 
mocap = load('data/mocapPoints3D.mat');
X = mocap.pts3D;

cam1c=cam1; 
cam1c.K=K1c; 
cam2c=cam2; 
cam2c.K=K2c;

% Project
XC = (cam1c.R * (X' - cam1c.C')'); % 3xN
XP = cam1c.K * XC;              % 3xN
xy = (XP(1:2,:) ./ XP(3,:))'; % Nx2
mask = XP(3,:)>0; % in front of camera
xy1 = xy(mask',:);

XC = (cam2c.R * (X' - cam2c.C')'); % 3xN
XP = cam2c.K * XC;              % 3xN
xy = (XP(1:2,:) ./ XP(3,:))'; % Nx2
mask = XP(3,:)>0; % in front of camera
xy2 = xy(mask',:);

figure; imshow(Image1c); hold on; 
plot(xy1(:,1),xy1(:,2),'r.'); 
title('Projection on cropped Image 1'); 
saveas(gcf, 'Results for Extra Credit 1/ec1_proj_cropped_1.png');

figure; imshow(Image2c); hold on; 
plot(xy2(:,1),xy2(:,2),'r.'); 
title('Projection on cropped Image 2'); 
saveas(gcf, 'Results for Extra Credit 1/ec1_proj_cropped_2.png');

F = eightpoint(Image1c,Image2c,xy1,xy2);
%save(fullfile(outDir,'extra_credit1_results.mat'),'rect1','rect2','K1c','K2c','Fc','Ec','Rrel','trel');
