function y = TrackZFit(x, A, B, C, D, E)
y = C + (x < D) .* (A * (x-D).^2 + B * (x-D)) + E * (x >= D).*  (x-D);
end
    