%This program need to provide therotically value of k0 and phi
%% Initialize the matrix 
clear all
close all
clc


% load("result.mat");
% 
% aa1 = imread('sim01z4.tif');
% aa = aa1(:,:,2);
% bb = uint16(zeros(512,512,9));
% for ii=1:3
%      for jj=1:3
%         bb(1:512,1:512,(ii-1)*3+jj)=aa((ii-1)*512+1:ii*512,(jj-1)*512+1:jj*512,1);
%      end
% end
% framesSIM = double(bb);
% n = 3;
load("../Modified SOFI/fSOFI/result_s17_k15.mat")
framesSOFI = framesSOFI_FI;
framesSIM = framesSIM_FIFI;
%% Background Normalization
framesSOFI = BgNormalization(framesSOFI);
framesSIM = BgNormalization(framesSIM);
%framesSOFI = BgNormalization(framesSOFI);
%kcutoff = 71.2;
kcutoff = 71.2;
gamma = 0.03;
k_factor = 1.5;
k = [];
phase = [];
OTFo = OTFgenerate(size(framesSOFI,1),kcutoff,[0 0]);
%% Background subtraction

%% Obtain estimates of frequency component

%three frequency components
fSOFI = zeros(size(framesSOFI));
fSIM = zeros(size(framesSIM,1),size(framesSIM,1),15);
n = ceil(size(framesSOFI,3)^0.5);
kSOFI = [55.2999518421719,14.8178997907538;36.0211937118148,44.4855121273234;2.99816376817320,57.1734861088626;-31.1686926498762,48.0054494087735;-53.4430624244311,20.5108414886416];
kSIM = [55.2999518421719,14.8178997907538;36.0211937118148,44.4855121273234;2.99816376817320,57.1734861088626;-31.1686926498762,48.0054494087735;-53.4430624244311,20.5108414886416];
kSOFI=kSOFI./0.8.*k_factor;
kSIM = kSIM./0.8.*k_factor;
phaseSOFI = [0 pi/5 pi*2/5 pi*3/5 pi*4/5;
    0 pi/5 pi*2/5 pi*3/5 pi*4/5;
    0 pi/5 pi*2/5 pi*3/5 pi*4/5;
    0 pi/5 pi*2/5 pi*3/5 pi*4/5;
    0 pi/5 pi*2/5 pi*3/5 pi*4/5;];
phaseSOFI = phaseSOFI';
phaseSIM = phaseSOFI;
for i = 1:n
    [fSOFI(:,:,(i-1)*n+1:i*n)] = SeparatedComponents2D(phaseSOFI((i-1)*n+1:i*n),framesSOFI(:,:,(i-1)*n+1:i*n));
end
for i = 1 : n
    [fSIM(:,:,(i-1)*3+1:i*3)] = SeparatedComponents2DSIM(phaseSOFI((i-1)*n+1:i*n),framesSIM(:,:,(i-1)*n+1:i*n)); 
end

%% check all freq component
viewFreq(fSOFI);
viewIMG(fSOFI);
%% Wiener Filtering the noisy frequency components

% %% check all freq component
% viewFreq(wienerFreq);
% viewIMG(wienerFreq);

[Fsum,Fsum2,Fperi,Fcent] = WienerF(fSOFI,kSOFI,kcutoff,gamma);
%[FsumSIM,FsumSIM2,FperiSIM,FcentSIM] = WienerFSIM(fSIM,kSIM,kcutoff,gamma);
SIMplot(Fsum,Fsum2,Fperi,Fcent,kSOFI,OTFo);
% SIMplotSIM(FsumSIM,FsumSIM2,FperiSIM,FcentSIM,kSIM,OTFo);
% frameSUM = sum(framesSIM_FIFI,3);
% figure; 
% imshow(frameSUM,[]);
% title('Intensity')
% framesSOFI = sum(framesSOFI_FI,3);
% figure; 
% imshow(framesSOFI,[]);
% title('SOFI Intensity')