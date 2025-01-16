function f_Corr_T1
global gmSEQ gSG
gSG.bfixedPow = 1;
gSG.bfixedFreq = 1;
gSG.bMod = 'LOL';%set to no modulation
gSG.bModSrc = 'External';

[gmSEQ.ScaleT, gmSEQ.ScaleStr] = GetScale(gmSEQ.To);

tp = gmSEQ.interval;
fpga_delay = 700;

pre_init_wait = gmSEQ.post_init_wait + gmSEQ.post_MW_wait;

seq_len = round((gmSEQ.halfpi*4 + gmSEQ.pi*2 + 4*tp + gmSEQ.m) * 2.6)+1;


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
gmSEQ.CHN(numel(gmSEQ.CHN)).T = T_green_1_start + gmSEQ.readout/2;
gmSEQ.CHN(numel(gmSEQ.CHN)).DT = T_green_4_start - T_green_1_start;

%fpga trigger
gmSEQ.CHN(numel(gmSEQ.CHN) + 1).PBN = 10;
gmSEQ.CHN(numel(gmSEQ.CHN)).NRise = 1;
gmSEQ.CHN(numel(gmSEQ.CHN)).T = T_green_1_start + gmSEQ.readout + gmSEQ.post_init_wait-fpga_delay;
gmSEQ.CHN(numel(gmSEQ.CHN)).DT = 100;

gmSEQ.CHN(numel(gmSEQ.CHN) + 1).PBN = 11;
gmSEQ.CHN(numel(gmSEQ.CHN)).NRise = 1;
gmSEQ.CHN(numel(gmSEQ.CHN)).T = T_green_1_start + gmSEQ.readout + gmSEQ.post_init_wait-fpga_delay;
gmSEQ.CHN(numel(gmSEQ.CHN)).DT = 100;



gmSEQ.CHN(numel(gmSEQ.CHN) + 1).PBN = PBDictionary('dummy1');
gmSEQ.CHN(numel(gmSEQ.CHN)).NRise = 2;
gmSEQ.CHN(numel(gmSEQ.CHN)).T = [0, ...
    T_green_4_start + gmSEQ.readout];
gmSEQ.CHN(numel(gmSEQ.CHN)).DT = [100, 100];



uploadSimplePulse('+X', gSG.FPGAFreq7, gSG.FPGAGain7, gmSEQ.pi, 0)
uploadSimplePulse('+Xhalf', gSG.FPGAFreq7, gSG.FPGAGain7, gmSEQ.halfpi, 0)
uploadSimplePulse('+Yhalf', gSG.FPGAFreq7, gSG.FPGAGain7, gmSEQ.halfpi, 90)
uploadSimplePulse('-Yhalf', gSG.FPGAFreq7, gSG.FPGAGain7, gmSEQ.halfpi, 270)
uploadSimplePulse('-Xhalf', gSG.FPGAFreq7, gSG.FPGAGain7, gmSEQ.halfpi, 180)
uploadSimplePulse('+X_DEER', gSG.FPGAFreq6, gSG.FPGAGain6, gmSEQ.DEERpi, 0)

wait1 = round((gmSEQ.post_init_wait + gmSEQ.post_MW_wait + gmSEQ.readout) / 2.6);
delta_tp = (gmSEQ.pi-gmSEQ.DEERpi)/2;

seq1 = {'+Xhalf',tp,'+X',tp,'+Yhalf',gmSEQ.m,'+Xhalf',tp,'+X',tp,'+Yhalf',...
    wait1,'+X',wait1,...
    '+Xhalf',tp,'+X',tp,'+Yhalf',gmSEQ.m,'+Xhalf',tp,'+X',tp,'+Yhalf'};
seq2 = {gmSEQ.halfpi,tp+delta_tp,'+X_DEER',tp+delta_tp,gmSEQ.halfpi,gmSEQ.m,gmSEQ.halfpi,tp+delta_tp,'+X_DEER',tp+delta_tp,gmSEQ.halfpi,...
    wait1,gmSEQ.pi,wait1,...
    gmSEQ.halfpi,tp+delta_tp,'+X_DEER',tp+delta_tp,gmSEQ.halfpi,gmSEQ.m,gmSEQ.halfpi,tp+delta_tp,'+X_DEER',tp+delta_tp,gmSEQ.halfpi};
ch = complieCHN({seq1,seq2});
uploadSimpleProg(char(gmSEQ.name), ch);


ApplyDelays();
