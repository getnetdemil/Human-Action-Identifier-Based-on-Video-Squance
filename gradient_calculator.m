function [Gx, Gy] = gradient_calculator(I)   

Hx= [-1 0 1];
Hy= transpose([-1 0 1]);
I=double(I);
Gx= imfilter(I,Hx,'replicate','same');
Gy= imfilter(I,Hy,'replicate','same');

end
