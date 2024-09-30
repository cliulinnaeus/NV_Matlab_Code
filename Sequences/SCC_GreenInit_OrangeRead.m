function SCC_GreenInit_OrangeRead
%fdc stands for fixed duty cycle
global gmSEQ gSG
gSG.bfixedPow=1;
gSG.bfixedFreq=1;
gSG.bMod='LOL';
gSG.bModSrc='External';
gmSEQ.meas2='PD0';
gmSEQ.meas3='PD1';

[gmSEQ.ScaleT, gmSEQ.ScaleStr] = GetScale(gmSEQ.To);

m = gmSEQ.m;
v = gmSEQ.Var;

pre_init_wait = v(1);
init_dur = v(2); %initial pulse duration
T_init_end = pre_init_wait+init_dur; %initial pulse end time
post_init_wait = v(3);
laser_readout_dur = gmSEQ.readout;
pi_time = gmSEQ.pi;
post_MW_wait = 10000;
T_laser_readout_start = T_init_end+post_init_wait+pi_time+post_MW_wait;
wait_time_before_counting = v(6);
% counter_total_dur =  post_init_wait/2 + post_laser_readout_wait/2+ laser_readout_dur;
T_counter_start = T_laser_readout_start-wait_time_before_counting; %counter start time
T_seq = T_laser_readout_start + laser_readout_dur;
%%%%% Variable sequence length%%%%%%


gmSEQ.CHN(1).PBN=0;
gmSEQ.CHN(1).NRise=2;
T = [T_counter_start T_counter_start];
DT=[gmSEQ.CtrGateDur,gmSEQ.CtrGateDur];    
ConstructSeq(T,DT)


gmSEQ.CHN(numel(gmSEQ.CHN)+1).PBN=7;
gmSEQ.CHN(numel(gmSEQ.CHN)).NRise=2;
T = [T_counter_start T_counter_start];
DT=[gmSEQ.CtrGateDur,gmSEQ.CtrGateDur];    
ConstructSeq(T,DT)

    
%charge init
gmSEQ.CHN(numel(gmSEQ.CHN)+1).PBN=v(9);
gmSEQ.CHN(numel(gmSEQ.CHN)).NRise=2;
T=[pre_init_wait, T_seq - init_dur];
DT=[init_dur,init_dur];
ConstructSeq(T,DT)

gmSEQ.CHN(numel(gmSEQ.CHN)+1).PBN=PBDictionary('OrangeAOM');
gmSEQ.CHN(numel(gmSEQ.CHN)).NRise=2;
T=[T_laser_readout_start, T_seq - laser_readout_dur];
DT=[laser_readout_dur, laser_readout_dur];
ConstructSeq(T,DT)

gmSEQ.CHN(numel(gmSEQ.CHN)+1).PBN=PBDictionary('MWSwitch');
gmSEQ.CHN(numel(gmSEQ.CHN)).NRise=1;
T=[T_init_end+post_init_wait];
DT=[pi_time];
ConstructSeq(T,DT)

gmSEQ.CHN(numel(gmSEQ.CHN)+1).PBN=PBDictionary('dummy1');
gmSEQ.CHN(numel(gmSEQ.CHN)).NRise=2;
T=[0 , T_seq*2 - 20];
DT=[20 20];
ConstructSeq(T,DT)

ApplyDelays();
