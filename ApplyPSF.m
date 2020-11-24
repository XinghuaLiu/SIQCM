function grid = ApplyPSF(t,positions,brightness,sigma)
Nemitters = size(positions,1);
 % pixel number within the camera
 emitter_position = positions;
 s_xy = sigma;
 r = 3*s_xy;
[gridX,gridY] = meshgrid(1:t,1:t);
grid = zeros(t,t);
for m=1:Nemitters

    % Discrete Grid
    [x,y]=ind2sub(size(grid),find((gridY - emitter_position(m,1)).^2 +...
        (gridX - emitter_position(m,2)).^2 <=  r^2 == 1));
    for k=1:length(x)
        grid(x(k),y(k))= squeeze(grid(x(k),y(k))).' + 0.25*brightness(m)*...
                         (erf((x(k)-emitter_position(m,1)+0.5)/(sqrt(2)*s_xy)) -...
                     erf((x(k)-emitter_position(m,1)-0.5)/(sqrt(2)*s_xy))).*...
                         (erf((y(k)-emitter_position(m,2)+0.5)/(sqrt(2)*s_xy)) -...
                         erf((y(k)-emitter_position(m,2)-0.5)/(sqrt(2)*s_xy)));
    end
end
end
