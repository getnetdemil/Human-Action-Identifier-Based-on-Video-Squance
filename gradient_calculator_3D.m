function Gt= gradient_calculator_3D(I,n,RGN)

if n==1
    Gt=I-RGN(:,:,2);
elseif n==9
    Gt=I-RGN(:,:,8);
else
    Gt=RGN(:,:,n+1)-RGN(:,:,n-1);
end

end
