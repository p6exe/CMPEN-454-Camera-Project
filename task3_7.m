%% Task 3.7: Quantitative evaluation of your estimated F matrices
fprintf('--- Task 3.7 ---\n');

addpath('helpers');
addpath('data');


%load in Fundamental matrices
t_3_5 = load('data/Fundamental.mat');
t_3_6 = load('data/F_matrix_3_6.mat');

F1 = t_3_5.F;
F2 = t_3_6.F;

%loading in point matches
point_matches = load('data/2d_points.mat');

x1 = point_matches.x1; 
y1 = point_matches.y1; 
x2 = point_matches.x2; 
y2 = point_matches.y2;

N = size(x1,1);

%converting to homogeneous points
pts1 = [x1(:)'; y1(:)'; ones(1,numMatches)];
pts2 = [x2(:)'; y2(:)'; ones(1,numMatches)];

% --- evaluate for F1 ---
sumSquared = 0;
for i = 1:numMatches
    x1_h = pts1(:,i);
    x2_h = pts2(:,i);

    %epipolar line in image2 for point in image1
    l2 = F1 * x1_h;
    d2 = abs(x2_h' * l2) / sqrt(l2(1)^2 + l2(2)^2);

    %epipolar line in image1 for point in image2
    l1 = F1' * x2_h;
    d1 = abs(x1_h' * l1) / sqrt(l1(1)^2 + l1(2)^2);

    sumSquared = sumSquared + (d1^2 + d2^2);
end
meanSED1 = sumSquared / numMatches;
fprintf('Mean symmetric epipolar distance for F1 = %f\n', meanSED1);

% --- evaluate for F2 ---
sumSquared = 0;
for i = 1:numMatches
    x1_h = pts1(:,i);
    x2_h = pts2(:,i);

    l2 = F2 * x1_h;
    d2 = abs(x2_h' * l2) / sqrt(l2(1)^2 + l2(2)^2);

    l1 = F2' * x2_h;
    d1 = abs(x1_h' * l1) / sqrt(l1(1)^2 + l1(2)^2);

    sumSquared = sumSquared + (d1^2 + d2^2);
end
meanSED2 = sumSquared / numMatches;
fprintf('Mean symmetric epipolar distance for F2 = %f\n', meanSED2);