function [] =viewRawIMG(img)
    n = size(img,3);
    k = ceil(n^0.5);
    for i = 1 : n
       subplot(k,k,i);
       imshow(img(:,:,i),[]);
       title(mean(mean(img(:,:,i))));
    end
end