%% Task 3.7: Quantitative SED for both F matrices
fprintf('--- Task 3.7 ---\n');
addpath('helpers');
%load in Fundamental matrices
t_3_5 = load('data/Fundamental.mat');
t_3_6 = load('data/F_matrix_3_6.mat');

F1 = t_3_5.F;
F2 = t_3_6.F;

%loading in point matches
data = load('data/2d_points.mat');
xy1 = data.xy1;
xy2 = data.xy2;

x1 = xy1(:,1);
y1 = xy1(:,2);
x2 = xy2(:,1);
y2 = xy2(:,2);

e_cal = sed_error(F1, xy1, xy2);
e_8pt = sed_error(F2,  xy1, xy2);
fprintf('SED (mean squared pixels) for F_calib: %.4f\n', e_cal);
fprintf('SED (mean squared pixels) for F_8point: %.4f\n', e_8pt); %sqrt(2129) = 49 pixels, That means on average, each matched point is about 46 pixels away from where it should be on its epipolar line.

better = 'calibration'; if e_8pt < e_cal, better='8-point'; end
fprintf('Smaller SED: %s\n', better);
save('data/t3_7_sed.mat','e_cal','e_8pt');
