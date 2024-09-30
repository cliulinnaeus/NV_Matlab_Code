function SCC_charge_readout_TimeTagger
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
%init_dur = gmSEQ.m;
T_init_end = pre_init_wait+init_dur; %initial pulse end time
post_init_wait = v(3);
laser_readout_dur = v(4);
post_laser_readout_wait = v(5); %extra time to keep counting*2
pi_time = gmSEQ.pi;
post_MW_wait = 10000;
T_laser_readout_start = T_init_end+post_init_wait+pi_time+post_MW_wait;
wait_time_before_counting = v(6);
counter_DT = v(8); %counter duration
counter_off = v(7)-v(8);
counter_period = v(7); 
% counter_total_dur =  post_init_wait/2 + post_laser_readout_wait/2+ laser_readout_dur;
counter_total_dur =  laser_readout_dur-wait_time_before_counting;
T_counter_start = T_laser_readout_start+wait_time_before_counting; %counter start time
N = 1; %number of counters
T_seq = T_laser_readout_start + laser_readout_dur;
disp(['Number of Counter: ' num2str(N) ' *2'])
disp(['Counter Period (ns): ' num2str(counter_period)])
%%%%% Variable sequence length%%%%%%

gmSEQ.CHN(1).PBN=PBDictionary('ctr0');
gmSEQ.CHN(1).NRise=N*2;
T_first_half=[T_counter_start, counter_off]; 
T_first_half = repelem(T_first_half, [1, N-1]);
T_second_half = [T_counter_start+laser_readout_dur-N*counter_period+counter_off-wait_time_before_counting, counter_off];
T_second_half = repelem(T_second_half, [1, N-1]);
T = [T_first_half T_second_half];
DT=[counter_DT];    
DT = repelem(DT, N*2);
ConstructSeq(T,DT)

gmSEQ.CHN(numel(gmSEQ.CHN)+1).PBN=PBDictionary('TimeTaggerTrig');
gmSEQ.CHN(numel(gmSEQ.CHN)).NRise=N*2;
T_first_half=[T_counter_start, counter_off]; 
T_first_half = repelem(T_first_half, [1, N-1]);
T_second_half = [T_counter_start+laser_readout_dur-N*counter_period+counter_off-wait_time_before_counting, counter_off];
T_second_half = repelem(T_second_half, [1, N-1]);
T = [T_first_half T_second_half];
DT=[counter_DT];    
DT = repelem(DT, N*2);
ConstructSeq(T,DT)

use_orange_init = v(10);
if use_orange_init == 1234 %put 1234 in Var4 to use orange to init.
    %charge init
    gmSEQ.CHN(numel(gmSEQ.CHN)+1).PBN=7;%bit 7 is not in use, dummy bit
    gmSEQ.CHN(numel(gmSEQ.CHN)).NRise=1;
    T=[pre_init_wait];
    DT=[init_dur];
    ConstructSeq(T,DT)
    
    gmSEQ.CHN(numel(gmSEQ.CHN)+1).PBN=PBDictionary('GreenAOM');
    gmSEQ.CHN(numel(gmSEQ.CHN)).NRise=4;
    T=[pre_init_wait,T_laser_readout_start-pre_init_wait-init_dur,pre_init_wait,T_laser_readout_start-pre_init_wait-init_dur];
    DT=[init_dur,laser_readout_dur,init_dur,laser_readout_dur];
    ConstructSeq(T,DT)
else
    
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
end

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
