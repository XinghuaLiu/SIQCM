function []= viewFreq(f)
    n = ceil(size(f,3)./5);
    figure;
    maxF = max(max(max(log(abs(f)))));
    for i = 1 : n
        for j = 1 : 5
        subplot(5,n,j+(i-1)*5);
        imshow(log(abs(f(:,:,j+(i-1)*5))),[0 maxF]);    
        end
    end
end