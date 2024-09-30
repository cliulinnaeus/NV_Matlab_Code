function Ramsey
global gmSEQ gSG
gSG.bfixedPow=1;
gSG.bfixedFreq=1;
gSG.bMod='IQ';
gSG.bModSrc='External';

[gmSEQ.ScaleT, gmSEQ.ScaleStr] = GetScale(gmSEQ.To);

arr = gmSEQ.SweepParam;
max_index = length(arr);
m = gmSEQ.m;
index_m = find(arr ==m); %find the index of the current t
index_n = 1 + max_index - index_m; %find the index of the differential t
n = arr(index_n); %find the differential t
n=m;

q = 20; %iq time
pre_init_wait = 5000;
init_dur = gmSEQ.readout;
readout_dur = gmSEQ.CtrGateDur;
post_init_wait = 1000;
pi_half = gmSEQ.pi/2;
post_MWseq_wait = 1000;

T_green_1_start = pre_init_wait;
T_green_2_start = T_green_1_start + init_dur + post_init_wait + pi_half*2 + post_MWseq_wait + m;
T_green_3_start = T_green_2_start + init_dur + pre_init_wait;
T_green_4_start = T_green_3_start + init_dur + post_init_wait + pi_half*2 + post_MWseq_wait + n;

if strcmp(gmSEQ.meas,'APD')
    gmSEQ.CtrGateDur = 1000;
end

gmSEQ.CHN(1).PBN=PBDictionary('ctr0');
gmSEQ.CHN(1).NRise=4;
gmSEQ.CHN(1).T=[T_green_1_start,T_green_2_start,T_green_3_start,T_green_4_start]; 
gmSEQ.CHN(1).DT=[readout_dur,readout_dur,readout_dur,readout_dur];    

gmSEQ.CHN(2).PBN=PBDictionary('GreenAOM');
gmSEQ.CHN(2).NRise=4;
gmSEQ.CHN(2).T=[T_green_1_start,T_green_2_start,T_green_3_start,T_green_4_start]; 
gmSEQ.CHN(2).DT=[init_dur,init_dur,init_dur,init_dur];    

gmSEQ.CHN(3).PBN=PBDictionary('MWSwitch');
gmSEQ.CHN(3).NRise=4;
T=[T_green_1_start+init_dur+post_init_wait,...
    m,...
    pre_init_wait+init_dur*2+post_init_wait+post_MWseq_wait,...
    n]; 
DT=[pi_half,pi_half,pi_half,pi_half];    
ConstructSeq(T,DT)

gmSEQ.CHN(4).PBN=PBDictionary('+X');
gmSEQ.CHN(4).NRise=3;
T=[T_green_1_start+init_dur+post_init_wait-q,...
    m-2*q,...
    pre_init_wait+init_dur*2+post_init_wait-2*q+post_MWseq_wait]; 
DT=[pi_half+2*q,pi_half+2*q,pi_half+2*q];    
ConstructSeq(T,DT)

gmSEQ.CHN(5).PBN=PBDictionary('-X');
gmSEQ.CHN(5).NRise=1;
T=[T_green_4_start-pi_half-q-post_MWseq_wait]; 
DT=[pi_half+2*q];    
ConstructSeq(T,DT)

gmSEQ.CHN(6).PBN=PBDictionary('dummy1');
gmSEQ.CHN(6).NRise=2;
T=[0,T_green_4_start-20+post_MWseq_wait]; 
DT=[20,20];    
ConstructSeq(T,DT)

ApplyDelays();
