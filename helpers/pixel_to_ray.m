
function [C, u] = pixel_to_ray(xy, cam)
% PIXEL_TO_RAY  Converts pixel(s) (Nx2) to camera center C and unit ray u in world coords.
% Converts pixel(s) (Nx2) to camera center C and unit ray u in world coords.
    xy = [xy, ones(size(xy,1),1)];        % Nx3 homogeneous
    Kinv = inv(cam.K);                    % Inverse K
    dirs_c = (Kinv * xy') ;               % 3xN in camera coords
    dirs_w = cam.R' * dirs_c;             % 3xN in world coords (since Xc = R(Xw-C))
    u = dirs_w ./ vecnorm(dirs_w);        % unit vectors, 3xN
    C = repmat(cam.C,1,size(xy,1));       % 3xN
    disp(C)
end
