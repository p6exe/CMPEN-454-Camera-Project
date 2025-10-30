function Kc=adjust_K_for_crop(K,rect)
    dx = rect(1) - 1;
    dy = rect(2) - 1;
    Kc = K;
    Kc(1,3) = K(1,3) - dx;   % shift principal point x
    Kc(2,3) = K(2,3) - dy;   % shift principal point y
end
