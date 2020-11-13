function freq = SeparatedComponents2DSIM(phase,frames)

%Aim: Unmixing the frequency components of raw SIM images
%
n = size(frames,3);
fFrames = zeros(size(frames));
for i = 1 : n
    fFrames(:,:,i) = fftshift(fft2(frames(:,:,i)));
end
freq = zeros(size(frames,1),size(frames,2),3);
switch n
    case 3  
        MF = 1.0;
        M = 0.5*[1 0.5*MF*exp(-1i*phase(1)) 0.5*MF*exp(+1i*phase(1));
        1 0.5*MF*exp(-1i*phase(2)) 0.5*MF*exp(+1i*phase(2));
        1 0.5*MF*exp(-1i*phase(3)) 0.5*MF*exp(+1i*phase(3))];
        Minv = inv(M);
        for i = 1 : n
           freq(:,:,i) = Minv(i,1)*fFrames(:,:,1)+ Minv(i,2)*fFrames(:,:,2)+...
               Minv(i,3)*fFrames(:,:,3);
        end
    case 5
        MF = 1.0;
        M = 0.5*[1 0.5*MF*exp(-1i*phase(1)) 0.5*MF*exp(1i*phase(1)) ;
            1 0.5*MF*exp(-1i*phase(2)) 0.5*MF*exp(1i*phase(2)) ;
            1 0.5*MF*exp(-1i*phase(3)) 0.5*MF*exp(1i*phase(3)) ;
            1 0.5*MF*exp(-1i*phase(4)) 0.5*MF*exp(1i*phase(4)) ;
            1 0.5*MF*exp(-1i*phase(5)) 0.5*MF*exp(1i*phase(5)) ;
        ];
        Minv = (M'*M)\M';
        for i = 1:3
             freq(:,:,i) = Minv(i,1)*fFrames(:,:,1)+ Minv(i,2)*fFrames(:,:,2)+...
               Minv(i,3)*fFrames(:,:,3)+Minv(i,4)*fFrames(:,:,4)+Minv(i,5)*fFrames(:,:,5);
        end
    otherwise
        printf('N is not correct num')
 end     
end
        
        