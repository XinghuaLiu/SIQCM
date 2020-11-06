function [freq,Ka,phase] = PCMseparateSIM(frames,OTFo)
n = size(frames,3);
k = zeros(n,2);
Ka = [0 0];
for i = 1 : n
    k(i,:) = IlluminationFreqSIM(frames(:,:,i),OTFo);
    Ka = Ka +k(i,:);
end
Ka = Ka/ n;
phase = zeros(n,1);
for i = 1 : n
    phase(i) = IlluminationPhaseF(frames(:,:,i),Ka);
end
phase*180/pi

%%Separating the three frequency components
freq = SeparatedComponents2DSIM(phase,frames);
