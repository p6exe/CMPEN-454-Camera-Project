%% Project 2: Extra Credit #2
%read source image
source = imread('bldg2.jpg');
%source = imread('bldg4.jpg');
%source = imread('bldg3.jpg');
[nr, nc, nb] = size(source);

%show the image and user clicks four floor-plane points but automatically
%calculate rectangle later instead of user
figure; imshow(source); axis image;
title('Click four corners on the floor plane (in a rectangle order)');
[xpts, ypts] = ginput(4);
imagePoints = [xpts(:), ypts(:)];

%defining corresponding world-plane (X,Y) coordinates (Z=0).  
%assuming the floor corners form a rectangle of size W by H
W = 4.0;
H = 3.0;

%defining world points in a matching order of the clicks above
worldPoints = [  0, 0;
                 W, 0;
                 W, H;
                 0, H ];

%computing a projective/similarity transform
tform = fitgeotform2d(imagePoints, worldPoints, "projective");

%defining output view so that output image resolution equals input
outputView = imref2d([nr, nc], [0 W], [0 H]);

%warp image
topDown = imwarp(source, tform, 'OutputView', outputView);

%display results
figure;
subplot(1,2,1); imshow(source); title('Original image');
subplot(1,2,2); imshow(topDown); title('Top-down (floor plane) view');

imwrite(topDown, 'floor_topdown_extra_credit.jpg');

