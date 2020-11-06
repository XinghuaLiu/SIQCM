function [Fsum,Fsum2,Fperi,Fcent] = WienerFSIM(f,k,kcutoff,gamma)
    n = 5;
    Fcent =zeros(size(f,1),size(f,2));
    for i = 1 : n
        Fcent =Fcent+ f(:,:,(i-1)*3+1);
    end
    Fcent = Fcent ./ n;
   %% double freq component size
    w = size(f,1);
    t = 2*w;
    wo = w/2;
    Fsum = zeros(t,t);
    Fperi = zeros(t,t);
    Dsum = zeros(t,t); 
    Dperi = zeros(t,t);
    to = t/2;
    u = linspace(0,t-1,t);
    v = linspace(0,t-1,t);
    [U,V] = meshgrid(u,v);
	fTemp = zeros(2*w,2*w,n^2);
    Ro = sqrt( (U-w).^2 + (V-w).^2 );
 	for i = 1 : n*3 
		fTemp(wo+1:w+wo,wo+1:w+wo,i) = f(:,:,i);
	end
    fdouble = fTemp;
    c = [0.2 0.5 0.5];
    kshift = [0 1 -1];
    k_mag = [1 1 1];
    for i = 1 : n
        for j = 1 : 3
            TempMask = Ro<(kcutoff*k_mag(j)*1.05);
            fdouble(:,:,(i-1)*3+j) = fdouble(:,:,(i-1)*3+j).*TempMask;
        end
    end
  %  shift every component to corrected position 
    for i = 1 : n
       for j = 1 : 3
%            if(isequal(i,1))
%                add = 1;
%            else 
%                add = -1;
%            end
           temp = c(j)*fft2(ifft2(fdouble(:,:,(i-1)*3+j)).*...
               exp( kshift(j)*1i.*2.*pi.*((k(i,2)/t.*(U-to) + k(i,1)/t.*(V-to)))));
           tempD = OTFgenerate(w*2,kcutoff*k_mag(j));
           tempD = circshift(tempD,round(k(i,:).*kshift(j)));
           Dsum = Dsum+ c(j)*tempD;
           Fsum = Fsum + temp;
%            figure();
%            imshow(log(abs(temp)),[]);
%            title((i-1)*3+j);
           if(~isequal(j,1))
               Fperi = Fperi+temp;
               Dperi = Dperi+c(j)*tempD;
           end
       end
    end
    Dsum = Dsum + gamma;
    Dperi = Dperi + gamma;
    H = triMask(t,kcutoff/2,60);
    Fsum2 = Fsum./Dsum;
    Fsum = Fsum./Dsum.*H;
    Fperi = Fperi./Dperi.*H;
   
end