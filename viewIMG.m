function []= viewIMG(f)
  n = ceil(size(f,3)./5);
    figure;
    img = zeros(size(f));
    for i = 1 : n
        for j = 1 : 5
            img(:,:,j+(i-1)*5)= real(ifft2(fftshift((f(:,:,j+(i-1)*5)))));   
        end
    end
    
     for i = 1 : n
        for j = 1 : 5
        subplot(n,n,(i-1)*n+j);
        imshow(img(:,:,(i-1)*n+j),[]);
        end
     end
end