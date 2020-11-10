function w =  WienerMask(t,kcutoff,k,korder,gamma)
  %t the mask size size*size
    %kmax the cutoff freq of 
    n = size(k,1);
    k0 = mean(sqrt(k(:,1).^2+k(:,2).^2));
    H = triMask(t,kcutoff,k0,-korder);
    c = [0.375 0.25 0.25 0.0625 0.0625];
    kshift = [0 1 -1 2 -2];
    w = zeros(t,t);
    D = zeros(t,t);
    for i = 1 : n
        for j = 1 : n
            temp =  OTFgenerate(t,kcutoff*sqrt(2),k(i,:).*kshift(j)-korder);
            w = w + temp*c(j)*c(j);
            D = D +c(j)*c(j).*temp.*temp;
        end
    end
    D = D + gamma*gamma;
    w = w./D.*H;
end