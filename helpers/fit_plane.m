
function [n, d, plane] = fit_plane(X)
    % ax+by+cz+d=0 through Nx3 points.
    % Returns unit normal n (3x1), scalar d, and struct with fields a,b,c,d.
    N = size(X,1);
    A = [X, ones(N,1)];
    [~,~,V] = svd(A,0);
    v = V(:,end); 
    a=v(1); b=v(2); c=v(3); d=v(4);
    n = [a;b;c]; 
    ln = norm(n);
    n = n/ln; 
    d = d/ln;
    plane = struct('a',n(1),'b',n(2),'c',n(3),'d',d);
end
