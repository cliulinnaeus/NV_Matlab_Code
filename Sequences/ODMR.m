function ODMR
global gmSEQ gSG
gSG.bfixedPow=1;
gSG.bfixedFreq=0;
gSG.bMod='lol'; 
gSG.bModSrc='External';

gmSEQ.ScaleStr = "GHz";
gmSEQ.ScaleT = 1e-9;


T_AfterLaser = 10000;
T_AfterPulse = 10000;
T_initial_wait = T_AfterLaser + gmSEQ.To + T_AfterPulse;


% Pulse Blaster
gmSEQ.CHN(1).PBN = PBDictionary('ctr0');
gmSEQ.CHN(1).NRise = 2;
gmSEQ.CHN(1).T = [T_initial_wait, ...
    T_initial_wait + gmSEQ.readout + T_AfterLaser + gmSEQ.To + T_AfterPulse];
gmSEQ.CHN(1).DT = [gmSEQ.CtrGateDur, gmSEQ.CtrGateDur];


gmSEQ.CHN(numel(gmSEQ.CHN) + 1).PBN = PBDictionary('MWSwitch');
gmSEQ.CHN(numel(gmSEQ.CHN)).NRise = 1;
gmSEQ.CHN(numel(gmSEQ.CHN)).T = T_initial_wait + gmSEQ.readout + T_AfterLaser;
gmSEQ.CHN(numel(gmSEQ.CHN)).DT = gmSEQ.pi;

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


% delay = 10000; % 1050 or 100000
% afterPulse = 1000;
% if strcmp(gmSEQ.meas,'APD')
%     gmSEQ.CtrGateDur = 1000;
% end
% %%%%% Fixed sequence length %%%%%%
% 
% gmSEQ.CHN(1).PBN=PBDictionary('AOM');
% gmSEQ.CHN(1).NRise=2;
% gmSEQ.CHN(1).T=[0 gmSEQ.readout+delay+gmSEQ.pi+afterPulse];
% gmSEQ.CHN(1).DT=[gmSEQ.readout 5000];
% 
% gmSEQ.CHN(numel(gmSEQ.CHN)+1).PBN=PBDictionary('ctr0');
% gmSEQ.CHN(numel(gmSEQ.CHN)).NRise=2;
% gmSEQ.CHN(numel(gmSEQ.CHN)).T=[gmSEQ.readout-1000-gmSEQ.CtrGateDur, gmSEQ.readout+delay+gmSEQ.pi+afterPulse];
% gmSEQ.CHN(numel(gmSEQ.CHN)).DT=[gmSEQ.CtrGateDur, gmSEQ.CtrGateDur];
% 
% gmSEQ.CHN(numel(gmSEQ.CHN)+1).PBN=PBDictionary('MWSwitch');
% gmSEQ.CHN(numel(gmSEQ.CHN)).NRise=1;
% gmSEQ.CHN(numel(gmSEQ.CHN)).T=[gmSEQ.readout+delay-20];
% gmSEQ.CHN(numel(gmSEQ.CHN)).DT=[gmSEQ.pi];
% 
% gmSEQ.CHN(numel(gmSEQ.CHN)+1).PBN=PBDictionary('dummy1');
% gmSEQ.CHN(numel(gmSEQ.CHN)).NRise=1;
% gmSEQ.CHN(numel(gmSEQ.CHN)).T=0;
% gmSEQ.CHN(numel(gmSEQ.CHN)).DT=100;

ApplyDelays();
