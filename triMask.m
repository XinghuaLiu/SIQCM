function H = triMask(size,kmax,k0,kshift)
    t = size;
    to = t/2;
    u = linspace(0,t-1,t);
    v = linspace(0,t-1,t);
    [U,V] = meshgrid(u,v);    
    H = (1-(sqrt((U-to-kshift(2)).^2+(V-to-kshift(1)).^2)./(1.3*kmax+2*k0)));
    z = (H>0);
    H = H.*z;
end