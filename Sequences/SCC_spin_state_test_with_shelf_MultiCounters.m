function SCC_spin_state_test_with_shelf_MultiCounters()
%fdc stands for fixed duty cycle
global gmSEQ gSG
gSG.bfixedPow=1;
gSG.bfixedFreq=1;
gSG.bMod='LOL';
gSG.bModSrc='External';

[gmSEQ.ScaleT, gmSEQ.ScaleStr] = GetScale(gmSEQ.To);

v = gmSEQ.Var;

pre_green_init_wait = 5e6;
green_init_dur = gmSEQ.readout;
post_green_init_wait = 10000;
post_MW_wait = 1000;
green_shelf_dur = gmSEQ.m;
post_green_shelf = 0;
red_ion_dur = 500;
post_red_ion_wait = 4e6;
orange_readout = v(4);
extra_readout_time = 0; %Make sure the last counter get full laser power.
counter_start_delay = v(6);
counter_period = v(7);
counter_on = v(8);
counter_off = counter_period - counter_on;
N = floor((orange_readout-counter_start_delay)/counter_period);

N_counter_T = repelem([counter_off],N-1); %This does not contain the T before 1st counter and the T after the last counter. So it only has N-1 elements. 
N_counter_DT = repelem([counter_on],N);

disp(['Number of Counters: ' num2str(N) ' *2'])
disp(['Counter Period (ns): ' num2str(counter_period)])

MW_dur = gmSEQ.pi;

T_pre_MW = pre_green_init_wait+green_init_dur+post_green_init_wait;
T_pre_green_shelf = T_pre_MW+MW_dur+post_MW_wait;
T_pre_red_ion = T_pre_green_shelf+green_shelf_dur+post_green_shelf;
T_pre_orange_readout = T_pre_red_ion+red_ion_dur+post_red_ion_wait;

%%%%% Variable sequence length%%%%%%
gmSEQ.CHN(1).PBN=PBDictionary('ctr0');
gmSEQ.CHN(1).NRise=N*2;
T=[T_pre_orange_readout+counter_start_delay, N_counter_T, ...
    T_pre_orange_readout+counter_off+counter_start_delay+orange_readout+extra_readout_time-N*counter_period, N_counter_T]; 
DT=[N_counter_DT,N_counter_DT];    
ConstructSeq(T,DT)

gmSEQ.CHN(numel(gmSEQ.CHN)+1).PBN=PBDictionary('GreenAOM');
gmSEQ.CHN(numel(gmSEQ.CHN)).NRise=4;
T=[pre_green_init_wait,...
    post_green_init_wait+MW_dur+post_MW_wait,...
    post_green_shelf+red_ion_dur+post_red_ion_wait+orange_readout+pre_green_init_wait,...
    post_green_init_wait+MW_dur+post_MW_wait];
DT=[green_init_dur,green_shelf_dur,green_init_dur,green_shelf_dur];
ConstructSeq(T,DT)

gmSEQ.CHN(numel(gmSEQ.CHN)+1).PBN=PBDictionary('OrangeAOM');
gmSEQ.CHN(numel(gmSEQ.CHN)).NRise=2;
T=[T_pre_orange_readout,T_pre_orange_readout];
DT=[orange_readout+extra_readout_time,orange_readout+extra_readout_time];
ConstructSeq(T,DT)

gmSEQ.CHN(numel(gmSEQ.CHN)+1).PBN=PBDictionary('RedAOM');
gmSEQ.CHN(numel(gmSEQ.CHN)).NRise=2;
T=[T_pre_red_ion,T_pre_red_ion+post_red_ion_wait+orange_readout];
DT=[red_ion_dur,red_ion_dur];
ConstructSeq(T,DT)

gmSEQ.CHN(numel(gmSEQ.CHN)+1).PBN=PBDictionary('MWSwitch');
gmSEQ.CHN(numel(gmSEQ.CHN)).NRise=1;
T=[T_pre_MW+T_pre_orange_readout+orange_readout];
DT=[MW_dur];
ConstructSeq(T,DT)

gmSEQ.CHN(numel(gmSEQ.CHN)+1).PBN=PBDictionary('dummy1');
gmSEQ.CHN(numel(gmSEQ.CHN)).NRise=2;
T=[0 , 2*T_pre_orange_readout+2*orange_readout+extra_readout_time*2-40];
DT=[20 20];
ConstructSeq(T,DT)

ApplyDelays();