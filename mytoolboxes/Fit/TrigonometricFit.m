function y = TrigonometricFit(x, A, C, T)
y = A * sin(2*pi/T * x).^2 + C;
end
    