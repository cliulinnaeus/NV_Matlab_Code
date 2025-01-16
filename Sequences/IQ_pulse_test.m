function IQ_pulse_test
global gmSEQ gSG
gSG.bfixedPow = 1;
gSG.bfixedFreq = 1;
gSG.bMod = 'IQ';%set to no modulation
gSG.bModSrc = 'External';

[gmSEQ.ScaleT, gmSEQ.ScaleStr] = GetScale(gmSEQ.To);

T_AfterLaser = 5000;
T_AfterPulse = 5000;
T_initial_wait = T_AfterLaser + gmSEQ.To + T_AfterPulse;


% Pulse Blaster
gmSEQ.CHN(1).PBN = PBDictionary('ctr0');
gmSEQ.CHN(1).NRise = 2;
% gmSEQ.CHN(1).T = [gmSEQ.readout - gmSEQ.CtrGateDur - 1000, ...
%     gmSEQ.readout + T_AfterLaser + gmSEQ.To + T_AfterPulse];
gmSEQ.CHN(1).T = [T_initial_wait, ...
    T_initial_wait + gmSEQ.readout + T_AfterLaser + gmSEQ.To + T_AfterPulse];
gmSEQ.CHN(1).DT = [gmSEQ.CtrGateDur, gmSEQ.CtrGateDur];

T0 = T_initial_wait + gmSEQ.readout + T_AfterLaser;
q = 10;
wait_bwt_pulse = 2*q+10;

gmSEQ.CHN(numel(gmSEQ.CHN) + 1).PBN = PBDictionary('MWSwitch');
gmSEQ.CHN(numel(gmSEQ.CHN)).NRise = 3;
gmSEQ.CHN(numel(gmSEQ.CHN)).T = [T0, T0+gmSEQ.pi+wait_bwt_pulse, T0+gmSEQ.pi+wait_bwt_pulse+gmSEQ.pi+wait_bwt_pulse];
gmSEQ.CHN(numel(gmSEQ.CHN)).DT = [gmSEQ.pi,gmSEQ.pi,gmSEQ.pi];

gmSEQ.CHN(numel(gmSEQ.CHN) + 1).PBN = PBDictionary('+X');
gmSEQ.CHN(numel(gmSEQ.CHN)).NRise = 1;
gmSEQ.CHN(numel(gmSEQ.CHN)).T = T0 - q;
gmSEQ.CHN(numel(gmSEQ.CHN)).DT = gmSEQ.pi+2*q;

gmSEQ.CHN(numel(gmSEQ.CHN) + 1).PBN = PBDictionary('-X');
gmSEQ.CHN(numel(gmSEQ.CHN)).NRise = 1;
gmSEQ.CHN(numel(gmSEQ.CHN)).T = T0+gmSEQ.pi+wait_bwt_pulse - q;
gmSEQ.CHN(numel(gmSEQ.CHN)).DT = gmSEQ.pi+2*q;

gmSEQ.CHN(numel(gmSEQ.CHN) + 1).PBN = PBDictionary('+Y');
gmSEQ.CHN(numel(gmSEQ.CHN)).NRise = 1;
gmSEQ.CHN(numel(gmSEQ.CHN)).T = T0+gmSEQ.pi+wait_bwt_pulse+gmSEQ.pi+wait_bwt_pulse - q;
gmSEQ.CHN(numel(gmSEQ.CHN)).DT = gmSEQ.pi+2*q;

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

ApplyDelays();
