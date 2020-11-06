function [freq,Ka,phase] = PCMseparateF(frames,phase)


%%Separating the three frequency components
freq = SeparatedComponents2D(phase,frames);
