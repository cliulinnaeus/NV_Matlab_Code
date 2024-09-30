function T1_Rb_S00_S01_Rd_newRef
global gmSEQ gSG
gSG.bfixedPow=1;
gSG.bfixedFreq=1;
gSG.bMod='LOL';
gSG.bModSrc='External';

[gmSEQ.ScaleT, gmSEQ.ScaleStr] = GetScale(gmSEQ.To);

if strcmp(gmSEQ.meas,'APD')
    gmSEQ.CtrGateDur = 1000;
end
d = 10000; %AfterLaser
u = 10000; %AfterPulse
w = 10000; %initial wait
i = gmSEQ.readout; 
r = gmSEQ.CtrGateDur;
re = 0; %extra laser on time for readout
rl = r+re; %total laser on time for readout
p = gmSEQ.pi;
m = gmSEQ.m;
to = gmSEQ.To;

%%%%% Variable sequence length%%%%%%

gmSEQ.CHN(1).PBN=PBDictionary('ctr0');
gmSEQ.CHN(1).NRise=5;
T=[w+i+d,d+m+u+re,w+i+d,re+d+m+u+re,w+i+d+re];
DT=[r,r,r,r,r];
ConstructSeq(T,DT)

gmSEQ.CHN(numel(gmSEQ.CHN)+1).PBN=PBDictionary('GreenAOM');
gmSEQ.CHN(numel(gmSEQ.CHN)).NRise=8;
T=[w,d,d+m+u,w,d,d+m+u,w,d];
DT=[i,rl,rl,i,rl,rl,i,rl];
ConstructSeq(T,DT)

gmSEQ.CHN(numel(gmSEQ.CHN)+1).PBN=PBDictionary('MWSwitch');
gmSEQ.CHN(numel(gmSEQ.CHN)).NRise=1;
%T=[(w+i+d+rl+d+m+u)*2+rl-u-p,u+rl+w+i+d];
%DT=[p,p];
T=[(w+i+d+rl+d+m+u)*2+rl-u-p];
DT=[p];
ConstructSeq(T,DT)

gmSEQ.CHN(numel(gmSEQ.CHN)+1).PBN=PBDictionary('dummy1');
gmSEQ.CHN(numel(gmSEQ.CHN)).NRise=2;
T=[0 (w+i+d+r+100+d+m+u+rl)*2+p+rl+w+i+d];
DT=[20 20];
ConstructSeq(T,DT)

%keep duty cycle same
% gmSEQ.CHN(1).PBN=PBDictionary('ctr0');
% gmSEQ.CHN(1).NRise=4;
% T=[w+i+d,d+m+u+re,w+i+d+rl+d+to-m+u+re,w+i+d+p+u+re];
% DT=[r,r,r,r];
% ConstructSeq(T,DT)
% 
% gmSEQ.CHN(numel(gmSEQ.CHN)+1).PBN=PBDictionary('AOM');
% gmSEQ.CHN(numel(gmSEQ.CHN)).NRise=8;
% T=[w,d,d+m+u,w,d,d+to-m+u,w,d+p+u];
% DT=[i,rl,rl,i,rl,rl,i,rl];
% ConstructSeq(T,DT)
% 
% gmSEQ.CHN(numel(gmSEQ.CHN)+1).PBN=PBDictionary('MWSwitch');
% gmSEQ.CHN(numel(gmSEQ.CHN)).NRise=2;
% T=[(w+i+d+rl+d+u)*2+to+rl-u-p,u+rl+w+i+d];
% DT=[p,p];
% ConstructSeq(T,DT)
% 
% gmSEQ.CHN(numel(gmSEQ.CHN)+1).PBN=PBDictionary('dummy1');
% gmSEQ.CHN(numel(gmSEQ.CHN)).NRise=2;
% T=[0 (w+i+d+r+100+d+u+rl)*2+to+p+rl+w+i+d];
% DT=[20 20];
% ConstructSeq(T,DT)

ApplyDelays();
