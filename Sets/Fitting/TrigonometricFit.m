function y = TrigonometricFit(x, A, B, C, T)
y = A * sin(2*pi/T * x) + B * sin(2*pi/T * x) + C;
end
    