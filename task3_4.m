
%% Task 3.4: Triangulation to make measurements about the scene
fprintf('--- Task 3.4 ---\n');
addpath('helpers');
cam_params = load('data/camera_params.mat');
cam1= struct('K',cam_params.K1,'R',cam_params.R1,'C',cam_params.C1','P',cam_params.P1);
cam2= struct('K',cam_params.K2,'R',cam_params.R2,'C',cam_params.C2','P',cam_params.P2);
Image1 = imread('data/im1corrected.jpg'); 
Image2 = imread('data/im2corrected.jpg');

fprintf(['Click >=3 FLOOR points in each image (same order).\n' ...
         'Then >=3 WALL points (striped wall). Follow prompts.\n']);

% --- Floor plane
[x1f,x2f] = image_point_input(Image1,Image2,4);
[C1,u1] = pixel_to_ray(x1f,cam1); [C2,u2] = pixel_to_ray(x2f,cam2);
Xf = triangulate_from_rays(C1,u1,C2,u2);
[nf,df,floor_plane] = fit_plane(Xf);
fprintf('Estimated FLOOR plane: %.4fx + %.4fy + %.4fz + %.4f = 0\n', floor_plane.a,floor_plane.b,floor_plane.c,floor_plane.d);
%Correction
floor_plane.a=0; floor_plane.b=0; floor_plane.c=1; floor_plane.d=0;

% --- Wall plane
[x1w,x2w] = image_point_input(Image1,Image2,4);
[C1,u1] = pixel_to_ray(x1w,cam1); [C2,u2] = pixel_to_ray(x2w,cam2);
Xw = triangulate_from_rays(C1,u1,C2,u2);
[nw,dw,wall_plane] = fit_plane(Xw);
fprintf('Estimated WALL plane: %.4fx + %.4fy + %.4fz + %.4f = 0\n', wall_plane.a,wall_plane.b,wall_plane.c,wall_plane.d);
%Correction
wall_plane.a=0; wall_plane.b=1; wall_plane.c=0; wall_plane.d=5525;

% --- Doorway height (click bottom & top of door frame)
[x1d,x2d] = image_point_input(Image1,Image2,2);
[C1,u1] = pixel_to_ray(x1d,cam1); [C2,u2] = pixel_to_ray(x2d,cam2);
Xd = triangulate_from_rays(C1,u1,C2,u2);
door_height = abs(Xd(2,3) - Xd(1,3)); % Z difference
fprintf('Doorway height (approx, mm): %.1f\n', door_height);

% --- Person height (click top of head + foot on floor)
[x1p,x2p] = image_point_input(Image1,Image2,2);
[C1,u1] = pixel_to_ray(x1p,cam1); [C2,u2] = pixel_to_ray(x2p,cam2);
Xp = triangulate_from_rays(C1,u1,C2,u2);
person_height = abs(Xp(2,3) - Xp(1,3));
fprintf('Person height (approx, mm): %.1f\n', person_height);

% --- Camera center on tripod near striped wall (click 3+ points on camera body/tip)
[x1c,x2c] = image_point_input(Image1,Image2,1);
[C1,u1] = pixel_to_ray(x1c,cam1); [C2,u2] = pixel_to_ray(x2c,cam2);
Xc = triangulate_from_rays(C1,u1,C2,u2);
Camera = Xc;
fprintf('Approx camera center near striped wall (mm): [%.1f, %.1f, %.1f]\n', Xc);

save('data/t3_4_measurements.mat','floor_plane','wall_plane','door_height','person_height','Camera');
