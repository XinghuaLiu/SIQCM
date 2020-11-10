function [Fsum,Fsum2,Fperi,Fcent] = WienerF2(f,k,kcutoff,gamma)
    n = ceil(size(f,3)^0.5);
    Fcent =zeros(size(f,1),size(f,2));
    for i = 1 : n
        Fcent =Fcent+ f(:,:,(i-1)*n+1);
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
 	for i = 1 : n^2 
		fTemp(wo+1:w+wo,wo+1:w+wo,i) = f(:,:,i);
	end
    fdouble = fTemp;
    c = [0.375 0.25 0.25 0.0625 0.0625];
    kshift = [0 1 -1 2 -2];
   % k_mag = [sqrt(2) sqrt(2) sqrt(2) sqrt(2) sqrt(2)];
%     for i = 1 : n
%         for j = 1 : n
%             TempMask = Ro<(kcutoff*k_mag(j)*1.05);
%             fdouble(:,:,(i-1)*n+j) = fdouble(:,:,(i-1)*n+j).*TempMask;
%         end
%     end
  %  shift every component to corrected position 
%     for i = 1 : n
%        for j = 1 : n 
%            tempD = OTFgenerate(w*2,kcutoff*sqrt(2),k(i,:).*kshift(j));
% %            figure;
% %            imshow(tempD,[]);
% %            title((i-1)*n+j);
%            Dsum = Dsum+ tempD.*c(j).*c(j).*tempD;
%          
%            if((~isequal(j,1)))
%              Dperi = Dperi+tempD.*c(j).*c(j).*tempD;
%            end
%        end
%     end
    for i = 1 : n
       for j = 1 : n
           W = WienerMask(t,kcutoff,k,k(i,:).*kshift(j),gamma);
           temp = (ifft2(fdouble(:,:,(i-1)*n+j).*W));   
      %     imshow(log(W),[]);
           temp =temp .* exp( kshift(j)*1i.*2.*pi.*((k(i,2)/t.*(U-to) + k(i,1)/t.*(V-to))));
           Fsum = Fsum + temp;
%            figure();
%            imshow(log(abs(temp)),[]);
%            title((i-1)*n+j);
           if(~isequal(j,1))
               Fperi = Fperi+temp;
              % Dperi = Dperi+c(j).*c(j).*tempD.*tempD;
           end
       end
    end
    figure;
    imshow(abs(Fsum),[]);
    colormap('hot');
    title('SIQCM in Real Space')
end