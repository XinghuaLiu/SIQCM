function OTF = OTFgenerate(size,kcutoff,k0)
% generate OTF function with given cutoff frequency and k vector shift
		%OTF = exp(-0.44*k/kcutoff);
		%size of the OTF supposed to generate.
		%Kcutoff cutoff frequency of the OTF, where 
		%k0 shift vector of the center component 

    w = size;
    wo = w /2;
    x = linspace(0,w-1,w);
    y = linspace(0,w-1,w);
    [X,Y] = meshgrid(x,y);
    k = sqrt((X-wo-k0(2)).^2+(Y-wo-k0(1)).^2);
    %ko = k./kcutoff;
    %OTF = 2/pi*(acos(k./kcutoff)-k./kcutoff*sqrt(1-(k./kcutoff).^2));
    OTF = exp(-4.4*(k./kcutoff).^2);
    OTF(OTF<0.001)=0;
end