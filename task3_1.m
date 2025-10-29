
%% Task 3.1: Understanding pinhole camera model parameters
fprintf('--- Task 3.1 ---\n');
cam1= load('data/Parameters_V1_1.mat');
cam2= load('data/Parameters_V2_1.mat');

% Intrinsics
K1 = cam1.Parameters.Kmat;
K2 = cam2.Parameters.Kmat;

% Rotations
R1 = cam1.Parameters.Rmat;
R2 = cam2.Parameters.Rmat;

% Camera Centers
C1 = cam1.Parameters.position;
C2 = cam2.Parameters.position;

% Projection
P1 = cam1.Parameters.Pmat;
P2 = cam2.Parameters.Pmat;

t1 = -R1*C1';  
t2 = -R2*C2';

fprintf('Camera 1 intrinsics K:\n'); disp(K1);
fprintf('Camera 1 rotation R:\n');  disp(R1);
fprintf('Camera 1 center C (world):\n'); disp(C1);
fprintf('Camera 1 projection P = K[R|-RC]:\n'); disp(P1);
fprintf('Camera 1 translation vector t = -RC'); disp(t1)

fprintf('Camera 2 intrinsics K:\n'); disp(K2);
fprintf('Camera 2 rotation R:\n');  disp(R2);
fprintf('Camera 2 center C (world):\n'); disp(C2);
fprintf('Camera 2 projection P = K[R|-RC]:\n'); disp(P2);
fprintf('Camera 2 translation vector t = -RC'); disp(t2)

% Verify P decomposition numerically
% They're all part of the verification step where we check that the projection matrix 𝑃=𝐾[𝑅∣−𝑅𝐶]P=K[R∣−RC] really matches the stored camera parameters.

fprintf('\nCamera 1 Verification\n');
Rt1 = K1\P1; 
R1v = Rt1(:,1:3); 
t1v = Rt1(:,4);
C1v = (-R1v\t1v)';%get the location of the camera 1
fprintf('(R1 - R1v):\n'); disp(R1-R1v); %verify rotation camera 1
fprintf('(C1 - C1v):\n'); disp(C1-C1v); %verify location camera 1

fprintf('\nCamera 2 Verification\n');
Rt2 = K2\P2; 
R2v = Rt2(:,1:3); 
t2v = Rt2(:,4); 
C2v = (-R2v\t2v)'; %get the location of the camera 2
fprintf('(R2 - R2v):\n'); disp(R2-R2v); %verify rotation camera 2
fprintf('(C2 - C2v):\n'); disp(C2-C2v); %verify location camera 2

save('data\camera_params.mat','K1','R1','C1','t1','P1','K2','R2','C2','P2','t2');