function frames = BgNormalization(frames)
%Aim Bg normalization for all the frames to Normalize same mean 
%and std value
% Input: frames[](3d matrix) Original Frames
% Output: frames[](3d matrix) Normalized Frames

 n = size(frames,3);
 mn = zeros(n,1);
 sd = zeros(n,1);
 for i= 1 : n
     mn(i) = mean2(frames(:,:,i));
     sd(i) = std2(frames(:,:,i));
 end
 mMean = max(mn);
 mStd = max(sd);
 for i = 1:n
     frames(:,:,i) = (frames(:,:,i)-mn(i)).*(mStd./sd(i))+mMean;
 end

end