function SCC_spin_state_test_with_shelf()
%fdc stands for fixed duty cycle
global gmSEQ gSG
gSG.bfixedPow=1;
gSG.bfixedFreq=1;
gSG.bMod='LOL';
gSG.bModSrc='External';

[gmSEQ.ScaleT, gmSEQ.ScaleStr] = GetScale(gmSEQ.To);

pre_green_init_wait = 5e6;
green_init_dur = gmSEQ.readout;
post_green_init_wait = 10000;
post_MW_wait = 1000;
green_shelf_dur = 500;
post_green_shelf = 20;
red_ion_dur = 100;
post_red_ion_wait = 3e6;
orange_readout = 4e6;
MW_dur = gmSEQ.pi;

T_pre_MW = pre_green_init_wait+green_init_dur+post_green_init_wait;
T_pre_green_shelf = T_pre_MW+MW_dur+post_MW_wait;
T_pre_red_ion = T_pre_green_shelf+green_shelf_dur+post_green_shelf;
T_pre_orange_readout = T_pre_red_ion+red_ion_dur+post_red_ion_wait;

%%%%% Variable sequence length%%%%%%
gmSEQ.CHN(1).PBN=PBDictionary('ctr0');
gmSEQ.CHN(1).NRise=2;
T=[T_pre_orange_readout,T_pre_orange_readout]; 
DT=[orange_readout,orange_readout];    
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
DT=[orange_readout,orange_readout];
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
T=[0 , 2*T_pre_orange_readout+orange_readout-20];
DT=[20 20];
ConstructSeq(T,DT)

ApplyDelays();
