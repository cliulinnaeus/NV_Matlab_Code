function y = GaussianFit(x, A, B, C, D)
y = A * exp( -((x-B)/(2*C)).^2 ) + D;
end
    