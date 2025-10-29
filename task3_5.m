%% Task 3.5: Fundamental matrix from calibration
fprintf('--- Task 3.5 ---\n');
addpath('helpers');

cam_params = load('data/camera_params.mat');
Image1 = imread('data/im1corrected.jpg'); 
Image2 = imread('data/im2corrected.jpg');

t_rel = cam_params.R2 * (cam_params.C1 - cam_params.C2)';     % translation of cam2 in cam1's coordinates
R_rel = cam_params.R2 * cam_params.R1';           % rotation from camera1 frame to camera2 frame

fprintf('Relative translation t_rel (camera 2 wrt camera 1):\n');
disp(t_rel');
fprintf('Relative rotation R_rel (camera 2 wrt camera 1):\n');
disp(R_rel);

%% Step 2: Compute Essential matrix
tx = [0 -t_rel(3) t_rel(2);
      t_rel(3) 0 -t_rel(1);
      -t_rel(2) t_rel(1) 0];
E = tx * R_rel;

fprintf('Essential Matrix E:\n');
disp(E);

%% Step 3: Compute Fundamental Matrix
K1 = cam1.K;
K2 = cam2.K;
F = inv(K2') * E * inv(K1);

fprintf('Fundamental Matrix F:\n');
disp(F);

% Visual check with some points (use projected mocap pts from task 3.2)
data = load('data\2d_points.mat');
xy1 = data.xy1;
xy2 = data.xy2;

x2 = xy2(:,1);
y2 = xy2(:,2);
x1 = xy1(:,1);
y1 = xy1(:,2);

colors =  'bgrcmykbgrcmykbgrcmykbgrcmykbgrcmykbgrcmykbgrcmyk';
%overlay epipolar lines on im2
L = F * [x1' ; y1'; ones(size(x1'))];
[nr,nc,nb] = size(Image2);
figure(2); clf; imagesc(Image2); axis image;
hold on; plot(x2,y2,'*'); hold off
for i=1:length(L)
    a = L(1,i); b = L(2,i); c=L(3,i);
    if (abs(a) > (abs(b)))
       ylo=0; yhi=nr; 
       xlo = (-b * ylo - c) / a;
       xhi = (-b * yhi - c) / a;
       hold on
       h=plot([xlo; xhi],[ylo; yhi]);
       set(h,'Color',colors(i),'LineWidth',2);
       hold off
       drawnow;
    else
       xlo=0; xhi=nc; 
       ylo = (-a * xlo - c) / b;
       yhi = (-a * xhi - c) / b;
       hold on
       h=plot([xlo; xhi],[ylo; yhi],'b');
       set(h,'Color',colors(i),'LineWidth',2);
       hold off
       drawnow;
    end
end
saveas(gcf, 'outputs/t3_5_epi_cam_2.png')

%overlay epipolar lines on im1
L = ([x2' ; y2'; ones(size(x2'))]' * F)' ;
[nr,nc,nb] = size(Image1);
figure(1); clf; imagesc(Image1); axis image;
hold on; plot(x1,y1,'*'); hold off
for i=1:length(L)
    a = L(1,i); b = L(2,i); c=L(3,i);
    if (abs(a) > (abs(b)))
       ylo=0; yhi=nr; 
       xlo = (-b * ylo - c) / a;
       xhi = (-b * yhi - c) / a;
       hold on
       h=plot([xlo; xhi],[ylo; yhi],'b');
       set(h,'Color',colors(i),'LineWidth',2);
       hold off
       drawnow;
    else
       xlo=0; xhi=nc; 
       ylo = (-a * xlo - c) / b;
       yhi = (-a * xhi - c) / b;
       hold on
       h=plot([xlo; xhi],[ylo; yhi],'b');
       set(h,'Color',colors(i),'LineWidth',2);
       hold off
       drawnow;
    end
end
saveas(gcf, 'outputs/t3_5_epi_cam_1.png')

save('data/Fundamental.mat','F','E','R_rel','t_rel');