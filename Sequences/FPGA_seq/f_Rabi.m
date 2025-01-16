function f_Rabi
global gmSEQ gSG
gSG.bfixedPow = 1;
gSG.bfixedFreq = 1;
gSG.bMod = 'LOL';%set to no modulation
gSG.bModSrc = 'External';

[gmSEQ.ScaleT, gmSEQ.ScaleStr] = GetScale(gmSEQ.To);

T_AfterLaser = 5000;
T_AfterPulse = 2000;
T_initial_wait = T_AfterLaser + gmSEQ.To*3 + T_AfterPulse;
fpga_delay = 700;


% Pulse Blaster
gmSEQ.CHN(1).PBN = PBDictionary('ctr0');
gmSEQ.CHN(1).NRise = 2;
% gmSEQ.CHN(1).T = [gmSEQ.readout - gmSEQ.CtrGateDur - 1000, ...
%     gmSEQ.readout + T_AfterLaser + gmSEQ.To + T_AfterPulse];
gmSEQ.CHN(1).T = [T_initial_wait, ...
    T_initial_wait + gmSEQ.readout + T_AfterLaser + gmSEQ.To + T_AfterPulse];
gmSEQ.CHN(1).DT = [gmSEQ.CtrGateDur, gmSEQ.CtrGateDur];

gmSEQ.CHN(numel(gmSEQ.CHN) + 1).PBN = PBDictionary('MWSwitch');
gmSEQ.CHN(numel(gmSEQ.CHN)).NRise = 1;
gmSEQ.CHN(numel(gmSEQ.CHN)).T = T_initial_wait;
gmSEQ.CHN(numel(gmSEQ.CHN)).DT = gmSEQ.readout*2+T_AfterPulse/2;

%fpga trigger
gmSEQ.CHN(numel(gmSEQ.CHN) + 1).PBN = 10;
gmSEQ.CHN(numel(gmSEQ.CHN)).NRise = 1;
gmSEQ.CHN(numel(gmSEQ.CHN)).T = T_initial_wait + gmSEQ.readout + T_AfterLaser - fpga_delay;
gmSEQ.CHN(numel(gmSEQ.CHN)).DT = 100;

gmSEQ.CHN(numel(gmSEQ.CHN) + 1).PBN = 11;
gmSEQ.CHN(numel(gmSEQ.CHN)).NRise = 1;
gmSEQ.CHN(numel(gmSEQ.CHN)).T = T_initial_wait + gmSEQ.readout + T_AfterLaser - fpga_delay;
gmSEQ.CHN(numel(gmSEQ.CHN)).DT = 100;

gmSEQ.CHN(numel(gmSEQ.CHN) + 1).PBN = PBDictionary('GreenAOM');
gmSEQ.CHN(numel(gmSEQ.CHN)).NRise = 2;
gmSEQ.CHN(numel(gmSEQ.CHN)).T = [T_initial_wait, ...
    T_initial_wait + gmSEQ.readout + T_AfterLaser + gmSEQ.To + T_AfterPulse];
gmSEQ.CHN(numel(gmSEQ.CHN)).DT = [gmSEQ.readout, gmSEQ.readout];

gmSEQ.CHN(numel(gmSEQ.CHN) + 1).PBN = PBDictionary('dummy1');
gmSEQ.CHN(numel(gmSEQ.CHN)).NRise = 2;
gmSEQ.CHN(numel(gmSEQ.CHN)).T = [0, ...
    T_initial_wait + gmSEQ.readout + T_AfterLaser + gmSEQ.To + T_AfterPulse];
gmSEQ.CHN(numel(gmSEQ.CHN)).DT = [1000, 1000];

uploadSimplePulse('+X', gSG.FPGAFreq7, gSG.FPGAGain7, gmSEQ.m, 0)
uploadPeriodicPulse('pX', gSG.FPGAFreq7, 0, 0)
seq1 = {'+X'};
%seq2 = {'pX'};
ch = complieCHN({seq1});
uploadSimpleProg('f_Rabi', ch);


ApplyDelays();
