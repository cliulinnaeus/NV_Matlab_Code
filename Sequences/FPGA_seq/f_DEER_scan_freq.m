function f_DEER_scan_freq
global gmSEQ gSG
gSG.bfixedPow = 1;
gSG.bfixedFreq = 1;
gSG.bMod = 'LOL';%set to no modulation
gSG.bModSrc = 'External';

[gmSEQ.ScaleT, gmSEQ.ScaleStr] = GetScale(gmSEQ.To);

tp = gmSEQ.interval;
two_tp = num2str(2 * tp);
tp = num2str(tp);



pre_init_wait = gmSEQ.post_init_wait + gmSEQ.post_MW_wait;


seq_len = round((gmSEQ.halfpi * 2 + gmSEQ.m * 2 + gmSEQ.pi) * 2.6);


T_green_1_start = pre_init_wait;
T_green_2_start = T_green_1_start + gmSEQ.readout + gmSEQ.post_init_wait + gmSEQ.post_MW_wait + seq_len;
T_green_3_start = T_green_2_start + gmSEQ.readout + pre_init_wait + gmSEQ.pi * 3;
T_green_4_start = T_green_3_start + gmSEQ.readout + gmSEQ.post_init_wait + gmSEQ.post_MW_wait + seq_len;



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
gmSEQ.CHN(numel(gmSEQ.CHN)).T = T_green_1_start;
gmSEQ.CHN(numel(gmSEQ.CHN)).DT = T_green_4_start - T_green_1_start;

%fpga trigger
gmSEQ.CHN(numel(gmSEQ.CHN) + 1).PBN = 10;
gmSEQ.CHN(numel(gmSEQ.CHN)).NRise = 1;
gmSEQ.CHN(numel(gmSEQ.CHN)).T = T_green_1_start + gmSEQ.readout + gmSEQ.post_init_wait;
gmSEQ.CHN(numel(gmSEQ.CHN)).DT = 100;

gmSEQ.CHN(numel(gmSEQ.CHN) + 1).PBN = 11;
gmSEQ.CHN(numel(gmSEQ.CHN)).NRise = 1;
gmSEQ.CHN(numel(gmSEQ.CHN)).T = T_green_1_start + gmSEQ.readout + gmSEQ.post_init_wait;
gmSEQ.CHN(numel(gmSEQ.CHN)).DT = 100;



gmSEQ.CHN(numel(gmSEQ.CHN) + 1).PBN = PBDictionary('dummy1');
gmSEQ.CHN(numel(gmSEQ.CHN)).NRise = 2;
gmSEQ.CHN(numel(gmSEQ.CHN)).T = [0, ...
    T_green_4_start + gmSEQ.readout];
gmSEQ.CHN(numel(gmSEQ.CHN)).DT = [100, 100];


uploadSimplePulse('+X', gSG.FPGAFreq7, gSG.FPGAGain7, gmSEQ.pi, 0)
uploadSimplePulse('+Xhalf', gSG.FPGAFreq7, gSG.FPGAGain7, gmSEQ.halfpi, 0)
uploadSimplePulse('-Xhalf', gSG.FPGAFreq7, gSG.FPGAGain7, gmSEQ.halfpi, 180)
uploadSimplePulse('X_DEER', gmSEQ.m, gSG.FPGAGain6, gmSEQ.DEERpi, 0)

wait1 = round((gmSEQ.post_init_wait + gmSEQ.post_MW_wait + gmSEQ.readout) / 2.6);
t1 = round((gmSEQ.pi-gmSEQ.DEERpi)/2);


seq1 = {'+Xhalf', gmSEQ.DEERt, '+X', gmSEQ.DEERt, '+Xhalf', wait1, '+X', wait1, '+Xhalf', gmSEQ.DEERt, '+X', gmSEQ.DEERt, '-Xhalf'};
seq2 = {gmSEQ.halfpi, gmSEQ.DEERt + t1, 'X_DEER', t1 + gmSEQ.DEERt, gmSEQ.halfpi, wait1, gmSEQ.pi, wait1, gmSEQ.halfpi, gmSEQ.DEERt + t1, 'X_DEER', t1 + gmSEQ.DEERt, gmSEQ.halfpi};

ch = complieCHN({seq1, seq2});
uploadSimpleProg('f_DEER_scan_freq', ch);


ApplyDelays();
