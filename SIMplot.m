function [] = SIMplot(Fsum,Fsum2,Fperi,Fcent,k,OTFo)

%% recontructed SIM images
Dsum = real( ifft2(fftshift(Fsum)) );
Dperi = real( ifft2(fftshift(Fperi)) );
Dsum2 = real( ifft2(fftshift(Fsum2)) );
figure;
imshow(Dsum(),[])
title('Appodized SIQCM image')
colormap('hot');
figure;
imshow(Dperi(),[])
title('SIQCM image (using only off-center frequency components)')
figure;
imshow(Dsum2(),[])
title('SIQCM image')
% appodizing the merged frequency components
% Index = 0.4;
% Kotf = OTFedgeF(OTFo);
% [FsumA] = ApodizationFunction(Fsum,k,Kotf,Index);
% [FperiA] = ApodizationFunction(Fperi,k,Kotf,Index);
% DsumA = real( ifft2(fftshift(FsumA)) );
% DperiA = real( ifft2(fftshift(FperiA)) );
% 
% figure;
% imshow(DsumA(h+1:t-h,h+1:t-h),[])
% title('appodized SIM image')
% figure;
% imshow(DperiA(h+1:t-h,h+1:t-h),[])
% title('appodized SIM image (using only off-center frequency components)')
% 
% 
% %% Frequency Plots
% fS1aTnoisy = fftshift(fft2(S1aTnoisy));
% w = size(OTFo,1);
% wo = w/2;
% w1 = size(fS1aTnoisy,1);
% if ( w > w1 )
%     fS1aTnoisy0 = zeros(w,w);
%     fS1aTnoisy0(wo-w1/2+1:wo+w1/2,wo-w1/2+1:wo+w1/2) = fS1aTnoisy;
%     clear fS1aTnoisy
%     fS1aTnoisy = fS1aTnoisy0;
%     clear fS1aTnoisy0;
% end
% 
% 
% p = 10;
% minL1 = min(min( abs(fS1aTnoisy).^(1/p) ));
% minL2 = min(min( abs(Fcent).^(1/p) ));
% minL3 = min(min( abs(Fsum).^(1/p) ));
% minL4 = min(min( abs(Fperi).^(1/p) ));
% minL5 = min(min( abs(FsumA).^(1/p) ));
% maxL1 = max(max( abs(fS1aTnoisy).^(1/p) ));
% maxL2 = max(max( abs(Fcent).^(1/p) ));
% maxL3 = max(max( abs(Fsum).^(1/p) ));
% maxL4 = max(max( abs(Fperi).^(1/p) ));
% maxL5 = max(max( abs(FsumA).^(1/p) ));
% minL = min([minL1,minL2,minL3,minL4,minL5]);
% maxL = max([maxL1,maxL2,maxL3,maxL4,maxL5]);
% 
% figure;
% imshow(abs(fS1aTnoisy).^(1/p),[minL maxL])
% title('fS1aTnoisy')
% 
p = 10;
figure;
imshow(abs(Fcent),[])
title('Weiner Filtered frequency')
figure;
imshow(abs(Fsum),[])
title('SIQCM frequency')
figure;
imshow(abs(Fperi),[])
title('SIQCM (off-center frequency components)')
% figure;
% imshow(abs(FsumA).^(1/p),[])
% title('appodized SIM frequency')
% figure;
% imshow(abs(FperiA).^(1/p),[])
% title('appodized SIM (off-center frequency components)')


