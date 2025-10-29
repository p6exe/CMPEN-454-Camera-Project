
function [x1,x2] = image_point_input(Image1,Image2,n)
    % Ask user to click n matching points in two images.
    % Returns x1,x2 Nx2.
    figure; imshow(Image1); title(sprintf('Click %d points in IMAGE 1',n));
    [x1,y1] = ginput(n); close;
    figure; imshow(Image2); title(sprintf('Click the same %d points in IMAGE 2, in order',n));
    [x2,y2] = ginput(n); close;
    x1 = [x1,y1]; x2 = [x2,y2];
end
