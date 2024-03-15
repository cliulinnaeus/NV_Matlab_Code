function y = TrackZFit2(x, A, B, C, D, E)
% Replaced by a sigmiod function
y = C + A ./ (1 + exp( -B *(x - D + 18 )) ) + E * (x >= D) .* (x-D);
end
    