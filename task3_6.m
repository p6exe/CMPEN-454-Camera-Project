%% Task 3.6: Fundamental matrix using the eight-point algorithm
fprintf('--- Task 3.6 ---\n');
addpath('helpers');
addpath('data');

%load in images
im = imread('im1corrected.jpg');
im2 = imread('im2corrected.jpg');

%user inputs the points for 8point algo
[z1, z2] = image_point_input(im, im2, 8);

%run 8point algo
F = eightpoint(im,im2,z1,z2);

save('data/F_matrix_3_6.mat','F');