function ConstructSeq(T,DT)
global gmSEQ
       for i = 2:length(T)
           Taccum = T(i-1);
           T(i) = Taccum + T(i)+ DT(i-1);
       end
       gmSEQ.CHN(numel(gmSEQ.CHN)).T = T;
       gmSEQ.CHN(numel(gmSEQ.CHN)).DT = DT;
