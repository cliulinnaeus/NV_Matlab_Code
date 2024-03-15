function y = TrigonometricDecayFit(x, A, B, C, T)
y = - A .* exp(- x / B) .* cos(2*pi/T * x) + C;
end
    