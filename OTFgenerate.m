function OTF = OTFgenerate(size,kcutoff,k0)
    w = size;
    wo = w /2;
    x = linspace(0,w-1,w);
    y = linspace(0,w-1,w);
    [X,Y] = meshgrid(x,y);
    k = sqrt((X-wo-k0(2)).^2+(Y-wo-k0(1)).^2);
    %ko = k./kcutoff;
    %OTF = 2/pi*(acos(k./kcutoff)-k./kcutoff*sqrt(1-(k./kcutoff).^2));
    OTF = exp(-4.4*(k./kcutoff).^2);
    OTF(OTF<0.02)=0;
end