
function X = triangulate_from_rays(C1,u1,C2,u2)
% TRIANGULATE_FROM_RAYS  Closest point to two skew lines: L1=C1+s*u1, L2=C2+t*u2
% Accepts C1,C2 3xN and u1,u2 3xN (unit). Returns Nx3 world points.
    n = size(u1,2);
    X = zeros(n,3);
    for i=1:n
        a = u1(:,i); b = u2(:,i); c = C2(:,i)-C1(:,i);
        A = [dot(a,a), -dot(a,b); -dot(a,b), dot(b,b)];
        rhs = [dot(a,c); -dot(b,c)];
        st = A\rhs;
        p1 = C1(:,i) + st(1)*a;
        p2 = C2(:,i) + st(2)*b;
        X(i,:) = ((p1+p2)/2)';
    end
end
