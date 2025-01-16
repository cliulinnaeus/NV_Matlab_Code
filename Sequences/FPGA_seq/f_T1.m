function f_T1
global gmSEQ gSG
gSG.bfixedPow = 1;
gSG.bfixedFreq = 1;
gSG.bMod = 'LOL';%set to no modulation
gSG.bModSrc = 'External';

[gmSEQ.ScaleT, gmSEQ.ScaleStr] = GetScale(gmSEQ.To);

FPGA_delay = 700;
pre_init_wait = gmSEQ.post_init_wait + gmSEQ.post_MW_wait;

arr = gmSEQ.SweepParam;
max_index = length(arr);
m = gmSEQ.m;
index_m = find(arr ==m); %find the index of the current t
index_n = 1 + max_index - index_m; %find the index of the differential t
n = arr(index_n); %find the differential t


seq_len = round((gmSEQ.halfpi * 2 + gmSEQ.m * 2 + gmSEQ.pi) * 2.6);


T_green_1_start = pre_init_wait;
T_green_2_start = T_green_1_start + gmSEQ.readout + gmSEQ.post_init_wait + gmSEQ.post_MW_wait + m;
T_green_3_start = T_green_2_start + gmSEQ.readout + pre_init_wait ;
T_green_4_start = T_green_3_start + gmSEQ.readout + gmSEQ.post_init_wait + gmSEQ.post_MW_wait + n;



% Pulse Blaster
gmSEQ.CHN(1).PBN = PBDictionary('ctr0');
gmSEQ.CHN(1).NRise = 4;

gmSEQ.CHN(1).T = [T_green_1_start, T_green_2_start, T_green_3_start, T_green_4_start];
gmSEQ.CHN(1).DT = [gmSEQ.CtrGateDur, gmSEQ.CtrGateDur, gmSEQ.CtrGateDur, gmSEQ.CtrGateDur];

gmSEQ.CHN(numel(gmSEQ.CHN) + 1).PBN = PBDictionary('GreenAOM');
gmSEQ.CHN(numel(gmSEQ.CHN)).NRise = 4;
gmSEQ.CHN(numel(gmSEQ.CHN)).T = [T_green_1_start, T_green_2_start, T_green_3_start, T_green_4_start];
gmSEQ.CHN(numel(gmSEQ.CHN)).DT = [gmSEQ.readout, gmSEQ.readout, gmSEQ.readout, gmSEQ.readout];


gmSEQ.CHN(numel(gmSEQ.CHN) + 1).PBN = PBDictionary('MWSwitch');
gmSEQ.CHN(numel(gmSEQ.CHN)).NRise = 1;
gmSEQ.CHN(numel(gmSEQ.CHN)).T = T_green_1_start + gmSEQ.readout/2;
gmSEQ.CHN(numel(gmSEQ.CHN)).DT = T_green_4_start - T_green_1_start;

%fpga trigger
gmSEQ.CHN(numel(gmSEQ.CHN) + 1).PBN = 10;
gmSEQ.CHN(numel(gmSEQ.CHN)).NRise = 1;
gmSEQ.CHN(numel(gmSEQ.CHN)).T = T_green_2_start + gmSEQ.readout + gmSEQ.post_init_wait -round(gmSEQ.pi*2.6) - FPGA_delay;
gmSEQ.CHN(numel(gmSEQ.CHN)).DT = 100;

gmSEQ.CHN(numel(gmSEQ.CHN) + 1).PBN = 11;
gmSEQ.CHN(numel(gmSEQ.CHN)).NRise = 1;
gmSEQ.CHN(numel(gmSEQ.CHN)).T = T_green_2_start + gmSEQ.readout + gmSEQ.post_init_wait -round(gmSEQ.pi*2.6) - FPGA_delay;
gmSEQ.CHN(numel(gmSEQ.CHN)).DT = 100;



gmSEQ.CHN(numel(gmSEQ.CHN) + 1).PBN = PBDictionary('dummy1');
gmSEQ.CHN(numel(gmSEQ.CHN)).NRise = 2;
gmSEQ.CHN(numel(gmSEQ.CHN)).T = [0, ...
    T_green_4_start];
gmSEQ.CHN(numel(gmSEQ.CHN)).DT = [100, 100];


uploadSimplePulse('+X', gSG.FPGAFreq7, gSG.FPGAGain7, gmSEQ.pi, 0)

wait1 = round((gmSEQ.post_MW_wait + gmSEQ.readout + gmSEQ.post_init_wait + n) / 2.6);


seq1 = {'+X', wait1, '+X'};

ch = complieCHN({seq1});
uploadSimpleProg(char(gmSEQ.name), ch);


ApplyDelays();
