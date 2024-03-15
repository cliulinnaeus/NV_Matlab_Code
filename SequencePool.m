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
    case 'Rabi'
        Rabi();
    case 'Rabi_fix_MWDutyCycle'
        Rabi_fix_MWDutyCycle()
    case 'Rabi_Raman'
        Rabi_Raman();
    case 'Rabi_SG2'
        Rabi_SG2();
    case 'Rabi_Scan_Ini_time'
        Rabi_Scan_Ini_time();
    case 'Rabi_TuneDensity'
        Rabi_TuneDensity()
    case 'Test_NV_Polarization'
        Test_NV_Polarization();
    case 'Ramsey'
        Ramsey();
    case 'AOM Delay'
        AOMDelay();
    case 'AOM Delay Orange'
        AOMDelay_Orange();
    case 'Echo'
        Echo();
    case 'XY8'
        XY8();
    case 'ESR'
        ESR();
    case 'T1'
        T1();
    case 'T1_S00_S01'
        T1_S00_S01();
    case 'T1_Rb_S00_S01_Rd'
        T1_Rb_S00_S01_Rd();
    case 'T1_Rb_S00_S01_Rd_newRef'
        T1_Rb_S00_S01_Rd_newRef();
    case 'ODMR'
        ODMR();
    case 'ODMR_sweep'
        ODMR_sweep()
    case 'ODMR_SG2'
        ODMR_SG2();
    case 'ODMR_ACstark_probe'
        ODMR_ACstark_probe();
    case 'ODMR_ACstark_bath'
        ODMR_ACstark_bath();
    case 'PBDictionary'
        varargout{1}=PBDictionary(varargin{2});
    case 'CtrDur'
        CtrDur();
    case 'CtrDelay'
        CtrDelay();
    case 'Pulsed ESR'
        PESR();
    case 'Select Sequence'
        return
        
end

function StrL = PopulateSeq
% Here I only put the sequence which is frequently used.

StrL{1} = 'Select Sequence';

StrL{numel(StrL)+1}='CtrGates_4';
StrL{numel(StrL)+1}='Test_DAQ';

StrL{numel(StrL)+1}='ESR';
StrL{numel(StrL)+1}='ODMR';
StrL{numel(StrL)+1}='ODMR_sweep';
% StrL{numel(StrL)+1}='ODMR_SG2';
% StrL{numel(StrL)+1}='ODMR_ACstark_probe';
% StrL{numel(StrL)+1}='ODMR_ACstark_bath';

StrL{numel(StrL)+1}='Rabi';
StrL{numel(StrL)+1}='Rabi_Scan_Ini_time';
%StrL{numel(StrL)+1}='Rabi_SG2';
%StrL{numel(StrL)+1}='Rabi_SG3';
% StrL{numel(StrL)+1}='Rabi_Raman';
% StrL{numel(StrL)+1}='Rabi_TuneDensity';
%StrL{numel(StrL)+1}='Rabi_fix_MWDutyCycle';
% StrL{numel(StrL)+1}='Test_NV_Polarization';
% StrL{numel(StrL)+1}='Ramsey';
StrL{numel(StrL)+1}='Echo';
% StrL{numel(StrL)+1}='Echo_HR';
% StrL{numel(StrL)+1}='Echo_Double';
% StrL{numel(StrL)+1}='Echo_TuneDensity';
% 
% StrL{numel(StrL)+1}='Sz_local_probe';
% StrL{numel(StrL)+1}='Sz_local_probe_compare';

% StrL{numel(StrL)+1}='WAHUHAN';
% StrL{numel(StrL)+1}='DROID60';
% StrL{numel(StrL)+1}='DROID60N';
% StrL{numel(StrL)+1}='DROID60N_tomo';
% StrL{numel(StrL)+1}='Cory48N_tomo';
% StrL{numel(StrL)+1}='SeqHN_tomo';
% StrL{numel(StrL)+1}='SeqGN_tomo';
StrL{numel(StrL)+1}='AOM Delay';
StrL{numel(StrL)+1}='T1';
StrL{numel(StrL)+1}='T1_S00_S01';
StrL{numel(StrL)+1}='T1_Rb_S00_S01_Rd';
StrL{numel(StrL)+1}='T1_Rb_S00_S01_Rd_newRef';
StrL{numel(StrL)+1}='CtrDur';
StrL{numel(StrL)+1}='CtrDelay';
% StrL{numel(StrL)+1}='Pulsed ESR';
% StrL{numel(StrL)+1}= 'AWG Sync Testing';
% StrL{numel(StrL)+1}= 'Spin Locking';


% StrL{numel(StrL)+1}= 'Pulse_Cali';
% StrL{numel(StrL)+1}= 'Pulse_Cali_XY_N';
% StrL{numel(StrL)+1}= 'Pulse_Cali_N';
% StrL{numel(StrL)+1}= 'Pulse_Cali_N_diff';
% StrL{numel(StrL)+1}= 'Pulse_Cali_N_XY_diff';

% StrL{numel(StrL)+1}= 'XY8N_Cali';
% StrL{numel(StrL)+1}= 'Pi_Cali';
% StrL{numel(StrL)+1}= 'Pi_Cali_DEER';
% StrL{numel(StrL)+1}= 'HalfPi_Cali';
% StrL{numel(StrL)+1}= 'Rabi_diff';
% StrL{numel(StrL)+1}= 'DROID60N_Cali';
% StrL{numel(StrL)+1}= 'Composite_Cali';
% StrL{numel(StrL)+1}= 'Pi_Cali_SG2';
% StrL{numel(StrL)+1}= 'Pi_Cali_DEER_SG2';
% StrL{numel(StrL)+1}= 'Pi_Cali_SG3';
% StrL{numel(StrL)+1}= 'HalfPi_Cali_SG2';

function Rabi
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
gmSEQ.CHN(numel(gmSEQ.CHN)).T = T_initial_wait + gmSEQ.readout + T_AfterLaser;
gmSEQ.CHN(numel(gmSEQ.CHN)).DT = gmSEQ.m;

gmSEQ.CHN(numel(gmSEQ.CHN) + 1).PBN = PBDictionary('AOM');
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

function Rabi_Scan_Ini_time
global gmSEQ gSG
gSG.bfixedPow = 1;
gSG.bfixedFreq = 1;
gSG.bMod = 'LOL';%set to no modulation
gSG.bModSrc = 'External';

[gmSEQ.ScaleT, gmSEQ.ScaleStr] = GetScale(gmSEQ.pi);

T_AfterLaser = 2000;
T_AfterPulse = 1000;
T_initial_wait = T_AfterLaser + gmSEQ.pi + T_AfterPulse;


% Pulse Blaster
gmSEQ.CHN(1).PBN = PBDictionary('ctr0');
gmSEQ.CHN(1).NRise = 2;
gmSEQ.CHN(1).T = [T_initial_wait, ...
    T_initial_wait + gmSEQ.m + T_AfterLaser + gmSEQ.pi + T_AfterPulse];
gmSEQ.CHN(1).DT = [gmSEQ.CtrGateDur, gmSEQ.CtrGateDur];

gmSEQ.CHN(numel(gmSEQ.CHN) + 1).PBN = PBDictionary('MWSwitch');
gmSEQ.CHN(numel(gmSEQ.CHN)).NRise = 1;
gmSEQ.CHN(numel(gmSEQ.CHN)).T = T_initial_wait + gmSEQ.m + T_AfterLaser;
gmSEQ.CHN(numel(gmSEQ.CHN)).DT = gmSEQ.pi;

gmSEQ.CHN(numel(gmSEQ.CHN) + 1).PBN = PBDictionary('AOM');
gmSEQ.CHN(numel(gmSEQ.CHN)).NRise = 2;
gmSEQ.CHN(numel(gmSEQ.CHN)).T = [T_initial_wait, ...
    T_initial_wait + gmSEQ.m + T_AfterLaser + gmSEQ.pi + T_AfterPulse];
gmSEQ.CHN(numel(gmSEQ.CHN)).DT = [gmSEQ.m, gmSEQ.m];

gmSEQ.CHN(numel(gmSEQ.CHN) + 1).PBN = PBDictionary('dummy1');
gmSEQ.CHN(numel(gmSEQ.CHN)).NRise = 2;
gmSEQ.CHN(numel(gmSEQ.CHN)).T = [0, ...
    T_initial_wait + gmSEQ.m + T_AfterLaser + gmSEQ.pi + T_AfterPulse];
gmSEQ.CHN(numel(gmSEQ.CHN)).DT = [1000, 1000];

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

gmSEQ.CHN(numel(gmSEQ.CHN) + 1).PBN = PBDictionary('AOM');
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

gmSEQ.CHN(numel(gmSEQ.CHN) + 1).PBN = PBDictionary('AOM');
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

function Rabi_fix_MWDutyCycle
global gmSEQ gSG
gSG.bfixedPow = 1;
gSG.bfixedFreq = 1;
gSG.bMod = 'LOL';%set to no modulation
gSG.bModSrc = 'External';


T_AfterLaser = 2000;
T_AfterPulse = 1000;
T_initial_wait =  T_AfterLaser + gmSEQ.To + T_AfterPulse;

[gmSEQ.ScaleT, gmSEQ.ScaleStr] = GetScale(gmSEQ.To);

% Pulse Blaster
gmSEQ.CHN(1).PBN = PBDictionary('ctr0');
gmSEQ.CHN(1).NRise = 4;
% gmSEQ.CHN(1).T = [gmSEQ.readout - gmSEQ.CtrGateDur - 1000, ...
%     gmSEQ.readout + T_AfterLaser + gmSEQ.To + T_AfterPulse];
gmSEQ.CHN(1).T = [T_initial_wait, ...
    T_initial_wait + gmSEQ.readout + T_AfterLaser + gmSEQ.To + T_AfterPulse,...
    T_initial_wait + gmSEQ.readout + T_AfterLaser + gmSEQ.To + T_AfterPulse...
    + gmSEQ.readout + T_AfterLaser + gmSEQ.To + T_AfterPulse,...
    T_initial_wait + gmSEQ.readout + T_AfterLaser + gmSEQ.To + T_AfterPulse...
    + gmSEQ.readout + T_AfterLaser + gmSEQ.To + T_AfterPulse...
    + gmSEQ.readout + T_AfterLaser + gmSEQ.To + T_AfterPulse];
gmSEQ.CHN(1).DT = [gmSEQ.CtrGateDur, gmSEQ.CtrGateDur,gmSEQ.CtrGateDur,gmSEQ.CtrGateDur];

% gmSEQ.CHN(1).PBN = PBDictionary('ctr0');
% gmSEQ.CHN(1).NRise = 2;
% % gmSEQ.CHN(1).T = [gmSEQ.readout + T_AfterLaser + gmSEQ.To + T_AfterPulse];
% gmSEQ.CHN(1).T = [gmSEQ.readout - , gmSEQ.readout - 1500];
% gmSEQ.CHN(1).DT = [gmSEQ.CtrGateDur, gmSEQ.CtrGateDur];

gmSEQ.CHN(numel(gmSEQ.CHN) + 1).PBN = PBDictionary('MWSwitch');
gmSEQ.CHN(numel(gmSEQ.CHN)).NRise = 2;
gmSEQ.CHN(numel(gmSEQ.CHN)).T = [T_initial_wait + gmSEQ.readout + T_AfterLaser - 20,...
    3*T_initial_wait + 3*gmSEQ.readout+T_AfterLaser - 20];
gmSEQ.CHN(numel(gmSEQ.CHN)).DT = [gmSEQ.m + 40, gmSEQ.To - gmSEQ.m + 40];

gmSEQ.CHN(numel(gmSEQ.CHN) + 1).PBN = PBDictionary('AOM');
gmSEQ.CHN(numel(gmSEQ.CHN)).NRise = 4;
gmSEQ.CHN(numel(gmSEQ.CHN)).T = [T_initial_wait, ...
    T_initial_wait + gmSEQ.readout + T_AfterLaser + gmSEQ.To + T_AfterPulse,...
    T_initial_wait + gmSEQ.readout + T_AfterLaser + gmSEQ.To + T_AfterPulse...
    + gmSEQ.readout + T_AfterLaser + gmSEQ.To + T_AfterPulse,...
    T_initial_wait + gmSEQ.readout + T_AfterLaser + gmSEQ.To + T_AfterPulse...
    + gmSEQ.readout + T_AfterLaser + gmSEQ.To + T_AfterPulse...
    + gmSEQ.readout + T_AfterLaser + gmSEQ.To + T_AfterPulse];
gmSEQ.CHN(numel(gmSEQ.CHN)).DT = [gmSEQ.readout, gmSEQ.readout,gmSEQ.readout,gmSEQ.readout];

gmSEQ.CHN(numel(gmSEQ.CHN) + 1).PBN = PBDictionary('dummy1');
gmSEQ.CHN(numel(gmSEQ.CHN)).NRise = 2;
gmSEQ.CHN(numel(gmSEQ.CHN)).T = [0, ...
    T_initial_wait + gmSEQ.readout + T_AfterLaser + gmSEQ.To + T_AfterPulse...
    + gmSEQ.readout + T_AfterLaser + gmSEQ.To + T_AfterPulse...
    + gmSEQ.readout + T_AfterLaser + gmSEQ.To + T_AfterPulse];
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

Wait = 1e3;
gateDur = 1e3;
scrDur = 50;
% shift = gmSEQ.m;
shift = -200;

% Pulse Blaster
gmSEQ.CHN(1).PBN = PBDictionary('ctr0');
gmSEQ.CHN(1).NRise = 2;
gmSEQ.CHN(1).T = [Wait,3*Wait];
gmSEQ.CHN(1).DT = [gateDur,gateDur];

% gmSEQ.CHN(numel(gmSEQ.CHN) + 1).PBN = PBDictionary('MWSwitch');
% gmSEQ.CHN(numel(gmSEQ.CHN)).NRise = 1;
% gmSEQ.CHN(numel(gmSEQ.CHN)).T = Wait + gmSEQ.readout + T_AfterLaser - 20;
% gmSEQ.CHN(numel(gmSEQ.CHN)).DT = gmSEQ.m + 40;

gmSEQ.CHN(numel(gmSEQ.CHN) + 1).PBN = PBDictionary('MWSwitch2');
gmSEQ.CHN(numel(gmSEQ.CHN)).NRise = 6;
gmSEQ.CHN(numel(gmSEQ.CHN)).T = [Wait+50+shift,Wait+50+950+scrDur+shift,Wait+50+950+50+2*scrDur+shift,Wait+50+950+50+850+3*scrDur+shift,...
    Wait+50+950+50+850+50+4*scrDur+shift,Wait+50+950+50+850+100+5*scrDur+shift];
gmSEQ.CHN(numel(gmSEQ.CHN)).DT = [scrDur,scrDur,scrDur,scrDur,scrDur,scrDur];


gmSEQ.CHN(numel(gmSEQ.CHN) + 1).PBN = PBDictionary('dummy1');
gmSEQ.CHN(numel(gmSEQ.CHN)).NRise = 2;
gmSEQ.CHN(numel(gmSEQ.CHN)).T = [0,4*Wait];
gmSEQ.CHN(numel(gmSEQ.CHN)).DT = [100, 100];
ApplyDelays();

function Rabi_SG3
global gmSEQ gSG
gSG.bfixedPow = 1;
gSG.bfixedFreq = 1;
gSG.bMod = 'IQ';
gSG.bModSrc = 'External';



if strcmp(gmSEQ.meas,'APD') % If PL signal is collected via APD.
    gmSEQ.CtrGateDur = 1000;
end

T_AfterLaser = 2000;
T_AfterPulse = 3000;

% Pulse Blaster
gmSEQ.CHN(1).PBN = PBDictionary('ctr0');
gmSEQ.CHN(1).NRise = 2;
gmSEQ.CHN(1).T = [gmSEQ.readout - gmSEQ.CtrGateDur - 1000, ...
    gmSEQ.readout + T_AfterLaser + gmSEQ.To + T_AfterPulse];
gmSEQ.CHN(1).DT = [gmSEQ.CtrGateDur, gmSEQ.CtrGateDur];

gmSEQ.CHN(numel(gmSEQ.CHN) + 1).PBN = PBDictionary('MWSwitch');
gmSEQ.CHN(numel(gmSEQ.CHN)).NRise = 1;
gmSEQ.CHN(numel(gmSEQ.CHN)).T = gmSEQ.readout + T_AfterLaser - 20;
gmSEQ.CHN(numel(gmSEQ.CHN)).DT = gmSEQ.m + 40;

gmSEQ.CHN(numel(gmSEQ.CHN) + 1).PBN = PBDictionary('AOM');
gmSEQ.CHN(numel(gmSEQ.CHN)).NRise = 2;
gmSEQ.CHN(numel(gmSEQ.CHN)).T = [0, ...
    gmSEQ.readout + T_AfterLaser + gmSEQ.To + T_AfterPulse];
gmSEQ.CHN(numel(gmSEQ.CHN)).DT = [gmSEQ.readout, 5000];

gmSEQ.CHN(numel(gmSEQ.CHN) + 1).PBN = PBDictionary('dummy1');
gmSEQ.CHN(numel(gmSEQ.CHN)).NRise = 2;
gmSEQ.CHN(numel(gmSEQ.CHN)).T = [0, ...
    gmSEQ.readout + T_AfterLaser + gmSEQ.To + T_AfterPulse];
gmSEQ.CHN(numel(gmSEQ.CHN)).DT = [1000, 1000];

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

gmSEQ.CHN(numel(gmSEQ.CHN) + 1).PBN = PBDictionary('AOM');
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

gmSEQ.CHN(numel(gmSEQ.CHN) + 1).PBN = PBDictionary('AOM');
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

gmSEQ.CHN(numel(gmSEQ.CHN) + 1).PBN = PBDictionary('AOM');
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

function AOMDelay
global gmSEQ gSG
gSG.bfixedPow=1;
gSG.bfixedFreq=1;
gSG.bMod='IQ';
gSG.bModSrc='External';

[gmSEQ.ScaleT, gmSEQ.ScaleStr] = GetScale(gmSEQ.m);


if strcmp(gmSEQ.meas,'APD')
    gmSEQ.CtrGateDur = 1000;
end

gmSEQ.CHN(1).PBN=PBDictionary('ctr0');
gmSEQ.CHN(1).NRise=1;
gmSEQ.CHN(1).T=[gmSEQ.m];
gmSEQ.CHN(1).DT=[gmSEQ.CtrGateDur];

gmSEQ.CHN(2).PBN=PBDictionary('AOM');
gmSEQ.CHN(2).NRise=1;
gmSEQ.CHN(2).T=2000;
gmSEQ.CHN(2).DT=[gmSEQ.readout];

gmSEQ.CHN(3).PBN=PBDictionary('dummy1');
gmSEQ.CHN(3).NRise=2;
gmSEQ.CHN(3).T=[0 6000];
gmSEQ.CHN(3).DT=[12 12];

ApplyNoDelays;

function AOMDelay_Orange
global gmSEQ gSG
gSG.bfixedPow=1;
gSG.bfixedFreq=1;
gSG.bMod='IQ';
gSG.bModSrc='External';

if strcmp(gmSEQ.meas,'APD')
    gmSEQ.CtrGateDur = 1000;
end

gmSEQ.CHN(1).PBN=PBDictionary('ctr0');
gmSEQ.CHN(1).NRise=1;
gmSEQ.CHN(1).T=[gmSEQ.m];
gmSEQ.CHN(1).DT=[gmSEQ.CtrGateDur];

gmSEQ.CHN(2).PBN=PBDictionary('OrangeAOM');
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

gmSEQ.CHN(numel(gmSEQ.CHN) + 1).PBN = PBDictionary('AOM');
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

function Ramsey
global gmSEQ gSG
gSG.bfixedPow=1;
gSG.bfixedFreq=1;
gSG.bMod='LOL';
gSG.bModSrc='External';

[gmSEQ.ScaleT, gmSEQ.ScaleStr] = GetScale(gmSEQ.To);

gmSEQ.halfpi = gmSEQ.pi/2;

AfterPi = 2000;
AfterLaser = 0.1e6;
Wait_p = 0.1e6; 
Detect_Window = 5000;

if strcmp(gmSEQ.meas,'APD')
    gmSEQ.CtrGateDur = 1000;
end

% TODO: change the total time
Sig_D_start = Wait_p+gmSEQ.readout+AfterLaser+gmSEQ.halfpi+gmSEQ.m+gmSEQ.halfpi+AfterPi+Detect_Window+Wait_p;

gmSEQ.CHN(1).PBN=PBDictionary('ctr0');
gmSEQ.CHN(1).NRise=4;
gmSEQ.CHN(1).T=[Wait_p+gmSEQ.readout-1000-gmSEQ.CtrGateDur, ... % Ref_B
    Wait_p+gmSEQ.readout+AfterLaser+gmSEQ.halfpi+gmSEQ.m+gmSEQ.halfpi+AfterPi, ... % Sig_B
    Sig_D_start+gmSEQ.readout-1000-gmSEQ.CtrGateDur, ... % Ref_D
    Sig_D_start+gmSEQ.readout+AfterLaser+gmSEQ.halfpi+gmSEQ.m+gmSEQ.halfpi+AfterPi]; % Sig_D
gmSEQ.CHN(1).DT=[gmSEQ.CtrGateDur gmSEQ.CtrGateDur gmSEQ.CtrGateDur gmSEQ.CtrGateDur];


gmSEQ.CHN(numel(gmSEQ.CHN)+1).PBN=PBDictionary('AOM');
gmSEQ.CHN(numel(gmSEQ.CHN)).NRise=4;
gmSEQ.CHN(numel(gmSEQ.CHN)).T = [Wait_p, ...
    Wait_p+gmSEQ.readout+AfterLaser+gmSEQ.halfpi+gmSEQ.m+gmSEQ.halfpi+AfterPi, ...
    Sig_D_start, ...
    Sig_D_start+gmSEQ.readout+AfterLaser+gmSEQ.halfpi+gmSEQ.m+gmSEQ.halfpi+AfterPi];
gmSEQ.CHN(numel(gmSEQ.CHN)).DT = [gmSEQ.readout Detect_Window gmSEQ.readout Detect_Window];

% Check this point
gmSEQ.CHN(numel(gmSEQ.CHN)+1).PBN=PBDictionary('MWSwitch');
if gmSEQ.m < 400
    gmSEQ.CHN(numel(gmSEQ.CHN)).NRise=2;
    gmSEQ.CHN(numel(gmSEQ.CHN)).T=[Wait_p+gmSEQ.readout+AfterLaser-20, Sig_D_start+gmSEQ.readout+AfterLaser-20];
    gmSEQ.CHN(numel(gmSEQ.CHN)).DT=[gmSEQ.halfpi+gmSEQ.m+gmSEQ.halfpi+40, gmSEQ.halfpi+gmSEQ.m+gmSEQ.halfpi+40];
else
    gmSEQ.CHN(numel(gmSEQ.CHN)).NRise=4;
    gmSEQ.CHN(numel(gmSEQ.CHN)).T=[Wait_p+gmSEQ.readout+AfterLaser-20,...
        Wait_p+gmSEQ.readout+AfterLaser+gmSEQ.halfpi+gmSEQ.m-20, ...
        Sig_D_start+gmSEQ.readout+AfterLaser-20, ... 
        Sig_D_start+gmSEQ.readout+AfterLaser+gmSEQ.halfpi+gmSEQ.m-20];
    gmSEQ.CHN(numel(gmSEQ.CHN)).DT=[gmSEQ.halfpi+40, gmSEQ.halfpi+40, gmSEQ.halfpi+40, gmSEQ.halfpi+40];
end

gmSEQ.CHN(numel(gmSEQ.CHN)+1).PBN=PBDictionary('dummy1');
gmSEQ.CHN(numel(gmSEQ.CHN)).NRise=2;
gmSEQ.CHN(numel(gmSEQ.CHN)).T=[0 Sig_D_start+gmSEQ.readout+AfterLaser+gmSEQ.halfpi+gmSEQ.m+gmSEQ.halfpi+AfterPi+Detect_Window-50];
gmSEQ.CHN(numel(gmSEQ.CHN)).DT=[50 50];

ApplyDelays();

function Echo
global gmSEQ gSG
gSG.bfixedPow=1;
gSG.bfixedFreq=1;
gSG.bMod='LOL';
gSG.bModSrc='External';

[gmSEQ.ScaleT, gmSEQ.ScaleStr] = GetScale(gmSEQ.To);

AfterPulse = 1000;
AfterLaser = 1000;
InitialWait = AfterLaser+gmSEQ.halfpi+gmSEQ.m/2+gmSEQ.pi+gmSEQ.m/2+gmSEQ.halfpi+AfterPulse;

gmSEQ.CHN(1).PBN=PBDictionary('ctr0');
gmSEQ.CHN(1).NRise=2;
gmSEQ.CHN(1).T=[InitialWait,...
    InitialWait+gmSEQ.readout+AfterLaser+gmSEQ.halfpi+gmSEQ.m/2+gmSEQ.pi+gmSEQ.m/2+gmSEQ.halfpi+AfterPulse];
if strcmp(gmSEQ.meas,'SPCM')
    gmSEQ.CHN(1).DT=[gmSEQ.CtrGateDur gmSEQ.CtrGateDur];
elseif strcmp(gmSEQ.meas,'APD')
    gmSEQ.CHN(1).DT=[1000 1000 1000 1000];
end

gmSEQ.CHN(numel(gmSEQ.CHN)+1).PBN=PBDictionary('AOM');
gmSEQ.CHN(numel(gmSEQ.CHN)).NRise=2;
gmSEQ.CHN(numel(gmSEQ.CHN)).T = [InitialWait,...
    InitialWait+gmSEQ.readout+AfterLaser+gmSEQ.halfpi+gmSEQ.m/2+gmSEQ.pi+gmSEQ.m/2+gmSEQ.halfpi+AfterPulse];
gmSEQ.CHN(numel(gmSEQ.CHN)).DT = [gmSEQ.readout gmSEQ.readout];


gmSEQ.CHN(numel(gmSEQ.CHN)+1).PBN=PBDictionary('MWSwitch');
gmSEQ.CHN(numel(gmSEQ.CHN)).NRise=3;
gmSEQ.CHN(numel(gmSEQ.CHN)).T=[InitialWait+gmSEQ.readout+AfterLaser, ...
    InitialWait+gmSEQ.readout+AfterLaser+gmSEQ.halfpi+gmSEQ.m/2, ...
    InitialWait+gmSEQ.readout+AfterLaser+gmSEQ.halfpi+gmSEQ.m/2+gmSEQ.pi+gmSEQ.m/2];
gmSEQ.CHN(numel(gmSEQ.CHN)).DT=[gmSEQ.halfpi, gmSEQ.pi, gmSEQ.halfpi];

gmSEQ.CHN(numel(gmSEQ.CHN)+1).PBN=PBDictionary('dummy1');
gmSEQ.CHN(numel(gmSEQ.CHN)).NRise=2;
gmSEQ.CHN(numel(gmSEQ.CHN)).T=[0  InitialWait+gmSEQ.readout+AfterLaser+gmSEQ.halfpi+gmSEQ.m/2+gmSEQ.pi+gmSEQ.m/2+gmSEQ.halfpi+AfterPulse];
gmSEQ.CHN(numel(gmSEQ.CHN)).DT=[50 50];


ApplyDelays();

function ESR
global gSG gmSEQ
gSG.bfixedPow=1;
gSG.bfixedFreq=0;
gSG.bMod='Sweep';
gSG.bModSrc='External';
gSG.sweepRate=4;
gmSEQ.bLiO=1;
gmSEQ.ctrN=1;

gmSEQ.ScaleT = 1e-9;
gmSEQ.ScaleStr = "GHz";

% dummy sequence for DrawSequence
gmSEQ.CHN(1).PBN=PBDictionary('AOM');
gmSEQ.CHN(1).NRise=1;
gmSEQ.CHN(1).T=0;
gmSEQ.CHN(1).DT=1;

gmSEQ.CHN(2).PBN=PBDictionary('MWSwitch');
gmSEQ.CHN(2).NRise=1;
gmSEQ.CHN(2).T=0;
gmSEQ.CHN(2).DT=1;

function pbn = PBDictionary(type)
switch type
    case 'ctr0'
        pbn=0;
%     case 'AWGTrig2'
%         pbn=1;
%     case 'AWGTrig' 
%         pbn=0;
    case 'dummy1'
        pbn=8;
    case 'AOM'
        pbn=1;
%     case 'AWGTrig3' 
%         pbn=4;
    case 'MWSwitch'
        pbn=2;
    case 'MWSwitch2'
        pbn=3;
%     case 'MWSwitch3'
%         pbn=7;
end

function T1_S00_S01
global gmSEQ gSG
gSG.bfixedPow=1;
gSG.bfixedFreq=1;
gSG.bMod='LOL';
gSG.bModSrc='External';

[gmSEQ.ScaleT, gmSEQ.ScaleStr] = GetScale(gmSEQ.To);

if strcmp(gmSEQ.meas,'APD')
    gmSEQ.CtrGateDur = 1000;
end
d = 1000; %AfterLaser
u = 100; %AfterPulse
w = 1e6; %initial wait
i = gmSEQ.readout; 
r = gmSEQ.CtrGateDur;
p = gmSEQ.pi;
m = gmSEQ.m;

%%%%% Variable sequence length%%%%%%

gmSEQ.CHN(1).PBN=PBDictionary('ctr0');
gmSEQ.CHN(1).NRise=4;
gmSEQ.CHN(1).T=[w+i-r-100,w+i+(d+m+u),w*2+i*2+(d+m+u),w*2+i*2+(d+m+u)*2+r+40];
gmSEQ.CHN(1).DT=[r,r,r,r];

gmSEQ.CHN(numel(gmSEQ.CHN)+1).PBN=PBDictionary('AOM');
gmSEQ.CHN(numel(gmSEQ.CHN)).NRise=6;
gmSEQ.CHN(numel(gmSEQ.CHN)).T=[w,w+i+(d+m+u),w+i+(d+m+u)+d,w*2+i+(d+m+u)+(r+100)*2+d,...
    w*2+i+(d+m+u)+(r+100)*2+2*d,w*2+i*2+(d+m+u)*2+r+100+2*d];
gmSEQ.CHN(numel(gmSEQ.CHN)).DT=[i,r+100,r+100,i,r+100,r+100];

gmSEQ.CHN(numel(gmSEQ.CHN)+1).PBN=PBDictionary('MWSwitch');
gmSEQ.CHN(numel(gmSEQ.CHN)).NRise=1;
gmSEQ.CHN(numel(gmSEQ.CHN)).T=[w*2+i*2+(d+m+u)*2+r+40-p-u];
gmSEQ.CHN(numel(gmSEQ.CHN)).DT=[p];

gmSEQ.CHN(numel(gmSEQ.CHN)+1).PBN=PBDictionary('dummy1');
gmSEQ.CHN(numel(gmSEQ.CHN)).NRise=2;
gmSEQ.CHN(numel(gmSEQ.CHN)).T=[0 w*2+(d+m+u)*2+i*2-20];
gmSEQ.CHN(numel(gmSEQ.CHN)).DT=[20 20];


ApplyDelays();

function T1_Rb_S00_S01_Rd
global gmSEQ gSG
gSG.bfixedPow=1;
gSG.bfixedFreq=1;
gSG.bMod='LOL';
gSG.bModSrc='External';

[gmSEQ.ScaleT, gmSEQ.ScaleStr] = GetScale(gmSEQ.To);

if strcmp(gmSEQ.meas,'APD')
    gmSEQ.CtrGateDur = 1000;
end
d = 1000; %AfterLaser
u = 100; %AfterPulse
w = 1e6; %initial wait
i = gmSEQ.readout; 
r = gmSEQ.CtrGateDur;
p = gmSEQ.pi;
m = gmSEQ.m;

%%%%% Variable sequence length%%%%%%

gmSEQ.CHN(1).PBN=PBDictionary('ctr0');
gmSEQ.CHN(1).NRise=4;
gmSEQ.CHN(1).T=[w+i-r-100,w+i+(d+m+u),(w+i+d+m+u+r+100+w)+i+d+m+u,...
    (w+i+d+m+u+r+100+w+i+d+m+u+r+100+w)+p+d+u+i];
gmSEQ.CHN(1).DT=[r,r,r,r];

gmSEQ.CHN(numel(gmSEQ.CHN)+1).PBN=PBDictionary('AOM');
gmSEQ.CHN(numel(gmSEQ.CHN)).NRise=6;
gmSEQ.CHN(numel(gmSEQ.CHN)).T=[w,(w)+i+d+m+u,(w+i+d+m+u)+r+100+w,...
    (w+i+d+m+u+r+100+w)+i+d+m+u,(w+i+d+m+u+r+100+w+i+d+m+u)+r+100+w,...
    (w+i+d+m+u+r+100+w+i+d+m+u+r+100+w)+i+p+d+u];
gmSEQ.CHN(numel(gmSEQ.CHN)).DT=[i,r+100,i,r+100,i,r+100];

gmSEQ.CHN(numel(gmSEQ.CHN)+1).PBN=PBDictionary('MWSwitch');
gmSEQ.CHN(numel(gmSEQ.CHN)).NRise=2;
gmSEQ.CHN(numel(gmSEQ.CHN)).T=[(w+i+d+m+u+r+100+w)+i+d+m+u-p-u,...
    (w+i+d+m+u+r+100+w+i+d+m+u)+r+100+w+i+d];
gmSEQ.CHN(numel(gmSEQ.CHN)).DT=[p,p];

gmSEQ.CHN(numel(gmSEQ.CHN)+1).PBN=PBDictionary('dummy1');
gmSEQ.CHN(numel(gmSEQ.CHN)).NRise=2;
gmSEQ.CHN(numel(gmSEQ.CHN)).T=[0 (w+i+d+m+u+r+100+w+i+d+m+u+r+100+w)+i+p+d+u+r+100];
gmSEQ.CHN(numel(gmSEQ.CHN)).DT=[20 20];










ApplyDelays();

function T1_Rb_S00_S01_Rd_newRef
global gmSEQ gSG
gSG.bfixedPow=1;
gSG.bfixedFreq=1;
gSG.bMod='LOL';
gSG.bModSrc='External';

[gmSEQ.ScaleT, gmSEQ.ScaleStr] = GetScale(gmSEQ.To);

if strcmp(gmSEQ.meas,'APD')
    gmSEQ.CtrGateDur = 1000;
end
d = 1000; %AfterLaser
u = 100; %AfterPulse
w = 1e6; %initial wait
i = gmSEQ.readout; 
r = gmSEQ.CtrGateDur;
re = 100; %extra laser on time for readout
rl = r+re; %total laser on time for readout
p = gmSEQ.pi;
m = gmSEQ.m;

%%%%% Variable sequence length%%%%%%

gmSEQ.CHN(1).PBN=PBDictionary('ctr0');
gmSEQ.CHN(1).NRise=4;
T=[w+i+d,d+m+u+re,w+i+d+rl+d+m+u+re,w+i+d+p+u+re];
DT=[r,r,r,r];
ConstructSeq(T,DT)

gmSEQ.CHN(numel(gmSEQ.CHN)+1).PBN=PBDictionary('AOM');
gmSEQ.CHN(numel(gmSEQ.CHN)).NRise=8;
T=[w,d,d+m+u,w,d,d+m+u,w,d+p+u];
DT=[i,rl,rl,i,rl,rl,i,rl];
ConstructSeq(T,DT)

gmSEQ.CHN(numel(gmSEQ.CHN)+1).PBN=PBDictionary('MWSwitch');
gmSEQ.CHN(numel(gmSEQ.CHN)).NRise=2;
T=[(w+i+d+rl+d+m+u)*2+rl-u-p,u+rl+w+i+d];
DT=[p,p];
ConstructSeq(T,DT)

gmSEQ.CHN(numel(gmSEQ.CHN)+1).PBN=PBDictionary('dummy1');
gmSEQ.CHN(numel(gmSEQ.CHN)).NRise=2;
T=[0 (w+i+d+r+100+d+m+u+rl)*2+p+rl+w+i+d];
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

gmSEQ.CHN(numel(gmSEQ.CHN)+1).PBN=PBDictionary('AOM');
gmSEQ.CHN(numel(gmSEQ.CHN)).NRise=2;
gmSEQ.CHN(numel(gmSEQ.CHN)).T=[WaitTime WaitTime+gmSEQ.readout+gmSEQ.m];
gmSEQ.CHN(numel(gmSEQ.CHN)).DT=[gmSEQ.readout gmSEQ.readout];


gmSEQ.CHN(numel(gmSEQ.CHN)+1).PBN=PBDictionary('dummy1');
gmSEQ.CHN(numel(gmSEQ.CHN)).NRise=2;
gmSEQ.CHN(numel(gmSEQ.CHN)).T=[0 Total_Length-20];
gmSEQ.CHN(numel(gmSEQ.CHN)).DT=[20 20];

ApplyDelays();

function ODMR
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

gmSEQ.CHN(1).PBN=PBDictionary('AOM');
gmSEQ.CHN(1).NRise=2;
gmSEQ.CHN(1).T=[0 gmSEQ.readout+delay+gmSEQ.pi+afterPulse];
gmSEQ.CHN(1).DT=[gmSEQ.readout 5000];

gmSEQ.CHN(numel(gmSEQ.CHN)+1).PBN=PBDictionary('ctr0');
gmSEQ.CHN(numel(gmSEQ.CHN)).NRise=2;
gmSEQ.CHN(numel(gmSEQ.CHN)).T=[gmSEQ.readout-1000-gmSEQ.CtrGateDur, gmSEQ.readout+delay+gmSEQ.pi+afterPulse];
gmSEQ.CHN(numel(gmSEQ.CHN)).DT=[gmSEQ.CtrGateDur, gmSEQ.CtrGateDur];

gmSEQ.CHN(numel(gmSEQ.CHN)+1).PBN=PBDictionary('MWSwitch');
gmSEQ.CHN(numel(gmSEQ.CHN)).NRise=1;
gmSEQ.CHN(numel(gmSEQ.CHN)).T=[gmSEQ.readout+delay-20];
gmSEQ.CHN(numel(gmSEQ.CHN)).DT=[gmSEQ.pi+40];

gmSEQ.CHN(numel(gmSEQ.CHN)+1).PBN=PBDictionary('dummy1');
gmSEQ.CHN(numel(gmSEQ.CHN)).NRise=1;
gmSEQ.CHN(numel(gmSEQ.CHN)).T=0;
gmSEQ.CHN(numel(gmSEQ.CHN)).DT=100;

% gmSEQ.CHN(numel(gmSEQ.CHN) + 1).PBN = PBDictionary('AWGTrig');
gmSEQ.CHN(numel(gmSEQ.CHN)).NRise = 1;
gmSEQ.CHN(numel(gmSEQ.CHN)).T = gmSEQ.readout + delay;
gmSEQ.CHN(numel(gmSEQ.CHN)).DT = 200;

% AWG.
% WaveForm_Length = ceil((gmSEQ.m + 1000) * gSG.AWGClockRate / 16) * 16;
% WaveForm_Length = ceil((gmSEQ.pi + 1000) / (16/gSG.AWGClockRate)) * (16/gSG.AWGClockRate);
% WaveForm_PointNum = WaveForm_Length*gSG.AWGClockRate;

% chaseFunctionPool('stopChase', gmSEQ.MWAWG)
% if gSG.ACmodAWG % if we use AWG in AC modulation mode.
%     WaveForm_1 = [0, gmSEQ.pi, gSG.AWGFreq, 0, gSG.AWGAmp];
%     WaveForm_2 = [0, gmSEQ.pi, gSG.AWGFreq, -pi/2, gSG.AWGAmp];
% else
%     WaveForm_1 = [0, gmSEQ.pi, gSG.AWGAmp];
%     WaveForm_2 = [0, gmSEQ.pi, 0];
% end

% chaseFunctionPool('createWaveform', WaveForm_1, ...
%     gSG.AWGClockRate, WaveForm_Length, 'ODMR_Ch1.txt')
% chaseFunctionPool('createWaveform', ...
%     WaveForm_2, gSG.AWGClockRate, WaveForm_Length, 'ODMR_Ch2.txt')
% chaseFunctionPool('CreateSingleSegment', gmSEQ.MWAWG, 1, ...
%     WaveForm_PointNum, 1, 2047, 2047, 'ODMR_Ch1.txt', 1); 
% pause(1.0);
% chaseFunctionPool('CreateSingleSegment', gmSEQ.MWAWG, 2, ...
%     WaveForm_PointNum, 1, 2047, 2047, 'ODMR_Ch2.txt', 1);
% pause(1.0);
% chaseFunctionPool('runChase',  gmSEQ.MWAWG, 'false');

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

gmSEQ.CHN(1).PBN=PBDictionary('AOM');
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


function ODMR_SG2
global gmSEQ gSG gSG3
gSG.bfixedPow=1;
gSG.bfixedFreq=0;
gSG.bMod='IQ'; 
gSG.bModSrc='External';

gmSEQ.ScaleStr = "GHz";
gmSEQ.ScaleT = 1e-9;

if gSG3.ACmodAWG
    gSG3.Freq = (gmSEQ.m - gSG3.AWGFreq)*1e9;
else
    gSG3.Freq = gmSEQ.m*1e9;
end

SignalGeneratorFunctionPool3('WritePow');
SignalGeneratorFunctionPool3('WriteFreq');
gSG3.bOn=1; SignalGeneratorFunctionPool3('RFOnOff');

delay = 10000; % 1050 or 100000
afterPulse = 1000;
if strcmp(gmSEQ.meas,'APD')
    gmSEQ.CtrGateDur = 1000;
end
%%%%% Fixed sequence length %%%%%%

gmSEQ.CHN(1).PBN=PBDictionary('AOM');
gmSEQ.CHN(1).NRise=2;
gmSEQ.CHN(1).T=[0 gmSEQ.readout+delay+gmSEQ.pi+afterPulse];
gmSEQ.CHN(1).DT=[gmSEQ.readout 5000];

gmSEQ.CHN(numel(gmSEQ.CHN)+1).PBN=PBDictionary('ctr0');
gmSEQ.CHN(numel(gmSEQ.CHN)).NRise=2;
gmSEQ.CHN(numel(gmSEQ.CHN)).T=[gmSEQ.readout-1000-gmSEQ.CtrGateDur gmSEQ.readout+delay+gmSEQ.pi+afterPulse];
gmSEQ.CHN(numel(gmSEQ.CHN)).DT=[gmSEQ.CtrGateDur gmSEQ.CtrGateDur];

gmSEQ.CHN(numel(gmSEQ.CHN)+1).PBN=PBDictionary('MWSwitch3');
gmSEQ.CHN(numel(gmSEQ.CHN)).NRise=1;
gmSEQ.CHN(numel(gmSEQ.CHN)).T=[gmSEQ.readout+delay-20];
gmSEQ.CHN(numel(gmSEQ.CHN)).DT=[gmSEQ.pi+40];

gmSEQ.CHN(numel(gmSEQ.CHN)+1).PBN=PBDictionary('dummy1');
gmSEQ.CHN(numel(gmSEQ.CHN)).NRise=1;
gmSEQ.CHN(numel(gmSEQ.CHN)).T=0;
gmSEQ.CHN(numel(gmSEQ.CHN)).DT=100;

gmSEQ.CHN(numel(gmSEQ.CHN) + 1).PBN = PBDictionary('AWGTrig3');
gmSEQ.CHN(numel(gmSEQ.CHN)).NRise = 1;
gmSEQ.CHN(numel(gmSEQ.CHN)).T = gmSEQ.readout + delay;
gmSEQ.CHN(numel(gmSEQ.CHN)).DT = 200;

% AWG.
% WaveForm_Length = ceil((gmSEQ.m + 1000) * gSG.AWGClockRate / 16) * 16;
WaveForm_Length = ceil((gmSEQ.pi + 1000) / (16/gSG3.AWGClockRate)) * (16/gSG3.AWGClockRate);
WaveForm_PointNum = WaveForm_Length*gSG3.AWGClockRate;

chaseFunctionPool('stopChase', gmSEQ.MWAWG2)
if gSG3.ACmodAWG % if we use AWG in AC modulation mode.
    WaveForm_1 = [0, gmSEQ.pi, gSG3.AWGFreq, 0, gSG3.AWGAmp];
    WaveForm_2 = [0, gmSEQ.pi, gSG3.AWGFreq, -pi/2, gSG3.AWGAmp];
else
    WaveForm_1 = [0, gmSEQ.pi, gSG3.AWGAmp];
    WaveForm_2 = [0, gmSEQ.pi, 0];
end

chaseFunctionPool('createWaveform', WaveForm_1, ...
    gSG3.AWGClockRate, WaveForm_Length, 'ODMR_Ch1.txt')
chaseFunctionPool('createWaveform', ...
    WaveForm_2, gSG3.AWGClockRate, WaveForm_Length, 'ODMR_Ch2.txt')
chaseFunctionPool('CreateSingleSegment', gmSEQ.MWAWG2, 1, ...
    WaveForm_PointNum, 1, 2047, 2047, 'ODMR_Ch1.txt', 1); 
pause(1.0);
chaseFunctionPool('CreateSingleSegment', gmSEQ.MWAWG2, 2, ...
    WaveForm_PointNum, 1, 2047, 2047, 'ODMR_Ch2.txt', 1);
pause(1.0);
chaseFunctionPool('runChase',  gmSEQ.MWAWG2, 'false');

ApplyDelays();

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

function Pulse_Cali
global gmSEQ gSG
gSG.bfixedPow = 1;
gSG.bfixedFreq = 1;
gSG.bMod = 'IQ'; 
gSG.bModSrc = 'External';

if strcmp(gmSEQ.meas,'APD') % If PL signal is collected via APD.
    gmSEQ.CtrGateDur = 1000;
end

T_AfterLaser = 20000;
T_AfterPulse = 2000; % 1000 before
PulseGap = 16;
Detect_Window = 5000; 
Wait = 1500;
Sig_D_start = Wait + gmSEQ.readout + T_AfterLaser + gmSEQ.halfpi + PulseGap + gmSEQ.halfpi + T_AfterPulse + Detect_Window + Wait;
buffer = 16;

% TODO: add the definition for the pi and halfpi pulse AWG amp
gSG.piAWGAmp = gSG.AWGAmp; % Just for temporary use
gSG.halfpiAWGAmp = gSG.AWGAmp; % Just for temporary use

% Pulse Blaster
gmSEQ.CHN(1).PBN = PBDictionary('ctr0');
gmSEQ.CHN(1).NRise = 4;
gmSEQ.CHN(1).T = [Wait + gmSEQ.readout - gmSEQ.CtrGateDur - 1000, ...
    Wait + gmSEQ.readout + T_AfterLaser + gmSEQ.halfpi + PulseGap + gmSEQ.halfpi + T_AfterPulse, ...
    Sig_D_start + gmSEQ.readout - gmSEQ.CtrGateDur - 1000, ...
    Sig_D_start + gmSEQ.readout + T_AfterLaser + gmSEQ.halfpi + PulseGap + gmSEQ.halfpi + T_AfterPulse];
gmSEQ.CHN(1).DT = repelem(gmSEQ.CtrGateDur, 4);

gmSEQ.CHN(numel(gmSEQ.CHN) + 1).PBN = PBDictionary('AOM');
gmSEQ.CHN(numel(gmSEQ.CHN)).NRise = 4;
gmSEQ.CHN(numel(gmSEQ.CHN)).T = [Wait, Wait + gmSEQ.readout + T_AfterLaser + gmSEQ.halfpi + PulseGap + gmSEQ.halfpi + T_AfterPulse, ... 
    Sig_D_start, Sig_D_start + gmSEQ.readout + T_AfterLaser + gmSEQ.halfpi + PulseGap + gmSEQ.halfpi + T_AfterPulse];
gmSEQ.CHN(numel(gmSEQ.CHN)).DT = [gmSEQ.readout, Detect_Window, gmSEQ.readout, Detect_Window];

gmSEQ.CHN(numel(gmSEQ.CHN) + 1).PBN = PBDictionary('MWSwitch');
if PulseGap < 2*buffer + 14
    gmSEQ.CHN(numel(gmSEQ.CHN)).NRise = 2;
    gmSEQ.CHN(numel(gmSEQ.CHN)).T = [Wait + gmSEQ.readout + T_AfterLaser - buffer,  Sig_D_start + gmSEQ.readout + T_AfterLaser - buffer];
    gmSEQ.CHN(numel(gmSEQ.CHN)).DT = repelem(2*gmSEQ.halfpi + PulseGap + 2*buffer, 2);
else
    gmSEQ.CHN(numel(gmSEQ.CHN)).NRise = 4;
    gmSEQ.CHN(numel(gmSEQ.CHN)).T = [Wait + gmSEQ.readout + T_AfterLaser - buffer, Wait + gmSEQ.readout + T_AfterLaser + gmSEQ.halfpi + PulseGap - buffer, ...
        Sig_D_start + gmSEQ.readout + T_AfterLaser - buffer, Sig_D_start + gmSEQ.readout + T_AfterLaser + gmSEQ.halfpi + PulseGap - buffer];
    gmSEQ.CHN(numel(gmSEQ.CHN)).DT = repelem(gmSEQ.halfpi + 2*buffer, 4);
end

gmSEQ.CHN(numel(gmSEQ.CHN) + 1).PBN = PBDictionary('AWGTrig');
gmSEQ.CHN(numel(gmSEQ.CHN)).NRise = 2;
gmSEQ.CHN(numel(gmSEQ.CHN)).T = [Wait + gmSEQ.readout + T_AfterLaser, Sig_D_start + gmSEQ.readout + T_AfterLaser];
gmSEQ.CHN(numel(gmSEQ.CHN)).DT = repelem(2*gmSEQ.halfpi + PulseGap + 200, 2);

gmSEQ.CHN(numel(gmSEQ.CHN) + 1).PBN = PBDictionary('dummy1');
gmSEQ.CHN(numel(gmSEQ.CHN)).NRise = 2;
gmSEQ.CHN(numel(gmSEQ.CHN)).T = [0,  2 * (Sig_D_start - Wait)  - 1000];
gmSEQ.CHN(numel(gmSEQ.CHN)).DT = [1000, 1000];

% AWG.
chaseFunctionPool('stopChase', gmSEQ.MWAWG)
if ~gSG.ACmodAWG % if we use AWG in AC modulation mode
    gSG.AWGFreq = 0;
end

factor = 0.5;
WaveForm_1I = [0 gmSEQ.halfpi gSG.AWGFreq 0 gSG.halfpiAWGAmp;...
    gmSEQ.halfpi+PulseGap gmSEQ.halfpi+PulseGap+gmSEQ.halfpi gSG.AWGFreq pi/2 gSG.halfpiAWGAmp;];
WaveForm_1Q = WaveForm_1I - repmat([0 0 0 pi/2 0], size(WaveForm_1I, 1), 1);
WaveForm_1Length = ceil((gmSEQ.halfpi+PulseGap+gmSEQ.halfpi + 1000) / (16/gSG.AWGClockRate)) * (16/gSG.AWGClockRate);
WaveForm_1PointNum = WaveForm_1Length*gSG.AWGClockRate;

WaveForm_2I = [0 gmSEQ.halfpi gSG.AWGFreq 0 gmSEQ.m*gSG.halfpiAWGAmp;...
    gmSEQ.halfpi+PulseGap gmSEQ.halfpi+PulseGap+gmSEQ.halfpi gSG.AWGFreq 3*pi/2 gSG.halfpiAWGAmp;];
WaveForm_2Q = WaveForm_2I - repmat([0 0 0 pi/2 0], size(WaveForm_2I, 1), 1);
WaveForm_2Length = ceil((gmSEQ.halfpi+PulseGap+gmSEQ.halfpi + 1000) / (16/gSG.AWGClockRate)) * (16/gSG.AWGClockRate);
WaveForm_2PointNum = WaveForm_2Length*gSG.AWGClockRate;

% WaveForm_2I = WaveForm_1I;
% WaveForm_2I(size(WaveForm_1I, 1), 4) = WaveForm_1I(size(WaveForm_1I, 1), 4) - pi; % Differential measurement
% WaveForm_2Q = WaveForm_1Q;
% WaveForm_2Q(size(WaveForm_1I, 1), 4) = WaveForm_1Q(size(WaveForm_1I, 1), 4) - pi; % Differential measurement
% WaveForm_2Length = WaveForm_1Length;
% WaveForm_2PointNum = WaveForm_2Length * gSG.AWGClockRate;

chaseFunctionPool('createWaveform', WaveForm_2I, gSG.AWGClockRate, WaveForm_1Length, 'HalfPi_Cal_I_seg1.txt'); pause(0.5);
chaseFunctionPool('createWaveform', WaveForm_2Q, gSG.AWGClockRate, WaveForm_1Length, 'HalfPi_Cal_Q_seg1.txt'); pause(0.5);
chaseFunctionPool('createWaveform', WaveForm_1I, gSG.AWGClockRate, WaveForm_2Length, 'HalfPi_Cal_I_seg2.txt'); pause(0.5);
chaseFunctionPool('createWaveform', WaveForm_1Q, gSG.AWGClockRate, WaveForm_2Length, 'HalfPi_Cal_Q_seg2.txt'); pause(0.5);

chaseFunctionPool('createSegStruct', 'HalfPi_Cal_SegStruct_I.txt', ...
    'HalfPi_Cal_I_seg1.txt', WaveForm_1PointNum, 1, 1, ...
    'HalfPi_Cal_I_seg2.txt', WaveForm_2PointNum, 1, 1);
pause(0.5);
chaseFunctionPool('createSegStruct', 'HalfPi_Cal_SegStruct_Q.txt', ...
    'HalfPi_Cal_Q_seg1.txt', WaveForm_1PointNum, 1, 1, ...
    'HalfPi_Cal_Q_seg2.txt', WaveForm_2PointNum, 1, 1);
pause(0.5);

%% Load waveform to AWG
chaseFunctionPool('CreateSegments', gmSEQ.MWAWG, 1, ...
    2, ...
    2047, 2047, 'HalfPi_Cal_SegStruct_I.txt', 'false');
pause(1); % this pause seems to be important, otherwise the loading is not right occassionally
chaseFunctionPool('CreateSegments', gmSEQ.MWAWG, 2, ...
    2, ...
    2047, 2047, 'HalfPi_Cal_SegStruct_Q.txt', 'false');
pause(1); % this pause seems to be important, otherwise the loading is not right occassionally
%% Run waveform
chaseFunctionPool('runChase', gmSEQ.MWAWG, 'false');
ApplyDelays();

function Pi_Cali
global gmSEQ gSG
gSG.bfixedPow = 1;
gSG.bfixedFreq = 1;
gSG.bMod = 'IQ'; 
gSG.bModSrc = 'External';

if strcmp(gmSEQ.meas,'APD') % If PL signal is collected via APD.
    gmSEQ.CtrGateDur = 1000;
end

T_AfterLaser = 2000;
T_AfterPulse = 1000;
N = gmSEQ.CoolCycle; % The number of calibration pulses
T_Cycle = gmSEQ.pi + gmSEQ.interval; % Time for a single pulse

% Pulse Blaster
gmSEQ.CHN(1).PBN = PBDictionary('ctr0');
gmSEQ.CHN(1).NRise = 2;
gmSEQ.CHN(1).T = [gmSEQ.readout - gmSEQ.CtrGateDur - 1000, ...
    gmSEQ.readout + T_AfterLaser + N * T_Cycle + T_AfterPulse];
gmSEQ.CHN(1).DT = [gmSEQ.CtrGateDur, gmSEQ.CtrGateDur];

bSwitch = true;
gmSEQ.CHN(numel(gmSEQ.CHN) + 1).PBN = PBDictionary('MWSwitch');
if bSwitch
    buffer = 20;
    gmSEQ.CHN(numel(gmSEQ.CHN)).NRise = N;
    gmSEQ.CHN(numel(gmSEQ.CHN)).T = [];
    for i = 0:N-1
       gmSEQ.CHN(numel(gmSEQ.CHN)).T = [gmSEQ.CHN(numel(gmSEQ.CHN)).T, ...
           gmSEQ.readout + T_AfterLaser + i * T_Cycle - buffer]; 
    end
    gmSEQ.CHN(numel(gmSEQ.CHN)).DT = repelem(gmSEQ.pi + 2*buffer, N);
else
    buffer = 20;
    gmSEQ.CHN(numel(gmSEQ.CHN)).NRise = 1;
    gmSEQ.CHN(numel(gmSEQ.CHN)).T = [gmSEQ.readout + T_AfterLaser - buffer];
    gmSEQ.CHN(numel(gmSEQ.CHN)).DT =  [N * T_Cycle + 2*buffer];
end

gmSEQ.CHN(numel(gmSEQ.CHN) + 1).PBN = PBDictionary('AOM');
gmSEQ.CHN(numel(gmSEQ.CHN)).NRise = 2;
gmSEQ.CHN(numel(gmSEQ.CHN)).T = [0, gmSEQ.readout + T_AfterLaser + N * T_Cycle + T_AfterPulse];
gmSEQ.CHN(numel(gmSEQ.CHN)).DT = [gmSEQ.readout, 5000];

gmSEQ.CHN(numel(gmSEQ.CHN) + 1).PBN = PBDictionary('dummy1');
gmSEQ.CHN(numel(gmSEQ.CHN)).NRise = 2;
gmSEQ.CHN(numel(gmSEQ.CHN)).T = [0, ...
    gmSEQ.readout + T_AfterLaser + N * T_Cycle + + T_AfterPulse + 5000 - 1000];
gmSEQ.CHN(numel(gmSEQ.CHN)).DT = [1000, 1000];

gmSEQ.CHN(numel(gmSEQ.CHN) + 1).PBN = PBDictionary('AWGTrig');
gmSEQ.CHN(numel(gmSEQ.CHN)).NRise = 1;
gmSEQ.CHN(numel(gmSEQ.CHN)).T = gmSEQ.readout + T_AfterLaser;
gmSEQ.CHN(numel(gmSEQ.CHN)).DT =  N * T_Cycle + 200;

% AWG.
chaseFunctionPool('stopChase', gmSEQ.MWAWG)
if ~gSG.ACmodAWG % if we use AWG in AC modulation mode
    gSG.AWGFreq = 0;
end

WaveForm_I = zeros(N, 5);
WaveForm_Q = zeros(N, 5);
for i = 1:N
    WaveForm_I(i,:) = [(i-1)*T_Cycle, (i-1)*T_Cycle + gmSEQ.pi, gSG.AWGFreq, 0, gmSEQ.m];
    WaveForm_Q(i,:) = [(i-1)*T_Cycle, (i-1)*T_Cycle + gmSEQ.pi, gSG.AWGFreq, -pi/2, gmSEQ.m];
end
WaveForm_Length = ceil((N*T_Cycle + 1000) / (16/gSG.AWGClockRate)) * (16/gSG.AWGClockRate);
WaveForm_PointNum = WaveForm_Length*gSG.AWGClockRate;

bGaussian = false;
if bGaussian
    sigma = 3;
    WaveForm_I(:,6) = sigma;
    WaveForm_Q(:,6) = sigma;
    disp("Generating Gaussian pulses")
end

chaseFunctionPool('createWaveform', WaveForm_I, ...
    gSG.AWGClockRate, WaveForm_Length, 'Pi_Cal_I.txt')
chaseFunctionPool('createWaveform', WaveForm_Q,  ...
    gSG.AWGClockRate, WaveForm_Length, 'Pi_Cal_Q.txt')

chaseFunctionPool('createSegStruct', 'Pi_Cal_SegStruct_I.txt', ...
    'Pi_Cal_I.txt', WaveForm_PointNum, 1, 1);
pause(0.5);
chaseFunctionPool('createSegStruct', 'Pi_Cal_SegStruct_Q.txt', ...
    'Pi_Cal_Q.txt', WaveForm_PointNum, 1, 1);
pause(0.5);
chaseFunctionPool('CreateSegments', gmSEQ.MWAWG, 1, ...
    1, ...
    2047, 2047, 'Pi_Cal_SegStruct_I.txt', 'false');
pause(1); % this pause seems to be important, otherwise the loading is not right occassionally
chaseFunctionPool('CreateSegments', gmSEQ.MWAWG, 2, ...
    1, ...
    2047, 2047, 'Pi_Cal_SegStruct_Q.txt', 'false');
pause(1); % this pause seems to be important, otherwise the loading is not right occassionally

chaseFunctionPool('runChase', gmSEQ.MWAWG, 'false');
ApplyDelays();

function ApplyDelays
global gmSEQ gSG gSG2
% aom_delay = 610; % changed to 610 03/24/2022 RT4 Weijie.
aom_delay = 220; % changed to 820 10/19/2022 RT4 Weijie.

if strcmp(gmSEQ.meas,'APD')
    % detector_delay=-1100+610;
    detector_delay=550;
else
    detector_delay=0;
end

AWG_Delay = 46; % 2GHz sampling rate
% AWG_Delay = 53/gSG.AWGClockRate+14; % Need further testing

% LaserAWG_Delay = 53/gSG2.LaserAWGClockRate+14; % for 0.1GHz , delay = [(53*(1/SamplingRate)) + 14] ns

MW2_Delay = 26;

for i=1:numel(gmSEQ.CHN)
    if gmSEQ.CHN(i).PBN==PBDictionary('AOM')
        gmSEQ.CHN(i).Delays=ones(1,2)*aom_delay;
    elseif gmSEQ.CHN(i).PBN==PBDictionary('ctr0')
        gmSEQ.CHN(i).Delays=ones(1,2)*detector_delay;
%     elseif gmSEQ.CHN(i).PBN == PBDictionary('AWGTrig') % Yuanqi Lyu, for AWG.
%         gmSEQ.CHN(i).Delays = ones(1, 2) * AWG_Delay;
%     elseif gmSEQ.CHN(i).PBN == PBDictionary('AWGTrig2') 
%         gmSEQ.CHN(i).Delays = ones(1, 2) * AWG_Delay;
%     elseif gmSEQ.CHN(i).PBN == PBDictionary('AWGTrig3') 
%         gmSEQ.CHN(i).Delays = ones(1, 2) * (AWG_Delay+MW2_Delay);
%     elseif gmSEQ.CHN(i).PBN == PBDictionary('MWSwitch3') 
%         gmSEQ.CHN(i).Delays = ones(1, 2) * MW2_Delay;
    else
        gmSEQ.CHN(i).Delays=zeros(1,2);
    end
end

function ApplyNoDelays
global gmSEQ
for i=1:numel(gmSEQ.CHN)
    gmSEQ.CHN(i).Delays=zeros(1,max(2,gmSEQ.CHN(i).NRise));
end

function ConstructSeq(T,DT)
global gmSEQ
       for i = 2:length(T)
           Taccum = T(i-1);
           T(i) = Taccum + T(i)+ DT(i-1);
       end
       gmSEQ.CHN(numel(gmSEQ.CHN)).T = T;
       gmSEQ.CHN(numel(gmSEQ.CHN)).DT = DT;


function [ScaleT, ScaleStr] = GetScale(tmax)
if tmax > 0 && tmax <= 100e-3
    ScaleT = 1e3;
    ScaleStr = 'ps';
elseif tmax > 100e-3 && tmax <= 100
    ScaleT = 1;
    ScaleStr = 'ns';
elseif tmax > 100 && tmax <= 100e3
    ScaleT = 1e-3;
    ScaleStr = '{\mu}s';
elseif tmax > 100e3 && tmax <= 100e6
    ScaleT = 1e-6;
    ScaleStr = 'ms';
elseif tmax > 100e6 && tmax <= 100e9
    ScaleT = 1e-9;
    ScaleStr = 's';
end