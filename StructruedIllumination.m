function Ion = StructruedIllumination(position, k,  phase)
% Simulated the sturctured illumination according to the 

%Inputs:
% position              location of the fluoresore
% Fluo                  parameters of the fluorophore and sample 
%                       fluorescent properties [struct]
%Structed               parameters of the structed illumination
x = position(1);
y = position(2);
kx = k(1);
ky = k(2);
Ion = 1/2*Fluo.Ion*(1+cos((kx*x+ky*y+phase)));
end