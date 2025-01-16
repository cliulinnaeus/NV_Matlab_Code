function f_InitDurCali
global gmSEQ gSG
gSG.bfixedPow = 1;
gSG.bfixedFreq = 1;
gSG.bMod = 'LOL';%set to no modulation
gSG.bModSrc = 'External';

[gmSEQ.ScaleT, gmSEQ.ScaleStr] = GetScale(gmSEQ.To);

fpga_delay = 700;
MW_length = round(gmSEQ.pi*2.6);
Init_dur = gmSEQ.m;
T_green_1_start = gmSEQ.post_init_wait + gmSEQ.post_MW_wait; 
T_green_2_start = T_green_1_start + Init_dur + gmSEQ.post_init_wait + MW_length + gmSEQ.post_MW_wait;

% Pulse Blaster
gmSEQ.CHN(1).PBN = PBDictionary('ctr0');
gmSEQ.CHN(1).NRise = 2;
gmSEQ.CHN(1).T = [T_green_1_start, T_green_2_start];
gmSEQ.CHN(1).DT = [gmSEQ.CtrGateDur, gmSEQ.CtrGateDur];

gmSEQ.CHN(numel(gmSEQ.CHN) + 1).PBN = PBDictionary('GreenAOM');
gmSEQ.CHN(numel(gmSEQ.CHN)).NRise = 2;
gmSEQ.CHN(numel(gmSEQ.CHN)).T = [T_green_1_start, T_green_2_start];
gmSEQ.CHN(numel(gmSEQ.CHN)).DT = [Init_dur, Init_dur];

gmSEQ.CHN(numel(gmSEQ.CHN) + 1).PBN = PBDictionary('MWSwitch');
gmSEQ.CHN(numel(gmSEQ.CHN)).NRise = 1;
gmSEQ.CHN(numel(gmSEQ.CHN)).T = T_green_1_start + Init_dur/2;
gmSEQ.CHN(numel(gmSEQ.CHN)).DT = T_green_2_start - T_green_1_start;

%fpga trigger
gmSEQ.CHN(numel(gmSEQ.CHN) + 1).PBN = 10;
gmSEQ.CHN(numel(gmSEQ.CHN)).NRise = 1;
gmSEQ.CHN(numel(gmSEQ.CHN)).T = T_green_1_start + Init_dur + gmSEQ.post_init_wait - fpga_delay;
gmSEQ.CHN(numel(gmSEQ.CHN)).DT = 100;

gmSEQ.CHN(numel(gmSEQ.CHN) + 1).PBN = 11;
gmSEQ.CHN(numel(gmSEQ.CHN)).NRise = 1;
gmSEQ.CHN(numel(gmSEQ.CHN)).T = T_green_1_start + Init_dur + gmSEQ.post_init_wait - fpga_delay;
gmSEQ.CHN(numel(gmSEQ.CHN)).DT = 100;


gmSEQ.CHN(numel(gmSEQ.CHN) + 1).PBN = PBDictionary('dummy1');
gmSEQ.CHN(numel(gmSEQ.CHN)).NRise = 2;
gmSEQ.CHN(numel(gmSEQ.CHN)).T = [0, T_green_2_start];
gmSEQ.CHN(numel(gmSEQ.CHN)).DT = [100, 100];

uploadSimplePulse('+X', gSG.FPGAFreq7, gSG.FPGAGain7, gmSEQ.pi, 0)
seq1 = {'+X'};
ch = complieCHN({seq1});
uploadSimpleProg('f_InitDurCali', ch);


ApplyDelays();
