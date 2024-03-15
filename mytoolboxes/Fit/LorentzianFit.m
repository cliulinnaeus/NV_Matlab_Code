function y = LorentzianFit(x, A, B, C, D)
y = A./(((x-D)./B).^2 +1) + C;
end
    