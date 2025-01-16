function f_FPGA_delay
global gmSEQ gSG
gSG.bfixedPow = 1;
gSG.bfixedFreq = 1;
gSG.bMod = 'LOL';%set to no modulation
gSG.bModSrc = 'External';

[gmSEQ.ScaleT, gmSEQ.ScaleStr] = GetScale(gmSEQ.To);

T_AfterPulse = 1000;
T_initial_wait = 1000;


% Pulse Blaster
gmSEQ.CHN(1).PBN = PBDictionary('MWSwitch');
gmSEQ.CHN(1).NRise = 1;
gmSEQ.CHN(1).T = [T_initial_wait];
gmSEQ.CHN(1).DT = [gmSEQ.readout];

%fpga trigger
gmSEQ.CHN(numel(gmSEQ.CHN) + 1).PBN = 10;
gmSEQ.CHN(numel(gmSEQ.CHN)).NRise = 1;
gmSEQ.CHN(numel(gmSEQ.CHN)).T = T_initial_wait+T_AfterPulse;
gmSEQ.CHN(numel(gmSEQ.CHN)).DT = 100;

gmSEQ.CHN(numel(gmSEQ.CHN) + 1).PBN = 11;
gmSEQ.CHN(numel(gmSEQ.CHN)).NRise = 1;
gmSEQ.CHN(numel(gmSEQ.CHN)).T = T_initial_wait+T_AfterPulse;
gmSEQ.CHN(numel(gmSEQ.CHN)).DT = 100;

gmSEQ.CHN(numel(gmSEQ.CHN) + 1).PBN = PBDictionary('ctr0');
gmSEQ.CHN(numel(gmSEQ.CHN)).NRise = 1;
gmSEQ.CHN(numel(gmSEQ.CHN)).T = T_initial_wait;
gmSEQ.CHN(numel(gmSEQ.CHN)).DT = gmSEQ.readout;

gmSEQ.CHN(numel(gmSEQ.CHN) + 1).PBN = PBDictionary('dummy1');
gmSEQ.CHN(numel(gmSEQ.CHN)).NRise = 2;
gmSEQ.CHN(numel(gmSEQ.CHN)).T = [0, ...
    T_initial_wait+gmSEQ.readout-20];
gmSEQ.CHN(numel(gmSEQ.CHN)).DT = [20, 20];

uploadSimplePulse('+X', gSG.FPGAFreq, gSG.FPGAGain, gmSEQ.pi, 0)
uploadPeriodicPulse('pX', gSG.FPGAFreq, 0, 0)
seq1 = {'+Xhalf'};
seq2 = {'pX'};
ch = complieCHN({seq1,seq2});
uploadSimpleProg('f_FPGA_delay', ch);


ApplyDelays();
