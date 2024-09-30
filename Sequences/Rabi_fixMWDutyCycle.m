function Rabi_fix_MWDutyCycle
global gmSEQ gSG
gSG.bfixedPow = 1;
gSG.bfixedFreq = 1;
gSG.bMod = 'LOL';%set to no modulation
gSG.bModSrc = 'External';
[gmSEQ.ScaleT, gmSEQ.ScaleStr] = GetScale(gmSEQ.To);


arr = gmSEQ.SweepParam;
max_index = length(arr);
m = gmSEQ.m;
index_m = find(arr ==m); %find the index of the current t
index_n = 1 + max_index - index_m; %find the index of the differential t
n = arr(index_n); %find the differential t

d = 1e6; %AfterLaser
u = 1e6; %AfterPulse
i = gmSEQ.readout; 
r = gmSEQ.CtrGateDur;

To = arr(end)+arr(1);

%%%%% Variable sequence length%%%%%%

gmSEQ.CHN(1).PBN=PBDictionary('ctr0');
gmSEQ.CHN(1).NRise=4;
T=[d,i-r+d+m+u,i-r+d,i-r+d+n+u];
DT=[r,r,r,r];
ConstructSeq(T,DT)

gmSEQ.CHN(numel(gmSEQ.CHN)+1).PBN=PBDictionary('GreenAOM');
gmSEQ.CHN(numel(gmSEQ.CHN)).NRise=4;
T=[d,d+m+u,d,d+n+u];
DT=[i,i,i,i];
ConstructSeq(T,DT)

gmSEQ.CHN(numel(gmSEQ.CHN)+1).PBN=PBDictionary('MWSwitch');
gmSEQ.CHN(numel(gmSEQ.CHN)).NRise=2;
T=[d+i+d,u+i+d+i+d];
DT=[m,n];
ConstructSeq(T,DT)

gmSEQ.CHN(numel(gmSEQ.CHN)+1).PBN=PBDictionary('dummy1');
gmSEQ.CHN(numel(gmSEQ.CHN)).NRise=2;
T=[0 (2*d+2*i+u)*2+To-i];
DT=[20 20];
ConstructSeq(T,DT)

ApplyDelays();
