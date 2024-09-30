function varargout = SequencePool(varargin)
global gmSEQ
if isfield(gmSEQ,'CHN')&& ~isequal(varargin{1},'PBDictionary')
    gmSEQ=rmfield(gmSEQ,'CHN');
end
if isfield(gmSEQ,'bLiO') && ~isequal(varargin{1},'PBDictionary')
    gmSEQ=rmfield(gmSEQ,'bLiO');
end
switch varargin{1}
    case 'PopulateSeq'
        varargout{1} = PopulateSeq();
    case 'CtrGates_4'
        CtrGates_4();
    case 'Test_DAQ'
        Test_DAQ();
    case 'Test_Laser'
        Test_Laser();
    case 'Rabi'
        Rabi();
    case 'Rabi_IQ'
        Rabi_IQ();
    case 'Rabi_fix_MWDutyCycle'
        Rabi_fix_MWDutyCycle()
    case 'Rabi_Raman'
        Rabi_Raman();
    case 'Rabi_SG2'
        Rabi_SG2();
    case 'Scan_Init_time'
        Scan_Init_time();
    case 'Scan_CounterGate_time'
        Scan_CounterGate_time();
    case 'Rabi_TuneDensity'
        Rabi_TuneDensity()
    case 'Test_NV_Polarization'
        Test_NV_Polarization();
    case 'Ramsey'
        Ramsey();
    case 'AOM Delay'
        AOMDelay();
    case 'AOM Delay Green'
        AOMDelay_Green();
    case 'Echo'
        Echo();
    case 'XY8_N'
        XY8_N();
    case 'XY8_N_wDarkRef'
        XY8_N_wDarkRef();
    case 'ESR'
        ESR();
    case 'T1'
        T1();
    case 'T1_S00_S01'
        T1_S00_S01();
    case 'T1_Rb_S00_S01_Rd_newRef'
        T1_Rb_S00_S01_Rd_newRef();
    case 'T1_S00_S01_S10_S11'
        T1_S00_S01_S10_S11();
    case 'T1_S00_R0_S01_R1_fixDutyCycle'
        T1_S00_R0_S01_R1_fixDutyCycle();
    case 'ODMR'
        ODMR();
    case 'ODMR_sweep'
        ODMR_sweep()
    case 'PBDictionary'
        varargout{1}=PBDictionary(varargin{2});
    case 'CtrDur'
        CtrDur();
    case 'CtrDelay'
        CtrDelay();
    case 'Pulsed ESR'
        PESR();
    case 'SCC_scan_orange'
        SCC_scan_orange();
    case 'SCC_scan_orange_with_MW'
        SCC_scan_orange_with_MW();        
    case 'SCC_scan_orange_both'
        SCC_scan_orange_both();
    case 'SCC_charge_readout'
        SCC_charge_readout();
    case 'SCC_charge_readout_TimeTagger'
        SCC_charge_readout_TimeTagger();
    case 'SCC_spin_state_test'
        SCC_spin_state_test()
    case 'SCC_spin_state_test_with_shelf'
        SCC_spin_state_test_with_shelf()
    case 'SCC_spin_state_test_with_shelf_MultiCounters'
        SCC_spin_state_test_with_shelf_MultiCounters()
    case 'SCC_GreenInit_OrangeRead'
        SCC_GreenInit_OrangeRead()
    case 'Select Sequence'
        return
        
end

function StrL = PopulateSeq
% Here I only put the sequence which is frequently used.

StrL{1} = 'Select Sequence';

StrL{numel(StrL)+1}='ESR';
StrL{numel(StrL)+1}='ODMR';
StrL{numel(StrL)+1}='ODMR_sweep';

StrL{numel(StrL)+1}='Rabi';
StrL{numel(StrL)+1}='Rabi_IQ';
StrL{numel(StrL)+1}='Rabi_fix_MWDutyCycle';

StrL{numel(StrL)+1}='Echo';
StrL{numel(StrL)+1}='Ramsey';
StrL{numel(StrL)+1}='XY8_N';
StrL{numel(StrL)+1}='XY8_N_wDarkRef';

StrL{numel(StrL)+1}='--------------------T1--------------------';
StrL{numel(StrL)+1}='T1';
StrL{numel(StrL)+1}='T1_S00_S01';
StrL{numel(StrL)+1}='T1_Rb_S00_S01_Rd_newRef';
StrL{numel(StrL)+1}='T1_S00_R0_S01_R1_fixDutyCycle';
StrL{numel(StrL)+1}='T1_S00_S01_S10_S11';

StrL{numel(StrL)+1}='--------------------SCC--------------------';
StrL{numel(StrL)+1}='SCC_scan_orange';
StrL{numel(StrL)+1}='SCC_scan_orange_with_MW';
StrL{numel(StrL)+1}='SCC_scan_orange_both';
StrL{numel(StrL)+1}='SCC_charge_readout';
StrL{numel(StrL)+1}='SCC_charge_readout_TimeTagger';
StrL{numel(StrL)+1}='SCC_GreenInit_OrangeRead';
StrL{numel(StrL)+1}='SCC_spin_state_test';
StrL{numel(StrL)+1}='SCC_spin_state_test_with_shelf';
StrL{numel(StrL)+1}='SCC_spin_state_test_with_shelf_MultiCounters';

StrL{numel(StrL)+1}='--------------------Testing--------------------';
StrL{numel(StrL)+1}='CtrGates_4';
StrL{numel(StrL)+1}='Test_DAQ';
StrL{numel(StrL)+1}='Test_Laser';
StrL{numel(StrL)+1}='AOM Delay';
StrL{numel(StrL)+1}='AOM Delay Green';
StrL{numel(StrL)+1}='Scan_Init_time';
StrL{numel(StrL)+1}='Scan_CounterGate_time';
StrL{numel(StrL)+1}='CtrDur';
StrL{numel(StrL)+1}='CtrDelay';

function Scan_CounterGate_time
global gmSEQ gSG
gSG.bfixedPow = 1;
gSG.bfixedFreq = 1;
gSG.bMod = 'LOL';%set to no modulation
gSG.bModSrc = 'External';

[gmSEQ.ScaleT, gmSEQ.ScaleStr] = GetScale(gmSEQ.pi);

T_AfterLaser = 10000;
T_AfterPulse = 10000;
T_initial_wait = T_AfterLaser + gmSEQ.pi + T_AfterPulse;


% Pulse Blaster
gmSEQ.CHN(1).PBN = PBDictionary('ctr0');
gmSEQ.CHN(1).NRise = 2;
gmSEQ.CHN(1).T = [T_initial_wait, ...
    T_initial_wait + T_AfterLaser + gmSEQ.pi + T_AfterPulse+gmSEQ.readout];
gmSEQ.CHN(1).DT = [gmSEQ.m, gmSEQ.m];

gmSEQ.CHN(numel(gmSEQ.CHN) + 1).PBN = PBDictionary('MWSwitch');
gmSEQ.CHN(numel(gmSEQ.CHN)).NRise = 1;
gmSEQ.CHN(numel(gmSEQ.CHN)).T = T_initial_wait + T_AfterLaser+gmSEQ.readout;
gmSEQ.CHN(numel(gmSEQ.CHN)).DT = gmSEQ.pi;

gmSEQ.CHN(numel(gmSEQ.CHN) + 1).PBN = PBDictionary('GreenAOM');
gmSEQ.CHN(numel(gmSEQ.CHN)).NRise = 2;
gmSEQ.CHN(numel(gmSEQ.CHN)).T = [T_initial_wait, ...
    T_initial_wait + T_AfterLaser + gmSEQ.pi + T_AfterPulse+gmSEQ.readout];
gmSEQ.CHN(numel(gmSEQ.CHN)).DT = [gmSEQ.readout, gmSEQ.readout];

gmSEQ.CHN(numel(gmSEQ.CHN) + 1).PBN = PBDictionary('dummy1');
gmSEQ.CHN(numel(gmSEQ.CHN)).NRise = 2;
gmSEQ.CHN(numel(gmSEQ.CHN)).T = [0, ...
    T_initial_wait + T_AfterLaser + gmSEQ.pi + T_AfterPulse+gmSEQ.readout*2];
gmSEQ.CHN(numel(gmSEQ.CHN)).DT = [100, 100];

ApplyDelays();

function Rabi_Raman
global gmSEQ gSG gSG2
gSG.bfixedPow = 1;
gSG.bfixedFreq = 1;
gSG.bMod = 'IQ'; 
gSG.bModSrc = 'External';
Wait_p = 2000;
T_AfterLaser = 2000;
T_AfterPulse = 1000; % FUCK Yuanqi
MWBuffer = 10; 
PulseGap = 80;

gSG2.bMod='IQ';
gSG2.bModSrc='External';
SignalGeneratorFunctionPool2('SetMod');
SignalGeneratorFunctionPool2('WritePow');
SignalGeneratorFunctionPool2('WriteFreq');
gSG2.bOn=1; SignalGeneratorFunctionPool2('RFOnOff');

gmSEQ.bRaman = 1;

[gmSEQ.ScaleT, gmSEQ.ScaleStr] = GetScale(gmSEQ.To);

if strcmp(gmSEQ.meas,'APD') % If PL signal is collected via APD.
    gmSEQ.CtrGateDur = 1000;
end

% Pulse Blaster
gmSEQ.CHN(1).PBN = PBDictionary('ctr0');
gmSEQ.CHN(1).NRise = 2;
gmSEQ.CHN(1).T = [Wait_p + gmSEQ.readout - gmSEQ.CtrGateDur - 1000, ...
    Wait_p + gmSEQ.readout + T_AfterLaser + gmSEQ.DEERpi + PulseGap + gmSEQ.pi + PulseGap + gmSEQ.m + PulseGap + gmSEQ.pi + T_AfterPulse];
gmSEQ.CHN(1).DT = [gmSEQ.CtrGateDur, gmSEQ.CtrGateDur];

gmSEQ.CHN(numel(gmSEQ.CHN) + 1).PBN = PBDictionary('MWSwitch');
gmSEQ.CHN(numel(gmSEQ.CHN)).NRise = 3;
gmSEQ.CHN(numel(gmSEQ.CHN)).T = [Wait_p + gmSEQ.readout + T_AfterLaser + gmSEQ.DEERpi + PulseGap - MWBuffer, ... 
    Wait_p + gmSEQ.readout + T_AfterLaser + gmSEQ.DEERpi + PulseGap + gmSEQ.pi + PulseGap - MWBuffer, ...
    Wait_p + gmSEQ.readout + T_AfterLaser + gmSEQ.DEERpi + PulseGap  + gmSEQ.pi + PulseGap + gmSEQ.m + PulseGap - MWBuffer];
gmSEQ.CHN(numel(gmSEQ.CHN)).DT = [gmSEQ.pi + 2*MWBuffer, gmSEQ.m + 2*MWBuffer, gmSEQ.pi + 2*MWBuffer];

gmSEQ.CHN(numel(gmSEQ.CHN) + 1).PBN = PBDictionary('MWSwitch2');
gmSEQ.CHN(numel(gmSEQ.CHN)).NRise = 1;
gmSEQ.CHN(numel(gmSEQ.CHN)).T = [Wait_p + gmSEQ.readout + T_AfterLaser  - MWBuffer];
gmSEQ.CHN(numel(gmSEQ.CHN)).DT = [gmSEQ.DEERpi + 2*MWBuffer];

gmSEQ.CHN(numel(gmSEQ.CHN) + 1).PBN = PBDictionary('GreenAOM');
gmSEQ.CHN(numel(gmSEQ.CHN)).NRise = 2;
gmSEQ.CHN(numel(gmSEQ.CHN)).T = [Wait_p, ...
    Wait_p + gmSEQ.readout + T_AfterLaser + gmSEQ.DEERpi + PulseGap + gmSEQ.pi + PulseGap + gmSEQ.m + PulseGap + gmSEQ.pi + T_AfterPulse];
gmSEQ.CHN(numel(gmSEQ.CHN)).DT = [gmSEQ.readout, 5000];

gmSEQ.CHN(numel(gmSEQ.CHN) + 1).PBN = PBDictionary('dummy1');
gmSEQ.CHN(numel(gmSEQ.CHN)).NRise = 2;
gmSEQ.CHN(numel(gmSEQ.CHN)).T = [0, ...
    Wait_p + gmSEQ.readout + T_AfterLaser + gmSEQ.DEERpi + PulseGap + gmSEQ.pi + PulseGap + gmSEQ.m + PulseGap + gmSEQ.pi + T_AfterPulse];
gmSEQ.CHN(numel(gmSEQ.CHN)).DT = [1000, 1000];

gmSEQ.CHN(numel(gmSEQ.CHN) + 1).PBN = PBDictionary('AWGTrig');
gmSEQ.CHN(numel(gmSEQ.CHN)).NRise = 1;
gmSEQ.CHN(numel(gmSEQ.CHN)).T = Wait_p + gmSEQ.readout + T_AfterLaser + gmSEQ.DEERpi + PulseGap;
gmSEQ.CHN(numel(gmSEQ.CHN)).DT = gmSEQ.pi + PulseGap + gmSEQ.m + PulseGap + gmSEQ.pi + 200;

gmSEQ.CHN(numel(gmSEQ.CHN) + 1).PBN = PBDictionary('AWGTrig2');
gmSEQ.CHN(numel(gmSEQ.CHN)).NRise = 1;
gmSEQ.CHN(numel(gmSEQ.CHN)).T = Wait_p + gmSEQ.readout + T_AfterLaser;
gmSEQ.CHN(numel(gmSEQ.CHN)).DT = gmSEQ.DEERpi + 100;

% AWG.
chaseFunctionPool('stopChase', gmSEQ.P1AWG)
chaseFunctionPool('stopChase', gmSEQ.MWAWG)
if ~gSG.ACmodAWG % if we use AWG in AC modulation mode.
    error("AC modulation must be enabled.");
end

WaveForm_1I = [0, gmSEQ.pi, gSG.AWGFreq, 0, gSG.AWGAmp, 0, 0, 0; ...
    gmSEQ.pi + PulseGap, gmSEQ.pi + PulseGap + gmSEQ.m, gmSEQ.SAmp1, 0, gmSEQ.SAmp2, gmSEQ.SAmp1_M, 0, gmSEQ.SAmp2_M; ...
    gmSEQ.pi + PulseGap + gmSEQ.m + PulseGap, gmSEQ.pi + PulseGap + gmSEQ.m + PulseGap + gmSEQ.pi, gSG.AWGFreq, pi, gSG.AWGAmp, 0, 0, 0;];
% WaveForm_1 = [0, gmSEQ.m, gSG.AWGFreq, 0, gSG.AWGAmp, 0, 0, 0];
WaveForm_1Q = WaveForm_1I + repmat([0 0 0 pi/2 0 0 -pi/2 0], size(WaveForm_1I, 1), 1);
WaveForm_1Length = ceil((gmSEQ.pi + PulseGap + gmSEQ.m + PulseGap + gmSEQ.pi + 1000) / (16/gSG.AWGClockRate)) * (16/gSG.AWGClockRate);
WaveForm_1PointNum = WaveForm_1Length*gSG.AWGClockRate;

WaveForm_2I = [0, gmSEQ.DEERpi, gSG2.AWGFreq, 0, gSG2.AWGAmp, 0, 0, 0;]; % Careful! In this Raman pulse, the frequency of the final MW output should be carefully calibrated
WaveForm_2Q = WaveForm_2I + repmat([0 0 0 -pi/2 0 0 0 0], size(WaveForm_2I, 1), 1);
WaveForm_2Length = ceil((gmSEQ.DEERpi + 1000) / (16/gSG2.P1AWGClockRate)) * (16/gSG2.P1AWGClockRate);
WaveForm_2PointNum = WaveForm_2Length*gSG2.P1AWGClockRate;

chaseFunctionPool('createWaveform', WaveForm_1I, ...
    gSG.AWGClockRate, WaveForm_1Length, 'Rabi_Ch1.txt')
chaseFunctionPool('createWaveform', WaveForm_1Q,...
    gSG.AWGClockRate, WaveForm_1Length, 'Rabi_Ch2.txt')
chaseFunctionPool('createWaveform', WaveForm_2I, ...
    gSG2.P1AWGClockRate, WaveForm_2Length, 'Rabi_Ch3.txt')
chaseFunctionPool('createWaveform', WaveForm_2Q,...
    gSG2.P1AWGClockRate, WaveForm_2Length, 'Rabi_Ch4.txt')

chaseFunctionPool('CreateSingleSegment', gmSEQ.MWAWG, 1, ...
    WaveForm_1PointNum, 1, 2047, 2047, 'Rabi_Ch1.txt', 1); 
pause(1.0);
chaseFunctionPool('CreateSingleSegment', gmSEQ.MWAWG, 2, ...
    WaveForm_1PointNum, 1, 2047, 2047, 'Rabi_Ch2.txt', 1);
pause(1.0);
chaseFunctionPool('CreateSingleSegment', gmSEQ.P1AWG, 1, ...
    WaveForm_2PointNum, 1, 2047, 2047, 'Rabi_Ch3.txt', 1); 
pause(1.0);
chaseFunctionPool('CreateSingleSegment', gmSEQ.P1AWG, 2, ...
    WaveForm_2PointNum, 1, 2047, 2047, 'Rabi_Ch4.txt', 1);
pause(1.0);

chaseFunctionPool('runChase', gmSEQ.MWAWG, 'false'); pause(0.5);
chaseFunctionPool('runChase', gmSEQ.P1AWG, 'false');
ApplyDelays();

function Rabi_SG2
global gmSEQ gSG
gSG.bfixedPow = 1;
gSG.bfixedFreq = 1;
gSG.bMod = 'LOL';%set to no modulation
gSG.bModSrc = 'External';

[gmSEQ.ScaleT, gmSEQ.ScaleStr] = GetScale(gmSEQ.To);

T_AfterLaser = 2000;
T_AfterPulse = 1000;
T_initial_wait = T_AfterLaser + gmSEQ.To + T_AfterPulse;


% Pulse Blaster
gmSEQ.CHN(1).PBN = PBDictionary('ctr0');
gmSEQ.CHN(1).NRise = 2;
% gmSEQ.CHN(1).T = [gmSEQ.readout - gmSEQ.CtrGateDur - 1000, ...
%     gmSEQ.readout + T_AfterLaser + gmSEQ.To + T_AfterPulse];
gmSEQ.CHN(1).T = [T_initial_wait, ...
    T_initial_wait + gmSEQ.readout + T_AfterLaser + gmSEQ.To + T_AfterPulse];
gmSEQ.CHN(1).DT = [gmSEQ.CtrGateDur, gmSEQ.CtrGateDur];

% gmSEQ.CHN(1).PBN = PBDictionary('ctr0');
% gmSEQ.CHN(1).NRise = 2;
% % gmSEQ.CHN(1).T = [gmSEQ.readout + T_AfterLaser + gmSEQ.To + T_AfterPulse];
% gmSEQ.CHN(1).T = [gmSEQ.readout - , gmSEQ.readout - 1500];
% gmSEQ.CHN(1).DT = [gmSEQ.CtrGateDur, gmSEQ.CtrGateDur];

gmSEQ.CHN(numel(gmSEQ.CHN) + 1).PBN = PBDictionary('MWSwitch');
gmSEQ.CHN(numel(gmSEQ.CHN)).NRise = 1;
gmSEQ.CHN(numel(gmSEQ.CHN)).T = T_initial_wait + gmSEQ.readout + T_AfterLaser-20;
gmSEQ.CHN(numel(gmSEQ.CHN)).DT = gmSEQ.m+40;

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

function CtrGates_4
global gmSEQ gSG
gSG.bfixedPow = 1;
gSG.bfixedFreq = 1;
gSG.bMod = 'IQ';
gSG.bModSrc = 'External';

%SignalGeneratorFunctionPool('WritePow');
%SignalGeneratorFunctionPool('WriteFreq');
%gSG.bOn=1; SignalGeneratorFunctionPool('RFOnOff');

T_AfterLaser = 1000;
T_AfterPulse = 2000;

[gmSEQ.ScaleT, gmSEQ.ScaleStr] = GetScale(gmSEQ.To);

Wait = 2e3;

% Pulse Blaster
gmSEQ.CHN(1).PBN = PBDictionary('ctr0');
gmSEQ.CHN(1).NRise = 2;
gmSEQ.CHN(1).T = [2*Wait,3*Wait];
gmSEQ.CHN(1).DT = [gmSEQ.CtrGateDur,gmSEQ.CtrGateDur];

% gmSEQ.CHN(numel(gmSEQ.CHN) + 1).PBN = PBDictionary('MWSwitch');
% gmSEQ.CHN(numel(gmSEQ.CHN)).NRise = 1;
% gmSEQ.CHN(numel(gmSEQ.CHN)).T = Wait + gmSEQ.readout + T_AfterLaser - 20;
% gmSEQ.CHN(numel(gmSEQ.CHN)).DT = gmSEQ.m + 40;

gmSEQ.CHN(numel(gmSEQ.CHN) + 1).PBN = PBDictionary('MWSwitch2');
gmSEQ.CHN(numel(gmSEQ.CHN)).NRise = 6;
gmSEQ.CHN(numel(gmSEQ.CHN)).T = [0];
gmSEQ.CHN(numel(gmSEQ.CHN)).DT = [Wait + gmSEQ.readout + T_AfterLaser + T_AfterPulse + 10000];


gmSEQ.CHN(numel(gmSEQ.CHN) + 1).PBN = PBDictionary('dummy1');
gmSEQ.CHN(numel(gmSEQ.CHN)).NRise = 2;
gmSEQ.CHN(numel(gmSEQ.CHN)).T = [0, ...
    Wait + gmSEQ.readout + T_AfterLaser + T_AfterPulse + 8000];
gmSEQ.CHN(numel(gmSEQ.CHN)).DT = [1000, 1000];
ApplyDelays();

function Test_DAQ
global gmSEQ gSG
gSG.bfixedPow = 1;
gSG.bfixedFreq = 1;
gSG.bMod = 'IQ';
gSG.bModSrc = 'External';

T_AfterLaser = 1000;
T_AfterPulse = 2000;

[gmSEQ.ScaleT, gmSEQ.ScaleStr] = GetScale(gmSEQ.To);

i = gmSEQ.readout; 
r = gmSEQ.CtrGateDur;
p = gmSEQ.pi;
m = gmSEQ.m;
To = gmSEQ.To;
l = 50;
b = 100;

% Pulse Blaster
gmSEQ.CHN(1).PBN = PBDictionary('ctr0');
gmSEQ.CHN(1).NRise = 2;
T = [i,i];
DT = [r,r];
ConstructSeq(T,DT)

gmSEQ.CHN(numel(gmSEQ.CHN) + 1).PBN = 3;
gmSEQ.CHN(numel(gmSEQ.CHN)).NRise = 6;
T = [m,r-l,b,i-2*l-b,b,b];
DT = [l,l,l,l,l,l];
ConstructSeq(T,DT)


gmSEQ.CHN(numel(gmSEQ.CHN) + 1).PBN = PBDictionary('dummy1');
gmSEQ.CHN(numel(gmSEQ.CHN)).NRise = 2;
gmSEQ.CHN(numel(gmSEQ.CHN)).T = [0,2*i+2*r];
gmSEQ.CHN(numel(gmSEQ.CHN)).DT = [100, 100];
ApplyNoDelays();

function Test_Laser
global gmSEQ gSG
gSG.bfixedPow=1;
gSG.bfixedFreq=1;
gSG.bMod='IQ';
gSG.bModSrc='External';

[gmSEQ.ScaleT, gmSEQ.ScaleStr] = GetScale(gmSEQ.To);

if strcmp(gmSEQ.meas,'APD')
    gmSEQ.CtrGateDur = 1000;
end
d = 1000; %AfterLaser
u = 100; %AfterPulse
w = 1e3; %initial wait
i = gmSEQ.readout; 
r = gmSEQ.CtrGateDur;
re = 100; %extra laser on time for readout
rl = r+re; %total laser on time for readout
p = gmSEQ.pi;
m = gmSEQ.m;

% gmSEQ.CHN(1).PBN=PBDictionary('ctr0');
% gmSEQ.CHN(1).NRise=3;
% T=[w,d+m,i-m+d];
% DT=[r,r,r];
% ConstructSeq(T,DT)
% 
% gmSEQ.CHN(numel(gmSEQ.CHN)+1).PBN=PBDictionary('AOM');
% gmSEQ.CHN(numel(gmSEQ.CHN)).NRise=3;
% T=[w,d+m-600,i-m+d-600];
% DT=[r+600,r+600,r];
% ConstructSeq(T,DT)
% 
% gmSEQ.CHN(numel(gmSEQ.CHN)+1).PBN=PBDictionary('dummy1');
% gmSEQ.CHN(numel(gmSEQ.CHN)).NRise=2;
% T=[0 w+r+r+i+d+d];
% DT=[20 20];
% ConstructSeq(T,DT)

gmSEQ.CHN(1).PBN=PBDictionary('ctr0');
gmSEQ.CHN(1).NRise=1;
T=[w];
DT=[r];
ConstructSeq(T,DT)

gmSEQ.CHN(numel(gmSEQ.CHN)+1).PBN=PBDictionary('GreenAOM');
gmSEQ.CHN(numel(gmSEQ.CHN)).NRise=1;
T=[w,gmSEQ.To-m];
DT=[m];
ConstructSeq(T,DT)

gmSEQ.CHN(numel(gmSEQ.CHN)+1).PBN=PBDictionary('dummy1');
gmSEQ.CHN(numel(gmSEQ.CHN)).NRise=2;
T=[0 w+gmSEQ.To];
DT=[20 20];
ConstructSeq(T,DT)


ApplyDelays();

function Rabi_TuneDensity
global gmSEQ gSG gSG3
gSG.bfixedPow = 1;
gSG.bfixedFreq = 1;
gSG.bMod = 'IQ';
gSG.bModSrc = 'External';

gSG3.bMod='IQ';
gSG3.bModSrc='External';
SignalGeneratorFunctionPool3('SetMod');
SignalGeneratorFunctionPool3('WritePow');
SignalGeneratorFunctionPool3('WriteFreq');
gSG3.bOn=1; SignalGeneratorFunctionPool3('RFOnOff');

T_AfterLaser = 2000;
T_AfterPulse = 1000; % FUCK Yuanqi
T_Depol = 10000;

[gmSEQ.ScaleT, gmSEQ.ScaleStr] = GetScale(gmSEQ.To);

if strcmp(gmSEQ.meas,'APD') % If PL signal is collected via APD.
    gmSEQ.CtrGateDur = 1000;
end

% Pulse Blaster
gmSEQ.CHN(1).PBN = PBDictionary('ctr0');
gmSEQ.CHN(1).NRise = 2;
gmSEQ.CHN(1).T = [gmSEQ.readout - gmSEQ.CtrGateDur - 1000, ...
    gmSEQ.readout + T_AfterLaser + gmSEQ.DEERt + T_Depol + gmSEQ.To + T_AfterPulse];
gmSEQ.CHN(1).DT = [gmSEQ.CtrGateDur, gmSEQ.CtrGateDur];

gmSEQ.CHN(numel(gmSEQ.CHN) + 1).PBN = PBDictionary('GreenAOM');
gmSEQ.CHN(numel(gmSEQ.CHN)).NRise = 2;
gmSEQ.CHN(numel(gmSEQ.CHN)).T = [0, ...
    gmSEQ.readout + T_AfterLaser + gmSEQ.DEERt + T_Depol + gmSEQ.To + T_AfterPulse];
gmSEQ.CHN(numel(gmSEQ.CHN)).DT = [gmSEQ.readout, 5000];

gmSEQ.CHN(numel(gmSEQ.CHN) + 1).PBN = PBDictionary('AWGTrig3');
gmSEQ.CHN(numel(gmSEQ.CHN)).NRise = 1;
gmSEQ.CHN(numel(gmSEQ.CHN)).T = gmSEQ.readout + T_AfterLaser;
gmSEQ.CHN(numel(gmSEQ.CHN)).DT = 1000;

gmSEQ.CHN(numel(gmSEQ.CHN) + 1).PBN = PBDictionary('MWSwitch3');
gmSEQ.CHN(numel(gmSEQ.CHN)).NRise = 1;
gmSEQ.CHN(numel(gmSEQ.CHN)).T = gmSEQ.readout + T_AfterLaser - 20;
gmSEQ.CHN(numel(gmSEQ.CHN)).DT = gmSEQ.DEERt + 40;

gmSEQ.CHN(numel(gmSEQ.CHN) + 1).PBN = PBDictionary('AWGTrig');
gmSEQ.CHN(numel(gmSEQ.CHN)).NRise = 1;
gmSEQ.CHN(numel(gmSEQ.CHN)).T = gmSEQ.readout + T_AfterLaser + gmSEQ.DEERt + T_Depol;
gmSEQ.CHN(numel(gmSEQ.CHN)).DT = 1000;

gmSEQ.CHN(numel(gmSEQ.CHN) + 1).PBN = PBDictionary('MWSwitch');
gmSEQ.CHN(numel(gmSEQ.CHN)).NRise = 1;
gmSEQ.CHN(numel(gmSEQ.CHN)).T = gmSEQ.readout + T_AfterLaser + gmSEQ.DEERt + T_Depol - 20;
gmSEQ.CHN(numel(gmSEQ.CHN)).DT = gmSEQ.m + 40;

gmSEQ.CHN(numel(gmSEQ.CHN) + 1).PBN = PBDictionary('dummy1');
gmSEQ.CHN(numel(gmSEQ.CHN)).NRise = 2;
gmSEQ.CHN(numel(gmSEQ.CHN)).T = [0, ...
    gmSEQ.readout + T_AfterLaser + gmSEQ.DEERt + T_Depol + gmSEQ.To + T_AfterPulse];
gmSEQ.CHN(numel(gmSEQ.CHN)).DT = [1000, 1000];

% AWG.
chaseFunctionPool('stopChase', gmSEQ.MWAWG)
chaseFunctionPool('stopChase', gmSEQ.MWAWG2)
if ~gSG.ACmodAWG % if we use AWG in AC modulation mode.
    gSG.AWGFreq = 0;
    gSG3.AWGFreq = 0;
end
WaveForm_1I = [0, gmSEQ.m, gSG.AWGFreq, 0*pi+0, gSG.AWGAmp];
WaveForm_1Q = [0, gmSEQ.m, gSG.AWGFreq, 0*pi-pi/2, gSG.AWGAmp];
WaveForm_1Length = ceil((gmSEQ.m + 1000) / (16/gSG.AWGClockRate)) * (16/gSG.AWGClockRate);
WaveForm_1PointNum = WaveForm_1Length*gSG.AWGClockRate;

WaveForm_2I = [0, gmSEQ.DEERt, gSG3.AWGFreq, 0*pi+0, gSG3.AWGAmp];
WaveForm_2Q = [0, gmSEQ.DEERt, gSG3.AWGFreq, 0*pi-pi/2, gSG3.AWGAmp];
WaveForm_2Length = ceil((gmSEQ.DEERt + 1000) / (16/gSG3.AWGClockRate)) * (16/gSG3.AWGClockRate);
WaveForm_2PointNum = WaveForm_2Length*gSG3.AWGClockRate;

chaseFunctionPool('createWaveform', WaveForm_1I, gSG.AWGClockRate, WaveForm_1Length, 'Rabi_Ch1.txt')
chaseFunctionPool('createWaveform', WaveForm_1Q, gSG.AWGClockRate, WaveForm_1Length, 'Rabi_Ch2.txt')
chaseFunctionPool('createWaveform', WaveForm_2I, gSG3.AWGClockRate, WaveForm_2Length, 'Rabi_TuneDensity_Ch1.txt')
chaseFunctionPool('createWaveform', WaveForm_2Q, gSG3.AWGClockRate, WaveForm_2Length, 'Rabi_TuneDensity_Ch2.txt')

chaseFunctionPool('CreateSingleSegment', gmSEQ.MWAWG, 1, WaveForm_1PointNum, 1, 2047, 2047, 'Rabi_Ch1.txt', 1); pause(1.0);
chaseFunctionPool('CreateSingleSegment', gmSEQ.MWAWG, 2, WaveForm_1PointNum, 1, 2047, 2047, 'Rabi_Ch2.txt', 1); pause(1.0);
chaseFunctionPool('CreateSingleSegment', gmSEQ.MWAWG2, 1, WaveForm_2PointNum, 1, 2047, 2047, 'Rabi_TuneDensity_Ch1.txt', 1); pause(1.0);
chaseFunctionPool('CreateSingleSegment', gmSEQ.MWAWG2, 2, WaveForm_2PointNum, 1, 2047, 2047, 'Rabi_TuneDensity_Ch2.txt', 1); pause(1.0);

chaseFunctionPool('runChase', gmSEQ.MWAWG, 'false'); pause(0.5)
chaseFunctionPool('runChase', gmSEQ.MWAWG2, 'false');
ApplyDelays();

function Test_NV_Polarization
global gmSEQ gSG
gSG.bfixedPow = 1;
gSG.bfixedFreq = 1;
gSG.bMod = 'IQ';
gSG.bModSrc = 'External';
T_AfterLaser = 0.1e6;
T_AfterPulse = 1000;
Wait_T = 0.5e6;

if strcmp(gmSEQ.meas,'APD') % If PL signal is collected via APD.
    gmSEQ.CtrGateDur = 1000;
end

% Pulse Blaster

SigD_start = gmSEQ.m+T_AfterLaser+gmSEQ.pi+T_AfterPulse+gmSEQ.readout+Wait_T;
gmSEQ.CHN(1).PBN = PBDictionary('ctr0');
gmSEQ.CHN(1).NRise = 4;
gmSEQ.CHN(1).T = [gmSEQ.m+T_AfterLaser+gmSEQ.pi+T_AfterPulse ...
    gmSEQ.m+T_AfterLaser+gmSEQ.pi+T_AfterPulse+gmSEQ.readout-gmSEQ.CtrGateDur-1000 ...
    SigD_start+gmSEQ.m+T_AfterLaser+gmSEQ.pi+T_AfterPulse ...
    SigD_start+gmSEQ.m+T_AfterLaser+gmSEQ.pi+T_AfterPulse+gmSEQ.readout-gmSEQ.CtrGateDur-1000];
gmSEQ.CHN(1).DT = [gmSEQ.CtrGateDur, gmSEQ.CtrGateDur gmSEQ.CtrGateDur gmSEQ.CtrGateDur];

gmSEQ.CHN(numel(gmSEQ.CHN) + 1).PBN = PBDictionary('MWSwitch');
gmSEQ.CHN(numel(gmSEQ.CHN)).NRise = 5;
gmSEQ.CHN(numel(gmSEQ.CHN)).T = [gmSEQ.m+T_AfterLaser+gmSEQ.pi+T_AfterPulse+gmSEQ.readout+T_AfterLaser-20 ...
    gmSEQ.m+T_AfterLaser+gmSEQ.pi+T_AfterPulse+gmSEQ.readout+T_AfterLaser+T_AfterLaser-20 ...
    SigD_start+gmSEQ.m+T_AfterLaser-20 ...
    SigD_start+gmSEQ.m+T_AfterLaser+gmSEQ.pi+gmSEQ.readout+T_AfterLaser-20 ...
    SigD_start+gmSEQ.m+T_AfterLaser+gmSEQ.pi+gmSEQ.readout+T_AfterLaser+T_AfterLaser-20];
gmSEQ.CHN(numel(gmSEQ.CHN)).DT = [gmSEQ.pi/2+32, gmSEQ.pi/2+32, gmSEQ.pi+32, gmSEQ.pi/2+32, gmSEQ.pi/2+32];

gmSEQ.CHN(numel(gmSEQ.CHN) + 1).PBN = PBDictionary('GreenAOM');
gmSEQ.CHN(numel(gmSEQ.CHN)).NRise = 4;
gmSEQ.CHN(numel(gmSEQ.CHN)).T = [0, ...
    gmSEQ.m+T_AfterLaser+gmSEQ.pi+T_AfterPulse, ...
    SigD_start, ...
    SigD_start+gmSEQ.m+T_AfterLaser+gmSEQ.pi+T_AfterPulse];
gmSEQ.CHN(numel(gmSEQ.CHN)).DT = [gmSEQ.m gmSEQ.readout gmSEQ.m gmSEQ.readout];

gmSEQ.CHN(numel(gmSEQ.CHN) + 1).PBN = PBDictionary('dummy1');
gmSEQ.CHN(numel(gmSEQ.CHN)).NRise = 2;
gmSEQ.CHN(numel(gmSEQ.CHN)).T = [0, ...
    (gmSEQ.m+T_AfterLaser+gmSEQ.pi+T_AfterPulse+gmSEQ.readout+Wait_T)*2-200];
gmSEQ.CHN(numel(gmSEQ.CHN)).DT = [200, 200];

gmSEQ.CHN(numel(gmSEQ.CHN) + 1).PBN = PBDictionary('AWGTrig');
gmSEQ.CHN(numel(gmSEQ.CHN)).NRise = 5;
gmSEQ.CHN(numel(gmSEQ.CHN)).T = [gmSEQ.m+T_AfterLaser+gmSEQ.pi+T_AfterPulse+gmSEQ.readout+T_AfterLaser ...
    gmSEQ.m+T_AfterLaser+gmSEQ.pi+T_AfterPulse+gmSEQ.readout+T_AfterLaser+T_AfterLaser ...
    SigD_start+gmSEQ.m+T_AfterLaser ...
    SigD_start+gmSEQ.m+T_AfterLaser+gmSEQ.pi+gmSEQ.readout+T_AfterLaser ...
    SigD_start+gmSEQ.m+T_AfterLaser+gmSEQ.pi+gmSEQ.readout+T_AfterLaser+T_AfterLaser];
gmSEQ.CHN(numel(gmSEQ.CHN)).DT = [1000 1000 1000 1000 1000];

% AWG.
% WaveForm_Length = ceil((gmSEQ.m + 1000) * gSG.AWGClockRate / 16) * 16;
WaveForm_Length = ceil((gmSEQ.pi + 1000) / (16/gSG.AWGClockRate)) * (16/gSG.AWGClockRate);
WaveForm_PointNum = WaveForm_Length*gSG.AWGClockRate;

chaseFunctionPool('stopChase', 1)
if gSG.ACmodAWG % if we use AWG in AC modulation mode.
    WaveForm_1I = [0, gmSEQ.pi/2, gSG.AWGFreq, 0, gSG.AWGAmp];
    WaveForm_1Q = [0, gmSEQ.pi/2, gSG.AWGFreq, -pi/2, gSG.AWGAmp];
    WaveForm_2I = [0, gmSEQ.pi, gSG.AWGFreq, 0, gSG.AWGAmp];
    WaveForm_2Q = [0, gmSEQ.pi, gSG.AWGFreq, -pi/2, gSG.AWGAmp];
else
    WaveForm_1I = [0, gmSEQ.pi/2, gSG.AWGAmp];
    WaveForm_1Q = [0, gmSEQ.pi/2, 0];
    WaveForm_2I = [0, gmSEQ.pi, gSG.AWGAmp];
    WaveForm_2Q = [0, gmSEQ.pi, 0];
end

chaseFunctionPool('createWaveform', WaveForm_1I, ...
    gSG.AWGClockRate, WaveForm_Length, 'TestNVPol_I_Seg1.txt');
chaseFunctionPool('createWaveform', WaveForm_1Q, ...
    gSG.AWGClockRate, WaveForm_Length, 'TestNVPol_Q_Seg1.txt');
chaseFunctionPool('createWaveform', WaveForm_2I, ...
    gSG.AWGClockRate, WaveForm_Length, 'TestNVPol_I_Seg2.txt');
chaseFunctionPool('createWaveform', WaveForm_2Q, ...
    gSG.AWGClockRate, WaveForm_Length, 'TestNVPol_Q_Seg2.txt');

chaseFunctionPool('createSegStruct', 'TestNVPol_SegStruct_I.txt', ...
        'TestNVPol_I_Seg1.txt', WaveForm_PointNum, 1, 1, ...
        'TestNVPol_I_Seg1.txt', WaveForm_PointNum, 1, 1, ...
        'TestNVPol_I_Seg2.txt', WaveForm_PointNum, 1, 1, ...
        'TestNVPol_I_Seg1.txt', WaveForm_PointNum, 1, 1, ...
        'TestNVPol_I_Seg1.txt', WaveForm_PointNum, 1, 1);
    pause(0.5);
chaseFunctionPool('createSegStruct', 'TestNVPol_SegStruct_Q.txt', ...
        'TestNVPol_Q_Seg1.txt', WaveForm_PointNum, 1, 1, ...
        'TestNVPol_Q_Seg1.txt', WaveForm_PointNum, 1, 1, ...
        'TestNVPol_Q_Seg2.txt', WaveForm_PointNum, 1, 1,...
        'TestNVPol_Q_Seg1.txt', WaveForm_PointNum, 1, 1,...
        'TestNVPol_Q_Seg1.txt', WaveForm_PointNum, 1, 1);
    pause(0.5);
    chaseFunctionPool('CreateSegments', 1, 1, ...
        5, ...
        2047, 2047, 'TestNVPol_SegStruct_I.txt', 'false');
    pause(1); % this pause seems to be important, otherwise the loading is not right occassionally
    chaseFunctionPool('CreateSegments', 1, 2, ...
        5, ...
        2047, 2047, 'TestNVPol_SegStruct_Q.txt', 'false');
    pause(1); % this pause seems to be important, otherwise the loading is not right occassionally

chaseFunctionPool('runChase', 1, 'false');
ApplyDelays();

function CtrDur
% Modfied to differential measurement 03/04/2022 Weijie
global gmSEQ gSG
gSG.bfixedPow=1;
gSG.bfixedFreq=1;
gSG.bMod='IQ';
gSG.bModSrc='External';

T_AfterLaser = 2000;
T_AfterPulse = 1000;
Detect_Window = 5000;
Wait = 1000;
Sig_D_start = gmSEQ.readout + T_AfterLaser +gmSEQ.pi + T_AfterPulse + Detect_Window + Wait;

% Pulse Blaster
gmSEQ.CHN(1).PBN = PBDictionary('ctr0');
gmSEQ.CHN(1).NRise = 4;
gmSEQ.CHN(1).T = [gmSEQ.readout - gmSEQ.m - 1000, gmSEQ.readout + T_AfterLaser + gmSEQ.pi + T_AfterPulse, ...
   Sig_D_start + gmSEQ.readout - gmSEQ.m - 1000, Sig_D_start + gmSEQ.readout + T_AfterLaser + gmSEQ.pi + T_AfterPulse];
gmSEQ.CHN(1).DT = [gmSEQ.m, gmSEQ.m, gmSEQ.m, gmSEQ.m];

gmSEQ.CHN(numel(gmSEQ.CHN) + 1).PBN = PBDictionary('MWSwitch');
gmSEQ.CHN(numel(gmSEQ.CHN)).NRise = 1;
gmSEQ.CHN(numel(gmSEQ.CHN)).T = gmSEQ.readout + T_AfterLaser - 20;
gmSEQ.CHN(numel(gmSEQ.CHN)).DT = gmSEQ.pi + 40;

gmSEQ.CHN(numel(gmSEQ.CHN) + 1).PBN = PBDictionary('GreenAOM');
gmSEQ.CHN(numel(gmSEQ.CHN)).NRise = 4;
gmSEQ.CHN(numel(gmSEQ.CHN)).T = [0, gmSEQ.readout + T_AfterLaser + gmSEQ.pi + T_AfterPulse, ...
    Sig_D_start, Sig_D_start + gmSEQ.readout + T_AfterLaser + gmSEQ.pi + T_AfterPulse];
gmSEQ.CHN(numel(gmSEQ.CHN)).DT = [gmSEQ.readout, Detect_Window, gmSEQ.readout, Detect_Window];

gmSEQ.CHN(numel(gmSEQ.CHN) + 1).PBN = PBDictionary('dummy1');
gmSEQ.CHN(numel(gmSEQ.CHN)).NRise = 2;
gmSEQ.CHN(numel(gmSEQ.CHN)).T = [0, ...
    Sig_D_start + gmSEQ.readout + T_AfterLaser + gmSEQ.pi + T_AfterPulse + Detect_Window - 1000];
gmSEQ.CHN(numel(gmSEQ.CHN)).DT = [1000, 1000];

gmSEQ.CHN(numel(gmSEQ.CHN) + 1).PBN = PBDictionary('AWGTrig');
gmSEQ.CHN(numel(gmSEQ.CHN)).NRise = 1;
gmSEQ.CHN(numel(gmSEQ.CHN)).T = gmSEQ.readout + T_AfterLaser;
gmSEQ.CHN(numel(gmSEQ.CHN)).DT = 1000;

% AWG.
WaveForm_Length = ceil((gmSEQ.pi + 1000) / (16/gSG.AWGClockRate)) * (16/gSG.AWGClockRate);
WaveForm_PointNum = WaveForm_Length*gSG.AWGClockRate;

chaseFunctionPool('stopChase', gmSEQ.MWAWG)

if ~gSG.ACmodAWG % in AC modulation mode
    gSG.AWGFreq = 0;
end
    
WaveForm_1 = [0, gmSEQ.pi, gSG.AWGFreq, 0, gSG.AWGAmp];
WaveForm_2 = [0, gmSEQ.pi, gSG.AWGFreq, -pi/2, gSG.AWGAmp];

chaseFunctionPool('createWaveform', WaveForm_1, ...
    gSG.AWGClockRate, WaveForm_Length, 'CtrDur_Ch1.txt')
chaseFunctionPool('createWaveform', ...
    WaveForm_2, gSG.AWGClockRate, WaveForm_Length, 'Rabi_Ch2.txt')
chaseFunctionPool('CreateSingleSegment', gmSEQ.MWAWG, 1, ...
    WaveForm_PointNum, 1, 2047, 2047, 'CtrDur_Ch1.txt', 1); 
pause(1.0);
chaseFunctionPool('CreateSingleSegment', gmSEQ.MWAWG, 2, ...
    WaveForm_PointNum, 1, 2047, 2047, 'CtrDur_Ch2.txt', 1);
pause(1.0);
chaseFunctionPool('runChase', gmSEQ.MWAWG, 'false');

ApplyDelays();

function AOMDelay_Green
global gmSEQ gSG
gSG.bfixedPow=1;
gSG.bfixedFreq=1;
gSG.bMod='LOL';
gSG.bModSrc='External';

if strcmp(gmSEQ.meas,'APD')
    gmSEQ.CtrGateDur = 1000;
end

gmSEQ.CHN(1).PBN=PBDictionary('ctr0');
gmSEQ.CHN(1).NRise=1;
gmSEQ.CHN(1).T=[gmSEQ.m];
gmSEQ.CHN(1).DT=[gmSEQ.CtrGateDur];

gmSEQ.CHN(2).PBN=PBDictionary('GreenAOM');
gmSEQ.CHN(2).NRise=1;
gmSEQ.CHN(2).T=[2000];
gmSEQ.CHN(2).DT=[gmSEQ.readout];

gmSEQ.CHN(3).PBN=PBDictionary('dummy1');
gmSEQ.CHN(3).NRise=2;
gmSEQ.CHN(3).T=[0 6000];
gmSEQ.CHN(3).DT=[12 12];

ApplyNoDelays;

function CtrDelay
global gmSEQ gSG
gSG.bfixedPow=1;
gSG.bfixedFreq=1;
gSG.bMod='IQ';
gSG.bModSrc='External';

T_AfterLaser = 2000;
T_AfterPulse = 1000;
Detect_Window = 5000;

% Pulse Blaster
gmSEQ.CHN(1).PBN = PBDictionary('ctr0');
gmSEQ.CHN(1).NRise = 2;
gmSEQ.CHN(1).T = [gmSEQ.readout - gmSEQ.CtrGateDur - 1000, ...
    gmSEQ.readout + T_AfterLaser + gmSEQ.pi + T_AfterPulse + gmSEQ.m];
gmSEQ.CHN(1).DT = [gmSEQ.CtrGateDur, gmSEQ.CtrGateDur];

gmSEQ.CHN(numel(gmSEQ.CHN) + 1).PBN = PBDictionary('MWSwitch');
gmSEQ.CHN(numel(gmSEQ.CHN)).NRise = 1;
gmSEQ.CHN(numel(gmSEQ.CHN)).T = gmSEQ.readout + T_AfterLaser - 20;
gmSEQ.CHN(numel(gmSEQ.CHN)).DT = gmSEQ.pi + 32;

gmSEQ.CHN(numel(gmSEQ.CHN) + 1).PBN = PBDictionary('GreenAOM');
gmSEQ.CHN(numel(gmSEQ.CHN)).NRise = 2;
gmSEQ.CHN(numel(gmSEQ.CHN)).T = [0, ...
    gmSEQ.readout + T_AfterLaser + gmSEQ.pi + T_AfterPulse];
gmSEQ.CHN(numel(gmSEQ.CHN)).DT = [gmSEQ.readout, Detect_Window];

gmSEQ.CHN(numel(gmSEQ.CHN) + 1).PBN = PBDictionary('dummy1');
gmSEQ.CHN(numel(gmSEQ.CHN)).NRise = 2;
gmSEQ.CHN(numel(gmSEQ.CHN)).T = [0, ...
    gmSEQ.readout + T_AfterLaser + gmSEQ.pi + T_AfterPulse + Detect_Window - 1000];
gmSEQ.CHN(numel(gmSEQ.CHN)).DT = [1000, 1000];

gmSEQ.CHN(numel(gmSEQ.CHN) + 1).PBN = PBDictionary('AWGTrig');
gmSEQ.CHN(numel(gmSEQ.CHN)).NRise = 1;
gmSEQ.CHN(numel(gmSEQ.CHN)).T = gmSEQ.readout + T_AfterLaser;
gmSEQ.CHN(numel(gmSEQ.CHN)).DT = 1000;

% AWG.
WaveForm_Length = ceil((gmSEQ.pi + 1000) / (16/gSG.AWGClockRate)) * (16/gSG.AWGClockRate);
WaveForm_PointNum = WaveForm_Length*gSG.AWGClockRate;

chaseFunctionPool('stopChase', gmSEQ.MWAWG)
if gSG.ACmodAWG % if we use AWG in AC modulation mode.
    WaveForm_1 = [0, gmSEQ.pi, gSG.AWGFreq, 0*pi+0, gSG.AWGAmp];
    WaveForm_2 = [0, gmSEQ.pi, gSG.AWGFreq, 0*pi-pi/2, gSG.AWGAmp];
else
    WaveForm_1 = [0, gmSEQ.pi, gSG.AWGAmp];
    WaveForm_2 = [0, gmSEQ.pi, 0];
end

chaseFunctionPool('createWaveform', WaveForm_1, ...
    gSG.AWGClockRate, WaveForm_Length, 'CtrDur_Ch1.txt')
chaseFunctionPool('createWaveform', ...
    WaveForm_2, gSG.AWGClockRate, WaveForm_Length, 'CtrDur_Ch2.txt')
chaseFunctionPool('CreateSingleSegment', gmSEQ.MWAWG, 1, ...
    WaveForm_PointNum, 1, 2047, 2047, 'CtrDur_Ch1.txt', 1); 
pause(1.0);
chaseFunctionPool('CreateSingleSegment', gmSEQ.MWAWG, 2, ...
    WaveForm_PointNum, 1, 2047, 2047, 'CtrDur_Ch2.txt', 1);
pause(1.0);
chaseFunctionPool('runChase', gmSEQ.MWAWG, 'false');

ApplyDelays();

function IQ_test
global gmSEQ gSG
gSG.bfixedPow=1;
gSG.bfixedFreq=1;
gSG.bMod='IQ';
gSG.bModSrc='External';

[gmSEQ.ScaleT, gmSEQ.ScaleStr] = GetScale(gmSEQ.To);

gmSEQ.CHN(1).PBN=6;
gmSEQ.CHN(1).NRise=1;
gmSEQ.CHN(1).T=[100]; 
gmSEQ.CHN(1).DT=[100];    

gmSEQ.CHN(2).PBN=7;
gmSEQ.CHN(2).NRise=1;
gmSEQ.CHN(2).T=[250]; 
gmSEQ.CHN(2).DT=[100];     


gmSEQ.CHN(3).PBN=PBDictionary('dummy1');
gmSEQ.CHN(3).NRise=2;
T=[0,400-20]; 
DT=[20,20];    
ConstructSeq(T,DT)

gmSEQ.CHN(4).PBN=0;
gmSEQ.CHN(4).NRise=1;
gmSEQ.CHN(4).T=[100]; 
gmSEQ.CHN(4).DT=[100];   

gmSEQ.CHN(5).PBN=2;
gmSEQ.CHN(5).NRise=2;
gmSEQ.CHN(5).T=[120,270]; 
gmSEQ.CHN(5).DT=[60,60]; 

ApplyDelays();

function T1_S00_S01
%fdc stands for fixed duty cycle
global gmSEQ gSG
gSG.bfixedPow=1;
gSG.bfixedFreq=1;
gSG.bMod='LOL';
gSG.bModSrc='External';

[gmSEQ.ScaleT, gmSEQ.ScaleStr] = GetScale(gmSEQ.To);


arr = gmSEQ.SweepParam;
max_index = length(arr);
m = gmSEQ.m;
index_m = find(arr ==m); %find the index of the current t
index_n = 1 + max_index - index_m; %find the index of the differential t
n = arr(index_n); %find the differential t

d = 1e3; %AfterLaser
u = 1000; %AfterPulse
i = gmSEQ.readout; 
r = gmSEQ.CtrGateDur;
p = gmSEQ.pi;

To = arr(end)+arr(1);

%%%%% Variable sequence length%%%%%%

gmSEQ.CHN(1).PBN=PBDictionary('ctr0');
gmSEQ.CHN(1).NRise=8;
T=[d,i-2*r,d+p+u+m,i-2*r,d,i-2*r,d+p+u+n,i-2*r];
DT=[r,r,r,r,r,r,r,r];
ConstructSeq(T,DT)

gmSEQ.CHN(numel(gmSEQ.CHN)+1).PBN=PBDictionary('GreenAOM');
gmSEQ.CHN(numel(gmSEQ.CHN)).NRise=4;
T=[d,d+p+u+m,d,d+p+u+n];
DT=[i,i,i,i];
ConstructSeq(T,DT)

gmSEQ.CHN(numel(gmSEQ.CHN)+1).PBN=PBDictionary('MWSwitch');
gmSEQ.CHN(numel(gmSEQ.CHN)).NRise=1;
T=[d+i+d+p+u+m+i+d+i+d+n];
DT=[p];
ConstructSeq(T,DT)

gmSEQ.CHN(numel(gmSEQ.CHN)+1).PBN=PBDictionary('dummy1');
gmSEQ.CHN(numel(gmSEQ.CHN)).NRise=2;
T=[0 (d+p+u)*2+i*4+d*2+m+n-r];
DT=[20 20];
ConstructSeq(T,DT)

ApplyDelays();

function T1_S00_S01_S10_S11
global gmSEQ gSG
gSG.bfixedPow=1;
gSG.bfixedFreq=1;
gSG.bMod='LOL';
gSG.bModSrc='External';

[gmSEQ.ScaleT, gmSEQ.ScaleStr] = GetScale(gmSEQ.To);

if strcmp(gmSEQ.meas,'APD')
    gmSEQ.CtrGateDur = 4000;
end

arr = gmSEQ.SweepParam;
max_index = length(arr);
m = gmSEQ.m;
index_m = find(arr ==m); %find the index of the current t
index_n = 1 + max_index - index_m; %find the index of the differential t
n = arr(index_n); %find the differential t

d = 1e7; %AfterLaser
u = 10000; %AfterPulse
w = 1e6; %initial wait
i = gmSEQ.readout; 
r = gmSEQ.CtrGateDur;
p = gmSEQ.pi;

To = arr(end)+arr(1);

%%%%% Variable sequence length%%%%%%

gmSEQ.CHN(1).PBN=PBDictionary('ctr0');
gmSEQ.CHN(1).NRise=16;
T=[d,i-2*r,d+p+u+m,i-2*r,d,i-2*r,d+p+u+n,i-2*r,d,i-2*r,d+p+u+m,i-2*r,d,i-2*r,d+p+u+n,i-2*r];
DT=[r,r,r,r,r,r,r,r,r,r,r,r,r,r,r,r];
ConstructSeq(T,DT)

gmSEQ.CHN(numel(gmSEQ.CHN)+1).PBN=PBDictionary('GreenAOM');
gmSEQ.CHN(numel(gmSEQ.CHN)).NRise=8;
T=[d,d+p+u+m,d,d+p+u+n,d,d+p+u+m,d,d+p+u+n];
DT=[i,i,i,i,i,i,i,i];
ConstructSeq(T,DT)

gmSEQ.CHN(numel(gmSEQ.CHN)+1).PBN=PBDictionary('MWSwitch');
gmSEQ.CHN(numel(gmSEQ.CHN)).NRise=4;
T=[d+i+d+p+u+m+i+d+i+d+n,u+i+d+i+d,u+m+i+d+i+d,n-p];
DT=[p,p,p,p];
% gmSEQ.CHN(numel(gmSEQ.CHN)).NRise=1;
% T=[d+i+d+p+u+m+i+d+i+d+n];
% DT=[p];
ConstructSeq(T,DT)

gmSEQ.CHN(numel(gmSEQ.CHN)+1).PBN=PBDictionary('dummy1');
gmSEQ.CHN(numel(gmSEQ.CHN)).NRise=2;
T=[0 (d+p+u)*4+i*8+d*4+(m+n)*2-r];
DT=[20 20];
ConstructSeq(T,DT)

ApplyDelays();

function T1
global gmSEQ gSG
gSG.bfixedPow=1;
gSG.bfixedFreq=1;
gSG.bMod='IQ';
gSG.bModSrc='External';

[gmSEQ.ScaleT, gmSEQ.ScaleStr] = GetScale(gmSEQ.m);

if strcmp(gmSEQ.meas,'APD')
    gmSEQ.CtrGateDur = 1000;
end

WaitTime = 0.1e6; % charge equilibrium
AfterPi = 2000;

Total_Length = WaitTime+gmSEQ.readout+gmSEQ.m+gmSEQ.readout;
%%%%% Variable sequence length%%%%%%

gmSEQ.CHN(1).PBN=PBDictionary('ctr0');
gmSEQ.CHN(1).NRise=2;
gmSEQ.CHN(1).T=[WaitTime WaitTime+gmSEQ.readout+gmSEQ.m];
gmSEQ.CHN(1).DT=[gmSEQ.CtrGateDur gmSEQ.CtrGateDur];

gmSEQ.CHN(numel(gmSEQ.CHN)+1).PBN=PBDictionary('GreenAOM');
gmSEQ.CHN(numel(gmSEQ.CHN)).NRise=2;
gmSEQ.CHN(numel(gmSEQ.CHN)).T=[WaitTime WaitTime+gmSEQ.readout+gmSEQ.m];
gmSEQ.CHN(numel(gmSEQ.CHN)).DT=[gmSEQ.readout gmSEQ.readout];


gmSEQ.CHN(numel(gmSEQ.CHN)+1).PBN=PBDictionary('dummy1');
gmSEQ.CHN(numel(gmSEQ.CHN)).NRise=2;
gmSEQ.CHN(numel(gmSEQ.CHN)).T=[0 Total_Length-20];
gmSEQ.CHN(numel(gmSEQ.CHN)).DT=[20 20];

ApplyDelays();

% tune ODMR to ESR continuously
function ODMR_sweep
global gmSEQ gSG
gSG.bfixedPow=1;
gSG.bfixedFreq=0;
gSG.bMod='IQ'; 
gSG.bModSrc='External';

gmSEQ.ScaleStr = "GHz";
gmSEQ.ScaleT = 1e-9;

delay = 10000; % 1050 or 100000
afterPulse = 1000;
if strcmp(gmSEQ.meas,'APD')
    gmSEQ.CtrGateDur = 1000;
end
%%%%% Fixed sequence length %%%%%%

gmSEQ.CHN(1).PBN=PBDictionary('GreenAOM');
gmSEQ.CHN(1).NRise=1;
% gmSEQ.CHN(1).T=[0, gmSEQ.readout+delay+gmSEQ.pi+afterPulse];
% gmSEQ.CHN(1).T=[0, gmSEQ.readout];
% gmSEQ.CHN(1).DT=[gmSEQ.readout, gmSEQ.readout];
gmSEQ.CHN(1).T=0;
gmSEQ.CHN(1).DT=gmSEQ.readout;

gmSEQ.CHN(numel(gmSEQ.CHN)+1).PBN=PBDictionary('ctr0');
gmSEQ.CHN(numel(gmSEQ.CHN)).NRise=1;
% gmSEQ.CHN(numel(gmSEQ.CHN)).T=[gmSEQ.readout-1000-gmSEQ.CtrGateDur, gmSEQ.readout];
gmSEQ.CHN(numel(gmSEQ.CHN)).T=[0];
gmSEQ.CHN(numel(gmSEQ.CHN)).DT=[gmSEQ.CtrGateDur];

gmSEQ.CHN(numel(gmSEQ.CHN)+1).PBN=PBDictionary('MWSwitch');
gmSEQ.CHN(numel(gmSEQ.CHN)).NRise=1;
% gmSEQ.CHN(numel(gmSEQ.CHN)).T=[gmSEQ.readout+delay-20];
gmSEQ.CHN(numel(gmSEQ.CHN)).T=[0];
gmSEQ.CHN(numel(gmSEQ.CHN)).DT=[gmSEQ.pi];

gmSEQ.CHN(numel(gmSEQ.CHN)+1).PBN=PBDictionary('dummy1');
gmSEQ.CHN(numel(gmSEQ.CHN)).NRise=1;
gmSEQ.CHN(numel(gmSEQ.CHN)).T=0;
gmSEQ.CHN(numel(gmSEQ.CHN)).DT=100;

% gmSEQ.CHN(numel(gmSEQ.CHN) + 1).PBN = PBDictionary('AWGTrig');
% gmSEQ.CHN(numel(gmSEQ.CHN)).NRise = 1;
% gmSEQ.CHN(numel(gmSEQ.CHN)).T = gmSEQ.readout + delay;
% gmSEQ.CHN(numel(gmSEQ.CHN)).DT = 200;
ApplyNoDelays();
% ApplyDelays();

function PESR
global gmSEQ gSG
gSG.bfixedPow=1;
gSG.bfixedFreq=0;
gSG.bMod='IQ';
gSG.bModSrc='External';

%%%%% Fixed sequence length %%%%%%
gmSEQ.CHN(1).PBN=PBDictionary('ctr0');
gmSEQ.CHN(1).NRise=1;
gmSEQ.CHN(1).T=[0];
if strcmp(gmSEQ.meas,'SPCM')
    gmSEQ.CHN(1).DT=[gmSEQ.CtrGateDur];
elseif strcmp(gmSEQ.meas,'APD')
    gmSEQ.CHN(1).DT=[1000 1000];
end
gmSEQ.CHN(numel(gmSEQ.CHN)+1).PBN=PBDictionary('I');
gmSEQ.CHN(numel(gmSEQ.CHN)).NRise=1;
gmSEQ.CHN(numel(gmSEQ.CHN)).T=0;
gmSEQ.CHN(numel(gmSEQ.CHN)).DT=gmSEQ.CtrGateDur;
gmSEQ.CHN(numel(gmSEQ.CHN)+1).PBN=PBDictionary('AOM');
gmSEQ.CHN(numel(gmSEQ.CHN)).NRise=1;
gmSEQ.CHN(numel(gmSEQ.CHN)).T=[0];
gmSEQ.CHN(numel(gmSEQ.CHN)).DT=gmSEQ.CtrGateDur;
gmSEQ.CHN(numel(gmSEQ.CHN)+1).PBN=PBDictionary('dummy');
gmSEQ.CHN(numel(gmSEQ.CHN)).NRise=1;
gmSEQ.CHN(numel(gmSEQ.CHN)).T=0;
gmSEQ.CHN(numel(gmSEQ.CHN)).DT=100000;
ApplyDelays();

function SCC_scan_orange
%fdc stands for fixed duty cycle
global gmSEQ gSG
gSG.bfixedPow=1;
gSG.bfixedFreq=1;
gSG.bMod='LOL';
gSG.bModSrc='External';

[gmSEQ.ScaleT, gmSEQ.ScaleStr] = GetScale(gmSEQ.To);

m = gmSEQ.m;
v = gmSEQ.Var;

pre_init_wait = v(1);
init_dur = v(2); %initial pulse duration
T_init_end = pre_init_wait+init_dur; %initial pulse end time
post_init_wait = v(3);
laser_readout_dur = v(4);
post_laser_readout_wait = v(5); %extra time to keep counting*2
T_laser_readout_start = T_init_end+post_init_wait;
wait_time_before_counting = v(6);
counter_DT = v(8); %counter duration
counter_off = v(7)-v(8);
counter_period = v(7); 
% counter_total_dur =  post_init_wait/2 + post_laser_readout_wait/2+ laser_readout_dur;
counter_total_dur =  laser_readout_dur-wait_time_before_counting;
T_counter_start = T_laser_readout_start+wait_time_before_counting; %counter start time
N = floor(counter_total_dur/counter_period); %number of counters
disp(['Number of Counter: ' num2str(N)])
disp(['Counter Period (ns): ' num2str(counter_period)])
%%%%% Variable sequence length%%%%%%

gmSEQ.CHN(1).PBN=PBDictionary('ctr0');
gmSEQ.CHN(1).NRise=N;
T=[T_counter_start, counter_off]; 
T = repelem(T, [1, N-1]);
DT=[counter_DT];    
DT = repelem(DT, N);
ConstructSeq(T,DT)

use_orange_init = v(10);
if use_orange_init == 1234 %put 1234 in Var4 to use orange to init.
    %charge init
    gmSEQ.CHN(numel(gmSEQ.CHN)+1).PBN=7;%bit 7 is not in use
    gmSEQ.CHN(numel(gmSEQ.CHN)).NRise=1;
    T=[pre_init_wait];
    DT=[init_dur];
    ConstructSeq(T,DT)
    
    gmSEQ.CHN(numel(gmSEQ.CHN)+1).PBN=PBDictionary('OrangeAOM');
    gmSEQ.CHN(numel(gmSEQ.CHN)).NRise=2;
    T=[pre_init_wait,T_laser_readout_start-pre_init_wait-init_dur];
    DT=[init_dur,laser_readout_dur];
    ConstructSeq(T,DT)
else
    gmSEQ.CHN(numel(gmSEQ.CHN)+1).PBN=v(9);
    gmSEQ.CHN(numel(gmSEQ.CHN)).NRise=1;
    T=[pre_init_wait];
    DT=[init_dur];
    ConstructSeq(T,DT)
    
    gmSEQ.CHN(numel(gmSEQ.CHN)+1).PBN=PBDictionary('OrangeAOM');
    gmSEQ.CHN(numel(gmSEQ.CHN)).NRise=1;
    T=[T_laser_readout_start];
    DT=[laser_readout_dur];
    ConstructSeq(T,DT)
    
end


gmSEQ.CHN(numel(gmSEQ.CHN)+1).PBN=PBDictionary('dummy1');
gmSEQ.CHN(numel(gmSEQ.CHN)).NRise=2;
T=[0 , T_counter_start + counter_total_dur+post_laser_readout_wait/2];
DT=[20 20];
ConstructSeq(T,DT)

ApplyDelays();

function SCC_scan_orange_with_MW
%fdc stands for fixed duty cycle
global gmSEQ gSG
gSG.bfixedPow=1;
gSG.bfixedFreq=1;
gSG.bMod='LOL';
gSG.bModSrc='External';

[gmSEQ.ScaleT, gmSEQ.ScaleStr] = GetScale(gmSEQ.To);

m = gmSEQ.m;
v = gmSEQ.Var;

pre_init_wait = v(1);
init_dur = v(2); %initial pulse duration
T_init_end = pre_init_wait+init_dur; %initial pulse end time
post_init_wait = v(3);
laser_readout_dur = v(4);
post_laser_readout_wait = v(5); %extra time to keep counting*2
pi_time = gmSEQ.pi;
post_MW_wait = 10000;
T_laser_readout_start = T_init_end+post_init_wait+pi_time+post_MW_wait;
wait_time_before_counting = v(6);
counter_DT = v(8); %counter duration
counter_off = v(7)-v(8);
counter_period = v(7); 
% counter_total_dur =  post_init_wait/2 + post_laser_readout_wait/2+ laser_readout_dur;
counter_total_dur =  laser_readout_dur-wait_time_before_counting;
T_counter_start = T_laser_readout_start+wait_time_before_counting; %counter start time
N = floor(counter_total_dur/counter_period); %number of counters
disp(['Number of Counter: ' num2str(N)])
disp(['Counter Period (ns): ' num2str(counter_period)])
%%%%% Variable sequence length%%%%%%

gmSEQ.CHN(1).PBN=PBDictionary('ctr0');
gmSEQ.CHN(1).NRise=N;
T=[T_counter_start, counter_off]; 
T = repelem(T, [1, N-1]);
DT=[counter_DT];    
DT = repelem(DT, N);
ConstructSeq(T,DT)


use_orange_init = v(10);
if use_orange_init == 1234 %put 1234 in Var4 to use orange to init.
    %charge init
    gmSEQ.CHN(numel(gmSEQ.CHN)+1).PBN=7;%bit 7 is not in use
    gmSEQ.CHN(numel(gmSEQ.CHN)).NRise=1;
    T=[pre_init_wait];
    DT=[init_dur];
    ConstructSeq(T,DT)
    
    gmSEQ.CHN(numel(gmSEQ.CHN)+1).PBN=PBDictionary('OrangeAOM');
    gmSEQ.CHN(numel(gmSEQ.CHN)).NRise=2;
    T=[pre_init_wait,T_laser_readout_start-pre_init_wait-init_dur];
    DT=[init_dur,laser_readout_dur];
    ConstructSeq(T,DT)
else
    
    %charge init
    gmSEQ.CHN(numel(gmSEQ.CHN)+1).PBN=v(9);
    gmSEQ.CHN(numel(gmSEQ.CHN)).NRise=1;
    T=[pre_init_wait];
    DT=[init_dur];
    ConstructSeq(T,DT)
    
    gmSEQ.CHN(numel(gmSEQ.CHN)+1).PBN=PBDictionary('OrangeAOM');
    gmSEQ.CHN(numel(gmSEQ.CHN)).NRise=1;
    T=[T_laser_readout_start];
    DT=[laser_readout_dur];
    ConstructSeq(T,DT)
end

gmSEQ.CHN(numel(gmSEQ.CHN)+1).PBN=PBDictionary('MWSwitch');
gmSEQ.CHN(numel(gmSEQ.CHN)).NRise=1;
T=[T_init_end+post_init_wait];
DT=[pi_time];
ConstructSeq(T,DT)

gmSEQ.CHN(numel(gmSEQ.CHN)+1).PBN=PBDictionary('dummy1');
gmSEQ.CHN(numel(gmSEQ.CHN)).NRise=2;
T=[0 , T_counter_start + counter_total_dur+post_laser_readout_wait/2];
DT=[20 20];
ConstructSeq(T,DT)

ApplyDelays();

% function SCC_charge_readout()
% %fdc stands for fixed duty cycle
% global gmSEQ gSG
% gSG.bfixedPow=1;
% gSG.bfixedFreq=1;
% gSG.bMod='LOL';
% gSG.bModSrc='External';
% 
% [gmSEQ.ScaleT, gmSEQ.ScaleStr] = GetScale(gmSEQ.To);
% 
% % turn on a continuous orange laser and 1e5 counter gates, plot histogram
% % of probability vs photon count 
% 
% init_wait = 0;
% orange_AOM_start = init_wait; % time stamp when Orange AOM is on
% orange_AOM_DT = 1e7; % 10ms
% ctr_start = 1e6; % wait for 10 us to start ctr
% ctr_DT = 1e6; % 1 ms counter gate on time
% 
% ctr_off = 1e6;
% 
% %%%%% Variable sequence length%%%%%%
% 
% gmSEQ.CHN(1).PBN=PBDictionary('ctr0');
% gmSEQ.CHN(1).NRise=1;
% T=[ctr_start, ctr_off + ctr_DT]; 
% T=repelem(T, 1);
% DT=repelem([ctr_DT], 1);    
% ConstructSeq(T,DT)
% 
% % charge readout
% gmSEQ.CHN(numel(gmSEQ.CHN)+1).PBN=PBDictionary('OrangeAOM');
% gmSEQ.CHN(numel(gmSEQ.CHN)).NRise=1;
% T=[orange_AOM_start];
% DT=[orange_AOM_DT];
% ConstructSeq(T,DT)
% 
% 
% gmSEQ.CHN(numel(gmSEQ.CHN)+1).PBN=PBDictionary('dummy1');
% gmSEQ.CHN(numel(gmSEQ.CHN)).NRise=2;
% T=[0 , orange_AOM_DT - 100];
% DT=[20 20];
% ConstructSeq(T,DT)
% 
% ApplyDelays();

function SCC_rabi_use_orange_readout()
%fdc stands for fixed duty cycle
global gmSEQ gSG
gSG.bfixedPow=1;
gSG.bfixedFreq=1;
gSG.bMod='LOL';
gSG.bModSrc='External';

[gmSEQ.ScaleT, gmSEQ.ScaleStr] = GetScale(gmSEQ.To);

pre_green_init_wait = 1000;
green_init_dur = gmSEQ.readout;
post_green_init_wait = 1000;
post_MW_wait = 1000;
orange_readout = gmSEQ.m;
pi_time = 138;

T_pre_MW = pre_green_init_wait+green_init_dur+post_green_init_wait;
T_pre_readout = T_pre_MW+post_MW_wait;

%%%%% Variable sequence length%%%%%%
gmSEQ.CHN(1).PBN=PBDictionary('ctr0');
gmSEQ.CHN(1).NRise=2;
T=[T_pre_readout,T_pre_readout]; 
DT=[orange_readout,orange_readout];    
ConstructSeq(T,DT)

gmSEQ.CHN(numel(gmSEQ.CHN)+1).PBN=PBDictionary('GreenAOM');
gmSEQ.CHN(numel(gmSEQ.CHN)).NRise=2;
T=[pre_green_init_wait,T_pre_readout+orange_readout-green_init_dur];
DT=[green_init_dur,green_init_dur];
ConstructSeq(T,DT)

gmSEQ.CHN(numel(gmSEQ.CHN)+1).PBN=PBDictionary('OrangeAOM');
gmSEQ.CHN(numel(gmSEQ.CHN)).NRise=2;
T=[T_pre_readout,T_pre_readout];
DT=[orange_readout,orange_readout];
ConstructSeq(T,DT)

gmSEQ.CHN(numel(gmSEQ.CHN)+1).PBN=PBDictionary('MWSwitch');
gmSEQ.CHN(numel(gmSEQ.CHN)).NRise=1;
T=[T_pre_readout+orange_readout+T_pre_MW];
DT=[pi_time];
ConstructSeq(T,DT)

gmSEQ.CHN(numel(gmSEQ.CHN)+1).PBN=PBDictionary('dummy1');
gmSEQ.CHN(numel(gmSEQ.CHN)).NRise=2;
T=[0 , 2*T_pre_readout+orange_readout-20];
DT=[20 20];
ConstructSeq(T,DT)

ApplyDelays();

function SCC_red_laser_edge()
%fdc stands for fixed duty cycle
global gmSEQ gSG
gSG.bfixedPow=1;
gSG.bfixedFreq=1;
gSG.bMod='LOL';
gSG.bModSrc='External';

[gmSEQ.ScaleT, gmSEQ.ScaleStr] = GetScale(gmSEQ.To);


%%%%% Variable sequence length%%%%%%
gmSEQ.CHN(1).PBN=PBDictionary('ctr0');
gmSEQ.CHN(1).NRise=1;
T=[gmSEQ.m]; 
DT=[1000000];    
ConstructSeq(T,DT)

% gmSEQ.CHN(numel(gmSEQ.CHN)+1).PBN=PBDictionary('RedAOM');
% gmSEQ.CHN(numel(gmSEQ.CHN)).NRise=1;
% T=[0];
% DT=[1000];
% ConstructSeq(T,DT)

gmSEQ.CHN(numel(gmSEQ.CHN)+1).PBN=PBDictionary('dummy1');
gmSEQ.CHN(numel(gmSEQ.CHN)).NRise=2;
T=[0 , gmSEQ.m+1000];
DT=[20 20];
ConstructSeq(T,DT)

ApplyDelays();



