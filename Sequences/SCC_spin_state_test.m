function SCC_spin_state_test()
%fdc stands for fixed duty cycle
global gmSEQ gSG
gSG.bfixedPow=1;
gSG.bfixedFreq=1;
gSG.bMod='LOL';
gSG.bModSrc='External';

[gmSEQ.ScaleT, gmSEQ.ScaleStr] = GetScale(gmSEQ.To);


green_init_dur = gmSEQ.readout;
post_green_init_wait = 1000;
post_MW_wait = 1000;
red_ion_dur = gmSEQ.m;
post_red_ion_wait = 4e6;
orange_readout = 10e6;
pi_time = gmSEQ.pi;
pre_green_init_wait = 1000000;

pre_MW = pre_green_init_wait+green_init_dur+post_green_init_wait;
pre_red_ion = pre_MW+pi_time+post_MW_wait;
pre_orange_readout = pre_red_ion+red_ion_dur+post_red_ion_wait;

%%%%% Variable sequence length%%%%%%
gmSEQ.CHN(1).PBN=PBDictionary('ctr0');
gmSEQ.CHN(1).NRise=2;
T=[pre_orange_readout+6e6,pre_orange_readout+6e6]; 
DT=[gmSEQ.CtrGateDur,gmSEQ.CtrGateDur];    
ConstructSeq(T,DT)

gmSEQ.CHN(numel(gmSEQ.CHN)+1).PBN=PBDictionary('GreenAOM');
gmSEQ.CHN(numel(gmSEQ.CHN)).NRise=2;
T=[pre_green_init_wait,pre_orange_readout-green_init_dur+orange_readout];
DT=[green_init_dur,green_init_dur];
ConstructSeq(T,DT)

gmSEQ.CHN(numel(gmSEQ.CHN)+1).PBN=PBDictionary('OrangeAOM');
gmSEQ.CHN(numel(gmSEQ.CHN)).NRise=2;
T=[pre_orange_readout,pre_orange_readout];
DT=[orange_readout,orange_readout];
ConstructSeq(T,DT)

gmSEQ.CHN(numel(gmSEQ.CHN)+1).PBN=PBDictionary('RedAOM');
gmSEQ.CHN(numel(gmSEQ.CHN)).NRise=2;
T=[pre_red_ion,pre_red_ion+post_red_ion_wait+orange_readout];
DT=[red_ion_dur,red_ion_dur];
ConstructSeq(T,DT)

gmSEQ.CHN(numel(gmSEQ.CHN)+1).PBN=PBDictionary('MWSwitch');
gmSEQ.CHN(numel(gmSEQ.CHN)).NRise=1;
T=[pre_MW+pre_orange_readout+orange_readout];
DT=[pi_time];
ConstructSeq(T,DT)

gmSEQ.CHN(numel(gmSEQ.CHN)+1).PBN=PBDictionary('dummy1');
gmSEQ.CHN(numel(gmSEQ.CHN)).NRise=2;
T=[0 , 2*pre_orange_readout+orange_readout-20];
DT=[20 20];
ConstructSeq(T,DT)

ApplyDelays();
