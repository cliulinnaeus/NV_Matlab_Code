function Echo_wDarkRef
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
n = m; %find the differential t

pre_init_wait = 10000;
init_dur = gmSEQ.readout;
readout_dur = gmSEQ.CtrGateDur;
post_init_wait = 3000;
pi_half = gmSEQ.halfpi;
post_MW_wait = 0;
pre_readout_wait = 3000;
q = 20; %rise time for the iq signal

T_green_1_start = pre_init_wait;
T_green_2_start = T_green_1_start + init_dur + post_init_wait + pi_half*2 + post_MW_wait*3 + m*2 + gmSEQ.pi+pre_readout_wait;
T_green_3_start = T_green_2_start + init_dur + pre_init_wait;
T_green_4_start = T_green_3_start + init_dur + post_init_wait + pi_half*2 + post_MW_wait*3 + n*2 + gmSEQ.pi+pre_readout_wait;

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
gmSEQ.CHN(3).NRise=7;
T=[T_green_1_start - pre_readout_wait,...
    pre_readout_wait+init_dur+post_init_wait-gmSEQ.pi,...
    post_MW_wait+m,...
    post_MW_wait+m,...
    post_MW_wait+pre_init_wait+init_dur*2+post_init_wait+pre_readout_wait,...
    post_MW_wait+n,...
    post_MW_wait+n]; 
DT=[gmSEQ.pi,pi_half,gmSEQ.pi,pi_half,pi_half,gmSEQ.pi,pi_half];    
ConstructSeq(T,DT)



gmSEQ.CHN(4).PBN=PBDictionary('+X');
gmSEQ.CHN(4).NRise=6;
T=[T_green_1_start - pre_readout_wait - q,...
    pre_readout_wait+init_dur+post_init_wait-gmSEQ.pi-2*q,...
    post_MW_wait+m-2*q,...
    post_MW_wait+m-2*q,...
    post_MW_wait+pre_init_wait+init_dur*2+post_init_wait-2*q+pre_readout_wait,...
    post_MW_wait+n-2*q]; 
DT=[gmSEQ.pi+2*q,pi_half+2*q,gmSEQ.pi+2*q,pi_half+2*q,pi_half+2*q,gmSEQ.pi+2*q];    
ConstructSeq(T,DT)

gmSEQ.CHN(5).PBN=PBDictionary('-X');
gmSEQ.CHN(5).NRise=1;
T=[T_green_4_start-post_MW_wait-pi_half-q-pre_readout_wait]; 
DT=[pi_half+2*q];    
ConstructSeq(T,DT)

gmSEQ.CHN(6).PBN=PBDictionary('dummy1');
gmSEQ.CHN(6).NRise=2;
T=[0,T_green_4_start-20]; 
DT=[20,20];    
ConstructSeq(T,DT)

ApplyDelays();
