%This program need to provide therotically value of k0 and phi
%% Initialize the matrix 
clear all
close all
clc


load("./result_32m_k2_lownoise2.mat")
framesSOFI = framesSOFI_FI;
framesSIM = framesSIM_FIFI;
% %% Background Normalization
% framesSOFI = BgNormalization(framesSOFI);
% framesSIM = BgNormalization(framesSIM);
%%
TheoryFrames = theorySOFI(32,Fluo.emitters,Structed,4,Optics.fwhm_digital/2.3548/sqrt(2));
N = 32;
itp_factor = (N-1)/2/pi;
framesSOFI = TheoryFrames;
kcutoff = Structed.kcutoff*itp_factor;
kSOFI = zeros(Structed.n,2);
for i = 1 : Structed.n
    kSOFI(i,1) = Structed.k*cos(Structed.Orient(i))*itp_factor;
    kSOFI(i,2) = Structed.k*sin(Structed.Orient(i))*itp_factor;
end
kSIM = kSOFI;
gamma = 0.2;



OTFo = OTFgenerate(size(framesSOFI,1),kcutoff,[0 0]);

%% Obtain estimates of frequency component

%three frequency components
fSOFI = zeros(size(framesSOFI));
fSIM = zeros(size(framesSIM,1),size(framesSIM,1),15);
n = Structed.n;
phaseSOFI = [0 pi/5 pi*2/5 pi*3/5 pi*4/5;
    0 pi/5 pi*2/5 pi*3/5 pi*4/5;
    0 pi/5 pi*2/5 pi*3/5 pi*4/5;
    0 pi/5 pi*2/5 pi*3/5 pi*4/5;
    0 pi/5 pi*2/5 pi*3/5 pi*4/5;].*2;
phaseSOFI = phaseSOFI';
phaseSIM = phaseSOFI;
for i = 1:n
    [fSOFI(:,:,(i-1)*n+1:i*n)] = SeparatedComponents2D(phaseSOFI((i-1)*n+1:i*n),framesSOFI(:,:,(i-1)*n+1:i*n));
end
for i = 1 : n
    [fSIM(:,:,(i-1)*3+1:i*3)] = SeparatedComponents2DSIM(phaseSOFI((i-1)*n+1:i*n),framesSIM(:,:,(i-1)*n+1:i*n)); 
end

%% check all freq component
% viewFreq(fSOFI);
% viewIMG(fSOFI);
%% Wiener Filtering the noisy frequency components

% %% check all freq component
% viewFreq(wienerFreq);
% viewIMG(wienerFreq);

[Fsum,Fsum2,Fperi,Fcent] = WienerF(fSOFI,kSOFI,kcutoff,gamma);
[Dsum,Dperi]= WienerF2(fSOFI,kSOFI,kcutoff,gamma);
%[FsumSIM,FsumSIM2,FperiSIM,FcentSIM] = WienerFSIM(fSIM,kSIM,kcutoff,gamma);
%SIMplot(Fsum,Fsum2,Fperi,Fcent,kSOFI,OTFo);
% SIMplotSIM(FsumSIM,FsumSIM2,FperiSIM,FcentSIM,kSIM,OTFo);
% frameSUM = sum(framesSIM_FIFI,3);
% figure; 
% imshow(frameSUM,[]);
% title('Intensity')
% framesSOFI = sum(framesSOFI_FI,3);
% figure; 
% imshow(framesSOFI,[]);
% title('SOFI average Intensity')