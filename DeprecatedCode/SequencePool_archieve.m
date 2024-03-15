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
    case 'Rabi'
        Rabi();
    case 'Rabi_SG2ON'
        Rabi_SG2ON();
    case 'Rabi_SG2'
        Rabi_SG2();
    case 'Rabi_SG3'
        Rabi_SG3();
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
    case 'Echo_HR'
        Echo_HR();
    case 'Echo_Double'
        Echo_Double();
    case 'Echo_TuneDensity'
        Echo_TuneDensity();
    case 'Sz_local_probe'
        Sz_local_probe()
    case 'Sz_local_probe_compare'
        Sz_local_probe_compare()
    case 'XY8'
        XY8();
    case 'XY8N'
        XY8N();
    case 'XY8N_debug'
        XY8N_debug();
    case 'XY8N_HR'
        XY8N_HR();
    case 'XY8N_TuneDensity'
        XY8N_TuneDensity();
    case 'WAHUHAN'
        WAHUHAN();
    case 'DROID60'
        DROID60();
    case 'DROID60N'
        DROID60N();
    case 'DROID60N_tomo'
        DROID60N_tomo();
    case 'DROID60N_Cali'
        DROID60N_Cali();
    case 'Cory48N_tomo'
        Cory48N_tomo();
    case 'SeqHN_tomo'
        SeqHN_tomo();
    case 'SeqGN_tomo'
        SeqGN_tomo();
    case 'ESR'
        ESR();
    case 'T1'
        T1();
    case 'ODMR'
        ODMR();
    case 'ODMR_SG2'
        ODMR_SG2();
    case 'CPMG-N'
        CPMGN();
    case 'PBDictionary'
        varargout{1}=PBDictionary(varargin{2});
    case 'CtrDur'
        CtrDur();
    case 'CtrDelay'
        CtrDelay();
    case 'Pulsed ESR'
        PESR();
    case 'AWG Sync Testing'
        AWGSyncTest();
    case 'Spin Locking'
        SpinLocking();
    case 'Spin Locking LOOP'
        SpinLockingLOOP();
    case 'Spin Locking P1'
        SpinLockingP1();
    case 'PolarP1Res'
        PolarP1Res();
    case 'PolarP1_SwpT'
        PolarP1_SwpT();
    case 'PolarP1_SwpN'
        PolarP1_SwpN();
    case 'PolarP1_Res'
        PolarP1_Res();
    case 'PolarP1_T1'
        PolarP1_T1();
    case 'Special Cooling'
        SpecialCooling();
    case 'Special Cooling_2'
        SpecialCooling_2();
    case 'Special Cooling Orange'
        SpecialCooling_Orange();
    case 'Special Cooling WaitLaser'
        SpecialCooling_WaitLaser();
    case 'Special Cooling_P1'
        SpecialCooling_P1();
    case 'Special Cooling_P1_2'
        SpecialCooling_P1_2();
    case 'Special Cooling_P1_2_DurMeas'
        SpecialCooling_P1_2_DurMeas();
    case 'Special Cooling_ODMR'
        SpecialCooling_ODMR();
    case 'DEER_ODMR'
        DEER_ODMR();
    case 'DEER_Rabi'
        DEER_Rabi();
    case 'DEER_T2'
        DEER_T2();
    case 'DEERNV_T2'
        DEERNV_T2();
    case 'DEER_XY8N'
        DEER_XY8N();
    case 'Squeezing_T2XY8_SwpDetN'
        Squeezing_T2XY8_SwpDetN();
    case 'Squeezing_T2XY8_SwpTheta'   
        Squeezing_T2XY8_SwpTheta();
    case 'Squeezing_Double_T2XY8_SwpDetN'
        Squeezing_Double_T2XY8_SwpDetN()
    case 'Squeezing_Double_T2XY8_SwpSquN'
        Squeezing_Double_T2XY8_SwpSquN()
    case 'Squeezing_Double_T2XY8_SwpTheta'
        Squeezing_Double_T2XY8_SwpTheta()
    case 'ENDOR_ODMR'
        ENDOR_ODMR();
    case 'ENDOR_ODMR2'
        ENDOR_ODMR2();
    case 'ENDOR_Rabi'
        ENDOR_Rabi();
    case 'ENDOR_NV_ODMR'
        ENDOR_NV_ODMR();
    case 'ENDOR_NV_Rabi'
        ENDOR_NV_Rabi();
    case 'ENDOR_NV_Rabi2'
        ENDOR_NV_Rabi2();
    case 'Elec_Pol_Extract'
        Elec_Pol_Extract()
    case 'Pi_Cali'
        Pi_Cali();
    case 'HalfPi_Cali'
        HalfPi_Cali();
    case 'Rabi_diff'
        Rabi_diff();
    case 'Composite_Cali' 
        Composite_Cali();
    case 'Pi_Cali_SG2'
        Pi_Cali_SG2();
    case 'Pi_Cali_SG3'
        Pi_Cali_SG3();
    case 'HalfPi_Cali_SG2'
        HalfPi_Cali_SG2();
    case 'Select Sequence'
        return
        
end

function StrL = PopulateSeq
% Here I only put the sequence which is frequently used.

StrL{1} = 'Select Sequence';
StrL{numel(StrL)+1}='ESR';
StrL{numel(StrL)+1}='ODMR';
StrL{numel(StrL)+1}='ODMR_SG2';
StrL{numel(StrL)+1}='Rabi';
StrL{numel(StrL)+1}='Rabi_SG2';
StrL{numel(StrL)+1}='Rabi_SG3';
StrL{numel(StrL)+1}='Rabi_TuneDensity';
% StrL{numel(StrL)+1}='Test_NV_Polarization';
StrL{numel(StrL)+1}='Ramsey';
StrL{numel(StrL)+1}='Echo';
StrL{numel(StrL)+1}='Echo_HR';
StrL{numel(StrL)+1}='Echo_Double';
StrL{numel(StrL)+1}='Echo_TuneDensity';

StrL{numel(StrL)+1}='Sz_local_probe';
StrL{numel(StrL)+1}='Sz_local_probe_compare';
% StrL{numel(StrL)+1}='XY8';
StrL{numel(StrL)+1}='XY8N';
StrL{numel(StrL)+1}='XY8N_debug';
StrL{numel(StrL)+1}='XY8N_HR';
StrL{numel(StrL)+1}='XY8N_TuneDensity';

StrL{numel(StrL)+1}='WAHUHAN';
% StrL{numel(StrL)+1}='DROID60';
% StrL{numel(StrL)+1}='DROID60N';
StrL{numel(StrL)+1}='DROID60N_tomo';
StrL{numel(StrL)+1}='Cory48N_tomo';
StrL{numel(StrL)+1}='SeqHN_tomo';
StrL{numel(StrL)+1}='SeqGN_tomo';
StrL{numel(StrL)+1}='AOM Delay';
StrL{numel(StrL)+1}='T1';
StrL{numel(StrL)+1}='CtrDur';
StrL{numel(StrL)+1}='CtrDelay';
% StrL{numel(StrL)+1}='Pulsed ESR';
% StrL{numel(StrL)+1}= 'AWG Sync Testing';
StrL{numel(StrL)+1}= 'Spin Locking';

% StrL{numel(StrL)+1}= 'Spin Locking LOOP';
% StrL{numel(StrL)+1}= 'Spin Locking P1';
% StrL{numel(StrL)+1}= 'PolarP1Res';
% StrL{numel(StrL)+1}= 'PolarP1_Res';
% StrL{numel(StrL)+1}= 'PolarP1_SwpT';
% StrL{numel(StrL)+1}= 'PolarP1_SwpN';
% StrL{numel(StrL)+1}= 'PolarP1_T1';

% StrL{numel(StrL)+1}= 'Special Cooling';
% StrL{numel(StrL)+1}= 'Special Cooling Orange';
% StrL{numel(StrL)+1}= 'Special Cooling WaitLaser';
% StrL{numel(StrL)+1}= 'Special Cooling_2';
% StrL{numel(StrL)+1}= 'Special Cooling_P1';
% StrL{numel(StrL)+1}= 'Special Cooling_P1_2';
% StrL{numel(StrL)+1}= 'Special Cooling_P1_2_DurMeas';
% StrL{numel(StrL)+1}= 'Special Cooling_ODMR';

StrL{numel(StrL)+1}= 'DEER_ODMR';
StrL{numel(StrL)+1}= 'DEER_Rabi';
StrL{numel(StrL)+1}= 'DEER_T2';
StrL{numel(StrL)+1}= 'DEERNV_T2';
StrL{numel(StrL)+1}= 'DEER_XY8N';

StrL{numel(StrL)+1}= 'Squeezing_T2XY8_SwpDetN';
StrL{numel(StrL)+1}= 'Squeezing_T2XY8_SwpTheta';
StrL{numel(StrL)+1}= 'Squeezing_Double_T2XY8_SwpDetN';
StrL{numel(StrL)+1}= 'Squeezing_Double_T2XY8_SwpTheta';
StrL{numel(StrL)+1}= 'Squeezing_Double_T2XY8_SwpSquN';

% StrL{numel(StrL)+1}= 'ENDOR_ODMR';
% StrL{numel(StrL)+1}= 'ENDOR_ODMR2';
% StrL{numel(StrL)+1}= 'ENDOR_Rabi';
% StrL{numel(StrL)+1}= 'ENDOR_NV_ODMR';
% StrL{numel(StrL)+1}= 'ENDOR_NV_Rabi';
% StrL{numel(StrL)+1}= 'ENDOR_NV_Rabi2';
% StrL{numel(StrL)+1}= 'Elec_Pol_Extract';
StrL{numel(StrL)+1}= 'Pi_Cali';
% StrL{numel(StrL)+1}= 'HalfPi_Cali';
% StrL{numel(StrL)+1}= 'Rabi_diff';
% StrL{numel(StrL)+1}= 'DROID60N_Cali';
% StrL{numel(StrL)+1}= 'Composite_Cali';
StrL{numel(StrL)+1}= 'Pi_Cali_SG2';
StrL{numel(StrL)+1}= 'Pi_Cali_SG3';
% StrL{numel(StrL)+1}= 'HalfPi_Cali_SG2';

function Rabi
global gmSEQ gSG
gSG.bfixedPow = 1;
gSG.bfixedFreq = 1;
gSG.bMod = 'IQ'; 
gSG.bModSrc = 'External';
T_AfterLaser = 2000;
% T_AfterLaser = 0.1e6; FUCK Yuanqi
T_AfterPulse = 1000; % FUCK Yuanqi
MWBuffer = 10; 

[gmSEQ.ScaleT, gmSEQ.ScaleStr] = GetScale(gmSEQ.To);

if strcmp(gmSEQ.meas,'APD') % If PL signal is collected via APD.
    gmSEQ.CtrGateDur = 1000;
end

% Pulse Blaster
gmSEQ.CHN(1).PBN = PBDictionary('ctr0');
gmSEQ.CHN(1).NRise = 2;
gmSEQ.CHN(1).T = [gmSEQ.readout - gmSEQ.CtrGateDur - 1000, ...
    gmSEQ.readout + T_AfterLaser + gmSEQ.To + T_AfterPulse];
gmSEQ.CHN(1).DT = [gmSEQ.CtrGateDur, gmSEQ.CtrGateDur];

gmSEQ.CHN(numel(gmSEQ.CHN) + 1).PBN = PBDictionary('MWSwitch');
gmSEQ.CHN(numel(gmSEQ.CHN)).NRise = 1;
gmSEQ.CHN(numel(gmSEQ.CHN)).T = gmSEQ.readout + T_AfterLaser - MWBuffer;
gmSEQ.CHN(numel(gmSEQ.CHN)).DT = gmSEQ.m + 2*MWBuffer;

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

gmSEQ.CHN(numel(gmSEQ.CHN) + 1).PBN = PBDictionary('AWGTrig');
gmSEQ.CHN(numel(gmSEQ.CHN)).NRise = 1;
gmSEQ.CHN(numel(gmSEQ.CHN)).T = gmSEQ.readout + T_AfterLaser;
gmSEQ.CHN(numel(gmSEQ.CHN)).DT = 1000;

% AWG.
chaseFunctionPool('stopChase', gmSEQ.P1AWG)
chaseFunctionPool('stopChase', gmSEQ.MWAWG)
if gSG.ACmodAWG % if we use AWG in AC modulation mode.
    WaveForm_1 = [0, gmSEQ.m, gSG.AWGFreq, 0*pi+0, gSG.AWGAmp];
    WaveForm_2 = [0, gmSEQ.m, gSG.AWGFreq, 0*pi-pi/2, gSG.AWGAmp];
else
    WaveForm_1 = [0, gmSEQ.m, gSG.AWGAmp];
    WaveForm_2 = [0, gmSEQ.m, 0];
end
WaveForm_Length = ceil((gmSEQ.m + 1000) / (16/gSG.AWGClockRate)) * (16/gSG.AWGClockRate);
WaveForm_PointNum = WaveForm_Length*gSG.AWGClockRate;

% gSG.AWGClockRate = 2; % in GHz. Yuanqi
% chaseFunctionPool('setClkRate', gmSEQ.MWAWG, gSG.AWGClockRate*1e9)
% pause(0.5)

chaseFunctionPool('createWaveform', WaveForm_1, ...
    gSG.AWGClockRate, WaveForm_Length, 'Rabi_Ch1.txt')
chaseFunctionPool('createWaveform', ...
    WaveForm_2, gSG.AWGClockRate, WaveForm_Length, 'Rabi_Ch2.txt')
chaseFunctionPool('CreateSingleSegment', gmSEQ.MWAWG, 1, ...
    WaveForm_PointNum, 1, 2047, 2047, 'Rabi_Ch1.txt', 1); 
pause(1.0);
chaseFunctionPool('CreateSingleSegment', gmSEQ.MWAWG, 2, ...
    WaveForm_PointNum, 1, 2047, 2047, 'Rabi_Ch2.txt', 1);
pause(1.0);
chaseFunctionPool('runChase', gmSEQ.MWAWG, 'false');
ApplyDelays();

function Rabi_SG2
global gmSEQ gSG gSG2
gSG.bfixedPow = 1;
gSG.bfixedFreq = 1;
gSG.bMod = 'IQ';
gSG.bModSrc = 'External';

SignalGeneratorFunctionPool2('WritePow');
SignalGeneratorFunctionPool2('WriteFreq');
gSG2.bOn=1; SignalGeneratorFunctionPool2('RFOnOff');

T_AfterLaser = 2000;
T_AfterPulse = 1000;

% Pulse Blaster
gmSEQ.CHN(1).PBN = PBDictionary('ctr0');
gmSEQ.CHN(1).NRise = 2;
gmSEQ.CHN(1).T = [gmSEQ.readout - gmSEQ.CtrGateDur - 1000, ...
    gmSEQ.readout + T_AfterLaser + gmSEQ.To + T_AfterPulse];
gmSEQ.CHN(1).DT = [gmSEQ.CtrGateDur, gmSEQ.CtrGateDur];

gmSEQ.CHN(numel(gmSEQ.CHN) + 1).PBN = PBDictionary('MWSwitch2');
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

gmSEQ.CHN(numel(gmSEQ.CHN) + 1).PBN = PBDictionary('AWGTrig2');
gmSEQ.CHN(numel(gmSEQ.CHN)).NRise = 1;
gmSEQ.CHN(numel(gmSEQ.CHN)).T = gmSEQ.readout + T_AfterLaser;
gmSEQ.CHN(numel(gmSEQ.CHN)).DT = 1000;

% AWG.
chaseFunctionPool('stopChase', gmSEQ.P1AWG)
if gSG2.ACmodAWG % if we use AWG in AC modulation mode.
    WaveForm_1 = [0, gmSEQ.m, gSG2.AWGFreq, 0*pi+0, gSG2.AWGAmp];
    WaveForm_2 = [0, gmSEQ.m, gSG2.AWGFreq, 0*pi-pi/2, gSG2.AWGAmp];
else
    WaveForm_1 = [0, gmSEQ.m, gSG2.AWGAmp];
    WaveForm_2 = [0, gmSEQ.m, 0];
end
WaveForm_Length = ceil((gmSEQ.m + 1000) / (16/gSG2.P1AWGClockRate)) * (16/gSG2.P1AWGClockRate);
WaveForm_PointNum = WaveForm_Length*gSG2.P1AWGClockRate;


chaseFunctionPool('createWaveform', WaveForm_1, ...
    gSG2.P1AWGClockRate, WaveForm_Length, 'Rabi_Ch1.txt')
chaseFunctionPool('createWaveform', WaveForm_2,...
    gSG2.P1AWGClockRate, WaveForm_Length, 'Rabi_Ch2.txt')
chaseFunctionPool('CreateSingleSegment', gmSEQ.P1AWG, 1, ...
    WaveForm_PointNum, 1, 2047, 2047, 'Rabi_Ch1.txt', 1); 
pause(1.0);
chaseFunctionPool('CreateSingleSegment', gmSEQ.P1AWG, 2, ...
    WaveForm_PointNum, 1, 2047, 2047, 'Rabi_Ch2.txt', 1);
pause(1.0);
chaseFunctionPool('runChase', gmSEQ.P1AWG, 'false');
ApplyDelays();

function Rabi_SG3
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

gmSEQ.CHN(numel(gmSEQ.CHN) + 1).PBN = PBDictionary('MWSwitch3');
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

gmSEQ.CHN(numel(gmSEQ.CHN) + 1).PBN = PBDictionary('AWGTrig3');
gmSEQ.CHN(numel(gmSEQ.CHN)).NRise = 1;
gmSEQ.CHN(numel(gmSEQ.CHN)).T = gmSEQ.readout + T_AfterLaser;
gmSEQ.CHN(numel(gmSEQ.CHN)).DT = 500;

% AWG.
chaseFunctionPool('stopChase', gmSEQ.MWAWG2)
if ~gSG.ACmodAWG % if we use AWG in AC modulation mode
    gSG3.AWGFreq = 0;
end
WaveForm_1 = [0, gmSEQ.m, gSG3.AWGFreq, 0*pi+0, gSG3.AWGAmp];
WaveForm_2 = [0, gmSEQ.m, gSG3.AWGFreq, 0*pi-pi/2, gSG3.AWGAmp];
WaveForm_Length = ceil((gmSEQ.m + 1000) / (16/gSG3.AWGClockRate)) * (16/gSG3.AWGClockRate);
WaveForm_PointNum = WaveForm_Length*gSG3.AWGClockRate;

chaseFunctionPool('createWaveform', WaveForm_1, ...
    gSG3.AWGClockRate, WaveForm_Length, 'Rabi_Ch1.txt')
chaseFunctionPool('createWaveform', WaveForm_2,...
    gSG3.AWGClockRate, WaveForm_Length, 'Rabi_Ch2.txt')

% chaseFunctionPool('CreateSingleSegment', gmSEQ.MWAWG2, 1, ...
%     WaveForm_PointNum, 1, 2047, 2047, 'Rabi_Ch1.txt', 1); 
% pause(1.0);
% chaseFunctionPool('CreateSingleSegment', gmSEQ.MWAWG2, 2, ...
%     WaveForm_PointNum, 1, 2047, 2047, 'Rabi_Ch2.txt', 1);
% pause(1.0);
chaseFunctionPool('createSegStruct', 'Rabi_SegStruct_I.txt', ...
    'Rabi_Ch1.txt', WaveForm_PointNum, 1, 1);
pause(0.5);
chaseFunctionPool('createSegStruct', 'Rabi_SegStruct_Q.txt', ...
    'Rabi_Ch2.txt', WaveForm_PointNum, 1, 1);
pause(0.5);
chaseFunctionPool('CreateSegments', gmSEQ.MWAWG2, 1, ...
    1, ...
    2047, 2047, 'Rabi_SegStruct_I.txt', 'false');
pause(1); % this pause seems to be important, otherwise the loading is not right occassionally
chaseFunctionPool('CreateSegments', gmSEQ.MWAWG2, 2, ...
    1, ...
    2047, 2047, 'Rabi_SegStruct_Q.txt', 'false');
pause(1); % this pause seems to be important, otherwise the loading is not right occassionally

chaseFunctionPool('runChase', gmSEQ.MWAWG2, 'false');
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

function SpinLocking
global gmSEQ gSG
gSG.bfixedPow=1;
gSG.bfixedFreq=1;
gSG.bMod='IQ';
gSG.bModSrc='External';

% Temp use. TODO: find an input window for this param
gmSEQ.LockingAmp = gmSEQ.SAmp1;

AfterPi = 2000;
AfterLaser = 0.1e6; % 0.1e6?
Wait_p = 0.1e6;
Detect_Window = 5000;
SpinLockGap = 10;

Sig_D_start = Wait_p+gmSEQ.readout+AfterLaser+gmSEQ.halfpi+SpinLockGap+gmSEQ.m+SpinLockGap+gmSEQ.halfpi+AfterPi+Detect_Window+Wait_p;

gmSEQ.CHN(1).PBN=PBDictionary('ctr0');
gmSEQ.CHN(1).NRise=4;
gmSEQ.CHN(1).T=[Wait_p+gmSEQ.readout-1000-gmSEQ.CtrGateDur, ...
    Wait_p+gmSEQ.readout+AfterLaser+gmSEQ.halfpi+SpinLockGap+gmSEQ.m+SpinLockGap+gmSEQ.halfpi+AfterPi, ...
    Sig_D_start+gmSEQ.readout-1000-gmSEQ.CtrGateDur, ... 
    Sig_D_start+gmSEQ.readout+AfterLaser+gmSEQ.halfpi+SpinLockGap+gmSEQ.m+SpinLockGap+gmSEQ.halfpi+AfterPi];
if strcmp(gmSEQ.meas,'SPCM')
    gmSEQ.CHN(1).DT=[gmSEQ.CtrGateDur gmSEQ.CtrGateDur gmSEQ.CtrGateDur gmSEQ.CtrGateDur];
elseif strcmp(gmSEQ.meas,'APD')
    gmSEQ.CHN(1).DT=[1000 1000 1000 1000];
end

gmSEQ.CHN(numel(gmSEQ.CHN)+1).PBN=PBDictionary('AOM');
gmSEQ.CHN(numel(gmSEQ.CHN)).NRise=4;
gmSEQ.CHN(numel(gmSEQ.CHN)).T = [Wait_p, Wait_p+gmSEQ.readout+AfterLaser+gmSEQ.halfpi+SpinLockGap+gmSEQ.m+SpinLockGap+gmSEQ.halfpi+AfterPi, ...
    Sig_D_start, Sig_D_start+gmSEQ.readout+AfterLaser+gmSEQ.halfpi+SpinLockGap+gmSEQ.m+SpinLockGap+gmSEQ.halfpi+AfterPi];
gmSEQ.CHN(numel(gmSEQ.CHN)).DT = [gmSEQ.readout Detect_Window gmSEQ.readout Detect_Window];

gmSEQ.CHN(numel(gmSEQ.CHN)+1).PBN=PBDictionary('AWGTrig');
gmSEQ.CHN(numel(gmSEQ.CHN)).NRise=2;
gmSEQ.CHN(numel(gmSEQ.CHN)).T=[Wait_p+gmSEQ.readout+AfterLaser, Sig_D_start+gmSEQ.readout+AfterLaser];
gmSEQ.CHN(numel(gmSEQ.CHN)).DT=[2150 2150];


gmSEQ.CHN(numel(gmSEQ.CHN)+1).PBN=PBDictionary('MWSwitch');
gmSEQ.CHN(numel(gmSEQ.CHN)).NRise=2;
gmSEQ.CHN(numel(gmSEQ.CHN)).T=[Wait_p+gmSEQ.readout+AfterLaser-20, Sig_D_start+gmSEQ.readout+AfterLaser-20];
gmSEQ.CHN(numel(gmSEQ.CHN)).DT=[gmSEQ.halfpi+SpinLockGap+gmSEQ.m+SpinLockGap+gmSEQ.halfpi+40, ... 
    gmSEQ.halfpi+SpinLockGap+gmSEQ.m+SpinLockGap+gmSEQ.halfpi+40];


gmSEQ.CHN(numel(gmSEQ.CHN)+1).PBN=PBDictionary('dummy1');
gmSEQ.CHN(numel(gmSEQ.CHN)).NRise=2;
gmSEQ.CHN(numel(gmSEQ.CHN)).T=[0 Sig_D_start+gmSEQ.readout+AfterLaser+gmSEQ.halfpi+SpinLockGap+gmSEQ.m+SpinLockGap+gmSEQ.halfpi+AfterPi+Detect_Window-50];
gmSEQ.CHN(numel(gmSEQ.CHN)).DT=[50 50];

%% AWG
% Initialization
chaseFunctionPool('stopChase',  gmSEQ.MWAWG)

% This part need to be modified to accomodate the DC modulation
if gSG.ACmodAWG % in AC modulation mode
    gSG.AWGFreq = gSG.AWGFreq;
else
    gSG.AWGFreq = 0;
end

WaveForm_1I = [0 gmSEQ.halfpi gSG.AWGFreq 0 gSG.AWGAmp;...
    gmSEQ.halfpi+SpinLockGap gmSEQ.halfpi+SpinLockGap+gmSEQ.m gSG.AWGFreq pi/2 gmSEQ.LockingAmp; ...
    gmSEQ.halfpi+SpinLockGap+gmSEQ.m+SpinLockGap gmSEQ.halfpi+SpinLockGap+gmSEQ.m+SpinLockGap+gmSEQ.halfpi gSG.AWGFreq pi gSG.AWGAmp];
WaveForm_1Q = WaveForm_1I - repmat([0 0 0 pi/2 0], size(WaveForm_1I, 1), 1);

WaveForm_1Length = ceil((gmSEQ.halfpi+gmSEQ.halfpi+SpinLockGap+gmSEQ.m+SpinLockGap+gmSEQ.halfpi+1000) / (16 / gSG.AWGClockRate)) ...
    *(16 / gSG.AWGClockRate);
WaveForm_1PointNum = WaveForm_1Length * gSG.AWGClockRate;

WaveForm_2I = WaveForm_1I;
WaveForm_2I(size(WaveForm_1I, 1), 4) = 0; % Differential measurement
WaveForm_2Q = WaveForm_1Q;
WaveForm_2Q(size(WaveForm_1I, 1), 4) = -pi/2; % Differential measurement
WaveForm_2Length = WaveForm_1Length;
WaveForm_2PointNum = WaveForm_2Length * gSG.AWGClockRate;
            

chaseFunctionPool('createWaveform', WaveForm_1I, gSG.AWGClockRate, WaveForm_1Length, 'SpinLocking_I_seg1.txt'); pause(0.5);
chaseFunctionPool('createWaveform', WaveForm_1Q, gSG.AWGClockRate, WaveForm_1Length, 'SpinLocking_Q_seg1.txt'); pause(0.5);
chaseFunctionPool('createWaveform', WaveForm_2I, gSG.AWGClockRate, WaveForm_2Length, 'SpinLocking_I_seg2.txt'); pause(0.5);
chaseFunctionPool('createWaveform', WaveForm_2Q, gSG.AWGClockRate, WaveForm_2Length, 'SpinLocking_Q_seg2.txt'); pause(0.5);

chaseFunctionPool('createSegStruct', 'SpinLocking_SegStruct_I.txt', ...
    'SpinLocking_I_seg1.txt', WaveForm_1PointNum, 1, 1, ...
    'SpinLocking_I_seg2.txt', WaveForm_2PointNum, 1, 1);
pause(0.5);
chaseFunctionPool('createSegStruct', 'SpinLocking_SegStruct_Q.txt', ...
    'SpinLocking_Q_seg1.txt', WaveForm_1PointNum, 1, 1, ...
    'SpinLocking_Q_seg2.txt', WaveForm_2PointNum, 1, 1);
pause(0.5);

%% Load waveform to AWG
chaseFunctionPool('CreateSegments', gmSEQ.MWAWG, 1, ...
    2, ...
    2047, 2047, 'SpinLocking_SegStruct_I.txt', 'false');
pause(1); % this pause seems to be important, otherwise the loading is not right occassionally
chaseFunctionPool('CreateSegments', gmSEQ.MWAWG, 2, ...
    2, ...
    2047, 2047, 'SpinLocking_SegStruct_Q.txt', 'false');
pause(1); % this pause seems to be important, otherwise the loading is not right occassionally
%% Run waveform
chaseFunctionPool('runChase', gmSEQ.MWAWG, 'false');
ApplyDelays();

function SpinLockingLOOP 
global gmSEQ gSG
gSG.bfixedPow=1;
gSG.bfixedFreq=1;
gSG.bMod='IQ';
gSG.bModSrc='External';

% Temp use. TODO: find an input window for this param
gSG.LockingAmp = gmSEQ.SAmp1;

AfterPi = 2000;
AfterLaser = 0.1e6; % 0.1e6?
Wait_p = max(gmSEQ.m, 0.1e6);
Detect_Window = 5000;

% Adjust the spinlockgap
SpinLockGap = 2;
SpinLockGap = ceil(gmSEQ.halfpi + SpinLockGap / (16 / gSG.AWGClockRate))*(16 / gSG.AWGClockRate) - gmSEQ.halfpi;
% Set the minimum block 
tunit = (16 / gSG.AWGClockRate) * 100; 
gmSEQ.m = ceil(gmSEQ.m / tunit) * tunit; 
gmSEQ.SweepParam = ceil(gmSEQ.SweepParam / tunit) * tunit; 

Sig_D_start = Wait_p+gmSEQ.readout+AfterLaser+gmSEQ.halfpi+SpinLockGap+gmSEQ.m+SpinLockGap+gmSEQ.halfpi+AfterPi+Detect_Window+Wait_p;

gmSEQ.CHN(1).PBN=PBDictionary('ctr0');
gmSEQ.CHN(1).NRise=4;
gmSEQ.CHN(1).T=[Wait_p+gmSEQ.readout-1000-gmSEQ.CtrGateDur, ...
    Wait_p+gmSEQ.readout+AfterLaser+gmSEQ.halfpi+SpinLockGap+gmSEQ.m+SpinLockGap+gmSEQ.halfpi+AfterPi, ...
    Sig_D_start+gmSEQ.readout-1000-gmSEQ.CtrGateDur, ... 
    Sig_D_start+gmSEQ.readout+AfterLaser+gmSEQ.halfpi+SpinLockGap+gmSEQ.m+SpinLockGap+gmSEQ.halfpi+AfterPi];
if strcmp(gmSEQ.meas,'SPCM')
    gmSEQ.CHN(1).DT=[gmSEQ.CtrGateDur gmSEQ.CtrGateDur gmSEQ.CtrGateDur gmSEQ.CtrGateDur];
elseif strcmp(gmSEQ.meas,'APD')
    gmSEQ.CHN(1).DT=[1000 1000 1000 1000];
end

gmSEQ.CHN(numel(gmSEQ.CHN)+1).PBN=PBDictionary('AOM');
gmSEQ.CHN(numel(gmSEQ.CHN)).NRise=4;
gmSEQ.CHN(numel(gmSEQ.CHN)).T = [Wait_p, Wait_p+gmSEQ.readout+AfterLaser+gmSEQ.halfpi+SpinLockGap+gmSEQ.m+SpinLockGap+gmSEQ.halfpi+AfterPi, ...
    Sig_D_start, Sig_D_start+gmSEQ.readout+AfterLaser+gmSEQ.halfpi+SpinLockGap+gmSEQ.m+SpinLockGap+gmSEQ.halfpi+AfterPi];
gmSEQ.CHN(numel(gmSEQ.CHN)).DT = [gmSEQ.readout Detect_Window gmSEQ.readout Detect_Window];

gmSEQ.CHN(numel(gmSEQ.CHN)+1).PBN=PBDictionary('AWGTrig');
gmSEQ.CHN(numel(gmSEQ.CHN)).NRise=2;
gmSEQ.CHN(numel(gmSEQ.CHN)).T=[Wait_p+gmSEQ.readout+AfterLaser, Sig_D_start+gmSEQ.readout+AfterLaser];
gmSEQ.CHN(numel(gmSEQ.CHN)).DT=[2150 2150];

gmSEQ.CHN(numel(gmSEQ.CHN)+1).PBN=PBDictionary('MWSwitch');
gmSEQ.CHN(numel(gmSEQ.CHN)).NRise=2;
gmSEQ.CHN(numel(gmSEQ.CHN)).T=[Wait_p+gmSEQ.readout+AfterLaser-20, Sig_D_start+gmSEQ.readout+AfterLaser-20];
gmSEQ.CHN(numel(gmSEQ.CHN)).DT=[gmSEQ.halfpi+SpinLockGap+gmSEQ.m+SpinLockGap+gmSEQ.halfpi+40, ... 
    gmSEQ.halfpi+SpinLockGap+gmSEQ.m+SpinLockGap+gmSEQ.halfpi+40];

gmSEQ.CHN(numel(gmSEQ.CHN)+1).PBN=PBDictionary('dummy1');
gmSEQ.CHN(numel(gmSEQ.CHN)).NRise=2;
gmSEQ.CHN(numel(gmSEQ.CHN)).T=[0 Sig_D_start+gmSEQ.readout+AfterLaser+gmSEQ.halfpi+SpinLockGap+gmSEQ.m+SpinLockGap+gmSEQ.halfpi+AfterPi+Detect_Window-50];
gmSEQ.CHN(numel(gmSEQ.CHN)).DT=[50 50];

%% AWG
% Initialization
chaseFunctionPool('stopChase', gmSEQ.MWAWG)

% This part need to be modified to accomodate the DC modulation
if gSG.ACmodAWG % in AC modulation mode
    gSG.AWGFreq = gSG.AWGFreq;
else
    gSG.AWGFreq = 0;
end

% Check whether the modulation frequency is legal or not.
if rem(tunit * gSG.AWGFreq, 1) ~= 0
    warning('The modulation frequency is incompatible with the AWG minimum time unit.');
end

WaveForm_1I = [0 gmSEQ.halfpi gSG.AWGFreq 0 gSG.AWGAmp];
WaveForm_1Q = WaveForm_1I - repmat([0 0 0 pi/2 0], size(WaveForm_1I, 1), 1);
WaveForm_1Length = gmSEQ.halfpi + SpinLockGap;
WaveForm_1PointNum = WaveForm_1Length * gSG.AWGClockRate;

phaseRef = 2*pi*rem(gSG.AWGFreq*WaveForm_1Length, 1); % adjust the phase between pulses

WaveForm_2I = [0 tunit gSG.AWGFreq phaseRef+pi/2 gSG.LockingAmp];
WaveForm_2Q = WaveForm_2I - repmat([0 0 0 pi/2 0], size(WaveForm_2I, 1), 1);
WaveForm_2Length = tunit;
WaveForm_2PointNum = WaveForm_2Length * gSG.AWGClockRate;

WaveForm_3I = [0 SpinLockGap 0 0 0; ...
    SpinLockGap SpinLockGap+gmSEQ.halfpi gSG.AWGFreq phaseRef+pi gSG.AWGAmp];
WaveForm_3Q = WaveForm_3I - repmat([0 0 0 pi/2 0], size(WaveForm_3I, 1), 1);
WaveForm_3Length = gmSEQ.halfpi + SpinLockGap;
WaveForm_3PointNum = WaveForm_3Length * gSG.AWGClockRate;

WaveForm_4I = [0 SpinLockGap 0 0 0; ...
    SpinLockGap SpinLockGap+gmSEQ.halfpi gSG.AWGFreq phaseRef+0 gSG.AWGAmp];
WaveForm_4Q = WaveForm_4I - repmat([0 0 0 pi/2 0], size(WaveForm_4I, 1), 1);
WaveForm_4Length = gmSEQ.halfpi + SpinLockGap;
WaveForm_4PointNum = WaveForm_4Length * gSG.AWGClockRate;

if rem(WaveForm_1PointNum, 16) ~= 0 || rem(WaveForm_2PointNum, 16) ~= 0  || rem(WaveForm_3PointNum, 16) ~= 0 
   warning('The waveform point number is not a mulutple of 16.') 
end
if rem(gmSEQ.m/tunit, 1) ~= 0 
   warning('gmSEQ.m is not a multiple of minimum time unit.') 
end

chaseFunctionPool('createWaveform', WaveForm_1I, gSG.AWGClockRate, WaveForm_1Length, 'SpinLocking_I_seg1.txt'); pause(0.5);
chaseFunctionPool('createWaveform', WaveForm_1Q, gSG.AWGClockRate, WaveForm_1Length, 'SpinLocking_Q_seg1.txt'); pause(0.5);
chaseFunctionPool('createWaveform', WaveForm_2I, gSG.AWGClockRate, WaveForm_2Length, 'SpinLocking_I_seg2.txt'); pause(0.5);
chaseFunctionPool('createWaveform', WaveForm_2Q, gSG.AWGClockRate, WaveForm_2Length, 'SpinLocking_Q_seg2.txt'); pause(0.5);
chaseFunctionPool('createWaveform', WaveForm_3I, gSG.AWGClockRate, WaveForm_3Length, 'SpinLocking_I_seg3.txt'); pause(0.5);
chaseFunctionPool('createWaveform', WaveForm_3Q, gSG.AWGClockRate, WaveForm_3Length, 'SpinLocking_Q_seg3.txt'); pause(0.5);
chaseFunctionPool('createWaveform', WaveForm_4I, gSG.AWGClockRate, WaveForm_4Length, 'SpinLocking_I_seg4.txt'); pause(0.5);
chaseFunctionPool('createWaveform', WaveForm_4Q, gSG.AWGClockRate, WaveForm_4Length, 'SpinLocking_Q_seg4.txt'); pause(0.5);

chaseFunctionPool('createSegStruct', 'SpinLocking_SegStruct_I.txt', ...
    'SpinLocking_I_seg1.txt', WaveForm_1PointNum, 1, 1, ...
    'SpinLocking_I_seg2.txt', WaveForm_2PointNum, round(gmSEQ.m/tunit), 0, ...
    'SpinLocking_I_seg3.txt', WaveForm_3PointNum, 1, 0, ...
    'SpinLocking_I_seg1.txt', WaveForm_1PointNum, 1, 1, ...
    'SpinLocking_I_seg2.txt', WaveForm_2PointNum, round(gmSEQ.m/tunit), 0, ...
    'SpinLocking_I_seg4.txt', WaveForm_4PointNum, 1, 0);
pause(0.5);
chaseFunctionPool('createSegStruct', 'SpinLocking_SegStruct_Q.txt', ...
    'SpinLocking_Q_seg1.txt', WaveForm_1PointNum, 1, 1, ...
    'SpinLocking_Q_seg2.txt', WaveForm_2PointNum, round(gmSEQ.m/tunit), 0, ...
    'SpinLocking_Q_seg3.txt', WaveForm_3PointNum, 1, 0, ...
    'SpinLocking_Q_seg1.txt', WaveForm_1PointNum, 1, 1, ...
    'SpinLocking_Q_seg2.txt', WaveForm_2PointNum, round(gmSEQ.m/tunit), 0, ...
    'SpinLocking_Q_seg4.txt', WaveForm_4PointNum, 1, 0);
pause(0.5);

%% Load waveform to AWG
chaseFunctionPool('CreateSegments', gmSEQ.MWAWG, 1, ...
    6, ...
    2047, 2047, 'SpinLocking_SegStruct_I.txt', 'false');
pause(1); % this pause seems to be important, otherwise the loading is not right occassionally
chaseFunctionPool('CreateSegments', gmSEQ.MWAWG, 2, ...
    6, ...
    2047, 2047, 'SpinLocking_SegStruct_Q.txt', 'false');
pause(1); % this pause seems to be important, otherwise the loading is not right occassionally
%% Run waveform
chaseFunctionPool('runChase', gmSEQ.MWAWG, 'false');
ApplyDelays();

function SpinLockingLOOPP1 % have not tested yet
global gmSEQ gSG gSG2
gSG.bfixedPow=1;
gSG.bfixedFreq=1;
gSG.bMod='IQ';
gSG.bModSrc='External';

gSG2.bMod='IQ';
gSG2.bModSrc='External';
SignalGeneratorFunctionPool2('SetMod');

SignalGeneratorFunctionPool2('WritePow');
SignalGeneratorFunctionPool2('WriteFreq');
gSG2.bOn=1; SignalGeneratorFunctionPool2('RFOnOff');

% Temp use. TODO: find an input window for this param
gSG.LockingAmp = gmSEQ.SAmp1;
gSG2.LockingAmp = gmSEQ.SAmp2;

AfterPi = 1000;
AfterLaser = 2000; % reduced from 0.5e6 01/27/2022 Weijie
Wait_p = 0.1e6;
Detect_Window = 5000;

% Adjust the spinlockgap
SpinLockGap = 2;
SpinLockGap = ceil(gmSEQ.halfpi + SpinLockGap / (16 / gSG.AWGClockRate))*(16 / gSG.AWGClockRate) - gmSEQ.halfpi;
% Set the minimum block 
tunit = (16 / gSG.AWGClockRate) * 100; % Assume two AWG have the sample clock rate here
gmSEQ.m = ceil(gmSEQ.m / tunit) * tunit; 
gmSEQ.SweepParam = ceil(gmSEQ.SweepParam / tunit) * tunit; 

Sig_D_start = Wait_p+gmSEQ.readout+AfterLaser+gmSEQ.halfpi+SpinLockGap+gmSEQ.m+SpinLockGap+gmSEQ.halfpi+AfterPi+Detect_Window+Wait_p;

gmSEQ.CHN(1).PBN=PBDictionary('ctr0');
gmSEQ.CHN(1).NRise=4;
gmSEQ.CHN(1).T=[Wait_p+gmSEQ.readout-1000-gmSEQ.CtrGateDur, ...
    Wait_p+gmSEQ.readout+AfterLaser+gmSEQ.halfpi+SpinLockGap+gmSEQ.m+SpinLockGap+gmSEQ.halfpi+AfterPi, ...
    Sig_D_start+gmSEQ.readout-1000-gmSEQ.CtrGateDur, ... 
    Sig_D_start+gmSEQ.readout+AfterLaser+gmSEQ.halfpi+SpinLockGap+gmSEQ.m+SpinLockGap+gmSEQ.halfpi+AfterPi];
if strcmp(gmSEQ.meas,'SPCM')
    gmSEQ.CHN(1).DT=[gmSEQ.CtrGateDur gmSEQ.CtrGateDur gmSEQ.CtrGateDur gmSEQ.CtrGateDur];
elseif strcmp(gmSEQ.meas,'APD')
    gmSEQ.CHN(1).DT=[1000 1000 1000 1000];
end

gmSEQ.CHN(numel(gmSEQ.CHN)+1).PBN=PBDictionary('AOM');
gmSEQ.CHN(numel(gmSEQ.CHN)).NRise=4;
gmSEQ.CHN(numel(gmSEQ.CHN)).T = [Wait_p, Wait_p+gmSEQ.readout+AfterLaser+gmSEQ.halfpi+SpinLockGap+gmSEQ.m+SpinLockGap+gmSEQ.halfpi+AfterPi, ...
    Sig_D_start, Sig_D_start+gmSEQ.readout+AfterLaser+gmSEQ.halfpi+SpinLockGap+gmSEQ.m+SpinLockGap+gmSEQ.halfpi+AfterPi];
gmSEQ.CHN(numel(gmSEQ.CHN)).DT = [gmSEQ.readout Detect_Window gmSEQ.readout Detect_Window];

gmSEQ.CHN(numel(gmSEQ.CHN)+1).PBN=PBDictionary('AWGTrig');
gmSEQ.CHN(numel(gmSEQ.CHN)).NRise=2;
gmSEQ.CHN(numel(gmSEQ.CHN)).T=[Wait_p+gmSEQ.readout+AfterLaser, Sig_D_start+gmSEQ.readout+AfterLaser];
gmSEQ.CHN(numel(gmSEQ.CHN)).DT=[2000 2000];

gmSEQ.CHN(numel(gmSEQ.CHN)+1).PBN=PBDictionary('AWGTrig2');
gmSEQ.CHN(numel(gmSEQ.CHN)).NRise=2;
gmSEQ.CHN(numel(gmSEQ.CHN)).T=[Wait_p+gmSEQ.readout+AfterLaser+gmSEQ.halfpi+SpinLockGap, ...
    Sig_D_start+gmSEQ.readout+AfterLaser+gmSEQ.halfpi+SpinLockGap];
gmSEQ.CHN(numel(gmSEQ.CHN)).DT=[2000 2000];

gmSEQ.CHN(numel(gmSEQ.CHN)+1).PBN=PBDictionary('MWSwitch');
gmSEQ.CHN(numel(gmSEQ.CHN)).NRise=2;
gmSEQ.CHN(numel(gmSEQ.CHN)).T=[Wait_p+gmSEQ.readout+AfterLaser-20, Sig_D_start+gmSEQ.readout+AfterLaser-20];
gmSEQ.CHN(numel(gmSEQ.CHN)).DT=[gmSEQ.halfpi+SpinLockGap+gmSEQ.m+SpinLockGap+gmSEQ.halfpi+40, ... 
    gmSEQ.halfpi+SpinLockGap+gmSEQ.m+SpinLockGap+gmSEQ.halfpi+40];

gmSEQ.CHN(numel(gmSEQ.CHN)+1).PBN=PBDictionary('MWSwitch2');
gmSEQ.CHN(numel(gmSEQ.CHN)).NRise=2;
gmSEQ.CHN(numel(gmSEQ.CHN)).T=[Wait_p+gmSEQ.readout+AfterLaser+gmSEQ.halfpi+SpinLockGap-20, ...
    Sig_D_start+gmSEQ.readout+AfterLaser+gmSEQ.halfpi+SpinLockGap-20];
gmSEQ.CHN(numel(gmSEQ.CHN)).DT=[gmSEQ.m+40 gmSEQ.m+40];

gmSEQ.CHN(numel(gmSEQ.CHN)+1).PBN=PBDictionary('dummy1');
gmSEQ.CHN(numel(gmSEQ.CHN)).NRise=2;
gmSEQ.CHN(numel(gmSEQ.CHN)).T=[0 Sig_D_start+gmSEQ.readout+AfterLaser+gmSEQ.halfpi+SpinLockGap+gmSEQ.m+SpinLockGap+gmSEQ.halfpi+AfterPi+Detect_Window-50];
gmSEQ.CHN(numel(gmSEQ.CHN)).DT=[50 50];

%% AWG
% Initialization
chaseFunctionPool('stopChase', gmSEQ.MWAWG)
chaseFunctionPool('stopChase', gmSEQ.P1AWG);

% This part need to be modified to accomodate the DC modulation
if gSG.ACmodAWG % in AC modulation mode
    gSG.AWGFreq = gSG.AWGFreq;
    gSG2.AWGFreq = gSG2.AWGFreq;
else
    gSG.AWGFreq = 0;
    gSG2.AWGFreq = 0;
end

% Check whether the modulation frequency is legal or not.
if rem(tunit * gSG.AWGFreq, 1) ~= 0 || rem(tunit * gSG2.AWGFreq, 1) ~= 0 
    warning('The modulation frequency is incompatible with the AWG minimum time unit.');
end

WaveForm_1I = [0 gmSEQ.halfpi gSG.AWGFreq 0 gSG.AWGAmp];
WaveForm_1Q = WaveForm_1I - repmat([0 0 0 pi/2 0], size(WaveForm_1I, 1), 1);
WaveForm_1Length = gmSEQ.halfpi + SpinLockGap;
WaveForm_1PointNum = WaveForm_1Length * gSG.AWGClockRate;

phaseRef = 2*pi*rem(gSG.AWGFreq*WaveForm_1Length, 1); % adjust the phase between pulses

WaveForm_2I = [0 tunit gSG.AWGFreq phaseRef+pi/2 gSG.LockingAmp];
WaveForm_2Q = WaveForm_2I - repmat([0 0 0 pi/2 0], size(WaveForm_2I, 1), 1);
WaveForm_2Length = tunit;
WaveForm_2PointNum = WaveForm_2Length * gSG.AWGClockRate;

WaveForm_3I = [0 SpinLockGap 0 0 0; ...
    SpinLockGap SpinLockGap+gmSEQ.halfpi gSG.AWGFreq phaseRef+pi gSG.AWGAmp];
WaveForm_3Q = WaveForm_3I - repmat([0 0 0 pi/2 0], size(WaveForm_3I, 1), 1);
WaveForm_3Length = gmSEQ.halfpi + SpinLockGap;
WaveForm_3PointNum = WaveForm_3Length * gSG.AWGClockRate;

WaveForm_4I = [0 SpinLockGap 0 0 0; ...
    SpinLockGap SpinLockGap+gmSEQ.halfpi gSG.AWGFreq phaseRef+0 gSG.AWGAmp];
WaveForm_4Q = WaveForm_4I - repmat([0 0 0 pi/2 0], size(WaveForm_4I, 1), 1);
WaveForm_4Length = gmSEQ.halfpi + SpinLockGap;
WaveForm_4PointNum = WaveForm_4Length * gSG.AWGClockRate;

% P1 sequence
WaveForm_5I = [0 tunit gSG2.AWGFreq 0 gSG2.LockingAmp];
WaveForm_5Q = WaveForm_5I - repmat([0 0 0 pi/2 0], size(WaveForm_5I, 1), 1);
WaveForm_5Length = tunit;
WaveForm_5PointNum = WaveForm_5Length * gSG2.P1AWGClockRate;

if rem(WaveForm_1PointNum, 16) ~= 0 || rem(WaveForm_2PointNum, 16) ~= 0  ... 
        || rem(WaveForm_3PointNum, 16) ~= 0 || rem(WaveForm_5PointNum, 16) ~= 0
   warning('The waveform point number is not a mulutple of 16.') 
end
if rem(gmSEQ.m/tunit, 1) ~= 0 
   warning('gmSEQ.m is not a multiple of minimum time unit.') 
end

chaseFunctionPool('createWaveform', WaveForm_1I, gSG.AWGClockRate, WaveForm_1Length, 'SpinLockLOOPP1_I_seg1.txt'); pause(0.5);
chaseFunctionPool('createWaveform', WaveForm_1Q, gSG.AWGClockRate, WaveForm_1Length, 'SpinLockLOOPP1_Q_seg1.txt'); pause(0.5);
chaseFunctionPool('createWaveform', WaveForm_2I, gSG.AWGClockRate, WaveForm_2Length, 'SpinLockLOOPP1_I_seg2.txt'); pause(0.5);
chaseFunctionPool('createWaveform', WaveForm_2Q, gSG.AWGClockRate, WaveForm_2Length, 'SpinLockLOOPP1_Q_seg2.txt'); pause(0.5);
chaseFunctionPool('createWaveform', WaveForm_3I, gSG.AWGClockRate, WaveForm_3Length, 'SpinLockLOOPP1_I_seg3.txt'); pause(0.5);
chaseFunctionPool('createWaveform', WaveForm_3Q, gSG.AWGClockRate, WaveForm_3Length, 'SpinLockLOOPP1_Q_seg3.txt'); pause(0.5);
chaseFunctionPool('createWaveform', WaveForm_4I, gSG.AWGClockRate, WaveForm_4Length, 'SpinLockLOOPP1_I_seg4.txt'); pause(0.5);
chaseFunctionPool('createWaveform', WaveForm_4Q, gSG.AWGClockRate, WaveForm_4Length, 'SpinLockLOOPP1_Q_seg4.txt'); pause(0.5);
chaseFunctionPool('createWaveform', WaveForm_5I, gSG2.P1AWGClockRate, WaveForm_5Length, 'SpinLockLOOPP1_I_seg5.txt'); pause(0.5);
chaseFunctionPool('createWaveform', WaveForm_5Q, gSG2.P1AWGClockRate, WaveForm_5Length, 'SpinLockLOOPP1_Q_seg5.txt'); pause(0.5);

chaseFunctionPool('createSegStruct', 'SpinLockLOOPP1_SegStruct_I.txt', ...
    'SpinLockLOOPP1_I_seg1.txt', WaveForm_1PointNum, 1, 1, ...
    'SpinLockLOOPP1_I_seg2.txt', WaveForm_2PointNum, round(gmSEQ.m/tunit), 0, ...
    'SpinLockLOOPP1_I_seg3.txt', WaveForm_3PointNum, 1, 0, ...
    'SpinLockLOOPP1_I_seg1.txt', WaveForm_1PointNum, 1, 1, ...
    'SpinLockLOOPP1_I_seg2.txt', WaveForm_2PointNum, round(gmSEQ.m/tunit), 0, ...
    'SpinLockLOOPP1_I_seg4.txt', WaveForm_4PointNum, 1, 0);
pause(0.5);
chaseFunctionPool('createSegStruct', 'SpinLockLOOPP1_SegStruct_Q.txt', ...
    'SpinLockLOOPP1_Q_seg1.txt', WaveForm_1PointNum, 1, 1, ...
    'SpinLockLOOPP1_Q_seg2.txt', WaveForm_2PointNum, round(gmSEQ.m/tunit), 0, ...
    'SpinLockLOOPP1_Q_seg3.txt', WaveForm_3PointNum, 1, 0, ...
    'SpinLockLOOPP1_Q_seg1.txt', WaveForm_1PointNum, 1, 1, ...
    'SpinLockLOOPP1_Q_seg2.txt', WaveForm_2PointNum, round(gmSEQ.m/tunit), 0, ...
    'SpinLockLOOPP1_Q_seg4.txt', WaveForm_4PointNum, 1, 0);
pause(0.5);

% Need further modification
if round(gmSEQ.m/tunit) > 1
    chaseFunctionPool('createSegStruct', 'SpinLockLOOPP1_P1_SegStruct_I.txt', ...
        'SpinLockLOOPP1_I_seg5.txt', WaveForm_5PointNum, 1, 1, ...
        'SpinLockLOOPP1_I_seg5.txt', WaveForm_5PointNum, round(gmSEQ.m/tunit)-1, 0);
    pause(0.5);
    chaseFunctionPool('createSegStruct', 'SpinLockLOOPP1_P1_SegStruct_Q.txt', ...
        'SpinLockLOOPP1_Q_seg5.txt', WaveForm_5PointNum, 1, 1, ...
        'SpinLockLOOPP1_Q_seg5.txt', WaveForm_5PointNum, round(gmSEQ.m/tunit)-1, 0);
    pause(0.5);
else
    chaseFunctionPool('createSegStruct', 'SpinLockLOOPP1_P1_SegStruct_I.txt', ...
        'SpinLockLOOPP1_I_seg5.txt', WaveForm_5PointNum, round(gmSEQ.m/tunit), 1);
    pause(0.5);
    chaseFunctionPool('createSegStruct', 'SpinLockLOOPP1_P1_SegStruct_Q.txt', ...
        'SpinLockLOOPP1_Q_seg5.txt', WaveForm_5PointNum, round(gmSEQ.m/tunit), 1);
    pause(0.5);
end

%% Load waveform to AWG
chaseFunctionPool('CreateSegments', gmSEQ.MWAWG, 1, ...
    6, ...
    2047, 2047, 'SpinLockLOOPP1_SegStruct_I.txt', 'false');
pause(1); % this pause seems to be important, otherwise the loading is not right occassionally
chaseFunctionPool('CreateSegments', gmSEQ.MWAWG, 2, ...
    6, ...
    2047, 2047, 'SpinLockLOOPP1_SegStruct_Q.txt', 'false');
pause(1); % this pause seems to be important, otherwise the loading is not right occassionally
chaseFunctionPool('CreateSegments', gmSEQ.P1AWG, 1, ...
    1, ...
    2047, 2047, 'SpinLockLOOPP1_P1_SegStruct_I.txt', 'false');
pause(1); % this pause seems to be important, otherwise the loading is not right occassionally   
chaseFunctionPool('CreateSegments', gmSEQ.P1AWG, 2, ...
    1, ...
    2047, 2047, 'SpinLockLOOPP1_P1_SegStruct_Q.txt', 'false');
pause(1); % this pause seems to be important, otherwise the loading is not right occassionally 
%% Run waveform
chaseFunctionPool('runChase', gmSEQ.MWAWG, 'false'); pause(1);
chaseFunctionPool('runChase', gmSEQ.P1AWG, 'false'); pause(1);
ApplyDelays();

function PolarP1Res_LOOP % have not tested yet
disp("This is the LOOP version")
% Tune the AWG amplitude so that NV and P1 are resonant in the rotating frame
global gmSEQ gSG gSG2
gSG.bfixedPow=1;
gSG.bfixedFreq=1;
gSG.bMod='IQ';
gSG.bModSrc='External';

gSG2.bMod='IQ';
gSG2.bModSrc='External';
SignalGeneratorFunctionPool2('SetMod');

SignalGeneratorFunctionPool2('WritePow');
SignalGeneratorFunctionPool2('WriteFreq');
gSG2.bOn=1; SignalGeneratorFunctionPool2('RFOnOff');

% TODO: find an input window for this param
gSG.LockingAmp = gmSEQ.SAmp1;
gSG2.LockingAmp = gmSEQ.m;

AfterPi = 1000;
AfterLaser = 2000; % 0.1e6?
Detect_Window = 5000;
NDepol = 4; % Depolarization pulse for P1
IntDepol = 0.5e6;
Wait_p = NDepol*IntDepol + 2e6;

% Adjust the spinlockgap
SpinLockGap = 2;
SpinLockGap = ceil(gmSEQ.halfpi + SpinLockGap / (16 / gSG.AWGClockRate))*(16 / gSG.AWGClockRate) - gmSEQ.halfpi;
% Set the minimum block 
tunit = (16 / gSG.AWGClockRate) * 100; % Assume two AWG have the same clock rate here
gmSEQ.DEERt = ceil(gmSEQ.DEERt / tunit) * tunit; 

Sig_D_start = Wait_p+gmSEQ.readout+AfterLaser+gmSEQ.halfpi+SpinLockGap+gmSEQ.DEERt+SpinLockGap+gmSEQ.halfpi+AfterPi+Detect_Window+Wait_p;

gmSEQ.CHN(1).PBN=PBDictionary('ctr0');
gmSEQ.CHN(1).NRise=4;
gmSEQ.CHN(1).T=[Wait_p+gmSEQ.readout-1000-gmSEQ.CtrGateDur, ...
    Wait_p+gmSEQ.readout+AfterLaser+gmSEQ.halfpi+SpinLockGap+gmSEQ.DEERt+SpinLockGap+gmSEQ.halfpi+AfterPi, ...
    Sig_D_start+gmSEQ.readout-1000-gmSEQ.CtrGateDur, ... 
    Sig_D_start+gmSEQ.readout+AfterLaser+gmSEQ.halfpi+SpinLockGap+gmSEQ.DEERt+SpinLockGap+gmSEQ.halfpi+AfterPi];
if strcmp(gmSEQ.meas,'SPCM')
    gmSEQ.CHN(1).DT=[gmSEQ.CtrGateDur gmSEQ.CtrGateDur gmSEQ.CtrGateDur gmSEQ.CtrGateDur];
elseif strcmp(gmSEQ.meas,'APD')
    gmSEQ.CHN(1).DT=[1000 1000 1000 1000];
end

gmSEQ.CHN(numel(gmSEQ.CHN)+1).PBN=PBDictionary('AOM');
gmSEQ.CHN(numel(gmSEQ.CHN)).NRise=4;
gmSEQ.CHN(numel(gmSEQ.CHN)).T = [Wait_p, Wait_p+gmSEQ.readout+AfterLaser+gmSEQ.halfpi+SpinLockGap+gmSEQ.DEERt+SpinLockGap+gmSEQ.halfpi+AfterPi, ...
    Sig_D_start, Sig_D_start+gmSEQ.readout+AfterLaser+gmSEQ.halfpi+SpinLockGap+gmSEQ.DEERt+SpinLockGap+gmSEQ.halfpi+AfterPi];
gmSEQ.CHN(numel(gmSEQ.CHN)).DT = [gmSEQ.readout Detect_Window gmSEQ.readout Detect_Window];

gmSEQ.CHN(numel(gmSEQ.CHN)+1).PBN=PBDictionary('AWGTrig');
gmSEQ.CHN(numel(gmSEQ.CHN)).NRise=2;
gmSEQ.CHN(numel(gmSEQ.CHN)).T=[Wait_p+gmSEQ.readout+AfterLaser, Sig_D_start+gmSEQ.readout+AfterLaser];
gmSEQ.CHN(numel(gmSEQ.CHN)).DT=[2000 2000];

gmSEQ.CHN(numel(gmSEQ.CHN)+1).PBN=PBDictionary('AWGTrig2');
gmSEQ.CHN(numel(gmSEQ.CHN)).NRise=2*(1+NDepol);
gmSEQ.CHN(numel(gmSEQ.CHN)).T=[(1:NDepol)*IntDepol-gmSEQ.DEERpi/2,  Wait_p+gmSEQ.readout+AfterLaser+gmSEQ.halfpi+SpinLockGap, ...
     Sig_D_start-Wait_p+(1:NDepol)*IntDepol-gmSEQ.DEERpi/2, Sig_D_start+gmSEQ.readout+AfterLaser+gmSEQ.halfpi+SpinLockGap];
gmSEQ.CHN(numel(gmSEQ.CHN)).DT=repelem(2000, 2*(1+NDepol));

gmSEQ.CHN(numel(gmSEQ.CHN)+1).PBN=PBDictionary('MWSwitch');
gmSEQ.CHN(numel(gmSEQ.CHN)).NRise=2;
gmSEQ.CHN(numel(gmSEQ.CHN)).T=[Wait_p+gmSEQ.readout+AfterLaser-20, Sig_D_start+gmSEQ.readout+AfterLaser-20];
gmSEQ.CHN(numel(gmSEQ.CHN)).DT=[gmSEQ.halfpi+SpinLockGap+gmSEQ.DEERt+SpinLockGap+gmSEQ.halfpi+40, ... 
    gmSEQ.halfpi+SpinLockGap+gmSEQ.DEERt+SpinLockGap+gmSEQ.halfpi+40];

gmSEQ.CHN(numel(gmSEQ.CHN)+1).PBN=PBDictionary('MWSwitch2');
gmSEQ.CHN(numel(gmSEQ.CHN)).NRise=2*(1+NDepol);
gmSEQ.CHN(numel(gmSEQ.CHN)).T=[(1:NDepol)*IntDepol-gmSEQ.DEERpi/2-20, Wait_p+gmSEQ.readout+AfterLaser-20,... 
    Sig_D_start-Wait_p+(1:NDepol)*IntDepol-gmSEQ.DEERpi/2-20, Sig_D_start+gmSEQ.readout+AfterLaser-20];
gmSEQ.CHN(numel(gmSEQ.CHN)).DT=[repelem(gmSEQ.DEERpi/2+40, NDepol), gmSEQ.halfpi+SpinLockGap+gmSEQ.DEERt+SpinLockGap+gmSEQ.halfpi+40, ... 
    repelem(gmSEQ.DEERpi/2+40, NDepol), gmSEQ.halfpi+SpinLockGap+gmSEQ.DEERt+SpinLockGap+gmSEQ.halfpi+40];

gmSEQ.CHN(numel(gmSEQ.CHN)+1).PBN=PBDictionary('dummy1');
gmSEQ.CHN(numel(gmSEQ.CHN)).NRise=2;
gmSEQ.CHN(numel(gmSEQ.CHN)).T=[0 Sig_D_start+gmSEQ.readout+AfterLaser+gmSEQ.halfpi+SpinLockGap+gmSEQ.DEERt+SpinLockGap+gmSEQ.halfpi+AfterPi+Detect_Window-50];
gmSEQ.CHN(numel(gmSEQ.CHN)).DT=[50 50];

%% AWG
% Initialization
chaseFunctionPool('stopChase', gmSEQ.MWAWG)
chaseFunctionPool('stopChase', gmSEQ.P1AWG);

% This part need to be modified to accomodate the DC modulation
if gSG.ACmodAWG % in AC modulation mode
    gSG.AWGFreq = gSG.AWGFreq;
    gSG2.AWGFreq = gSG2.AWGFreq;
else
    gSG.AWGFreq = 0;
    gSG2.AWGFreq = 0;
end

% Check whether the modulation frequency is legal or not.
if rem(tunit * gSG.AWGFreq, 1) ~= 0 || rem(tunit * gSG2.AWGFreq, 1) ~= 0 
    warning('The modulation frequency is incompatible with the AWG minimum time unit.');
end

WaveForm_1I = [0 gmSEQ.halfpi gSG.AWGFreq 0 gSG.AWGAmp];
WaveForm_1Q = WaveForm_1I - repmat([0 0 0 pi/2 0], size(WaveForm_1I, 1), 1);
WaveForm_1Length = gmSEQ.halfpi + SpinLockGap;
WaveForm_1PointNum = WaveForm_1Length * gSG.AWGClockRate;

phaseRef = 2*pi*rem(gSG.AWGFreq*WaveForm_1Length, 1); % adjust the phase between pulses

WaveForm_2I = [0 tunit gSG.AWGFreq phaseRef+pi/2 gSG.LockingAmp];
WaveForm_2Q = WaveForm_2I - repmat([0 0 0 pi/2 0], size(WaveForm_2I, 1), 1);
WaveForm_2Length = tunit;
WaveForm_2PointNum = WaveForm_2Length * gSG.AWGClockRate;

WaveForm_3I = [0 SpinLockGap 0 0 0; ...
    SpinLockGap SpinLockGap+gmSEQ.halfpi gSG.AWGFreq phaseRef+pi gSG.AWGAmp];
WaveForm_3Q = WaveForm_3I - repmat([0 0 0 pi/2 0], size(WaveForm_3I, 1), 1);
WaveForm_3Length = gmSEQ.halfpi + SpinLockGap;
WaveForm_3PointNum = WaveForm_3Length * gSG.AWGClockRate;

WaveForm_4I = [0 SpinLockGap 0 0 0; ...
    SpinLockGap SpinLockGap+gmSEQ.halfpi gSG.AWGFreq phaseRef+0 gSG.AWGAmp];
WaveForm_4Q = WaveForm_4I - repmat([0 0 0 pi/2 0], size(WaveForm_4I, 1), 1);
WaveForm_4Length = gmSEQ.halfpi + SpinLockGap;
WaveForm_4PointNum = WaveForm_4Length * gSG.AWGClockRate;

% P1 sequence
WaveForm_5I = [0 tunit gSG2.AWGFreq 0 gSG2.LockingAmp];
WaveForm_5Q = WaveForm_5I - repmat([0 0 0 pi/2 0], size(WaveForm_5I, 1), 1);
WaveForm_5Length = tunit;
WaveForm_5PointNum = WaveForm_5Length * gSG2.P1AWGClockRate;

WaveForm_6I = [0 gmSEQ.DEERpi/2 gSG2.AWGFreq 0 gSG2.AWGAmp];
WaveForm_6Q = WaveForm_6I - repmat([0 0 0 pi/2 0], size(WaveForm_6I, 1), 1);
WaveForm_6Length = ceil((gmSEQ.DEERpi/2+1000) / (16 / gSG2.P1AWGClockRate)) ...
        *(16 / gSG2.P1AWGClockRate);
WaveForm_6PointNum = WaveForm_6Length * gSG2.P1AWGClockRate;

if rem(WaveForm_1PointNum, 16) ~= 0 || rem(WaveForm_2PointNum, 16) ~= 0  ... 
        || rem(WaveForm_3PointNum, 16) ~= 0 || rem(WaveForm_5PointNum, 16) ~= 0
   warning('The waveform point number is not a mulutple of 16.') 
end
if rem(gmSEQ.DEERt/tunit, 1) ~= 0 
   warning('gmSEQ.DEERt is not a multiple of minimum time unit.') 
end

chaseFunctionPool('createWaveform', WaveForm_1I, gSG.AWGClockRate, WaveForm_1Length, 'SpinLockLOOPP1_I_seg1.txt'); pause(0.5);
chaseFunctionPool('createWaveform', WaveForm_1Q, gSG.AWGClockRate, WaveForm_1Length, 'SpinLockLOOPP1_Q_seg1.txt'); pause(0.5);
chaseFunctionPool('createWaveform', WaveForm_2I, gSG.AWGClockRate, WaveForm_2Length, 'SpinLockLOOPP1_I_seg2.txt'); pause(0.5);
chaseFunctionPool('createWaveform', WaveForm_2Q, gSG.AWGClockRate, WaveForm_2Length, 'SpinLockLOOPP1_Q_seg2.txt'); pause(0.5);
chaseFunctionPool('createWaveform', WaveForm_3I, gSG.AWGClockRate, WaveForm_3Length, 'SpinLockLOOPP1_I_seg3.txt'); pause(0.5);
chaseFunctionPool('createWaveform', WaveForm_3Q, gSG.AWGClockRate, WaveForm_3Length, 'SpinLockLOOPP1_Q_seg3.txt'); pause(0.5);
chaseFunctionPool('createWaveform', WaveForm_4I, gSG.AWGClockRate, WaveForm_4Length, 'SpinLockLOOPP1_I_seg4.txt'); pause(0.5);
chaseFunctionPool('createWaveform', WaveForm_4Q, gSG.AWGClockRate, WaveForm_4Length, 'SpinLockLOOPP1_Q_seg4.txt'); pause(0.5);
chaseFunctionPool('createWaveform', WaveForm_5I, gSG2.P1AWGClockRate, WaveForm_5Length, 'SpinLockLOOPP1_I_seg5.txt'); pause(0.5);
chaseFunctionPool('createWaveform', WaveForm_5Q, gSG2.P1AWGClockRate, WaveForm_5Length, 'SpinLockLOOPP1_Q_seg5.txt'); pause(0.5);
chaseFunctionPool('createWaveform', WaveForm_6I, gSG2.P1AWGClockRate, WaveForm_6Length, 'SpinLockLOOPP1_I_seg6.txt'); pause(0.5);
chaseFunctionPool('createWaveform', WaveForm_6Q, gSG2.P1AWGClockRate, WaveForm_6Length, 'SpinLockLOOPP1_Q_seg6.txt'); pause(0.5);

chaseFunctionPool('createSegStruct', 'SpinLockLOOPP1_SegStruct_I.txt', ...
    'SpinLockLOOPP1_I_seg1.txt', WaveForm_1PointNum, 1, 1, ...
    'SpinLockLOOPP1_I_seg2.txt', WaveForm_2PointNum, round(gmSEQ.DEERt/tunit), 0, ...
    'SpinLockLOOPP1_I_seg3.txt', WaveForm_3PointNum, 1, 0, ...
    'SpinLockLOOPP1_I_seg1.txt', WaveForm_1PointNum, 1, 1, ...
    'SpinLockLOOPP1_I_seg2.txt', WaveForm_2PointNum, round(gmSEQ.DEERt/tunit), 0, ...
    'SpinLockLOOPP1_I_seg4.txt', WaveForm_4PointNum, 1, 0);
pause(0.5);
chaseFunctionPool('createSegStruct', 'SpinLockLOOPP1_SegStruct_Q.txt', ...
    'SpinLockLOOPP1_Q_seg1.txt', WaveForm_1PointNum, 1, 1, ...
    'SpinLockLOOPP1_Q_seg2.txt', WaveForm_2PointNum, round(gmSEQ.DEERt/tunit), 0, ...
    'SpinLockLOOPP1_Q_seg3.txt', WaveForm_3PointNum, 1, 0, ...
    'SpinLockLOOPP1_Q_seg1.txt', WaveForm_1PointNum, 1, 1, ...
    'SpinLockLOOPP1_Q_seg2.txt', WaveForm_2PointNum, round(gmSEQ.DEERt/tunit), 0, ...
    'SpinLockLOOPP1_Q_seg4.txt', WaveForm_4PointNum, 1, 0);
pause(0.5);

%% Load waveform to AWG
chaseFunctionPool('CreateSegments', gmSEQ.MWAWG, 1, ...
    6, ...
    2047, 2047, 'SpinLockLOOPP1_SegStruct_I.txt', 'false');
pause(1); % this pause seems to be important, otherwise the loading is not right occassionally
chaseFunctionPool('CreateSegments', gmSEQ.MWAWG, 2, ...
    6, ...
    2047, 2047, 'SpinLockLOOPP1_SegStruct_Q.txt', 'false');
pause(1); % this pause seems to be important, otherwise the loading is not right occassionally

if NDepol < 2
   warning("The AWG createSegStruct is not compatible with NDepol less than 2."); 
end

if round(gmSEQ.DEERt/tunit) > 1
    chaseFunctionPool('createSegStruct', 'SpinLockLOOPP1_P1_SegStruct_I.txt', ...
        'SpinLockLOOPP1_I_seg6.txt', WaveForm_6PointNum, 1, 1, ...
        'SpinLockLOOPP1_I_seg6.txt', WaveForm_6PointNum, NDepol-1, 1, ...
        'SpinLockLOOPP1_I_seg5.txt', WaveForm_5PointNum, 1, 1, ...
        'SpinLockLOOPP1_I_seg5.txt', WaveForm_5PointNum, round(gmSEQ.DEERt/tunit)-1, 0);
    pause(0.5);
    chaseFunctionPool('createSegStruct', 'SpinLockLOOPP1_P1_SegStruct_Q.txt', ...
        'SpinLockLOOPP1_Q_seg6.txt', WaveForm_6PointNum, 1, 1, ...
        'SpinLockLOOPP1_Q_seg6.txt', WaveForm_6PointNum, NDepol-1, 1, ...
        'SpinLockLOOPP1_Q_seg5.txt', WaveForm_5PointNum, 1, 1, ...
        'SpinLockLOOPP1_Q_seg5.txt', WaveForm_5PointNum, round(gmSEQ.DEERt/tunit)-1, 0);
    pause(0.5);
    chaseFunctionPool('CreateSegments', gmSEQ.P1AWG, 1, ...
        4, ...
        2047, 2047, 'SpinLockLOOPP1_P1_SegStruct_I.txt', 'false');
    pause(1); % this pause seems to be important, otherwise the loading is not right occassionally   
    chaseFunctionPool('CreateSegments', gmSEQ.P1AWG, 2, ...
        4, ...
        2047, 2047, 'SpinLockLOOPP1_P1_SegStruct_Q.txt', 'false');
    pause(1); % this pause seems to be important, otherwise the loading is not right occassionally 
else
    chaseFunctionPool('createSegStruct', 'SpinLockLOOPP1_P1_SegStruct_I.txt', ...
        'SpinLockLOOPP1_I_seg6.txt', WaveForm_6PointNum, 1, 1, ...
        'SpinLockLOOPP1_I_seg6.txt', WaveForm_6PointNum, NDepol-1, 1, ...
        'SpinLockLOOPP1_I_seg5.txt', WaveForm_5PointNum, round(gmSEQ.DEERt/tunit), 1);
    pause(0.5);
    chaseFunctionPool('createSegStruct', 'SpinLockLOOPP1_P1_SegStruct_Q.txt', ...
        'SpinLockLOOPP1_Q_seg6.txt', WaveForm_6PointNum, 1, 1, ...
        'SpinLockLOOPP1_Q_seg6.txt', WaveForm_6PointNum, NDepol-1, 1, ...
        'SpinLockLOOPP1_Q_seg5.txt', WaveForm_5PointNum, round(gmSEQ.DEERt/tunit), 1);
    pause(0.5);
    chaseFunctionPool('CreateSegments', gmSEQ.P1AWG, 1, ...
        3, ...
        2047, 2047, 'SpinLockLOOPP1_P1_SegStruct_I.txt', 'false');
    pause(1); % this pause seems to be important, otherwise the loading is not right occassionally   
    chaseFunctionPool('CreateSegments', gmSEQ.P1AWG, 2, ...
        3, ...
        2047, 2047, 'SpinLockLOOPP1_P1_SegStruct_Q.txt', 'false');
    pause(1); % this pause seems to be important, otherwise the loading is not right occassionally 
end

%% Run waveform
chaseFunctionPool('runChase', gmSEQ.MWAWG, 'false'); pause(1);
chaseFunctionPool('runChase', gmSEQ.P1AWG, 'false'); pause(1);
ApplyDelays();

function SpinLockingP1 
% Tune the AWG amplitude so that NV and P1 are resonant in the rotating frame
global gmSEQ gSG gSG2
gSG.bfixedPow=1;
gSG.bfixedFreq=1;
gSG.bMod='IQ';
gSG.bModSrc='External';

gSG2.bMod='IQ';
gSG2.bModSrc='External';
SignalGeneratorFunctionPool2('SetMod');

SignalGeneratorFunctionPool2('WritePow');
SignalGeneratorFunctionPool2('WriteFreq');
gSG2.bOn=1; SignalGeneratorFunctionPool2('RFOnOff');

% TODO: find an input window for this param
gSG.LockingAmp = gmSEQ.SAmp1;
gSG2.LockingAmp = gmSEQ.SAmp2;
gmSEQ.Lockingt = gmSEQ.m;

AfterPi = 1000;
AfterLaser = 100e3; % 0.1e6?
Detect_Window = 5000;
NDepol = 2; % Depolarization pulse for P1
IntDepol = 50e3;
Wait_p = NDepol*IntDepol + 100e3;
SpinLockGap = 0;
Sig_D_start = Wait_p+gmSEQ.readout+AfterLaser+gmSEQ.halfpi+SpinLockGap+gmSEQ.Lockingt+SpinLockGap+gmSEQ.halfpi+AfterPi+Detect_Window+Wait_p;

gmSEQ.CHN(1).PBN=PBDictionary('ctr0');
gmSEQ.CHN(1).NRise=4;
gmSEQ.CHN(1).T=[Wait_p+gmSEQ.readout-1000-gmSEQ.CtrGateDur, ...
    Wait_p+gmSEQ.readout+AfterLaser+gmSEQ.halfpi+SpinLockGap+gmSEQ.Lockingt+SpinLockGap+gmSEQ.halfpi+AfterPi, ...
    Sig_D_start+gmSEQ.readout-1000-gmSEQ.CtrGateDur, ... 
    Sig_D_start+gmSEQ.readout+AfterLaser+gmSEQ.halfpi+SpinLockGap+gmSEQ.Lockingt+SpinLockGap+gmSEQ.halfpi+AfterPi];
if strcmp(gmSEQ.meas,'SPCM')
    gmSEQ.CHN(1).DT=[gmSEQ.CtrGateDur gmSEQ.CtrGateDur gmSEQ.CtrGateDur gmSEQ.CtrGateDur];
elseif strcmp(gmSEQ.meas,'APD')
    gmSEQ.CHN(1).DT=[1000 1000 1000 1000];
end

gmSEQ.CHN(numel(gmSEQ.CHN)+1).PBN=PBDictionary('AOM');
gmSEQ.CHN(numel(gmSEQ.CHN)).NRise=4;
gmSEQ.CHN(numel(gmSEQ.CHN)).T = [Wait_p, Wait_p+gmSEQ.readout+AfterLaser+gmSEQ.halfpi+SpinLockGap+gmSEQ.Lockingt+SpinLockGap+gmSEQ.halfpi+AfterPi, ...
    Sig_D_start, Sig_D_start+gmSEQ.readout+AfterLaser+gmSEQ.halfpi+SpinLockGap+gmSEQ.Lockingt+SpinLockGap+gmSEQ.halfpi+AfterPi];
gmSEQ.CHN(numel(gmSEQ.CHN)).DT = [gmSEQ.readout Detect_Window gmSEQ.readout Detect_Window];

gmSEQ.CHN(numel(gmSEQ.CHN)+1).PBN=PBDictionary('AWGTrig');
gmSEQ.CHN(numel(gmSEQ.CHN)).NRise=2;
gmSEQ.CHN(numel(gmSEQ.CHN)).T=[Wait_p+gmSEQ.readout+AfterLaser, Sig_D_start+gmSEQ.readout+AfterLaser];
gmSEQ.CHN(numel(gmSEQ.CHN)).DT=[1000 1000];

gmSEQ.CHN(numel(gmSEQ.CHN)+1).PBN=PBDictionary('AWGTrig2');
gmSEQ.CHN(numel(gmSEQ.CHN)).NRise=2*(1+NDepol);
gmSEQ.CHN(numel(gmSEQ.CHN)).T=[(1:NDepol)*IntDepol-gmSEQ.DEERpi/2,  Wait_p+gmSEQ.readout+AfterLaser, ...
     Sig_D_start-Wait_p+(1:NDepol)*IntDepol-gmSEQ.DEERpi/2, Sig_D_start+gmSEQ.readout+AfterLaser];
gmSEQ.CHN(numel(gmSEQ.CHN)).DT=[repelem(gmSEQ.DEERpi/2+200, NDepol), 1000, ... 
    repelem(gmSEQ.DEERpi/2+200, NDepol), 1000];

gmSEQ.CHN(numel(gmSEQ.CHN)+1).PBN=PBDictionary('MWSwitch');
gmSEQ.CHN(numel(gmSEQ.CHN)).NRise=2;
gmSEQ.CHN(numel(gmSEQ.CHN)).T=[Wait_p+gmSEQ.readout+AfterLaser-20, Sig_D_start+gmSEQ.readout+AfterLaser-20];
gmSEQ.CHN(numel(gmSEQ.CHN)).DT=[gmSEQ.halfpi+SpinLockGap+gmSEQ.Lockingt+SpinLockGap+gmSEQ.halfpi+40, ... 
    gmSEQ.halfpi+SpinLockGap+gmSEQ.Lockingt+SpinLockGap+gmSEQ.halfpi+40];

gmSEQ.CHN(numel(gmSEQ.CHN)+1).PBN=PBDictionary('MWSwitch2');
gmSEQ.CHN(numel(gmSEQ.CHN)).NRise=2*(1+NDepol);
gmSEQ.CHN(numel(gmSEQ.CHN)).T=[(1:NDepol)*IntDepol-gmSEQ.DEERpi/2-20, Wait_p+gmSEQ.readout+AfterLaser-20,... 
    Sig_D_start-Wait_p+(1:NDepol)*IntDepol-gmSEQ.DEERpi/2-20, Sig_D_start+gmSEQ.readout+AfterLaser-20];
gmSEQ.CHN(numel(gmSEQ.CHN)).DT=[repelem(gmSEQ.DEERpi/2+40, NDepol), gmSEQ.halfpi+SpinLockGap+gmSEQ.Lockingt+SpinLockGap+gmSEQ.halfpi+40, ... 
    repelem(gmSEQ.DEERpi/2+40, NDepol), gmSEQ.halfpi+SpinLockGap+gmSEQ.Lockingt+SpinLockGap+gmSEQ.halfpi+40];

gmSEQ.CHN(numel(gmSEQ.CHN)+1).PBN=PBDictionary('dummy1');
gmSEQ.CHN(numel(gmSEQ.CHN)).NRise=2;
gmSEQ.CHN(numel(gmSEQ.CHN)).T=[0 Sig_D_start+gmSEQ.readout+AfterLaser+gmSEQ.halfpi+SpinLockGap+gmSEQ.Lockingt+SpinLockGap+gmSEQ.halfpi+AfterPi+Detect_Window-50];
gmSEQ.CHN(numel(gmSEQ.CHN)).DT=[50 50];

%% AWG
% Initialization
chaseFunctionPool('stopChase', gmSEQ.MWAWG); pause(1); % Not sure whether waiting is required
chaseFunctionPool('stopChase', gmSEQ.P1AWG);

% This part need to be modified to accomodate the DC modulation
if ~gSG.ACmodAWG % in AC modulation mode
    gSG.AWGFreq = 0;
    gSG2.AWGFreq = 0;
end

WaveForm_1I = [0 gmSEQ.halfpi gSG.AWGFreq 0 gSG.AWGAmp; ...
    gmSEQ.halfpi+SpinLockGap gmSEQ.halfpi+SpinLockGap+gmSEQ.Lockingt gSG.AWGFreq pi/2 gSG.LockingAmp; ... 
    gmSEQ.halfpi+SpinLockGap+gmSEQ.Lockingt+SpinLockGap gmSEQ.halfpi+SpinLockGap+gmSEQ.Lockingt+SpinLockGap+gmSEQ.halfpi gSG.AWGFreq pi gSG.AWGAmp];
WaveForm_1Q = WaveForm_1I - repmat([0 0 0 pi/2 0], size(WaveForm_1I, 1), 1);
WaveForm_1Length = ceil((gmSEQ.halfpi+SpinLockGap+gmSEQ.Lockingt+SpinLockGap+gmSEQ.halfpi+1000) / (16 / gSG.AWGClockRate)) ...
    *(16 / gSG.AWGClockRate);
WaveForm_1PointNum = WaveForm_1Length * gSG.AWGClockRate;

WaveForm_2I = WaveForm_1I;
WaveForm_2I(size(WaveForm_1I, 1), 4) = 0; % Differential measurement
WaveForm_2Q = WaveForm_1Q;
WaveForm_2Q(size(WaveForm_1I, 1), 4) = -pi/2; % Differential measurement
WaveForm_2Length = WaveForm_1Length;
WaveForm_2PointNum = WaveForm_2Length * gSG.AWGClockRate;
            
% P1 sequence
WaveForm_3I = [0 gmSEQ.halfpi 0 0 0; ...
    gmSEQ.halfpi+SpinLockGap gmSEQ.halfpi+SpinLockGap+gmSEQ.Lockingt gSG2.AWGFreq 0 gSG2.LockingAmp];
WaveForm_3Q = WaveForm_3I - repmat([0 0 0 pi/2 0], size(WaveForm_3I, 1), 1);
WaveForm_3Length = ceil((gmSEQ.halfpi+SpinLockGap+gmSEQ.Lockingt+1000) / (16 / gSG2.P1AWGClockRate)) ...
        *(16 / gSG2.P1AWGClockRate);
WaveForm_3PointNum = WaveForm_3Length * gSG2.P1AWGClockRate;

WaveForm_4I = [0 gmSEQ.DEERpi/2 gSG2.AWGFreq 0 gSG2.AWGAmp];
WaveForm_4Q = WaveForm_4I - repmat([0 0 0 pi/2 0], size(WaveForm_4I, 1), 1);
WaveForm_4Length = ceil((gmSEQ.DEERpi/2+1000) / (16 / gSG2.P1AWGClockRate)) ...
        *(16 / gSG2.P1AWGClockRate);
WaveForm_4PointNum = WaveForm_4Length * gSG2.P1AWGClockRate;

chaseFunctionPool('createWaveform', WaveForm_1I, gSG.AWGClockRate, WaveForm_1Length, 'SpinLockP1_I_seg1.txt'); pause(0.5);
chaseFunctionPool('createWaveform', WaveForm_1Q, gSG.AWGClockRate, WaveForm_1Length, 'SpinLockP1_Q_seg1.txt'); pause(0.5);
chaseFunctionPool('createWaveform', WaveForm_2I, gSG.AWGClockRate, WaveForm_2Length, 'SpinLockP1_I_seg2.txt'); pause(0.5);
chaseFunctionPool('createWaveform', WaveForm_2Q, gSG.AWGClockRate, WaveForm_2Length, 'SpinLockP1_Q_seg2.txt'); pause(0.5);
chaseFunctionPool('createWaveform', WaveForm_3I, gSG2.P1AWGClockRate, WaveForm_3Length, 'SpinLockP1_I_seg3.txt'); pause(0.5);
chaseFunctionPool('createWaveform', WaveForm_3Q, gSG2.P1AWGClockRate, WaveForm_3Length, 'SpinLockP1_Q_seg3.txt'); pause(0.5);
chaseFunctionPool('createWaveform', WaveForm_4I, gSG2.P1AWGClockRate, WaveForm_4Length, 'SpinLockP1_I_seg4.txt'); pause(0.5);
chaseFunctionPool('createWaveform', WaveForm_4Q, gSG2.P1AWGClockRate, WaveForm_4Length, 'SpinLockP1_Q_seg4.txt'); pause(0.5);

chaseFunctionPool('createSegStruct', 'SpinLockP1_SegStruct_I.txt', ...
    'SpinLockP1_I_seg1.txt', WaveForm_1PointNum, 1, 1, ...
    'SpinLockP1_I_seg2.txt', WaveForm_2PointNum, 1, 1);
pause(0.5);
chaseFunctionPool('createSegStruct', 'SpinLockP1_SegStruct_Q.txt', ...
    'SpinLockP1_Q_seg1.txt', WaveForm_1PointNum, 1, 1, ...
    'SpinLockP1_Q_seg2.txt', WaveForm_2PointNum, 1, 1);
pause(0.5);
% For P1, the differential measurement part should be exactly the same
% Accomadate NDepol = 1  case

if NDepol < 2
   warning("The AWG createSegStruct is not compatible with NDepol less than 2."); 
end

chaseFunctionPool('createSegStruct', 'SpinLockP1_P1_SegStruct_I.txt', ...
    'SpinLockP1_I_seg4.txt', WaveForm_4PointNum, 1, 1, ...
    'SpinLockP1_I_seg4.txt', WaveForm_4PointNum, NDepol-1, 1, ...
    'SpinLockP1_I_seg3.txt', WaveForm_3PointNum, 1, 1);
pause(0.5);
chaseFunctionPool('createSegStruct', 'SpinLockP1_P1_SegStruct_Q.txt', ...
    'SpinLockP1_Q_seg4.txt', WaveForm_4PointNum, 1, 1, ...
    'SpinLockP1_Q_seg4.txt', WaveForm_4PointNum, NDepol-1, 1, ...
    'SpinLockP1_Q_seg3.txt', WaveForm_3PointNum, 1, 1);
pause(0.5);

%% Load waveform to AWG
chaseFunctionPool('CreateSegments', gmSEQ.MWAWG, 1, ...
    2, ...
    2047, 2047, 'SpinLockP1_SegStruct_I.txt', 'false');
pause(1); % this pause seems to be important, otherwise the loading is not right occassionally
chaseFunctionPool('CreateSegments', gmSEQ.MWAWG, 2, ...
    2, ...
    2047, 2047, 'SpinLockP1_SegStruct_Q.txt', 'false');
pause(1); % this pause seems to be important, otherwise the loading is not right occassionally
chaseFunctionPool('CreateSegments', gmSEQ.P1AWG, 1, ...
    3, ...
    2047, 2047, 'SpinLockP1_P1_SegStruct_I.txt', 'false');
pause(1); % this pause seems to be important, otherwise the loading is not right occassionally   
chaseFunctionPool('CreateSegments', gmSEQ.P1AWG, 2, ...
    3, ...
    2047, 2047, 'SpinLockP1_P1_SegStruct_Q.txt', 'false');
pause(1); % this pause seems to be important, otherwise the loading is not right occassionally 

%% Run waveform
chaseFunctionPool('runChase', gmSEQ.MWAWG, 'false'); pause(1);
chaseFunctionPool('runChase', gmSEQ.P1AWG, 'false'); pause(1);
ApplyDelays();

function PolarP1Res 
% Tune the AWG amplitude so that NV and P1 are resonant in the rotating frame
global gmSEQ gSG gSG2
gSG.bfixedPow=1;
gSG.bfixedFreq=1;
gSG.bMod='IQ';
gSG.bModSrc='External';

gSG2.bMod='IQ';
gSG2.bModSrc='External';
SignalGeneratorFunctionPool2('SetMod');

SignalGeneratorFunctionPool2('WritePow');
SignalGeneratorFunctionPool2('WriteFreq');
gSG2.bOn=1; SignalGeneratorFunctionPool2('RFOnOff');

% TODO: find an input window for this param
gSG.LockingAmp = gmSEQ.SAmp1;
gSG2.LockingAmp = gmSEQ.m;

AfterPi = 1000;
AfterLaser = 100e3; % 0.1e6?
Detect_Window = 5000;
NDepol = 2; % Depolarization pulse for P1
IntDepol = 100e3;
Wait_p = NDepol*IntDepol + 100e3;
SpinLockGap = 10;
Sig_D_start = Wait_p+gmSEQ.readout+AfterLaser+gmSEQ.halfpi+SpinLockGap+gmSEQ.DEERt+SpinLockGap+gmSEQ.halfpi+AfterPi+Detect_Window+Wait_p;
disp(SpinLockGap)

gmSEQ.CHN(1).PBN=PBDictionary('ctr0');
gmSEQ.CHN(1).NRise=4;
gmSEQ.CHN(1).T=[Wait_p+gmSEQ.readout-1000-gmSEQ.CtrGateDur, ...
    Wait_p+gmSEQ.readout+AfterLaser+gmSEQ.halfpi+SpinLockGap+gmSEQ.DEERt+SpinLockGap+gmSEQ.halfpi+AfterPi, ...
    Sig_D_start+gmSEQ.readout-1000-gmSEQ.CtrGateDur, ... 
    Sig_D_start+gmSEQ.readout+AfterLaser+gmSEQ.halfpi+SpinLockGap+gmSEQ.DEERt+SpinLockGap+gmSEQ.halfpi+AfterPi];
if strcmp(gmSEQ.meas,'SPCM')
    gmSEQ.CHN(1).DT=[gmSEQ.CtrGateDur gmSEQ.CtrGateDur gmSEQ.CtrGateDur gmSEQ.CtrGateDur];
elseif strcmp(gmSEQ.meas,'APD')
    gmSEQ.CHN(1).DT=[1000 1000 1000 1000];
end

gmSEQ.CHN(numel(gmSEQ.CHN)+1).PBN=PBDictionary('AOM');
gmSEQ.CHN(numel(gmSEQ.CHN)).NRise=4;
gmSEQ.CHN(numel(gmSEQ.CHN)).T = [Wait_p, Wait_p+gmSEQ.readout+AfterLaser+gmSEQ.halfpi+SpinLockGap+gmSEQ.DEERt+SpinLockGap+gmSEQ.halfpi+AfterPi, ...
    Sig_D_start, Sig_D_start+gmSEQ.readout+AfterLaser+gmSEQ.halfpi+SpinLockGap+gmSEQ.DEERt+SpinLockGap+gmSEQ.halfpi+AfterPi];
gmSEQ.CHN(numel(gmSEQ.CHN)).DT = [gmSEQ.readout Detect_Window gmSEQ.readout Detect_Window];

gmSEQ.CHN(numel(gmSEQ.CHN)+1).PBN=PBDictionary('AWGTrig');
gmSEQ.CHN(numel(gmSEQ.CHN)).NRise=2;
gmSEQ.CHN(numel(gmSEQ.CHN)).T=[Wait_p+gmSEQ.readout+AfterLaser, Sig_D_start+gmSEQ.readout+AfterLaser];
gmSEQ.CHN(numel(gmSEQ.CHN)).DT=[1000 1000];

gmSEQ.CHN(numel(gmSEQ.CHN)+1).PBN=PBDictionary('AWGTrig2');
gmSEQ.CHN(numel(gmSEQ.CHN)).NRise=2*(1+NDepol);
gmSEQ.CHN(numel(gmSEQ.CHN)).T=[(1:NDepol)*IntDepol-gmSEQ.DEERpi/2,  Wait_p+gmSEQ.readout+AfterLaser, ...
     Sig_D_start-Wait_p+(1:NDepol)*IntDepol-gmSEQ.DEERpi/2, Sig_D_start+gmSEQ.readout+AfterLaser];
gmSEQ.CHN(numel(gmSEQ.CHN)).DT=[repelem(gmSEQ.DEERpi/2+200, NDepol), 1000, ... 
    repelem(gmSEQ.DEERpi/2+200, NDepol), 1000];

gmSEQ.CHN(numel(gmSEQ.CHN)+1).PBN=PBDictionary('MWSwitch');
gmSEQ.CHN(numel(gmSEQ.CHN)).NRise=2;
gmSEQ.CHN(numel(gmSEQ.CHN)).T=[Wait_p+gmSEQ.readout+AfterLaser-20, Sig_D_start+gmSEQ.readout+AfterLaser-20];
gmSEQ.CHN(numel(gmSEQ.CHN)).DT=[gmSEQ.halfpi+SpinLockGap+gmSEQ.DEERt+SpinLockGap+gmSEQ.halfpi+40, ... 
    gmSEQ.halfpi+SpinLockGap+gmSEQ.DEERt+SpinLockGap+gmSEQ.halfpi+40];

gmSEQ.CHN(numel(gmSEQ.CHN)+1).PBN=PBDictionary('MWSwitch2');
gmSEQ.CHN(numel(gmSEQ.CHN)).NRise=2*(1+NDepol);
gmSEQ.CHN(numel(gmSEQ.CHN)).T=[(1:NDepol)*IntDepol-gmSEQ.DEERpi/2-20, Wait_p+gmSEQ.readout+AfterLaser-20,... 
    Sig_D_start-Wait_p+(1:NDepol)*IntDepol-gmSEQ.DEERpi/2-20, Sig_D_start+gmSEQ.readout+AfterLaser-20];
gmSEQ.CHN(numel(gmSEQ.CHN)).DT=[repelem(gmSEQ.DEERpi/2+40, NDepol), gmSEQ.halfpi+SpinLockGap+gmSEQ.DEERt+SpinLockGap+gmSEQ.halfpi+40, ... 
    repelem(gmSEQ.DEERpi/2+40, NDepol), gmSEQ.halfpi+SpinLockGap+gmSEQ.DEERt+SpinLockGap+gmSEQ.halfpi+40];

gmSEQ.CHN(numel(gmSEQ.CHN)+1).PBN=PBDictionary('dummy1');
gmSEQ.CHN(numel(gmSEQ.CHN)).NRise=2;
gmSEQ.CHN(numel(gmSEQ.CHN)).T=[0 Sig_D_start+gmSEQ.readout+AfterLaser+gmSEQ.halfpi+SpinLockGap+gmSEQ.DEERt+SpinLockGap+gmSEQ.halfpi+AfterPi+Detect_Window-50];
gmSEQ.CHN(numel(gmSEQ.CHN)).DT=[50 50];

%% AWG
% Initialization
chaseFunctionPool('stopChase', gmSEQ.MWAWG); pause(1); % Not sure whether waiting is required
chaseFunctionPool('stopChase', gmSEQ.P1AWG);

% This part need to be modified to accomodate the DC modulation
if ~gSG.ACmodAWG % in AC modulation mode
    gSG.AWGFreq = 0;
    gSG2.AWGFreq = 0;
end

WaveForm_1I = [0 gmSEQ.halfpi gSG.AWGFreq 0 gSG.AWGAmp; ...
    gmSEQ.halfpi+SpinLockGap gmSEQ.halfpi+SpinLockGap+gmSEQ.DEERt gSG.AWGFreq pi/2 gSG.LockingAmp; ... 
    gmSEQ.halfpi+SpinLockGap+gmSEQ.DEERt+SpinLockGap gmSEQ.halfpi+SpinLockGap+gmSEQ.DEERt+SpinLockGap+gmSEQ.halfpi gSG.AWGFreq pi gSG.AWGAmp];
WaveForm_1Q = WaveForm_1I - repmat([0 0 0 pi/2 0], size(WaveForm_1I, 1), 1);
WaveForm_1Length = ceil((gmSEQ.halfpi+SpinLockGap+gmSEQ.DEERt+SpinLockGap+gmSEQ.halfpi+1000) / (16 / gSG.AWGClockRate)) ...
    *(16 / gSG.AWGClockRate);
WaveForm_1PointNum = WaveForm_1Length * gSG.AWGClockRate;

WaveForm_2I = WaveForm_1I;
WaveForm_2I(size(WaveForm_1I, 1), 4) = 0; % Differential measurement
WaveForm_2Q = WaveForm_1Q;
WaveForm_2Q(size(WaveForm_1I, 1), 4) = -pi/2; % Differential measurement
WaveForm_2Length = WaveForm_1Length;
WaveForm_2PointNum = WaveForm_2Length * gSG.AWGClockRate;
            
% P1 sequence
WaveForm_3I = [0 gmSEQ.halfpi 0 0 0; ...
    gmSEQ.halfpi+SpinLockGap gmSEQ.halfpi+SpinLockGap+gmSEQ.DEERt gSG2.AWGFreq 0 gSG2.LockingAmp];
WaveForm_3Q = WaveForm_3I - repmat([0 0 0 pi/2 0], size(WaveForm_3I, 1), 1);
WaveForm_3Length = ceil((gmSEQ.halfpi+SpinLockGap+gmSEQ.DEERt+1000) / (16 / gSG2.P1AWGClockRate)) ...
        *(16 / gSG2.P1AWGClockRate);
WaveForm_3PointNum = WaveForm_3Length * gSG2.P1AWGClockRate;

WaveForm_4I = [0 gmSEQ.DEERpi/2 gSG2.AWGFreq 0 gSG2.AWGAmp];
WaveForm_4Q = WaveForm_4I - repmat([0 0 0 pi/2 0], size(WaveForm_4I, 1), 1);
WaveForm_4Length = ceil((gmSEQ.DEERpi/2+1000) / (16 / gSG2.P1AWGClockRate)) ...
        *(16 / gSG2.P1AWGClockRate);
WaveForm_4PointNum = WaveForm_4Length * gSG2.P1AWGClockRate;

chaseFunctionPool('createWaveform', WaveForm_1I, gSG.AWGClockRate, WaveForm_1Length, 'SpinLockLOOPP1_I_seg1.txt'); pause(0.5);
chaseFunctionPool('createWaveform', WaveForm_1Q, gSG.AWGClockRate, WaveForm_1Length, 'SpinLockLOOPP1_Q_seg1.txt'); pause(0.5);
chaseFunctionPool('createWaveform', WaveForm_2I, gSG.AWGClockRate, WaveForm_2Length, 'SpinLockLOOPP1_I_seg2.txt'); pause(0.5);
chaseFunctionPool('createWaveform', WaveForm_2Q, gSG.AWGClockRate, WaveForm_2Length, 'SpinLockLOOPP1_Q_seg2.txt'); pause(0.5);
chaseFunctionPool('createWaveform', WaveForm_3I, gSG2.P1AWGClockRate, WaveForm_3Length, 'SpinLockLOOPP1_I_seg3.txt'); pause(0.5);
chaseFunctionPool('createWaveform', WaveForm_3Q, gSG2.P1AWGClockRate, WaveForm_3Length, 'SpinLockLOOPP1_Q_seg3.txt'); pause(0.5);
chaseFunctionPool('createWaveform', WaveForm_4I, gSG2.P1AWGClockRate, WaveForm_4Length, 'SpinLockLOOPP1_I_seg4.txt'); pause(0.5);
chaseFunctionPool('createWaveform', WaveForm_4Q, gSG2.P1AWGClockRate, WaveForm_4Length, 'SpinLockLOOPP1_Q_seg4.txt'); pause(0.5);

chaseFunctionPool('createSegStruct', 'SpinLockLOOPP1_SegStruct_I.txt', ...
    'SpinLockLOOPP1_I_seg1.txt', WaveForm_1PointNum, 1, 1, ...
    'SpinLockLOOPP1_I_seg2.txt', WaveForm_2PointNum, 1, 1);
pause(0.5);
chaseFunctionPool('createSegStruct', 'SpinLockLOOPP1_SegStruct_Q.txt', ...
    'SpinLockLOOPP1_Q_seg1.txt', WaveForm_1PointNum, 1, 1, ...
    'SpinLockLOOPP1_Q_seg2.txt', WaveForm_2PointNum, 1, 1);
pause(0.5);
% For P1, the differential measurement part should be exactly the same
% Accomadate NDepol = 1  case

if NDepol < 2
   warning("The AWG createSegStruct is not compatible with NDepol less than 2."); 
end

chaseFunctionPool('createSegStruct', 'SpinLockLOOPP1_P1_SegStruct_I.txt', ...
    'SpinLockLOOPP1_I_seg4.txt', WaveForm_4PointNum, 1, 1, ...
    'SpinLockLOOPP1_I_seg4.txt', WaveForm_4PointNum, NDepol-1, 1, ...
    'SpinLockLOOPP1_I_seg3.txt', WaveForm_3PointNum, 1, 1);
pause(0.5);
chaseFunctionPool('createSegStruct', 'SpinLockLOOPP1_P1_SegStruct_Q.txt', ...
    'SpinLockLOOPP1_Q_seg4.txt', WaveForm_4PointNum, 1, 1, ...
    'SpinLockLOOPP1_Q_seg4.txt', WaveForm_4PointNum, NDepol-1, 1, ...
    'SpinLockLOOPP1_Q_seg3.txt', WaveForm_3PointNum, 1, 1);
pause(0.5);

%% Load waveform to AWG
chaseFunctionPool('CreateSegments', gmSEQ.MWAWG, 1, ...
    2, ...
    2047, 2047, 'SpinLockLOOPP1_SegStruct_I.txt', 'false');
pause(1); % this pause seems to be important, otherwise the loading is not right occassionally
chaseFunctionPool('CreateSegments', gmSEQ.MWAWG, 2, ...
    2, ...
    2047, 2047, 'SpinLockLOOPP1_SegStruct_Q.txt', 'false');
pause(1); % this pause seems to be important, otherwise the loading is not right occassionally
chaseFunctionPool('CreateSegments', gmSEQ.P1AWG, 1, ...
    3, ...
    2047, 2047, 'SpinLockLOOPP1_P1_SegStruct_I.txt', 'false');
pause(1); % this pause seems to be important, otherwise the loading is not right occassionally   
chaseFunctionPool('CreateSegments', gmSEQ.P1AWG, 2, ...
    3, ...
    2047, 2047, 'SpinLockLOOPP1_P1_SegStruct_Q.txt', 'false');
pause(1); % this pause seems to be important, otherwise the loading is not right occassionally 

%% Run waveform
chaseFunctionPool('runChase', gmSEQ.MWAWG, 'false'); pause(1);
chaseFunctionPool('runChase', gmSEQ.P1AWG, 'false'); pause(1);
ApplyDelays();

function PolarP1_Res 
global gmSEQ gSG gSG2
gSG.bfixedPow=1;
gSG.bfixedFreq=1;
gSG.bMod='IQ';
gSG.bModSrc='External';

gSG2.bMod='IQ';
gSG2.bModSrc='External';
SignalGeneratorFunctionPool2('SetMod');
SignalGeneratorFunctionPool2('WritePow');
SignalGeneratorFunctionPool2('WriteFreq');
gSG2.bOn=1; SignalGeneratorFunctionPool2('RFOnOff');

gmSEQ.Ntomo = 2;

% Temp use. TODO: find an input window for this param
gSG.LockingAmp = gmSEQ.SAmp1;
gSG2.LockingAmp = gmSEQ.m;
gmSEQ.PolarCycle = gmSEQ.CoolCycle;
gmSEQ.DEERhalfpi = gmSEQ.DEERpi/2;
DetectTime = gmSEQ.DEERt;

NDepol = 3; % Depolarization pulse for P1
IntDepol = 60e3;
SpinLockGap = 4;
AfterPi = 1000;
AfterLaser = 2000; % 0.1e6?
AfterPolar = 1000;
Wait_p = NDepol*IntDepol + 10e3;
Detect_Window = 5000;
PolarTime = 20e3; % polarizing interaction time between NV and P1
PolarReadout = 5000; % polarizing initialization time
HalfPi = max(gmSEQ.halfpi, gmSEQ.DEERhalfpi);
CycleTime = PolarReadout+AfterLaser+HalfPi+SpinLockGap+PolarTime+SpinLockGap+HalfPi+AfterPolar;
Sig_D_start = Wait_p+CycleTime*gmSEQ.PolarCycle+gmSEQ.readout+AfterLaser+HalfPi+SpinLockGap+DetectTime+SpinLockGap+HalfPi+AfterPi+Detect_Window+Wait_p;

gmSEQ.CHN(1).PBN=PBDictionary('ctr0');
gmSEQ.CHN(1).NRise=4;
gmSEQ.CHN(1).T=[Wait_p+CycleTime*gmSEQ.PolarCycle+gmSEQ.readout-1000-gmSEQ.CtrGateDur, ...
    Wait_p+CycleTime*gmSEQ.PolarCycle+gmSEQ.readout+AfterLaser+HalfPi+SpinLockGap+DetectTime+SpinLockGap+HalfPi+AfterPi, ...
    Sig_D_start+CycleTime*gmSEQ.PolarCycle+gmSEQ.readout-1000-gmSEQ.CtrGateDur, ... 
    Sig_D_start+CycleTime*gmSEQ.PolarCycle+gmSEQ.readout+AfterLaser+HalfPi+SpinLockGap+DetectTime+SpinLockGap+HalfPi+AfterPi];
if strcmp(gmSEQ.meas,'SPCM')
    gmSEQ.CHN(1).DT=[gmSEQ.CtrGateDur gmSEQ.CtrGateDur gmSEQ.CtrGateDur gmSEQ.CtrGateDur];
elseif strcmp(gmSEQ.meas,'APD')
    gmSEQ.CHN(1).DT=[1000 1000 1000 1000];
end

gmSEQ.CHN(numel(gmSEQ.CHN)+1).PBN=PBDictionary('AOM');
gmSEQ.CHN(numel(gmSEQ.CHN)).NRise=2*(2 + gmSEQ.PolarCycle);
gmSEQ.CHN(numel(gmSEQ.CHN)).T = zeros(1, gmSEQ.CHN(numel(gmSEQ.CHN)).NRise);
for i = 1:gmSEQ.PolarCycle
    gmSEQ.CHN(numel(gmSEQ.CHN)).T(i)=Wait_p+(i-1)*CycleTime;
end
gmSEQ.CHN(numel(gmSEQ.CHN)).T(gmSEQ.PolarCycle+1)=Wait_p+CycleTime*gmSEQ.PolarCycle;
gmSEQ.CHN(numel(gmSEQ.CHN)).T(gmSEQ.PolarCycle+2)=Wait_p+CycleTime*gmSEQ.PolarCycle ...
    +gmSEQ.readout+AfterLaser+HalfPi+SpinLockGap+DetectTime+SpinLockGap+HalfPi+AfterPi;
for i = 1:gmSEQ.PolarCycle
    gmSEQ.CHN(numel(gmSEQ.CHN)).T(gmSEQ.PolarCycle+2+i)=Sig_D_start+(i-1)*CycleTime;
end
gmSEQ.CHN(numel(gmSEQ.CHN)).T(2*gmSEQ.PolarCycle+3)=Sig_D_start+CycleTime*gmSEQ.PolarCycle;
gmSEQ.CHN(numel(gmSEQ.CHN)).T(2*gmSEQ.PolarCycle+4)=Sig_D_start+CycleTime*gmSEQ.PolarCycle ...
	+gmSEQ.readout+AfterLaser+HalfPi+SpinLockGap+DetectTime+SpinLockGap+HalfPi+AfterPi;
gmSEQ.CHN(numel(gmSEQ.CHN)).DT = [repelem(PolarReadout, gmSEQ.PolarCycle) gmSEQ.readout Detect_Window ...
    repelem(PolarReadout, gmSEQ.PolarCycle) gmSEQ.readout Detect_Window];

gmSEQ.CHN(numel(gmSEQ.CHN)+1).PBN=PBDictionary('AWGTrig');
gmSEQ.CHN(numel(gmSEQ.CHN)).NRise=2*(1 + gmSEQ.PolarCycle);
gmSEQ.CHN(numel(gmSEQ.CHN)).T = zeros(1, gmSEQ.CHN(numel(gmSEQ.CHN)).NRise);
for i = 1:gmSEQ.PolarCycle
    gmSEQ.CHN(numel(gmSEQ.CHN)).T(i)=Wait_p+(i-1)*CycleTime+PolarReadout+AfterLaser;
    gmSEQ.CHN(numel(gmSEQ.CHN)).T(gmSEQ.PolarCycle+1+i)=Sig_D_start+(i-1)*CycleTime+PolarReadout+AfterLaser;
end
gmSEQ.CHN(numel(gmSEQ.CHN)).T(gmSEQ.PolarCycle+1)=Wait_p+CycleTime*gmSEQ.PolarCycle+gmSEQ.readout+AfterLaser;
gmSEQ.CHN(numel(gmSEQ.CHN)).T(2*gmSEQ.PolarCycle+2)=Sig_D_start+CycleTime*gmSEQ.PolarCycle+gmSEQ.readout+AfterLaser;
gmSEQ.CHN(numel(gmSEQ.CHN)).DT=[repelem(HalfPi+SpinLockGap+PolarTime+SpinLockGap+HalfPi+200,gmSEQ.PolarCycle), ...
    HalfPi+SpinLockGap+DetectTime+SpinLockGap+HalfPi+200, ... 
    repelem(HalfPi+SpinLockGap+PolarTime+SpinLockGap+HalfPi+200,gmSEQ.PolarCycle), ...
    HalfPi+SpinLockGap+DetectTime+SpinLockGap+HalfPi+200];

% P1 AWG Trig
gmSEQ.CHN(numel(gmSEQ.CHN)+1).PBN=PBDictionary('AWGTrig2');
gmSEQ.CHN(numel(gmSEQ.CHN)).NRise=2*(1 + gmSEQ.PolarCycle + NDepol);
gmSEQ.CHN(numel(gmSEQ.CHN)).T=zeros(1, gmSEQ.CHN(numel(gmSEQ.CHN)).NRise);
for i = 1:NDepol
    gmSEQ.CHN(numel(gmSEQ.CHN)).T(i)=i*IntDepol-gmSEQ.DEERpi/2;
    gmSEQ.CHN(numel(gmSEQ.CHN)).T(i+1+gmSEQ.PolarCycle+NDepol)=Sig_D_start-Wait_p+i*IntDepol-gmSEQ.DEERpi/2;
end
for i = 1:gmSEQ.PolarCycle
    gmSEQ.CHN(numel(gmSEQ.CHN)).T(NDepol + i)=Wait_p+(i-1)*CycleTime+PolarReadout+AfterLaser;
    gmSEQ.CHN(numel(gmSEQ.CHN)).T(2*NDepol+gmSEQ.PolarCycle+i+1)=Sig_D_start+(i-1)*CycleTime+PolarReadout+AfterLaser;
end
gmSEQ.CHN(numel(gmSEQ.CHN)).T(NDepol+gmSEQ.PolarCycle+1)=Wait_p+CycleTime*gmSEQ.PolarCycle+gmSEQ.readout+AfterLaser;
gmSEQ.CHN(numel(gmSEQ.CHN)).T(2*NDepol+2*gmSEQ.PolarCycle+2)=Sig_D_start+CycleTime*gmSEQ.PolarCycle+gmSEQ.readout+AfterLaser;
gmSEQ.CHN(numel(gmSEQ.CHN)).DT=[repelem(gmSEQ.DEERpi/2+200, NDepol), ... 
    repelem(HalfPi+SpinLockGap+PolarTime+SpinLockGap+HalfPi+200,gmSEQ.PolarCycle), ...
    HalfPi+SpinLockGap+DetectTime+SpinLockGap+HalfPi+200, ...
    repelem(gmSEQ.DEERpi/2+200, NDepol), ... 
    repelem(HalfPi+SpinLockGap+PolarTime+SpinLockGap+HalfPi+200,gmSEQ.PolarCycle), ...
    HalfPi+SpinLockGap+DetectTime+SpinLockGap+HalfPi+200];

gmSEQ.CHN(numel(gmSEQ.CHN)+1).PBN=PBDictionary('MWSwitch');
gmSEQ.CHN(numel(gmSEQ.CHN)).NRise=2*(1 + gmSEQ.PolarCycle);
gmSEQ.CHN(numel(gmSEQ.CHN)).T = zeros(1, gmSEQ.CHN(numel(gmSEQ.CHN)).NRise);
for i = 1:gmSEQ.PolarCycle
    gmSEQ.CHN(numel(gmSEQ.CHN)).T(i)=Wait_p+(i-1)*CycleTime+PolarReadout+AfterLaser-20;
    gmSEQ.CHN(numel(gmSEQ.CHN)).T(gmSEQ.PolarCycle+1+i)=Sig_D_start+(i-1)*CycleTime+PolarReadout+AfterLaser-20;
end
gmSEQ.CHN(numel(gmSEQ.CHN)).T(gmSEQ.PolarCycle+1)=Wait_p+CycleTime*gmSEQ.PolarCycle+gmSEQ.readout+AfterLaser-20;
gmSEQ.CHN(numel(gmSEQ.CHN)).T(2*gmSEQ.PolarCycle+2)=Sig_D_start+CycleTime*gmSEQ.PolarCycle+gmSEQ.readout+AfterLaser-20;
gmSEQ.CHN(numel(gmSEQ.CHN)).DT=[repelem(HalfPi+SpinLockGap+PolarTime+SpinLockGap+HalfPi+40, gmSEQ.PolarCycle), ...
    HalfPi+SpinLockGap+DetectTime+SpinLockGap+HalfPi+40, ...
    repelem(HalfPi+SpinLockGap+PolarTime+SpinLockGap+HalfPi+40, gmSEQ.PolarCycle), ...
    HalfPi+SpinLockGap+DetectTime+SpinLockGap+HalfPi+40];

gmSEQ.CHN(numel(gmSEQ.CHN)+1).PBN=PBDictionary('MWSwitch2');
gmSEQ.CHN(numel(gmSEQ.CHN)).NRise=2*(1 + gmSEQ.PolarCycle + NDepol);
gmSEQ.CHN(numel(gmSEQ.CHN)).T = zeros(1, gmSEQ.CHN(numel(gmSEQ.CHN)).NRise);
for i = 1:NDepol
    gmSEQ.CHN(numel(gmSEQ.CHN)).T(i)=i*IntDepol-gmSEQ.DEERpi/2-20;
    gmSEQ.CHN(numel(gmSEQ.CHN)).T(i+1+gmSEQ.PolarCycle+NDepol)=Sig_D_start-Wait_p+i*IntDepol-gmSEQ.DEERpi/2-20;
end
for i = 1:gmSEQ.PolarCycle
    gmSEQ.CHN(numel(gmSEQ.CHN)).T(NDepol + i)=Wait_p+(i-1)*CycleTime+PolarReadout+AfterLaser-20;
    gmSEQ.CHN(numel(gmSEQ.CHN)).T(2*NDepol+gmSEQ.PolarCycle+i+1)=Sig_D_start+(i-1)*CycleTime+PolarReadout+AfterLaser-20;
end
gmSEQ.CHN(numel(gmSEQ.CHN)).T(NDepol+gmSEQ.PolarCycle+1)=Wait_p+CycleTime*gmSEQ.PolarCycle+gmSEQ.readout+AfterLaser-20;
gmSEQ.CHN(numel(gmSEQ.CHN)).T(2*NDepol+2*gmSEQ.PolarCycle+2)=Sig_D_start+CycleTime*gmSEQ.PolarCycle+gmSEQ.readout+AfterLaser-20;
gmSEQ.CHN(numel(gmSEQ.CHN)).DT=[repelem(gmSEQ.DEERpi/2+20, NDepol), ... 
    repelem(HalfPi+SpinLockGap+PolarTime+SpinLockGap+HalfPi+40,gmSEQ.PolarCycle), ...
    HalfPi+SpinLockGap+DetectTime+SpinLockGap+HalfPi+40, ...
    repelem(gmSEQ.DEERpi/2+20, NDepol), ... 
    repelem(HalfPi+SpinLockGap+PolarTime+SpinLockGap+HalfPi+40,gmSEQ.PolarCycle), ...
    HalfPi+SpinLockGap+DetectTime+SpinLockGap+HalfPi+40];

gmSEQ.CHN(numel(gmSEQ.CHN)+1).PBN=PBDictionary('dummy1');
gmSEQ.CHN(numel(gmSEQ.CHN)).NRise=2;
gmSEQ.CHN(numel(gmSEQ.CHN)).T=[0 Sig_D_start+CycleTime*gmSEQ.PolarCycle+gmSEQ.readout+AfterLaser+ ...
    HalfPi+SpinLockGap+DetectTime+SpinLockGap+HalfPi+AfterPi+Detect_Window-50];
gmSEQ.CHN(numel(gmSEQ.CHN)).DT=[50 50];

%% AWG
% Initialization
chaseFunctionPool('stopChase', gmSEQ.MWAWG); pause(1);
chaseFunctionPool('stopChase', gmSEQ.P1AWG);

% This part need to be modified to accomodate the DC modulation
if ~gSG.ACmodAWG % in AC modulation mode
    gSG.AWGFreq = 0;
    gSG2.AWGFreq = 0;
end

% disp(DetectTime)
% if DetectTime == 0
%     disp("t=0 reference...")
%     WaveForm_1I = [0 HalfPi+SpinLockGap+DetectTime+SpinLockGap+HalfPi gSG.AWGFreq 0 0]; % No pulse at all
%     WaveForm_1Q = WaveForm_1I - repmat([0 0 0 pi/2 0], size(WaveForm_1I, 1), 1);
%     WaveForm_1Length = ceil((HalfPi+SpinLockGap+DetectTime+SpinLockGap+HalfPi + 1000) / (16/gSG.AWGClockRate)) * (16/gSG.AWGClockRate);
%     WaveForm_1PointNum = WaveForm_1Length * gSG.AWGClockRate;
%     
%     WaveForm_2I = [0 HalfPi+SpinLockGap+DetectTime+SpinLockGap+HalfPi-gmSEQ.pi gSG.AWGFreq 0 0; ...
%         HalfPi+SpinLockGap+DetectTime+SpinLockGap+HalfPi-gmSEQ.pi HalfPi+SpinLockGap+DetectTime+SpinLockGap+HalfPi gSG.AWGFreq 0 gSG.AWGAmp]; 
%     WaveForm_2Q = WaveForm_2I - repmat([0 0 0 pi/2 0], size(WaveForm_2I, 1), 1);
%     WaveForm_2Length = ceil((HalfPi+SpinLockGap+DetectTime+SpinLockGap+HalfPi + 1000) / (16/gSG.AWGClockRate)) * (16/gSG.AWGClockRate);
%     WaveForm_2PointNum = WaveForm_2Length * gSG.AWGClockRate;
% else
WaveForm_1I = [0 HalfPi-gmSEQ.halfpi gSG.AWGFreq 0 0; ...
    HalfPi-gmSEQ.halfpi HalfPi gSG.AWGFreq 0 gSG.AWGAmp; ...
    HalfPi+SpinLockGap HalfPi+SpinLockGap+DetectTime gSG.AWGFreq pi/2 gSG.LockingAmp; ...
    HalfPi+SpinLockGap+DetectTime+SpinLockGap HalfPi+SpinLockGap+DetectTime+SpinLockGap+gmSEQ.halfpi gSG.AWGFreq pi gSG.AWGAmp];
WaveForm_1Q = WaveForm_1I - repmat([0 0 0 pi/2 0], size(WaveForm_1I, 1), 1);
WaveForm_1Length = ceil((HalfPi+SpinLockGap+DetectTime+SpinLockGap+HalfPi + 1000) / (16/gSG.AWGClockRate)) * (16/gSG.AWGClockRate);
WaveForm_1PointNum = WaveForm_1Length * gSG.AWGClockRate;

WaveForm_2I = WaveForm_1I;
WaveForm_2I(size(WaveForm_1I, 1), 4) = 0; % Differential measurement
WaveForm_2Q = WaveForm_1Q;
WaveForm_2Q(size(WaveForm_1I, 1), 4) = -pi/2; % Differential measurement
WaveForm_2Length = WaveForm_1Length;
WaveForm_2PointNum = WaveForm_2Length * gSG.AWGClockRate;
    
if gmSEQ.CoolSwitch == 0
    % disp(" Polarization sequence ongoing....")
    % can also switch here
    WaveForm_3I = [0 HalfPi-gmSEQ.halfpi gSG.AWGFreq 0 0; ...
        HalfPi-gmSEQ.halfpi HalfPi gSG.AWGFreq 0 gSG.AWGAmp; ...
        HalfPi+SpinLockGap HalfPi+SpinLockGap+PolarTime gSG.AWGFreq pi/2 gSG.LockingAmp; ...
        HalfPi+SpinLockGap+PolarTime+SpinLockGap HalfPi+SpinLockGap+PolarTime+SpinLockGap+gmSEQ.halfpi gSG.AWGFreq pi gSG.AWGAmp];
    WaveForm_3Q = WaveForm_3I - repmat([0 0 0 pi/2 0], size(WaveForm_3I, 1), 1);
    WaveForm_3Length =  ceil((HalfPi+SpinLockGap+PolarTime+SpinLockGap+HalfPi + 1000) / (16/gSG.AWGClockRate)) * (16/gSG.AWGClockRate);
    WaveForm_3PointNum = WaveForm_3Length * gSG.AWGClockRate;

else
    disp(" Anti-polarization sequence ongoing....")
    WaveForm_3I = [0 HalfPi-gmSEQ.halfpi gSG.AWGFreq 0 0; ...
        HalfPi-gmSEQ.halfpi HalfPi gSG.AWGFreq pi gSG.AWGAmp; ...
        HalfPi+SpinLockGap HalfPi+SpinLockGap+PolarTime gSG.AWGFreq pi/2 gSG.LockingAmp; ...
        HalfPi+SpinLockGap+PolarTime+SpinLockGap HalfPi+SpinLockGap+PolarTime+SpinLockGap+gmSEQ.halfpi gSG.AWGFreq 0 gSG.AWGAmp];
    WaveForm_3Q = WaveForm_3I - repmat([0 0 0 pi/2 0], size(WaveForm_3I, 1), 1);
    WaveForm_3Length =  ceil((HalfPi+SpinLockGap+PolarTime+SpinLockGap+HalfPi + 1000) / (16/gSG.AWGClockRate)) * (16/gSG.AWGClockRate);
    WaveForm_3PointNum = WaveForm_3Length * gSG.AWGClockRate;
end


% P1 sequence
disp(DetectTime)
if DetectTime == 0
    WaveForm_1PI = [0 HalfPi+SpinLockGap+DetectTime+SpinLockGap+HalfPi gSG2.AWGFreq 0 0]; % No pulse at all
    WaveForm_1PQ = WaveForm_1PI - repmat([0 0 0 pi/2 0], size(WaveForm_1PI, 1), 1);
    WaveForm_1PLength = ceil((HalfPi+SpinLockGap+DetectTime+SpinLockGap+HalfPi + 1000) / (16/gSG2.P1AWGClockRate)) * (16/gSG2.P1AWGClockRate);
    WaveForm_1PPointNum = WaveForm_1PLength * gSG2.P1AWGClockRate;
else
    WaveForm_1PI = [0 HalfPi-gmSEQ.DEERhalfpi gSG2.AWGFreq 0 0; ...
        HalfPi-gmSEQ.DEERhalfpi HalfPi gSG2.AWGFreq 0 gSG2.AWGAmp; ...
        HalfPi+SpinLockGap HalfPi+SpinLockGap+DetectTime gSG2.AWGFreq pi/2 gSG2.LockingAmp; ...
        HalfPi+SpinLockGap+DetectTime+SpinLockGap HalfPi+SpinLockGap+DetectTime+SpinLockGap+gmSEQ.DEERhalfpi gSG2.AWGFreq pi gSG2.AWGAmp];
    WaveForm_1PQ = WaveForm_1PI - repmat([0 0 0 pi/2 0], size(WaveForm_1PI, 1), 1);
    WaveForm_1PLength = ceil((HalfPi+SpinLockGap+DetectTime+SpinLockGap+HalfPi + 1000) / (16/gSG2.P1AWGClockRate)) * (16/gSG2.P1AWGClockRate);
    WaveForm_1PPointNum = WaveForm_1PLength * gSG2.P1AWGClockRate;
end

% disp("Artifact diagnosis. Change polarizing bare frequency.")
% P1AWGFreq = 0.09;
% WaveForm_2PI = [0 HalfPi-gmSEQ.DEERhalfpi P1AWGFreq 0 0; ...
%     HalfPi-gmSEQ.DEERhalfpi HalfPi P1AWGFreq 0 gSG2.AWGAmp; ...
%     HalfPi+SpinLockGap HalfPi+SpinLockGap+PolarTime P1AWGFreq pi/2 gSG2.LockingAmp; ...
%     HalfPi+SpinLockGap+PolarTime+SpinLockGap HalfPi+SpinLockGap+PolarTime+SpinLockGap+gmSEQ.DEERhalfpi P1AWGFreq pi gSG2.AWGAmp];
% WaveForm_2PQ = WaveForm_2PI - repmat([0 0 0 pi/2 0], size(WaveForm_2PI, 1), 1);
% WaveForm_2PLength =  ceil((HalfPi+SpinLockGap+PolarTime+SpinLockGap+HalfPi + 1000) / (16/gSG2.P1AWGClockRate)) * (16/gSG2.P1AWGClockRate);
% WaveForm_2PPointNum = WaveForm_2PLength * gSG2.P1AWGClockRate;

WaveForm_2PI = [0 HalfPi-gmSEQ.DEERhalfpi gSG2.AWGFreq 0 0; ...
    HalfPi-gmSEQ.DEERhalfpi HalfPi gSG2.AWGFreq 0 gSG2.AWGAmp; ...
    HalfPi+SpinLockGap HalfPi+SpinLockGap+PolarTime gSG2.AWGFreq pi/2 gSG2.LockingAmp; ...
    HalfPi+SpinLockGap+PolarTime+SpinLockGap+HalfPi-gmSEQ.DEERhalfpi HalfPi+SpinLockGap+PolarTime+SpinLockGap+HalfPi gSG2.AWGFreq pi gSG2.AWGAmp];
WaveForm_2PQ = WaveForm_2PI - repmat([0 0 0 pi/2 0], size(WaveForm_2PI, 1), 1);
WaveForm_2PLength =  ceil((HalfPi+SpinLockGap+PolarTime+SpinLockGap+HalfPi + 1000) / (16/gSG2.P1AWGClockRate)) * (16/gSG2.P1AWGClockRate);
WaveForm_2PPointNum = WaveForm_2PLength * gSG2.P1AWGClockRate;

WaveForm_3PI = [0 gmSEQ.DEERhalfpi gSG2.AWGFreq 0 gSG2.AWGAmp];
WaveForm_3PQ = WaveForm_3PI - repmat([0 0 0 pi/2 0], size(WaveForm_3PI, 1), 1);
WaveForm_3PLength =  ceil((gmSEQ.DEERhalfpi + 1000) / (16/gSG2.P1AWGClockRate)) * (16/gSG2.P1AWGClockRate);
WaveForm_3PPointNum = WaveForm_3PLength * gSG2.P1AWGClockRate;

chaseFunctionPool('createWaveform', WaveForm_1I, gSG.AWGClockRate, WaveForm_1Length, 'PolarP1_I_seg1.txt'); pause(0.5);
chaseFunctionPool('createWaveform', WaveForm_1Q, gSG.AWGClockRate, WaveForm_1Length, 'PolarP1_Q_seg1.txt'); pause(0.5);
chaseFunctionPool('createWaveform', WaveForm_2I, gSG.AWGClockRate, WaveForm_2Length, 'PolarP1_I_seg2.txt'); pause(0.5);
chaseFunctionPool('createWaveform', WaveForm_2Q, gSG.AWGClockRate, WaveForm_2Length, 'PolarP1_Q_seg2.txt'); pause(0.5);
chaseFunctionPool('createWaveform', WaveForm_3I, gSG.AWGClockRate, WaveForm_3Length, 'PolarP1_I_seg3.txt'); pause(0.5);
chaseFunctionPool('createWaveform', WaveForm_3Q, gSG.AWGClockRate, WaveForm_3Length, 'PolarP1_Q_seg3.txt'); pause(0.5);

chaseFunctionPool('createWaveform', WaveForm_1PI, gSG2.P1AWGClockRate, WaveForm_1PLength, 'PolarP1_I_seg1P.txt'); pause(0.5);
chaseFunctionPool('createWaveform', WaveForm_1PQ, gSG2.P1AWGClockRate, WaveForm_1PLength, 'PolarP1_Q_seg1P.txt'); pause(0.5);
chaseFunctionPool('createWaveform', WaveForm_2PI, gSG2.P1AWGClockRate, WaveForm_2PLength, 'PolarP1_I_seg2P.txt'); pause(0.5);
chaseFunctionPool('createWaveform', WaveForm_2PQ, gSG2.P1AWGClockRate, WaveForm_2PLength, 'PolarP1_Q_seg2P.txt'); pause(0.5);
chaseFunctionPool('createWaveform', WaveForm_3PI, gSG2.P1AWGClockRate, WaveForm_3PLength, 'PolarP1_I_seg3P.txt'); pause(0.5);
chaseFunctionPool('createWaveform', WaveForm_3PQ, gSG2.P1AWGClockRate, WaveForm_3PLength, 'PolarP1_Q_seg3P.txt'); pause(0.5);

if NDepol < 2
   warning("The AWG createSegStruct is not compatible with NDepol less than 2."); 
end

if gmSEQ.PolarCycle == 0
    chaseFunctionPool('createSegStruct', 'Polar_SegStruct_I.txt', ...
        'PolarP1_I_seg1.txt', WaveForm_1PointNum, 1, 1, ... 
        'PolarP1_I_seg2.txt', WaveForm_2PointNum, 1, 1);
    pause(0.5);
    chaseFunctionPool('createSegStruct', 'Polar_SegStruct_Q.txt', ...
        'PolarP1_Q_seg1.txt', WaveForm_1PointNum, 1, 1, ...
        'PolarP1_Q_seg2.txt', WaveForm_2PointNum, 1, 1);
    pause(0.5);
    chaseFunctionPool('createSegStruct', 'Polar_P1_SegStruct_I.txt', ...
        'PolarP1_I_seg3P.txt', WaveForm_3PPointNum, 1, 1, ...
        'PolarP1_I_seg3P.txt', WaveForm_3PPointNum, NDepol-1, 1, ...
        'PolarP1_I_seg1P.txt', WaveForm_1PPointNum, 1, 1);
    pause(0.5);
    chaseFunctionPool('createSegStruct', 'Polar_P1_SegStruct_Q.txt', ...
        'PolarP1_Q_seg3P.txt', WaveForm_3PPointNum, 1, 1, ...
        'PolarP1_Q_seg3P.txt', WaveForm_3PPointNum, NDepol-1, 1, ...
        'PolarP1_Q_seg1P.txt', WaveForm_1PPointNum, 1, 1);
    pause(0.5);
    %% Load waveform to AWG
    chaseFunctionPool('CreateSegments', gmSEQ.MWAWG, 1, ...
        2, ...
        2047, 2047, 'Polar_SegStruct_I.txt', 'false');
    pause(1); % this pause seems to be important, otherwise the loading is not right occassionally
    chaseFunctionPool('CreateSegments', gmSEQ.MWAWG, 2, ...
        2, ...
        2047, 2047, 'Polar_SegStruct_Q.txt', 'false');
    pause(1); % this pause seems to be important, otherwise the loading is not right occassionally
    chaseFunctionPool('CreateSegments', gmSEQ.P1AWG, 1, ...
        3, ...
        2047, 2047, 'Polar_P1_SegStruct_I.txt', 'false');
    pause(1); % this pause seems to be important, otherwise the loading is not right occassionally   
    chaseFunctionPool('CreateSegments', gmSEQ.P1AWG, 2, ...
        3, ...
        2047, 2047, 'Polar_P1_SegStruct_Q.txt', 'false');
    pause(1); % this pause seems to be important, otherwise the loading is not right occassionally 
elseif gmSEQ.PolarCycle == 1
    chaseFunctionPool('createSegStruct', 'Polar_SegStruct_I.txt', ...
        'PolarP1_I_seg3.txt', WaveForm_3PointNum, 1, 1, ...
        'PolarP1_I_seg1.txt', WaveForm_1PointNum, 1, 1, ... 
        'PolarP1_I_seg3.txt', WaveForm_3PointNum, 1, 1, ...
        'PolarP1_I_seg2.txt', WaveForm_2PointNum, 1, 1);
    pause(0.5);
    chaseFunctionPool('createSegStruct', 'Polar_SegStruct_Q.txt', ...
        'PolarP1_Q_seg3.txt', WaveForm_3PointNum, 1, 1, ...
        'PolarP1_Q_seg1.txt', WaveForm_1PointNum, 1, 1, ...
        'PolarP1_Q_seg3.txt', WaveForm_3PointNum, 1, 1, ...
        'PolarP1_Q_seg2.txt', WaveForm_2PointNum, 1, 1);
    pause(0.5);
    chaseFunctionPool('createSegStruct', 'Polar_P1_SegStruct_I.txt', ...
        'PolarP1_I_seg3P.txt', WaveForm_3PPointNum, 1, 1, ...
        'PolarP1_I_seg3P.txt', WaveForm_3PPointNum, NDepol-1, 1, ...
        'PolarP1_I_seg2P.txt', WaveForm_2PPointNum, 1, 1, ...
        'PolarP1_I_seg1P.txt', WaveForm_1PPointNum, 1, 1);
    pause(0.5);
    chaseFunctionPool('createSegStruct', 'Polar_P1_SegStruct_Q.txt', ...
        'PolarP1_Q_seg3P.txt', WaveForm_3PPointNum, 1, 1, ...
        'PolarP1_Q_seg3P.txt', WaveForm_3PPointNum, NDepol-1, 1, ...
        'PolarP1_Q_seg2P.txt', WaveForm_2PPointNum, 1, 1, ...
        'PolarP1_Q_seg1P.txt', WaveForm_1PPointNum, 1, 1);
    pause(0.5);
    %% Load waveform to AWG
    chaseFunctionPool('CreateSegments', gmSEQ.MWAWG, 1, ...
        4, ...
        2047, 2047, 'Polar_SegStruct_I.txt', 'false');
    pause(1); % this pause seems to be important, otherwise the loading is not right occassionally
    chaseFunctionPool('CreateSegments', gmSEQ.MWAWG, 2, ...
        4, ...
        2047, 2047, 'Polar_SegStruct_Q.txt', 'false');
    pause(1); % this pause seems to be important, otherwise the loading is not right occassionally
    chaseFunctionPool('CreateSegments', gmSEQ.P1AWG, 1, ...
        4, ...
        2047, 2047, 'Polar_P1_SegStruct_I.txt', 'false');
    pause(1); % this pause seems to be important, otherwise the loading is not right occassionally   
    chaseFunctionPool('CreateSegments', gmSEQ.P1AWG, 2, ...
        4, ...
        2047, 2047, 'Polar_P1_SegStruct_Q.txt', 'false');
    pause(1); % this pause seems to be important, otherwise the loading is not right occassionally 
else 
    chaseFunctionPool('createSegStruct', 'Polar_SegStruct_I.txt', ...
        'PolarP1_I_seg3.txt', WaveForm_3PointNum, 1, 1, ...
        'PolarP1_I_seg3.txt', WaveForm_3PointNum, gmSEQ.PolarCycle - 1, 1, ...
        'PolarP1_I_seg1.txt', WaveForm_1PointNum, 1, 1, ... 
        'PolarP1_I_seg3.txt', WaveForm_3PointNum, 1, 1, ...
        'PolarP1_I_seg3.txt', WaveForm_3PointNum, gmSEQ.PolarCycle - 1, 1, ...
        'PolarP1_I_seg2.txt', WaveForm_2PointNum, 1, 1);
    pause(0.5);
    chaseFunctionPool('createSegStruct', 'Polar_SegStruct_Q.txt', ...
        'PolarP1_Q_seg3.txt', WaveForm_3PointNum, 1, 1, ...
        'PolarP1_Q_seg3.txt', WaveForm_3PointNum, gmSEQ.PolarCycle - 1, 1, ...
        'PolarP1_Q_seg1.txt', WaveForm_1PointNum, 1, 1, ...
        'PolarP1_Q_seg3.txt', WaveForm_3PointNum, 1, 1, ...
        'PolarP1_Q_seg3.txt', WaveForm_3PointNum, gmSEQ.PolarCycle - 1, 1, ...
        'PolarP1_Q_seg2.txt', WaveForm_2PointNum, 1, 1);
    pause(0.5);
    chaseFunctionPool('createSegStruct', 'Polar_P1_SegStruct_I.txt', ...
        'PolarP1_I_seg3P.txt', WaveForm_3PPointNum, 1, 1, ...
        'PolarP1_I_seg3P.txt', WaveForm_3PPointNum, NDepol-1, 1, ...
        'PolarP1_I_seg2P.txt', WaveForm_2PPointNum, 1, 1, ...
        'PolarP1_I_seg2P.txt', WaveForm_2PPointNum, gmSEQ.PolarCycle-1, 1, ...
        'PolarP1_I_seg1P.txt', WaveForm_1PPointNum, 1, 1);
    pause(0.5);
    chaseFunctionPool('createSegStruct', 'Polar_P1_SegStruct_Q.txt', ...
        'PolarP1_Q_seg3P.txt', WaveForm_3PPointNum, 1, 1, ...
        'PolarP1_Q_seg3P.txt', WaveForm_3PPointNum, NDepol-1, 1, ...
        'PolarP1_Q_seg2P.txt', WaveForm_2PPointNum, 1, 1, ...
        'PolarP1_Q_seg2P.txt', WaveForm_2PPointNum, gmSEQ.PolarCycle-1, 1, ...
        'PolarP1_Q_seg1P.txt', WaveForm_1PPointNum, 1, 1);
    pause(0.5);
    %% Load waveform to AWG
    chaseFunctionPool('CreateSegments', gmSEQ.MWAWG, 1, ...
        6, ...
        2047, 2047, 'Polar_SegStruct_I.txt', 'false');
    pause(1); % this pause seems to be important, otherwise the loading is not right occassionally
    chaseFunctionPool('CreateSegments', gmSEQ.MWAWG, 2, ...
        6 , ...
        2047, 2047, 'Polar_SegStruct_Q.txt', 'false');
    pause(1); % this pause seems to be important, otherwise the loading is not right occassionally
    chaseFunctionPool('CreateSegments', gmSEQ.P1AWG, 1, ...
        5, ...
        2047, 2047, 'Polar_P1_SegStruct_I.txt', 'false');
    pause(1); % this pause seems to be important, otherwise the loading is not right occassionally   
    chaseFunctionPool('CreateSegments', gmSEQ.P1AWG, 2, ...
        5, ...
        2047, 2047, 'Polar_P1_SegStruct_Q.txt', 'false');
    pause(1); % this pause seems to be important, otherwise the loading is not right occassionally 
end

%% Run waveform
chaseFunctionPool('runChase', gmSEQ.MWAWG, 'false'); pause(1);
chaseFunctionPool('runChase', gmSEQ.P1AWG, 'false'); pause(1);
ApplyDelays();


function PolarP1_SwpT % have not tested yet
global gmSEQ gSG gSG2
gSG.bfixedPow=1;
gSG.bfixedFreq=1;
gSG.bMod='IQ';
gSG.bModSrc='External';

gSG2.bMod='IQ';
gSG2.bModSrc='External';
SignalGeneratorFunctionPool2('SetMod');
SignalGeneratorFunctionPool2('WritePow');
SignalGeneratorFunctionPool2('WriteFreq');
gSG2.bOn=1; SignalGeneratorFunctionPool2('RFOnOff');

% Temp use. TODO: find an input window for this param
gSG.LockingAmp = gmSEQ.SAmp1;
gSG2.LockingAmp = gmSEQ.SAmp2;
gmSEQ.PolarCycle = gmSEQ.CoolCycle;
gmSEQ.DEERhalfpi = gmSEQ.DEERpi/2;

NDepol = 2; % Depolarization pulse for P1
IntDepol = 0.1e6;
SpinLockGap = 10;
AfterPi = 1000;
AfterLaser = 2000; % 0.1e6?
AfterPolar = 1000;
Wait_p = NDepol*IntDepol + 0.2e6;
Detect_Window = 5000;
PolarTime = gmSEQ.m; % polarizing interaction time between NV and P1
PolarReadout = 5000; % polarizing initialization time
HalfPi = max(gmSEQ.halfpi, gmSEQ.DEERhalfpi);
CycleTime = PolarReadout+AfterLaser+HalfPi+SpinLockGap+PolarTime+SpinLockGap+HalfPi+AfterPolar;
Sig_D_start = Wait_p+CycleTime*gmSEQ.PolarCycle+gmSEQ.readout+AfterLaser+HalfPi+SpinLockGap+gmSEQ.DEERt+SpinLockGap+HalfPi+AfterPi+Detect_Window+Wait_p;

gmSEQ.CHN(1).PBN=PBDictionary('ctr0');
gmSEQ.CHN(1).NRise=4;
gmSEQ.CHN(1).T=[Wait_p+CycleTime*gmSEQ.PolarCycle+gmSEQ.readout-1000-gmSEQ.CtrGateDur, ...
    Wait_p+CycleTime*gmSEQ.PolarCycle+gmSEQ.readout+AfterLaser+HalfPi+SpinLockGap+gmSEQ.DEERt+SpinLockGap+HalfPi+AfterPi, ...
    Sig_D_start+CycleTime*gmSEQ.PolarCycle+gmSEQ.readout-1000-gmSEQ.CtrGateDur, ... 
    Sig_D_start+CycleTime*gmSEQ.PolarCycle+gmSEQ.readout+AfterLaser+HalfPi+SpinLockGap+gmSEQ.DEERt+SpinLockGap+HalfPi+AfterPi];
if strcmp(gmSEQ.meas,'SPCM')
    gmSEQ.CHN(1).DT=[gmSEQ.CtrGateDur gmSEQ.CtrGateDur gmSEQ.CtrGateDur gmSEQ.CtrGateDur];
elseif strcmp(gmSEQ.meas,'APD')
    gmSEQ.CHN(1).DT=[1000 1000 1000 1000];
end

gmSEQ.CHN(numel(gmSEQ.CHN)+1).PBN=PBDictionary('AOM');
gmSEQ.CHN(numel(gmSEQ.CHN)).NRise=2*(2 + gmSEQ.PolarCycle);
gmSEQ.CHN(numel(gmSEQ.CHN)).T = zeros(1, gmSEQ.CHN(numel(gmSEQ.CHN)).NRise);
for i = 1:gmSEQ.PolarCycle
    gmSEQ.CHN(numel(gmSEQ.CHN)).T(i)=Wait_p+(i-1)*CycleTime;
end
gmSEQ.CHN(numel(gmSEQ.CHN)).T(gmSEQ.PolarCycle+1)=Wait_p+CycleTime*gmSEQ.PolarCycle;
gmSEQ.CHN(numel(gmSEQ.CHN)).T(gmSEQ.PolarCycle+2)=Wait_p+CycleTime*gmSEQ.PolarCycle ...
    +gmSEQ.readout+AfterLaser+HalfPi+SpinLockGap+gmSEQ.DEERt+SpinLockGap+HalfPi+AfterPi;
for i = 1:gmSEQ.PolarCycle
    gmSEQ.CHN(numel(gmSEQ.CHN)).T(gmSEQ.PolarCycle+2+i)=Sig_D_start+(i-1)*CycleTime;
end
gmSEQ.CHN(numel(gmSEQ.CHN)).T(2*gmSEQ.PolarCycle+3)=Sig_D_start+CycleTime*gmSEQ.PolarCycle;
gmSEQ.CHN(numel(gmSEQ.CHN)).T(2*gmSEQ.PolarCycle+4)=Sig_D_start+CycleTime*gmSEQ.PolarCycle ...
	+gmSEQ.readout+AfterLaser+HalfPi+SpinLockGap+gmSEQ.DEERt+SpinLockGap+HalfPi+AfterPi;
gmSEQ.CHN(numel(gmSEQ.CHN)).DT = [repelem(PolarReadout, gmSEQ.PolarCycle) gmSEQ.readout Detect_Window ...
    repelem(PolarReadout, gmSEQ.PolarCycle) gmSEQ.readout Detect_Window];

gmSEQ.CHN(numel(gmSEQ.CHN)+1).PBN=PBDictionary('AWGTrig');
gmSEQ.CHN(numel(gmSEQ.CHN)).NRise=2*(1 + gmSEQ.PolarCycle);
gmSEQ.CHN(numel(gmSEQ.CHN)).T = zeros(1, gmSEQ.CHN(numel(gmSEQ.CHN)).NRise);
for i = 1:gmSEQ.PolarCycle
    gmSEQ.CHN(numel(gmSEQ.CHN)).T(i)=Wait_p+(i-1)*CycleTime+PolarReadout+AfterLaser;
    gmSEQ.CHN(numel(gmSEQ.CHN)).T(gmSEQ.PolarCycle+1+i)=Sig_D_start+(i-1)*CycleTime+PolarReadout+AfterLaser;
end
gmSEQ.CHN(numel(gmSEQ.CHN)).T(gmSEQ.PolarCycle+1)=Wait_p+CycleTime*gmSEQ.PolarCycle+gmSEQ.readout+AfterLaser;
gmSEQ.CHN(numel(gmSEQ.CHN)).T(2*gmSEQ.PolarCycle+2)=Sig_D_start+CycleTime*gmSEQ.PolarCycle+gmSEQ.readout+AfterLaser;
gmSEQ.CHN(numel(gmSEQ.CHN)).DT=[repelem(HalfPi+SpinLockGap+PolarTime+SpinLockGap+HalfPi+200,gmSEQ.PolarCycle), ...
    HalfPi+SpinLockGap+gmSEQ.DEERt+SpinLockGap+HalfPi+200, ... 
    repelem(HalfPi+SpinLockGap+PolarTime+SpinLockGap+HalfPi+200,gmSEQ.PolarCycle), ...
    HalfPi+SpinLockGap+gmSEQ.DEERt+SpinLockGap+HalfPi+200];

% P1 AWG Trig
gmSEQ.CHN(numel(gmSEQ.CHN)+1).PBN=PBDictionary('AWGTrig2');
gmSEQ.CHN(numel(gmSEQ.CHN)).NRise=2*(1 + gmSEQ.PolarCycle + NDepol);
gmSEQ.CHN(numel(gmSEQ.CHN)).T=zeros(1, gmSEQ.CHN(numel(gmSEQ.CHN)).NRise);
for i = 1:NDepol
    gmSEQ.CHN(numel(gmSEQ.CHN)).T(i)=i*IntDepol-gmSEQ.DEERpi/2;
    gmSEQ.CHN(numel(gmSEQ.CHN)).T(i+1+gmSEQ.PolarCycle+NDepol)=Sig_D_start-Wait_p+i*IntDepol-gmSEQ.DEERpi/2;
end
for i = 1:gmSEQ.PolarCycle
    gmSEQ.CHN(numel(gmSEQ.CHN)).T(NDepol + i)=Wait_p+(i-1)*CycleTime+PolarReadout+AfterLaser;
    gmSEQ.CHN(numel(gmSEQ.CHN)).T(2*NDepol+gmSEQ.PolarCycle+i+1)=Sig_D_start+(i-1)*CycleTime+PolarReadout+AfterLaser;
end
gmSEQ.CHN(numel(gmSEQ.CHN)).T(NDepol+gmSEQ.PolarCycle+1)=Wait_p+CycleTime*gmSEQ.PolarCycle+gmSEQ.readout+AfterLaser;
gmSEQ.CHN(numel(gmSEQ.CHN)).T(2*NDepol+2*gmSEQ.PolarCycle+2)=Sig_D_start+CycleTime*gmSEQ.PolarCycle+gmSEQ.readout+AfterLaser;
gmSEQ.CHN(numel(gmSEQ.CHN)).DT=[repelem(gmSEQ.DEERpi/2+200, NDepol), ... 
    repelem(HalfPi+SpinLockGap+PolarTime+SpinLockGap+HalfPi+200,gmSEQ.PolarCycle), ...
    HalfPi+SpinLockGap+gmSEQ.DEERt+SpinLockGap+HalfPi+200, ...
    repelem(gmSEQ.DEERpi/2+200, NDepol), ... 
    repelem(HalfPi+SpinLockGap+PolarTime+SpinLockGap+HalfPi+200,gmSEQ.PolarCycle), ...
    HalfPi+SpinLockGap+gmSEQ.DEERt+SpinLockGap+HalfPi+200];

gmSEQ.CHN(numel(gmSEQ.CHN)+1).PBN=PBDictionary('MWSwitch');
gmSEQ.CHN(numel(gmSEQ.CHN)).NRise=2*(1 + gmSEQ.PolarCycle);
gmSEQ.CHN(numel(gmSEQ.CHN)).T = zeros(1, gmSEQ.CHN(numel(gmSEQ.CHN)).NRise);
for i = 1:gmSEQ.PolarCycle
    gmSEQ.CHN(numel(gmSEQ.CHN)).T(i)=Wait_p+(i-1)*CycleTime+PolarReadout+AfterLaser-20;
    gmSEQ.CHN(numel(gmSEQ.CHN)).T(gmSEQ.PolarCycle+1+i)=Sig_D_start+(i-1)*CycleTime+PolarReadout+AfterLaser-20;
end
gmSEQ.CHN(numel(gmSEQ.CHN)).T(gmSEQ.PolarCycle+1)=Wait_p+CycleTime*gmSEQ.PolarCycle+gmSEQ.readout+AfterLaser-20;
gmSEQ.CHN(numel(gmSEQ.CHN)).T(2*gmSEQ.PolarCycle+2)=Sig_D_start+CycleTime*gmSEQ.PolarCycle+gmSEQ.readout+AfterLaser-20;
gmSEQ.CHN(numel(gmSEQ.CHN)).DT=[repelem(HalfPi+SpinLockGap+PolarTime+SpinLockGap+HalfPi+40, gmSEQ.PolarCycle), ...
    HalfPi+SpinLockGap+gmSEQ.DEERt+SpinLockGap+HalfPi+40, ...
    repelem(HalfPi+SpinLockGap+PolarTime+SpinLockGap+HalfPi+40, gmSEQ.PolarCycle), ...
    HalfPi+SpinLockGap+gmSEQ.DEERt+SpinLockGap+HalfPi+40];

gmSEQ.CHN(numel(gmSEQ.CHN)+1).PBN=PBDictionary('MWSwitch2');
gmSEQ.CHN(numel(gmSEQ.CHN)).NRise=2*(1 + gmSEQ.PolarCycle + NDepol);
gmSEQ.CHN(numel(gmSEQ.CHN)).T = zeros(1, gmSEQ.CHN(numel(gmSEQ.CHN)).NRise);
for i = 1:NDepol
    gmSEQ.CHN(numel(gmSEQ.CHN)).T(i)=i*IntDepol-gmSEQ.DEERpi/2-20;
    gmSEQ.CHN(numel(gmSEQ.CHN)).T(i+1+gmSEQ.PolarCycle+NDepol)=Sig_D_start-Wait_p+i*IntDepol-gmSEQ.DEERpi/2-20;
end
for i = 1:gmSEQ.PolarCycle
    gmSEQ.CHN(numel(gmSEQ.CHN)).T(NDepol + i)=Wait_p+(i-1)*CycleTime+PolarReadout+AfterLaser-20;
    gmSEQ.CHN(numel(gmSEQ.CHN)).T(2*NDepol+gmSEQ.PolarCycle+i+1)=Sig_D_start+(i-1)*CycleTime+PolarReadout+AfterLaser-20;
end
gmSEQ.CHN(numel(gmSEQ.CHN)).T(NDepol+gmSEQ.PolarCycle+1)=Wait_p+CycleTime*gmSEQ.PolarCycle+gmSEQ.readout+AfterLaser-20;
gmSEQ.CHN(numel(gmSEQ.CHN)).T(2*NDepol+2*gmSEQ.PolarCycle+2)=Sig_D_start+CycleTime*gmSEQ.PolarCycle+gmSEQ.readout+AfterLaser-20;
gmSEQ.CHN(numel(gmSEQ.CHN)).DT=[repelem(gmSEQ.DEERpi/2+20, NDepol), ... 
    repelem(HalfPi+SpinLockGap+PolarTime+SpinLockGap+HalfPi+40,gmSEQ.PolarCycle), ...
    HalfPi+SpinLockGap+gmSEQ.DEERt+SpinLockGap+HalfPi+40, ...
    repelem(gmSEQ.DEERpi/2+20, NDepol), ... 
    repelem(HalfPi+SpinLockGap+PolarTime+SpinLockGap+HalfPi+40,gmSEQ.PolarCycle), ...
    HalfPi+SpinLockGap+gmSEQ.DEERt+SpinLockGap+HalfPi+40];

gmSEQ.CHN(numel(gmSEQ.CHN)+1).PBN=PBDictionary('dummy1');
gmSEQ.CHN(numel(gmSEQ.CHN)).NRise=2;
gmSEQ.CHN(numel(gmSEQ.CHN)).T=[0 Sig_D_start+CycleTime*gmSEQ.PolarCycle+gmSEQ.readout+AfterLaser+ ...
    HalfPi+SpinLockGap+gmSEQ.DEERt+SpinLockGap+HalfPi+AfterPi+Detect_Window-50];
gmSEQ.CHN(numel(gmSEQ.CHN)).DT=[50 50];

%% AWG
% Initialization
chaseFunctionPool('stopChase', gmSEQ.MWAWG); pause(1);
chaseFunctionPool('stopChase', gmSEQ.P1AWG);

% This part need to be modified to accomodate the DC modulation
if ~gSG.ACmodAWG % in AC modulation mode
    gSG.AWGFreq = 0;
    gSG2.AWGFreq = 0;
end

WaveForm_1I = [0 gmSEQ.halfpi gSG.AWGFreq 0 gSG.AWGAmp; ...
    HalfPi+SpinLockGap HalfPi+SpinLockGap+gmSEQ.DEERt gSG.AWGFreq pi/2 gSG.LockingAmp; ...
    HalfPi+SpinLockGap+gmSEQ.DEERt+SpinLockGap+HalfPi-gmSEQ.halfpi HalfPi+SpinLockGap+gmSEQ.DEERt+SpinLockGap+HalfPi gSG.AWGFreq pi gSG.AWGAmp];
WaveForm_1Q = WaveForm_1I - repmat([0 0 0 pi/2 0], size(WaveForm_1I, 1), 1);
WaveForm_1Length = ceil((HalfPi+SpinLockGap+gmSEQ.DEERt+SpinLockGap+HalfPi + 1000) / (16/gSG.AWGClockRate)) * (16/gSG.AWGClockRate);
WaveForm_1PointNum = WaveForm_1Length * gSG.AWGClockRate;

WaveForm_2I = WaveForm_1I;
WaveForm_2I(size(WaveForm_1I, 1), 4) = 0; % Differential measurement
WaveForm_2Q = WaveForm_1Q;
WaveForm_2Q(size(WaveForm_1I, 1), 4) = -pi/2; % Differential measurement
WaveForm_2Length = WaveForm_1Length;
WaveForm_2PointNum = WaveForm_2Length * gSG.AWGClockRate;

WaveForm_3I = [0 gmSEQ.halfpi gSG.AWGFreq 0 gSG.AWGAmp; ...
    HalfPi+SpinLockGap HalfPi+SpinLockGap+PolarTime gSG.AWGFreq pi/2 gSG.LockingAmp; ...
    HalfPi+SpinLockGap+PolarTime+SpinLockGap+HalfPi-gmSEQ.halfpi HalfPi+SpinLockGap+PolarTime+SpinLockGap+HalfPi gSG.AWGFreq pi gSG.AWGAmp];
WaveForm_3Q = WaveForm_3I - repmat([0 0 0 pi/2 0], size(WaveForm_3I, 1), 1);
WaveForm_3Length =  ceil((HalfPi+SpinLockGap+PolarTime+SpinLockGap+HalfPi + 1000) / (16/gSG.AWGClockRate)) * (16/gSG.AWGClockRate);
WaveForm_3PointNum = WaveForm_3Length * gSG.AWGClockRate;

% P1 sequence
WaveForm_1PI = [0 gmSEQ.DEERhalfpi gSG2.AWGFreq 0 gSG2.AWGAmp; ...
    HalfPi+SpinLockGap HalfPi+SpinLockGap+gmSEQ.DEERt gSG2.AWGFreq pi/2 gSG2.LockingAmp; ...
    HalfPi+SpinLockGap+gmSEQ.DEERt+SpinLockGap+HalfPi-gmSEQ.DEERhalfpi HalfPi+SpinLockGap+gmSEQ.DEERt+SpinLockGap+HalfPi gSG2.AWGFreq pi gSG2.AWGAmp];
WaveForm_1PQ = WaveForm_1PI - repmat([0 0 0 pi/2 0], size(WaveForm_1PI, 1), 1);
WaveForm_1PLength = ceil((HalfPi+SpinLockGap+gmSEQ.DEERt+SpinLockGap+HalfPi + 1000) / (16/gSG2.P1AWGClockRate)) * (16/gSG2.P1AWGClockRate);
WaveForm_1PPointNum = WaveForm_1PLength * gSG2.P1AWGClockRate;

WaveForm_2PI = [0 gmSEQ.DEERhalfpi gSG2.AWGFreq 0 gSG2.AWGAmp; ...
    HalfPi+SpinLockGap HalfPi+SpinLockGap+PolarTime gSG2.AWGFreq pi/2 gSG2.LockingAmp; ...
    HalfPi+SpinLockGap+PolarTime+SpinLockGap+HalfPi-gmSEQ.DEERhalfpi HalfPi+SpinLockGap+PolarTime+SpinLockGap+HalfPi gSG2.AWGFreq pi gSG2.AWGAmp];
WaveForm_2PQ = WaveForm_2PI - repmat([0 0 0 pi/2 0], size(WaveForm_2PI, 1), 1);
WaveForm_2PLength =  ceil((HalfPi+SpinLockGap+PolarTime+SpinLockGap+HalfPi + 1000) / (16/gSG2.P1AWGClockRate)) * (16/gSG2.P1AWGClockRate);
WaveForm_2PPointNum = WaveForm_2PLength * gSG2.P1AWGClockRate;

WaveForm_3PI = [0 gmSEQ.DEERhalfpi gSG2.AWGFreq 0 gSG2.AWGAmp];
WaveForm_3PQ = WaveForm_3PI - repmat([0 0 0 pi/2 0], size(WaveForm_3PI, 1), 1);
WaveForm_3PLength =  ceil((gmSEQ.DEERhalfpi + 1000) / (16/gSG2.P1AWGClockRate)) * (16/gSG2.P1AWGClockRate);
WaveForm_3PPointNum = WaveForm_3PLength * gSG2.P1AWGClockRate;

chaseFunctionPool('createWaveform', WaveForm_1I, gSG.AWGClockRate, WaveForm_1Length, 'PolarP1_I_seg1.txt'); pause(0.5);
chaseFunctionPool('createWaveform', WaveForm_1Q, gSG.AWGClockRate, WaveForm_1Length, 'PolarP1_Q_seg1.txt'); pause(0.5);
chaseFunctionPool('createWaveform', WaveForm_2I, gSG.AWGClockRate, WaveForm_2Length, 'PolarP1_I_seg2.txt'); pause(0.5);
chaseFunctionPool('createWaveform', WaveForm_2Q, gSG.AWGClockRate, WaveForm_2Length, 'PolarP1_Q_seg2.txt'); pause(0.5);
chaseFunctionPool('createWaveform', WaveForm_3I, gSG.AWGClockRate, WaveForm_3Length, 'PolarP1_I_seg3.txt'); pause(0.5);
chaseFunctionPool('createWaveform', WaveForm_3Q, gSG.AWGClockRate, WaveForm_3Length, 'PolarP1_Q_seg3.txt'); pause(0.5);

chaseFunctionPool('createWaveform', WaveForm_1PI, gSG2.P1AWGClockRate, WaveForm_1PLength, 'PolarP1_I_seg1P.txt'); pause(0.5);
chaseFunctionPool('createWaveform', WaveForm_1PQ, gSG2.P1AWGClockRate, WaveForm_1PLength, 'PolarP1_Q_seg1P.txt'); pause(0.5);
chaseFunctionPool('createWaveform', WaveForm_2PI, gSG2.P1AWGClockRate, WaveForm_2PLength, 'PolarP1_I_seg2P.txt'); pause(0.5);
chaseFunctionPool('createWaveform', WaveForm_2PQ, gSG2.P1AWGClockRate, WaveForm_2PLength, 'PolarP1_Q_seg2P.txt'); pause(0.5);
chaseFunctionPool('createWaveform', WaveForm_3PI, gSG2.P1AWGClockRate, WaveForm_3PLength, 'PolarP1_I_seg3P.txt'); pause(0.5);
chaseFunctionPool('createWaveform', WaveForm_3PQ, gSG2.P1AWGClockRate, WaveForm_3PLength, 'PolarP1_Q_seg3P.txt'); pause(0.5);

if NDepol < 2
   warning("The AWG createSegStruct is not compatible with NDepol less than 2."); 
end

if gmSEQ.PolarCycle == 0
    chaseFunctionPool('createSegStruct', 'Polar_SegStruct_I.txt', ...
        'PolarP1_I_seg1.txt', WaveForm_1PointNum, 1, 1, ... 
        'PolarP1_I_seg2.txt', WaveForm_2PointNum, 1, 1);
    pause(0.5);
    chaseFunctionPool('createSegStruct', 'Polar_SegStruct_Q.txt', ...
        'PolarP1_Q_seg1.txt', WaveForm_1PointNum, 1, 1, ...
        'PolarP1_Q_seg2.txt', WaveForm_2PointNum, 1, 1);
    pause(0.5);
    chaseFunctionPool('createSegStruct', 'Polar_P1_SegStruct_I.txt', ...
        'PolarP1_I_seg3P.txt', WaveForm_3PPointNum, 1, 1, ...
        'PolarP1_I_seg3P.txt', WaveForm_3PPointNum, NDepol-1, 1, ...
        'PolarP1_I_seg1P.txt', WaveForm_1PPointNum, 1, 1);
    pause(0.5);
    chaseFunctionPool('createSegStruct', 'Polar_P1_SegStruct_Q.txt', ...
        'PolarP1_Q_seg3P.txt', WaveForm_3PPointNum, 1, 1, ...
        'PolarP1_Q_seg3P.txt', WaveForm_3PPointNum, NDepol-1, 1, ...
        'PolarP1_Q_seg1P.txt', WaveForm_1PPointNum, 1, 1);
    pause(0.5);
    %% Load waveform to AWG
    chaseFunctionPool('CreateSegments', gmSEQ.MWAWG, 1, ...
        2, ...
        2047, 2047, 'Polar_SegStruct_I.txt', 'false');
    pause(1); % this pause seems to be important, otherwise the loading is not right occassionally
    chaseFunctionPool('CreateSegments', gmSEQ.MWAWG, 2, ...
        2, ...
        2047, 2047, 'Polar_SegStruct_Q.txt', 'false');
    pause(1); % this pause seems to be important, otherwise the loading is not right occassionally
    chaseFunctionPool('CreateSegments', gmSEQ.P1AWG, 1, ...
        3, ...
        2047, 2047, 'Polar_P1_SegStruct_I.txt', 'false');
    pause(1); % this pause seems to be important, otherwise the loading is not right occassionally   
    chaseFunctionPool('CreateSegments', gmSEQ.P1AWG, 2, ...
        3, ...
        2047, 2047, 'Polar_P1_SegStruct_Q.txt', 'false');
    pause(1); % this pause seems to be important, otherwise the loading is not right occassionally 
elseif gmSEQ.PolarCycle == 1
    chaseFunctionPool('createSegStruct', 'Polar_SegStruct_I.txt', ...
        'PolarP1_I_seg3.txt', WaveForm_3PointNum, 1, 1, ...
        'PolarP1_I_seg1.txt', WaveForm_1PointNum, 1, 1, ... 
        'PolarP1_I_seg3.txt', WaveForm_3PointNum, 1, 1, ...
        'PolarP1_I_seg2.txt', WaveForm_2PointNum, 1, 1);
    pause(0.5);
    chaseFunctionPool('createSegStruct', 'Polar_SegStruct_Q.txt', ...
        'PolarP1_Q_seg3.txt', WaveForm_3PointNum, 1, 1, ...
        'PolarP1_Q_seg1.txt', WaveForm_1PointNum, 1, 1, ...
        'PolarP1_Q_seg3.txt', WaveForm_3PointNum, 1, 1, ...
        'PolarP1_Q_seg2.txt', WaveForm_2PointNum, 1, 1);
    pause(0.5);
    chaseFunctionPool('createSegStruct', 'Polar_P1_SegStruct_I.txt', ...
        'PolarP1_I_seg3P.txt', WaveForm_3PPointNum, 1, 1, ...
        'PolarP1_I_seg3P.txt', WaveForm_3PPointNum, NDepol-1, 1, ...
        'PolarP1_I_seg2P.txt', WaveForm_2PPointNum, 1, 1, ...
        'PolarP1_I_seg1P.txt', WaveForm_1PPointNum, 1, 1);
    pause(0.5);
    chaseFunctionPool('createSegStruct', 'Polar_P1_SegStruct_Q.txt', ...
        'PolarP1_Q_seg3P.txt', WaveForm_3PPointNum, 1, 1, ...
        'PolarP1_Q_seg3P.txt', WaveForm_3PPointNum, NDepol-1, 1, ...
        'PolarP1_Q_seg2P.txt', WaveForm_2PPointNum, 1, 1, ...
        'PolarP1_Q_seg1P.txt', WaveForm_1PPointNum, 1, 1);
    pause(0.5);
    %% Load waveform to AWG
    chaseFunctionPool('CreateSegments', gmSEQ.MWAWG, 1, ...
        4, ...
        2047, 2047, 'Polar_SegStruct_I.txt', 'false');
    pause(1); % this pause seems to be important, otherwise the loading is not right occassionally
    chaseFunctionPool('CreateSegments', gmSEQ.MWAWG, 2, ...
        4, ...
        2047, 2047, 'Polar_SegStruct_Q.txt', 'false');
    pause(1); % this pause seems to be important, otherwise the loading is not right occassionally
    chaseFunctionPool('CreateSegments', gmSEQ.P1AWG, 1, ...
        4, ...
        2047, 2047, 'Polar_P1_SegStruct_I.txt', 'false');
    pause(1); % this pause seems to be important, otherwise the loading is not right occassionally   
    chaseFunctionPool('CreateSegments', gmSEQ.P1AWG, 2, ...
        4, ...
        2047, 2047, 'Polar_P1_SegStruct_Q.txt', 'false');
    pause(1); % this pause seems to be important, otherwise the loading is not right occassionally 
else 
    chaseFunctionPool('createSegStruct', 'Polar_SegStruct_I.txt', ...
        'PolarP1_I_seg3.txt', WaveForm_3PointNum, 1, 1, ...
        'PolarP1_I_seg3.txt', WaveForm_3PointNum, gmSEQ.PolarCycle - 1, 1, ...
        'PolarP1_I_seg1.txt', WaveForm_1PointNum, 1, 1, ... 
        'PolarP1_I_seg3.txt', WaveForm_3PointNum, 1, 1, ...
        'PolarP1_I_seg3.txt', WaveForm_3PointNum, gmSEQ.PolarCycle - 1, 1, ...
        'PolarP1_I_seg2.txt', WaveForm_2PointNum, 1, 1);
    pause(0.5);
    chaseFunctionPool('createSegStruct', 'Polar_SegStruct_Q.txt', ...
        'PolarP1_Q_seg3.txt', WaveForm_3PointNum, 1, 1, ...
        'PolarP1_Q_seg3.txt', WaveForm_3PointNum, gmSEQ.PolarCycle - 1, 1, ...
        'PolarP1_Q_seg1.txt', WaveForm_1PointNum, 1, 1, ...
        'PolarP1_Q_seg3.txt', WaveForm_3PointNum, 1, 1, ...
        'PolarP1_Q_seg3.txt', WaveForm_3PointNum, gmSEQ.PolarCycle - 1, 1, ...
        'PolarP1_Q_seg2.txt', WaveForm_2PointNum, 1, 1);
    pause(0.5);
    chaseFunctionPool('createSegStruct', 'Polar_P1_SegStruct_I.txt', ...
        'PolarP1_I_seg3P.txt', WaveForm_3PPointNum, 1, 1, ...
        'PolarP1_I_seg3P.txt', WaveForm_3PPointNum, NDepol-1, 1, ...
        'PolarP1_I_seg2P.txt', WaveForm_2PPointNum, 1, 1, ...
        'PolarP1_I_seg2P.txt', WaveForm_2PPointNum, gmSEQ.PolarCycle-1, 1, ...
        'PolarP1_I_seg1P.txt', WaveForm_1PPointNum, 1, 1);
    pause(0.5);
    chaseFunctionPool('createSegStruct', 'Polar_P1_SegStruct_Q.txt', ...
        'PolarP1_Q_seg3P.txt', WaveForm_3PPointNum, 1, 1, ...
        'PolarP1_Q_seg3P.txt', WaveForm_3PPointNum, NDepol-1, 1, ...
        'PolarP1_Q_seg2P.txt', WaveForm_2PPointNum, 1, 1, ...
        'PolarP1_Q_seg2P.txt', WaveForm_2PPointNum, gmSEQ.PolarCycle-1, 1, ...
        'PolarP1_Q_seg1P.txt', WaveForm_1PPointNum, 1, 1);
    pause(0.5);
    %% Load waveform to AWG
    chaseFunctionPool('CreateSegments', gmSEQ.MWAWG, 1, ...
        6, ...
        2047, 2047, 'Polar_SegStruct_I.txt', 'false');
    pause(1); % this pause seems to be important, otherwise the loading is not right occassionally
    chaseFunctionPool('CreateSegments', gmSEQ.MWAWG, 2, ...
        6 , ...
        2047, 2047, 'Polar_SegStruct_Q.txt', 'false');
    pause(1); % this pause seems to be important, otherwise the loading is not right occassionally
    chaseFunctionPool('CreateSegments', gmSEQ.P1AWG, 1, ...
        5, ...
        2047, 2047, 'Polar_P1_SegStruct_I.txt', 'false');
    pause(1); % this pause seems to be important, otherwise the loading is not right occassionally   
    chaseFunctionPool('CreateSegments', gmSEQ.P1AWG, 2, ...
        5, ...
        2047, 2047, 'Polar_P1_SegStruct_Q.txt', 'false');
    pause(1); % this pause seems to be important, otherwise the loading is not right occassionally 
end

%% Run waveform
chaseFunctionPool('runChase', gmSEQ.MWAWG, 'false'); pause(1);
chaseFunctionPool('runChase', gmSEQ.P1AWG, 'false'); pause(1);
ApplyDelays();

function PolarP1_SwpN % have not tested yet
global gmSEQ gSG gSG2
gSG.bfixedPow=1;
gSG.bfixedFreq=1;
gSG.bMod='IQ';
gSG.bModSrc='External';

gSG2.bMod='IQ';
gSG2.bModSrc='External';
SignalGeneratorFunctionPool2('SetMod');
SignalGeneratorFunctionPool2('WritePow');
SignalGeneratorFunctionPool2('WriteFreq');
gSG2.bOn=1; SignalGeneratorFunctionPool2('RFOnOff');

% Temp use. TODO: find an input window for this param
gSG.LockingAmp = gmSEQ.SAmp1;
gSG2.LockingAmp = gmSEQ.SAmp2;
gmSEQ.PolarCycle = round(gmSEQ.m);
gmSEQ.DEERhalfpi = gmSEQ.DEERpi/2;

NDepol = 2; % Depolarization pulse for P1
IntDepol = 0.1e6;
SpinLockGap = 10;
AfterPi = 1000;
AfterLaser = 2000; % 0.1e6?
AfterPolar = 1000;
Wait_p = NDepol*IntDepol + 0.2e6;
Detect_Window = 5000;
PolarTime = 50e3; % polarizing interaction time between NV and P1
PolarReadout = 5000; % polarizing initialization time
HalfPi = max(gmSEQ.halfpi, gmSEQ.DEERhalfpi);
CycleTime = PolarReadout+AfterLaser+HalfPi+SpinLockGap+PolarTime+SpinLockGap+HalfPi+AfterPolar;
Sig_D_start = Wait_p+CycleTime*gmSEQ.PolarCycle+gmSEQ.readout+AfterLaser+HalfPi+SpinLockGap+gmSEQ.DEERt+SpinLockGap+HalfPi+AfterPi+Detect_Window+Wait_p;

gmSEQ.CHN(1).PBN=PBDictionary('ctr0');
gmSEQ.CHN(1).NRise=4;
gmSEQ.CHN(1).T=[Wait_p+CycleTime*gmSEQ.PolarCycle+gmSEQ.readout-1000-gmSEQ.CtrGateDur, ...
    Wait_p+CycleTime*gmSEQ.PolarCycle+gmSEQ.readout+AfterLaser+HalfPi+SpinLockGap+gmSEQ.DEERt+SpinLockGap+HalfPi+AfterPi, ...
    Sig_D_start+CycleTime*gmSEQ.PolarCycle+gmSEQ.readout-1000-gmSEQ.CtrGateDur, ... 
    Sig_D_start+CycleTime*gmSEQ.PolarCycle+gmSEQ.readout+AfterLaser+HalfPi+SpinLockGap+gmSEQ.DEERt+SpinLockGap+HalfPi+AfterPi];
if strcmp(gmSEQ.meas,'SPCM')
    gmSEQ.CHN(1).DT=[gmSEQ.CtrGateDur gmSEQ.CtrGateDur gmSEQ.CtrGateDur gmSEQ.CtrGateDur];
elseif strcmp(gmSEQ.meas,'APD')
    gmSEQ.CHN(1).DT=[1000 1000 1000 1000];
end

gmSEQ.CHN(numel(gmSEQ.CHN)+1).PBN=PBDictionary('AOM');
gmSEQ.CHN(numel(gmSEQ.CHN)).NRise=2*(2 + gmSEQ.PolarCycle);
gmSEQ.CHN(numel(gmSEQ.CHN)).T = zeros(1, gmSEQ.CHN(numel(gmSEQ.CHN)).NRise);
for i = 1:gmSEQ.PolarCycle
    gmSEQ.CHN(numel(gmSEQ.CHN)).T(i)=Wait_p+(i-1)*CycleTime;
end
gmSEQ.CHN(numel(gmSEQ.CHN)).T(gmSEQ.PolarCycle+1)=Wait_p+CycleTime*gmSEQ.PolarCycle;
gmSEQ.CHN(numel(gmSEQ.CHN)).T(gmSEQ.PolarCycle+2)=Wait_p+CycleTime*gmSEQ.PolarCycle ...
    +gmSEQ.readout+AfterLaser+HalfPi+SpinLockGap+gmSEQ.DEERt+SpinLockGap+HalfPi+AfterPi;
for i = 1:gmSEQ.PolarCycle
    gmSEQ.CHN(numel(gmSEQ.CHN)).T(gmSEQ.PolarCycle+2+i)=Sig_D_start+(i-1)*CycleTime;
end
gmSEQ.CHN(numel(gmSEQ.CHN)).T(2*gmSEQ.PolarCycle+3)=Sig_D_start+CycleTime*gmSEQ.PolarCycle;
gmSEQ.CHN(numel(gmSEQ.CHN)).T(2*gmSEQ.PolarCycle+4)=Sig_D_start+CycleTime*gmSEQ.PolarCycle ...
	+gmSEQ.readout+AfterLaser+HalfPi+SpinLockGap+gmSEQ.DEERt+SpinLockGap+HalfPi+AfterPi;
gmSEQ.CHN(numel(gmSEQ.CHN)).DT = [repelem(PolarReadout, gmSEQ.PolarCycle) gmSEQ.readout Detect_Window ...
    repelem(PolarReadout, gmSEQ.PolarCycle) gmSEQ.readout Detect_Window];

gmSEQ.CHN(numel(gmSEQ.CHN)+1).PBN=PBDictionary('AWGTrig');
gmSEQ.CHN(numel(gmSEQ.CHN)).NRise=2*(1 + gmSEQ.PolarCycle);
gmSEQ.CHN(numel(gmSEQ.CHN)).T = zeros(1, gmSEQ.CHN(numel(gmSEQ.CHN)).NRise);
for i = 1:gmSEQ.PolarCycle
    gmSEQ.CHN(numel(gmSEQ.CHN)).T(i)=Wait_p+(i-1)*CycleTime+PolarReadout+AfterLaser;
    gmSEQ.CHN(numel(gmSEQ.CHN)).T(gmSEQ.PolarCycle+1+i)=Sig_D_start+(i-1)*CycleTime+PolarReadout+AfterLaser;
end
gmSEQ.CHN(numel(gmSEQ.CHN)).T(gmSEQ.PolarCycle+1)=Wait_p+CycleTime*gmSEQ.PolarCycle+gmSEQ.readout+AfterLaser;
gmSEQ.CHN(numel(gmSEQ.CHN)).T(2*gmSEQ.PolarCycle+2)=Sig_D_start+CycleTime*gmSEQ.PolarCycle+gmSEQ.readout+AfterLaser;
gmSEQ.CHN(numel(gmSEQ.CHN)).DT=[repelem(HalfPi+SpinLockGap+PolarTime+SpinLockGap+HalfPi+200,gmSEQ.PolarCycle), ...
    HalfPi+SpinLockGap+gmSEQ.DEERt+SpinLockGap+HalfPi+200, ... 
    repelem(HalfPi+SpinLockGap+PolarTime+SpinLockGap+HalfPi+200,gmSEQ.PolarCycle), ...
    HalfPi+SpinLockGap+gmSEQ.DEERt+SpinLockGap+HalfPi+200];

% P1 AWG Trig
gmSEQ.CHN(numel(gmSEQ.CHN)+1).PBN=PBDictionary('AWGTrig2');
gmSEQ.CHN(numel(gmSEQ.CHN)).NRise=2*(1 + gmSEQ.PolarCycle + NDepol);
gmSEQ.CHN(numel(gmSEQ.CHN)).T=zeros(1, gmSEQ.CHN(numel(gmSEQ.CHN)).NRise);
for i = 1:NDepol
    gmSEQ.CHN(numel(gmSEQ.CHN)).T(i)=i*IntDepol-gmSEQ.DEERpi/2;
    gmSEQ.CHN(numel(gmSEQ.CHN)).T(i+1+gmSEQ.PolarCycle+NDepol)=Sig_D_start-Wait_p+i*IntDepol-gmSEQ.DEERpi/2;
end
for i = 1:gmSEQ.PolarCycle
    gmSEQ.CHN(numel(gmSEQ.CHN)).T(NDepol + i)=Wait_p+(i-1)*CycleTime+PolarReadout+AfterLaser;
    gmSEQ.CHN(numel(gmSEQ.CHN)).T(2*NDepol+gmSEQ.PolarCycle+i+1)=Sig_D_start+(i-1)*CycleTime+PolarReadout+AfterLaser;
end
gmSEQ.CHN(numel(gmSEQ.CHN)).T(NDepol+gmSEQ.PolarCycle+1)=Wait_p+CycleTime*gmSEQ.PolarCycle+gmSEQ.readout+AfterLaser;
gmSEQ.CHN(numel(gmSEQ.CHN)).T(2*NDepol+2*gmSEQ.PolarCycle+2)=Sig_D_start+CycleTime*gmSEQ.PolarCycle+gmSEQ.readout+AfterLaser;
gmSEQ.CHN(numel(gmSEQ.CHN)).DT=[repelem(gmSEQ.DEERpi/2+200, NDepol), ... 
    repelem(HalfPi+SpinLockGap+PolarTime+SpinLockGap+HalfPi+200,gmSEQ.PolarCycle), ...
    HalfPi+SpinLockGap+gmSEQ.DEERt+SpinLockGap+HalfPi+200, ...
    repelem(gmSEQ.DEERpi/2+200, NDepol), ... 
    repelem(HalfPi+SpinLockGap+PolarTime+SpinLockGap+HalfPi+200,gmSEQ.PolarCycle), ...
    HalfPi+SpinLockGap+gmSEQ.DEERt+SpinLockGap+HalfPi+200];

gmSEQ.CHN(numel(gmSEQ.CHN)+1).PBN=PBDictionary('MWSwitch');
gmSEQ.CHN(numel(gmSEQ.CHN)).NRise=2*(1 + gmSEQ.PolarCycle);
gmSEQ.CHN(numel(gmSEQ.CHN)).T = zeros(1, gmSEQ.CHN(numel(gmSEQ.CHN)).NRise);
for i = 1:gmSEQ.PolarCycle
    gmSEQ.CHN(numel(gmSEQ.CHN)).T(i)=Wait_p+(i-1)*CycleTime+PolarReadout+AfterLaser-20;
    gmSEQ.CHN(numel(gmSEQ.CHN)).T(gmSEQ.PolarCycle+1+i)=Sig_D_start+(i-1)*CycleTime+PolarReadout+AfterLaser-20;
end
gmSEQ.CHN(numel(gmSEQ.CHN)).T(gmSEQ.PolarCycle+1)=Wait_p+CycleTime*gmSEQ.PolarCycle+gmSEQ.readout+AfterLaser-20;
gmSEQ.CHN(numel(gmSEQ.CHN)).T(2*gmSEQ.PolarCycle+2)=Sig_D_start+CycleTime*gmSEQ.PolarCycle+gmSEQ.readout+AfterLaser-20;
gmSEQ.CHN(numel(gmSEQ.CHN)).DT=[repelem(HalfPi+SpinLockGap+PolarTime+SpinLockGap+HalfPi+40, gmSEQ.PolarCycle), ...
    HalfPi+SpinLockGap+gmSEQ.DEERt+SpinLockGap+HalfPi+40, ...
    repelem(HalfPi+SpinLockGap+PolarTime+SpinLockGap+HalfPi+40, gmSEQ.PolarCycle), ...
    HalfPi+SpinLockGap+gmSEQ.DEERt+SpinLockGap+HalfPi+40];

gmSEQ.CHN(numel(gmSEQ.CHN)+1).PBN=PBDictionary('MWSwitch2');
gmSEQ.CHN(numel(gmSEQ.CHN)).NRise=2*(1 + gmSEQ.PolarCycle + NDepol);
gmSEQ.CHN(numel(gmSEQ.CHN)).T = zeros(1, gmSEQ.CHN(numel(gmSEQ.CHN)).NRise);
for i = 1:NDepol
    gmSEQ.CHN(numel(gmSEQ.CHN)).T(i)=i*IntDepol-gmSEQ.DEERpi/2-20;
    gmSEQ.CHN(numel(gmSEQ.CHN)).T(i+1+gmSEQ.PolarCycle+NDepol)=Sig_D_start-Wait_p+i*IntDepol-gmSEQ.DEERpi/2-20;
end
for i = 1:gmSEQ.PolarCycle
    gmSEQ.CHN(numel(gmSEQ.CHN)).T(NDepol + i)=Wait_p+(i-1)*CycleTime+PolarReadout+AfterLaser-20;
    gmSEQ.CHN(numel(gmSEQ.CHN)).T(2*NDepol+gmSEQ.PolarCycle+i+1)=Sig_D_start+(i-1)*CycleTime+PolarReadout+AfterLaser-20;
end
gmSEQ.CHN(numel(gmSEQ.CHN)).T(NDepol+gmSEQ.PolarCycle+1)=Wait_p+CycleTime*gmSEQ.PolarCycle+gmSEQ.readout+AfterLaser-20;
gmSEQ.CHN(numel(gmSEQ.CHN)).T(2*NDepol+2*gmSEQ.PolarCycle+2)=Sig_D_start+CycleTime*gmSEQ.PolarCycle+gmSEQ.readout+AfterLaser-20;
gmSEQ.CHN(numel(gmSEQ.CHN)).DT=[repelem(gmSEQ.DEERpi/2+20, NDepol), ... 
    repelem(HalfPi+SpinLockGap+PolarTime+SpinLockGap+HalfPi+40,gmSEQ.PolarCycle), ...
    HalfPi+SpinLockGap+gmSEQ.DEERt+SpinLockGap+HalfPi+40, ...
    repelem(gmSEQ.DEERpi/2+20, NDepol), ... 
    repelem(HalfPi+SpinLockGap+PolarTime+SpinLockGap+HalfPi+40,gmSEQ.PolarCycle), ...
    HalfPi+SpinLockGap+gmSEQ.DEERt+SpinLockGap+HalfPi+40];

gmSEQ.CHN(numel(gmSEQ.CHN)+1).PBN=PBDictionary('dummy1');
gmSEQ.CHN(numel(gmSEQ.CHN)).NRise=2;
gmSEQ.CHN(numel(gmSEQ.CHN)).T=[0 Sig_D_start+CycleTime*gmSEQ.PolarCycle+gmSEQ.readout+AfterLaser+ ...
    HalfPi+SpinLockGap+gmSEQ.DEERt+SpinLockGap+HalfPi+AfterPi+Detect_Window-50];
gmSEQ.CHN(numel(gmSEQ.CHN)).DT=[50 50];

%% AWG
% Initialization
chaseFunctionPool('stopChase', gmSEQ.MWAWG); pause(1);
chaseFunctionPool('stopChase', gmSEQ.P1AWG);

% This part need to be modified to accomodate the DC modulation
if ~gSG.ACmodAWG % in AC modulation mode
    gSG.AWGFreq = 0;
    gSG2.AWGFreq = 0;
end

WaveForm_1I = [0 gmSEQ.halfpi gSG.AWGFreq 0 gSG.AWGAmp; ...
    HalfPi+SpinLockGap HalfPi+SpinLockGap+gmSEQ.DEERt gSG.AWGFreq pi/2 gSG.LockingAmp; ...
    HalfPi+SpinLockGap+gmSEQ.DEERt+SpinLockGap+HalfPi-gmSEQ.halfpi HalfPi+SpinLockGap+gmSEQ.DEERt+SpinLockGap+HalfPi gSG.AWGFreq pi gSG.AWGAmp];
WaveForm_1Q = WaveForm_1I - repmat([0 0 0 pi/2 0], size(WaveForm_1I, 1), 1);
WaveForm_1Length = ceil((HalfPi+SpinLockGap+gmSEQ.DEERt+SpinLockGap+HalfPi + 1000) / (16/gSG.AWGClockRate)) * (16/gSG.AWGClockRate);
WaveForm_1PointNum = WaveForm_1Length * gSG.AWGClockRate;

WaveForm_2I = WaveForm_1I;
WaveForm_2I(size(WaveForm_1I, 1), 4) = 0; % Differential measurement
WaveForm_2Q = WaveForm_1Q;
WaveForm_2Q(size(WaveForm_1I, 1), 4) = -pi/2; % Differential measurement
WaveForm_2Length = WaveForm_1Length;
WaveForm_2PointNum = WaveForm_2Length * gSG.AWGClockRate;

WaveForm_3I = [0 gmSEQ.halfpi gSG.AWGFreq 0 gSG.AWGAmp; ...
    HalfPi+SpinLockGap HalfPi+SpinLockGap+PolarTime gSG.AWGFreq pi/2 gSG.LockingAmp; ...
    HalfPi+SpinLockGap+PolarTime+SpinLockGap+HalfPi-gmSEQ.halfpi HalfPi+SpinLockGap+PolarTime+SpinLockGap+HalfPi gSG.AWGFreq pi gSG.AWGAmp];
WaveForm_3Q = WaveForm_3I - repmat([0 0 0 pi/2 0], size(WaveForm_3I, 1), 1);
WaveForm_3Length =  ceil((HalfPi+SpinLockGap+PolarTime+SpinLockGap+HalfPi + 1000) / (16/gSG.AWGClockRate)) * (16/gSG.AWGClockRate);
WaveForm_3PointNum = WaveForm_3Length * gSG.AWGClockRate;

% P1 sequence
WaveForm_1PI = [0 gmSEQ.DEERhalfpi gSG2.AWGFreq 0 gSG2.AWGAmp; ...
    HalfPi+SpinLockGap HalfPi+SpinLockGap+gmSEQ.DEERt gSG2.AWGFreq pi/2 gSG2.LockingAmp; ...
    HalfPi+SpinLockGap+gmSEQ.DEERt+SpinLockGap+HalfPi-gmSEQ.DEERhalfpi HalfPi+SpinLockGap+gmSEQ.DEERt+SpinLockGap+HalfPi gSG2.AWGFreq pi gSG2.AWGAmp];
WaveForm_1PQ = WaveForm_1PI - repmat([0 0 0 pi/2 0], size(WaveForm_1PI, 1), 1);
WaveForm_1PLength = ceil((HalfPi+SpinLockGap+gmSEQ.DEERt+SpinLockGap+HalfPi + 1000) / (16/gSG2.P1AWGClockRate)) * (16/gSG2.P1AWGClockRate);
WaveForm_1PPointNum = WaveForm_1PLength * gSG2.P1AWGClockRate;

WaveForm_2PI = [0 gmSEQ.DEERhalfpi gSG2.AWGFreq 0 gSG2.AWGAmp; ...
    HalfPi+SpinLockGap HalfPi+SpinLockGap+PolarTime gSG2.AWGFreq pi/2 gSG2.LockingAmp; ...
    HalfPi+SpinLockGap+PolarTime+SpinLockGap+HalfPi-gmSEQ.DEERhalfpi HalfPi+SpinLockGap+PolarTime+SpinLockGap+HalfPi gSG2.AWGFreq pi gSG2.AWGAmp];
WaveForm_2PQ = WaveForm_2PI - repmat([0 0 0 pi/2 0], size(WaveForm_2PI, 1), 1);
WaveForm_2PLength =  ceil((HalfPi+SpinLockGap+PolarTime+SpinLockGap+HalfPi + 1000) / (16/gSG2.P1AWGClockRate)) * (16/gSG2.P1AWGClockRate);
WaveForm_2PPointNum = WaveForm_2PLength * gSG2.P1AWGClockRate;

WaveForm_3PI = [0 gmSEQ.DEERhalfpi gSG2.AWGFreq 0 gSG2.AWGAmp];
WaveForm_3PQ = WaveForm_3PI - repmat([0 0 0 pi/2 0], size(WaveForm_3PI, 1), 1);
WaveForm_3PLength =  ceil((gmSEQ.DEERhalfpi + 1000) / (16/gSG2.P1AWGClockRate)) * (16/gSG2.P1AWGClockRate);
WaveForm_3PPointNum = WaveForm_3PLength * gSG2.P1AWGClockRate;

chaseFunctionPool('createWaveform', WaveForm_1I, gSG.AWGClockRate, WaveForm_1Length, 'PolarP1_I_seg1.txt'); pause(0.5);
chaseFunctionPool('createWaveform', WaveForm_1Q, gSG.AWGClockRate, WaveForm_1Length, 'PolarP1_Q_seg1.txt'); pause(0.5);
chaseFunctionPool('createWaveform', WaveForm_2I, gSG.AWGClockRate, WaveForm_2Length, 'PolarP1_I_seg2.txt'); pause(0.5);
chaseFunctionPool('createWaveform', WaveForm_2Q, gSG.AWGClockRate, WaveForm_2Length, 'PolarP1_Q_seg2.txt'); pause(0.5);
chaseFunctionPool('createWaveform', WaveForm_3I, gSG.AWGClockRate, WaveForm_3Length, 'PolarP1_I_seg3.txt'); pause(0.5);
chaseFunctionPool('createWaveform', WaveForm_3Q, gSG.AWGClockRate, WaveForm_3Length, 'PolarP1_Q_seg3.txt'); pause(0.5);

chaseFunctionPool('createWaveform', WaveForm_1PI, gSG2.P1AWGClockRate, WaveForm_1PLength, 'PolarP1_I_seg1P.txt'); pause(0.5);
chaseFunctionPool('createWaveform', WaveForm_1PQ, gSG2.P1AWGClockRate, WaveForm_1PLength, 'PolarP1_Q_seg1P.txt'); pause(0.5);
chaseFunctionPool('createWaveform', WaveForm_2PI, gSG2.P1AWGClockRate, WaveForm_2PLength, 'PolarP1_I_seg2P.txt'); pause(0.5);
chaseFunctionPool('createWaveform', WaveForm_2PQ, gSG2.P1AWGClockRate, WaveForm_2PLength, 'PolarP1_Q_seg2P.txt'); pause(0.5);
chaseFunctionPool('createWaveform', WaveForm_3PI, gSG2.P1AWGClockRate, WaveForm_3PLength, 'PolarP1_I_seg3P.txt'); pause(0.5);
chaseFunctionPool('createWaveform', WaveForm_3PQ, gSG2.P1AWGClockRate, WaveForm_3PLength, 'PolarP1_Q_seg3P.txt'); pause(0.5);

if NDepol < 2
   warning("The AWG createSegStruct is not compatible with NDepol less than 2."); 
end

if gmSEQ.PolarCycle == 0
    chaseFunctionPool('createSegStruct', 'Polar_SegStruct_I.txt', ...
        'PolarP1_I_seg1.txt', WaveForm_1PointNum, 1, 1, ... 
        'PolarP1_I_seg2.txt', WaveForm_2PointNum, 1, 1);
    pause(0.5);
    chaseFunctionPool('createSegStruct', 'Polar_SegStruct_Q.txt', ...
        'PolarP1_Q_seg1.txt', WaveForm_1PointNum, 1, 1, ...
        'PolarP1_Q_seg2.txt', WaveForm_2PointNum, 1, 1);
    pause(0.5);
    chaseFunctionPool('createSegStruct', 'Polar_P1_SegStruct_I.txt', ...
        'PolarP1_I_seg3P.txt', WaveForm_3PPointNum, 1, 1, ...
        'PolarP1_I_seg3P.txt', WaveForm_3PPointNum, NDepol-1, 1, ...
        'PolarP1_I_seg1P.txt', WaveForm_1PPointNum, 1, 1);
    pause(0.5);
    chaseFunctionPool('createSegStruct', 'Polar_P1_SegStruct_Q.txt', ...
        'PolarP1_Q_seg3P.txt', WaveForm_3PPointNum, 1, 1, ...
        'PolarP1_Q_seg3P.txt', WaveForm_3PPointNum, NDepol-1, 1, ...
        'PolarP1_Q_seg1P.txt', WaveForm_1PPointNum, 1, 1);
    pause(0.5);
    %% Load waveform to AWG
    chaseFunctionPool('CreateSegments', gmSEQ.MWAWG, 1, ...
        2, ...
        2047, 2047, 'Polar_SegStruct_I.txt', 'false');
    pause(1); % this pause seems to be important, otherwise the loading is not right occassionally
    chaseFunctionPool('CreateSegments', gmSEQ.MWAWG, 2, ...
        2, ...
        2047, 2047, 'Polar_SegStruct_Q.txt', 'false');
    pause(1); % this pause seems to be important, otherwise the loading is not right occassionally
    chaseFunctionPool('CreateSegments', gmSEQ.P1AWG, 1, ...
        3, ...
        2047, 2047, 'Polar_P1_SegStruct_I.txt', 'false');
    pause(1); % this pause seems to be important, otherwise the loading is not right occassionally   
    chaseFunctionPool('CreateSegments', gmSEQ.P1AWG, 2, ...
        3, ...
        2047, 2047, 'Polar_P1_SegStruct_Q.txt', 'false');
    pause(1); % this pause seems to be important, otherwise the loading is not right occassionally 
elseif gmSEQ.PolarCycle == 1
    chaseFunctionPool('createSegStruct', 'Polar_SegStruct_I.txt', ...
        'PolarP1_I_seg3.txt', WaveForm_3PointNum, 1, 1, ...
        'PolarP1_I_seg1.txt', WaveForm_1PointNum, 1, 1, ... 
        'PolarP1_I_seg3.txt', WaveForm_3PointNum, 1, 1, ...
        'PolarP1_I_seg2.txt', WaveForm_2PointNum, 1, 1);
    pause(0.5);
    chaseFunctionPool('createSegStruct', 'Polar_SegStruct_Q.txt', ...
        'PolarP1_Q_seg3.txt', WaveForm_3PointNum, 1, 1, ...
        'PolarP1_Q_seg1.txt', WaveForm_1PointNum, 1, 1, ...
        'PolarP1_Q_seg3.txt', WaveForm_3PointNum, 1, 1, ...
        'PolarP1_Q_seg2.txt', WaveForm_2PointNum, 1, 1);
    pause(0.5);
    chaseFunctionPool('createSegStruct', 'Polar_P1_SegStruct_I.txt', ...
        'PolarP1_I_seg3P.txt', WaveForm_3PPointNum, 1, 1, ...
        'PolarP1_I_seg3P.txt', WaveForm_3PPointNum, NDepol-1, 1, ...
        'PolarP1_I_seg2P.txt', WaveForm_2PPointNum, 1, 1, ...
        'PolarP1_I_seg1P.txt', WaveForm_1PPointNum, 1, 1);
    pause(0.5);
    chaseFunctionPool('createSegStruct', 'Polar_P1_SegStruct_Q.txt', ...
        'PolarP1_Q_seg3P.txt', WaveForm_3PPointNum, 1, 1, ...
        'PolarP1_Q_seg3P.txt', WaveForm_3PPointNum, NDepol-1, 1, ...
        'PolarP1_Q_seg2P.txt', WaveForm_2PPointNum, 1, 1, ...
        'PolarP1_Q_seg1P.txt', WaveForm_1PPointNum, 1, 1);
    pause(0.5);
    %% Load waveform to AWG
    chaseFunctionPool('CreateSegments', gmSEQ.MWAWG, 1, ...
        4, ...
        2047, 2047, 'Polar_SegStruct_I.txt', 'false');
    pause(1); % this pause seems to be important, otherwise the loading is not right occassionally
    chaseFunctionPool('CreateSegments', gmSEQ.MWAWG, 2, ...
        4, ...
        2047, 2047, 'Polar_SegStruct_Q.txt', 'false');
    pause(1); % this pause seems to be important, otherwise the loading is not right occassionally
    chaseFunctionPool('CreateSegments', gmSEQ.P1AWG, 1, ...
        4, ...
        2047, 2047, 'Polar_P1_SegStruct_I.txt', 'false');
    pause(1); % this pause seems to be important, otherwise the loading is not right occassionally   
    chaseFunctionPool('CreateSegments', gmSEQ.P1AWG, 2, ...
        4, ...
        2047, 2047, 'Polar_P1_SegStruct_Q.txt', 'false');
    pause(1); % this pause seems to be important, otherwise the loading is not right occassionally 
else 
    chaseFunctionPool('createSegStruct', 'Polar_SegStruct_I.txt', ...
        'PolarP1_I_seg3.txt', WaveForm_3PointNum, 1, 1, ...
        'PolarP1_I_seg3.txt', WaveForm_3PointNum, gmSEQ.PolarCycle - 1, 1, ...
        'PolarP1_I_seg1.txt', WaveForm_1PointNum, 1, 1, ... 
        'PolarP1_I_seg3.txt', WaveForm_3PointNum, 1, 1, ...
        'PolarP1_I_seg3.txt', WaveForm_3PointNum, gmSEQ.PolarCycle - 1, 1, ...
        'PolarP1_I_seg2.txt', WaveForm_2PointNum, 1, 1);
    pause(0.5);
    chaseFunctionPool('createSegStruct', 'Polar_SegStruct_Q.txt', ...
        'PolarP1_Q_seg3.txt', WaveForm_3PointNum, 1, 1, ...
        'PolarP1_Q_seg3.txt', WaveForm_3PointNum, gmSEQ.PolarCycle - 1, 1, ...
        'PolarP1_Q_seg1.txt', WaveForm_1PointNum, 1, 1, ...
        'PolarP1_Q_seg3.txt', WaveForm_3PointNum, 1, 1, ...
        'PolarP1_Q_seg3.txt', WaveForm_3PointNum, gmSEQ.PolarCycle - 1, 1, ...
        'PolarP1_Q_seg2.txt', WaveForm_2PointNum, 1, 1);
    pause(0.5);
    chaseFunctionPool('createSegStruct', 'Polar_P1_SegStruct_I.txt', ...
        'PolarP1_I_seg3P.txt', WaveForm_3PPointNum, 1, 1, ...
        'PolarP1_I_seg3P.txt', WaveForm_3PPointNum, NDepol-1, 1, ...
        'PolarP1_I_seg2P.txt', WaveForm_2PPointNum, 1, 1, ...
        'PolarP1_I_seg2P.txt', WaveForm_2PPointNum, gmSEQ.PolarCycle-1, 1, ...
        'PolarP1_I_seg1P.txt', WaveForm_1PPointNum, 1, 1);
    pause(0.5);
    chaseFunctionPool('createSegStruct', 'Polar_P1_SegStruct_Q.txt', ...
        'PolarP1_Q_seg3P.txt', WaveForm_3PPointNum, 1, 1, ...
        'PolarP1_Q_seg3P.txt', WaveForm_3PPointNum, NDepol-1, 1, ...
        'PolarP1_Q_seg2P.txt', WaveForm_2PPointNum, 1, 1, ...
        'PolarP1_Q_seg2P.txt', WaveForm_2PPointNum, gmSEQ.PolarCycle-1, 1, ...
        'PolarP1_Q_seg1P.txt', WaveForm_1PPointNum, 1, 1);
    pause(0.5);
    %% Load waveform to AWG
    chaseFunctionPool('CreateSegments', gmSEQ.MWAWG, 1, ...
        6, ...
        2047, 2047, 'Polar_SegStruct_I.txt', 'false');
    pause(1); % this pause seems to be important, otherwise the loading is not right occassionally
    chaseFunctionPool('CreateSegments', gmSEQ.MWAWG, 2, ...
        6 , ...
        2047, 2047, 'Polar_SegStruct_Q.txt', 'false');
    pause(1); % this pause seems to be important, otherwise the loading is not right occassionally
    chaseFunctionPool('CreateSegments', gmSEQ.P1AWG, 1, ...
        5, ...
        2047, 2047, 'Polar_P1_SegStruct_I.txt', 'false');
    pause(1); % this pause seems to be important, otherwise the loading is not right occassionally   
    chaseFunctionPool('CreateSegments', gmSEQ.P1AWG, 2, ...
        5, ...
        2047, 2047, 'Polar_P1_SegStruct_Q.txt', 'false');
    pause(1); % this pause seems to be important, otherwise the loading is not right occassionally 
end

%% Run waveform
chaseFunctionPool('runChase', gmSEQ.MWAWG, 'false'); pause(1);
chaseFunctionPool('runChase', gmSEQ.P1AWG, 'false'); pause(1);
ApplyDelays();

function PolarP1_T1 
global gmSEQ gSG gSG2
gSG.bfixedPow=1;
gSG.bfixedFreq=1;
gSG.bMod='IQ';
gSG.bModSrc='External';

gSG2.bMod='IQ';
gSG2.bModSrc='External';
SignalGeneratorFunctionPool2('SetMod');
SignalGeneratorFunctionPool2('WritePow');
SignalGeneratorFunctionPool2('WriteFreq');
gSG2.bOn=1; SignalGeneratorFunctionPool2('RFOnOff');

gmSEQ.Ntomo = 2;

% Temp use. TODO: find an input window for this param
gSG.LockingAmp = gmSEQ.SAmp1;
gSG2.LockingAmp = gmSEQ.SAmp2;
gmSEQ.PolarCycle = gmSEQ.CoolCycle;
gmSEQ.DEERhalfpi = gmSEQ.DEERpi/2;
DetectTime = gmSEQ.m;

NDepol = 3; % Depolarization pulse for P1
IntDepol = 60e3;
SpinLockGap = 4;
AfterPi = 1000;
AfterLaser = 2000; % 0.1e6?
AfterPolar = 1000;
Wait_p = NDepol*IntDepol + 0.1e6;
Detect_Window = 5000;
PolarTime = 50e3; % polarizing interaction time between NV and P1
PolarReadout = 5000; % polarizing initialization time
HalfPi = max(gmSEQ.halfpi, gmSEQ.DEERhalfpi);
CycleTime = PolarReadout+AfterLaser+HalfPi+SpinLockGap+PolarTime+SpinLockGap+HalfPi+AfterPolar;
Sig_D_start = Wait_p+CycleTime*gmSEQ.PolarCycle+gmSEQ.readout+AfterLaser+HalfPi+SpinLockGap+DetectTime+SpinLockGap+HalfPi+AfterPi+Detect_Window+Wait_p;

gmSEQ.CHN(1).PBN=PBDictionary('ctr0');
gmSEQ.CHN(1).NRise=4;
gmSEQ.CHN(1).T=[Wait_p+CycleTime*gmSEQ.PolarCycle+gmSEQ.readout-1000-gmSEQ.CtrGateDur, ...
    Wait_p+CycleTime*gmSEQ.PolarCycle+gmSEQ.readout+AfterLaser+HalfPi+SpinLockGap+DetectTime+SpinLockGap+HalfPi+AfterPi, ...
    Sig_D_start+CycleTime*gmSEQ.PolarCycle+gmSEQ.readout-1000-gmSEQ.CtrGateDur, ... 
    Sig_D_start+CycleTime*gmSEQ.PolarCycle+gmSEQ.readout+AfterLaser+HalfPi+SpinLockGap+DetectTime+SpinLockGap+HalfPi+AfterPi];
if strcmp(gmSEQ.meas,'SPCM')
    gmSEQ.CHN(1).DT=[gmSEQ.CtrGateDur gmSEQ.CtrGateDur gmSEQ.CtrGateDur gmSEQ.CtrGateDur];
elseif strcmp(gmSEQ.meas,'APD')
    gmSEQ.CHN(1).DT=[1000 1000 1000 1000];
end

gmSEQ.CHN(numel(gmSEQ.CHN)+1).PBN=PBDictionary('AOM');
gmSEQ.CHN(numel(gmSEQ.CHN)).NRise=2*(2 + gmSEQ.PolarCycle);
gmSEQ.CHN(numel(gmSEQ.CHN)).T = zeros(1, gmSEQ.CHN(numel(gmSEQ.CHN)).NRise);
for i = 1:gmSEQ.PolarCycle
    gmSEQ.CHN(numel(gmSEQ.CHN)).T(i)=Wait_p+(i-1)*CycleTime;
end
gmSEQ.CHN(numel(gmSEQ.CHN)).T(gmSEQ.PolarCycle+1)=Wait_p+CycleTime*gmSEQ.PolarCycle;
gmSEQ.CHN(numel(gmSEQ.CHN)).T(gmSEQ.PolarCycle+2)=Wait_p+CycleTime*gmSEQ.PolarCycle ...
    +gmSEQ.readout+AfterLaser+HalfPi+SpinLockGap+DetectTime+SpinLockGap+HalfPi+AfterPi;
for i = 1:gmSEQ.PolarCycle
    gmSEQ.CHN(numel(gmSEQ.CHN)).T(gmSEQ.PolarCycle+2+i)=Sig_D_start+(i-1)*CycleTime;
end
gmSEQ.CHN(numel(gmSEQ.CHN)).T(2*gmSEQ.PolarCycle+3)=Sig_D_start+CycleTime*gmSEQ.PolarCycle;
gmSEQ.CHN(numel(gmSEQ.CHN)).T(2*gmSEQ.PolarCycle+4)=Sig_D_start+CycleTime*gmSEQ.PolarCycle ...
	+gmSEQ.readout+AfterLaser+HalfPi+SpinLockGap+DetectTime+SpinLockGap+HalfPi+AfterPi;
gmSEQ.CHN(numel(gmSEQ.CHN)).DT = [repelem(PolarReadout, gmSEQ.PolarCycle) gmSEQ.readout Detect_Window ...
    repelem(PolarReadout, gmSEQ.PolarCycle) gmSEQ.readout Detect_Window];

gmSEQ.CHN(numel(gmSEQ.CHN)+1).PBN=PBDictionary('AWGTrig');
gmSEQ.CHN(numel(gmSEQ.CHN)).NRise=2*(1 + gmSEQ.PolarCycle);
gmSEQ.CHN(numel(gmSEQ.CHN)).T = zeros(1, gmSEQ.CHN(numel(gmSEQ.CHN)).NRise);
for i = 1:gmSEQ.PolarCycle
    gmSEQ.CHN(numel(gmSEQ.CHN)).T(i)=Wait_p+(i-1)*CycleTime+PolarReadout+AfterLaser;
    gmSEQ.CHN(numel(gmSEQ.CHN)).T(gmSEQ.PolarCycle+1+i)=Sig_D_start+(i-1)*CycleTime+PolarReadout+AfterLaser;
end
gmSEQ.CHN(numel(gmSEQ.CHN)).T(gmSEQ.PolarCycle+1)=Wait_p+CycleTime*gmSEQ.PolarCycle+gmSEQ.readout+AfterLaser;
gmSEQ.CHN(numel(gmSEQ.CHN)).T(2*gmSEQ.PolarCycle+2)=Sig_D_start+CycleTime*gmSEQ.PolarCycle+gmSEQ.readout+AfterLaser;
gmSEQ.CHN(numel(gmSEQ.CHN)).DT=[repelem(HalfPi+SpinLockGap+PolarTime+SpinLockGap+HalfPi+200,gmSEQ.PolarCycle), ...
    HalfPi+SpinLockGap+DetectTime+SpinLockGap+HalfPi+200, ... 
    repelem(HalfPi+SpinLockGap+PolarTime+SpinLockGap+HalfPi+200,gmSEQ.PolarCycle), ...
    HalfPi+SpinLockGap+DetectTime+SpinLockGap+HalfPi+200];

% P1 AWG Trig
gmSEQ.CHN(numel(gmSEQ.CHN)+1).PBN=PBDictionary('AWGTrig2');
gmSEQ.CHN(numel(gmSEQ.CHN)).NRise=2*(1 + gmSEQ.PolarCycle + NDepol);
gmSEQ.CHN(numel(gmSEQ.CHN)).T=zeros(1, gmSEQ.CHN(numel(gmSEQ.CHN)).NRise);
for i = 1:NDepol
    gmSEQ.CHN(numel(gmSEQ.CHN)).T(i)=i*IntDepol-gmSEQ.DEERpi/2;
    gmSEQ.CHN(numel(gmSEQ.CHN)).T(i+1+gmSEQ.PolarCycle+NDepol)=Sig_D_start-Wait_p+i*IntDepol-gmSEQ.DEERpi/2;
end
for i = 1:gmSEQ.PolarCycle
    gmSEQ.CHN(numel(gmSEQ.CHN)).T(NDepol + i)=Wait_p+(i-1)*CycleTime+PolarReadout+AfterLaser;
    gmSEQ.CHN(numel(gmSEQ.CHN)).T(2*NDepol+gmSEQ.PolarCycle+i+1)=Sig_D_start+(i-1)*CycleTime+PolarReadout+AfterLaser;
end
gmSEQ.CHN(numel(gmSEQ.CHN)).T(NDepol+gmSEQ.PolarCycle+1)=Wait_p+CycleTime*gmSEQ.PolarCycle+gmSEQ.readout+AfterLaser;
gmSEQ.CHN(numel(gmSEQ.CHN)).T(2*NDepol+2*gmSEQ.PolarCycle+2)=Sig_D_start+CycleTime*gmSEQ.PolarCycle+gmSEQ.readout+AfterLaser;
gmSEQ.CHN(numel(gmSEQ.CHN)).DT=[repelem(gmSEQ.DEERpi/2+200, NDepol), ... 
    repelem(HalfPi+SpinLockGap+PolarTime+SpinLockGap+HalfPi+200,gmSEQ.PolarCycle), ...
    HalfPi+SpinLockGap+DetectTime+SpinLockGap+HalfPi+200, ...
    repelem(gmSEQ.DEERpi/2+200, NDepol), ... 
    repelem(HalfPi+SpinLockGap+PolarTime+SpinLockGap+HalfPi+200,gmSEQ.PolarCycle), ...
    HalfPi+SpinLockGap+DetectTime+SpinLockGap+HalfPi+200];

gmSEQ.CHN(numel(gmSEQ.CHN)+1).PBN=PBDictionary('MWSwitch');
gmSEQ.CHN(numel(gmSEQ.CHN)).NRise=2*(1 + gmSEQ.PolarCycle);
gmSEQ.CHN(numel(gmSEQ.CHN)).T = zeros(1, gmSEQ.CHN(numel(gmSEQ.CHN)).NRise);
for i = 1:gmSEQ.PolarCycle
    gmSEQ.CHN(numel(gmSEQ.CHN)).T(i)=Wait_p+(i-1)*CycleTime+PolarReadout+AfterLaser-20;
    gmSEQ.CHN(numel(gmSEQ.CHN)).T(gmSEQ.PolarCycle+1+i)=Sig_D_start+(i-1)*CycleTime+PolarReadout+AfterLaser-20;
end
gmSEQ.CHN(numel(gmSEQ.CHN)).T(gmSEQ.PolarCycle+1)=Wait_p+CycleTime*gmSEQ.PolarCycle+gmSEQ.readout+AfterLaser-20;
gmSEQ.CHN(numel(gmSEQ.CHN)).T(2*gmSEQ.PolarCycle+2)=Sig_D_start+CycleTime*gmSEQ.PolarCycle+gmSEQ.readout+AfterLaser-20;
gmSEQ.CHN(numel(gmSEQ.CHN)).DT=[repelem(HalfPi+SpinLockGap+PolarTime+SpinLockGap+HalfPi+40, gmSEQ.PolarCycle), ...
    HalfPi+SpinLockGap+DetectTime+SpinLockGap+HalfPi+40, ...
    repelem(HalfPi+SpinLockGap+PolarTime+SpinLockGap+HalfPi+40, gmSEQ.PolarCycle), ...
    HalfPi+SpinLockGap+DetectTime+SpinLockGap+HalfPi+40];

gmSEQ.CHN(numel(gmSEQ.CHN)+1).PBN=PBDictionary('MWSwitch2');
gmSEQ.CHN(numel(gmSEQ.CHN)).NRise=2*(1 + gmSEQ.PolarCycle + NDepol);
gmSEQ.CHN(numel(gmSEQ.CHN)).T = zeros(1, gmSEQ.CHN(numel(gmSEQ.CHN)).NRise);
for i = 1:NDepol
    gmSEQ.CHN(numel(gmSEQ.CHN)).T(i)=i*IntDepol-gmSEQ.DEERpi/2-20;
    gmSEQ.CHN(numel(gmSEQ.CHN)).T(i+1+gmSEQ.PolarCycle+NDepol)=Sig_D_start-Wait_p+i*IntDepol-gmSEQ.DEERpi/2-20;
end
for i = 1:gmSEQ.PolarCycle
    gmSEQ.CHN(numel(gmSEQ.CHN)).T(NDepol + i)=Wait_p+(i-1)*CycleTime+PolarReadout+AfterLaser-20;
    gmSEQ.CHN(numel(gmSEQ.CHN)).T(2*NDepol+gmSEQ.PolarCycle+i+1)=Sig_D_start+(i-1)*CycleTime+PolarReadout+AfterLaser-20;
end
gmSEQ.CHN(numel(gmSEQ.CHN)).T(NDepol+gmSEQ.PolarCycle+1)=Wait_p+CycleTime*gmSEQ.PolarCycle+gmSEQ.readout+AfterLaser-20;
gmSEQ.CHN(numel(gmSEQ.CHN)).T(2*NDepol+2*gmSEQ.PolarCycle+2)=Sig_D_start+CycleTime*gmSEQ.PolarCycle+gmSEQ.readout+AfterLaser-20;
gmSEQ.CHN(numel(gmSEQ.CHN)).DT=[repelem(gmSEQ.DEERpi/2+20, NDepol), ... 
    repelem(HalfPi+SpinLockGap+PolarTime+SpinLockGap+HalfPi+40,gmSEQ.PolarCycle), ...
    HalfPi+SpinLockGap+DetectTime+SpinLockGap+HalfPi+40, ...
    repelem(gmSEQ.DEERpi/2+20, NDepol), ... 
    repelem(HalfPi+SpinLockGap+PolarTime+SpinLockGap+HalfPi+40,gmSEQ.PolarCycle), ...
    HalfPi+SpinLockGap+DetectTime+SpinLockGap+HalfPi+40];

gmSEQ.CHN(numel(gmSEQ.CHN)+1).PBN=PBDictionary('dummy1');
gmSEQ.CHN(numel(gmSEQ.CHN)).NRise=2;
gmSEQ.CHN(numel(gmSEQ.CHN)).T=[0 Sig_D_start+CycleTime*gmSEQ.PolarCycle+gmSEQ.readout+AfterLaser+ ...
    HalfPi+SpinLockGap+DetectTime+SpinLockGap+HalfPi+AfterPi+Detect_Window-50];
gmSEQ.CHN(numel(gmSEQ.CHN)).DT=[50 50];

%% AWG
% Initialization
chaseFunctionPool('stopChase', gmSEQ.MWAWG); pause(1);
chaseFunctionPool('stopChase', gmSEQ.P1AWG);

% This part need to be modified to accomodate the DC modulation
if ~gSG.ACmodAWG % in AC modulation mode
    gSG.AWGFreq = 0;
    gSG2.AWGFreq = 0;
end

% disp(DetectTime)
% if DetectTime == 0
%     disp("t=0 reference...")
%     WaveForm_1I = [0 HalfPi+SpinLockGap+DetectTime+SpinLockGap+HalfPi gSG.AWGFreq 0 0]; % No pulse at all
%     WaveForm_1Q = WaveForm_1I - repmat([0 0 0 pi/2 0], size(WaveForm_1I, 1), 1);
%     WaveForm_1Length = ceil((HalfPi+SpinLockGap+DetectTime+SpinLockGap+HalfPi + 1000) / (16/gSG.AWGClockRate)) * (16/gSG.AWGClockRate);
%     WaveForm_1PointNum = WaveForm_1Length * gSG.AWGClockRate;
%     
%     WaveForm_2I = [0 HalfPi+SpinLockGap+DetectTime+SpinLockGap+HalfPi-gmSEQ.pi gSG.AWGFreq 0 0; ...
%         HalfPi+SpinLockGap+DetectTime+SpinLockGap+HalfPi-gmSEQ.pi HalfPi+SpinLockGap+DetectTime+SpinLockGap+HalfPi gSG.AWGFreq 0 gSG.AWGAmp]; 
%     WaveForm_2Q = WaveForm_2I - repmat([0 0 0 pi/2 0], size(WaveForm_2I, 1), 1);
%     WaveForm_2Length = ceil((HalfPi+SpinLockGap+DetectTime+SpinLockGap+HalfPi + 1000) / (16/gSG.AWGClockRate)) * (16/gSG.AWGClockRate);
%     WaveForm_2PointNum = WaveForm_2Length * gSG.AWGClockRate;
% else
WaveForm_1I = [0 HalfPi-gmSEQ.halfpi gSG.AWGFreq 0 0; ...
    HalfPi-gmSEQ.halfpi HalfPi gSG.AWGFreq 0 gSG.AWGAmp; ...
    HalfPi+SpinLockGap HalfPi+SpinLockGap+DetectTime gSG.AWGFreq pi/2 gSG.LockingAmp; ...
    HalfPi+SpinLockGap+DetectTime+SpinLockGap HalfPi+SpinLockGap+DetectTime+SpinLockGap+gmSEQ.halfpi gSG.AWGFreq pi gSG.AWGAmp];
WaveForm_1Q = WaveForm_1I - repmat([0 0 0 pi/2 0], size(WaveForm_1I, 1), 1);
WaveForm_1Length = ceil((HalfPi+SpinLockGap+DetectTime+SpinLockGap+HalfPi + 1000) / (16/gSG.AWGClockRate)) * (16/gSG.AWGClockRate);
WaveForm_1PointNum = WaveForm_1Length * gSG.AWGClockRate;

WaveForm_2I = WaveForm_1I;
WaveForm_2I(size(WaveForm_1I, 1), 4) = 0; % Differential measurement
WaveForm_2Q = WaveForm_1Q;
WaveForm_2Q(size(WaveForm_1I, 1), 4) = -pi/2; % Differential measurement
WaveForm_2Length = WaveForm_1Length;
WaveForm_2PointNum = WaveForm_2Length * gSG.AWGClockRate;
    
if gmSEQ.CoolSwitch == 1
    disp(" Polarization sequence ongoing....")
    % can also switch here
    WaveForm_3I = [0 HalfPi-gmSEQ.halfpi gSG.AWGFreq 0 0; ...
        HalfPi-gmSEQ.halfpi HalfPi gSG.AWGFreq 0 gSG.AWGAmp; ...
        HalfPi+SpinLockGap HalfPi+SpinLockGap+PolarTime gSG.AWGFreq pi/2 gSG.LockingAmp; ...
        HalfPi+SpinLockGap+PolarTime+SpinLockGap HalfPi+SpinLockGap+PolarTime+SpinLockGap+gmSEQ.halfpi gSG.AWGFreq pi gSG.AWGAmp];
    WaveForm_3Q = WaveForm_3I - repmat([0 0 0 pi/2 0], size(WaveForm_3I, 1), 1);
    WaveForm_3Length =  ceil((HalfPi+SpinLockGap+PolarTime+SpinLockGap+HalfPi + 1000) / (16/gSG.AWGClockRate)) * (16/gSG.AWGClockRate);
    WaveForm_3PointNum = WaveForm_3Length * gSG.AWGClockRate;

else
    disp(" Anti-polarization sequence ongoing....")
    WaveForm_3I = [0 HalfPi-gmSEQ.halfpi gSG.AWGFreq 0 0; ...
        HalfPi-gmSEQ.halfpi HalfPi gSG.AWGFreq pi gSG.AWGAmp; ...
        HalfPi+SpinLockGap HalfPi+SpinLockGap+PolarTime gSG.AWGFreq pi/2 gSG.LockingAmp; ...
        HalfPi+SpinLockGap+PolarTime+SpinLockGap HalfPi+SpinLockGap+PolarTime+SpinLockGap+gmSEQ.halfpi gSG.AWGFreq 0 gSG.AWGAmp];
    WaveForm_3Q = WaveForm_3I - repmat([0 0 0 pi/2 0], size(WaveForm_3I, 1), 1);
    WaveForm_3Length =  ceil((HalfPi+SpinLockGap+PolarTime+SpinLockGap+HalfPi + 1000) / (16/gSG.AWGClockRate)) * (16/gSG.AWGClockRate);
    WaveForm_3PointNum = WaveForm_3Length * gSG.AWGClockRate;
end


% P1 sequence
disp(DetectTime)
if DetectTime == 0
    WaveForm_1PI = [0 HalfPi+SpinLockGap+DetectTime+SpinLockGap+HalfPi gSG2.AWGFreq 0 0]; % No pulse at all
    WaveForm_1PQ = WaveForm_1PI - repmat([0 0 0 pi/2 0], size(WaveForm_1PI, 1), 1);
    WaveForm_1PLength = ceil((HalfPi+SpinLockGap+DetectTime+SpinLockGap+HalfPi + 1000) / (16/gSG2.P1AWGClockRate)) * (16/gSG2.P1AWGClockRate);
    WaveForm_1PPointNum = WaveForm_1PLength * gSG2.P1AWGClockRate;
else
    WaveForm_1PI = [0 HalfPi-gmSEQ.DEERhalfpi gSG2.AWGFreq 0 0; ...
        HalfPi-gmSEQ.DEERhalfpi HalfPi gSG2.AWGFreq 0 gSG2.AWGAmp; ...
        HalfPi+SpinLockGap HalfPi+SpinLockGap+DetectTime gSG2.AWGFreq pi/2 gSG2.LockingAmp; ...
        HalfPi+SpinLockGap+DetectTime+SpinLockGap HalfPi+SpinLockGap+DetectTime+SpinLockGap+gmSEQ.DEERhalfpi gSG2.AWGFreq pi gSG2.AWGAmp];
    WaveForm_1PQ = WaveForm_1PI - repmat([0 0 0 pi/2 0], size(WaveForm_1PI, 1), 1);
    WaveForm_1PLength = ceil((HalfPi+SpinLockGap+DetectTime+SpinLockGap+HalfPi + 1000) / (16/gSG2.P1AWGClockRate)) * (16/gSG2.P1AWGClockRate);
    WaveForm_1PPointNum = WaveForm_1PLength * gSG2.P1AWGClockRate;
end

% disp("Artifact diagnosis. Change polarizing bare frequency.")
% P1AWGFreq = 0.09;
% WaveForm_2PI = [0 HalfPi-gmSEQ.DEERhalfpi P1AWGFreq 0 0; ...
%     HalfPi-gmSEQ.DEERhalfpi HalfPi P1AWGFreq 0 gSG2.AWGAmp; ...
%     HalfPi+SpinLockGap HalfPi+SpinLockGap+PolarTime P1AWGFreq pi/2 gSG2.LockingAmp; ...
%     HalfPi+SpinLockGap+PolarTime+SpinLockGap HalfPi+SpinLockGap+PolarTime+SpinLockGap+gmSEQ.DEERhalfpi P1AWGFreq pi gSG2.AWGAmp];
% WaveForm_2PQ = WaveForm_2PI - repmat([0 0 0 pi/2 0], size(WaveForm_2PI, 1), 1);
% WaveForm_2PLength =  ceil((HalfPi+SpinLockGap+PolarTime+SpinLockGap+HalfPi + 1000) / (16/gSG2.P1AWGClockRate)) * (16/gSG2.P1AWGClockRate);
% WaveForm_2PPointNum = WaveForm_2PLength * gSG2.P1AWGClockRate;

WaveForm_2PI = [0 HalfPi-gmSEQ.DEERhalfpi gSG2.AWGFreq 0 0; ...
    HalfPi-gmSEQ.DEERhalfpi HalfPi gSG2.AWGFreq 0 gSG2.AWGAmp; ...
    HalfPi+SpinLockGap HalfPi+SpinLockGap+PolarTime gSG2.AWGFreq pi/2 gSG2.LockingAmp; ...
    HalfPi+SpinLockGap+PolarTime+SpinLockGap+HalfPi-gmSEQ.DEERhalfpi HalfPi+SpinLockGap+PolarTime+SpinLockGap+HalfPi gSG2.AWGFreq pi gSG2.AWGAmp];
WaveForm_2PQ = WaveForm_2PI - repmat([0 0 0 pi/2 0], size(WaveForm_2PI, 1), 1);
WaveForm_2PLength =  ceil((HalfPi+SpinLockGap+PolarTime+SpinLockGap+HalfPi + 1000) / (16/gSG2.P1AWGClockRate)) * (16/gSG2.P1AWGClockRate);
WaveForm_2PPointNum = WaveForm_2PLength * gSG2.P1AWGClockRate;

WaveForm_3PI = [0 gmSEQ.DEERhalfpi gSG2.AWGFreq 0 gSG2.AWGAmp];
WaveForm_3PQ = WaveForm_3PI - repmat([0 0 0 pi/2 0], size(WaveForm_3PI, 1), 1);
WaveForm_3PLength =  ceil((gmSEQ.DEERhalfpi + 1000) / (16/gSG2.P1AWGClockRate)) * (16/gSG2.P1AWGClockRate);
WaveForm_3PPointNum = WaveForm_3PLength * gSG2.P1AWGClockRate;

chaseFunctionPool('createWaveform', WaveForm_1I, gSG.AWGClockRate, WaveForm_1Length, 'PolarP1_I_seg1.txt'); pause(0.5);
chaseFunctionPool('createWaveform', WaveForm_1Q, gSG.AWGClockRate, WaveForm_1Length, 'PolarP1_Q_seg1.txt'); pause(0.5);
chaseFunctionPool('createWaveform', WaveForm_2I, gSG.AWGClockRate, WaveForm_2Length, 'PolarP1_I_seg2.txt'); pause(0.5);
chaseFunctionPool('createWaveform', WaveForm_2Q, gSG.AWGClockRate, WaveForm_2Length, 'PolarP1_Q_seg2.txt'); pause(0.5);
chaseFunctionPool('createWaveform', WaveForm_3I, gSG.AWGClockRate, WaveForm_3Length, 'PolarP1_I_seg3.txt'); pause(0.5);
chaseFunctionPool('createWaveform', WaveForm_3Q, gSG.AWGClockRate, WaveForm_3Length, 'PolarP1_Q_seg3.txt'); pause(0.5);

chaseFunctionPool('createWaveform', WaveForm_1PI, gSG2.P1AWGClockRate, WaveForm_1PLength, 'PolarP1_I_seg1P.txt'); pause(0.5);
chaseFunctionPool('createWaveform', WaveForm_1PQ, gSG2.P1AWGClockRate, WaveForm_1PLength, 'PolarP1_Q_seg1P.txt'); pause(0.5);
chaseFunctionPool('createWaveform', WaveForm_2PI, gSG2.P1AWGClockRate, WaveForm_2PLength, 'PolarP1_I_seg2P.txt'); pause(0.5);
chaseFunctionPool('createWaveform', WaveForm_2PQ, gSG2.P1AWGClockRate, WaveForm_2PLength, 'PolarP1_Q_seg2P.txt'); pause(0.5);
chaseFunctionPool('createWaveform', WaveForm_3PI, gSG2.P1AWGClockRate, WaveForm_3PLength, 'PolarP1_I_seg3P.txt'); pause(0.5);
chaseFunctionPool('createWaveform', WaveForm_3PQ, gSG2.P1AWGClockRate, WaveForm_3PLength, 'PolarP1_Q_seg3P.txt'); pause(0.5);

if NDepol < 2
   warning("The AWG createSegStruct is not compatible with NDepol less than 2."); 
end

if gmSEQ.PolarCycle == 0
    chaseFunctionPool('createSegStruct', 'Polar_SegStruct_I.txt', ...
        'PolarP1_I_seg1.txt', WaveForm_1PointNum, 1, 1, ... 
        'PolarP1_I_seg2.txt', WaveForm_2PointNum, 1, 1);
    pause(0.5);
    chaseFunctionPool('createSegStruct', 'Polar_SegStruct_Q.txt', ...
        'PolarP1_Q_seg1.txt', WaveForm_1PointNum, 1, 1, ...
        'PolarP1_Q_seg2.txt', WaveForm_2PointNum, 1, 1);
    pause(0.5);
    chaseFunctionPool('createSegStruct', 'Polar_P1_SegStruct_I.txt', ...
        'PolarP1_I_seg3P.txt', WaveForm_3PPointNum, 1, 1, ...
        'PolarP1_I_seg3P.txt', WaveForm_3PPointNum, NDepol-1, 1, ...
        'PolarP1_I_seg1P.txt', WaveForm_1PPointNum, 1, 1);
    pause(0.5);
    chaseFunctionPool('createSegStruct', 'Polar_P1_SegStruct_Q.txt', ...
        'PolarP1_Q_seg3P.txt', WaveForm_3PPointNum, 1, 1, ...
        'PolarP1_Q_seg3P.txt', WaveForm_3PPointNum, NDepol-1, 1, ...
        'PolarP1_Q_seg1P.txt', WaveForm_1PPointNum, 1, 1);
    pause(0.5);
    %% Load waveform to AWG
    chaseFunctionPool('CreateSegments', gmSEQ.MWAWG, 1, ...
        2, ...
        2047, 2047, 'Polar_SegStruct_I.txt', 'false');
    pause(1); % this pause seems to be important, otherwise the loading is not right occassionally
    chaseFunctionPool('CreateSegments', gmSEQ.MWAWG, 2, ...
        2, ...
        2047, 2047, 'Polar_SegStruct_Q.txt', 'false');
    pause(1); % this pause seems to be important, otherwise the loading is not right occassionally
    chaseFunctionPool('CreateSegments', gmSEQ.P1AWG, 1, ...
        3, ...
        2047, 2047, 'Polar_P1_SegStruct_I.txt', 'false');
    pause(1); % this pause seems to be important, otherwise the loading is not right occassionally   
    chaseFunctionPool('CreateSegments', gmSEQ.P1AWG, 2, ...
        3, ...
        2047, 2047, 'Polar_P1_SegStruct_Q.txt', 'false');
    pause(1); % this pause seems to be important, otherwise the loading is not right occassionally 
elseif gmSEQ.PolarCycle == 1
    chaseFunctionPool('createSegStruct', 'Polar_SegStruct_I.txt', ...
        'PolarP1_I_seg3.txt', WaveForm_3PointNum, 1, 1, ...
        'PolarP1_I_seg1.txt', WaveForm_1PointNum, 1, 1, ... 
        'PolarP1_I_seg3.txt', WaveForm_3PointNum, 1, 1, ...
        'PolarP1_I_seg2.txt', WaveForm_2PointNum, 1, 1);
    pause(0.5);
    chaseFunctionPool('createSegStruct', 'Polar_SegStruct_Q.txt', ...
        'PolarP1_Q_seg3.txt', WaveForm_3PointNum, 1, 1, ...
        'PolarP1_Q_seg1.txt', WaveForm_1PointNum, 1, 1, ...
        'PolarP1_Q_seg3.txt', WaveForm_3PointNum, 1, 1, ...
        'PolarP1_Q_seg2.txt', WaveForm_2PointNum, 1, 1);
    pause(0.5);
    chaseFunctionPool('createSegStruct', 'Polar_P1_SegStruct_I.txt', ...
        'PolarP1_I_seg3P.txt', WaveForm_3PPointNum, 1, 1, ...
        'PolarP1_I_seg3P.txt', WaveForm_3PPointNum, NDepol-1, 1, ...
        'PolarP1_I_seg2P.txt', WaveForm_2PPointNum, 1, 1, ...
        'PolarP1_I_seg1P.txt', WaveForm_1PPointNum, 1, 1);
    pause(0.5);
    chaseFunctionPool('createSegStruct', 'Polar_P1_SegStruct_Q.txt', ...
        'PolarP1_Q_seg3P.txt', WaveForm_3PPointNum, 1, 1, ...
        'PolarP1_Q_seg3P.txt', WaveForm_3PPointNum, NDepol-1, 1, ...
        'PolarP1_Q_seg2P.txt', WaveForm_2PPointNum, 1, 1, ...
        'PolarP1_Q_seg1P.txt', WaveForm_1PPointNum, 1, 1);
    pause(0.5);
    %% Load waveform to AWG
    chaseFunctionPool('CreateSegments', gmSEQ.MWAWG, 1, ...
        4, ...
        2047, 2047, 'Polar_SegStruct_I.txt', 'false');
    pause(1); % this pause seems to be important, otherwise the loading is not right occassionally
    chaseFunctionPool('CreateSegments', gmSEQ.MWAWG, 2, ...
        4, ...
        2047, 2047, 'Polar_SegStruct_Q.txt', 'false');
    pause(1); % this pause seems to be important, otherwise the loading is not right occassionally
    chaseFunctionPool('CreateSegments', gmSEQ.P1AWG, 1, ...
        4, ...
        2047, 2047, 'Polar_P1_SegStruct_I.txt', 'false');
    pause(1); % this pause seems to be important, otherwise the loading is not right occassionally   
    chaseFunctionPool('CreateSegments', gmSEQ.P1AWG, 2, ...
        4, ...
        2047, 2047, 'Polar_P1_SegStruct_Q.txt', 'false');
    pause(1); % this pause seems to be important, otherwise the loading is not right occassionally 
else 
    chaseFunctionPool('createSegStruct', 'Polar_SegStruct_I.txt', ...
        'PolarP1_I_seg3.txt', WaveForm_3PointNum, 1, 1, ...
        'PolarP1_I_seg3.txt', WaveForm_3PointNum, gmSEQ.PolarCycle - 1, 1, ...
        'PolarP1_I_seg1.txt', WaveForm_1PointNum, 1, 1, ... 
        'PolarP1_I_seg3.txt', WaveForm_3PointNum, 1, 1, ...
        'PolarP1_I_seg3.txt', WaveForm_3PointNum, gmSEQ.PolarCycle - 1, 1, ...
        'PolarP1_I_seg2.txt', WaveForm_2PointNum, 1, 1);
    pause(0.5);
    chaseFunctionPool('createSegStruct', 'Polar_SegStruct_Q.txt', ...
        'PolarP1_Q_seg3.txt', WaveForm_3PointNum, 1, 1, ...
        'PolarP1_Q_seg3.txt', WaveForm_3PointNum, gmSEQ.PolarCycle - 1, 1, ...
        'PolarP1_Q_seg1.txt', WaveForm_1PointNum, 1, 1, ...
        'PolarP1_Q_seg3.txt', WaveForm_3PointNum, 1, 1, ...
        'PolarP1_Q_seg3.txt', WaveForm_3PointNum, gmSEQ.PolarCycle - 1, 1, ...
        'PolarP1_Q_seg2.txt', WaveForm_2PointNum, 1, 1);
    pause(0.5);
    chaseFunctionPool('createSegStruct', 'Polar_P1_SegStruct_I.txt', ...
        'PolarP1_I_seg3P.txt', WaveForm_3PPointNum, 1, 1, ...
        'PolarP1_I_seg3P.txt', WaveForm_3PPointNum, NDepol-1, 1, ...
        'PolarP1_I_seg2P.txt', WaveForm_2PPointNum, 1, 1, ...
        'PolarP1_I_seg2P.txt', WaveForm_2PPointNum, gmSEQ.PolarCycle-1, 1, ...
        'PolarP1_I_seg1P.txt', WaveForm_1PPointNum, 1, 1);
    pause(0.5);
    chaseFunctionPool('createSegStruct', 'Polar_P1_SegStruct_Q.txt', ...
        'PolarP1_Q_seg3P.txt', WaveForm_3PPointNum, 1, 1, ...
        'PolarP1_Q_seg3P.txt', WaveForm_3PPointNum, NDepol-1, 1, ...
        'PolarP1_Q_seg2P.txt', WaveForm_2PPointNum, 1, 1, ...
        'PolarP1_Q_seg2P.txt', WaveForm_2PPointNum, gmSEQ.PolarCycle-1, 1, ...
        'PolarP1_Q_seg1P.txt', WaveForm_1PPointNum, 1, 1);
    pause(0.5);
    %% Load waveform to AWG
    chaseFunctionPool('CreateSegments', gmSEQ.MWAWG, 1, ...
        6, ...
        2047, 2047, 'Polar_SegStruct_I.txt', 'false');
    pause(1); % this pause seems to be important, otherwise the loading is not right occassionally
    chaseFunctionPool('CreateSegments', gmSEQ.MWAWG, 2, ...
        6 , ...
        2047, 2047, 'Polar_SegStruct_Q.txt', 'false');
    pause(1); % this pause seems to be important, otherwise the loading is not right occassionally
    chaseFunctionPool('CreateSegments', gmSEQ.P1AWG, 1, ...
        5, ...
        2047, 2047, 'Polar_P1_SegStruct_I.txt', 'false');
    pause(1); % this pause seems to be important, otherwise the loading is not right occassionally   
    chaseFunctionPool('CreateSegments', gmSEQ.P1AWG, 2, ...
        5, ...
        2047, 2047, 'Polar_P1_SegStruct_Q.txt', 'false');
    pause(1); % this pause seems to be important, otherwise the loading is not right occassionally 
end

%% Run waveform
chaseFunctionPool('runChase', gmSEQ.MWAWG, 'false'); pause(1);
chaseFunctionPool('runChase', gmSEQ.P1AWG, 'false'); pause(1);
ApplyDelays();

function PolarP1 % have not tested yet
global gmSEQ gSG gSG2
gSG.bfixedPow=1;
gSG.bfixedFreq=1;
gSG.bMod='IQ';
gSG.bModSrc='External';

gSG2.bMod='IQ';
gSG2.bModSrc='External';
SignalGeneratorFunctionPool2('SetMod');
SignalGeneratorFunctionPool2('WritePow');
SignalGeneratorFunctionPool2('WriteFreq');
gSG2.bOn=1; SignalGeneratorFunctionPool2('RFOnOff');

% Temp use. TODO: find an input window for this param
gSG.LockingAmp = gmSEQ.SAmp1;
gSG.P1LockingAmp = gmSEQ.SAmp2;
gmSEQ.PolarCycle = gmSEQ.CoolCycle;
gmSEQ.DEERhalfpi = gmSEQ.DEERpi/2;

AfterPi = 1000;
AfterLaser = 2000; % 0.1e6?
AfterPolar = 1000;
Wait_p = 14e6; % It is not clear yet what the time is for P1 depolarization
Detect_Window = 5000;
PulseGap = 30;
PolarTime = 10e3; % polarizing interaction time between NV and P1
PolarReadout = 1000; % polarizing initialization time
HalfPi = max(gmSEQ.halfpi, gmSEQ.DEERhalfpi);

% Adjust the spinlockgap
SpinLockGap = 2; % The minimum SpinLockGap
SpinLockGap = ceil(HalfPi + SpinLockGap / (16 / gSG.AWGClockRate))*(16 / gSG.AWGClockRate) - HalfPi;
% Set the minimum block 
tunit = (16 / gSG.AWGClockRate) * 100; % Assume two AWG have the sample clock rate here
gmSEQ.m = ceil(gmSEQ.m / tunit) * tunit; 
gmSEQ.SweepParam = ceil(gmSEQ.SweepParam / tunit) * tunit; 
PolarTime = ceil(PolarTime / tunit) * tunit;

CycleTime = PolarReadout+AfterLaser+HalfPi+SpinLockGap+PolarTime+SpinLockGap+HalfPi+AfterPolar;
Sig_D_start = Wait_p+CycleTime*gmSEQ.PolarCycle+gmSEQ.readout+AfterLaser+HalfPi+SpinLockGap+gmSEQ.m+SpinLockGap+HalfPi+AfterPi+Detect_Window+Wait_p;

% Reuse the parameters for cooling input
gmSEQ.CHN(1).PBN=PBDictionary('ctr0');
gmSEQ.CHN(1).NRise=4;
gmSEQ.CHN(1).T=[Wait_p+CycleTime*gmSEQ.PolarCycle+gmSEQ.readout-1000-gmSEQ.CtrGateDur, ...
    Wait_p+CycleTime*gmSEQ.PolarCycle+gmSEQ.readout+AfterLaser+HalfPi+SpinLockGap+gmSEQ.m+SpinLockGap+HalfPi+AfterPi, ...
    Sig_D_start+CycleTime*gmSEQ.PolarCycle+gmSEQ.readout-1000-gmSEQ.CtrGateDur, ... 
    Sig_D_start+CycleTime*gmSEQ.PolarCycle+gmSEQ.readout+AfterLaser+HalfPi+SpinLockGap+gmSEQ.m+SpinLockGap+HalfPi+AfterPi];
if strcmp(gmSEQ.meas,'SPCM')
    gmSEQ.CHN(1).DT=[gmSEQ.CtrGateDur gmSEQ.CtrGateDur gmSEQ.CtrGateDur gmSEQ.CtrGateDur];
elseif strcmp(gmSEQ.meas,'APD')
    gmSEQ.CHN(1).DT=[1000 1000 1000 1000];
end

gmSEQ.CHN(numel(gmSEQ.CHN)+1).PBN=PBDictionary('AOM');
gmSEQ.CHN(numel(gmSEQ.CHN)).NRise=2*(2 + gmSEQ.PolarCycle);
gmSEQ.CHN(numel(gmSEQ.CHN)).T = zeros(1, gmSEQ.CHN(numel(gmSEQ.CHN)).NRise);
for i = 1:gmSEQ.PolarCycle
    gmSEQ.CHN(numel(gmSEQ.CHN)).T(i)=Wait_p+(i-1)*CycleTime;
end
gmSEQ.CHN(numel(gmSEQ.CHN)).T(gmSEQ.PolarCycle+1)=Wait_p+CycleTime*gmSEQ.PolarCycle;
gmSEQ.CHN(numel(gmSEQ.CHN)).T(gmSEQ.PolarCycle+2)=Wait_p+CycleTime*gmSEQ.PolarCycle ...
    +gmSEQ.readout+AfterLaser+HalfPi+SpinLockGap+gmSEQ.m+SpinLockGap+HalfPi+AfterPi;
for i = 1:gmSEQ.PolarCycle
    gmSEQ.CHN(numel(gmSEQ.CHN)).T(gmSEQ.PolarCycle+2+i)=Sig_D_start+(i-1)*CycleTime;
end
gmSEQ.CHN(numel(gmSEQ.CHN)).T(2*gmSEQ.PolarCycle+3)=Sig_D_start+CycleTime*gmSEQ.PolarCycle;
gmSEQ.CHN(numel(gmSEQ.CHN)).T(2*gmSEQ.PolarCycle+4)=Sig_D_start+CycleTime*gmSEQ.PolarCycle ...
	+gmSEQ.readout+AfterLaser+HalfPi+SpinLockGap+gmSEQ.m+SpinLockGap+HalfPi+AfterPi;
gmSEQ.CHN(numel(gmSEQ.CHN)).DT = [repelem(PolarReadout, gmSEQ.PolarCycle) gmSEQ.readout Detect_Window ...
    repelem(PolarReadout, gmSEQ.PolarCycle) gmSEQ.readout Detect_Window];

gmSEQ.CHN(numel(gmSEQ.CHN)+1).PBN=PBDictionary('AWGTrig');
gmSEQ.CHN(numel(gmSEQ.CHN)).NRise=2*(1 + gmSEQ.PolarCycle);
gmSEQ.CHN(numel(gmSEQ.CHN)).T = zeros(1, gmSEQ.CHN(numel(gmSEQ.CHN)).NRise);
for i = 1:gmSEQ.PolarCycle
    gmSEQ.CHN(numel(gmSEQ.CHN)).T(i)=Wait_p+(i-1)*CycleTime+PolarReadout+AfterLaser;
end
gmSEQ.CHN(numel(gmSEQ.CHN)).T(gmSEQ.PolarCycle+1)=Wait_p+CycleTime*gmSEQ.PolarCycle+gmSEQ.readout+AfterLaser;
for i = 1:gmSEQ.PolarCycle
    gmSEQ.CHN(numel(gmSEQ.CHN)).T(gmSEQ.PolarCycle+1+i)=Sig_D_start+(i-1)*CycleTime+PolarReadout+AfterLaser;
end
gmSEQ.CHN(numel(gmSEQ.CHN)).T(2*gmSEQ.PolarCycle+2)=Sig_D_start+CycleTime*gmSEQ.PolarCycle+gmSEQ.readout+AfterLaser;
gmSEQ.CHN(numel(gmSEQ.CHN)).DT=repelem(2000, gmSEQ.CHN(numel(gmSEQ.CHN)).NRise);

% P1 AWG Trig
gmSEQ.CHN(numel(gmSEQ.CHN)+1).PBN=PBDictionary('AWGTrig2');
gmSEQ.CHN(numel(gmSEQ.CHN)).NRise=2*(1 + gmSEQ.PolarCycle);
gmSEQ.CHN(numel(gmSEQ.CHN)).T=zeros(1, gmSEQ.CHN(numel(gmSEQ.CHN)).NRise);
for i = 1:gmSEQ.PolarCycle
    gmSEQ.CHN(numel(gmSEQ.CHN)).T(i)=Wait_p+(i-1)*CycleTime+PolarReadout+AfterLaser;
end
gmSEQ.CHN(numel(gmSEQ.CHN)).T(gmSEQ.PolarCycle+1)=Wait_p+CycleTime*gmSEQ.PolarCycle+gmSEQ.readout+AfterLaser;
for i = 1:gmSEQ.PolarCycle
    gmSEQ.CHN(numel(gmSEQ.CHN)).T(gmSEQ.PolarCycle+1+i)=Sig_D_start+(i-1)*CycleTime+PolarReadout+AfterLaser;
end
gmSEQ.CHN(numel(gmSEQ.CHN)).T(2*gmSEQ.PolarCycle+2)=Sig_D_start+CycleTime*gmSEQ.PolarCycle+gmSEQ.readout+AfterLaser;
gmSEQ.CHN(numel(gmSEQ.CHN)).DT=repelem(2000, gmSEQ.CHN(numel(gmSEQ.CHN)).NRise);

gmSEQ.CHN(numel(gmSEQ.CHN)+1).PBN=PBDictionary('MWSwitch');
gmSEQ.CHN(numel(gmSEQ.CHN)).NRise=2*(1 + gmSEQ.PolarCycle);
gmSEQ.CHN(numel(gmSEQ.CHN)).T = zeros(1, gmSEQ.CHN(numel(gmSEQ.CHN)).NRise);
for i = 1:gmSEQ.PolarCycle
    gmSEQ.CHN(numel(gmSEQ.CHN)).T(i)=Wait_p+(i-1)*CycleTime+PolarReadout+AfterLaser-20;
end
gmSEQ.CHN(numel(gmSEQ.CHN)).T(gmSEQ.PolarCycle+1)=Wait_p+CycleTime*gmSEQ.PolarCycle+gmSEQ.readout+AfterLaser-20;
for i = 1:gmSEQ.PolarCycle
    gmSEQ.CHN(numel(gmSEQ.CHN)).T(gmSEQ.PolarCycle+1+i)=Sig_D_start+(i-1)*CycleTime+PolarReadout+AfterLaser-20;
end
gmSEQ.CHN(numel(gmSEQ.CHN)).T(2*gmSEQ.PolarCycle+2)=Sig_D_start+CycleTime*gmSEQ.PolarCycle+gmSEQ.readout+AfterLaser-20;
gmSEQ.CHN(numel(gmSEQ.CHN)).DT=[repelem(HalfPi+SpinLockGap+PolarTime+SpinLockGap+HalfPi+40, gmSEQ.PolarCycle), ...
    HalfPi+SpinLockGap+gmSEQ.m+SpinLockGap+HalfPi+40, ...
    repelem(HalfPi+SpinLockGap+PolarTime+SpinLockGap+HalfPi+40, gmSEQ.PolarCycle), ...
    HalfPi+SpinLockGap+gmSEQ.m+SpinLockGap+HalfPi+40];

gmSEQ.CHN(numel(gmSEQ.CHN)+1).PBN=PBDictionary('MWSwitch2');
gmSEQ.CHN(numel(gmSEQ.CHN)).NRise=2*(1 + gmSEQ.PolarCycle);
gmSEQ.CHN(numel(gmSEQ.CHN)).T = zeros(1, gmSEQ.CHN(numel(gmSEQ.CHN)).NRise);
for i = 1:gmSEQ.PolarCycle
    gmSEQ.CHN(numel(gmSEQ.CHN)).T(i)=Wait_p+(i-1)*CycleTime+PolarReadout+AfterLaser-20;
end
gmSEQ.CHN(numel(gmSEQ.CHN)).T(gmSEQ.PolarCycle+1)=Wait_p+CycleTime*gmSEQ.PolarCycle+gmSEQ.readout+AfterLaser-20;
for i = 1:gmSEQ.PolarCycle
    gmSEQ.CHN(numel(gmSEQ.CHN)).T(gmSEQ.PolarCycle+1+i)=Sig_D_start+(i-1)*CycleTime+PolarReadout+AfterLaser-20;
end
gmSEQ.CHN(numel(gmSEQ.CHN)).T(2*gmSEQ.PolarCycle+2)=Sig_D_start+CycleTime*gmSEQ.PolarCycle+gmSEQ.readout+AfterLaser-20;
gmSEQ.CHN(numel(gmSEQ.CHN)).DT=[repelem(HalfPi+SpinLockGap+PolarTime+SpinLockGap+HalfPi+40, gmSEQ.PolarCycle), ...
    HalfPi+SpinLockGap+gmSEQ.m+SpinLockGap+HalfPi+40, ...
    repelem(HalfPi+SpinLockGap+PolarTime+SpinLockGap+HalfPi+40, gmSEQ.PolarCycle), ...
    HalfPi+SpinLockGap+gmSEQ.m+SpinLockGap+HalfPi+40];

gmSEQ.CHN(numel(gmSEQ.CHN)+1).PBN=PBDictionary('dummy1');
gmSEQ.CHN(numel(gmSEQ.CHN)).NRise=2;
gmSEQ.CHN(numel(gmSEQ.CHN)).T=[0 Sig_D_start+CycleTime*gmSEQ.PolarCycle+gmSEQ.readout+AfterLaser+ ...
    HalfPi+SpinLockGap+gmSEQ.m+SpinLockGap+HalfPi+AfterPi+Detect_Window-50];
gmSEQ.CHN(numel(gmSEQ.CHN)).DT=[50 50];

%% AWG
% Here we only do the looping for the measurement but not polarizing

% Initialization
chaseFunctionPool('stopChase', gmSEQ.MWAWG)
chaseFunctionPool('stopChase', gmSEQ.P1AWG);

% This part need to be modified to accomodate the DC modulation
if gSG.ACmodAWG % in AC modulation mode
    gSG.AWGFreq = gSG.AWGFreq;
    gSG2.AWGFreq = gSG2.AWGFreq;
else
    gSG.AWGFreq = 0;
    gSG2.AWGFreq = 0;
end

% Check whether the modulation frequency is legal or not.
if rem(tunit * gSG.AWGFreq, 1) ~= 0 || rem(tunit * gSG2.AWGFreq, 1) ~= 0 
    warning('The modulation frequency is incompatible with the AWG minimum time unit.');
end

WaveForm_1I = [0 gmSEQ.halfpi gSG.AWGFreq 0 gSG.AWGAmp];
WaveForm_1Q = WaveForm_1I - repmat([0 0 0 pi/2 0], size(WaveForm_1I, 1), 1);
WaveForm_1Length = HalfPi + SpinLockGap;
WaveForm_1PointNum = WaveForm_1Length * gSG.AWGClockRate;

phaseRef = 2*pi*rem(gSG.AWGFreq*WaveForm_1Length, 1); % adjust the phase between pulses

WaveForm_2I = [0 tunit gSG.AWGFreq phaseRef+pi/2 gSG.LockingAmp];
WaveForm_2Q = WaveForm_2I - repmat([0 0 0 pi/2 0], size(WaveForm_2I, 1), 1);
WaveForm_2Length = tunit;
WaveForm_2PointNum = WaveForm_2Length * gSG.AWGClockRate;

WaveForm_3I = [0 SpinLockGap 0 0 0; ...
    SpinLockGap SpinLockGap+gmSEQ.halfpi gSG.AWGFreq phaseRef+pi gSG.AWGAmp];
WaveForm_3Q = WaveForm_3I - repmat([0 0 0 pi/2 0], size(WaveForm_3I, 1), 1);
WaveForm_3Length = HalfPi + SpinLockGap;
WaveForm_3PointNum = WaveForm_3Length * gSG.AWGClockRate;

WaveForm_4I = [0 SpinLockGap 0 0 0; ...
    SpinLockGap SpinLockGap+gmSEQ.halfpi gSG.AWGFreq phaseRef+0 gSG.AWGAmp];
WaveForm_4Q = WaveForm_4I - repmat([0 0 0 pi/2 0], size(WaveForm_4I, 1), 1);
WaveForm_4Length = HalfPi + SpinLockGap;
WaveForm_4PointNum = WaveForm_4Length * gSG.AWGClockRate;

% No looping version for polarizing 
WaveForm_5I = [0 gmSEQ.halfpi gSG.AWGFreq 0 gSG.AWGAmp; ...
    HalfPi+SpinLockGap HalfPi+SpinLockGap+PolarTime gSG.AWGFreq 0 gSG.LockingAmp; ...
    HalfPi+SpinLockGap+PolarTime+SpinLockGap+HalfPi-gmSEQ.halfpi HalfPi+SpinLockGap+PolarTime+SpinLockGap+HalfPi gSG.AWGFreq 0 gSG.AWGAmp];
WaveForm_5Q = WaveForm_5I - repmat([0 0 0 pi/2 0], size(WaveForm_5I, 1), 1);
WaveForm_5Length =  ceil((HalfPi+SpinLockGap+PolarTime+SpinLockGap+HalfPi + 1000) / (16/gSG.AWGClockRate)) * (16/gSG.AWGClockRate);
WaveForm_5PointNum = WaveForm_5Length * gSG.AWGClockRate;

% P1 sequence
WaveForm_1PI = [0 gmSEQ.halfpi gSG2.AWGFreq pi gSG2.AWGAmp];
WaveForm_1PQ = WaveForm_1PI - repmat([0 0 0 pi/2 0], size(WaveForm_1PI, 1), 1);
WaveForm_1PLength = gmSEQ.halfpi + SpinLockGap;
WaveForm_1PPointNum = WaveForm_1PLength * gSG2.P1AWGClockRate;

phaseRefP = 2*pi*rem(gSG2.AWGFreq*WaveForm_1PLength, 1); % adjust the phase between pulses

WaveForm_2PI = [0 tunit gSG2.AWGFreq  phaseRefP+pi/2 gSG2.P1LockingAmp];
WaveForm_2PQ = WaveForm_2PI - repmat([0 0 0 pi/2 0], size(WaveForm_2PI, 1), 1);
WaveForm_2PLength = tunit;
WaveForm_2PPointNum = WaveForm_2PLength * gSG2.P1AWGClockRate;

WaveForm_3PI = [0 SpinLockGap 0 0 0; ...
    SpinLockGap SpinLockGap+gmSEQ.halfpi gSG2.AWGFreq phaseRefP+pi gSG2.AWGAmp];
WaveForm_3PQ = WaveForm_3PI - repmat([0 0 0 pi/2 0], size(WaveForm_3PI, 1), 1);
WaveForm_3PLength = gmSEQ.halfpi + SpinLockGap;
WaveForm_3PPointNum = WaveForm_3PLength * gSG2.P1AWGClockRate;

% No looping version for polarizing 
WaveForm_4PI = [0 gmSEQ.DEERhalfpi gSG2.AWGFreq 0 gSG2.AWGAmp; ...
    HalfPi+SpinLockGap HalfPi+SpinLockGap+PolarTime gSG2.AWGFreq 0 gSG2.P1LockingAmp; ...
    HalfPi+SpinLockGap+PolarTime+SpinLockGap+HalfPi-gmSEQ.DEERhalfpi HalfPi+SpinLockGap+PolarTime+SpinLockGap+HalfPi gSG2.AWGFreq 0 gSG2.AWGAmp];
WaveForm_4PQ = WaveForm_5I - repmat([0 0 0 pi/2 0], size(WaveForm_5I, 1), 1);
WaveForm_4PLength =  ceil((gmSEQ.halfpi+SpinLockGap+PolarTime+SpinLockGap+gmSEQ.halfpi + 1000) / (16/gSG2.P1AWGClockRate)) * (16/gSG2.P1AWGClockRate);
WaveForm_4PPointNum = WaveForm_4PLength * gSG2.P1AWGClockRate;

if rem(WaveForm_1PointNum, 16) ~= 0 || rem(WaveForm_2PointNum, 16) ~= 0  || rem(WaveForm_3PointNum, 16) ~= 0 ...
        || rem(WaveForm_1PPointNum, 16) ~= 0 || rem(WaveForm_2PPointNum, 16) ~= 0|| rem(WaveForm_3PPointNum, 16) ~= 0
   warning('The waveform point number is not a mulutple of 16.') 
end
if rem(gmSEQ.m/tunit, 1) ~= 0 || rem(PolarTime/tunit, 1) ~= 0
   warning('gmSEQ.m or PolarTime is not a multiple of minimum time unit.') 
end

% Need to be modified 1/27/2022
chaseFunctionPool('createWaveform', WaveForm_1I, gSG.AWGClockRate, WaveForm_1Length, 'PolarP1_I_seg1.txt'); pause(0.5);
chaseFunctionPool('createWaveform', WaveForm_1Q, gSG.AWGClockRate, WaveForm_1Length, 'PolarP1_Q_seg1.txt'); pause(0.5);
chaseFunctionPool('createWaveform', WaveForm_2I, gSG.AWGClockRate, WaveForm_2Length, 'PolarP1_I_seg2.txt'); pause(0.5);
chaseFunctionPool('createWaveform', WaveForm_2Q, gSG.AWGClockRate, WaveForm_2Length, 'PolarP1_Q_seg2.txt'); pause(0.5);
chaseFunctionPool('createWaveform', WaveForm_3I, gSG.AWGClockRate, WaveForm_3Length, 'PolarP1_I_seg3.txt'); pause(0.5);
chaseFunctionPool('createWaveform', WaveForm_3Q, gSG.AWGClockRate, WaveForm_3Length, 'PolarP1_Q_seg3.txt'); pause(0.5);
chaseFunctionPool('createWaveform', WaveForm_4I, gSG.AWGClockRate, WaveForm_4Length, 'PolarP1_I_seg4.txt'); pause(0.5);
chaseFunctionPool('createWaveform', WaveForm_4Q, gSG.AWGClockRate, WaveForm_4Length, 'PolarP1_Q_seg4.txt'); pause(0.5);
chaseFunctionPool('createWaveform', WaveForm_5I, gSG.AWGClockRate, WaveForm_5Length, 'PolarP1_I_seg5.txt'); pause(0.5);
chaseFunctionPool('createWaveform', WaveForm_5Q, gSG.AWGClockRate, WaveForm_5Length, 'PolarP1_Q_seg5.txt'); pause(0.5);

chaseFunctionPool('createWaveform', WaveForm_1PI, gSG2.P1AWGClockRate, WaveForm_1PLength, 'PolarP1_I_seg1P.txt'); pause(0.5);
chaseFunctionPool('createWaveform', WaveForm_1PQ, gSG2.P1AWGClockRate, WaveForm_1PLength, 'PolarP1_Q_seg1P.txt'); pause(0.5);
chaseFunctionPool('createWaveform', WaveForm_2PI, gSG2.P1AWGClockRate, WaveForm_2PLength, 'PolarP1_I_seg2P.txt'); pause(0.5);
chaseFunctionPool('createWaveform', WaveForm_2PQ, gSG2.P1AWGClockRate, WaveForm_2PLength, 'PolarP1_Q_seg2P.txt'); pause(0.5);
chaseFunctionPool('createWaveform', WaveForm_3PI, gSG2.P1AWGClockRate, WaveForm_3PLength, 'PolarP1_I_seg3P.txt'); pause(0.5);
chaseFunctionPool('createWaveform', WaveForm_3PQ, gSG2.P1AWGClockRate, WaveForm_3PLength, 'PolarP1_Q_seg3P.txt'); pause(0.5);
chaseFunctionPool('createWaveform', WaveForm_4PI, gSG2.P1AWGClockRate, WaveForm_4PLength, 'PolarP1_I_seg4P.txt'); pause(0.5);
chaseFunctionPool('createWaveform', WaveForm_4PQ, gSG2.P1AWGClockRate, WaveForm_4PLength, 'PolarP1_Q_seg4P.txt'); pause(0.5);

chaseFunctionPool('createSegStruct', 'Polar_SegStruct_I.txt', ...
    'PolarP1_I_seg5.txt', WaveForm_5PointNum, gmSEQ.PolarCycle, 1, ...
    'PolarP1_I_seg1.txt', WaveForm_1PointNum, 1, 1, ...
    'PolarP1_I_seg2.txt', WaveForm_2PointNum, round(gmSEQ.m/tunit), 0, ...
    'PolarP1_I_seg3.txt', WaveForm_3PointNum, 1, 0, ...
    'PolarP1_I_seg5.txt', WaveForm_5PointNum, gmSEQ.PolarCycle, 1, ...
    'PolarP1_I_seg1.txt', WaveForm_1PointNum, 1, 1, ...
    'PolarP1_I_seg2.txt', WaveForm_2PointNum, round(gmSEQ.m/tunit), 0, ...
    'PolarP1_I_seg4.txt', WaveForm_4PointNum, 1, 0);
pause(0.5);
chaseFunctionPool('createSegStruct', 'Polar_SegStruct_Q.txt', ...
    'PolarP1_Q_seg5.txt', WaveForm_5PointNum, gmSEQ.PolarCycle, 1, ...
    'PolarP1_Q_seg1.txt', WaveForm_1PointNum, 1, 1, ...
    'PolarP1_Q_seg2.txt', WaveForm_2PointNum, round(gmSEQ.m/tunit), 0, ...
    'PolarP1_Q_seg3.txt', WaveForm_3PointNum, 1, 0, ...
    'PolarP1_Q_seg5.txt', WaveForm_5PointNum, gmSEQ.PolarCycle, 1, ...
    'PolarP1_Q_seg1.txt', WaveForm_1PointNum, 1, 1, ...
    'PolarP1_Q_seg2.txt', WaveForm_2PointNum, round(gmSEQ.m/tunit), 0, ...
    'PolarP1_Q_seg4.txt', WaveForm_4PointNum, 1, 0);
pause(0.5);
chaseFunctionPool('createSegStruct', 'Polar_P1_SegStruct_I.txt', ...
    'PolarP1_I_seg1P.txt', WaveForm_1PPointNum, gmSEQ.PolarCycle, 1, ...
    'PolarP1_I_seg2P.txt', WaveForm_2PPointNum, 1, 1, ...
    'PolarP1_I_seg3P.txt', WaveForm_3PPointNum, round(gmSEQ.m/tunit), 0, ...
    'PolarP1_I_seg4P.txt', WaveForm_4PPointNum, 1, 0, ...
    'PolarP1_I_seg1P.txt', WaveForm_1PPointNum, gmSEQ.PolarCycle, 1, ...
    'PolarP1_I_seg2P.txt', WaveForm_2PPointNum, 1, 1, ...
    'PolarP1_I_seg3P.txt', WaveForm_3PPointNum, round(gmSEQ.m/tunit), 0, ...
    'PolarP1_I_seg4P.txt', WaveForm_4PPointNum, 1, 0);
pause(0.5);
chaseFunctionPool('createSegStruct', 'Polar_P1_SegStruct_Q.txt', ...
    'PolarP1_Q_seg1P.txt', WaveForm_1PPointNum, gmSEQ.PolarCycle, 1, ...
    'PolarP1_Q_seg2P.txt', WaveForm_2PPointNum, 1, 1, ...
    'PolarP1_Q_seg3P.txt', WaveForm_3PPointNum, round(gmSEQ.m/tunit), 0, ...
    'PolarP1_Q_seg4P.txt', WaveForm_4PPointNum, 1, 0, ...
    'PolarP1_Q_seg1P.txt', WaveForm_1PPointNum, gmSEQ.PolarCycle, 1, ...
    'PolarP1_Q_seg2P.txt', WaveForm_2PPointNum, 1, 1, ...
    'PolarP1_Q_seg3P.txt', WaveForm_3PPointNum, round(gmSEQ.m/tunit), 0, ...
    'PolarP1_Q_seg4P.txt', WaveForm_4PPointNum, 1, 0);
pause(0.5);

%% Load waveform to AWG
chaseFunctionPool('CreateSegments', gmSEQ.MWAWG, 1, ...
    8, ...
    2047, 2047, 'Polar_SegStruct_I.txt', 'false');
pause(1); % this pause seems to be important, otherwise the loading is not right occassionally
chaseFunctionPool('CreateSegments', gmSEQ.MWAWG, 2, ...
    8 , ...
    2047, 2047, 'Polar_SegStruct_Q.txt', 'false');
pause(1); % this pause seems to be important, otherwise the loading is not right occassionally
chaseFunctionPool('CreateSegments', gmSEQ.P1AWG, 1, ...
    8, ...
    2047, 2047, 'Polar_P1_SegStruct_I.txt', 'false');
pause(1); % this pause seems to be important, otherwise the loading is not right occassionally   
chaseFunctionPool('CreateSegments', gmSEQ.P1AWG, 2, ...
    8, ...
    2047, 2047, 'Polar_P1_SegStruct_Q.txt', 'false');
pause(1); % this pause seems to be important, otherwise the loading is not right occassionally 
%% Run waveform
chaseFunctionPool('runChase', gmSEQ.MWAWG, 'false'); pause(1);
chaseFunctionPool('runChase', gmSEQ.P1AWG, 'false'); pause(1);
ApplyDelays();

function SpecialCooling
global gmSEQ gSG gSG2
gSG.bfixedPow = 1;
gSG.bfixedFreq = 1;
gSG.bMod = 'IQ';
gSG.bModSrc = 'External';

% If PL signal is collected via APD.
if strcmp(gmSEQ.meas,'APD') 
    gmSEQ.CtrGateDur = 1000;
end

% Cooling sequence [pi/2_x->[t1(Omega_y) -> t2(-Omega_y)]^{N_0}]^{Cooling cycle}...

gmSEQ.halfpi = gmSEQ.pi/2;
% Wait_p = 14e6; % to wait for P1 to be fully unpolarized again
Wait_p = 5e6; % Ref calibration sequence
AfterPi = 1000;
AfterLaser = 2000;
Detect_Window = 15000;
PulseGap = 30;
SpinLockGap = 0; % The gap (in ns) between t1(Omega) and t2(-Omega).

SingleLen_C = 2 * SpinLockGap + gmSEQ.SLockT1 + gmSEQ.SLockT2; % Length of cooling segment [t1(Omega_y) -> t2(-Omega_y)]
LockLenCool = gmSEQ.LockN0 * SingleLen_C;

SingleLen_M = 1*(2*SpinLockGap+gmSEQ.SLockT1_M + gmSEQ.SLockT2_M); % Length of measuring segment [t1(Omega_y) -> t2(-Omega_y)]
LockLenMeasure = gmSEQ.m * SingleLen_M;

AfterLock = 1000;
% Cooling_Readout = gmSEQ.readout;
Cooling_Readout = 1000;

CoolCycleT = Cooling_Readout + AfterLaser + gmSEQ.halfpi + LockLenCool + gmSEQ.halfpi + AfterLock;
CoolCycleT = ceil(CoolCycleT * gSG.AWGClockRate / 16) / (gSG.AWGClockRate / 16);

%% Pulse Blaster
%%% AOM
% Cooling
gmSEQ.CHN(1).PBN=PBDictionary('AOM');
gmSEQ.CHN(1).NRise = 2 * (2 + gmSEQ.CoolCycle);
    gmSEQ.CHN(1).T = [];
    gmSEQ.CHN(1).DT = [];
    for n = 1 : gmSEQ.CoolCycle
        gmSEQ.CHN(1).T = [gmSEQ.CHN(1).T, Wait_p + (n - 1) * CoolCycleT];
        gmSEQ.CHN(1).DT = [gmSEQ.CHN(1).DT, Cooling_Readout];
    end

% Cooling - Measurement
    gmSEQ.CHN(1).T = [gmSEQ.CHN(1).T, ...
        Wait_p + gmSEQ.CoolCycle * CoolCycleT + gmSEQ.CoolWait, ...
        Wait_p + gmSEQ.CoolCycle * CoolCycleT + gmSEQ.CoolWait ...
            + gmSEQ.readout + AfterLaser + gmSEQ.halfpi + LockLenMeasure ...
            + SpinLockGap + gmSEQ.halfpi + PulseGap + gmSEQ.pi+ AfterPi];
    gmSEQ.CHN(1).DT = [gmSEQ.CHN(1).DT, gmSEQ.readout, Detect_Window]; 

 
% Differential Cooling
    Start_Sig_D = Wait_p + gmSEQ.CoolCycle * CoolCycleT + gmSEQ.CoolWait ...
        + gmSEQ.readout + AfterLaser + gmSEQ.halfpi + LockLenMeasure ...
        + SpinLockGap + gmSEQ.halfpi + PulseGap + gmSEQ.pi + AfterPi ...
        + Detect_Window + Wait_p;
    for n = 1 : gmSEQ.CoolCycle
        gmSEQ.CHN(1).T = [gmSEQ.CHN(1).T, Start_Sig_D + (n - 1) * CoolCycleT];
        gmSEQ.CHN(1).DT = [gmSEQ.CHN(1).DT, Cooling_Readout];
    end
% Differential Cooling - Measurement
    gmSEQ.CHN(1).T = [gmSEQ.CHN(1).T, ...
        Start_Sig_D + gmSEQ.CoolCycle * CoolCycleT + gmSEQ.CoolWait, ...
        Start_Sig_D + gmSEQ.CoolCycle  *CoolCycleT + gmSEQ.CoolWait ...
            + gmSEQ.readout + AfterLaser + gmSEQ.halfpi + LockLenMeasure ...
            + SpinLockGap + gmSEQ.halfpi + PulseGap + gmSEQ.pi + AfterPi];
    gmSEQ.CHN(1).DT = [gmSEQ.CHN(1).DT, gmSEQ.readout, Detect_Window];


%%% APD
% gmSEQ.CHN(numel(gmSEQ.CHN)+1).PBN=PBDictionary('ctr0');
% gmSEQ.CHN(numel(gmSEQ.CHN)).NRise = 4;
% gmSEQ.CHN(numel(gmSEQ.CHN)).T = [gmSEQ.CHN(1).T(gmSEQ.CoolCycle + 1) + gmSEQ.readout - 1000, ...
%     gmSEQ.CHN(1).T(gmSEQ.CoolCycle + 2), ...
%     gmSEQ.CHN(1).T(2 * gmSEQ.CoolCycle + 3) + gmSEQ.readout - 1000, ...
%     gmSEQ.CHN(1).T(2 * gmSEQ.CoolCycle + 4)];
% gmSEQ.CHN(numel(gmSEQ.CHN)).DT = repelem(gmSEQ.CtrGateDur, 1, 4);

gmSEQ.CHN(numel(gmSEQ.CHN)+1).PBN=PBDictionary('ctr0');
gmSEQ.CHN(numel(gmSEQ.CHN)).NRise = 4;

gmSEQ.CHN(numel(gmSEQ.CHN)).T = [gmSEQ.CHN(1).T(gmSEQ.CoolCycle + 2), ...
    gmSEQ.CHN(1).T(gmSEQ.CoolCycle + 2)+Detect_Window-1000-gmSEQ.CtrGateDur, ...
    gmSEQ.CHN(1).T(2 * gmSEQ.CoolCycle + 4), ...
    gmSEQ.CHN(1).T(2 * gmSEQ.CoolCycle + 4)+Detect_Window-1000-gmSEQ.CtrGateDur];

gmSEQ.CHN(numel(gmSEQ.CHN)).DT = repelem(gmSEQ.CtrGateDur, 1, 4);

% Note that for sequence length ~ 2ms / 20ms, the timing difference between
% PulseBlaster and AWG is ~ 10ns / 100ns

% MW Switch
% Cooling -> Cooling - Measurement
gmSEQ.CHN(numel(gmSEQ.CHN) + 1).PBN=PBDictionary('MWSwitch');
gmSEQ.CHN(numel(gmSEQ.CHN)).NRise= 2 + 2 * gmSEQ.CoolCycle + 8;
gmSEQ.CHN(numel(gmSEQ.CHN)).T = [10000-30 20000-30 30000-30 40000-30];
gmSEQ.CHN(numel(gmSEQ.CHN)).DT = [gmSEQ.halfpi+54 gmSEQ.halfpi+54 gmSEQ.halfpi+54 gmSEQ.halfpi+54];
for n = 1 : gmSEQ.CoolCycle
    gmSEQ.CHN(numel(gmSEQ.CHN)).T = [gmSEQ.CHN(numel(gmSEQ.CHN)).T, ...
        Wait_p + (n - 1) * CoolCycleT + Cooling_Readout + AfterLaser - 30]; % double the buffer around IQ.
    gmSEQ.CHN(numel(gmSEQ.CHN)).DT = [gmSEQ.CHN(numel(gmSEQ.CHN)).DT, ...
        gmSEQ.halfpi + LockLenCool + gmSEQ.halfpi + 54];
end
gmSEQ.CHN(numel(gmSEQ.CHN)).T = [gmSEQ.CHN(numel(gmSEQ.CHN)).T, ...
    Wait_p + gmSEQ.CoolCycle * CoolCycleT + gmSEQ.CoolWait + gmSEQ.readout + AfterLaser - 30];
gmSEQ.CHN(numel(gmSEQ.CHN)).DT = [gmSEQ.CHN(numel(gmSEQ.CHN)).DT, ...
    gmSEQ.halfpi + LockLenMeasure + SpinLockGap + gmSEQ.halfpi + 54];
% Differential Cooling -> Differential Cooling - Measurement


gmSEQ.CHN(numel(gmSEQ.CHN)).T = [gmSEQ.CHN(numel(gmSEQ.CHN)).T, ...
    Start_Sig_D-Wait_p+10000-30 Start_Sig_D-Wait_p+20000-30 Start_Sig_D-Wait_p+30000-30 Start_Sig_D-Wait_p+40000-30];
gmSEQ.CHN(numel(gmSEQ.CHN)).DT = [gmSEQ.CHN(numel(gmSEQ.CHN)).DT gmSEQ.halfpi+54 gmSEQ.halfpi+54 gmSEQ.halfpi+54 gmSEQ.halfpi+54];

for n = 1 : gmSEQ.CoolCycle
    gmSEQ.CHN(numel(gmSEQ.CHN)).T = [gmSEQ.CHN(numel(gmSEQ.CHN)).T, ...
        Start_Sig_D + (n - 1) * CoolCycleT + Cooling_Readout + AfterLaser - 30];
    gmSEQ.CHN(numel(gmSEQ.CHN)).DT = [gmSEQ.CHN(numel(gmSEQ.CHN)).DT, ...
        gmSEQ.halfpi + LockLenCool + gmSEQ.halfpi + 54];
end
gmSEQ.CHN(numel(gmSEQ.CHN)).T = [gmSEQ.CHN(numel(gmSEQ.CHN)).T, ...
    Start_Sig_D + gmSEQ.CoolCycle * CoolCycleT + gmSEQ.CoolWait + gmSEQ.readout + AfterLaser - 30];
gmSEQ.CHN(numel(gmSEQ.CHN)).DT = [gmSEQ.CHN(numel(gmSEQ.CHN)).DT, ...
    gmSEQ.halfpi + LockLenMeasure + SpinLockGap + gmSEQ.halfpi + PulseGap + gmSEQ.pi + 54];


%%% Dummy 1: to check the total length of the sequence.
Max_length = 2 * Wait_p + 2 * gmSEQ.CoolCycle * CoolCycleT ...
    + 2 * gmSEQ.CoolWait + 2 * gmSEQ.readout + 2 * Detect_Window ...
    + 2 * (AfterLaser + AfterPi + gmSEQ.halfpi + LockLenMeasure + SpinLockGap + gmSEQ.halfpi + PulseGap + gmSEQ.pi);
gmSEQ.CHN(numel(gmSEQ.CHN) + 1).PBN = PBDictionary('dummy1');
gmSEQ.CHN(numel(gmSEQ.CHN)).NRise = 2;
gmSEQ.CHN(numel(gmSEQ.CHN)).T = [0, Max_length-200];
gmSEQ.CHN(numel(gmSEQ.CHN)).DT = [200, 200];

%%% AWG Trigger
% Each repeatition of the segement need one trigger, a total of 2 *
% (CoolCycle + 1) triggers are needed.
% Cooling -> Cooling - Measurement
gmSEQ.CHN(numel(gmSEQ.CHN)+1).PBN = PBDictionary('AWGTrig');
gmSEQ.CHN(numel(gmSEQ.CHN)).NRise = 2 + 2 + gmSEQ.CoolCycle * 2;
gmSEQ.CHN(numel(gmSEQ.CHN)).T = [10000];
gmSEQ.CHN(numel(gmSEQ.CHN)).DT = [1000];
for n = 1 : gmSEQ.CoolCycle
gmSEQ.CHN(numel(gmSEQ.CHN)).T = [gmSEQ.CHN(numel(gmSEQ.CHN)).T, ... 
    Wait_p + (n - 1) * CoolCycleT + Cooling_Readout + AfterLaser];
gmSEQ.CHN(numel(gmSEQ.CHN)).DT = [gmSEQ.CHN(numel(gmSEQ.CHN)).DT, 500];
end

gmSEQ.CHN(numel(gmSEQ.CHN)).T = [gmSEQ.CHN(numel(gmSEQ.CHN)).T, ...
    Wait_p + gmSEQ.CoolCycle * CoolCycleT + gmSEQ.CoolWait + gmSEQ.readout + AfterLaser];
gmSEQ.CHN(numel(gmSEQ.CHN)).DT=[gmSEQ.CHN(numel(gmSEQ.CHN)).DT, 500];

gmSEQ.CHN(numel(gmSEQ.CHN)).T = [gmSEQ.CHN(numel(gmSEQ.CHN)).T, ...
    Start_Sig_D-Wait_p+10000];
gmSEQ.CHN(numel(gmSEQ.CHN)).DT=[gmSEQ.CHN(numel(gmSEQ.CHN)).DT, 1000];

% Differential Cooling -> Differential Cooling - Measurement
for n = 1:gmSEQ.CoolCycle
gmSEQ.CHN(numel(gmSEQ.CHN)).T = [gmSEQ.CHN(numel(gmSEQ.CHN)).T, ...
    Start_Sig_D + (n - 1) * CoolCycleT + Cooling_Readout + AfterLaser];
gmSEQ.CHN(numel(gmSEQ.CHN)).DT = [gmSEQ.CHN(numel(gmSEQ.CHN)).DT, 500];
end
gmSEQ.CHN(numel(gmSEQ.CHN)).T = [gmSEQ.CHN(numel(gmSEQ.CHN)).T, ...
    Start_Sig_D + gmSEQ.CoolCycle * CoolCycleT + gmSEQ.CoolWait + gmSEQ.readout + AfterLaser];
gmSEQ.CHN(numel(gmSEQ.CHN)).DT = [gmSEQ.CHN(numel(gmSEQ.CHN)).DT, 500]; 


%%% Laser AOM AWG Trigger
% added by Weijie 06/10/2021
gmSEQ.CHN(numel(gmSEQ.CHN)+1).PBN = PBDictionary('AOMAWGTrig');
gmSEQ.CHN(numel(gmSEQ.CHN)).NRise = 2;
gmSEQ.CHN(numel(gmSEQ.CHN)).T = [Wait_p, Start_Sig_D];
gmSEQ.CHN(numel(gmSEQ.CHN)).DT = [500, 500];

%% AWG
%%% Initialization
chaseFunctionPool('stopChase', gmSEQ.MWAWG)
%%% Generating wave form
if gSG.ACmodAWG 
    WaveForm_1I = [];
    WaveForm_1Q = [];
%%%% Cooling / Heating Waveforms.
% |gmSEQ.CoolSwitch| controls whether cooling / heating is turned on. 
    if gmSEQ.CoolSwitch == 1 % Cooling
        WaveForm_1I = [WaveForm_1I; ...
            0, gmSEQ.halfpi, gSG.AWGFreq, 0, gSG.AWGAmp]; % The 1st pi/2_x pulse.
        WaveForm_1Q = [WaveForm_1Q; ...
            0, gmSEQ.halfpi, gSG.AWGFreq, - pi / 2, gSG.AWGAmp];
    elseif gmSEQ.CoolSwitch == 2 % Heating
        WaveForm_1I = [WaveForm_1I; ...
            0, gmSEQ.halfpi, gSG.AWGFreq, pi, gSG.AWGAmp];
        WaveForm_1Q = [WaveForm_1Q; ...
            0, gmSEQ.halfpi, gSG.AWGFreq, pi - pi / 2, gSG.AWGAmp];
    elseif gmSEQ.CoolSwitch == 0 % Nothing
        WaveForm_1I = [WaveForm_1I; ...
            0, gmSEQ.halfpi, 0, 0, 0];
        WaveForm_1Q = [WaveForm_1Q; ...
            0, gmSEQ.halfpi, 0, 0, 0];
    end
    
    for n = 1 : gmSEQ.LockN0 % add segments of [t1(Omega_y) -> t2(-Omega_y)]
       WaveForm_1I = [WaveForm_1I; ...
           gmSEQ.halfpi + (n - 1) * SingleLen_C + SpinLockGap, ...
               gmSEQ.halfpi + (n - 1) * SingleLen_C + SpinLockGap + gmSEQ.SLockT1, ...
               gSG.AWGFreq, ...
               pi / 2, ...
               gSG.AWGAmp * gmSEQ.SAmp1; ...
           gmSEQ.halfpi + (n - 1) * SingleLen_C + SpinLockGap + gmSEQ.SLockT1 + SpinLockGap, ...
               gmSEQ.halfpi + (n - 1) * SingleLen_C + SpinLockGap + gmSEQ.SLockT1 + SpinLockGap + gmSEQ.SLockT2, ...
               gSG.AWGFreq, ...
               3 * pi / 2, ...
               gSG.AWGAmp * gmSEQ.SAmp2];
       WaveForm_1Q = [WaveForm_1Q; ...
           gmSEQ.halfpi + (n - 1) * SingleLen_C + SpinLockGap, ...
               gmSEQ.halfpi + (n - 1) * SingleLen_C + SpinLockGap + gmSEQ.SLockT1, ...
               gSG.AWGFreq, ...
               pi / 2 - pi / 2, ...
               gSG.AWGAmp * gmSEQ.SAmp1; ...
           gmSEQ.halfpi + (n - 1) * SingleLen_C + SpinLockGap + gmSEQ.SLockT1 + SpinLockGap, ...
               gmSEQ.halfpi + (n - 1) * SingleLen_C + SpinLockGap + gmSEQ.SLockT1 + SpinLockGap + gmSEQ.SLockT2, ...
               gSG.AWGFreq, ...
               3 * pi / 2 - pi/2, ...
               gSG.AWGAmp * gmSEQ.SAmp2];     
    end
    
    if gmSEQ.CoolSwitch == 1
        WaveForm_1I = [WaveForm_1I; ...
            gmSEQ.halfpi+gmSEQ.LockN0*SingleLen_C+SpinLockGap, ...
            gmSEQ.halfpi+gmSEQ.LockN0*SingleLen_C+SpinLockGap+gmSEQ.halfpi, ...
             gSG.AWGFreq, ...
             2 * pi / 2, ...
             gSG.AWGAmp];
         WaveForm_1Q = [WaveForm_1Q; ...
            gmSEQ.halfpi+gmSEQ.LockN0*SingleLen_C+SpinLockGap, ...
            gmSEQ.halfpi+gmSEQ.LockN0*SingleLen_C+SpinLockGap+gmSEQ.halfpi, ...
             gSG.AWGFreq, ...
             2 * pi / 2 - pi / 2, ...
             gSG.AWGAmp];
                      
    elseif gmSEQ.CoolSwitch == 2
         WaveForm_1I = [WaveForm_1I; ...
            gmSEQ.halfpi+gmSEQ.LockN0*SingleLen_C+SpinLockGap, ...
            gmSEQ.halfpi+gmSEQ.LockN0*SingleLen_C+SpinLockGap+gmSEQ.halfpi, ...
             gSG.AWGFreq, ...
             0 * pi / 2, ...
             gSG.AWGAmp];
         WaveForm_1Q = [WaveForm_1Q; ...
            gmSEQ.halfpi+gmSEQ.LockN0*SingleLen_C+SpinLockGap, ...
            gmSEQ.halfpi+gmSEQ.LockN0*SingleLen_C+SpinLockGap+gmSEQ.halfpi, ...
             gSG.AWGFreq, ...
             0 * pi / 2 - pi / 2, ...
             gSG.AWGAmp];
        
    end
    
    WaveForm_1Length = ceil((gmSEQ.halfpi + LockLenCool + gmSEQ.halfpi + 1000) / (16 / gSG.AWGClockRate)) ...
        *(16 / gSG.AWGClockRate);
    WaveForm_1PointNum = WaveForm_1Length * gSG.AWGClockRate;
    
%%%% Measuring Waveforms.    
    if gmSEQ.CoolSwitch <2 
        WaveForm_2I = [0, gmSEQ.halfpi, gSG.AWGFreq, 0, gSG.AWGAmp]; 
        WaveForm_2Q = [0, gmSEQ.halfpi, gSG.AWGFreq, -pi/2, gSG.AWGAmp];    
    elseif gmSEQ.CoolSwitch == 2
        WaveForm_2I = [0, gmSEQ.halfpi, gSG.AWGFreq, 0+0, gSG.AWGAmp]; 
        WaveForm_2Q = [0, gmSEQ.halfpi, gSG.AWGFreq, 0-pi/2, gSG.AWGAmp];    
    end

    for n = 1 : gmSEQ.m  % add segments of [t1(Omega_y) -> t2(-Omega_y)]
        WaveForm_2I = [WaveForm_2I; ...
           gmSEQ.halfpi + (n - 1) * SingleLen_M + SpinLockGap, ...
               gmSEQ.halfpi + (n - 1) * SingleLen_M + SpinLockGap + gmSEQ.SLockT1_M, ...
               gSG.AWGFreq, ...
               pi / 2, gSG.AWGAmp * gmSEQ.SAmp1_M;...
           gmSEQ.halfpi + (n - 1) * SingleLen_M + SpinLockGap + gmSEQ.SLockT1_M + SpinLockGap, ...
               gmSEQ.halfpi + (n - 1) * SingleLen_M + SpinLockGap + gmSEQ.SLockT1_M + SpinLockGap + gmSEQ.SLockT2_M, ...
               gSG.AWGFreq, ...
               3 * pi / 2, ...
               gSG.AWGAmp * gmSEQ.SAmp2_M];
        WaveForm_2Q = [WaveForm_2Q; ...
           gmSEQ.halfpi + (n - 1) * SingleLen_M + SpinLockGap, ...
               gmSEQ.halfpi + (n - 1) * SingleLen_M + SpinLockGap + gmSEQ.SLockT1_M, ...
               gSG.AWGFreq, ...
               pi / 2 - pi / 2, gSG.AWGAmp*gmSEQ.SAmp1_M;...
           gmSEQ.halfpi + (n - 1) * SingleLen_M + SpinLockGap + gmSEQ.SLockT1_M + SpinLockGap, ...
               gmSEQ.halfpi + (n - 1) * SingleLen_M + SpinLockGap + gmSEQ.SLockT1_M + SpinLockGap + gmSEQ.SLockT2_M, ...
               gSG.AWGFreq, ...
               3 * pi / 2 - pi / 2, ...
               gSG.AWGAmp * gmSEQ.SAmp2_M];   
    end
    
    if gmSEQ.CoolSwitch <2 
    WaveForm_2I = [WaveForm_2I; ...
        gmSEQ.halfpi + gmSEQ.m * SingleLen_M + SpinLockGap, ...
            gmSEQ.halfpi + gmSEQ.m * SingleLen_M + SpinLockGap + gmSEQ.halfpi,...
            gSG.AWGFreq, ...
            2 * pi / 2, ...
            gSG.AWGAmp];
    WaveForm_2Q = [WaveForm_2Q; ...
        gmSEQ.halfpi + gmSEQ.m * SingleLen_M + SpinLockGap, ...
            gmSEQ.halfpi + gmSEQ.m * SingleLen_M + SpinLockGap + gmSEQ.halfpi,...
            gSG.AWGFreq, ...
            2 * pi / 2 - pi / 2, ...
            gSG.AWGAmp];
    elseif gmSEQ.CoolSwitch == 2
    WaveForm_2I = [WaveForm_2I; ...
        gmSEQ.halfpi + gmSEQ.m * SingleLen_M + SpinLockGap, ...
            gmSEQ.halfpi + gmSEQ.m * SingleLen_M + SpinLockGap + gmSEQ.halfpi,...
            gSG.AWGFreq, ...
            2 * pi / 2, ...
            gSG.AWGAmp];
    WaveForm_2Q = [WaveForm_2Q; ...
        gmSEQ.halfpi + gmSEQ.m * SingleLen_M + SpinLockGap, ...
            gmSEQ.halfpi + gmSEQ.m * SingleLen_M + SpinLockGap + gmSEQ.halfpi,...
            gSG.AWGFreq, ...
            2 * pi / 2 - pi / 2, ...
            gSG.AWGAmp];     
    end
    
%%%% Differential Measuring Waveforms. Just add another pi_y pulse at the
%%%% end.
    WaveForm_3I = [WaveForm_2I; ...
        gmSEQ.halfpi + gmSEQ.m * SingleLen_M + SpinLockGap + gmSEQ.halfpi + PulseGap, ...
            gmSEQ.halfpi + gmSEQ.m * SingleLen_M + SpinLockGap + gmSEQ.halfpi + PulseGap + gmSEQ.pi, ...
            gSG.AWGFreq, ...
            pi / 2, gSG.AWGAmp];
    WaveForm_3Q = [WaveForm_2Q; ...
        gmSEQ.halfpi + gmSEQ.m * SingleLen_M + SpinLockGap + gmSEQ.halfpi + PulseGap, ...
            gmSEQ.halfpi + gmSEQ.m * SingleLen_M + SpinLockGap + gmSEQ.halfpi + PulseGap + gmSEQ.pi, ...
            gSG.AWGFreq, ...
            pi / 2 - pi / 2, gSG.AWGAmp]; 
    
    WaveForm_2Length = ceil((gmSEQ.halfpi + LockLenMeasure + SpinLockGap + gmSEQ.halfpi + PulseGap + gmSEQ.pi + 1000) / (16 / gSG.AWGClockRate)) ...
        * (16 / gSG.AWGClockRate);
    WaveForm_2PointNum = WaveForm_2Length * gSG.AWGClockRate;
    WaveForm_3Length = WaveForm_2Length;
    WaveForm_3PointNum = WaveForm_2PointNum;
    
    % NV pulse to mix up NV
     WaveForm_4I = [0, gmSEQ.halfpi, gSG.AWGFreq, 0, gSG.AWGAmp; ...
         10000, 10000+gmSEQ.halfpi,  gSG.AWGFreq, 0, gSG.AWGAmp; ...
         20000, 20000+gmSEQ.halfpi,  gSG.AWGFreq, 0, gSG.AWGAmp; ...
         30000, 30000+gmSEQ.halfpi,  gSG.AWGFreq, 0, gSG.AWGAmp];
     WaveForm_4Q = [0, gmSEQ.halfpi, gSG.AWGFreq, -pi/2, gSG.AWGAmp; ...
         10000, 10000+gmSEQ.halfpi,  gSG.AWGFreq, -pi/2, gSG.AWGAmp; ...
         20000, 20000+gmSEQ.halfpi,  gSG.AWGFreq, -pi/2, gSG.AWGAmp; ...
         30000, 30000+gmSEQ.halfpi,  gSG.AWGFreq, -pi/2, gSG.AWGAmp];
    
    WaveForm_4Length = ceil((30000+gmSEQ.halfpi+1000) / (16 / gSG.AWGClockRate)) ...
        * (16 / gSG.AWGClockRate);
    WaveForm_4PointNum = WaveForm_4Length * gSG.AWGClockRate;
    
    
else
    questdlg('Only AC modulation works for now, please check AC modulation~',...
        'Heating / Cooling Sequence', 'Cancel');
end
%%% Create Wave Form Text Files
chaseFunctionPool('createWaveform', WaveForm_1I, gSG.AWGClockRate, WaveForm_1Length, 'SpecialCooling_I_seg1.txt'); pause(0.5);
chaseFunctionPool('createWaveform', WaveForm_1Q, gSG.AWGClockRate, WaveForm_1Length, 'SpecialCooling_Q_seg1.txt'); pause(0.5);
chaseFunctionPool('createWaveform', WaveForm_2I, gSG.AWGClockRate, WaveForm_2Length, 'SpecialCooling_I_seg2.txt'); pause(0.5);
chaseFunctionPool('createWaveform', WaveForm_2Q, gSG.AWGClockRate, WaveForm_2Length, 'SpecialCooling_Q_seg2.txt'); pause(0.5);
chaseFunctionPool('createWaveform', WaveForm_3I, gSG.AWGClockRate, WaveForm_3Length, 'SpecialCooling_I_seg3.txt'); pause(0.5);
chaseFunctionPool('createWaveform', WaveForm_3Q, gSG.AWGClockRate, WaveForm_3Length, 'SpecialCooling_Q_seg3.txt'); pause(0.5);
chaseFunctionPool('createWaveform', WaveForm_4I, gSG.AWGClockRate, WaveForm_4Length, 'SpecialCooling_I_seg4.txt'); pause(0.5);
chaseFunctionPool('createWaveform', WaveForm_4Q, gSG.AWGClockRate, WaveForm_4Length, 'SpecialCooling_Q_seg4.txt'); pause(0.5);

%%% Create Wave Form Structs -> Pass Segments to AWG
if gmSEQ.CoolCycle == 0
    chaseFunctionPool('createSegStruct', 'SpecialCooling_SegStruct_I.txt', ...
        'SpecialCooling_I_seg4.txt', WaveForm_4PointNum, 1, 1, ...
        'SpecialCooling_I_seg2.txt', WaveForm_2PointNum, 1, 1, ...
        'SpecialCooling_I_seg4.txt', WaveForm_4PointNum, 1, 1, ...
        'SpecialCooling_I_seg3.txt', WaveForm_3PointNum, 1, 1);
    pause(0.5);
    chaseFunctionPool('createSegStruct', 'SpecialCooling_SegStruct_Q.txt', ...
        'SpecialCooling_Q_seg4.txt', WaveForm_4PointNum, 1, 1, ...
        'SpecialCooling_Q_seg2.txt', WaveForm_2PointNum, 1, 1, ...
        'SpecialCooling_Q_seg4.txt', WaveForm_4PointNum, 1, 1, ...
        'SpecialCooling_Q_seg3.txt', WaveForm_3PointNum, 1, 1);
    pause(0.5);
    chaseFunctionPool('CreateSegments', gmSEQ.MWAWG, 1, ...
        4, ...
        2047, 2047, 'SpecialCooling_SegStruct_I.txt', 'false');
    pause(1); % this pause seems to be important, otherwise the loading is not right occassionally
    chaseFunctionPool('CreateSegments', gmSEQ.MWAWG, 2, ...
        4, ...
        2047, 2047, 'SpecialCooling_SegStruct_Q.txt', 'false');
    pause(1); % this pause seems to be important, otherwise the loading is not right occassionally
    chaseFunctionPool('runChase', gmSEQ.MWAWG, 'false');
elseif gmSEQ.CoolCycle == 1
    chaseFunctionPool('createSegStruct', 'SpecialCooling_SegStruct_I.txt', ...
        'SpecialCooling_I_seg4.txt', WaveForm_4PointNum, 1, 1, ...
        'SpecialCooling_I_seg1.txt', WaveForm_1PointNum, 1, 1, ...
        'SpecialCooling_I_seg2.txt', WaveForm_2PointNum, 1, 1, ...
        'SpecialCooling_I_seg4.txt', WaveForm_4PointNum, 1, 1, ...
        'SpecialCooling_I_seg1.txt', WaveForm_1PointNum, 1, 1, ...
        'SpecialCooling_I_seg3.txt', WaveForm_3PointNum, 1, 1);
    pause(0.5);
    chaseFunctionPool('createSegStruct', 'SpecialCooling_SegStruct_Q.txt', ...
        'SpecialCooling_Q_seg4.txt', WaveForm_4PointNum, 1, 1, ...
        'SpecialCooling_Q_seg1.txt', WaveForm_1PointNum, 1, 1, ...
        'SpecialCooling_Q_seg2.txt', WaveForm_2PointNum, 1, 1, ...
        'SpecialCooling_Q_seg4.txt', WaveForm_4PointNum, 1, 1, ...
        'SpecialCooling_Q_seg1.txt', WaveForm_1PointNum, 1, 1, ...
        'SpecialCooling_Q_seg3.txt', WaveForm_3PointNum, 1, 1);
    pause(0.5);
    chaseFunctionPool('CreateSegments', gmSEQ.MWAWG, 1, ...
        6, ...
        2047, 2047, 'SpecialCooling_SegStruct_I.txt', 'false');
    pause(1); % this pause seems to be important, otherwise the loading is not right occassionally
    chaseFunctionPool('CreateSegments', gmSEQ.MWAWG, 2, ...
        6, ...
        2047, 2047, 'SpecialCooling_SegStruct_Q.txt', 'false');
    pause(1); % this pause seems to be important, otherwise the loading is not right occassionally
    chaseFunctionPool('runChase', gmSEQ.MWAWG, 'false');
elseif gmSEQ.CoolCycle < 500
chaseFunctionPool('createSegStruct', 'SpecialCooling_SegStruct_I.txt', ...
    'SpecialCooling_I_seg4.txt', WaveForm_4PointNum, 1, 1, ...
    'SpecialCooling_I_seg1.txt', WaveForm_1PointNum, 1, 1, ... % The first repeatition cannot be looped and must be triggered, so must be left out.
    'SpecialCooling_I_seg1.txt', WaveForm_1PointNum, gmSEQ.CoolCycle - 1, 1, ...
    'SpecialCooling_I_seg2.txt', WaveForm_2PointNum, 1, 1, ...
    'SpecialCooling_I_seg4.txt', WaveForm_4PointNum, 1, 1, ...
    'SpecialCooling_I_seg1.txt', WaveForm_1PointNum, 1, 1, ... % This one just to make sure things are symmetric.
    'SpecialCooling_I_seg1.txt', WaveForm_1PointNum, gmSEQ.CoolCycle - 1, 1, ...
    'SpecialCooling_I_seg3.txt', WaveForm_3PointNum, 1, 1);
pause(0.5);
chaseFunctionPool('createSegStruct', 'SpecialCooling_SegStruct_Q.txt', ...
    'SpecialCooling_Q_seg4.txt', WaveForm_4PointNum, 1, 1, ...
    'SpecialCooling_Q_seg1.txt', WaveForm_1PointNum, 1, 1, ... 
    'SpecialCooling_Q_seg1.txt', WaveForm_1PointNum, gmSEQ.CoolCycle - 1, 1, ...
    'SpecialCooling_Q_seg2.txt', WaveForm_2PointNum, 1, 1, ...
    'SpecialCooling_Q_seg4.txt', WaveForm_4PointNum, 1, 1, ...
    'SpecialCooling_Q_seg1.txt', WaveForm_1PointNum, 1, 1, ...
    'SpecialCooling_Q_seg1.txt', WaveForm_1PointNum, gmSEQ.CoolCycle - 1, 1, ...
    'SpecialCooling_Q_seg3.txt', WaveForm_3PointNum, 1, 1);
pause(0.5);    
chaseFunctionPool('CreateSegments', gmSEQ.MWAWG, 1, ...
    8, ...
    2047, 2047, 'SpecialCooling_SegStruct_I.txt', 'false');
pause(3); % this pause seems to be important, otherwise the loading is not right occassionally
chaseFunctionPool('CreateSegments', gmSEQ.MWAWG, 2, ...
    8, ...
    2047, 2047, 'SpecialCooling_SegStruct_Q.txt', 'false');
pause(3); % this pause seems to be important, otherwise the loading is not right occassionally
%%% Run AWG.
chaseFunctionPool('runChase', gmSEQ.MWAWG, 'false');

% else
%     chaseFunctionPool('createSegStruct', 'SpecialCooling_SegStruct_I.txt', ...
%     'SpecialCooling_I_seg1.txt', WaveForm_1PointNum, 1, 1, ... % The first repeatition cannot be looped and must be triggered, so must be left out.
%     'SpecialCooling_I_seg1.txt', WaveForm_1PointNum, 300, 1, ...
%     'SpecialCooling_I_seg1.txt', WaveForm_1PointNum, gmSEQ.CoolCycle-300-1, 1, ...
%     'SpecialCooling_I_seg2.txt', WaveForm_2PointNum, 1, 1, ...
%     'SpecialCooling_I_seg1.txt', WaveForm_1PointNum, 1, 1, ... % This one just to make sure things are symmetric.
%     'SpecialCooling_I_seg1.txt', WaveForm_1PointNum, 300, 1, ...
%     'SpecialCooling_I_seg1.txt', WaveForm_1PointNum, gmSEQ.CoolCycle-300-1, 1, ...
%     'SpecialCooling_I_seg3.txt', WaveForm_3PointNum, 1, 1);
% pause(0.5);
% chaseFunctionPool('createSegStruct', 'SpecialCooling_SegStruct_Q.txt', ...
%     'SpecialCooling_Q_seg1.txt', WaveForm_1PointNum, 1, 1, ... 
%     'SpecialCooling_Q_seg1.txt', WaveForm_1PointNum, 300, 1, ...
%     'SpecialCooling_Q_seg1.txt', WaveForm_1PointNum, gmSEQ.CoolCycle-300-1, 1, ...
%     'SpecialCooling_Q_seg2.txt', WaveForm_2PointNum, 1, 1, ...
%     'SpecialCooling_Q_seg1.txt', WaveForm_1PointNum, 1, 1, ...
%     'SpecialCooling_Q_seg1.txt', WaveForm_1PointNum, 300, 1, ...
%     'SpecialCooling_Q_seg1.txt', WaveForm_1PointNum, gmSEQ.CoolCycle-300-1, 1, ...
%     'SpecialCooling_Q_seg3.txt', WaveForm_3PointNum, 1, 1);
% pause(0.5);    
% chaseFunctionPool('CreateSegments', 1, 1, ...
%     8, ...
%     2047, 2047, 'SpecialCooling_SegStruct_I.txt', 'false');
% pause(3); % this pause seems to be important, otherwise the loading is not right occassionally
% chaseFunctionPool('CreateSegments', 1, 2, ...
%     8, ...
%     2047, 2047, 'SpecialCooling_SegStruct_Q.txt', 'false');
% pause(3); % this pause seems to be important, otherwise the loading is not right occassionally
% %%% Run AWG.
% chaseFunctionPool('runChase', 1, 'false');
end

%% AOM AWG
% added by Weijie 06/10/2021
%%% Initialization
chaseFunctionPool('stopChase', gmSEQ.LaserAWG)

% genenerate the file below
%[t1,t2,freq1,phase1,amp1;...
% t3,t4,freq2,phase2,amp2;...
%...]
% [0 16000 0 pi/2 AWGVoltage] 
% gmSEQ.LaserCooling = 0.2;
% gmSEQ.LaserDet = 0.7;

Delay = 2000;
WaveForm_L = [ 0, ...
        gmSEQ.CoolCycle * CoolCycleT + gmSEQ.CoolWait + gmSEQ.readout + AfterLaser, ...
        0, pi/2, gmSEQ.LaserCooling; ...
        ...
        gmSEQ.CoolCycle * CoolCycleT + gmSEQ.CoolWait + gmSEQ.readout + ...
            AfterLaser + gmSEQ.halfpi + LockLenMeasure + SpinLockGap + ... 
            gmSEQ.halfpi + PulseGap + gmSEQ.pi, ...
        gmSEQ.CoolCycle * CoolCycleT + gmSEQ.CoolWait + gmSEQ.readout + ...
            AfterLaser + gmSEQ.halfpi + LockLenMeasure + SpinLockGap + ... 
            gmSEQ.halfpi + PulseGap + gmSEQ.pi+ AfterPi + Detect_Window + Delay, ...
        0, pi/2, gmSEQ.LaserDet; ...
    ];

WaveForm_LLength = ceil((gmSEQ.CoolCycle * CoolCycleT + gmSEQ.CoolWait + gmSEQ.readout + ...
        AfterLaser + gmSEQ.halfpi + LockLenMeasure + SpinLockGap + ... 
        gmSEQ.halfpi + PulseGap + gmSEQ.pi+ AfterPi + Detect_Window + Delay) / (16 / gSG2.LaserAWGClockRate)) ...
    *(16 / gSG2.LaserAWGClockRate);
WaveForm_LPointNum = WaveForm_LLength * gSG2.LaserAWGClockRate;

chaseFunctionPool('createWaveform', WaveForm_L, gSG2.LaserAWGClockRate, WaveForm_LLength, 'SpecialCooling_LaserPulse.txt');
pause(0.5);

chaseFunctionPool('createSegStruct', 'SpecialCooling_SegStruct_Laser.txt', ...
    'SpecialCooling_LaserPulse.txt', WaveForm_LPointNum, 1, 1, ...
    'SpecialCooling_LaserPulse.txt', WaveForm_LPointNum, 1, 1);
pause(0.5);
  
chaseFunctionPool('CreateSegments', gmSEQ.LaserAWG, 1, 2, 2047, 2047, 'SpecialCooling_SegStruct_Laser.txt', 'false');
pause(1); % this pause seems to be important, otherwise the loading is not right occassionally

%%% Run AWG.
chaseFunctionPool('runChase', gmSEQ.LaserAWG, 'false');

ApplyDelays();    

function SpecialCooling_Orange
global gmSEQ gSG
gSG.bfixedPow = 1;
gSG.bfixedFreq = 1;
gSG.bMod = 'IQ';
gSG.bModSrc = 'External';

% If PL signal is collected via APD.
if strcmp(gmSEQ.meas,'APD') 
    gmSEQ.CtrGateDur = 1000;
end

% Cooling sequence [pi/2_x->[t1(Omega_y) -> t2(-Omega_y)]^{N_0}]^{Cooling cycle}...

gmSEQ.halfpi = gmSEQ.pi/2;
Wait_p = 20e6; % to wait for P1 to be fully unpolarized again
AfterPi = 1000;
AfterLaser = 2000;
Detect_Window = 15000;
PulseGap = 30;
SpinLockGap = 0; % The gap (in ns) between t1(Omega) and t2(-Omega).

SingleLen_C = 2 * SpinLockGap + gmSEQ.SLockT1 + gmSEQ.SLockT2; % Length of cooling segment [t1(Omega_y) -> t2(-Omega_y)]
LockLenCool = gmSEQ.LockN0 * SingleLen_C;

SingleLen_M = 1*(2*SpinLockGap+gmSEQ.SLockT1_M + gmSEQ.SLockT2_M); % Length of measuring segment [t1(Omega_y) -> t2(-Omega_y)]
LockLenMeasure = gmSEQ.m * SingleLen_M;

AfterLock = 1000;
% Cooling_Readout = gmSEQ.readout;
Cooling_Readout = 1000;

CoolCycleT = Cooling_Readout + AfterLaser + gmSEQ.halfpi + LockLenCool + gmSEQ.halfpi + AfterLock;
CoolCycleT = ceil(CoolCycleT * gSG.AWGClockRate / 16) / (gSG.AWGClockRate / 16);

%% Pulse Blaster
%%% AOM
% Cooling
gmSEQ.CHN(1).PBN=PBDictionary('OrangeAOM');
gmSEQ.CHN(1).NRise = 2 * (2 + gmSEQ.CoolCycle);
    gmSEQ.CHN(1).T = [];
    gmSEQ.CHN(1).DT = [];
    for n = 1 : gmSEQ.CoolCycle
        gmSEQ.CHN(1).T = [gmSEQ.CHN(1).T, Wait_p + (n - 1) * CoolCycleT];
        gmSEQ.CHN(1).DT = [gmSEQ.CHN(1).DT, Cooling_Readout];
    end
% Cooling - Measurement
    gmSEQ.CHN(1).T = [gmSEQ.CHN(1).T, ...
        Wait_p + gmSEQ.CoolCycle * CoolCycleT + gmSEQ.CoolWait, ...
        Wait_p + gmSEQ.CoolCycle * CoolCycleT + gmSEQ.CoolWait ...
            + gmSEQ.readout + AfterLaser + gmSEQ.halfpi + LockLenMeasure ...
            + SpinLockGap + gmSEQ.halfpi + PulseGap + gmSEQ.pi+ AfterPi];
    gmSEQ.CHN(1).DT = [gmSEQ.CHN(1).DT, gmSEQ.readout, Detect_Window]; 
% Differential Cooling
    Start_Sig_D = Wait_p + gmSEQ.CoolCycle * CoolCycleT + gmSEQ.CoolWait ...
        + gmSEQ.readout + AfterLaser + gmSEQ.halfpi + LockLenMeasure ...
        + SpinLockGap + gmSEQ.halfpi + PulseGap + gmSEQ.pi + AfterPi ...
        + Detect_Window + Wait_p;
    for n = 1 : gmSEQ.CoolCycle
        gmSEQ.CHN(1).T = [gmSEQ.CHN(1).T, Start_Sig_D + (n - 1) * CoolCycleT];
        gmSEQ.CHN(1).DT = [gmSEQ.CHN(1).DT, Cooling_Readout];
    end
% Differential Cooling - Measurement
    gmSEQ.CHN(1).T = [gmSEQ.CHN(1).T, ...
        Start_Sig_D + gmSEQ.CoolCycle * CoolCycleT + gmSEQ.CoolWait, ...
        Start_Sig_D + gmSEQ.CoolCycle  *CoolCycleT + gmSEQ.CoolWait ...
            + gmSEQ.readout + AfterLaser + gmSEQ.halfpi + LockLenMeasure ...
            + SpinLockGap + gmSEQ.halfpi + PulseGap + gmSEQ.pi + AfterPi];
    gmSEQ.CHN(1).DT = [gmSEQ.CHN(1).DT, gmSEQ.readout, Detect_Window];

%%% APD
% gmSEQ.CHN(numel(gmSEQ.CHN)+1).PBN=PBDictionary('ctr0');
% gmSEQ.CHN(numel(gmSEQ.CHN)).NRise = 4;
% gmSEQ.CHN(numel(gmSEQ.CHN)).T = [gmSEQ.CHN(1).T(gmSEQ.CoolCycle + 1) + gmSEQ.readout - 1000, ...
%     gmSEQ.CHN(1).T(gmSEQ.CoolCycle + 2), ...
%     gmSEQ.CHN(1).T(2 * gmSEQ.CoolCycle + 3) + gmSEQ.readout - 1000, ...
%     gmSEQ.CHN(1).T(2 * gmSEQ.CoolCycle + 4)];
% gmSEQ.CHN(numel(gmSEQ.CHN)).DT = repelem(gmSEQ.CtrGateDur, 1, 4);

gmSEQ.CHN(numel(gmSEQ.CHN)+1).PBN=PBDictionary('ctr0');
gmSEQ.CHN(numel(gmSEQ.CHN)).NRise = 4;
gmSEQ.CHN(numel(gmSEQ.CHN)).T = [gmSEQ.CHN(1).T(gmSEQ.CoolCycle + 2), ...
    gmSEQ.CHN(1).T(gmSEQ.CoolCycle + 2)+Detect_Window-1000-gmSEQ.CtrGateDur, ...
    gmSEQ.CHN(1).T(2 * gmSEQ.CoolCycle + 4), ...
    gmSEQ.CHN(1).T(2 * gmSEQ.CoolCycle + 4)+Detect_Window-1000-gmSEQ.CtrGateDur];
gmSEQ.CHN(numel(gmSEQ.CHN)).DT = repelem(gmSEQ.CtrGateDur, 1, 4);

% Note that for sequence length ~ 2ms / 20ms, the timing difference between
% PulseBlaster and AWG is ~ 10ns / 100ns

% MW Switch
% Cooling -> Cooling - Measurement
gmSEQ.CHN(numel(gmSEQ.CHN) + 1).PBN=PBDictionary('MWSwitch');
gmSEQ.CHN(numel(gmSEQ.CHN)).NRise= 2 + 2 * gmSEQ.CoolCycle + 8;
gmSEQ.CHN(numel(gmSEQ.CHN)).T = [10000-30 20000-30 30000-30 40000-30];
gmSEQ.CHN(numel(gmSEQ.CHN)).DT = [gmSEQ.halfpi+54 gmSEQ.halfpi+54 gmSEQ.halfpi+54 gmSEQ.halfpi+54];
for n = 1 : gmSEQ.CoolCycle
    gmSEQ.CHN(numel(gmSEQ.CHN)).T = [gmSEQ.CHN(numel(gmSEQ.CHN)).T, ...
        Wait_p + (n - 1) * CoolCycleT + Cooling_Readout + AfterLaser - 30]; % double the buffer around IQ.
    gmSEQ.CHN(numel(gmSEQ.CHN)).DT = [gmSEQ.CHN(numel(gmSEQ.CHN)).DT, ...
        gmSEQ.halfpi + LockLenCool + gmSEQ.halfpi + 54];
end
gmSEQ.CHN(numel(gmSEQ.CHN)).T = [gmSEQ.CHN(numel(gmSEQ.CHN)).T, ...
    Wait_p + gmSEQ.CoolCycle * CoolCycleT + gmSEQ.CoolWait + gmSEQ.readout + AfterLaser - 30];
gmSEQ.CHN(numel(gmSEQ.CHN)).DT = [gmSEQ.CHN(numel(gmSEQ.CHN)).DT, ...
    gmSEQ.halfpi + LockLenMeasure + SpinLockGap + gmSEQ.halfpi + 54];
% Differential Cooling -> Differential Cooling - Measurement


gmSEQ.CHN(numel(gmSEQ.CHN)).T = [gmSEQ.CHN(numel(gmSEQ.CHN)).T, ...
    Start_Sig_D-Wait_p+10000-30 Start_Sig_D-Wait_p+20000-30 Start_Sig_D-Wait_p+30000-30 Start_Sig_D-Wait_p+40000-30];
gmSEQ.CHN(numel(gmSEQ.CHN)).DT = [gmSEQ.CHN(numel(gmSEQ.CHN)).DT gmSEQ.halfpi+54 gmSEQ.halfpi+54 gmSEQ.halfpi+54 gmSEQ.halfpi+54];

for n = 1 : gmSEQ.CoolCycle
    gmSEQ.CHN(numel(gmSEQ.CHN)).T = [gmSEQ.CHN(numel(gmSEQ.CHN)).T, ...
        Start_Sig_D + (n - 1) * CoolCycleT + Cooling_Readout + AfterLaser - 30];
    gmSEQ.CHN(numel(gmSEQ.CHN)).DT = [gmSEQ.CHN(numel(gmSEQ.CHN)).DT, ...
        gmSEQ.halfpi + LockLenCool + gmSEQ.halfpi + 54];
end
gmSEQ.CHN(numel(gmSEQ.CHN)).T = [gmSEQ.CHN(numel(gmSEQ.CHN)).T, ...
    Start_Sig_D + gmSEQ.CoolCycle * CoolCycleT + gmSEQ.CoolWait + gmSEQ.readout + AfterLaser - 30];
gmSEQ.CHN(numel(gmSEQ.CHN)).DT = [gmSEQ.CHN(numel(gmSEQ.CHN)).DT, ...
    gmSEQ.halfpi + LockLenMeasure + SpinLockGap + gmSEQ.halfpi + PulseGap + gmSEQ.pi + 54];


%%% Dummy 1: to check the total length of the sequence.
Max_length = 2 * Wait_p + 2 * gmSEQ.CoolCycle * CoolCycleT ...
    + 2 * gmSEQ.CoolWait + 2 * gmSEQ.readout + 2 * Detect_Window ...
    + 2 * (AfterLaser + AfterPi + gmSEQ.halfpi + LockLenMeasure + SpinLockGap + gmSEQ.halfpi + PulseGap + gmSEQ.pi);
gmSEQ.CHN(numel(gmSEQ.CHN) + 1).PBN = PBDictionary('dummy1');
gmSEQ.CHN(numel(gmSEQ.CHN)).NRise = 2;
gmSEQ.CHN(numel(gmSEQ.CHN)).T = [0, Max_length-200];
gmSEQ.CHN(numel(gmSEQ.CHN)).DT = [200, 200];

%%% AWG Trigger
% Each repeatition of the segement need one trigger, a total of 2 *
% (CoolCycle + 1) triggers are needed.
% Cooling -> Cooling - Measurement
gmSEQ.CHN(numel(gmSEQ.CHN)+1).PBN = PBDictionary('AWGTrig');
gmSEQ.CHN(numel(gmSEQ.CHN)).NRise = 2 + 2 + gmSEQ.CoolCycle * 2;
gmSEQ.CHN(numel(gmSEQ.CHN)).T = [10000];
gmSEQ.CHN(numel(gmSEQ.CHN)).DT = [800];
for n = 1 : gmSEQ.CoolCycle
gmSEQ.CHN(numel(gmSEQ.CHN)).T = [gmSEQ.CHN(numel(gmSEQ.CHN)).T, ... 
    Wait_p + (n - 1) * CoolCycleT + Cooling_Readout + AfterLaser];
gmSEQ.CHN(numel(gmSEQ.CHN)).DT = [gmSEQ.CHN(numel(gmSEQ.CHN)).DT, 800];
end

gmSEQ.CHN(numel(gmSEQ.CHN)).T = [gmSEQ.CHN(numel(gmSEQ.CHN)).T, ...
    Wait_p + gmSEQ.CoolCycle * CoolCycleT + gmSEQ.CoolWait + gmSEQ.readout + AfterLaser];
gmSEQ.CHN(numel(gmSEQ.CHN)).DT=[gmSEQ.CHN(numel(gmSEQ.CHN)).DT, 800];

gmSEQ.CHN(numel(gmSEQ.CHN)).T = [gmSEQ.CHN(numel(gmSEQ.CHN)).T, ...
    Start_Sig_D-Wait_p+10000];
gmSEQ.CHN(numel(gmSEQ.CHN)).DT=[gmSEQ.CHN(numel(gmSEQ.CHN)).DT, 800];

% Differential Cooling -> Differential Cooling - Measurement
for n = 1:gmSEQ.CoolCycle
gmSEQ.CHN(numel(gmSEQ.CHN)).T = [gmSEQ.CHN(numel(gmSEQ.CHN)).T, ...
    Start_Sig_D + (n - 1) * CoolCycleT + Cooling_Readout + AfterLaser];
gmSEQ.CHN(numel(gmSEQ.CHN)).DT = [gmSEQ.CHN(numel(gmSEQ.CHN)).DT, 800];
end
gmSEQ.CHN(numel(gmSEQ.CHN)).T = [gmSEQ.CHN(numel(gmSEQ.CHN)).T, ...
    Start_Sig_D + gmSEQ.CoolCycle * CoolCycleT + gmSEQ.CoolWait + gmSEQ.readout + AfterLaser];
gmSEQ.CHN(numel(gmSEQ.CHN)).DT = [gmSEQ.CHN(numel(gmSEQ.CHN)).DT, 800]; 

%% AWG
%%% Initialization
chaseFunctionPool('stopChase', 1)
%%% Generating wave form
if gSG.ACmodAWG 
    WaveForm_1I = [];
    WaveForm_1Q = [];
%%%% Cooling / Heating Waveforms.
% |gmSEQ.CoolSwitch| controls whether cooling / heating is turned on. 
    if gmSEQ.CoolSwitch == 1 % Cooling
        WaveForm_1I = [WaveForm_1I; ...
            0, gmSEQ.halfpi, gSG.AWGFreq, 0, gSG.AWGAmp]; % The 1st pi/2_x pulse.
        WaveForm_1Q = [WaveForm_1Q; ...
            0, gmSEQ.halfpi, gSG.AWGFreq, - pi / 2, gSG.AWGAmp];
    elseif gmSEQ.CoolSwitch == 2 % Heating
        WaveForm_1I = [WaveForm_1I; ...
            0, gmSEQ.halfpi, gSG.AWGFreq, pi, gSG.AWGAmp];
        WaveForm_1Q = [WaveForm_1Q; ...
            0, gmSEQ.halfpi, gSG.AWGFreq, pi - pi / 2, gSG.AWGAmp];
    elseif gmSEQ.CoolSwitch == 0 % Nothing
        WaveForm_1I = [WaveForm_1I; ...
            0, gmSEQ.halfpi, 0, 0, 0];
        WaveForm_1Q = [WaveForm_1Q; ...
            0, gmSEQ.halfpi, 0, 0, 0];
    end
    
    for n = 1 : gmSEQ.LockN0 % add segments of [t1(Omega_y) -> t2(-Omega_y)]
       WaveForm_1I = [WaveForm_1I; ...
           gmSEQ.halfpi + (n - 1) * SingleLen_C + SpinLockGap, ...
               gmSEQ.halfpi + (n - 1) * SingleLen_C + SpinLockGap + gmSEQ.SLockT1, ...
               gSG.AWGFreq, ...
               pi / 2, ...
               gSG.AWGAmp * gmSEQ.SAmp1; ...
           gmSEQ.halfpi + (n - 1) * SingleLen_C + SpinLockGap + gmSEQ.SLockT1 + SpinLockGap, ...
               gmSEQ.halfpi + (n - 1) * SingleLen_C + SpinLockGap + gmSEQ.SLockT1 + SpinLockGap + gmSEQ.SLockT2, ...
               gSG.AWGFreq, ...
               3 * pi / 2, ...
               gSG.AWGAmp * gmSEQ.SAmp2];
       WaveForm_1Q = [WaveForm_1Q; ...
           gmSEQ.halfpi + (n - 1) * SingleLen_C + SpinLockGap, ...
               gmSEQ.halfpi + (n - 1) * SingleLen_C + SpinLockGap + gmSEQ.SLockT1, ...
               gSG.AWGFreq, ...
               pi / 2 - pi / 2, ...
               gSG.AWGAmp * gmSEQ.SAmp1; ...
           gmSEQ.halfpi + (n - 1) * SingleLen_C + SpinLockGap + gmSEQ.SLockT1 + SpinLockGap, ...
               gmSEQ.halfpi + (n - 1) * SingleLen_C + SpinLockGap + gmSEQ.SLockT1 + SpinLockGap + gmSEQ.SLockT2, ...
               gSG.AWGFreq, ...
               3 * pi / 2 - pi/2, ...
               gSG.AWGAmp * gmSEQ.SAmp2];     
    end
    
    if gmSEQ.CoolSwitch == 1
        WaveForm_1I = [WaveForm_1I; ...
            gmSEQ.halfpi+gmSEQ.LockN0*SingleLen_C+SpinLockGap, ...
            gmSEQ.halfpi+gmSEQ.LockN0*SingleLen_C+SpinLockGap+gmSEQ.halfpi, ...
             gSG.AWGFreq, ...
             2 * pi / 2, ...
             gSG.AWGAmp];
         WaveForm_1Q = [WaveForm_1Q; ...
            gmSEQ.halfpi+gmSEQ.LockN0*SingleLen_C+SpinLockGap, ...
            gmSEQ.halfpi+gmSEQ.LockN0*SingleLen_C+SpinLockGap+gmSEQ.halfpi, ...
             gSG.AWGFreq, ...
             2 * pi / 2 - pi / 2, ...
             gSG.AWGAmp];
                      
    elseif gmSEQ.CoolSwitch == 2
         WaveForm_1I = [WaveForm_1I; ...
            gmSEQ.halfpi+gmSEQ.LockN0*SingleLen_C+SpinLockGap, ...
            gmSEQ.halfpi+gmSEQ.LockN0*SingleLen_C+SpinLockGap+gmSEQ.halfpi, ...
             gSG.AWGFreq, ...
             0 * pi / 2, ...
             gSG.AWGAmp];
         WaveForm_1Q = [WaveForm_1Q; ...
            gmSEQ.halfpi+gmSEQ.LockN0*SingleLen_C+SpinLockGap, ...
            gmSEQ.halfpi+gmSEQ.LockN0*SingleLen_C+SpinLockGap+gmSEQ.halfpi, ...
             gSG.AWGFreq, ...
             0 * pi / 2 - pi / 2, ...
             gSG.AWGAmp];
        
    end
    
    WaveForm_1Length = ceil((gmSEQ.halfpi + LockLenCool + gmSEQ.halfpi + 1000) / (16 / gSG.AWGClockRate)) ...
        *(16 / gSG.AWGClockRate);
    WaveForm_1PointNum = WaveForm_1Length * gSG.AWGClockRate;
    
%%%% Measuring Waveforms.    
    if gmSEQ.CoolSwitch <2 
        WaveForm_2I = [0, gmSEQ.halfpi, gSG.AWGFreq, 0, gSG.AWGAmp]; 
        WaveForm_2Q = [0, gmSEQ.halfpi, gSG.AWGFreq, -pi/2, gSG.AWGAmp];    
    elseif gmSEQ.CoolSwitch == 2
        WaveForm_2I = [0, gmSEQ.halfpi, gSG.AWGFreq, 0+0, gSG.AWGAmp]; 
        WaveForm_2Q = [0, gmSEQ.halfpi, gSG.AWGFreq, 0-pi/2, gSG.AWGAmp];    
    end

    for n = 1 : gmSEQ.m  % add segments of [t1(Omega_y) -> t2(-Omega_y)]
        WaveForm_2I = [WaveForm_2I; ...
           gmSEQ.halfpi + (n - 1) * SingleLen_M + SpinLockGap, ...
               gmSEQ.halfpi + (n - 1) * SingleLen_M + SpinLockGap + gmSEQ.SLockT1_M, ...
               gSG.AWGFreq, ...
               pi / 2, gSG.AWGAmp * gmSEQ.SAmp1_M;...
           gmSEQ.halfpi + (n - 1) * SingleLen_M + SpinLockGap + gmSEQ.SLockT1_M + SpinLockGap, ...
               gmSEQ.halfpi + (n - 1) * SingleLen_M + SpinLockGap + gmSEQ.SLockT1_M + SpinLockGap + gmSEQ.SLockT2_M, ...
               gSG.AWGFreq, ...
               3 * pi / 2, ...
               gSG.AWGAmp * gmSEQ.SAmp2_M];
        WaveForm_2Q = [WaveForm_2Q; ...
           gmSEQ.halfpi + (n - 1) * SingleLen_M + SpinLockGap, ...
               gmSEQ.halfpi + (n - 1) * SingleLen_M + SpinLockGap + gmSEQ.SLockT1_M, ...
               gSG.AWGFreq, ...
               pi / 2 - pi / 2, gSG.AWGAmp*gmSEQ.SAmp1_M;...
           gmSEQ.halfpi + (n - 1) * SingleLen_M + SpinLockGap + gmSEQ.SLockT1_M + SpinLockGap, ...
               gmSEQ.halfpi + (n - 1) * SingleLen_M + SpinLockGap + gmSEQ.SLockT1_M + SpinLockGap + gmSEQ.SLockT2_M, ...
               gSG.AWGFreq, ...
               3 * pi / 2 - pi / 2, ...
               gSG.AWGAmp * gmSEQ.SAmp2_M];   
    end
    
    if gmSEQ.CoolSwitch <2 
    WaveForm_2I = [WaveForm_2I; ...
        gmSEQ.halfpi + gmSEQ.m * SingleLen_M + SpinLockGap, ...
            gmSEQ.halfpi + gmSEQ.m * SingleLen_M + SpinLockGap + gmSEQ.halfpi,...
            gSG.AWGFreq, ...
            2 * pi / 2, ...
            gSG.AWGAmp];
    WaveForm_2Q = [WaveForm_2Q; ...
        gmSEQ.halfpi + gmSEQ.m * SingleLen_M + SpinLockGap, ...
            gmSEQ.halfpi + gmSEQ.m * SingleLen_M + SpinLockGap + gmSEQ.halfpi,...
            gSG.AWGFreq, ...
            2 * pi / 2 - pi / 2, ...
            gSG.AWGAmp];
    elseif gmSEQ.CoolSwitch == 2
    WaveForm_2I = [WaveForm_2I; ...
        gmSEQ.halfpi + gmSEQ.m * SingleLen_M + SpinLockGap, ...
            gmSEQ.halfpi + gmSEQ.m * SingleLen_M + SpinLockGap + gmSEQ.halfpi,...
            gSG.AWGFreq, ...
            2 * pi / 2, ...
            gSG.AWGAmp];
    WaveForm_2Q = [WaveForm_2Q; ...
        gmSEQ.halfpi + gmSEQ.m * SingleLen_M + SpinLockGap, ...
            gmSEQ.halfpi + gmSEQ.m * SingleLen_M + SpinLockGap + gmSEQ.halfpi,...
            gSG.AWGFreq, ...
            2 * pi / 2 - pi / 2, ...
            gSG.AWGAmp];     
    end
    
%%%% Differential Measuring Waveforms. Just add another pi_y pulse at the
%%%% end.
    WaveForm_3I = [WaveForm_2I; ...
        gmSEQ.halfpi + gmSEQ.m * SingleLen_M + SpinLockGap + gmSEQ.halfpi + PulseGap, ...
            gmSEQ.halfpi + gmSEQ.m * SingleLen_M + SpinLockGap + gmSEQ.halfpi + PulseGap + gmSEQ.pi, ...
            gSG.AWGFreq, ...
            pi / 2, gSG.AWGAmp];
    WaveForm_3Q = [WaveForm_2Q; ...
        gmSEQ.halfpi + gmSEQ.m * SingleLen_M + SpinLockGap + gmSEQ.halfpi + PulseGap, ...
            gmSEQ.halfpi + gmSEQ.m * SingleLen_M + SpinLockGap + gmSEQ.halfpi + PulseGap + gmSEQ.pi, ...
            gSG.AWGFreq, ...
            pi / 2 - pi / 2, gSG.AWGAmp]; 
    
    WaveForm_2Length = ceil((gmSEQ.halfpi + LockLenMeasure + SpinLockGap + gmSEQ.halfpi + PulseGap + gmSEQ.pi + 1000) / (16 / gSG.AWGClockRate)) ...
        * (16 / gSG.AWGClockRate);
    WaveForm_2PointNum = WaveForm_2Length * gSG.AWGClockRate;
    WaveForm_3Length = WaveForm_2Length;
    WaveForm_3PointNum = WaveForm_2PointNum;
    
    % NV pulse to mix up NV
     WaveForm_4I = [0, gmSEQ.halfpi, gSG.AWGFreq, 0, gSG.AWGAmp; ...
         10000, 10000+gmSEQ.halfpi,  gSG.AWGFreq, 0, gSG.AWGAmp; ...
         20000, 20000+gmSEQ.halfpi,  gSG.AWGFreq, 0, gSG.AWGAmp; ...
         30000, 30000+gmSEQ.halfpi,  gSG.AWGFreq, 0, gSG.AWGAmp];
     WaveForm_4Q = [0, gmSEQ.halfpi, gSG.AWGFreq, -pi/2, gSG.AWGAmp; ...
         10000, 10000+gmSEQ.halfpi,  gSG.AWGFreq, -pi/2, gSG.AWGAmp; ...
         20000, 20000+gmSEQ.halfpi,  gSG.AWGFreq, -pi/2, gSG.AWGAmp; ...
         30000, 30000+gmSEQ.halfpi,  gSG.AWGFreq, -pi/2, gSG.AWGAmp];
    
    WaveForm_4Length = ceil((30000+gmSEQ.halfpi+1000) / (16 / gSG.AWGClockRate)) ...
        * (16 / gSG.AWGClockRate);
    WaveForm_4PointNum = WaveForm_4Length * gSG.AWGClockRate;
    
    
else
    questdlg('Only AC mnodulation works for now, please check AC modulation~',...
        'Heating / Cooling Sequence', 'Cancel');
end
%%% Create Wave Form Text Files
chaseFunctionPool('createWaveform', WaveForm_1I, gSG.AWGClockRate, WaveForm_1Length, 'SpecialCooling_I_seg1.txt'); pause(0.5);
chaseFunctionPool('createWaveform', WaveForm_1Q, gSG.AWGClockRate, WaveForm_1Length, 'SpecialCooling_Q_seg1.txt'); pause(0.5);
chaseFunctionPool('createWaveform', WaveForm_2I, gSG.AWGClockRate, WaveForm_2Length, 'SpecialCooling_I_seg2.txt'); pause(0.5);
chaseFunctionPool('createWaveform', WaveForm_2Q, gSG.AWGClockRate, WaveForm_2Length, 'SpecialCooling_Q_seg2.txt'); pause(0.5);
chaseFunctionPool('createWaveform', WaveForm_3I, gSG.AWGClockRate, WaveForm_3Length, 'SpecialCooling_I_seg3.txt'); pause(0.5);
chaseFunctionPool('createWaveform', WaveForm_3Q, gSG.AWGClockRate, WaveForm_3Length, 'SpecialCooling_Q_seg3.txt'); pause(0.5);
chaseFunctionPool('createWaveform', WaveForm_4I, gSG.AWGClockRate, WaveForm_4Length, 'SpecialCooling_I_seg4.txt'); pause(0.5);
chaseFunctionPool('createWaveform', WaveForm_4Q, gSG.AWGClockRate, WaveForm_4Length, 'SpecialCooling_Q_seg4.txt'); pause(0.5);

%%% Create Wave Form Structs -> Pass Segments to AWG
if gmSEQ.CoolCycle == 0
    chaseFunctionPool('createSegStruct', 'SpecialCooling_SegStruct_I.txt', ...
        'SpecialCooling_I_seg4.txt', WaveForm_4PointNum, 1, 1, ...
        'SpecialCooling_I_seg2.txt', WaveForm_2PointNum, 1, 1, ...
        'SpecialCooling_I_seg4.txt', WaveForm_4PointNum, 1, 1, ...
        'SpecialCooling_I_seg3.txt', WaveForm_3PointNum, 1, 1);
    pause(0.5);
    chaseFunctionPool('createSegStruct', 'SpecialCooling_SegStruct_Q.txt', ...
        'SpecialCooling_Q_seg4.txt', WaveForm_4PointNum, 1, 1, ...
        'SpecialCooling_Q_seg2.txt', WaveForm_2PointNum, 1, 1, ...
        'SpecialCooling_Q_seg4.txt', WaveForm_4PointNum, 1, 1, ...
        'SpecialCooling_Q_seg3.txt', WaveForm_3PointNum, 1, 1);
    pause(0.5);
    chaseFunctionPool('CreateSegments', 1, 1, ...
        4, ...
        2047, 2047, 'SpecialCooling_SegStruct_I.txt', 'false');
    pause(1); % this pause seems to be important, otherwise the loading is not right occassionally
    chaseFunctionPool('CreateSegments', 1, 2, ...
        4, ...
        2047, 2047, 'SpecialCooling_SegStruct_Q.txt', 'false');
    pause(1); % this pause seems to be important, otherwise the loading is not right occassionally
    chaseFunctionPool('runChase', 1, 'false');
elseif gmSEQ.CoolCycle == 1
    chaseFunctionPool('createSegStruct', 'SpecialCooling_SegStruct_I.txt', ...
        'SpecialCooling_I_seg4.txt', WaveForm_4PointNum, 1, 1, ...
        'SpecialCooling_I_seg1.txt', WaveForm_1PointNum, 1, 1, ...
        'SpecialCooling_I_seg2.txt', WaveForm_2PointNum, 1, 1, ...
        'SpecialCooling_I_seg4.txt', WaveForm_4PointNum, 1, 1, ...
        'SpecialCooling_I_seg1.txt', WaveForm_1PointNum, 1, 1, ...
        'SpecialCooling_I_seg3.txt', WaveForm_3PointNum, 1, 1);
    pause(0.5);
    chaseFunctionPool('createSegStruct', 'SpecialCooling_SegStruct_Q.txt', ...
        'SpecialCooling_Q_seg4.txt', WaveForm_4PointNum, 1, 1, ...
        'SpecialCooling_Q_seg1.txt', WaveForm_1PointNum, 1, 1, ...
        'SpecialCooling_Q_seg2.txt', WaveForm_2PointNum, 1, 1, ...
        'SpecialCooling_Q_seg4.txt', WaveForm_4PointNum, 1, 1, ...
        'SpecialCooling_Q_seg1.txt', WaveForm_1PointNum, 1, 1, ...
        'SpecialCooling_Q_seg3.txt', WaveForm_3PointNum, 1, 1);
    pause(0.5);
    chaseFunctionPool('CreateSegments', 1, 1, ...
        6, ...
        2047, 2047, 'SpecialCooling_SegStruct_I.txt', 'false');
    pause(1); % this pause seems to be important, otherwise the loading is not right occassionally
    chaseFunctionPool('CreateSegments', 1, 2, ...
        6, ...
        2047, 2047, 'SpecialCooling_SegStruct_Q.txt', 'false');
    pause(1); % this pause seems to be important, otherwise the loading is not right occassionally
    chaseFunctionPool('runChase', 1, 'false');
elseif gmSEQ.CoolCycle < 500
chaseFunctionPool('createSegStruct', 'SpecialCooling_SegStruct_I.txt', ...
    'SpecialCooling_I_seg4.txt', WaveForm_4PointNum, 1, 1, ...
    'SpecialCooling_I_seg1.txt', WaveForm_1PointNum, 1, 1, ... % The first repeatition cannot be looped and must be triggered, so must be left out.
    'SpecialCooling_I_seg1.txt', WaveForm_1PointNum, gmSEQ.CoolCycle - 1, 1, ...
    'SpecialCooling_I_seg2.txt', WaveForm_2PointNum, 1, 1, ...
    'SpecialCooling_I_seg4.txt', WaveForm_4PointNum, 1, 1, ...
    'SpecialCooling_I_seg1.txt', WaveForm_1PointNum, 1, 1, ... % This one just to make sure things are symmetric.
    'SpecialCooling_I_seg1.txt', WaveForm_1PointNum, gmSEQ.CoolCycle - 1, 1, ...
    'SpecialCooling_I_seg3.txt', WaveForm_3PointNum, 1, 1);
pause(0.5);
chaseFunctionPool('createSegStruct', 'SpecialCooling_SegStruct_Q.txt', ...
    'SpecialCooling_Q_seg4.txt', WaveForm_4PointNum, 1, 1, ...
    'SpecialCooling_Q_seg1.txt', WaveForm_1PointNum, 1, 1, ... 
    'SpecialCooling_Q_seg1.txt', WaveForm_1PointNum, gmSEQ.CoolCycle - 1, 1, ...
    'SpecialCooling_Q_seg2.txt', WaveForm_2PointNum, 1, 1, ...
    'SpecialCooling_Q_seg4.txt', WaveForm_4PointNum, 1, 1, ...
    'SpecialCooling_Q_seg1.txt', WaveForm_1PointNum, 1, 1, ...
    'SpecialCooling_Q_seg1.txt', WaveForm_1PointNum, gmSEQ.CoolCycle - 1, 1, ...
    'SpecialCooling_Q_seg3.txt', WaveForm_3PointNum, 1, 1);
pause(0.5);    
chaseFunctionPool('CreateSegments', 1, 1, ...
    8, ...
    2047, 2047, 'SpecialCooling_SegStruct_I.txt', 'false');
pause(3); % this pause seems to be important, otherwise the loading is not right occassionally
chaseFunctionPool('CreateSegments', 1, 2, ...
    8, ...
    2047, 2047, 'SpecialCooling_SegStruct_Q.txt', 'false');
pause(3); % this pause seems to be important, otherwise the loading is not right occassionally
%%% Run AWG.
chaseFunctionPool('runChase', 1, 'false');

% else
%     chaseFunctionPool('createSegStruct', 'SpecialCooling_SegStruct_I.txt', ...
%     'SpecialCooling_I_seg1.txt', WaveForm_1PointNum, 1, 1, ... % The first repeatition cannot be looped and must be triggered, so must be left out.
%     'SpecialCooling_I_seg1.txt', WaveForm_1PointNum, 300, 1, ...
%     'SpecialCooling_I_seg1.txt', WaveForm_1PointNum, gmSEQ.CoolCycle-300-1, 1, ...
%     'SpecialCooling_I_seg2.txt', WaveForm_2PointNum, 1, 1, ...
%     'SpecialCooling_I_seg1.txt', WaveForm_1PointNum, 1, 1, ... % This one just to make sure things are symmetric.
%     'SpecialCooling_I_seg1.txt', WaveForm_1PointNum, 300, 1, ...
%     'SpecialCooling_I_seg1.txt', WaveForm_1PointNum, gmSEQ.CoolCycle-300-1, 1, ...
%     'SpecialCooling_I_seg3.txt', WaveForm_3PointNum, 1, 1);
% pause(0.5);
% chaseFunctionPool('createSegStruct', 'SpecialCooling_SegStruct_Q.txt', ...
%     'SpecialCooling_Q_seg1.txt', WaveForm_1PointNum, 1, 1, ... 
%     'SpecialCooling_Q_seg1.txt', WaveForm_1PointNum, 300, 1, ...
%     'SpecialCooling_Q_seg1.txt', WaveForm_1PointNum, gmSEQ.CoolCycle-300-1, 1, ...
%     'SpecialCooling_Q_seg2.txt', WaveForm_2PointNum, 1, 1, ...
%     'SpecialCooling_Q_seg1.txt', WaveForm_1PointNum, 1, 1, ...
%     'SpecialCooling_Q_seg1.txt', WaveForm_1PointNum, 300, 1, ...
%     'SpecialCooling_Q_seg1.txt', WaveForm_1PointNum, gmSEQ.CoolCycle-300-1, 1, ...
%     'SpecialCooling_Q_seg3.txt', WaveForm_3PointNum, 1, 1);
% pause(0.5);    
% chaseFunctionPool('CreateSegments', 1, 1, ...
%     8, ...
%     2047, 2047, 'SpecialCooling_SegStruct_I.txt', 'false');
% pause(3); % this pause seems to be important, otherwise the loading is not right occassionally
% chaseFunctionPool('CreateSegments', 1, 2, ...
%     8, ...
%     2047, 2047, 'SpecialCooling_SegStruct_Q.txt', 'false');
% pause(3); % this pause seems to be important, otherwise the loading is not right occassionally
% %%% Run AWG.
% chaseFunctionPool('runChase', 1, 'false');
end
ApplyDelays();    

function SpecialCooling_WaitLaser
global gmSEQ gSG
gSG.bfixedPow = 1;
gSG.bfixedFreq = 1;
gSG.bMod = 'IQ';
gSG.bModSrc = 'External';

% If PL signal is collected via APD.
if strcmp(gmSEQ.meas,'APD') 
    gmSEQ.CtrGateDur = 1000;
end

% Cooling sequence [pi/2_x->[t1(Omega_y) -> t2(-Omega_y)]^{N_0}]^{Cooling cycle}...

gmSEQ.halfpi = gmSEQ.pi/2;
Wait_p = 20e6; % to wait for P1 to be fully unpolarized again
AfterPi = 1000;
AfterLaser = 2000;
Detect_Window = 15000;
PulseGap = 30;
SpinLockGap = 0; % The gap (in ns) between t1(Omega) and t2(-Omega).

SingleLen_C = 2 * SpinLockGap + gmSEQ.SLockT1 + gmSEQ.SLockT2; % Length of cooling segment [t1(Omega_y) -> t2(-Omega_y)]
LockLenCool = gmSEQ.LockN0 * SingleLen_C;

SingleLen_M = 1*(2*SpinLockGap+gmSEQ.SLockT1_M + gmSEQ.SLockT2_M); % Length of measuring segment [t1(Omega_y) -> t2(-Omega_y)]
LockLenMeasure = gmSEQ.m * SingleLen_M;

AfterLock = 1000;
% Cooling_Readout = gmSEQ.readout;
Cooling_Readout = 1000;

CoolCycleT = Cooling_Readout + AfterLaser + gmSEQ.halfpi + LockLenCool + gmSEQ.halfpi + AfterLock;
CoolCycleT = ceil(CoolCycleT * gSG.AWGClockRate / 16) / (gSG.AWGClockRate / 16);

%% Pulse Blaster
%%% AOM
% Cooling
gmSEQ.CHN(1).PBN=PBDictionary('AOM');
gmSEQ.CHN(1).NRise = 2 * (2 + gmSEQ.CoolCycle)+2;
    gmSEQ.CHN(1).T = [];
    gmSEQ.CHN(1).DT = [];
    for n = 1 : gmSEQ.CoolCycle
        gmSEQ.CHN(1).T = [gmSEQ.CHN(1).T, Wait_p + (n - 1) * CoolCycleT];
        gmSEQ.CHN(1).DT = [gmSEQ.CHN(1).DT, Cooling_Readout];
    end
        
% Cooling - Measurement
    gmSEQ.CHN(1).T = [gmSEQ.CHN(1).T, ...
        Wait_p + gmSEQ.CoolCycle * CoolCycleT, ...
        Wait_p + gmSEQ.CoolCycle * CoolCycleT + gmSEQ.CoolWait, ...
        Wait_p + gmSEQ.CoolCycle * CoolCycleT + gmSEQ.CoolWait ...
            + gmSEQ.readout + AfterLaser + gmSEQ.halfpi + LockLenMeasure ...
            + SpinLockGap + gmSEQ.halfpi + PulseGap + gmSEQ.pi+ AfterPi];
    gmSEQ.CHN(1).DT = [gmSEQ.CHN(1).DT, gmSEQ.CoolWait, gmSEQ.readout, Detect_Window]; 
% Differential Cooling
    Start_Sig_D = Wait_p + gmSEQ.CoolCycle * CoolCycleT + gmSEQ.CoolWait ...
        + gmSEQ.readout + AfterLaser + gmSEQ.halfpi + LockLenMeasure ...
        + SpinLockGap + gmSEQ.halfpi + PulseGap + gmSEQ.pi + AfterPi ...
        + Detect_Window + Wait_p;
    for n = 1 : gmSEQ.CoolCycle
        gmSEQ.CHN(1).T = [gmSEQ.CHN(1).T, Start_Sig_D + (n - 1) * CoolCycleT];
        gmSEQ.CHN(1).DT = [gmSEQ.CHN(1).DT, Cooling_Readout];
    end
% Differential Cooling - Measurement
    gmSEQ.CHN(1).T = [gmSEQ.CHN(1).T, ...
        Start_Sig_D + gmSEQ.CoolCycle * CoolCycleT, ...
        Start_Sig_D + gmSEQ.CoolCycle * CoolCycleT + gmSEQ.CoolWait, ...
        Start_Sig_D + gmSEQ.CoolCycle  *CoolCycleT + gmSEQ.CoolWait ...
            + gmSEQ.readout + AfterLaser + gmSEQ.halfpi + LockLenMeasure ...
            + SpinLockGap + gmSEQ.halfpi + PulseGap + gmSEQ.pi + AfterPi];
    gmSEQ.CHN(1).DT = [gmSEQ.CHN(1).DT, gmSEQ.CoolWait, gmSEQ.readout, Detect_Window];

%%% APD
% gmSEQ.CHN(numel(gmSEQ.CHN)+1).PBN=PBDictionary('ctr0');
% gmSEQ.CHN(numel(gmSEQ.CHN)).NRise = 4;
% gmSEQ.CHN(numel(gmSEQ.CHN)).T = [gmSEQ.CHN(1).T(gmSEQ.CoolCycle + 1) + gmSEQ.readout - 1000, ...
%     gmSEQ.CHN(1).T(gmSEQ.CoolCycle + 2), ...
%     gmSEQ.CHN(1).T(2 * gmSEQ.CoolCycle + 3) + gmSEQ.readout - 1000, ...
%     gmSEQ.CHN(1).T(2 * gmSEQ.CoolCycle + 4)];
% gmSEQ.CHN(numel(gmSEQ.CHN)).DT = repelem(gmSEQ.CtrGateDur, 1, 4);

gmSEQ.CHN(numel(gmSEQ.CHN)+1).PBN=PBDictionary('ctr0');
gmSEQ.CHN(numel(gmSEQ.CHN)).NRise = 4;
gmSEQ.CHN(numel(gmSEQ.CHN)).T = [gmSEQ.CHN(1).T(gmSEQ.CoolCycle + 2 + 1), ...
    gmSEQ.CHN(1).T(gmSEQ.CoolCycle + 2 + 1)+Detect_Window-1000-gmSEQ.CtrGateDur, ...
    gmSEQ.CHN(1).T(2 * gmSEQ.CoolCycle + 4 + 2), ...
    gmSEQ.CHN(1).T(2 * gmSEQ.CoolCycle + 4 + 2)+Detect_Window-1000-gmSEQ.CtrGateDur];
gmSEQ.CHN(numel(gmSEQ.CHN)).DT = repelem(gmSEQ.CtrGateDur, 1, 4);

% Note that for sequence length ~ 2ms / 20ms, the timing difference between
% PulseBlaster and AWG is ~ 10ns / 100ns

% MW Switch
% Cooling -> Cooling - Measurement
gmSEQ.CHN(numel(gmSEQ.CHN) + 1).PBN=PBDictionary('MWSwitch');
gmSEQ.CHN(numel(gmSEQ.CHN)).NRise= 2 + 2 * gmSEQ.CoolCycle + 8;
gmSEQ.CHN(numel(gmSEQ.CHN)).T = [10000-30 20000-30 30000-30 40000-30];
gmSEQ.CHN(numel(gmSEQ.CHN)).DT = [gmSEQ.halfpi+54 gmSEQ.halfpi+54 gmSEQ.halfpi+54 gmSEQ.halfpi+54];
for n = 1 : gmSEQ.CoolCycle
    gmSEQ.CHN(numel(gmSEQ.CHN)).T = [gmSEQ.CHN(numel(gmSEQ.CHN)).T, ...
        Wait_p + (n - 1) * CoolCycleT + Cooling_Readout + AfterLaser - 30]; % double the buffer around IQ.
    gmSEQ.CHN(numel(gmSEQ.CHN)).DT = [gmSEQ.CHN(numel(gmSEQ.CHN)).DT, ...
        gmSEQ.halfpi + LockLenCool + gmSEQ.halfpi + 54];
end
gmSEQ.CHN(numel(gmSEQ.CHN)).T = [gmSEQ.CHN(numel(gmSEQ.CHN)).T, ...
    Wait_p + gmSEQ.CoolCycle * CoolCycleT + gmSEQ.CoolWait + gmSEQ.readout + AfterLaser - 30];
gmSEQ.CHN(numel(gmSEQ.CHN)).DT = [gmSEQ.CHN(numel(gmSEQ.CHN)).DT, ...
    gmSEQ.halfpi + LockLenMeasure + SpinLockGap + gmSEQ.halfpi + 54];
% Differential Cooling -> Differential Cooling - Measurement


gmSEQ.CHN(numel(gmSEQ.CHN)).T = [gmSEQ.CHN(numel(gmSEQ.CHN)).T, ...
    Start_Sig_D-Wait_p+10000-30 Start_Sig_D-Wait_p+20000-30 Start_Sig_D-Wait_p+30000-30 Start_Sig_D-Wait_p+40000-30];
gmSEQ.CHN(numel(gmSEQ.CHN)).DT = [gmSEQ.CHN(numel(gmSEQ.CHN)).DT gmSEQ.halfpi+54 gmSEQ.halfpi+54 gmSEQ.halfpi+54 gmSEQ.halfpi+54];

for n = 1 : gmSEQ.CoolCycle
    gmSEQ.CHN(numel(gmSEQ.CHN)).T = [gmSEQ.CHN(numel(gmSEQ.CHN)).T, ...
        Start_Sig_D + (n - 1) * CoolCycleT + Cooling_Readout + AfterLaser - 30];
    gmSEQ.CHN(numel(gmSEQ.CHN)).DT = [gmSEQ.CHN(numel(gmSEQ.CHN)).DT, ...
        gmSEQ.halfpi + LockLenCool + gmSEQ.halfpi + 54];
end
gmSEQ.CHN(numel(gmSEQ.CHN)).T = [gmSEQ.CHN(numel(gmSEQ.CHN)).T, ...
    Start_Sig_D + gmSEQ.CoolCycle * CoolCycleT + gmSEQ.CoolWait + gmSEQ.readout + AfterLaser - 30];
gmSEQ.CHN(numel(gmSEQ.CHN)).DT = [gmSEQ.CHN(numel(gmSEQ.CHN)).DT, ...
    gmSEQ.halfpi + LockLenMeasure + SpinLockGap + gmSEQ.halfpi + PulseGap + gmSEQ.pi + 54];


%%% Dummy 1: to check the total length of the sequence.
Max_length = 2 * Wait_p + 2 * gmSEQ.CoolCycle * CoolCycleT ...
    + 2 * gmSEQ.CoolWait + 2 * gmSEQ.readout + 2 * Detect_Window ...
    + 2 * (AfterLaser + AfterPi + gmSEQ.halfpi + LockLenMeasure + SpinLockGap + gmSEQ.halfpi + PulseGap + gmSEQ.pi);
gmSEQ.CHN(numel(gmSEQ.CHN) + 1).PBN = PBDictionary('dummy1');
gmSEQ.CHN(numel(gmSEQ.CHN)).NRise = 2;
gmSEQ.CHN(numel(gmSEQ.CHN)).T = [0, Max_length-200];
gmSEQ.CHN(numel(gmSEQ.CHN)).DT = [200, 200];

%%% AWG Trigger
% Each repeatition of the segement need one trigger, a total of 2 *
% (CoolCycle + 1) triggers are needed.
% Cooling -> Cooling - Measurement
gmSEQ.CHN(numel(gmSEQ.CHN)+1).PBN = PBDictionary('AWGTrig');
gmSEQ.CHN(numel(gmSEQ.CHN)).NRise = 2 + 2 + gmSEQ.CoolCycle * 2;
gmSEQ.CHN(numel(gmSEQ.CHN)).T = [10000];
gmSEQ.CHN(numel(gmSEQ.CHN)).DT = [1000];
for n = 1 : gmSEQ.CoolCycle
gmSEQ.CHN(numel(gmSEQ.CHN)).T = [gmSEQ.CHN(numel(gmSEQ.CHN)).T, ... 
    Wait_p + (n - 1) * CoolCycleT + Cooling_Readout + AfterLaser];
gmSEQ.CHN(numel(gmSEQ.CHN)).DT = [gmSEQ.CHN(numel(gmSEQ.CHN)).DT, 500];
end

gmSEQ.CHN(numel(gmSEQ.CHN)).T = [gmSEQ.CHN(numel(gmSEQ.CHN)).T, ...
    Wait_p + gmSEQ.CoolCycle * CoolCycleT + gmSEQ.CoolWait + gmSEQ.readout + AfterLaser];
gmSEQ.CHN(numel(gmSEQ.CHN)).DT=[gmSEQ.CHN(numel(gmSEQ.CHN)).DT, 500];

gmSEQ.CHN(numel(gmSEQ.CHN)).T = [gmSEQ.CHN(numel(gmSEQ.CHN)).T, ...
    Start_Sig_D-Wait_p+10000];
gmSEQ.CHN(numel(gmSEQ.CHN)).DT=[gmSEQ.CHN(numel(gmSEQ.CHN)).DT, 1000];

% Differential Cooling -> Differential Cooling - Measurement
for n = 1:gmSEQ.CoolCycle
gmSEQ.CHN(numel(gmSEQ.CHN)).T = [gmSEQ.CHN(numel(gmSEQ.CHN)).T, ...
    Start_Sig_D + (n - 1) * CoolCycleT + Cooling_Readout + AfterLaser];
gmSEQ.CHN(numel(gmSEQ.CHN)).DT = [gmSEQ.CHN(numel(gmSEQ.CHN)).DT, 500];
end
gmSEQ.CHN(numel(gmSEQ.CHN)).T = [gmSEQ.CHN(numel(gmSEQ.CHN)).T, ...
    Start_Sig_D + gmSEQ.CoolCycle * CoolCycleT + gmSEQ.CoolWait + gmSEQ.readout + AfterLaser];
gmSEQ.CHN(numel(gmSEQ.CHN)).DT = [gmSEQ.CHN(numel(gmSEQ.CHN)).DT, 500]; 

%% AWG
%%% Initialization
chaseFunctionPool('stopChase', 1)
%%% Generating wave form
if gSG.ACmodAWG 
    WaveForm_1I = [];
    WaveForm_1Q = [];
%%%% Cooling / Heating Waveforms.
% |gmSEQ.CoolSwitch| controls whether cooling / heating is turned on. 
    if gmSEQ.CoolSwitch == 1 % Cooling
        WaveForm_1I = [WaveForm_1I; ...
            0, gmSEQ.halfpi, gSG.AWGFreq, 0, gSG.AWGAmp]; % The 1st pi/2_x pulse.
        WaveForm_1Q = [WaveForm_1Q; ...
            0, gmSEQ.halfpi, gSG.AWGFreq, - pi / 2, gSG.AWGAmp];
    elseif gmSEQ.CoolSwitch == 2 % Heating
        WaveForm_1I = [WaveForm_1I; ...
            0, gmSEQ.halfpi, gSG.AWGFreq, pi, gSG.AWGAmp];
        WaveForm_1Q = [WaveForm_1Q; ...
            0, gmSEQ.halfpi, gSG.AWGFreq, pi - pi / 2, gSG.AWGAmp];
    elseif gmSEQ.CoolSwitch == 0 % Nothing
        WaveForm_1I = [WaveForm_1I; ...
            0, gmSEQ.halfpi, 0, 0, 0];
        WaveForm_1Q = [WaveForm_1Q; ...
            0, gmSEQ.halfpi, 0, 0, 0];
    end
    
    for n = 1 : gmSEQ.LockN0 % add segments of [t1(Omega_y) -> t2(-Omega_y)]
       WaveForm_1I = [WaveForm_1I; ...
           gmSEQ.halfpi + (n - 1) * SingleLen_C + SpinLockGap, ...
               gmSEQ.halfpi + (n - 1) * SingleLen_C + SpinLockGap + gmSEQ.SLockT1, ...
               gSG.AWGFreq, ...
               pi / 2, ...
               gSG.AWGAmp * gmSEQ.SAmp1; ...
           gmSEQ.halfpi + (n - 1) * SingleLen_C + SpinLockGap + gmSEQ.SLockT1 + SpinLockGap, ...
               gmSEQ.halfpi + (n - 1) * SingleLen_C + SpinLockGap + gmSEQ.SLockT1 + SpinLockGap + gmSEQ.SLockT2, ...
               gSG.AWGFreq, ...
               3 * pi / 2, ...
               gSG.AWGAmp * gmSEQ.SAmp2];
       WaveForm_1Q = [WaveForm_1Q; ...
           gmSEQ.halfpi + (n - 1) * SingleLen_C + SpinLockGap, ...
               gmSEQ.halfpi + (n - 1) * SingleLen_C + SpinLockGap + gmSEQ.SLockT1, ...
               gSG.AWGFreq, ...
               pi / 2 - pi / 2, ...
               gSG.AWGAmp * gmSEQ.SAmp1; ...
           gmSEQ.halfpi + (n - 1) * SingleLen_C + SpinLockGap + gmSEQ.SLockT1 + SpinLockGap, ...
               gmSEQ.halfpi + (n - 1) * SingleLen_C + SpinLockGap + gmSEQ.SLockT1 + SpinLockGap + gmSEQ.SLockT2, ...
               gSG.AWGFreq, ...
               3 * pi / 2 - pi/2, ...
               gSG.AWGAmp * gmSEQ.SAmp2];     
    end
    
    if gmSEQ.CoolSwitch == 1
        WaveForm_1I = [WaveForm_1I; ...
            gmSEQ.halfpi+gmSEQ.LockN0*SingleLen_C+SpinLockGap, ...
            gmSEQ.halfpi+gmSEQ.LockN0*SingleLen_C+SpinLockGap+gmSEQ.halfpi, ...
             gSG.AWGFreq, ...
             2 * pi / 2, ...
             gSG.AWGAmp];
         WaveForm_1Q = [WaveForm_1Q; ...
            gmSEQ.halfpi+gmSEQ.LockN0*SingleLen_C+SpinLockGap, ...
            gmSEQ.halfpi+gmSEQ.LockN0*SingleLen_C+SpinLockGap+gmSEQ.halfpi, ...
             gSG.AWGFreq, ...
             2 * pi / 2 - pi / 2, ...
             gSG.AWGAmp];
                      
    elseif gmSEQ.CoolSwitch == 2
         WaveForm_1I = [WaveForm_1I; ...
            gmSEQ.halfpi+gmSEQ.LockN0*SingleLen_C+SpinLockGap, ...
            gmSEQ.halfpi+gmSEQ.LockN0*SingleLen_C+SpinLockGap+gmSEQ.halfpi, ...
             gSG.AWGFreq, ...
             0 * pi / 2, ...
             gSG.AWGAmp];
         WaveForm_1Q = [WaveForm_1Q; ...
            gmSEQ.halfpi+gmSEQ.LockN0*SingleLen_C+SpinLockGap, ...
            gmSEQ.halfpi+gmSEQ.LockN0*SingleLen_C+SpinLockGap+gmSEQ.halfpi, ...
             gSG.AWGFreq, ...
             0 * pi / 2 - pi / 2, ...
             gSG.AWGAmp];
        
    end
    
    WaveForm_1Length = ceil((gmSEQ.halfpi + LockLenCool + gmSEQ.halfpi + 1000) / (16 / gSG.AWGClockRate)) ...
        *(16 / gSG.AWGClockRate);
    WaveForm_1PointNum = WaveForm_1Length * gSG.AWGClockRate;
    
%%%% Measuring Waveforms.    
    if gmSEQ.CoolSwitch <2 
        WaveForm_2I = [0, gmSEQ.halfpi, gSG.AWGFreq, 0, gSG.AWGAmp]; 
        WaveForm_2Q = [0, gmSEQ.halfpi, gSG.AWGFreq, -pi/2, gSG.AWGAmp];    
    elseif gmSEQ.CoolSwitch == 2
        WaveForm_2I = [0, gmSEQ.halfpi, gSG.AWGFreq, 0+0, gSG.AWGAmp]; 
        WaveForm_2Q = [0, gmSEQ.halfpi, gSG.AWGFreq, 0-pi/2, gSG.AWGAmp];    
    end

    for n = 1 : gmSEQ.m  % add segments of [t1(Omega_y) -> t2(-Omega_y)]
        WaveForm_2I = [WaveForm_2I; ...
           gmSEQ.halfpi + (n - 1) * SingleLen_M + SpinLockGap, ...
               gmSEQ.halfpi + (n - 1) * SingleLen_M + SpinLockGap + gmSEQ.SLockT1_M, ...
               gSG.AWGFreq, ...
               pi / 2, gSG.AWGAmp * gmSEQ.SAmp1_M;...
           gmSEQ.halfpi + (n - 1) * SingleLen_M + SpinLockGap + gmSEQ.SLockT1_M + SpinLockGap, ...
               gmSEQ.halfpi + (n - 1) * SingleLen_M + SpinLockGap + gmSEQ.SLockT1_M + SpinLockGap + gmSEQ.SLockT2_M, ...
               gSG.AWGFreq, ...
               3 * pi / 2, ...
               gSG.AWGAmp * gmSEQ.SAmp2_M];
        WaveForm_2Q = [WaveForm_2Q; ...
           gmSEQ.halfpi + (n - 1) * SingleLen_M + SpinLockGap, ...
               gmSEQ.halfpi + (n - 1) * SingleLen_M + SpinLockGap + gmSEQ.SLockT1_M, ...
               gSG.AWGFreq, ...
               pi / 2 - pi / 2, gSG.AWGAmp*gmSEQ.SAmp1_M;...
           gmSEQ.halfpi + (n - 1) * SingleLen_M + SpinLockGap + gmSEQ.SLockT1_M + SpinLockGap, ...
               gmSEQ.halfpi + (n - 1) * SingleLen_M + SpinLockGap + gmSEQ.SLockT1_M + SpinLockGap + gmSEQ.SLockT2_M, ...
               gSG.AWGFreq, ...
               3 * pi / 2 - pi / 2, ...
               gSG.AWGAmp * gmSEQ.SAmp2_M];   
    end
    
    if gmSEQ.CoolSwitch <2 
    WaveForm_2I = [WaveForm_2I; ...
        gmSEQ.halfpi + gmSEQ.m * SingleLen_M + SpinLockGap, ...
            gmSEQ.halfpi + gmSEQ.m * SingleLen_M + SpinLockGap + gmSEQ.halfpi,...
            gSG.AWGFreq, ...
            2 * pi / 2, ...
            gSG.AWGAmp];
    WaveForm_2Q = [WaveForm_2Q; ...
        gmSEQ.halfpi + gmSEQ.m * SingleLen_M + SpinLockGap, ...
            gmSEQ.halfpi + gmSEQ.m * SingleLen_M + SpinLockGap + gmSEQ.halfpi,...
            gSG.AWGFreq, ...
            2 * pi / 2 - pi / 2, ...
            gSG.AWGAmp];
    elseif gmSEQ.CoolSwitch == 2
    WaveForm_2I = [WaveForm_2I; ...
        gmSEQ.halfpi + gmSEQ.m * SingleLen_M + SpinLockGap, ...
            gmSEQ.halfpi + gmSEQ.m * SingleLen_M + SpinLockGap + gmSEQ.halfpi,...
            gSG.AWGFreq, ...
            2 * pi / 2, ...
            gSG.AWGAmp];
    WaveForm_2Q = [WaveForm_2Q; ...
        gmSEQ.halfpi + gmSEQ.m * SingleLen_M + SpinLockGap, ...
            gmSEQ.halfpi + gmSEQ.m * SingleLen_M + SpinLockGap + gmSEQ.halfpi,...
            gSG.AWGFreq, ...
            2 * pi / 2 - pi / 2, ...
            gSG.AWGAmp];     
    end
    
%%%% Differential Measuring Waveforms. Just add another pi_y pulse at the
%%%% end.
    WaveForm_3I = [WaveForm_2I; ...
        gmSEQ.halfpi + gmSEQ.m * SingleLen_M + SpinLockGap + gmSEQ.halfpi + PulseGap, ...
            gmSEQ.halfpi + gmSEQ.m * SingleLen_M + SpinLockGap + gmSEQ.halfpi + PulseGap + gmSEQ.pi, ...
            gSG.AWGFreq, ...
            pi / 2, gSG.AWGAmp];
    WaveForm_3Q = [WaveForm_2Q; ...
        gmSEQ.halfpi + gmSEQ.m * SingleLen_M + SpinLockGap + gmSEQ.halfpi + PulseGap, ...
            gmSEQ.halfpi + gmSEQ.m * SingleLen_M + SpinLockGap + gmSEQ.halfpi + PulseGap + gmSEQ.pi, ...
            gSG.AWGFreq, ...
            pi / 2 - pi / 2, gSG.AWGAmp]; 
    
    WaveForm_2Length = ceil((gmSEQ.halfpi + LockLenMeasure + SpinLockGap + gmSEQ.halfpi + PulseGap + gmSEQ.pi + 1000) / (16 / gSG.AWGClockRate)) ...
        * (16 / gSG.AWGClockRate);
    WaveForm_2PointNum = WaveForm_2Length * gSG.AWGClockRate;
    WaveForm_3Length = WaveForm_2Length;
    WaveForm_3PointNum = WaveForm_2PointNum;
    
    % NV pulse to mix up NV
     WaveForm_4I = [0, gmSEQ.halfpi, gSG.AWGFreq, 0, gSG.AWGAmp; ...
         10000, 10000+gmSEQ.halfpi,  gSG.AWGFreq, 0, gSG.AWGAmp; ...
         20000, 20000+gmSEQ.halfpi,  gSG.AWGFreq, 0, gSG.AWGAmp; ...
         30000, 30000+gmSEQ.halfpi,  gSG.AWGFreq, 0, gSG.AWGAmp];
     WaveForm_4Q = [0, gmSEQ.halfpi, gSG.AWGFreq, -pi/2, gSG.AWGAmp; ...
         10000, 10000+gmSEQ.halfpi,  gSG.AWGFreq, -pi/2, gSG.AWGAmp; ...
         20000, 20000+gmSEQ.halfpi,  gSG.AWGFreq, -pi/2, gSG.AWGAmp; ...
         30000, 30000+gmSEQ.halfpi,  gSG.AWGFreq, -pi/2, gSG.AWGAmp];
    
    WaveForm_4Length = ceil((30000+gmSEQ.halfpi+1000) / (16 / gSG.AWGClockRate)) ...
        * (16 / gSG.AWGClockRate);
    WaveForm_4PointNum = WaveForm_4Length * gSG.AWGClockRate;
    
    
else
    questdlg('Only AC mnodulation works for now, please check AC modulation~',...
        'Heating / Cooling Sequence', 'Cancel');
end
%%% Create Wave Form Text Files
chaseFunctionPool('createWaveform', WaveForm_1I, gSG.AWGClockRate, WaveForm_1Length, 'SpecialCooling_I_seg1.txt'); pause(0.5);
chaseFunctionPool('createWaveform', WaveForm_1Q, gSG.AWGClockRate, WaveForm_1Length, 'SpecialCooling_Q_seg1.txt'); pause(0.5);
chaseFunctionPool('createWaveform', WaveForm_2I, gSG.AWGClockRate, WaveForm_2Length, 'SpecialCooling_I_seg2.txt'); pause(0.5);
chaseFunctionPool('createWaveform', WaveForm_2Q, gSG.AWGClockRate, WaveForm_2Length, 'SpecialCooling_Q_seg2.txt'); pause(0.5);
chaseFunctionPool('createWaveform', WaveForm_3I, gSG.AWGClockRate, WaveForm_3Length, 'SpecialCooling_I_seg3.txt'); pause(0.5);
chaseFunctionPool('createWaveform', WaveForm_3Q, gSG.AWGClockRate, WaveForm_3Length, 'SpecialCooling_Q_seg3.txt'); pause(0.5);
chaseFunctionPool('createWaveform', WaveForm_4I, gSG.AWGClockRate, WaveForm_4Length, 'SpecialCooling_I_seg4.txt'); pause(0.5);
chaseFunctionPool('createWaveform', WaveForm_4Q, gSG.AWGClockRate, WaveForm_4Length, 'SpecialCooling_Q_seg4.txt'); pause(0.5);

%%% Create Wave Form Structs -> Pass Segments to AWG
if gmSEQ.CoolCycle == 0
    chaseFunctionPool('createSegStruct', 'SpecialCooling_SegStruct_I.txt', ...
        'SpecialCooling_I_seg4.txt', WaveForm_4PointNum, 1, 1, ...
        'SpecialCooling_I_seg2.txt', WaveForm_2PointNum, 1, 1, ...
        'SpecialCooling_I_seg4.txt', WaveForm_4PointNum, 1, 1, ...
        'SpecialCooling_I_seg3.txt', WaveForm_3PointNum, 1, 1);
    pause(0.5);
    chaseFunctionPool('createSegStruct', 'SpecialCooling_SegStruct_Q.txt', ...
        'SpecialCooling_Q_seg4.txt', WaveForm_4PointNum, 1, 1, ...
        'SpecialCooling_Q_seg2.txt', WaveForm_2PointNum, 1, 1, ...
        'SpecialCooling_Q_seg4.txt', WaveForm_4PointNum, 1, 1, ...
        'SpecialCooling_Q_seg3.txt', WaveForm_3PointNum, 1, 1);
    pause(0.5);
    chaseFunctionPool('CreateSegments', 1, 1, ...
        4, ...
        2047, 2047, 'SpecialCooling_SegStruct_I.txt', 'false');
    pause(1); % this pause seems to be important, otherwise the loading is not right occassionally
    chaseFunctionPool('CreateSegments', 1, 2, ...
        4, ...
        2047, 2047, 'SpecialCooling_SegStruct_Q.txt', 'false');
    pause(1); % this pause seems to be important, otherwise the loading is not right occassionally
    chaseFunctionPool('runChase', 1, 'false');
elseif gmSEQ.CoolCycle == 1
    chaseFunctionPool('createSegStruct', 'SpecialCooling_SegStruct_I.txt', ...
        'SpecialCooling_I_seg4.txt', WaveForm_4PointNum, 1, 1, ...
        'SpecialCooling_I_seg1.txt', WaveForm_1PointNum, 1, 1, ...
        'SpecialCooling_I_seg2.txt', WaveForm_2PointNum, 1, 1, ...
        'SpecialCooling_I_seg4.txt', WaveForm_4PointNum, 1, 1, ...
        'SpecialCooling_I_seg1.txt', WaveForm_1PointNum, 1, 1, ...
        'SpecialCooling_I_seg3.txt', WaveForm_3PointNum, 1, 1);
    pause(0.5);
    chaseFunctionPool('createSegStruct', 'SpecialCooling_SegStruct_Q.txt', ...
        'SpecialCooling_Q_seg4.txt', WaveForm_4PointNum, 1, 1, ...
        'SpecialCooling_Q_seg1.txt', WaveForm_1PointNum, 1, 1, ...
        'SpecialCooling_Q_seg2.txt', WaveForm_2PointNum, 1, 1, ...
        'SpecialCooling_Q_seg4.txt', WaveForm_4PointNum, 1, 1, ...
        'SpecialCooling_Q_seg1.txt', WaveForm_1PointNum, 1, 1, ...
        'SpecialCooling_Q_seg3.txt', WaveForm_3PointNum, 1, 1);
    pause(0.5);
    chaseFunctionPool('CreateSegments', 1, 1, ...
        6, ...
        2047, 2047, 'SpecialCooling_SegStruct_I.txt', 'false');
    pause(1); % this pause seems to be important, otherwise the loading is not right occassionally
    chaseFunctionPool('CreateSegments', 1, 2, ...
        6, ...
        2047, 2047, 'SpecialCooling_SegStruct_Q.txt', 'false');
    pause(1); % this pause seems to be important, otherwise the loading is not right occassionally
    chaseFunctionPool('runChase', 1, 'false');
elseif gmSEQ.CoolCycle < 500
chaseFunctionPool('createSegStruct', 'SpecialCooling_SegStruct_I.txt', ...
    'SpecialCooling_I_seg4.txt', WaveForm_4PointNum, 1, 1, ...
    'SpecialCooling_I_seg1.txt', WaveForm_1PointNum, 1, 1, ... % The first repeatition cannot be looped and must be triggered, so must be left out.
    'SpecialCooling_I_seg1.txt', WaveForm_1PointNum, gmSEQ.CoolCycle - 1, 1, ...
    'SpecialCooling_I_seg2.txt', WaveForm_2PointNum, 1, 1, ...
    'SpecialCooling_I_seg4.txt', WaveForm_4PointNum, 1, 1, ...
    'SpecialCooling_I_seg1.txt', WaveForm_1PointNum, 1, 1, ... % This one just to make sure things are symmetric.
    'SpecialCooling_I_seg1.txt', WaveForm_1PointNum, gmSEQ.CoolCycle - 1, 1, ...
    'SpecialCooling_I_seg3.txt', WaveForm_3PointNum, 1, 1);
pause(0.5);
chaseFunctionPool('createSegStruct', 'SpecialCooling_SegStruct_Q.txt', ...
    'SpecialCooling_Q_seg4.txt', WaveForm_4PointNum, 1, 1, ...
    'SpecialCooling_Q_seg1.txt', WaveForm_1PointNum, 1, 1, ... 
    'SpecialCooling_Q_seg1.txt', WaveForm_1PointNum, gmSEQ.CoolCycle - 1, 1, ...
    'SpecialCooling_Q_seg2.txt', WaveForm_2PointNum, 1, 1, ...
    'SpecialCooling_Q_seg4.txt', WaveForm_4PointNum, 1, 1, ...
    'SpecialCooling_Q_seg1.txt', WaveForm_1PointNum, 1, 1, ...
    'SpecialCooling_Q_seg1.txt', WaveForm_1PointNum, gmSEQ.CoolCycle - 1, 1, ...
    'SpecialCooling_Q_seg3.txt', WaveForm_3PointNum, 1, 1);
pause(0.5);    
chaseFunctionPool('CreateSegments', 1, 1, ...
    8, ...
    2047, 2047, 'SpecialCooling_SegStruct_I.txt', 'false');
pause(3); % this pause seems to be important, otherwise the loading is not right occassionally
chaseFunctionPool('CreateSegments', 1, 2, ...
    8, ...
    2047, 2047, 'SpecialCooling_SegStruct_Q.txt', 'false');
pause(3); % this pause seems to be important, otherwise the loading is not right occassionally
%%% Run AWG.
chaseFunctionPool('runChase', 1, 'false');

% else
%     chaseFunctionPool('createSegStruct', 'SpecialCooling_SegStruct_I.txt', ...
%     'SpecialCooling_I_seg1.txt', WaveForm_1PointNum, 1, 1, ... % The first repeatition cannot be looped and must be triggered, so must be left out.
%     'SpecialCooling_I_seg1.txt', WaveForm_1PointNum, 300, 1, ...
%     'SpecialCooling_I_seg1.txt', WaveForm_1PointNum, gmSEQ.CoolCycle-300-1, 1, ...
%     'SpecialCooling_I_seg2.txt', WaveForm_2PointNum, 1, 1, ...
%     'SpecialCooling_I_seg1.txt', WaveForm_1PointNum, 1, 1, ... % This one just to make sure things are symmetric.
%     'SpecialCooling_I_seg1.txt', WaveForm_1PointNum, 300, 1, ...
%     'SpecialCooling_I_seg1.txt', WaveForm_1PointNum, gmSEQ.CoolCycle-300-1, 1, ...
%     'SpecialCooling_I_seg3.txt', WaveForm_3PointNum, 1, 1);
% pause(0.5);
% chaseFunctionPool('createSegStruct', 'SpecialCooling_SegStruct_Q.txt', ...
%     'SpecialCooling_Q_seg1.txt', WaveForm_1PointNum, 1, 1, ... 
%     'SpecialCooling_Q_seg1.txt', WaveForm_1PointNum, 300, 1, ...
%     'SpecialCooling_Q_seg1.txt', WaveForm_1PointNum, gmSEQ.CoolCycle-300-1, 1, ...
%     'SpecialCooling_Q_seg2.txt', WaveForm_2PointNum, 1, 1, ...
%     'SpecialCooling_Q_seg1.txt', WaveForm_1PointNum, 1, 1, ...
%     'SpecialCooling_Q_seg1.txt', WaveForm_1PointNum, 300, 1, ...
%     'SpecialCooling_Q_seg1.txt', WaveForm_1PointNum, gmSEQ.CoolCycle-300-1, 1, ...
%     'SpecialCooling_Q_seg3.txt', WaveForm_3PointNum, 1, 1);
% pause(0.5);    
% chaseFunctionPool('CreateSegments', 1, 1, ...
%     8, ...
%     2047, 2047, 'SpecialCooling_SegStruct_I.txt', 'false');
% pause(3); % this pause seems to be important, otherwise the loading is not right occassionally
% chaseFunctionPool('CreateSegments', 1, 2, ...
%     8, ...
%     2047, 2047, 'SpecialCooling_SegStruct_Q.txt', 'false');
% pause(3); % this pause seems to be important, otherwise the loading is not right occassionally
% %%% Run AWG.
% chaseFunctionPool('runChase', 1, 'false');
end
ApplyDelays();    

function SpecialCooling_2

% group every 20 Cycles of cooling, and then a t_wait, and then repeat 
% RepN = 20 cycles

global gmSEQ gSG
gSG.bfixedPow = 1;
gSG.bfixedFreq = 1;
gSG.bMod = 'IQ';
gSG.bModSrc = 'External';

% If PL signal is collected via APD.
if strcmp(gmSEQ.meas,'APD') 
    gmSEQ.CtrGateDur = 1000;
end

RepN = 20;

% Cooling sequence [pi/2_x->[t1(Omega_y) -> t2(-Omega_y)]^{N_0}]^{Cooling cycle}...

gmSEQ.halfpi = gmSEQ.pi/2;
Wait_p = 15e6; % to wait for P1 to be fully unpolarized again
AfterPi = 1000;
AfterLaser = 2000;
Detect_Window = 15000;
PulseGap = 30;
SpinLockGap = 0; % The gap (in ns) between t1(Omega) and t2(-Omega).

SingleLen_C = 2 * SpinLockGap + gmSEQ.SLockT1 + gmSEQ.SLockT2; % Length of cooling segment [t1(Omega_y) -> t2(-Omega_y)]
LockLenCool = gmSEQ.LockN0 * SingleLen_C;

SingleLen_M = 1*(2*SpinLockGap+gmSEQ.SLockT1_M + gmSEQ.SLockT2_M); % Length of measuring segment [t1(Omega_y) -> t2(-Omega_y)]
LockLenMeasure = gmSEQ.m * SingleLen_M;

AfterLock = 1000;
% Cooling_Readout = gmSEQ.readout;
Cooling_Readout = 1000;

CoolCycleT = Cooling_Readout + AfterLaser + gmSEQ.halfpi + LockLenCool + gmSEQ.halfpi + AfterLock;
CoolCycleT = ceil(CoolCycleT * gSG.AWGClockRate / 16) / (gSG.AWGClockRate / 16);

%% Pulse Blaster
%%% AOM
% Cooling
gmSEQ.CHN(1).PBN=PBDictionary('AOM');

gmSEQ.CHN(1).NRise = 2 * (2 + gmSEQ.CoolCycle);
    gmSEQ.CHN(1).T = [];
    gmSEQ.CHN(1).DT = [];
    
    
    for n = 1 : gmSEQ.CoolCycle
        gmSEQ.CHN(1).T = [gmSEQ.CHN(1).T, Wait_p + floor( (n-1) / RepN) * gmSEQ.CoolWait + (n - 1) * CoolCycleT];
        gmSEQ.CHN(1).DT = [gmSEQ.CHN(1).DT, Cooling_Readout];
    end
% Cooling - Measurement
    gmSEQ.CHN(1).T = [gmSEQ.CHN(1).T, ...
        Wait_p + floor(gmSEQ.CoolCycle/RepN) * gmSEQ.CoolWait + gmSEQ.CoolCycle * CoolCycleT, ...
        Wait_p + floor(gmSEQ.CoolCycle/RepN) * gmSEQ.CoolWait + gmSEQ.CoolCycle * CoolCycleT ...
            + gmSEQ.readout + AfterLaser + gmSEQ.halfpi + LockLenMeasure ...
            + SpinLockGap + gmSEQ.halfpi + PulseGap + gmSEQ.pi+ AfterPi];
    gmSEQ.CHN(1).DT = [gmSEQ.CHN(1).DT, gmSEQ.readout, Detect_Window]; 
% Differential Cooling
    Start_Sig_D = Wait_p + floor(gmSEQ.CoolCycle/RepN) * gmSEQ.CoolWait + gmSEQ.CoolCycle * CoolCycleT ...
        + gmSEQ.readout + AfterLaser + gmSEQ.halfpi + LockLenMeasure ...
        + SpinLockGap + gmSEQ.halfpi + PulseGap + gmSEQ.pi + AfterPi ...
        + Detect_Window + Wait_p;
    for n = 1 : gmSEQ.CoolCycle
        gmSEQ.CHN(1).T = [gmSEQ.CHN(1).T, Start_Sig_D + floor( (n-1) / RepN) * gmSEQ.CoolWait + (n - 1) * CoolCycleT];
        gmSEQ.CHN(1).DT = [gmSEQ.CHN(1).DT, Cooling_Readout];
    end
% Differential Cooling - Measurement
    gmSEQ.CHN(1).T = [gmSEQ.CHN(1).T, ...
        Start_Sig_D + floor(gmSEQ.CoolCycle/RepN) * gmSEQ.CoolWait + gmSEQ.CoolCycle * CoolCycleT, ...
        Start_Sig_D + floor(gmSEQ.CoolCycle/RepN) * gmSEQ.CoolWait + gmSEQ.CoolCycle * CoolCycleT ...
            + gmSEQ.readout + AfterLaser + gmSEQ.halfpi + LockLenMeasure ...
            + SpinLockGap + gmSEQ.halfpi + PulseGap + gmSEQ.pi + AfterPi];
    gmSEQ.CHN(1).DT = [gmSEQ.CHN(1).DT, gmSEQ.readout, Detect_Window];

%%% APD
% gmSEQ.CHN(numel(gmSEQ.CHN)+1).PBN=PBDictionary('ctr0');
% gmSEQ.CHN(numel(gmSEQ.CHN)).NRise = 4;
% gmSEQ.CHN(numel(gmSEQ.CHN)).T = [gmSEQ.CHN(1).T(gmSEQ.CoolCycle + 1) + gmSEQ.readout - 1000, ...
%     gmSEQ.CHN(1).T(gmSEQ.CoolCycle + 2), ...
%     gmSEQ.CHN(1).T(2 * gmSEQ.CoolCycle + 3) + gmSEQ.readout - 1000, ...
%     gmSEQ.CHN(1).T(2 * gmSEQ.CoolCycle + 4)];
% gmSEQ.CHN(numel(gmSEQ.CHN)).DT = repelem(gmSEQ.CtrGateDur, 1, 4);

gmSEQ.CHN(numel(gmSEQ.CHN)+1).PBN=PBDictionary('ctr0');
gmSEQ.CHN(numel(gmSEQ.CHN)).NRise = 4;
gmSEQ.CHN(numel(gmSEQ.CHN)).T = [gmSEQ.CHN(1).T(gmSEQ.CoolCycle + 2), ...
    gmSEQ.CHN(1).T(gmSEQ.CoolCycle + 2)+Detect_Window-1000-gmSEQ.CtrGateDur, ...
    gmSEQ.CHN(1).T(2 * gmSEQ.CoolCycle + 4), ...
    gmSEQ.CHN(1).T(2 * gmSEQ.CoolCycle + 4)+Detect_Window-1000-gmSEQ.CtrGateDur];
gmSEQ.CHN(numel(gmSEQ.CHN)).DT = repelem(gmSEQ.CtrGateDur, 1, 4);

% Note that for sequence length ~ 2ms / 20ms, the timing difference between
% PulseBlaster and AWG is ~ 10ns / 100ns

% MW Switch
% Cooling -> Cooling - Measurement
gmSEQ.CHN(numel(gmSEQ.CHN) + 1).PBN=PBDictionary('MWSwitch');
gmSEQ.CHN(numel(gmSEQ.CHN)).NRise= 2 + 2 * gmSEQ.CoolCycle + 8;
gmSEQ.CHN(numel(gmSEQ.CHN)).T = [10000-30 20000-30 30000-30 40000-30];
gmSEQ.CHN(numel(gmSEQ.CHN)).DT = [gmSEQ.halfpi+54 gmSEQ.halfpi+54 gmSEQ.halfpi+54 gmSEQ.halfpi+54];
for n = 1 : gmSEQ.CoolCycle
    gmSEQ.CHN(numel(gmSEQ.CHN)).T = [gmSEQ.CHN(numel(gmSEQ.CHN)).T, ...
        Wait_p + floor( (n-1) / RepN) * gmSEQ.CoolWait + (n - 1) * CoolCycleT + Cooling_Readout + AfterLaser - 30]; % double the buffer around IQ.
    gmSEQ.CHN(numel(gmSEQ.CHN)).DT = [gmSEQ.CHN(numel(gmSEQ.CHN)).DT, ...
        gmSEQ.halfpi + LockLenCool + gmSEQ.halfpi + 54];
end
gmSEQ.CHN(numel(gmSEQ.CHN)).T = [gmSEQ.CHN(numel(gmSEQ.CHN)).T, ...
    Wait_p +  floor( gmSEQ.CoolCycle / RepN) * gmSEQ.CoolWait + gmSEQ.CoolCycle * CoolCycleT + gmSEQ.readout + AfterLaser - 30];
gmSEQ.CHN(numel(gmSEQ.CHN)).DT = [gmSEQ.CHN(numel(gmSEQ.CHN)).DT, ...
    gmSEQ.halfpi + LockLenMeasure + SpinLockGap + gmSEQ.halfpi + 54];
% Differential Cooling -> Differential Cooling - Measurement


gmSEQ.CHN(numel(gmSEQ.CHN)).T = [gmSEQ.CHN(numel(gmSEQ.CHN)).T, ...
    Start_Sig_D-Wait_p+10000-30 Start_Sig_D-Wait_p+20000-30 Start_Sig_D-Wait_p+30000-30 Start_Sig_D-Wait_p+40000-30];
gmSEQ.CHN(numel(gmSEQ.CHN)).DT = [gmSEQ.CHN(numel(gmSEQ.CHN)).DT gmSEQ.halfpi+54 gmSEQ.halfpi+54 gmSEQ.halfpi+54 gmSEQ.halfpi+54];

for n = 1 : gmSEQ.CoolCycle
    gmSEQ.CHN(numel(gmSEQ.CHN)).T = [gmSEQ.CHN(numel(gmSEQ.CHN)).T, ...
        Start_Sig_D + floor( (n-1) / RepN) * gmSEQ.CoolWait + (n - 1) * CoolCycleT + Cooling_Readout + AfterLaser - 30];
    gmSEQ.CHN(numel(gmSEQ.CHN)).DT = [gmSEQ.CHN(numel(gmSEQ.CHN)).DT, ...
        gmSEQ.halfpi + LockLenCool + gmSEQ.halfpi + 54];
end
gmSEQ.CHN(numel(gmSEQ.CHN)).T = [gmSEQ.CHN(numel(gmSEQ.CHN)).T, ...
    Start_Sig_D + floor( gmSEQ.CoolCycle / RepN) * gmSEQ.CoolWait + gmSEQ.CoolCycle * CoolCycleT + gmSEQ.readout + AfterLaser - 30];
gmSEQ.CHN(numel(gmSEQ.CHN)).DT = [gmSEQ.CHN(numel(gmSEQ.CHN)).DT, ...
    gmSEQ.halfpi + LockLenMeasure + SpinLockGap + gmSEQ.halfpi + PulseGap + gmSEQ.pi + 54];


%%% Dummy 1: to check the total length of the sequence.
Max_length = 2 * Wait_p + 2 * gmSEQ.CoolCycle * CoolCycleT ...
    + 2 * floor( gmSEQ.CoolCycle / RepN) * gmSEQ.CoolWait + 2 * gmSEQ.readout + 2 * Detect_Window ...
    + 2 * (AfterLaser + AfterPi + gmSEQ.halfpi + LockLenMeasure + SpinLockGap + gmSEQ.halfpi + PulseGap + gmSEQ.pi);
gmSEQ.CHN(numel(gmSEQ.CHN) + 1).PBN = PBDictionary('dummy1');
gmSEQ.CHN(numel(gmSEQ.CHN)).NRise = 2;
gmSEQ.CHN(numel(gmSEQ.CHN)).T = [0, Max_length-200];
gmSEQ.CHN(numel(gmSEQ.CHN)).DT = [200, 200];

%%% AWG Trigger
% Each repeatition of the segement need one trigger, a total of 2 *
% (CoolCycle + 1) triggers are needed.
% Cooling -> Cooling - Measurement
gmSEQ.CHN(numel(gmSEQ.CHN)+1).PBN = PBDictionary('AWGTrig');
gmSEQ.CHN(numel(gmSEQ.CHN)).NRise = 2 + 2 + gmSEQ.CoolCycle * 2;
gmSEQ.CHN(numel(gmSEQ.CHN)).T = [10000];
gmSEQ.CHN(numel(gmSEQ.CHN)).DT = [1000];
for n = 1 : gmSEQ.CoolCycle
gmSEQ.CHN(numel(gmSEQ.CHN)).T = [gmSEQ.CHN(numel(gmSEQ.CHN)).T, ... 
    Wait_p + floor( (n - 1) / RepN) * gmSEQ.CoolWait + (n - 1) * CoolCycleT + Cooling_Readout + AfterLaser];
gmSEQ.CHN(numel(gmSEQ.CHN)).DT = [gmSEQ.CHN(numel(gmSEQ.CHN)).DT, 500];
end

gmSEQ.CHN(numel(gmSEQ.CHN)).T = [gmSEQ.CHN(numel(gmSEQ.CHN)).T, ...
    Wait_p + floor( gmSEQ.CoolCycle / RepN) * gmSEQ.CoolWait + gmSEQ.CoolCycle * CoolCycleT + gmSEQ.readout + AfterLaser];
gmSEQ.CHN(numel(gmSEQ.CHN)).DT=[gmSEQ.CHN(numel(gmSEQ.CHN)).DT, 500];

gmSEQ.CHN(numel(gmSEQ.CHN)).T = [gmSEQ.CHN(numel(gmSEQ.CHN)).T, ...
    Start_Sig_D-Wait_p+10000];
gmSEQ.CHN(numel(gmSEQ.CHN)).DT=[gmSEQ.CHN(numel(gmSEQ.CHN)).DT, 1000];

% Differential Cooling -> Differential Cooling - Measurement
for n = 1:gmSEQ.CoolCycle
gmSEQ.CHN(numel(gmSEQ.CHN)).T = [gmSEQ.CHN(numel(gmSEQ.CHN)).T, ...
    Start_Sig_D + floor( (n - 1) / RepN) * gmSEQ.CoolWait + (n - 1) * CoolCycleT + Cooling_Readout + AfterLaser];
gmSEQ.CHN(numel(gmSEQ.CHN)).DT = [gmSEQ.CHN(numel(gmSEQ.CHN)).DT, 500];
end
gmSEQ.CHN(numel(gmSEQ.CHN)).T = [gmSEQ.CHN(numel(gmSEQ.CHN)).T, ...
    Start_Sig_D + floor( gmSEQ.CoolCycle / RepN) * gmSEQ.CoolWait + gmSEQ.CoolCycle * CoolCycleT + gmSEQ.readout + AfterLaser];
gmSEQ.CHN(numel(gmSEQ.CHN)).DT = [gmSEQ.CHN(numel(gmSEQ.CHN)).DT, 500]; 

%% AWG
%%% Initialization
chaseFunctionPool('stopChase', 1)
%%% Generating wave form
if gSG.ACmodAWG 
    WaveForm_1I = [];
    WaveForm_1Q = [];
%%%% Cooling / Heating Waveforms.
% |gmSEQ.CoolSwitch| controls whether cooling / heating is turned on. 
    if gmSEQ.CoolSwitch == 1 % Cooling
        WaveForm_1I = [WaveForm_1I; ...
            0, gmSEQ.halfpi, gSG.AWGFreq, 0, gSG.AWGAmp]; % The 1st pi/2_x pulse.
        WaveForm_1Q = [WaveForm_1Q; ...
            0, gmSEQ.halfpi, gSG.AWGFreq, - pi / 2, gSG.AWGAmp];
    elseif gmSEQ.CoolSwitch == 2 % Heating
        WaveForm_1I = [WaveForm_1I; ...
            0, gmSEQ.halfpi, gSG.AWGFreq, pi, gSG.AWGAmp];
        WaveForm_1Q = [WaveForm_1Q; ...
            0, gmSEQ.halfpi, gSG.AWGFreq, pi - pi / 2, gSG.AWGAmp];
    elseif gmSEQ.CoolSwitch == 0 % Nothing
        WaveForm_1I = [WaveForm_1I; ...
            0, gmSEQ.halfpi, 0, 0, 0];
        WaveForm_1Q = [WaveForm_1Q; ...
            0, gmSEQ.halfpi, 0, 0, 0];
    end
    
    for n = 1 : gmSEQ.LockN0 % add segments of [t1(Omega_y) -> t2(-Omega_y)]
       WaveForm_1I = [WaveForm_1I; ...
           gmSEQ.halfpi + (n - 1) * SingleLen_C + SpinLockGap, ...
               gmSEQ.halfpi + (n - 1) * SingleLen_C + SpinLockGap + gmSEQ.SLockT1, ...
               gSG.AWGFreq, ...
               pi / 2, ...
               gSG.AWGAmp * gmSEQ.SAmp1; ...
           gmSEQ.halfpi + (n - 1) * SingleLen_C + SpinLockGap + gmSEQ.SLockT1 + SpinLockGap, ...
               gmSEQ.halfpi + (n - 1) * SingleLen_C + SpinLockGap + gmSEQ.SLockT1 + SpinLockGap + gmSEQ.SLockT2, ...
               gSG.AWGFreq, ...
               3 * pi / 2, ...
               gSG.AWGAmp * gmSEQ.SAmp2];
       WaveForm_1Q = [WaveForm_1Q; ...
           gmSEQ.halfpi + (n - 1) * SingleLen_C + SpinLockGap, ...
               gmSEQ.halfpi + (n - 1) * SingleLen_C + SpinLockGap + gmSEQ.SLockT1, ...
               gSG.AWGFreq, ...
               pi / 2 - pi / 2, ...
               gSG.AWGAmp * gmSEQ.SAmp1; ...
           gmSEQ.halfpi + (n - 1) * SingleLen_C + SpinLockGap + gmSEQ.SLockT1 + SpinLockGap, ...
               gmSEQ.halfpi + (n - 1) * SingleLen_C + SpinLockGap + gmSEQ.SLockT1 + SpinLockGap + gmSEQ.SLockT2, ...
               gSG.AWGFreq, ...
               3 * pi / 2 - pi/2, ...
               gSG.AWGAmp * gmSEQ.SAmp2];     
    end
    
    if gmSEQ.CoolSwitch == 1
        WaveForm_1I = [WaveForm_1I; ...
            gmSEQ.halfpi+gmSEQ.LockN0*SingleLen_C+SpinLockGap, ...
            gmSEQ.halfpi+gmSEQ.LockN0*SingleLen_C+SpinLockGap+gmSEQ.halfpi, ...
             gSG.AWGFreq, ...
             2 * pi / 2, ...
             gSG.AWGAmp];
         WaveForm_1Q = [WaveForm_1Q; ...
            gmSEQ.halfpi+gmSEQ.LockN0*SingleLen_C+SpinLockGap, ...
            gmSEQ.halfpi+gmSEQ.LockN0*SingleLen_C+SpinLockGap+gmSEQ.halfpi, ...
             gSG.AWGFreq, ...
             2 * pi / 2 - pi / 2, ...
             gSG.AWGAmp];
                      
    elseif gmSEQ.CoolSwitch == 2
         WaveForm_1I = [WaveForm_1I; ...
            gmSEQ.halfpi+gmSEQ.LockN0*SingleLen_C+SpinLockGap, ...
            gmSEQ.halfpi+gmSEQ.LockN0*SingleLen_C+SpinLockGap+gmSEQ.halfpi, ...
             gSG.AWGFreq, ...
             0 * pi / 2, ...
             gSG.AWGAmp];
         WaveForm_1Q = [WaveForm_1Q; ...
            gmSEQ.halfpi+gmSEQ.LockN0*SingleLen_C+SpinLockGap, ...
            gmSEQ.halfpi+gmSEQ.LockN0*SingleLen_C+SpinLockGap+gmSEQ.halfpi, ...
             gSG.AWGFreq, ...
             0 * pi / 2 - pi / 2, ...
             gSG.AWGAmp];
        
    end
    
    WaveForm_1Length = ceil((gmSEQ.halfpi + LockLenCool + gmSEQ.halfpi + 1000) / (16 / gSG.AWGClockRate)) ...
        *(16 / gSG.AWGClockRate);
    WaveForm_1PointNum = WaveForm_1Length * gSG.AWGClockRate;
    
%%%% Measuring Waveforms.    
    if gmSEQ.CoolSwitch <2 
        WaveForm_2I = [0, gmSEQ.halfpi, gSG.AWGFreq, 0, gSG.AWGAmp]; 
        WaveForm_2Q = [0, gmSEQ.halfpi, gSG.AWGFreq, -pi/2, gSG.AWGAmp];    
    elseif gmSEQ.CoolSwitch == 2
        WaveForm_2I = [0, gmSEQ.halfpi, gSG.AWGFreq, 0+0, gSG.AWGAmp]; 
        WaveForm_2Q = [0, gmSEQ.halfpi, gSG.AWGFreq, 0-pi/2, gSG.AWGAmp];    
    end

    for n = 1 : gmSEQ.m  % add segments of [t1(Omega_y) -> t2(-Omega_y)]
        WaveForm_2I = [WaveForm_2I; ...
           gmSEQ.halfpi + (n - 1) * SingleLen_M + SpinLockGap, ...
               gmSEQ.halfpi + (n - 1) * SingleLen_M + SpinLockGap + gmSEQ.SLockT1_M, ...
               gSG.AWGFreq, ...
               pi / 2, gSG.AWGAmp * gmSEQ.SAmp1_M;...
           gmSEQ.halfpi + (n - 1) * SingleLen_M + SpinLockGap + gmSEQ.SLockT1_M + SpinLockGap, ...
               gmSEQ.halfpi + (n - 1) * SingleLen_M + SpinLockGap + gmSEQ.SLockT1_M + SpinLockGap + gmSEQ.SLockT2_M, ...
               gSG.AWGFreq, ...
               3 * pi / 2, ...
               gSG.AWGAmp * gmSEQ.SAmp2_M];
        WaveForm_2Q = [WaveForm_2Q; ...
           gmSEQ.halfpi + (n - 1) * SingleLen_M + SpinLockGap, ...
               gmSEQ.halfpi + (n - 1) * SingleLen_M + SpinLockGap + gmSEQ.SLockT1_M, ...
               gSG.AWGFreq, ...
               pi / 2 - pi / 2, gSG.AWGAmp*gmSEQ.SAmp1_M;...
           gmSEQ.halfpi + (n - 1) * SingleLen_M + SpinLockGap + gmSEQ.SLockT1_M + SpinLockGap, ...
               gmSEQ.halfpi + (n - 1) * SingleLen_M + SpinLockGap + gmSEQ.SLockT1_M + SpinLockGap + gmSEQ.SLockT2_M, ...
               gSG.AWGFreq, ...
               3 * pi / 2 - pi / 2, ...
               gSG.AWGAmp * gmSEQ.SAmp2_M];   
    end
    
    if gmSEQ.CoolSwitch <2 
    WaveForm_2I = [WaveForm_2I; ...
        gmSEQ.halfpi + gmSEQ.m * SingleLen_M + SpinLockGap, ...
            gmSEQ.halfpi + gmSEQ.m * SingleLen_M + SpinLockGap + gmSEQ.halfpi,...
            gSG.AWGFreq, ...
            2 * pi / 2, ...
            gSG.AWGAmp];
    WaveForm_2Q = [WaveForm_2Q; ...
        gmSEQ.halfpi + gmSEQ.m * SingleLen_M + SpinLockGap, ...
            gmSEQ.halfpi + gmSEQ.m * SingleLen_M + SpinLockGap + gmSEQ.halfpi,...
            gSG.AWGFreq, ...
            2 * pi / 2 - pi / 2, ...
            gSG.AWGAmp];
    elseif gmSEQ.CoolSwitch == 2
    WaveForm_2I = [WaveForm_2I; ...
        gmSEQ.halfpi + gmSEQ.m * SingleLen_M + SpinLockGap, ...
            gmSEQ.halfpi + gmSEQ.m * SingleLen_M + SpinLockGap + gmSEQ.halfpi,...
            gSG.AWGFreq, ...
            2 * pi / 2, ...
            gSG.AWGAmp];
    WaveForm_2Q = [WaveForm_2Q; ...
        gmSEQ.halfpi + gmSEQ.m * SingleLen_M + SpinLockGap, ...
            gmSEQ.halfpi + gmSEQ.m * SingleLen_M + SpinLockGap + gmSEQ.halfpi,...
            gSG.AWGFreq, ...
            2 * pi / 2 - pi / 2, ...
            gSG.AWGAmp];     
    end
    
%%%% Differential Measuring Waveforms. Just add another pi_y pulse at the
%%%% end.
    WaveForm_3I = [WaveForm_2I; ...
        gmSEQ.halfpi + gmSEQ.m * SingleLen_M + SpinLockGap + gmSEQ.halfpi + PulseGap, ...
            gmSEQ.halfpi + gmSEQ.m * SingleLen_M + SpinLockGap + gmSEQ.halfpi + PulseGap + gmSEQ.pi, ...
            gSG.AWGFreq, ...
            pi / 2, gSG.AWGAmp];
    WaveForm_3Q = [WaveForm_2Q; ...
        gmSEQ.halfpi + gmSEQ.m * SingleLen_M + SpinLockGap + gmSEQ.halfpi + PulseGap, ...
            gmSEQ.halfpi + gmSEQ.m * SingleLen_M + SpinLockGap + gmSEQ.halfpi + PulseGap + gmSEQ.pi, ...
            gSG.AWGFreq, ...
            pi / 2 - pi / 2, gSG.AWGAmp]; 
    
    WaveForm_2Length = ceil((gmSEQ.halfpi + LockLenMeasure + SpinLockGap + gmSEQ.halfpi + PulseGap + gmSEQ.pi + 1000) / (16 / gSG.AWGClockRate)) ...
        * (16 / gSG.AWGClockRate);
    WaveForm_2PointNum = WaveForm_2Length * gSG.AWGClockRate;
    WaveForm_3Length = WaveForm_2Length;
    WaveForm_3PointNum = WaveForm_2PointNum;
    
    % NV pulse to mix up NV
     WaveForm_4I = [0, gmSEQ.halfpi, gSG.AWGFreq, 0, gSG.AWGAmp; ...
         10000, 10000+gmSEQ.halfpi,  gSG.AWGFreq, 0, gSG.AWGAmp; ...
         20000, 20000+gmSEQ.halfpi,  gSG.AWGFreq, 0, gSG.AWGAmp; ...
         30000, 30000+gmSEQ.halfpi,  gSG.AWGFreq, 0, gSG.AWGAmp];
     WaveForm_4Q = [0, gmSEQ.halfpi, gSG.AWGFreq, -pi/2, gSG.AWGAmp; ...
         10000, 10000+gmSEQ.halfpi,  gSG.AWGFreq, -pi/2, gSG.AWGAmp; ...
         20000, 20000+gmSEQ.halfpi,  gSG.AWGFreq, -pi/2, gSG.AWGAmp; ...
         30000, 30000+gmSEQ.halfpi,  gSG.AWGFreq, -pi/2, gSG.AWGAmp];
    
    WaveForm_4Length = ceil((30000+gmSEQ.halfpi+1000) / (16 / gSG.AWGClockRate)) ...
        * (16 / gSG.AWGClockRate);
    WaveForm_4PointNum = WaveForm_4Length * gSG.AWGClockRate;
    
    
else
    questdlg('Only AC mnodulation works for now, please check AC modulation~',...
        'Heating / Cooling Sequence', 'Cancel');
end
%%% Create Wave Form Text Files
chaseFunctionPool('createWaveform', WaveForm_1I, gSG.AWGClockRate, WaveForm_1Length, 'SpecialCooling_I_seg1.txt'); pause(0.1);
chaseFunctionPool('createWaveform', WaveForm_1Q, gSG.AWGClockRate, WaveForm_1Length, 'SpecialCooling_Q_seg1.txt'); pause(0.1);
chaseFunctionPool('createWaveform', WaveForm_2I, gSG.AWGClockRate, WaveForm_2Length, 'SpecialCooling_I_seg2.txt'); pause(0.1);
chaseFunctionPool('createWaveform', WaveForm_2Q, gSG.AWGClockRate, WaveForm_2Length, 'SpecialCooling_Q_seg2.txt'); pause(0.1);
chaseFunctionPool('createWaveform', WaveForm_3I, gSG.AWGClockRate, WaveForm_3Length, 'SpecialCooling_I_seg3.txt'); pause(0.1);
chaseFunctionPool('createWaveform', WaveForm_3Q, gSG.AWGClockRate, WaveForm_3Length, 'SpecialCooling_Q_seg3.txt'); pause(0.1);
chaseFunctionPool('createWaveform', WaveForm_4I, gSG.AWGClockRate, WaveForm_4Length, 'SpecialCooling_I_seg4.txt'); pause(0.1);
chaseFunctionPool('createWaveform', WaveForm_4Q, gSG.AWGClockRate, WaveForm_4Length, 'SpecialCooling_Q_seg4.txt'); pause(0.1);

%%% Create Wave Form Structs -> Pass Segments to AWG
if gmSEQ.CoolCycle == 0
    chaseFunctionPool('createSegStruct', 'SpecialCooling_SegStruct_I.txt', ...
        'SpecialCooling_I_seg4.txt', WaveForm_4PointNum, 1, 1, ...
        'SpecialCooling_I_seg2.txt', WaveForm_2PointNum, 1, 1, ...
        'SpecialCooling_I_seg4.txt', WaveForm_4PointNum, 1, 1, ...
        'SpecialCooling_I_seg3.txt', WaveForm_3PointNum, 1, 1);
    pause(0.2);
    chaseFunctionPool('createSegStruct', 'SpecialCooling_SegStruct_Q.txt', ...
        'SpecialCooling_Q_seg4.txt', WaveForm_4PointNum, 1, 1, ...
        'SpecialCooling_Q_seg2.txt', WaveForm_2PointNum, 1, 1, ...
        'SpecialCooling_Q_seg4.txt', WaveForm_4PointNum, 1, 1, ...
        'SpecialCooling_Q_seg3.txt', WaveForm_3PointNum, 1, 1);
    pause(0.2);
    chaseFunctionPool('CreateSegments', 1, 1, ...
        4, ...
        2047, 2047, 'SpecialCooling_SegStruct_I.txt', 'false');
    pause(1); % this pause seems to be important, otherwise the loading is not right occassionally
    chaseFunctionPool('CreateSegments', 1, 2, ...
        4, ...
        2047, 2047, 'SpecialCooling_SegStruct_Q.txt', 'false');
    pause(1); % this pause seems to be important, otherwise the loading is not right occassionally
    chaseFunctionPool('runChase', 1, 'false');
elseif gmSEQ.CoolCycle == 1
    chaseFunctionPool('createSegStruct', 'SpecialCooling_SegStruct_I.txt', ...
        'SpecialCooling_I_seg4.txt', WaveForm_4PointNum, 1, 1, ...
        'SpecialCooling_I_seg1.txt', WaveForm_1PointNum, 1, 1, ...
        'SpecialCooling_I_seg2.txt', WaveForm_2PointNum, 1, 1, ...
        'SpecialCooling_I_seg4.txt', WaveForm_4PointNum, 1, 1, ...
        'SpecialCooling_I_seg1.txt', WaveForm_1PointNum, 1, 1, ...
        'SpecialCooling_I_seg3.txt', WaveForm_3PointNum, 1, 1);
    pause(0.2);
    chaseFunctionPool('createSegStruct', 'SpecialCooling_SegStruct_Q.txt', ...
        'SpecialCooling_Q_seg4.txt', WaveForm_4PointNum, 1, 1, ...
        'SpecialCooling_Q_seg1.txt', WaveForm_1PointNum, 1, 1, ...
        'SpecialCooling_Q_seg2.txt', WaveForm_2PointNum, 1, 1, ...
        'SpecialCooling_Q_seg4.txt', WaveForm_4PointNum, 1, 1, ...
        'SpecialCooling_Q_seg1.txt', WaveForm_1PointNum, 1, 1, ...
        'SpecialCooling_Q_seg3.txt', WaveForm_3PointNum, 1, 1);
    pause(0.2);
    chaseFunctionPool('CreateSegments', 1, 1, ...
        6, ...
        2047, 2047, 'SpecialCooling_SegStruct_I.txt', 'false');
    pause(1); % this pause seems to be important, otherwise the loading is not right occassionally
    chaseFunctionPool('CreateSegments', 1, 2, ...
        6, ...
        2047, 2047, 'SpecialCooling_SegStruct_Q.txt', 'false');
    pause(1); % this pause seems to be important, otherwise the loading is not right occassionally
    chaseFunctionPool('runChase', 1, 'false');
elseif gmSEQ.CoolCycle < 500
chaseFunctionPool('createSegStruct', 'SpecialCooling_SegStruct_I.txt', ...
    'SpecialCooling_I_seg4.txt', WaveForm_4PointNum, 1, 1, ...
    'SpecialCooling_I_seg1.txt', WaveForm_1PointNum, 1, 1, ... % The first repeatition cannot be looped and must be triggered, so must be left out.
    'SpecialCooling_I_seg1.txt', WaveForm_1PointNum, gmSEQ.CoolCycle - 1, 1, ...
    'SpecialCooling_I_seg2.txt', WaveForm_2PointNum, 1, 1, ...
    'SpecialCooling_I_seg4.txt', WaveForm_4PointNum, 1, 1, ...
    'SpecialCooling_I_seg1.txt', WaveForm_1PointNum, 1, 1, ... % This one just to make sure things are symmetric.
    'SpecialCooling_I_seg1.txt', WaveForm_1PointNum, gmSEQ.CoolCycle - 1, 1, ...
    'SpecialCooling_I_seg3.txt', WaveForm_3PointNum, 1, 1);
pause(0.2);
chaseFunctionPool('createSegStruct', 'SpecialCooling_SegStruct_Q.txt', ...
    'SpecialCooling_Q_seg4.txt', WaveForm_4PointNum, 1, 1, ...
    'SpecialCooling_Q_seg1.txt', WaveForm_1PointNum, 1, 1, ... 
    'SpecialCooling_Q_seg1.txt', WaveForm_1PointNum, gmSEQ.CoolCycle - 1, 1, ...
    'SpecialCooling_Q_seg2.txt', WaveForm_2PointNum, 1, 1, ...
    'SpecialCooling_Q_seg4.txt', WaveForm_4PointNum, 1, 1, ...
    'SpecialCooling_Q_seg1.txt', WaveForm_1PointNum, 1, 1, ...
    'SpecialCooling_Q_seg1.txt', WaveForm_1PointNum, gmSEQ.CoolCycle - 1, 1, ...
    'SpecialCooling_Q_seg3.txt', WaveForm_3PointNum, 1, 1);
pause(0.2);    
chaseFunctionPool('CreateSegments', 1, 1, ...
    8, ...
    2047, 2047, 'SpecialCooling_SegStruct_I.txt', 'false');
pause(1); % this pause seems to be important, otherwise the loading is not right occassionally
chaseFunctionPool('CreateSegments', 1, 2, ...
    8, ...
    2047, 2047, 'SpecialCooling_SegStruct_Q.txt', 'false');
pause(1); % this pause seems to be important, otherwise the loading is not right occassionally
%%% Run AWG.
chaseFunctionPool('runChase', 1, 'false');

% else
%     chaseFunctionPool('createSegStruct', 'SpecialCooling_SegStruct_I.txt', ...
%     'SpecialCooling_I_seg1.txt', WaveForm_1PointNum, 1, 1, ... % The first repeatition cannot be looped and must be triggered, so must be left out.
%     'SpecialCooling_I_seg1.txt', WaveForm_1PointNum, 300, 1, ...
%     'SpecialCooling_I_seg1.txt', WaveForm_1PointNum, gmSEQ.CoolCycle-300-1, 1, ...
%     'SpecialCooling_I_seg2.txt', WaveForm_2PointNum, 1, 1, ...
%     'SpecialCooling_I_seg1.txt', WaveForm_1PointNum, 1, 1, ... % This one just to make sure things are symmetric.
%     'SpecialCooling_I_seg1.txt', WaveForm_1PointNum, 300, 1, ...
%     'SpecialCooling_I_seg1.txt', WaveForm_1PointNum, gmSEQ.CoolCycle-300-1, 1, ...
%     'SpecialCooling_I_seg3.txt', WaveForm_3PointNum, 1, 1);
% pause(0.5);
% chaseFunctionPool('createSegStruct', 'SpecialCooling_SegStruct_Q.txt', ...
%     'SpecialCooling_Q_seg1.txt', WaveForm_1PointNum, 1, 1, ... 
%     'SpecialCooling_Q_seg1.txt', WaveForm_1PointNum, 300, 1, ...
%     'SpecialCooling_Q_seg1.txt', WaveForm_1PointNum, gmSEQ.CoolCycle-300-1, 1, ...
%     'SpecialCooling_Q_seg2.txt', WaveForm_2PointNum, 1, 1, ...
%     'SpecialCooling_Q_seg1.txt', WaveForm_1PointNum, 1, 1, ...
%     'SpecialCooling_Q_seg1.txt', WaveForm_1PointNum, 300, 1, ...
%     'SpecialCooling_Q_seg1.txt', WaveForm_1PointNum, gmSEQ.CoolCycle-300-1, 1, ...
%     'SpecialCooling_Q_seg3.txt', WaveForm_3PointNum, 1, 1);
% pause(0.5);    
% chaseFunctionPool('CreateSegments', 1, 1, ...
%     8, ...
%     2047, 2047, 'SpecialCooling_SegStruct_I.txt', 'false');
% pause(3); % this pause seems to be important, otherwise the loading is not right occassionally
% chaseFunctionPool('CreateSegments', 1, 2, ...
%     8, ...
%     2047, 2047, 'SpecialCooling_SegStruct_Q.txt', 'false');
% pause(3); % this pause seems to be important, otherwise the loading is not right occassionally
% %%% Run AWG.
% chaseFunctionPool('runChase', 1, 'false');
end
ApplyDelays();    

function SpecialCooling_P1

global gmSEQ gSG gSG2
gSG.bfixedPow = 1;
gSG.bfixedFreq = 1;
gSG.bMod = 'IQ';
gSG.bModSrc = 'External';

gSG2.bMod='IQ';
gSG2.bModSrc='External';
SignalGeneratorFunctionPool2('SetMod');

SignalGeneratorFunctionPool2('WritePow');
SignalGeneratorFunctionPool2('WriteFreq');
gSG2.bOn=1; SignalGeneratorFunctionPool2('RFOnOff');

% If PL signal is collected via APD.
if strcmp(gmSEQ.meas,'APD') 
    gmSEQ.CtrGateDur = 1000;
end

% Cooling sequence [pi/2_x->[t1(Omega_y) -> t2(-Omega_y)]^{N_0}]^{Cooling cycle}...

gmSEQ.halfpi = gmSEQ.pi/2;
Wait_p = 20e6; % to wait for P1 to be fully unpolarized again
AfterPi = 1000;
AfterLaser = 2000;
Detect_Window = 15000;
PulseGap = 30;
SpinLockGap = 0; % The gap (in ns) between t1(Omega) and t2(-Omega).

SingleLen_C = 2 * SpinLockGap + gmSEQ.SLockT1 + gmSEQ.SLockT2; % Length of cooling segment [t1(Omega_y) -> t2(-Omega_y)]
LockLenCool = gmSEQ.LockN0 * SingleLen_C;

SingleLen_M = 1*(2*SpinLockGap+gmSEQ.SLockT1_M + gmSEQ.SLockT2_M); % Length of measuring segment [t1(Omega_y) -> t2(-Omega_y)]
LockLenMeasure = gmSEQ.m * SingleLen_M;

AfterLock = 1000;
% Cooling_Readout = gmSEQ.readout;
Cooling_Readout = 1000;

CoolCycleT = Cooling_Readout + AfterLaser + gmSEQ.halfpi + LockLenCool + gmSEQ.halfpi + AfterLock;
CoolCycleT = ceil(CoolCycleT * gSG.AWGClockRate / 16) / (gSG.AWGClockRate / 16);

%% Pulse Blaster
%%% AOM
% Cooling
gmSEQ.CHN(1).PBN=PBDictionary('AOM');
gmSEQ.CHN(1).NRise = 2 * (2 + gmSEQ.CoolCycle);
    gmSEQ.CHN(1).T = [];
    gmSEQ.CHN(1).DT = [];
    for n = 1 : gmSEQ.CoolCycle
        gmSEQ.CHN(1).T = [gmSEQ.CHN(1).T, Wait_p + (n - 1) * CoolCycleT];
        gmSEQ.CHN(1).DT = [gmSEQ.CHN(1).DT, Cooling_Readout];
    end
% Cooling - Measurement
    gmSEQ.CHN(1).T = [gmSEQ.CHN(1).T, ...
        Wait_p + gmSEQ.CoolCycle * CoolCycleT + gmSEQ.CoolWait, ...
        Wait_p + gmSEQ.CoolCycle * CoolCycleT + gmSEQ.CoolWait ...
            + gmSEQ.readout + AfterLaser + gmSEQ.halfpi + LockLenMeasure ...
            + SpinLockGap + gmSEQ.halfpi + PulseGap + gmSEQ.pi+ AfterPi];
    gmSEQ.CHN(1).DT = [gmSEQ.CHN(1).DT, gmSEQ.readout, Detect_Window]; 
% Differential Cooling
    Start_Sig_D = Wait_p + gmSEQ.CoolCycle * CoolCycleT + gmSEQ.CoolWait ...
        + gmSEQ.readout + AfterLaser + gmSEQ.halfpi + LockLenMeasure ...
        + SpinLockGap + gmSEQ.halfpi + PulseGap + gmSEQ.pi + AfterPi ...
        + Detect_Window + Wait_p;
    for n = 1 : gmSEQ.CoolCycle
        gmSEQ.CHN(1).T = [gmSEQ.CHN(1).T, Start_Sig_D + (n - 1) * CoolCycleT];
        gmSEQ.CHN(1).DT = [gmSEQ.CHN(1).DT, Cooling_Readout];
    end
% Differential Cooling - Measurement
    gmSEQ.CHN(1).T = [gmSEQ.CHN(1).T, ...
        Start_Sig_D + gmSEQ.CoolCycle * CoolCycleT + gmSEQ.CoolWait, ...
        Start_Sig_D + gmSEQ.CoolCycle  *CoolCycleT + gmSEQ.CoolWait ...
            + gmSEQ.readout + AfterLaser + gmSEQ.halfpi + LockLenMeasure ...
            + SpinLockGap + gmSEQ.halfpi + PulseGap + gmSEQ.pi + AfterPi];
    gmSEQ.CHN(1).DT = [gmSEQ.CHN(1).DT, gmSEQ.readout, Detect_Window];

%%% APD
% gmSEQ.CHN(numel(gmSEQ.CHN)+1).PBN=PBDictionary('ctr0');
% gmSEQ.CHN(numel(gmSEQ.CHN)).NRise = 4;
% gmSEQ.CHN(numel(gmSEQ.CHN)).T = [gmSEQ.CHN(1).T(gmSEQ.CoolCycle + 1) + gmSEQ.readout - 1000, ...
%     gmSEQ.CHN(1).T(gmSEQ.CoolCycle + 2), ...
%     gmSEQ.CHN(1).T(2 * gmSEQ.CoolCycle + 3) + gmSEQ.readout - 1000, ...
%     gmSEQ.CHN(1).T(2 * gmSEQ.CoolCycle + 4)];
% gmSEQ.CHN(numel(gmSEQ.CHN)).DT = repelem(gmSEQ.CtrGateDur, 1, 4);

gmSEQ.CHN(numel(gmSEQ.CHN)+1).PBN=PBDictionary('ctr0');
gmSEQ.CHN(numel(gmSEQ.CHN)).NRise = 4;
gmSEQ.CHN(numel(gmSEQ.CHN)).T = [gmSEQ.CHN(1).T(gmSEQ.CoolCycle + 2), ...
    gmSEQ.CHN(1).T(gmSEQ.CoolCycle + 2)+Detect_Window-1000-gmSEQ.CtrGateDur, ...
    gmSEQ.CHN(1).T(2 * gmSEQ.CoolCycle + 4), ...
    gmSEQ.CHN(1).T(2 * gmSEQ.CoolCycle + 4)+Detect_Window-1000-gmSEQ.CtrGateDur];
gmSEQ.CHN(numel(gmSEQ.CHN)).DT = repelem(gmSEQ.CtrGateDur, 1, 4);

% Note that for sequence length ~ 2ms / 20ms, the timing difference between
% PulseBlaster and AWG is ~ 10ns / 100ns

% MW Switch
% Cooling -> Cooling - Measurement
gmSEQ.CHN(numel(gmSEQ.CHN) + 1).PBN=PBDictionary('MWSwitch');
gmSEQ.CHN(numel(gmSEQ.CHN)).NRise= 2 + 2 * gmSEQ.CoolCycle + 8;
gmSEQ.CHN(numel(gmSEQ.CHN)).T = [10000-30 20000-30 30000-30 40000-30];
gmSEQ.CHN(numel(gmSEQ.CHN)).DT = [gmSEQ.halfpi+54 gmSEQ.halfpi+54 gmSEQ.halfpi+54 gmSEQ.halfpi+54];
for n = 1 : gmSEQ.CoolCycle
    gmSEQ.CHN(numel(gmSEQ.CHN)).T = [gmSEQ.CHN(numel(gmSEQ.CHN)).T, ...
        Wait_p + (n - 1) * CoolCycleT + Cooling_Readout + AfterLaser - 30]; % double the buffer around IQ.
    gmSEQ.CHN(numel(gmSEQ.CHN)).DT = [gmSEQ.CHN(numel(gmSEQ.CHN)).DT, ...
        gmSEQ.halfpi + LockLenCool + gmSEQ.halfpi + 54];
end
gmSEQ.CHN(numel(gmSEQ.CHN)).T = [gmSEQ.CHN(numel(gmSEQ.CHN)).T, ...
    Wait_p + gmSEQ.CoolCycle * CoolCycleT + gmSEQ.CoolWait + gmSEQ.readout + AfterLaser - 30];
gmSEQ.CHN(numel(gmSEQ.CHN)).DT = [gmSEQ.CHN(numel(gmSEQ.CHN)).DT, ...
    gmSEQ.halfpi + LockLenMeasure + SpinLockGap + gmSEQ.halfpi + 54];
% Differential Cooling -> Differential Cooling - Measurement


gmSEQ.CHN(numel(gmSEQ.CHN)).T = [gmSEQ.CHN(numel(gmSEQ.CHN)).T, ...
    Start_Sig_D-Wait_p+10000-30 Start_Sig_D-Wait_p+20000-30 Start_Sig_D-Wait_p+30000-30 Start_Sig_D-Wait_p+40000-30];
gmSEQ.CHN(numel(gmSEQ.CHN)).DT = [gmSEQ.CHN(numel(gmSEQ.CHN)).DT gmSEQ.halfpi+54 gmSEQ.halfpi+54 gmSEQ.halfpi+54 gmSEQ.halfpi+55];

for n = 1 : gmSEQ.CoolCycle
    gmSEQ.CHN(numel(gmSEQ.CHN)).T = [gmSEQ.CHN(numel(gmSEQ.CHN)).T, ...
        Start_Sig_D + (n - 1) * CoolCycleT + Cooling_Readout + AfterLaser - 30];
    gmSEQ.CHN(numel(gmSEQ.CHN)).DT = [gmSEQ.CHN(numel(gmSEQ.CHN)).DT, ...
        gmSEQ.halfpi + LockLenCool + gmSEQ.halfpi + 54];
end
gmSEQ.CHN(numel(gmSEQ.CHN)).T = [gmSEQ.CHN(numel(gmSEQ.CHN)).T, ...
    Start_Sig_D + gmSEQ.CoolCycle * CoolCycleT + gmSEQ.CoolWait + gmSEQ.readout + AfterLaser - 30];
gmSEQ.CHN(numel(gmSEQ.CHN)).DT = [gmSEQ.CHN(numel(gmSEQ.CHN)).DT, ...
    gmSEQ.halfpi + LockLenMeasure + SpinLockGap + gmSEQ.halfpi + PulseGap + gmSEQ.pi + 54];


%%% Dummy 1: to check the total length of the sequence.
Max_length = 2 * Wait_p + 2 * gmSEQ.CoolCycle * CoolCycleT ...
    + 2 * gmSEQ.CoolWait + 2 * gmSEQ.readout + 2 * Detect_Window ...
    + 2 * (AfterLaser + AfterPi + gmSEQ.halfpi + LockLenMeasure + SpinLockGap + gmSEQ.halfpi + PulseGap + gmSEQ.pi);
gmSEQ.CHN(numel(gmSEQ.CHN) + 1).PBN = PBDictionary('dummy1');
gmSEQ.CHN(numel(gmSEQ.CHN)).NRise = 2;
gmSEQ.CHN(numel(gmSEQ.CHN)).T = [0, Max_length-200];
gmSEQ.CHN(numel(gmSEQ.CHN)).DT = [200, 200];

% Adding P1 pulse during the CoolWait
if gmSEQ.CoolWait > 500
  gmSEQ.CHN(numel(gmSEQ.CHN) + 1).PBN = PBDictionary('MWSwitch2');
  gmSEQ.CHN(numel(gmSEQ.CHN)).NRise = 2;
  gmSEQ.CHN(numel(gmSEQ.CHN)).T = [Wait_p + gmSEQ.CoolCycle * CoolCycleT, ...
      Start_Sig_D + gmSEQ.CoolCycle * CoolCycleT];
  gmSEQ.CHN(numel(gmSEQ.CHN)).DT = [gmSEQ.CoolWait, gmSEQ.CoolWait];
% % 
  gmSEQ.CHN(numel(gmSEQ.CHN) + 1).PBN = PBDictionary('I_2');
  gmSEQ.CHN(numel(gmSEQ.CHN)).NRise = 2;
  gmSEQ.CHN(numel(gmSEQ.CHN)).T = [Wait_p + gmSEQ.CoolCycle * CoolCycleT, ...
      Start_Sig_D + gmSEQ.CoolCycle * CoolCycleT ];
  gmSEQ.CHN(numel(gmSEQ.CHN)).DT = [gmSEQ.CoolWait, gmSEQ.CoolWait];
end
% if gmSEQ.CoolWait > 500
%   gmSEQ.CHN(numel(gmSEQ.CHN) + 1).PBN = PBDictionary('MWSwitch2');
%   gmSEQ.CHN(numel(gmSEQ.CHN)).NRise = 2;
%   gmSEQ.CHN(numel(gmSEQ.CHN)).T = [Wait_p + gmSEQ.CoolCycle * CoolCycleT - 20, ...
%       Start_Sig_D + gmSEQ.CoolCycle * CoolCycleT - 20];
%   gmSEQ.CHN(numel(gmSEQ.CHN)).DT = [gmSEQ.CoolWait, gmSEQ.CoolWait];
% % % 
%   gmSEQ.CHN(numel(gmSEQ.CHN) + 1).PBN = PBDictionary('I_2');
%   gmSEQ.CHN(numel(gmSEQ.CHN)).NRise = 2;
%   gmSEQ.CHN(numel(gmSEQ.CHN)).T = [Wait_p + gmSEQ.CoolCycle * CoolCycleT, ...
%       Start_Sig_D + gmSEQ.CoolCycle * CoolCycleT];
%   gmSEQ.CHN(numel(gmSEQ.CHN)).DT = [gmSEQ.CoolWait-40, gmSEQ.CoolWait-40];
% end

%%% AWG Trigger
% Each repeatition of the segement need one trigger, a total of 2 *
% (CoolCycle + 1) triggers are needed.
% Cooling -> Cooling - Measurement
gmSEQ.CHN(numel(gmSEQ.CHN)+1).PBN = PBDictionary('AWGTrig');
gmSEQ.CHN(numel(gmSEQ.CHN)).NRise = 2 + 2 + gmSEQ.CoolCycle * 2;
gmSEQ.CHN(numel(gmSEQ.CHN)).T = [10000];
gmSEQ.CHN(numel(gmSEQ.CHN)).DT = [1000];
for n = 1 : gmSEQ.CoolCycle
gmSEQ.CHN(numel(gmSEQ.CHN)).T = [gmSEQ.CHN(numel(gmSEQ.CHN)).T, ... 
    Wait_p + (n - 1) * CoolCycleT + Cooling_Readout + AfterLaser];
gmSEQ.CHN(numel(gmSEQ.CHN)).DT = [gmSEQ.CHN(numel(gmSEQ.CHN)).DT, 500];
end

gmSEQ.CHN(numel(gmSEQ.CHN)).T = [gmSEQ.CHN(numel(gmSEQ.CHN)).T, ...
    Wait_p + gmSEQ.CoolCycle * CoolCycleT + gmSEQ.CoolWait + gmSEQ.readout + AfterLaser];
gmSEQ.CHN(numel(gmSEQ.CHN)).DT=[gmSEQ.CHN(numel(gmSEQ.CHN)).DT, 500];

gmSEQ.CHN(numel(gmSEQ.CHN)).T = [gmSEQ.CHN(numel(gmSEQ.CHN)).T, ...
    Start_Sig_D-Wait_p+10000];
gmSEQ.CHN(numel(gmSEQ.CHN)).DT=[gmSEQ.CHN(numel(gmSEQ.CHN)).DT, 1000];

% Differential Cooling -> Differential Cooling - Measurement
for n = 1:gmSEQ.CoolCycle
gmSEQ.CHN(numel(gmSEQ.CHN)).T = [gmSEQ.CHN(numel(gmSEQ.CHN)).T, ...
    Start_Sig_D + (n - 1) * CoolCycleT + Cooling_Readout + AfterLaser];
gmSEQ.CHN(numel(gmSEQ.CHN)).DT = [gmSEQ.CHN(numel(gmSEQ.CHN)).DT, 500];
end
gmSEQ.CHN(numel(gmSEQ.CHN)).T = [gmSEQ.CHN(numel(gmSEQ.CHN)).T, ...
    Start_Sig_D + gmSEQ.CoolCycle * CoolCycleT + gmSEQ.CoolWait + gmSEQ.readout + AfterLaser];
gmSEQ.CHN(numel(gmSEQ.CHN)).DT = [gmSEQ.CHN(numel(gmSEQ.CHN)).DT, 500]; 

%% AWG
%%% Initialization
chaseFunctionPool('stopChase', 1)
%%% Generating wave form
if gSG.ACmodAWG 
    WaveForm_1I = [];
    WaveForm_1Q = [];
%%%% Cooling / Heating Waveforms.
% |gmSEQ.CoolSwitch| controls whether cooling / heating is turned on. 
    if gmSEQ.CoolSwitch == 1 % Cooling
        WaveForm_1I = [WaveForm_1I; ...
            0, gmSEQ.halfpi, gSG.AWGFreq, 0, gSG.AWGAmp]; % The 1st pi/2_x pulse.
        WaveForm_1Q = [WaveForm_1Q; ...
            0, gmSEQ.halfpi, gSG.AWGFreq, - pi / 2, gSG.AWGAmp];
    elseif gmSEQ.CoolSwitch == 2 % Heating
        WaveForm_1I = [WaveForm_1I; ...
            0, gmSEQ.halfpi, gSG.AWGFreq, pi, gSG.AWGAmp];
        WaveForm_1Q = [WaveForm_1Q; ...
            0, gmSEQ.halfpi, gSG.AWGFreq, pi - pi / 2, gSG.AWGAmp];
    elseif gmSEQ.CoolSwitch == 0 % Nothing
        WaveForm_1I = [WaveForm_1I; ...
            0, gmSEQ.halfpi, 0, 0, 0];
        WaveForm_1Q = [WaveForm_1Q; ...
            0, gmSEQ.halfpi, 0, 0, 0];
    end
    
    for n = 1 : gmSEQ.LockN0 % add segments of [t1(Omega_y) -> t2(-Omega_y)]
       WaveForm_1I = [WaveForm_1I; ...
           gmSEQ.halfpi + (n - 1) * SingleLen_C + SpinLockGap, ...
               gmSEQ.halfpi + (n - 1) * SingleLen_C + SpinLockGap + gmSEQ.SLockT1, ...
               gSG.AWGFreq, ...
               pi / 2, ...
               gSG.AWGAmp * gmSEQ.SAmp1; ...
           gmSEQ.halfpi + (n - 1) * SingleLen_C + SpinLockGap + gmSEQ.SLockT1 + SpinLockGap, ...
               gmSEQ.halfpi + (n - 1) * SingleLen_C + SpinLockGap + gmSEQ.SLockT1 + SpinLockGap + gmSEQ.SLockT2, ...
               gSG.AWGFreq, ...
               3 * pi / 2, ...
               gSG.AWGAmp * gmSEQ.SAmp2];
       WaveForm_1Q = [WaveForm_1Q; ...
           gmSEQ.halfpi + (n - 1) * SingleLen_C + SpinLockGap, ...
               gmSEQ.halfpi + (n - 1) * SingleLen_C + SpinLockGap + gmSEQ.SLockT1, ...
               gSG.AWGFreq, ...
               pi / 2 - pi / 2, ...
               gSG.AWGAmp * gmSEQ.SAmp1; ...
           gmSEQ.halfpi + (n - 1) * SingleLen_C + SpinLockGap + gmSEQ.SLockT1 + SpinLockGap, ...
               gmSEQ.halfpi + (n - 1) * SingleLen_C + SpinLockGap + gmSEQ.SLockT1 + SpinLockGap + gmSEQ.SLockT2, ...
               gSG.AWGFreq, ...
               3 * pi / 2 - pi/2, ...
               gSG.AWGAmp * gmSEQ.SAmp2];     
    end
    
    if gmSEQ.CoolSwitch == 1
        WaveForm_1I = [WaveForm_1I; ...
            gmSEQ.halfpi+gmSEQ.LockN0*SingleLen_C+SpinLockGap, ...
            gmSEQ.halfpi+gmSEQ.LockN0*SingleLen_C+SpinLockGap+gmSEQ.halfpi, ...
             gSG.AWGFreq, ...
             2 * pi / 2, ...
             gSG.AWGAmp];
         WaveForm_1Q = [WaveForm_1Q; ...
            gmSEQ.halfpi+gmSEQ.LockN0*SingleLen_C+SpinLockGap, ...
            gmSEQ.halfpi+gmSEQ.LockN0*SingleLen_C+SpinLockGap+gmSEQ.halfpi, ...
             gSG.AWGFreq, ...
             2 * pi / 2 - pi / 2, ...
             gSG.AWGAmp];
                      
    elseif gmSEQ.CoolSwitch == 2
         WaveForm_1I = [WaveForm_1I; ...
            gmSEQ.halfpi+gmSEQ.LockN0*SingleLen_C+SpinLockGap, ...
            gmSEQ.halfpi+gmSEQ.LockN0*SingleLen_C+SpinLockGap+gmSEQ.halfpi, ...
             gSG.AWGFreq, ...
             0 * pi / 2, ...
             gSG.AWGAmp];
         WaveForm_1Q = [WaveForm_1Q; ...
            gmSEQ.halfpi+gmSEQ.LockN0*SingleLen_C+SpinLockGap, ...
            gmSEQ.halfpi+gmSEQ.LockN0*SingleLen_C+SpinLockGap+gmSEQ.halfpi, ...
             gSG.AWGFreq, ...
             0 * pi / 2 - pi / 2, ...
             gSG.AWGAmp];
        
    end
    
    WaveForm_1Length = ceil((gmSEQ.halfpi + LockLenCool + gmSEQ.halfpi + 1000) / (16 / gSG.AWGClockRate)) ...
        *(16 / gSG.AWGClockRate);
    WaveForm_1PointNum = WaveForm_1Length * gSG.AWGClockRate;
    
%%%% Measuring Waveforms.    
    if gmSEQ.CoolSwitch <2 
        WaveForm_2I = [0, gmSEQ.halfpi, gSG.AWGFreq, 0, gSG.AWGAmp]; 
        WaveForm_2Q = [0, gmSEQ.halfpi, gSG.AWGFreq, -pi/2, gSG.AWGAmp];    
    elseif gmSEQ.CoolSwitch == 2
        WaveForm_2I = [0, gmSEQ.halfpi, gSG.AWGFreq, 0+0, gSG.AWGAmp]; 
        WaveForm_2Q = [0, gmSEQ.halfpi, gSG.AWGFreq, 0-pi/2, gSG.AWGAmp];    
    end

    for n = 1 : gmSEQ.m  % add segments of [t1(Omega_y) -> t2(-Omega_y)]
        WaveForm_2I = [WaveForm_2I; ...
           gmSEQ.halfpi + (n - 1) * SingleLen_M + SpinLockGap, ...
               gmSEQ.halfpi + (n - 1) * SingleLen_M + SpinLockGap + gmSEQ.SLockT1_M, ...
               gSG.AWGFreq, ...
               pi / 2, gSG.AWGAmp * gmSEQ.SAmp1_M;...
           gmSEQ.halfpi + (n - 1) * SingleLen_M + SpinLockGap + gmSEQ.SLockT1_M + SpinLockGap, ...
               gmSEQ.halfpi + (n - 1) * SingleLen_M + SpinLockGap + gmSEQ.SLockT1_M + SpinLockGap + gmSEQ.SLockT2_M, ...
               gSG.AWGFreq, ...
               3 * pi / 2, ...
               gSG.AWGAmp * gmSEQ.SAmp2_M];
        WaveForm_2Q = [WaveForm_2Q; ...
           gmSEQ.halfpi + (n - 1) * SingleLen_M + SpinLockGap, ...
               gmSEQ.halfpi + (n - 1) * SingleLen_M + SpinLockGap + gmSEQ.SLockT1_M, ...
               gSG.AWGFreq, ...
               pi / 2 - pi / 2, gSG.AWGAmp*gmSEQ.SAmp1_M;...
           gmSEQ.halfpi + (n - 1) * SingleLen_M + SpinLockGap + gmSEQ.SLockT1_M + SpinLockGap, ...
               gmSEQ.halfpi + (n - 1) * SingleLen_M + SpinLockGap + gmSEQ.SLockT1_M + SpinLockGap + gmSEQ.SLockT2_M, ...
               gSG.AWGFreq, ...
               3 * pi / 2 - pi / 2, ...
               gSG.AWGAmp * gmSEQ.SAmp2_M];   
    end
    
    if gmSEQ.CoolSwitch <2 
    WaveForm_2I = [WaveForm_2I; ...
        gmSEQ.halfpi + gmSEQ.m * SingleLen_M + SpinLockGap, ...
            gmSEQ.halfpi + gmSEQ.m * SingleLen_M + SpinLockGap + gmSEQ.halfpi,...
            gSG.AWGFreq, ...
            2 * pi / 2, ...
            gSG.AWGAmp];
    WaveForm_2Q = [WaveForm_2Q; ...
        gmSEQ.halfpi + gmSEQ.m * SingleLen_M + SpinLockGap, ...
            gmSEQ.halfpi + gmSEQ.m * SingleLen_M + SpinLockGap + gmSEQ.halfpi,...
            gSG.AWGFreq, ...
            2 * pi / 2 - pi / 2, ...
            gSG.AWGAmp];
    elseif gmSEQ.CoolSwitch == 2
    WaveForm_2I = [WaveForm_2I; ...
        gmSEQ.halfpi + gmSEQ.m * SingleLen_M + SpinLockGap, ...
            gmSEQ.halfpi + gmSEQ.m * SingleLen_M + SpinLockGap + gmSEQ.halfpi,...
            gSG.AWGFreq, ...
            2 * pi / 2, ...
            gSG.AWGAmp];
    WaveForm_2Q = [WaveForm_2Q; ...
        gmSEQ.halfpi + gmSEQ.m * SingleLen_M + SpinLockGap, ...
            gmSEQ.halfpi + gmSEQ.m * SingleLen_M + SpinLockGap + gmSEQ.halfpi,...
            gSG.AWGFreq, ...
            2 * pi / 2 - pi / 2, ...
            gSG.AWGAmp];     
    end
    
%%%% Differential Measuring Waveforms. Just add another pi_y pulse at the
%%%% end.
    WaveForm_3I = [WaveForm_2I; ...
        gmSEQ.halfpi + gmSEQ.m * SingleLen_M + SpinLockGap + gmSEQ.halfpi + PulseGap, ...
            gmSEQ.halfpi + gmSEQ.m * SingleLen_M + SpinLockGap + gmSEQ.halfpi + PulseGap + gmSEQ.pi, ...
            gSG.AWGFreq, ...
            pi / 2, gSG.AWGAmp];
    WaveForm_3Q = [WaveForm_2Q; ...
        gmSEQ.halfpi + gmSEQ.m * SingleLen_M + SpinLockGap + gmSEQ.halfpi + PulseGap, ...
            gmSEQ.halfpi + gmSEQ.m * SingleLen_M + SpinLockGap + gmSEQ.halfpi + PulseGap + gmSEQ.pi, ...
            gSG.AWGFreq, ...
            pi / 2 - pi / 2, gSG.AWGAmp]; 
    
    WaveForm_2Length = ceil((gmSEQ.halfpi + LockLenMeasure + SpinLockGap + gmSEQ.halfpi + PulseGap + gmSEQ.pi + 1000) / (16 / gSG.AWGClockRate)) ...
        * (16 / gSG.AWGClockRate);
    WaveForm_2PointNum = WaveForm_2Length * gSG.AWGClockRate;
    WaveForm_3Length = WaveForm_2Length;
    WaveForm_3PointNum = WaveForm_2PointNum;
    
    % NV pulse to mix up NV
     WaveForm_4I = [0, gmSEQ.halfpi, gSG.AWGFreq, 0, gSG.AWGAmp; ...
         10000, 10000+gmSEQ.halfpi,  gSG.AWGFreq, 0, gSG.AWGAmp; ...
         20000, 20000+gmSEQ.halfpi,  gSG.AWGFreq, 0, gSG.AWGAmp; ...
         30000, 30000+gmSEQ.halfpi,  gSG.AWGFreq, 0, gSG.AWGAmp];
     WaveForm_4Q = [0, gmSEQ.halfpi, gSG.AWGFreq, -pi/2, gSG.AWGAmp; ...
         10000, 10000+gmSEQ.halfpi,  gSG.AWGFreq, -pi/2, gSG.AWGAmp; ...
         20000, 20000+gmSEQ.halfpi,  gSG.AWGFreq, -pi/2, gSG.AWGAmp; ...
         30000, 30000+gmSEQ.halfpi,  gSG.AWGFreq, -pi/2, gSG.AWGAmp];
    
    WaveForm_4Length = ceil((30000+gmSEQ.halfpi+1000) / (16 / gSG.AWGClockRate)) ...
        * (16 / gSG.AWGClockRate);
    WaveForm_4PointNum = WaveForm_4Length * gSG.AWGClockRate;
    
    
else
    questdlg('Only AC mnodulation works for now, please check AC modulation~',...
        'Heating / Cooling Sequence', 'Cancel');
end
%%% Create Wave Form Text Files
chaseFunctionPool('createWaveform', WaveForm_1I, gSG.AWGClockRate, WaveForm_1Length, 'SpecialCooling_I_seg1.txt'); pause(0.5);
chaseFunctionPool('createWaveform', WaveForm_1Q, gSG.AWGClockRate, WaveForm_1Length, 'SpecialCooling_Q_seg1.txt'); pause(0.5);
chaseFunctionPool('createWaveform', WaveForm_2I, gSG.AWGClockRate, WaveForm_2Length, 'SpecialCooling_I_seg2.txt'); pause(0.5);
chaseFunctionPool('createWaveform', WaveForm_2Q, gSG.AWGClockRate, WaveForm_2Length, 'SpecialCooling_Q_seg2.txt'); pause(0.5);
chaseFunctionPool('createWaveform', WaveForm_3I, gSG.AWGClockRate, WaveForm_3Length, 'SpecialCooling_I_seg3.txt'); pause(0.5);
chaseFunctionPool('createWaveform', WaveForm_3Q, gSG.AWGClockRate, WaveForm_3Length, 'SpecialCooling_Q_seg3.txt'); pause(0.5);
chaseFunctionPool('createWaveform', WaveForm_4I, gSG.AWGClockRate, WaveForm_4Length, 'SpecialCooling_I_seg4.txt'); pause(0.5);
chaseFunctionPool('createWaveform', WaveForm_4Q, gSG.AWGClockRate, WaveForm_4Length, 'SpecialCooling_Q_seg4.txt'); pause(0.5);

%%% Create Wave Form Structs -> Pass Segments to AWG
if gmSEQ.CoolCycle == 0
    chaseFunctionPool('createSegStruct', 'SpecialCooling_SegStruct_I.txt', ...
        'SpecialCooling_I_seg4.txt', WaveForm_4PointNum, 1, 1, ...
        'SpecialCooling_I_seg2.txt', WaveForm_2PointNum, 1, 1, ...
        'SpecialCooling_I_seg4.txt', WaveForm_4PointNum, 1, 1, ...
        'SpecialCooling_I_seg3.txt', WaveForm_3PointNum, 1, 1);
    pause(0.5);
    chaseFunctionPool('createSegStruct', 'SpecialCooling_SegStruct_Q.txt', ...
        'SpecialCooling_Q_seg4.txt', WaveForm_4PointNum, 1, 1, ...
        'SpecialCooling_Q_seg2.txt', WaveForm_2PointNum, 1, 1, ...
        'SpecialCooling_Q_seg4.txt', WaveForm_4PointNum, 1, 1, ...
        'SpecialCooling_Q_seg3.txt', WaveForm_3PointNum, 1, 1);
    pause(0.5);
    chaseFunctionPool('CreateSegments', 1, 1, ...
        4, ...
        2047, 2047, 'SpecialCooling_SegStruct_I.txt', 'false');
    pause(1); % this pause seems to be important, otherwise the loading is not right occassionally
    chaseFunctionPool('CreateSegments', 1, 2, ...
        4, ...
        2047, 2047, 'SpecialCooling_SegStruct_Q.txt', 'false');
    pause(1); % this pause seems to be important, otherwise the loading is not right occassionally
    chaseFunctionPool('runChase', 1, 'false');
elseif gmSEQ.CoolCycle == 1
    chaseFunctionPool('createSegStruct', 'SpecialCooling_SegStruct_I.txt', ...
        'SpecialCooling_I_seg4.txt', WaveForm_4PointNum, 1, 1, ...
        'SpecialCooling_I_seg1.txt', WaveForm_1PointNum, 1, 1, ...
        'SpecialCooling_I_seg2.txt', WaveForm_2PointNum, 1, 1, ...
        'SpecialCooling_I_seg4.txt', WaveForm_4PointNum, 1, 1, ...
        'SpecialCooling_I_seg1.txt', WaveForm_1PointNum, 1, 1, ...
        'SpecialCooling_I_seg3.txt', WaveForm_3PointNum, 1, 1);
    pause(0.5);
    chaseFunctionPool('createSegStruct', 'SpecialCooling_SegStruct_Q.txt', ...
        'SpecialCooling_Q_seg4.txt', WaveForm_4PointNum, 1, 1, ...
        'SpecialCooling_Q_seg1.txt', WaveForm_1PointNum, 1, 1, ...
        'SpecialCooling_Q_seg2.txt', WaveForm_2PointNum, 1, 1, ...
        'SpecialCooling_Q_seg4.txt', WaveForm_4PointNum, 1, 1, ...
        'SpecialCooling_Q_seg1.txt', WaveForm_1PointNum, 1, 1, ...
        'SpecialCooling_Q_seg3.txt', WaveForm_3PointNum, 1, 1);
    pause(0.5);
    chaseFunctionPool('CreateSegments', 1, 1, ...
        6, ...
        2047, 2047, 'SpecialCooling_SegStruct_I.txt', 'false');
    pause(1); % this pause seems to be important, otherwise the loading is not right occassionally
    chaseFunctionPool('CreateSegments', 1, 2, ...
        6, ...
        2047, 2047, 'SpecialCooling_SegStruct_Q.txt', 'false');
    pause(1); % this pause seems to be important, otherwise the loading is not right occassionally
    chaseFunctionPool('runChase', 1, 'false');
elseif gmSEQ.CoolCycle < 500
chaseFunctionPool('createSegStruct', 'SpecialCooling_SegStruct_I.txt', ...
    'SpecialCooling_I_seg4.txt', WaveForm_4PointNum, 1, 1, ...
    'SpecialCooling_I_seg1.txt', WaveForm_1PointNum, 1, 1, ... % The first repeatition cannot be looped and must be triggered, so must be left out.
    'SpecialCooling_I_seg1.txt', WaveForm_1PointNum, gmSEQ.CoolCycle - 1, 1, ...
    'SpecialCooling_I_seg2.txt', WaveForm_2PointNum, 1, 1, ...
    'SpecialCooling_I_seg4.txt', WaveForm_4PointNum, 1, 1, ...
    'SpecialCooling_I_seg1.txt', WaveForm_1PointNum, 1, 1, ... % This one just to make sure things are symmetric.
    'SpecialCooling_I_seg1.txt', WaveForm_1PointNum, gmSEQ.CoolCycle - 1, 1, ...
    'SpecialCooling_I_seg3.txt', WaveForm_3PointNum, 1, 1);
pause(0.5);
chaseFunctionPool('createSegStruct', 'SpecialCooling_SegStruct_Q.txt', ...
    'SpecialCooling_Q_seg4.txt', WaveForm_4PointNum, 1, 1, ...
    'SpecialCooling_Q_seg1.txt', WaveForm_1PointNum, 1, 1, ... 
    'SpecialCooling_Q_seg1.txt', WaveForm_1PointNum, gmSEQ.CoolCycle - 1, 1, ...
    'SpecialCooling_Q_seg2.txt', WaveForm_2PointNum, 1, 1, ...
    'SpecialCooling_Q_seg4.txt', WaveForm_4PointNum, 1, 1, ...
    'SpecialCooling_Q_seg1.txt', WaveForm_1PointNum, 1, 1, ...
    'SpecialCooling_Q_seg1.txt', WaveForm_1PointNum, gmSEQ.CoolCycle - 1, 1, ...
    'SpecialCooling_Q_seg3.txt', WaveForm_3PointNum, 1, 1);
pause(0.5);    
chaseFunctionPool('CreateSegments', 1, 1, ...
    8, ...
    2047, 2047, 'SpecialCooling_SegStruct_I.txt', 'false');
pause(3); % this pause seems to be important, otherwise the loading is not right occassionally
chaseFunctionPool('CreateSegments', 1, 2, ...
    8, ...
    2047, 2047, 'SpecialCooling_SegStruct_Q.txt', 'false');
pause(3); % this pause seems to be important, otherwise the loading is not right occassionally
%%% Run AWG.
chaseFunctionPool('runChase', 1, 'false');

end

ApplyDelays();    

function SpecialCooling_P1_2

global gmSEQ gSG gSG2
gSG.bfixedPow = 1;
gSG.bfixedFreq = 1;
gSG.bMod = 'IQ';
gSG.bModSrc = 'External';

gSG2.bMod='IQ';
gSG2.bModSrc='External';
SignalGeneratorFunctionPool2('SetMod');

SignalGeneratorFunctionPool2('WritePow');
SignalGeneratorFunctionPool2('WriteFreq');
gSG2.bOn=1; SignalGeneratorFunctionPool2('RFOnOff');

% If PL signal is collected via APD.
if strcmp(gmSEQ.meas,'APD') 
    gmSEQ.CtrGateDur = 1000;
end

% Cooling sequence [pi/2_x->[t1(Omega_y) -> t2(-Omega_y)]^{N_0}]^{Cooling cycle}...

gmSEQ.halfpi = gmSEQ.pi/2;
Wait_p = 30e6; % to wait for P1 to be fully unpolarized again
AfterPi = 1000;
AfterLaser = 2000;
Detect_Window = 15000;
PulseGap = 30;
SpinLockGap = 0; % The gap (in ns) between t1(Omega) and t2(-Omega).

SingleLen_C = 2 * SpinLockGap + gmSEQ.SLockT1 + gmSEQ.SLockT2; % Length of cooling segment [t1(Omega_y) -> t2(-Omega_y)]
LockLenCool = gmSEQ.LockN0 * SingleLen_C;

SingleLen_M = 1*(2*SpinLockGap+gmSEQ.SLockT1_M + gmSEQ.SLockT2_M); % Length of measuring segment [t1(Omega_y) -> t2(-Omega_y)]
LockLenMeasure = gmSEQ.m * SingleLen_M;

AfterLock = 1000;
% Cooling_Readout = gmSEQ.readout;
Cooling_Readout = 1000;

CoolCycleT = Cooling_Readout + AfterLaser + gmSEQ.halfpi + LockLenCool + gmSEQ.halfpi + AfterLock;
CoolCycleT = ceil(CoolCycleT * gSG.AWGClockRate / 16) / (gSG.AWGClockRate / 16);

%% Pulse Blaster
%%% AOM
% Cooling
gmSEQ.CHN(1).PBN=PBDictionary('AOM');
gmSEQ.CHN(1).NRise = 2 * (2 + gmSEQ.CoolCycle);
    gmSEQ.CHN(1).T = [];
    gmSEQ.CHN(1).DT = [];
    for n = 1 : gmSEQ.CoolCycle
        gmSEQ.CHN(1).T = [gmSEQ.CHN(1).T, Wait_p + (n - 1) * CoolCycleT];
        gmSEQ.CHN(1).DT = [gmSEQ.CHN(1).DT, Cooling_Readout];
    end
% Cooling - Measurement
    gmSEQ.CHN(1).T = [gmSEQ.CHN(1).T, ...
        Wait_p + gmSEQ.CoolCycle * CoolCycleT + gmSEQ.CoolWait, ...
        Wait_p + gmSEQ.CoolCycle * CoolCycleT + gmSEQ.CoolWait ...
            + gmSEQ.readout + AfterLaser + gmSEQ.halfpi + LockLenMeasure ...
            + SpinLockGap + gmSEQ.halfpi + PulseGap + gmSEQ.pi+ AfterPi];
    gmSEQ.CHN(1).DT = [gmSEQ.CHN(1).DT, gmSEQ.readout, Detect_Window]; 
% Differential Cooling
    Start_Sig_D = Wait_p + gmSEQ.CoolCycle * CoolCycleT + gmSEQ.CoolWait ...
        + gmSEQ.readout + AfterLaser + gmSEQ.halfpi + LockLenMeasure ...
        + SpinLockGap + gmSEQ.halfpi + PulseGap + gmSEQ.pi + AfterPi ...
        + Detect_Window + Wait_p;
    for n = 1 : gmSEQ.CoolCycle
        gmSEQ.CHN(1).T = [gmSEQ.CHN(1).T, Start_Sig_D + (n - 1) * CoolCycleT];
        gmSEQ.CHN(1).DT = [gmSEQ.CHN(1).DT, Cooling_Readout];
    end
% Differential Cooling - Measurement
    gmSEQ.CHN(1).T = [gmSEQ.CHN(1).T, ...
        Start_Sig_D + gmSEQ.CoolCycle * CoolCycleT + gmSEQ.CoolWait, ...
        Start_Sig_D + gmSEQ.CoolCycle  *CoolCycleT + gmSEQ.CoolWait ...
            + gmSEQ.readout + AfterLaser + gmSEQ.halfpi + LockLenMeasure ...
            + SpinLockGap + gmSEQ.halfpi + PulseGap + gmSEQ.pi + AfterPi];
    gmSEQ.CHN(1).DT = [gmSEQ.CHN(1).DT, gmSEQ.readout, Detect_Window];

%%% APD
% gmSEQ.CHN(numel(gmSEQ.CHN)+1).PBN=PBDictionary('ctr0');
% gmSEQ.CHN(numel(gmSEQ.CHN)).NRise = 4;
% gmSEQ.CHN(numel(gmSEQ.CHN)).T = [gmSEQ.CHN(1).T(gmSEQ.CoolCycle + 1) + gmSEQ.readout - 1000, ...
%     gmSEQ.CHN(1).T(gmSEQ.CoolCycle + 2), ...
%     gmSEQ.CHN(1).T(2 * gmSEQ.CoolCycle + 3) + gmSEQ.readout - 1000, ...
%     gmSEQ.CHN(1).T(2 * gmSEQ.CoolCycle + 4)];
% gmSEQ.CHN(numel(gmSEQ.CHN)).DT = repelem(gmSEQ.CtrGateDur, 1, 4);

gmSEQ.CHN(numel(gmSEQ.CHN)+1).PBN=PBDictionary('ctr0');
gmSEQ.CHN(numel(gmSEQ.CHN)).NRise = 4;
gmSEQ.CHN(numel(gmSEQ.CHN)).T = [gmSEQ.CHN(1).T(gmSEQ.CoolCycle + 2), ...
    gmSEQ.CHN(1).T(gmSEQ.CoolCycle + 2)+Detect_Window-1000-gmSEQ.CtrGateDur, ...
    gmSEQ.CHN(1).T(2 * gmSEQ.CoolCycle + 4), ...
    gmSEQ.CHN(1).T(2 * gmSEQ.CoolCycle + 4)+Detect_Window-1000-gmSEQ.CtrGateDur];
gmSEQ.CHN(numel(gmSEQ.CHN)).DT = repelem(gmSEQ.CtrGateDur, 1, 4);

% Note that for sequence length ~ 2ms / 20ms, the timing difference between
% PulseBlaster and AWG is ~ 10ns / 100ns

% MW Switch
% Cooling -> Cooling - Measurement
gmSEQ.CHN(numel(gmSEQ.CHN) + 1).PBN=PBDictionary('MWSwitch');
gmSEQ.CHN(numel(gmSEQ.CHN)).NRise= 2 + 2 * gmSEQ.CoolCycle + 8;
gmSEQ.CHN(numel(gmSEQ.CHN)).T = [10000-30 20000-30 30000-30 40000-30];
gmSEQ.CHN(numel(gmSEQ.CHN)).DT = [gmSEQ.halfpi+54 gmSEQ.halfpi+54 gmSEQ.halfpi+54 gmSEQ.halfpi+54];
for n = 1 : gmSEQ.CoolCycle
    gmSEQ.CHN(numel(gmSEQ.CHN)).T = [gmSEQ.CHN(numel(gmSEQ.CHN)).T, ...
        Wait_p + (n - 1) * CoolCycleT + Cooling_Readout + AfterLaser - 30]; % double the buffer around IQ.
    gmSEQ.CHN(numel(gmSEQ.CHN)).DT = [gmSEQ.CHN(numel(gmSEQ.CHN)).DT, ...
        gmSEQ.halfpi + LockLenCool + gmSEQ.halfpi + 54];
end
gmSEQ.CHN(numel(gmSEQ.CHN)).T = [gmSEQ.CHN(numel(gmSEQ.CHN)).T, ...
    Wait_p + gmSEQ.CoolCycle * CoolCycleT + gmSEQ.CoolWait + gmSEQ.readout + AfterLaser - 30];
gmSEQ.CHN(numel(gmSEQ.CHN)).DT = [gmSEQ.CHN(numel(gmSEQ.CHN)).DT, ...
    gmSEQ.halfpi + LockLenMeasure + SpinLockGap + gmSEQ.halfpi + 54];
% Differential Cooling -> Differential Cooling - Measurement


gmSEQ.CHN(numel(gmSEQ.CHN)).T = [gmSEQ.CHN(numel(gmSEQ.CHN)).T, ...
    Start_Sig_D-Wait_p+10000-30 Start_Sig_D-Wait_p+20000-30 Start_Sig_D-Wait_p+30000-30 Start_Sig_D-Wait_p+40000-30];
gmSEQ.CHN(numel(gmSEQ.CHN)).DT = [gmSEQ.CHN(numel(gmSEQ.CHN)).DT gmSEQ.halfpi+54 gmSEQ.halfpi+54 gmSEQ.halfpi+54 gmSEQ.halfpi+54];

for n = 1 : gmSEQ.CoolCycle
    gmSEQ.CHN(numel(gmSEQ.CHN)).T = [gmSEQ.CHN(numel(gmSEQ.CHN)).T, ...
        Start_Sig_D + (n - 1) * CoolCycleT + Cooling_Readout + AfterLaser - 30];
    gmSEQ.CHN(numel(gmSEQ.CHN)).DT = [gmSEQ.CHN(numel(gmSEQ.CHN)).DT, ...
        gmSEQ.halfpi + LockLenCool + gmSEQ.halfpi + 54];
end
gmSEQ.CHN(numel(gmSEQ.CHN)).T = [gmSEQ.CHN(numel(gmSEQ.CHN)).T, ...
    Start_Sig_D + gmSEQ.CoolCycle * CoolCycleT + gmSEQ.CoolWait + gmSEQ.readout + AfterLaser - 30];
gmSEQ.CHN(numel(gmSEQ.CHN)).DT = [gmSEQ.CHN(numel(gmSEQ.CHN)).DT, ...
    gmSEQ.halfpi + LockLenMeasure + SpinLockGap + gmSEQ.halfpi + PulseGap + gmSEQ.pi + 54];


%%% Dummy 1: to check the total length of the sequence.
Max_length = 2 * Wait_p + 2 * gmSEQ.CoolCycle * CoolCycleT ...
    + 2 * gmSEQ.CoolWait + 2 * gmSEQ.readout + 2 * Detect_Window ...
    + 2 * (AfterLaser + AfterPi + gmSEQ.halfpi + LockLenMeasure + SpinLockGap + gmSEQ.halfpi + PulseGap + gmSEQ.pi);
gmSEQ.CHN(numel(gmSEQ.CHN) + 1).PBN = PBDictionary('dummy1');
gmSEQ.CHN(numel(gmSEQ.CHN)).NRise = 2;
gmSEQ.CHN(numel(gmSEQ.CHN)).T = [0, Max_length-200];
gmSEQ.CHN(numel(gmSEQ.CHN)).DT = [200, 200];

% Adding P1 pulse during the cooling process

gmSEQ.CHN(numel(gmSEQ.CHN) + 1).PBN=PBDictionary('MWSwitch2');
gmSEQ.CHN(numel(gmSEQ.CHN)).NRise= 2 * gmSEQ.CoolCycle;
gmSEQ.CHN(numel(gmSEQ.CHN)).T = [];
gmSEQ.CHN(numel(gmSEQ.CHN)).DT = [];
for n = 1 : gmSEQ.CoolCycle
    gmSEQ.CHN(numel(gmSEQ.CHN)).T = [gmSEQ.CHN(numel(gmSEQ.CHN)).T, ...
        Wait_p + (n - 1) * CoolCycleT + Cooling_Readout + AfterLaser + gmSEQ.halfpi + 20]; % double the buffer around IQ.
    gmSEQ.CHN(numel(gmSEQ.CHN)).DT = [gmSEQ.CHN(numel(gmSEQ.CHN)).DT, ...
        LockLenCool - 40];
end

% Differential Cooling -> Differential Cooling - Measurement
for n = 1 : gmSEQ.CoolCycle
    gmSEQ.CHN(numel(gmSEQ.CHN)).T = [gmSEQ.CHN(numel(gmSEQ.CHN)).T, ...
        Start_Sig_D + (n - 1) * CoolCycleT + Cooling_Readout + AfterLaser];
    gmSEQ.CHN(numel(gmSEQ.CHN)).DT = [gmSEQ.CHN(numel(gmSEQ.CHN)).DT, ...
       LockLenCool - 40];
end

gmSEQ.CHN(numel(gmSEQ.CHN) + 1).PBN=PBDictionary('I_2');
gmSEQ.CHN(numel(gmSEQ.CHN)).NRise= 2 * gmSEQ.CoolCycle;
gmSEQ.CHN(numel(gmSEQ.CHN)).T = [];
gmSEQ.CHN(numel(gmSEQ.CHN)).DT = [];
for n = 1 : gmSEQ.CoolCycle
    gmSEQ.CHN(numel(gmSEQ.CHN)).T = [gmSEQ.CHN(numel(gmSEQ.CHN)).T, ...
        Wait_p + (n - 1) * CoolCycleT + Cooling_Readout + AfterLaser + gmSEQ.halfpi + 20]; % double the buffer around IQ.
    gmSEQ.CHN(numel(gmSEQ.CHN)).DT = [gmSEQ.CHN(numel(gmSEQ.CHN)).DT, ...
        LockLenCool - 40];
end

% Differential Cooling -> Differential Cooling - Measurement
for n = 1 : gmSEQ.CoolCycle
    gmSEQ.CHN(numel(gmSEQ.CHN)).T = [gmSEQ.CHN(numel(gmSEQ.CHN)).T, ...
        Start_Sig_D + (n - 1) * CoolCycleT + Cooling_Readout + AfterLaser];
    gmSEQ.CHN(numel(gmSEQ.CHN)).DT = [gmSEQ.CHN(numel(gmSEQ.CHN)).DT, ...
       LockLenCool - 40];
end


%%% AWG Trigger
% Each repeatition of the segement need one trigger, a total of 2 *
% (CoolCycle + 1) triggers are needed.
% Cooling -> Cooling - Measurement
gmSEQ.CHN(numel(gmSEQ.CHN)+1).PBN = PBDictionary('AWGTrig');
gmSEQ.CHN(numel(gmSEQ.CHN)).NRise = 2 + 2 + gmSEQ.CoolCycle * 2;
gmSEQ.CHN(numel(gmSEQ.CHN)).T = [10000];
gmSEQ.CHN(numel(gmSEQ.CHN)).DT = [1000];
for n = 1 : gmSEQ.CoolCycle
gmSEQ.CHN(numel(gmSEQ.CHN)).T = [gmSEQ.CHN(numel(gmSEQ.CHN)).T, ... 
    Wait_p + (n - 1) * CoolCycleT + Cooling_Readout + AfterLaser];
gmSEQ.CHN(numel(gmSEQ.CHN)).DT = [gmSEQ.CHN(numel(gmSEQ.CHN)).DT, 500];
end

gmSEQ.CHN(numel(gmSEQ.CHN)).T = [gmSEQ.CHN(numel(gmSEQ.CHN)).T, ...
    Wait_p + gmSEQ.CoolCycle * CoolCycleT + gmSEQ.CoolWait + gmSEQ.readout + AfterLaser];
gmSEQ.CHN(numel(gmSEQ.CHN)).DT=[gmSEQ.CHN(numel(gmSEQ.CHN)).DT, 500];

gmSEQ.CHN(numel(gmSEQ.CHN)).T = [gmSEQ.CHN(numel(gmSEQ.CHN)).T, ...
    Start_Sig_D-Wait_p+10000];
gmSEQ.CHN(numel(gmSEQ.CHN)).DT=[gmSEQ.CHN(numel(gmSEQ.CHN)).DT, 1000];

% Differential Cooling -> Differential Cooling - Measurement
for n = 1:gmSEQ.CoolCycle
gmSEQ.CHN(numel(gmSEQ.CHN)).T = [gmSEQ.CHN(numel(gmSEQ.CHN)).T, ...
    Start_Sig_D + (n - 1) * CoolCycleT + Cooling_Readout + AfterLaser];
gmSEQ.CHN(numel(gmSEQ.CHN)).DT = [gmSEQ.CHN(numel(gmSEQ.CHN)).DT, 500];
end
gmSEQ.CHN(numel(gmSEQ.CHN)).T = [gmSEQ.CHN(numel(gmSEQ.CHN)).T, ...
    Start_Sig_D + gmSEQ.CoolCycle * CoolCycleT + gmSEQ.CoolWait + gmSEQ.readout + AfterLaser];
gmSEQ.CHN(numel(gmSEQ.CHN)).DT = [gmSEQ.CHN(numel(gmSEQ.CHN)).DT, 500]; 

%% AWG
%%% Initialization
chaseFunctionPool('stopChase', 1)
%%% Generating wave form
if gSG.ACmodAWG 
    WaveForm_1I = [];
    WaveForm_1Q = [];
%%%% Cooling / Heating Waveforms.
% |gmSEQ.CoolSwitch| controls whether cooling / heating is turned on. 
    if gmSEQ.CoolSwitch == 1 % Cooling
        WaveForm_1I = [WaveForm_1I; ...
            0, gmSEQ.halfpi, gSG.AWGFreq, 0, gSG.AWGAmp]; % The 1st pi/2_x pulse.
        WaveForm_1Q = [WaveForm_1Q; ...
            0, gmSEQ.halfpi, gSG.AWGFreq, - pi / 2, gSG.AWGAmp];
    elseif gmSEQ.CoolSwitch == 2 % Heating
        WaveForm_1I = [WaveForm_1I; ...
            0, gmSEQ.halfpi, gSG.AWGFreq, pi, gSG.AWGAmp];
        WaveForm_1Q = [WaveForm_1Q; ...
            0, gmSEQ.halfpi, gSG.AWGFreq, pi - pi / 2, gSG.AWGAmp];
    elseif gmSEQ.CoolSwitch == 0 % Nothing
        WaveForm_1I = [WaveForm_1I; ...
            0, gmSEQ.halfpi, 0, 0, 0];
        WaveForm_1Q = [WaveForm_1Q; ...
            0, gmSEQ.halfpi, 0, 0, 0];
    end
    
    for n = 1 : gmSEQ.LockN0 % add segments of [t1(Omega_y) -> t2(-Omega_y)]
       WaveForm_1I = [WaveForm_1I; ...
           gmSEQ.halfpi + (n - 1) * SingleLen_C + SpinLockGap, ...
               gmSEQ.halfpi + (n - 1) * SingleLen_C + SpinLockGap + gmSEQ.SLockT1, ...
               gSG.AWGFreq, ...
               pi / 2, ...
               gSG.AWGAmp * gmSEQ.SAmp1; ...
           gmSEQ.halfpi + (n - 1) * SingleLen_C + SpinLockGap + gmSEQ.SLockT1 + SpinLockGap, ...
               gmSEQ.halfpi + (n - 1) * SingleLen_C + SpinLockGap + gmSEQ.SLockT1 + SpinLockGap + gmSEQ.SLockT2, ...
               gSG.AWGFreq, ...
               3 * pi / 2, ...
               gSG.AWGAmp * gmSEQ.SAmp2];
       WaveForm_1Q = [WaveForm_1Q; ...
           gmSEQ.halfpi + (n - 1) * SingleLen_C + SpinLockGap, ...
               gmSEQ.halfpi + (n - 1) * SingleLen_C + SpinLockGap + gmSEQ.SLockT1, ...
               gSG.AWGFreq, ...
               pi / 2 - pi / 2, ...
               gSG.AWGAmp * gmSEQ.SAmp1; ...
           gmSEQ.halfpi + (n - 1) * SingleLen_C + SpinLockGap + gmSEQ.SLockT1 + SpinLockGap, ...
               gmSEQ.halfpi + (n - 1) * SingleLen_C + SpinLockGap + gmSEQ.SLockT1 + SpinLockGap + gmSEQ.SLockT2, ...
               gSG.AWGFreq, ...
               3 * pi / 2 - pi/2, ...
               gSG.AWGAmp * gmSEQ.SAmp2];     
    end
    
    if gmSEQ.CoolSwitch == 1
        WaveForm_1I = [WaveForm_1I; ...
            gmSEQ.halfpi+gmSEQ.LockN0*SingleLen_C+SpinLockGap, ...
            gmSEQ.halfpi+gmSEQ.LockN0*SingleLen_C+SpinLockGap+gmSEQ.halfpi, ...
             gSG.AWGFreq, ...
             2 * pi / 2, ...
             gSG.AWGAmp];
         WaveForm_1Q = [WaveForm_1Q; ...
            gmSEQ.halfpi+gmSEQ.LockN0*SingleLen_C+SpinLockGap, ...
            gmSEQ.halfpi+gmSEQ.LockN0*SingleLen_C+SpinLockGap+gmSEQ.halfpi, ...
             gSG.AWGFreq, ...
             2 * pi / 2 - pi / 2, ...
             gSG.AWGAmp];
                      
    elseif gmSEQ.CoolSwitch == 2
         WaveForm_1I = [WaveForm_1I; ...
            gmSEQ.halfpi+gmSEQ.LockN0*SingleLen_C+SpinLockGap, ...
            gmSEQ.halfpi+gmSEQ.LockN0*SingleLen_C+SpinLockGap+gmSEQ.halfpi, ...
             gSG.AWGFreq, ...
             0 * pi / 2, ...
             gSG.AWGAmp];
         WaveForm_1Q = [WaveForm_1Q; ...
            gmSEQ.halfpi+gmSEQ.LockN0*SingleLen_C+SpinLockGap, ...
            gmSEQ.halfpi+gmSEQ.LockN0*SingleLen_C+SpinLockGap+gmSEQ.halfpi, ...
             gSG.AWGFreq, ...
             0 * pi / 2 - pi / 2, ...
             gSG.AWGAmp];
        
    end
    
    WaveForm_1Length = ceil((gmSEQ.halfpi + LockLenCool + gmSEQ.halfpi + 1000) / (16 / gSG.AWGClockRate)) ...
        *(16 / gSG.AWGClockRate);
    WaveForm_1PointNum = WaveForm_1Length * gSG.AWGClockRate;
    
%%%% Measuring Waveforms.    
    if gmSEQ.CoolSwitch <2 
        WaveForm_2I = [0, gmSEQ.halfpi, gSG.AWGFreq, 0, gSG.AWGAmp]; 
        WaveForm_2Q = [0, gmSEQ.halfpi, gSG.AWGFreq, -pi/2, gSG.AWGAmp];    
    elseif gmSEQ.CoolSwitch == 2
        WaveForm_2I = [0, gmSEQ.halfpi, gSG.AWGFreq, 0+0, gSG.AWGAmp]; 
        WaveForm_2Q = [0, gmSEQ.halfpi, gSG.AWGFreq, 0-pi/2, gSG.AWGAmp];    
    end

    for n = 1 : gmSEQ.m  % add segments of [t1(Omega_y) -> t2(-Omega_y)]
        WaveForm_2I = [WaveForm_2I; ...
           gmSEQ.halfpi + (n - 1) * SingleLen_M + SpinLockGap, ...
               gmSEQ.halfpi + (n - 1) * SingleLen_M + SpinLockGap + gmSEQ.SLockT1_M, ...
               gSG.AWGFreq, ...
               pi / 2, gSG.AWGAmp * gmSEQ.SAmp1_M;...
           gmSEQ.halfpi + (n - 1) * SingleLen_M + SpinLockGap + gmSEQ.SLockT1_M + SpinLockGap, ...
               gmSEQ.halfpi + (n - 1) * SingleLen_M + SpinLockGap + gmSEQ.SLockT1_M + SpinLockGap + gmSEQ.SLockT2_M, ...
               gSG.AWGFreq, ...
               3 * pi / 2, ...
               gSG.AWGAmp * gmSEQ.SAmp2_M];
        WaveForm_2Q = [WaveForm_2Q; ...
           gmSEQ.halfpi + (n - 1) * SingleLen_M + SpinLockGap, ...
               gmSEQ.halfpi + (n - 1) * SingleLen_M + SpinLockGap + gmSEQ.SLockT1_M, ...
               gSG.AWGFreq, ...
               pi / 2 - pi / 2, gSG.AWGAmp*gmSEQ.SAmp1_M;...
           gmSEQ.halfpi + (n - 1) * SingleLen_M + SpinLockGap + gmSEQ.SLockT1_M + SpinLockGap, ...
               gmSEQ.halfpi + (n - 1) * SingleLen_M + SpinLockGap + gmSEQ.SLockT1_M + SpinLockGap + gmSEQ.SLockT2_M, ...
               gSG.AWGFreq, ...
               3 * pi / 2 - pi / 2, ...
               gSG.AWGAmp * gmSEQ.SAmp2_M];   
    end
    
    if gmSEQ.CoolSwitch <2 
    WaveForm_2I = [WaveForm_2I; ...
        gmSEQ.halfpi + gmSEQ.m * SingleLen_M + SpinLockGap, ...
            gmSEQ.halfpi + gmSEQ.m * SingleLen_M + SpinLockGap + gmSEQ.halfpi,...
            gSG.AWGFreq, ...
            2 * pi / 2, ...
            gSG.AWGAmp];
    WaveForm_2Q = [WaveForm_2Q; ...
        gmSEQ.halfpi + gmSEQ.m * SingleLen_M + SpinLockGap, ...
            gmSEQ.halfpi + gmSEQ.m * SingleLen_M + SpinLockGap + gmSEQ.halfpi,...
            gSG.AWGFreq, ...
            2 * pi / 2 - pi / 2, ...
            gSG.AWGAmp];
    elseif gmSEQ.CoolSwitch == 2
    WaveForm_2I = [WaveForm_2I; ...
        gmSEQ.halfpi + gmSEQ.m * SingleLen_M + SpinLockGap, ...
            gmSEQ.halfpi + gmSEQ.m * SingleLen_M + SpinLockGap + gmSEQ.halfpi,...
            gSG.AWGFreq, ...
            2 * pi / 2, ...
            gSG.AWGAmp];
    WaveForm_2Q = [WaveForm_2Q; ...
        gmSEQ.halfpi + gmSEQ.m * SingleLen_M + SpinLockGap, ...
            gmSEQ.halfpi + gmSEQ.m * SingleLen_M + SpinLockGap + gmSEQ.halfpi,...
            gSG.AWGFreq, ...
            2 * pi / 2 - pi / 2, ...
            gSG.AWGAmp];     
    end
    
%%%% Differential Measuring Waveforms. Just add another pi_y pulse at the
%%%% end.
    WaveForm_3I = [WaveForm_2I; ...
        gmSEQ.halfpi + gmSEQ.m * SingleLen_M + SpinLockGap + gmSEQ.halfpi + PulseGap, ...
            gmSEQ.halfpi + gmSEQ.m * SingleLen_M + SpinLockGap + gmSEQ.halfpi + PulseGap + gmSEQ.pi, ...
            gSG.AWGFreq, ...
            pi / 2, gSG.AWGAmp];
    WaveForm_3Q = [WaveForm_2Q; ...
        gmSEQ.halfpi + gmSEQ.m * SingleLen_M + SpinLockGap + gmSEQ.halfpi + PulseGap, ...
            gmSEQ.halfpi + gmSEQ.m * SingleLen_M + SpinLockGap + gmSEQ.halfpi + PulseGap + gmSEQ.pi, ...
            gSG.AWGFreq, ...
            pi / 2 - pi / 2, gSG.AWGAmp]; 
    
    WaveForm_2Length = ceil((gmSEQ.halfpi + LockLenMeasure + SpinLockGap + gmSEQ.halfpi + PulseGap + gmSEQ.pi + 1000) / (16 / gSG.AWGClockRate)) ...
        * (16 / gSG.AWGClockRate);
    WaveForm_2PointNum = WaveForm_2Length * gSG.AWGClockRate;
    WaveForm_3Length = WaveForm_2Length;
    WaveForm_3PointNum = WaveForm_2PointNum;
    
    % NV pulse to mix up NV
     WaveForm_4I = [0, gmSEQ.halfpi, gSG.AWGFreq, 0, gSG.AWGAmp; ...
         10000, 10000+gmSEQ.halfpi,  gSG.AWGFreq, 0, gSG.AWGAmp; ...
         20000, 20000+gmSEQ.halfpi,  gSG.AWGFreq, 0, gSG.AWGAmp; ...
         30000, 30000+gmSEQ.halfpi,  gSG.AWGFreq, 0, gSG.AWGAmp];
     WaveForm_4Q = [0, gmSEQ.halfpi, gSG.AWGFreq, -pi/2, gSG.AWGAmp; ...
         10000, 10000+gmSEQ.halfpi,  gSG.AWGFreq, -pi/2, gSG.AWGAmp; ...
         20000, 20000+gmSEQ.halfpi,  gSG.AWGFreq, -pi/2, gSG.AWGAmp; ...
         30000, 30000+gmSEQ.halfpi,  gSG.AWGFreq, -pi/2, gSG.AWGAmp];
    
    WaveForm_4Length = ceil((30000+gmSEQ.halfpi+1000) / (16 / gSG.AWGClockRate)) ...
        * (16 / gSG.AWGClockRate);
    WaveForm_4PointNum = WaveForm_4Length * gSG.AWGClockRate;
    
    
else
    questdlg('Only AC mnodulation works for now, please check AC modulation~',...
        'Heating / Cooling Sequence', 'Cancel');
end
%%% Create Wave Form Text Files
chaseFunctionPool('createWaveform', WaveForm_1I, gSG.AWGClockRate, WaveForm_1Length, 'SpecialCooling_I_seg1.txt'); pause(0.5);
chaseFunctionPool('createWaveform', WaveForm_1Q, gSG.AWGClockRate, WaveForm_1Length, 'SpecialCooling_Q_seg1.txt'); pause(0.5);
chaseFunctionPool('createWaveform', WaveForm_2I, gSG.AWGClockRate, WaveForm_2Length, 'SpecialCooling_I_seg2.txt'); pause(0.5);
chaseFunctionPool('createWaveform', WaveForm_2Q, gSG.AWGClockRate, WaveForm_2Length, 'SpecialCooling_Q_seg2.txt'); pause(0.5);
chaseFunctionPool('createWaveform', WaveForm_3I, gSG.AWGClockRate, WaveForm_3Length, 'SpecialCooling_I_seg3.txt'); pause(0.5);
chaseFunctionPool('createWaveform', WaveForm_3Q, gSG.AWGClockRate, WaveForm_3Length, 'SpecialCooling_Q_seg3.txt'); pause(0.5);
chaseFunctionPool('createWaveform', WaveForm_4I, gSG.AWGClockRate, WaveForm_4Length, 'SpecialCooling_I_seg4.txt'); pause(0.5);
chaseFunctionPool('createWaveform', WaveForm_4Q, gSG.AWGClockRate, WaveForm_4Length, 'SpecialCooling_Q_seg4.txt'); pause(0.5);

%%% Create Wave Form Structs -> Pass Segments to AWG
if gmSEQ.CoolCycle == 0
    chaseFunctionPool('createSegStruct', 'SpecialCooling_SegStruct_I.txt', ...
        'SpecialCooling_I_seg4.txt', WaveForm_4PointNum, 1, 1, ...
        'SpecialCooling_I_seg2.txt', WaveForm_2PointNum, 1, 1, ...
        'SpecialCooling_I_seg4.txt', WaveForm_4PointNum, 1, 1, ...
        'SpecialCooling_I_seg3.txt', WaveForm_3PointNum, 1, 1);
    pause(0.5);
    chaseFunctionPool('createSegStruct', 'SpecialCooling_SegStruct_Q.txt', ...
        'SpecialCooling_Q_seg4.txt', WaveForm_4PointNum, 1, 1, ...
        'SpecialCooling_Q_seg2.txt', WaveForm_2PointNum, 1, 1, ...
        'SpecialCooling_Q_seg4.txt', WaveForm_4PointNum, 1, 1, ...
        'SpecialCooling_Q_seg3.txt', WaveForm_3PointNum, 1, 1);
    pause(0.5);
    chaseFunctionPool('CreateSegments', 1, 1, ...
        4, ...
        2047, 2047, 'SpecialCooling_SegStruct_I.txt', 'false');
    pause(1); % this pause seems to be important, otherwise the loading is not right occassionally
    chaseFunctionPool('CreateSegments', 1, 2, ...
        4, ...
        2047, 2047, 'SpecialCooling_SegStruct_Q.txt', 'false');
    pause(1); % this pause seems to be important, otherwise the loading is not right occassionally
    chaseFunctionPool('runChase', 1, 'false');
elseif gmSEQ.CoolCycle == 1
    chaseFunctionPool('createSegStruct', 'SpecialCooling_SegStruct_I.txt', ...
        'SpecialCooling_I_seg4.txt', WaveForm_4PointNum, 1, 1, ...
        'SpecialCooling_I_seg1.txt', WaveForm_1PointNum, 1, 1, ...
        'SpecialCooling_I_seg2.txt', WaveForm_2PointNum, 1, 1, ...
        'SpecialCooling_I_seg4.txt', WaveForm_4PointNum, 1, 1, ...
        'SpecialCooling_I_seg1.txt', WaveForm_1PointNum, 1, 1, ...
        'SpecialCooling_I_seg3.txt', WaveForm_3PointNum, 1, 1);
    pause(0.5);
    chaseFunctionPool('createSegStruct', 'SpecialCooling_SegStruct_Q.txt', ...
        'SpecialCooling_Q_seg4.txt', WaveForm_4PointNum, 1, 1, ...
        'SpecialCooling_Q_seg1.txt', WaveForm_1PointNum, 1, 1, ...
        'SpecialCooling_Q_seg2.txt', WaveForm_2PointNum, 1, 1, ...
        'SpecialCooling_Q_seg4.txt', WaveForm_4PointNum, 1, 1, ...
        'SpecialCooling_Q_seg1.txt', WaveForm_1PointNum, 1, 1, ...
        'SpecialCooling_Q_seg3.txt', WaveForm_3PointNum, 1, 1);
    pause(0.5);
    chaseFunctionPool('CreateSegments', 1, 1, ...
        6, ...
        2047, 2047, 'SpecialCooling_SegStruct_I.txt', 'false');
    pause(1); % this pause seems to be important, otherwise the loading is not right occassionally
    chaseFunctionPool('CreateSegments', 1, 2, ...
        6, ...
        2047, 2047, 'SpecialCooling_SegStruct_Q.txt', 'false');
    pause(1); % this pause seems to be important, otherwise the loading is not right occassionally
    chaseFunctionPool('runChase', 1, 'false');
elseif gmSEQ.CoolCycle < 500
chaseFunctionPool('createSegStruct', 'SpecialCooling_SegStruct_I.txt', ...
    'SpecialCooling_I_seg4.txt', WaveForm_4PointNum, 1, 1, ...
    'SpecialCooling_I_seg1.txt', WaveForm_1PointNum, 1, 1, ... % The first repeatition cannot be looped and must be triggered, so must be left out.
    'SpecialCooling_I_seg1.txt', WaveForm_1PointNum, gmSEQ.CoolCycle - 1, 1, ...
    'SpecialCooling_I_seg2.txt', WaveForm_2PointNum, 1, 1, ...
    'SpecialCooling_I_seg4.txt', WaveForm_4PointNum, 1, 1, ...
    'SpecialCooling_I_seg1.txt', WaveForm_1PointNum, 1, 1, ... % This one just to make sure things are symmetric.
    'SpecialCooling_I_seg1.txt', WaveForm_1PointNum, gmSEQ.CoolCycle - 1, 1, ...
    'SpecialCooling_I_seg3.txt', WaveForm_3PointNum, 1, 1);
pause(0.5);
chaseFunctionPool('createSegStruct', 'SpecialCooling_SegStruct_Q.txt', ...
    'SpecialCooling_Q_seg4.txt', WaveForm_4PointNum, 1, 1, ...
    'SpecialCooling_Q_seg1.txt', WaveForm_1PointNum, 1, 1, ... 
    'SpecialCooling_Q_seg1.txt', WaveForm_1PointNum, gmSEQ.CoolCycle - 1, 1, ...
    'SpecialCooling_Q_seg2.txt', WaveForm_2PointNum, 1, 1, ...
    'SpecialCooling_Q_seg4.txt', WaveForm_4PointNum, 1, 1, ...
    'SpecialCooling_Q_seg1.txt', WaveForm_1PointNum, 1, 1, ...
    'SpecialCooling_Q_seg1.txt', WaveForm_1PointNum, gmSEQ.CoolCycle - 1, 1, ...
    'SpecialCooling_Q_seg3.txt', WaveForm_3PointNum, 1, 1);
pause(0.5);    
chaseFunctionPool('CreateSegments', 1, 1, ...
    8, ...
    2047, 2047, 'SpecialCooling_SegStruct_I.txt', 'false');
pause(3); % this pause seems to be important, otherwise the loading is not right occassionally
chaseFunctionPool('CreateSegments', 1, 2, ...
    8, ...
    2047, 2047, 'SpecialCooling_SegStruct_Q.txt', 'false');
pause(3); % this pause seems to be important, otherwise the loading is not right occassionally
%%% Run AWG.
chaseFunctionPool('runChase', 1, 'false');

end

ApplyDelays();    

function SpecialCooling_P1_2_DurMeas

global gmSEQ gSG gSG2
gSG.bfixedPow = 1;
gSG.bfixedFreq = 1;
gSG.bMod = 'IQ';
gSG.bModSrc = 'External';

gSG2.bMod='IQ';
gSG2.bModSrc='External';
SignalGeneratorFunctionPool2('SetMod');

SignalGeneratorFunctionPool2('WritePow');
SignalGeneratorFunctionPool2('WriteFreq');
gSG2.bOn=1; SignalGeneratorFunctionPool2('RFOnOff');

% If PL signal is collected via APD.
if strcmp(gmSEQ.meas,'APD') 
    gmSEQ.CtrGateDur = 1000;
end

% Cooling sequence [pi/2_x->[t1(Omega_y) -> t2(-Omega_y)]^{N_0}]^{Cooling cycle}...

gmSEQ.halfpi = gmSEQ.pi/2;
Wait_p = 30e6; % to wait for P1 to be fully unpolarized again
AfterPi = 1000;
AfterLaser = 2000;
Detect_Window = 15000;
PulseGap = 30;
SpinLockGap = 0; % The gap (in ns) between t1(Omega) and t2(-Omega).

SingleLen_C = 2 * SpinLockGap + gmSEQ.SLockT1 + gmSEQ.SLockT2; % Length of cooling segment [t1(Omega_y) -> t2(-Omega_y)]
LockLenCool = gmSEQ.LockN0 * SingleLen_C;

SingleLen_M = 1*(2*SpinLockGap+gmSEQ.SLockT1_M + gmSEQ.SLockT2_M); % Length of measuring segment [t1(Omega_y) -> t2(-Omega_y)]
LockLenMeasure = gmSEQ.m * SingleLen_M;

AfterLock = 1000;
% Cooling_Readout = gmSEQ.readout;
Cooling_Readout = 1000;

CoolCycleT = Cooling_Readout + AfterLaser + gmSEQ.halfpi + LockLenCool + gmSEQ.halfpi + AfterLock;
CoolCycleT = ceil(CoolCycleT * gSG.AWGClockRate / 16) / (gSG.AWGClockRate / 16);

%% Pulse Blaster
%%% AOM
% Cooling
gmSEQ.CHN(1).PBN=PBDictionary('AOM');
gmSEQ.CHN(1).NRise = 2 * (2 + gmSEQ.CoolCycle);
    gmSEQ.CHN(1).T = [];
    gmSEQ.CHN(1).DT = [];
    for n = 1 : gmSEQ.CoolCycle
        gmSEQ.CHN(1).T = [gmSEQ.CHN(1).T, Wait_p + (n - 1) * CoolCycleT];
        gmSEQ.CHN(1).DT = [gmSEQ.CHN(1).DT, Cooling_Readout];
    end
% Cooling - Measurement
    gmSEQ.CHN(1).T = [gmSEQ.CHN(1).T, ...
        Wait_p + gmSEQ.CoolCycle * CoolCycleT + gmSEQ.CoolWait, ...
        Wait_p + gmSEQ.CoolCycle * CoolCycleT + gmSEQ.CoolWait ...
            + gmSEQ.readout + AfterLaser + gmSEQ.halfpi + LockLenMeasure ...
            + SpinLockGap + gmSEQ.halfpi + PulseGap + gmSEQ.pi+ AfterPi];
    gmSEQ.CHN(1).DT = [gmSEQ.CHN(1).DT, gmSEQ.readout, Detect_Window]; 
% Differential Cooling
    Start_Sig_D = Wait_p + gmSEQ.CoolCycle * CoolCycleT + gmSEQ.CoolWait ...
        + gmSEQ.readout + AfterLaser + gmSEQ.halfpi + LockLenMeasure ...
        + SpinLockGap + gmSEQ.halfpi + PulseGap + gmSEQ.pi + AfterPi ...
        + Detect_Window + Wait_p;
    for n = 1 : gmSEQ.CoolCycle
        gmSEQ.CHN(1).T = [gmSEQ.CHN(1).T, Start_Sig_D + (n - 1) * CoolCycleT];
        gmSEQ.CHN(1).DT = [gmSEQ.CHN(1).DT, Cooling_Readout];
    end
% Differential Cooling - Measurement
    gmSEQ.CHN(1).T = [gmSEQ.CHN(1).T, ...
        Start_Sig_D + gmSEQ.CoolCycle * CoolCycleT + gmSEQ.CoolWait, ...
        Start_Sig_D + gmSEQ.CoolCycle  *CoolCycleT + gmSEQ.CoolWait ...
            + gmSEQ.readout + AfterLaser + gmSEQ.halfpi + LockLenMeasure ...
            + SpinLockGap + gmSEQ.halfpi + PulseGap + gmSEQ.pi + AfterPi];
    gmSEQ.CHN(1).DT = [gmSEQ.CHN(1).DT, gmSEQ.readout, Detect_Window];

%%% APD
% gmSEQ.CHN(numel(gmSEQ.CHN)+1).PBN=PBDictionary('ctr0');
% gmSEQ.CHN(numel(gmSEQ.CHN)).NRise = 4;
% gmSEQ.CHN(numel(gmSEQ.CHN)).T = [gmSEQ.CHN(1).T(gmSEQ.CoolCycle + 1) + gmSEQ.readout - 1000, ...
%     gmSEQ.CHN(1).T(gmSEQ.CoolCycle + 2), ...
%     gmSEQ.CHN(1).T(2 * gmSEQ.CoolCycle + 3) + gmSEQ.readout - 1000, ...
%     gmSEQ.CHN(1).T(2 * gmSEQ.CoolCycle + 4)];
% gmSEQ.CHN(numel(gmSEQ.CHN)).DT = repelem(gmSEQ.CtrGateDur, 1, 4);

gmSEQ.CHN(numel(gmSEQ.CHN)+1).PBN=PBDictionary('ctr0');
gmSEQ.CHN(numel(gmSEQ.CHN)).NRise = 4;
gmSEQ.CHN(numel(gmSEQ.CHN)).T = [gmSEQ.CHN(1).T(gmSEQ.CoolCycle + 2), ...
    gmSEQ.CHN(1).T(gmSEQ.CoolCycle + 2)+Detect_Window-1000-gmSEQ.CtrGateDur, ...
    gmSEQ.CHN(1).T(2 * gmSEQ.CoolCycle + 4), ...
    gmSEQ.CHN(1).T(2 * gmSEQ.CoolCycle + 4)+Detect_Window-1000-gmSEQ.CtrGateDur];
gmSEQ.CHN(numel(gmSEQ.CHN)).DT = repelem(gmSEQ.CtrGateDur, 1, 4);

% Note that for sequence length ~ 2ms / 20ms, the timing difference between
% PulseBlaster and AWG is ~ 10ns / 100ns

% MW Switch
% Cooling -> Cooling - Measurement
gmSEQ.CHN(numel(gmSEQ.CHN) + 1).PBN=PBDictionary('MWSwitch');
gmSEQ.CHN(numel(gmSEQ.CHN)).NRise= 2 + 2 * gmSEQ.CoolCycle + 8;
gmSEQ.CHN(numel(gmSEQ.CHN)).T = [10000-30 20000-30 30000-30 40000-30];
gmSEQ.CHN(numel(gmSEQ.CHN)).DT = [gmSEQ.halfpi+54 gmSEQ.halfpi+54 gmSEQ.halfpi+54 gmSEQ.halfpi+54];
for n = 1 : gmSEQ.CoolCycle
    gmSEQ.CHN(numel(gmSEQ.CHN)).T = [gmSEQ.CHN(numel(gmSEQ.CHN)).T, ...
        Wait_p + (n - 1) * CoolCycleT + Cooling_Readout + AfterLaser - 30]; % double the buffer around IQ.
    gmSEQ.CHN(numel(gmSEQ.CHN)).DT = [gmSEQ.CHN(numel(gmSEQ.CHN)).DT, ...
        gmSEQ.halfpi + LockLenCool + gmSEQ.halfpi + 54];
end
gmSEQ.CHN(numel(gmSEQ.CHN)).T = [gmSEQ.CHN(numel(gmSEQ.CHN)).T, ...
    Wait_p + gmSEQ.CoolCycle * CoolCycleT + gmSEQ.CoolWait + gmSEQ.readout + AfterLaser - 30];
gmSEQ.CHN(numel(gmSEQ.CHN)).DT = [gmSEQ.CHN(numel(gmSEQ.CHN)).DT, ...
    gmSEQ.halfpi + LockLenMeasure + SpinLockGap + gmSEQ.halfpi + 54];
% Differential Cooling -> Differential Cooling - Measurement


gmSEQ.CHN(numel(gmSEQ.CHN)).T = [gmSEQ.CHN(numel(gmSEQ.CHN)).T, ...
    Start_Sig_D-Wait_p+10000-30 Start_Sig_D-Wait_p+20000-30 Start_Sig_D-Wait_p+30000-30 Start_Sig_D-Wait_p+40000-30];
gmSEQ.CHN(numel(gmSEQ.CHN)).DT = [gmSEQ.CHN(numel(gmSEQ.CHN)).DT gmSEQ.halfpi+54 gmSEQ.halfpi+54 gmSEQ.halfpi+54 gmSEQ.halfpi+54];

for n = 1 : gmSEQ.CoolCycle
    gmSEQ.CHN(numel(gmSEQ.CHN)).T = [gmSEQ.CHN(numel(gmSEQ.CHN)).T, ...
        Start_Sig_D + (n - 1) * CoolCycleT + Cooling_Readout + AfterLaser - 30];
    gmSEQ.CHN(numel(gmSEQ.CHN)).DT = [gmSEQ.CHN(numel(gmSEQ.CHN)).DT, ...
        gmSEQ.halfpi + LockLenCool + gmSEQ.halfpi + 54];
end
gmSEQ.CHN(numel(gmSEQ.CHN)).T = [gmSEQ.CHN(numel(gmSEQ.CHN)).T, ...
    Start_Sig_D + gmSEQ.CoolCycle * CoolCycleT + gmSEQ.CoolWait + gmSEQ.readout + AfterLaser - 30];
gmSEQ.CHN(numel(gmSEQ.CHN)).DT = [gmSEQ.CHN(numel(gmSEQ.CHN)).DT, ...
    gmSEQ.halfpi + LockLenMeasure + SpinLockGap + gmSEQ.halfpi + PulseGap + gmSEQ.pi + 54];


%%% Dummy 1: to check the total length of the sequence.
Max_length = 2 * Wait_p + 2 * gmSEQ.CoolCycle * CoolCycleT ...
    + 2 * gmSEQ.CoolWait + 2 * gmSEQ.readout + 2 * Detect_Window ...
    + 2 * (AfterLaser + AfterPi + gmSEQ.halfpi + LockLenMeasure + SpinLockGap + gmSEQ.halfpi + PulseGap + gmSEQ.pi);
gmSEQ.CHN(numel(gmSEQ.CHN) + 1).PBN = PBDictionary('dummy1');
gmSEQ.CHN(numel(gmSEQ.CHN)).NRise = 2;
gmSEQ.CHN(numel(gmSEQ.CHN)).T = [0, Max_length-200];
gmSEQ.CHN(numel(gmSEQ.CHN)).DT = [200, 200];

% Adding P1 pulse during the cooling process

gmSEQ.CHN(numel(gmSEQ.CHN) + 1).PBN=PBDictionary('MWSwitch2');
gmSEQ.CHN(numel(gmSEQ.CHN)).NRise= 2 * gmSEQ.CoolCycle + 2;
gmSEQ.CHN(numel(gmSEQ.CHN)).T = [];
gmSEQ.CHN(numel(gmSEQ.CHN)).DT = [];

for n = 1 : gmSEQ.CoolCycle
    gmSEQ.CHN(numel(gmSEQ.CHN)).T = [gmSEQ.CHN(numel(gmSEQ.CHN)).T, ...
        Wait_p + (n - 1) * CoolCycleT + Cooling_Readout + AfterLaser + gmSEQ.halfpi + 20]; % double the buffer around IQ.
    
    if LockLenCool > 100
    gmSEQ.CHN(numel(gmSEQ.CHN)).DT = [gmSEQ.CHN(numel(gmSEQ.CHN)).DT, ...
        LockLenCool - 40];
    else
    gmSEQ.CHN(numel(gmSEQ.CHN)).DT = [gmSEQ.CHN(numel(gmSEQ.CHN)).DT, ...
        0];    
    end
end
gmSEQ.CHN(numel(gmSEQ.CHN)).T = [gmSEQ.CHN(numel(gmSEQ.CHN)).T, ...
    Wait_p + gmSEQ.CoolCycle * CoolCycleT + gmSEQ.CoolWait + gmSEQ.readout + AfterLaser + gmSEQ.halfpi + 20];

if LockLenMeasure > 100
    gmSEQ.CHN(numel(gmSEQ.CHN)).DT = [gmSEQ.CHN(numel(gmSEQ.CHN)).DT, ...
        LockLenMeasure - 40];
else
    gmSEQ.CHN(numel(gmSEQ.CHN)).DT = [gmSEQ.CHN(numel(gmSEQ.CHN)).DT, ...
        0];
end

% Differential Cooling -> Differential Cooling - Measurement
for n = 1 : gmSEQ.CoolCycle
    gmSEQ.CHN(numel(gmSEQ.CHN)).T = [gmSEQ.CHN(numel(gmSEQ.CHN)).T, ...
        Start_Sig_D + (n - 1) * CoolCycleT + Cooling_Readout + AfterLaser];
    
    if LockLenCool > 100
    gmSEQ.CHN(numel(gmSEQ.CHN)).DT = [gmSEQ.CHN(numel(gmSEQ.CHN)).DT, ...
        LockLenCool - 40];
    else
    gmSEQ.CHN(numel(gmSEQ.CHN)).DT = [gmSEQ.CHN(numel(gmSEQ.CHN)).DT, ...
        0];    
    end
end
gmSEQ.CHN(numel(gmSEQ.CHN)).T = [gmSEQ.CHN(numel(gmSEQ.CHN)).T, ...
    Start_Sig_D + gmSEQ.CoolCycle * CoolCycleT + gmSEQ.CoolWait + gmSEQ.readout + AfterLaser + gmSEQ.halfpi + 20];

if LockLenMeasure > 100
    gmSEQ.CHN(numel(gmSEQ.CHN)).DT = [gmSEQ.CHN(numel(gmSEQ.CHN)).DT, ...
        LockLenMeasure - 40];
else
    gmSEQ.CHN(numel(gmSEQ.CHN)).DT = [gmSEQ.CHN(numel(gmSEQ.CHN)).DT, ...
        0];
end


gmSEQ.CHN(numel(gmSEQ.CHN) + 1).PBN=PBDictionary('I_2');
gmSEQ.CHN(numel(gmSEQ.CHN)).NRise= 2 * gmSEQ.CoolCycle + 2;
gmSEQ.CHN(numel(gmSEQ.CHN)).T = [];
gmSEQ.CHN(numel(gmSEQ.CHN)).DT = [];
for n = 1 : gmSEQ.CoolCycle
    gmSEQ.CHN(numel(gmSEQ.CHN)).T = [gmSEQ.CHN(numel(gmSEQ.CHN)).T, ...
        Wait_p + (n - 1) * CoolCycleT + Cooling_Readout + AfterLaser + gmSEQ.halfpi + 20]; % double the buffer around IQ.
    
    if LockLenCool > 100
    gmSEQ.CHN(numel(gmSEQ.CHN)).DT = [gmSEQ.CHN(numel(gmSEQ.CHN)).DT, ...
        LockLenCool - 40];
    else
    gmSEQ.CHN(numel(gmSEQ.CHN)).DT = [gmSEQ.CHN(numel(gmSEQ.CHN)).DT, ...
        0];    
    end
end
gmSEQ.CHN(numel(gmSEQ.CHN)).T = [gmSEQ.CHN(numel(gmSEQ.CHN)).T, ...
    Wait_p + gmSEQ.CoolCycle * CoolCycleT + gmSEQ.CoolWait + gmSEQ.readout + AfterLaser + gmSEQ.halfpi + 20];

if LockLenMeasure > 100
    gmSEQ.CHN(numel(gmSEQ.CHN)).DT = [gmSEQ.CHN(numel(gmSEQ.CHN)).DT, ...
        LockLenMeasure - 40];
else
    gmSEQ.CHN(numel(gmSEQ.CHN)).DT = [gmSEQ.CHN(numel(gmSEQ.CHN)).DT, ...
        0];
end

% Differential Cooling -> Differential Cooling - Measurement
for n = 1 : gmSEQ.CoolCycle
    gmSEQ.CHN(numel(gmSEQ.CHN)).T = [gmSEQ.CHN(numel(gmSEQ.CHN)).T, ...
        Start_Sig_D + (n - 1) * CoolCycleT + Cooling_Readout + AfterLaser];
    
    if LockLenCool > 100
    gmSEQ.CHN(numel(gmSEQ.CHN)).DT = [gmSEQ.CHN(numel(gmSEQ.CHN)).DT, ...
        LockLenCool - 40];
    else
    gmSEQ.CHN(numel(gmSEQ.CHN)).DT = [gmSEQ.CHN(numel(gmSEQ.CHN)).DT, ...
        0];    
    end
end
gmSEQ.CHN(numel(gmSEQ.CHN)).T = [gmSEQ.CHN(numel(gmSEQ.CHN)).T, ...
    Start_Sig_D + gmSEQ.CoolCycle * CoolCycleT + gmSEQ.CoolWait + gmSEQ.readout + AfterLaser + gmSEQ.halfpi + 20];

if LockLenMeasure > 100
    gmSEQ.CHN(numel(gmSEQ.CHN)).DT = [gmSEQ.CHN(numel(gmSEQ.CHN)).DT, ...
        LockLenMeasure - 40];
else
    gmSEQ.CHN(numel(gmSEQ.CHN)).DT = [gmSEQ.CHN(numel(gmSEQ.CHN)).DT, ...
        0];
end


%%% AWG Trigger
% Each repeatition of the segement need one trigger, a total of 2 *
% (CoolCycle + 1) triggers are needed.
% Cooling -> Cooling - Measurement
gmSEQ.CHN(numel(gmSEQ.CHN)+1).PBN = PBDictionary('AWGTrig');
gmSEQ.CHN(numel(gmSEQ.CHN)).NRise = 2 + 2 + gmSEQ.CoolCycle * 2;
gmSEQ.CHN(numel(gmSEQ.CHN)).T = [10000];
gmSEQ.CHN(numel(gmSEQ.CHN)).DT = [1000];
for n = 1 : gmSEQ.CoolCycle
gmSEQ.CHN(numel(gmSEQ.CHN)).T = [gmSEQ.CHN(numel(gmSEQ.CHN)).T, ... 
    Wait_p + (n - 1) * CoolCycleT + Cooling_Readout + AfterLaser];
gmSEQ.CHN(numel(gmSEQ.CHN)).DT = [gmSEQ.CHN(numel(gmSEQ.CHN)).DT, 500];
end

gmSEQ.CHN(numel(gmSEQ.CHN)).T = [gmSEQ.CHN(numel(gmSEQ.CHN)).T, ...
    Wait_p + gmSEQ.CoolCycle * CoolCycleT + gmSEQ.CoolWait + gmSEQ.readout + AfterLaser];
gmSEQ.CHN(numel(gmSEQ.CHN)).DT=[gmSEQ.CHN(numel(gmSEQ.CHN)).DT, 500];

gmSEQ.CHN(numel(gmSEQ.CHN)).T = [gmSEQ.CHN(numel(gmSEQ.CHN)).T, ...
    Start_Sig_D-Wait_p+10000];
gmSEQ.CHN(numel(gmSEQ.CHN)).DT=[gmSEQ.CHN(numel(gmSEQ.CHN)).DT, 1000];

% Differential Cooling -> Differential Cooling - Measurement
for n = 1:gmSEQ.CoolCycle
gmSEQ.CHN(numel(gmSEQ.CHN)).T = [gmSEQ.CHN(numel(gmSEQ.CHN)).T, ...
    Start_Sig_D + (n - 1) * CoolCycleT + Cooling_Readout + AfterLaser];
gmSEQ.CHN(numel(gmSEQ.CHN)).DT = [gmSEQ.CHN(numel(gmSEQ.CHN)).DT, 500];
end
gmSEQ.CHN(numel(gmSEQ.CHN)).T = [gmSEQ.CHN(numel(gmSEQ.CHN)).T, ...
    Start_Sig_D + gmSEQ.CoolCycle * CoolCycleT + gmSEQ.CoolWait + gmSEQ.readout + AfterLaser];
gmSEQ.CHN(numel(gmSEQ.CHN)).DT = [gmSEQ.CHN(numel(gmSEQ.CHN)).DT, 500]; 

%% AWG
%%% Initialization
chaseFunctionPool('stopChase', 1)
%%% Generating wave form
if gSG.ACmodAWG 
    WaveForm_1I = [];
    WaveForm_1Q = [];
%%%% Cooling / Heating Waveforms.
% |gmSEQ.CoolSwitch| controls whether cooling / heating is turned on. 
    if gmSEQ.CoolSwitch == 1 % Cooling
        WaveForm_1I = [WaveForm_1I; ...
            0, gmSEQ.halfpi, gSG.AWGFreq, 0, gSG.AWGAmp]; % The 1st pi/2_x pulse.
        WaveForm_1Q = [WaveForm_1Q; ...
            0, gmSEQ.halfpi, gSG.AWGFreq, - pi / 2, gSG.AWGAmp];
    elseif gmSEQ.CoolSwitch == 2 % Heating
        WaveForm_1I = [WaveForm_1I; ...
            0, gmSEQ.halfpi, gSG.AWGFreq, pi, gSG.AWGAmp];
        WaveForm_1Q = [WaveForm_1Q; ...
            0, gmSEQ.halfpi, gSG.AWGFreq, pi - pi / 2, gSG.AWGAmp];
    elseif gmSEQ.CoolSwitch == 0 % Nothing
        WaveForm_1I = [WaveForm_1I; ...
            0, gmSEQ.halfpi, 0, 0, 0];
        WaveForm_1Q = [WaveForm_1Q; ...
            0, gmSEQ.halfpi, 0, 0, 0];
    end
    
    for n = 1 : gmSEQ.LockN0 % add segments of [t1(Omega_y) -> t2(-Omega_y)]
       WaveForm_1I = [WaveForm_1I; ...
           gmSEQ.halfpi + (n - 1) * SingleLen_C + SpinLockGap, ...
               gmSEQ.halfpi + (n - 1) * SingleLen_C + SpinLockGap + gmSEQ.SLockT1, ...
               gSG.AWGFreq, ...
               pi / 2, ...
               gSG.AWGAmp * gmSEQ.SAmp1; ...
           gmSEQ.halfpi + (n - 1) * SingleLen_C + SpinLockGap + gmSEQ.SLockT1 + SpinLockGap, ...
               gmSEQ.halfpi + (n - 1) * SingleLen_C + SpinLockGap + gmSEQ.SLockT1 + SpinLockGap + gmSEQ.SLockT2, ...
               gSG.AWGFreq, ...
               3 * pi / 2, ...
               gSG.AWGAmp * gmSEQ.SAmp2];
       WaveForm_1Q = [WaveForm_1Q; ...
           gmSEQ.halfpi + (n - 1) * SingleLen_C + SpinLockGap, ...
               gmSEQ.halfpi + (n - 1) * SingleLen_C + SpinLockGap + gmSEQ.SLockT1, ...
               gSG.AWGFreq, ...
               pi / 2 - pi / 2, ...
               gSG.AWGAmp * gmSEQ.SAmp1; ...
           gmSEQ.halfpi + (n - 1) * SingleLen_C + SpinLockGap + gmSEQ.SLockT1 + SpinLockGap, ...
               gmSEQ.halfpi + (n - 1) * SingleLen_C + SpinLockGap + gmSEQ.SLockT1 + SpinLockGap + gmSEQ.SLockT2, ...
               gSG.AWGFreq, ...
               3 * pi / 2 - pi/2, ...
               gSG.AWGAmp * gmSEQ.SAmp2];     
    end
    
    if gmSEQ.CoolSwitch == 1
        WaveForm_1I = [WaveForm_1I; ...
            gmSEQ.halfpi+gmSEQ.LockN0*SingleLen_C+SpinLockGap, ...
            gmSEQ.halfpi+gmSEQ.LockN0*SingleLen_C+SpinLockGap+gmSEQ.halfpi, ...
             gSG.AWGFreq, ...
             2 * pi / 2, ...
             gSG.AWGAmp];
         WaveForm_1Q = [WaveForm_1Q; ...
            gmSEQ.halfpi+gmSEQ.LockN0*SingleLen_C+SpinLockGap, ...
            gmSEQ.halfpi+gmSEQ.LockN0*SingleLen_C+SpinLockGap+gmSEQ.halfpi, ...
             gSG.AWGFreq, ...
             2 * pi / 2 - pi / 2, ...
             gSG.AWGAmp];
                      
    elseif gmSEQ.CoolSwitch == 2
         WaveForm_1I = [WaveForm_1I; ...
            gmSEQ.halfpi+gmSEQ.LockN0*SingleLen_C+SpinLockGap, ...
            gmSEQ.halfpi+gmSEQ.LockN0*SingleLen_C+SpinLockGap+gmSEQ.halfpi, ...
             gSG.AWGFreq, ...
             0 * pi / 2, ...
             gSG.AWGAmp];
         WaveForm_1Q = [WaveForm_1Q; ...
            gmSEQ.halfpi+gmSEQ.LockN0*SingleLen_C+SpinLockGap, ...
            gmSEQ.halfpi+gmSEQ.LockN0*SingleLen_C+SpinLockGap+gmSEQ.halfpi, ...
             gSG.AWGFreq, ...
             0 * pi / 2 - pi / 2, ...
             gSG.AWGAmp];
        
    end
    
    WaveForm_1Length = ceil((gmSEQ.halfpi + LockLenCool + gmSEQ.halfpi + 1000) / (16 / gSG.AWGClockRate)) ...
        *(16 / gSG.AWGClockRate);
    WaveForm_1PointNum = WaveForm_1Length * gSG.AWGClockRate;
    
%%%% Measuring Waveforms.    
    if gmSEQ.CoolSwitch <2 
        WaveForm_2I = [0, gmSEQ.halfpi, gSG.AWGFreq, 0, gSG.AWGAmp]; 
        WaveForm_2Q = [0, gmSEQ.halfpi, gSG.AWGFreq, -pi/2, gSG.AWGAmp];    
    elseif gmSEQ.CoolSwitch == 2
        WaveForm_2I = [0, gmSEQ.halfpi, gSG.AWGFreq, 0+0, gSG.AWGAmp]; 
        WaveForm_2Q = [0, gmSEQ.halfpi, gSG.AWGFreq, 0-pi/2, gSG.AWGAmp];    
    end

    for n = 1 : gmSEQ.m  % add segments of [t1(Omega_y) -> t2(-Omega_y)]
        WaveForm_2I = [WaveForm_2I; ...
           gmSEQ.halfpi + (n - 1) * SingleLen_M + SpinLockGap, ...
               gmSEQ.halfpi + (n - 1) * SingleLen_M + SpinLockGap + gmSEQ.SLockT1_M, ...
               gSG.AWGFreq, ...
               pi / 2, gSG.AWGAmp * gmSEQ.SAmp1_M;...
           gmSEQ.halfpi + (n - 1) * SingleLen_M + SpinLockGap + gmSEQ.SLockT1_M + SpinLockGap, ...
               gmSEQ.halfpi + (n - 1) * SingleLen_M + SpinLockGap + gmSEQ.SLockT1_M + SpinLockGap + gmSEQ.SLockT2_M, ...
               gSG.AWGFreq, ...
               3 * pi / 2, ...
               gSG.AWGAmp * gmSEQ.SAmp2_M];
        WaveForm_2Q = [WaveForm_2Q; ...
           gmSEQ.halfpi + (n - 1) * SingleLen_M + SpinLockGap, ...
               gmSEQ.halfpi + (n - 1) * SingleLen_M + SpinLockGap + gmSEQ.SLockT1_M, ...
               gSG.AWGFreq, ...
               pi / 2 - pi / 2, gSG.AWGAmp*gmSEQ.SAmp1_M;...
           gmSEQ.halfpi + (n - 1) * SingleLen_M + SpinLockGap + gmSEQ.SLockT1_M + SpinLockGap, ...
               gmSEQ.halfpi + (n - 1) * SingleLen_M + SpinLockGap + gmSEQ.SLockT1_M + SpinLockGap + gmSEQ.SLockT2_M, ...
               gSG.AWGFreq, ...
               3 * pi / 2 - pi / 2, ...
               gSG.AWGAmp * gmSEQ.SAmp2_M];   
    end
    
    if gmSEQ.CoolSwitch <2 
    WaveForm_2I = [WaveForm_2I; ...
        gmSEQ.halfpi + gmSEQ.m * SingleLen_M + SpinLockGap, ...
            gmSEQ.halfpi + gmSEQ.m * SingleLen_M + SpinLockGap + gmSEQ.halfpi,...
            gSG.AWGFreq, ...
            2 * pi / 2, ...
            gSG.AWGAmp];
    WaveForm_2Q = [WaveForm_2Q; ...
        gmSEQ.halfpi + gmSEQ.m * SingleLen_M + SpinLockGap, ...
            gmSEQ.halfpi + gmSEQ.m * SingleLen_M + SpinLockGap + gmSEQ.halfpi,...
            gSG.AWGFreq, ...
            2 * pi / 2 - pi / 2, ...
            gSG.AWGAmp];
    elseif gmSEQ.CoolSwitch == 2
    WaveForm_2I = [WaveForm_2I; ...
        gmSEQ.halfpi + gmSEQ.m * SingleLen_M + SpinLockGap, ...
            gmSEQ.halfpi + gmSEQ.m * SingleLen_M + SpinLockGap + gmSEQ.halfpi,...
            gSG.AWGFreq, ...
            2 * pi / 2, ...
            gSG.AWGAmp];
    WaveForm_2Q = [WaveForm_2Q; ...
        gmSEQ.halfpi + gmSEQ.m * SingleLen_M + SpinLockGap, ...
            gmSEQ.halfpi + gmSEQ.m * SingleLen_M + SpinLockGap + gmSEQ.halfpi,...
            gSG.AWGFreq, ...
            2 * pi / 2 - pi / 2, ...
            gSG.AWGAmp];     
    end
    
%%%% Differential Measuring Waveforms. Just add another pi_y pulse at the
%%%% end.
    WaveForm_3I = [WaveForm_2I; ...
        gmSEQ.halfpi + gmSEQ.m * SingleLen_M + SpinLockGap + gmSEQ.halfpi + PulseGap, ...
            gmSEQ.halfpi + gmSEQ.m * SingleLen_M + SpinLockGap + gmSEQ.halfpi + PulseGap + gmSEQ.pi, ...
            gSG.AWGFreq, ...
            pi / 2, gSG.AWGAmp];
    WaveForm_3Q = [WaveForm_2Q; ...
        gmSEQ.halfpi + gmSEQ.m * SingleLen_M + SpinLockGap + gmSEQ.halfpi + PulseGap, ...
            gmSEQ.halfpi + gmSEQ.m * SingleLen_M + SpinLockGap + gmSEQ.halfpi + PulseGap + gmSEQ.pi, ...
            gSG.AWGFreq, ...
            pi / 2 - pi / 2, gSG.AWGAmp]; 
    
    WaveForm_2Length = ceil((gmSEQ.halfpi + LockLenMeasure + SpinLockGap + gmSEQ.halfpi + PulseGap + gmSEQ.pi + 1000) / (16 / gSG.AWGClockRate)) ...
        * (16 / gSG.AWGClockRate);
    WaveForm_2PointNum = WaveForm_2Length * gSG.AWGClockRate;
    WaveForm_3Length = WaveForm_2Length;
    WaveForm_3PointNum = WaveForm_2PointNum;
    
    % NV pulse to mix up NV
     WaveForm_4I = [0, gmSEQ.halfpi, gSG.AWGFreq, 0, gSG.AWGAmp; ...
         10000, 10000+gmSEQ.halfpi,  gSG.AWGFreq, 0, gSG.AWGAmp; ...
         20000, 20000+gmSEQ.halfpi,  gSG.AWGFreq, 0, gSG.AWGAmp; ...
         30000, 30000+gmSEQ.halfpi,  gSG.AWGFreq, 0, gSG.AWGAmp];
     WaveForm_4Q = [0, gmSEQ.halfpi, gSG.AWGFreq, -pi/2, gSG.AWGAmp; ...
         10000, 10000+gmSEQ.halfpi,  gSG.AWGFreq, -pi/2, gSG.AWGAmp; ...
         20000, 20000+gmSEQ.halfpi,  gSG.AWGFreq, -pi/2, gSG.AWGAmp; ...
         30000, 30000+gmSEQ.halfpi,  gSG.AWGFreq, -pi/2, gSG.AWGAmp];
    
    WaveForm_4Length = ceil((30000+gmSEQ.halfpi+1000) / (16 / gSG.AWGClockRate)) ...
        * (16 / gSG.AWGClockRate);
    WaveForm_4PointNum = WaveForm_4Length * gSG.AWGClockRate;
    
    
else
    questdlg('Only AC mnodulation works for now, please check AC modulation~',...
        'Heating / Cooling Sequence', 'Cancel');
end
%%% Create Wave Form Text Files
chaseFunctionPool('createWaveform', WaveForm_1I, gSG.AWGClockRate, WaveForm_1Length, 'SpecialCooling_I_seg1.txt'); pause(0.5);
chaseFunctionPool('createWaveform', WaveForm_1Q, gSG.AWGClockRate, WaveForm_1Length, 'SpecialCooling_Q_seg1.txt'); pause(0.5);
chaseFunctionPool('createWaveform', WaveForm_2I, gSG.AWGClockRate, WaveForm_2Length, 'SpecialCooling_I_seg2.txt'); pause(0.5);
chaseFunctionPool('createWaveform', WaveForm_2Q, gSG.AWGClockRate, WaveForm_2Length, 'SpecialCooling_Q_seg2.txt'); pause(0.5);
chaseFunctionPool('createWaveform', WaveForm_3I, gSG.AWGClockRate, WaveForm_3Length, 'SpecialCooling_I_seg3.txt'); pause(0.5);
chaseFunctionPool('createWaveform', WaveForm_3Q, gSG.AWGClockRate, WaveForm_3Length, 'SpecialCooling_Q_seg3.txt'); pause(0.5);
chaseFunctionPool('createWaveform', WaveForm_4I, gSG.AWGClockRate, WaveForm_4Length, 'SpecialCooling_I_seg4.txt'); pause(0.5);
chaseFunctionPool('createWaveform', WaveForm_4Q, gSG.AWGClockRate, WaveForm_4Length, 'SpecialCooling_Q_seg4.txt'); pause(0.5);

%%% Create Wave Form Structs -> Pass Segments to AWG
if gmSEQ.CoolCycle == 0
    chaseFunctionPool('createSegStruct', 'SpecialCooling_SegStruct_I.txt', ...
        'SpecialCooling_I_seg4.txt', WaveForm_4PointNum, 1, 1, ...
        'SpecialCooling_I_seg2.txt', WaveForm_2PointNum, 1, 1, ...
        'SpecialCooling_I_seg4.txt', WaveForm_4PointNum, 1, 1, ...
        'SpecialCooling_I_seg3.txt', WaveForm_3PointNum, 1, 1);
    pause(0.5);
    chaseFunctionPool('createSegStruct', 'SpecialCooling_SegStruct_Q.txt', ...
        'SpecialCooling_Q_seg4.txt', WaveForm_4PointNum, 1, 1, ...
        'SpecialCooling_Q_seg2.txt', WaveForm_2PointNum, 1, 1, ...
        'SpecialCooling_Q_seg4.txt', WaveForm_4PointNum, 1, 1, ...
        'SpecialCooling_Q_seg3.txt', WaveForm_3PointNum, 1, 1);
    pause(0.5);
    chaseFunctionPool('CreateSegments', 1, 1, ...
        4, ...
        2047, 2047, 'SpecialCooling_SegStruct_I.txt', 'false');
    pause(1); % this pause seems to be important, otherwise the loading is not right occassionally
    chaseFunctionPool('CreateSegments', 1, 2, ...
        4, ...
        2047, 2047, 'SpecialCooling_SegStruct_Q.txt', 'false');
    pause(1); % this pause seems to be important, otherwise the loading is not right occassionally
    chaseFunctionPool('runChase', 1, 'false');
elseif gmSEQ.CoolCycle == 1
    chaseFunctionPool('createSegStruct', 'SpecialCooling_SegStruct_I.txt', ...
        'SpecialCooling_I_seg4.txt', WaveForm_4PointNum, 1, 1, ...
        'SpecialCooling_I_seg1.txt', WaveForm_1PointNum, 1, 1, ...
        'SpecialCooling_I_seg2.txt', WaveForm_2PointNum, 1, 1, ...
        'SpecialCooling_I_seg4.txt', WaveForm_4PointNum, 1, 1, ...
        'SpecialCooling_I_seg1.txt', WaveForm_1PointNum, 1, 1, ...
        'SpecialCooling_I_seg3.txt', WaveForm_3PointNum, 1, 1);
    pause(0.5);
    chaseFunctionPool('createSegStruct', 'SpecialCooling_SegStruct_Q.txt', ...
        'SpecialCooling_Q_seg4.txt', WaveForm_4PointNum, 1, 1, ...
        'SpecialCooling_Q_seg1.txt', WaveForm_1PointNum, 1, 1, ...
        'SpecialCooling_Q_seg2.txt', WaveForm_2PointNum, 1, 1, ...
        'SpecialCooling_Q_seg4.txt', WaveForm_4PointNum, 1, 1, ...
        'SpecialCooling_Q_seg1.txt', WaveForm_1PointNum, 1, 1, ...
        'SpecialCooling_Q_seg3.txt', WaveForm_3PointNum, 1, 1);
    pause(0.5);
    chaseFunctionPool('CreateSegments', 1, 1, ...
        6, ...
        2047, 2047, 'SpecialCooling_SegStruct_I.txt', 'false');
    pause(1); % this pause seems to be important, otherwise the loading is not right occassionally
    chaseFunctionPool('CreateSegments', 1, 2, ...
        6, ...
        2047, 2047, 'SpecialCooling_SegStruct_Q.txt', 'false');
    pause(1); % this pause seems to be important, otherwise the loading is not right occassionally
    chaseFunctionPool('runChase', 1, 'false');
elseif gmSEQ.CoolCycle < 500
chaseFunctionPool('createSegStruct', 'SpecialCooling_SegStruct_I.txt', ...
    'SpecialCooling_I_seg4.txt', WaveForm_4PointNum, 1, 1, ...
    'SpecialCooling_I_seg1.txt', WaveForm_1PointNum, 1, 1, ... % The first repeatition cannot be looped and must be triggered, so must be left out.
    'SpecialCooling_I_seg1.txt', WaveForm_1PointNum, gmSEQ.CoolCycle - 1, 1, ...
    'SpecialCooling_I_seg2.txt', WaveForm_2PointNum, 1, 1, ...
    'SpecialCooling_I_seg4.txt', WaveForm_4PointNum, 1, 1, ...
    'SpecialCooling_I_seg1.txt', WaveForm_1PointNum, 1, 1, ... % This one just to make sure things are symmetric.
    'SpecialCooling_I_seg1.txt', WaveForm_1PointNum, gmSEQ.CoolCycle - 1, 1, ...
    'SpecialCooling_I_seg3.txt', WaveForm_3PointNum, 1, 1);
pause(0.5);
chaseFunctionPool('createSegStruct', 'SpecialCooling_SegStruct_Q.txt', ...
    'SpecialCooling_Q_seg4.txt', WaveForm_4PointNum, 1, 1, ...
    'SpecialCooling_Q_seg1.txt', WaveForm_1PointNum, 1, 1, ... 
    'SpecialCooling_Q_seg1.txt', WaveForm_1PointNum, gmSEQ.CoolCycle - 1, 1, ...
    'SpecialCooling_Q_seg2.txt', WaveForm_2PointNum, 1, 1, ...
    'SpecialCooling_Q_seg4.txt', WaveForm_4PointNum, 1, 1, ...
    'SpecialCooling_Q_seg1.txt', WaveForm_1PointNum, 1, 1, ...
    'SpecialCooling_Q_seg1.txt', WaveForm_1PointNum, gmSEQ.CoolCycle - 1, 1, ...
    'SpecialCooling_Q_seg3.txt', WaveForm_3PointNum, 1, 1);
pause(0.5);    
chaseFunctionPool('CreateSegments', 1, 1, ...
    8, ...
    2047, 2047, 'SpecialCooling_SegStruct_I.txt', 'false');
pause(3); % this pause seems to be important, otherwise the loading is not right occassionally
chaseFunctionPool('CreateSegments', 1, 2, ...
    8, ...
    2047, 2047, 'SpecialCooling_SegStruct_Q.txt', 'false');
pause(3); % this pause seems to be important, otherwise the loading is not right occassionally
%%% Run AWG.
chaseFunctionPool('runChase', 1, 'false');

end

ApplyDelays();    

function SpecialCooling_ODMR
global gmSEQ gSG
gSG.bfixedPow = 1;
gSG.bfixedFreq = 1;
gSG.bMod = 'IQ';
gSG.bModSrc = 'External';

% If PL signal is collected via APD.
if strcmp(gmSEQ.meas,'APD') 
    gmSEQ.CtrGateDur = 1000;
end

% Cooling sequence [pi/2_x->[t1(Omega_y) -> t2(-Omega_y)]^{N_0}]^{Cooling cycle}...
%ODMR_pi = 1200; ODMR_Amp = 0.02;
ODMR_pi = 500; ODMR_Amp = 0.045;
gmSEQ.halfpi = gmSEQ.pi/2;
Wait_p = 13e6; % to wait for P1 to be fully unpolarized again
AfterPi = 1000;
AfterLaser = 2000;
Detect_Window = 15000;
PulseGap = 30;
SpinLockGap = 0; % The gap (in ns) between t1(Omega) and t2(-Omega).

SingleLen_C = 2 * SpinLockGap + gmSEQ.SLockT1 + gmSEQ.SLockT2; % Length of cooling segment [t1(Omega_y) -> t2(-Omega_y)]
LockLenCool = gmSEQ.LockN0 * SingleLen_C;

% SingleLen_M = 1*(2*SpinLockGap+gmSEQ.SLockT1_M + gmSEQ.SLockT2_M); % Length of measuring segment [t1(Omega_y) -> t2(-Omega_y)]
% LockLenMeasure = gmSEQ.m * SingleLen_M;
LockLenMeasure = ODMR_pi;

AfterLock = 1000;
% Cooling_Readout = gmSEQ.readout;
Cooling_Readout = 1000;

CoolCycleT = Cooling_Readout + AfterLaser + gmSEQ.halfpi + LockLenCool + gmSEQ.halfpi + AfterLock;
CoolCycleT = ceil(CoolCycleT * gSG.AWGClockRate / 16) / (gSG.AWGClockRate / 16);

%% Pulse Blaster
%%% AOM
% Cooling
gmSEQ.CHN(1).PBN=PBDictionary('AOM');
gmSEQ.CHN(1).NRise = 2 * (2 + gmSEQ.CoolCycle);
    gmSEQ.CHN(1).T = [];
    gmSEQ.CHN(1).DT = [];
    for n = 1 : gmSEQ.CoolCycle
        gmSEQ.CHN(1).T = [gmSEQ.CHN(1).T, Wait_p + (n - 1) * CoolCycleT];
        gmSEQ.CHN(1).DT = [gmSEQ.CHN(1).DT, Cooling_Readout];
    end
% Cooling - Measurement
    gmSEQ.CHN(1).T = [gmSEQ.CHN(1).T, ...
        Wait_p + gmSEQ.CoolCycle * CoolCycleT + gmSEQ.CoolWait, ...
        Wait_p + gmSEQ.CoolCycle * CoolCycleT + gmSEQ.CoolWait ...
            + gmSEQ.readout + AfterLaser + gmSEQ.halfpi + LockLenMeasure ...
            + SpinLockGap + gmSEQ.halfpi + PulseGap + gmSEQ.pi+ AfterPi];
    gmSEQ.CHN(1).DT = [gmSEQ.CHN(1).DT, gmSEQ.readout, Detect_Window]; 
% Differential Cooling
    Start_Sig_D = Wait_p + gmSEQ.CoolCycle * CoolCycleT + gmSEQ.CoolWait ...
        + gmSEQ.readout + AfterLaser + gmSEQ.halfpi + LockLenMeasure ...
        + SpinLockGap + gmSEQ.halfpi + PulseGap + gmSEQ.pi + AfterPi ...
        + Detect_Window + Wait_p;
    for n = 1 : gmSEQ.CoolCycle
        gmSEQ.CHN(1).T = [gmSEQ.CHN(1).T, Start_Sig_D + (n - 1) * CoolCycleT];
        gmSEQ.CHN(1).DT = [gmSEQ.CHN(1).DT, Cooling_Readout];
    end
% Differential Cooling - Measurement
    gmSEQ.CHN(1).T = [gmSEQ.CHN(1).T, ...
        Start_Sig_D + gmSEQ.CoolCycle * CoolCycleT + gmSEQ.CoolWait, ...
        Start_Sig_D + gmSEQ.CoolCycle  *CoolCycleT + gmSEQ.CoolWait ...
            + gmSEQ.readout + AfterLaser + gmSEQ.halfpi + LockLenMeasure ...
            + SpinLockGap + gmSEQ.halfpi + PulseGap + gmSEQ.pi + AfterPi];
    gmSEQ.CHN(1).DT = [gmSEQ.CHN(1).DT, gmSEQ.readout, Detect_Window];

%%% APD
% gmSEQ.CHN(numel(gmSEQ.CHN)+1).PBN=PBDictionary('ctr0');
% gmSEQ.CHN(numel(gmSEQ.CHN)).NRise = 4;
% gmSEQ.CHN(numel(gmSEQ.CHN)).T = [gmSEQ.CHN(1).T(gmSEQ.CoolCycle + 1) + gmSEQ.readout - 1000, ...
%     gmSEQ.CHN(1).T(gmSEQ.CoolCycle + 2), ...
%     gmSEQ.CHN(1).T(2 * gmSEQ.CoolCycle + 3) + gmSEQ.readout - 1000, ...
%     gmSEQ.CHN(1).T(2 * gmSEQ.CoolCycle + 4)];
% gmSEQ.CHN(numel(gmSEQ.CHN)).DT = repelem(gmSEQ.CtrGateDur, 1, 4);

gmSEQ.CHN(numel(gmSEQ.CHN)+1).PBN=PBDictionary('ctr0');
gmSEQ.CHN(numel(gmSEQ.CHN)).NRise = 4;
gmSEQ.CHN(numel(gmSEQ.CHN)).T = [gmSEQ.CHN(1).T(gmSEQ.CoolCycle + 2), ...
    gmSEQ.CHN(1).T(gmSEQ.CoolCycle + 2)+Detect_Window-1000-gmSEQ.CtrGateDur, ...
    gmSEQ.CHN(1).T(2 * gmSEQ.CoolCycle + 4), ...
    gmSEQ.CHN(1).T(2 * gmSEQ.CoolCycle + 4)+Detect_Window-1000-gmSEQ.CtrGateDur];
gmSEQ.CHN(numel(gmSEQ.CHN)).DT = repelem(gmSEQ.CtrGateDur, 1, 4);

% Note that for sequence length ~ 2ms / 20ms, the timing difference between
% PulseBlaster and AWG is ~ 10ns / 100ns

% MW Switch
% Cooling -> Cooling - Measurement
gmSEQ.CHN(numel(gmSEQ.CHN) + 1).PBN=PBDictionary('MWSwitch');
gmSEQ.CHN(numel(gmSEQ.CHN)).NRise= 2 + 2 * gmSEQ.CoolCycle + 8;
gmSEQ.CHN(numel(gmSEQ.CHN)).T = [10000-30 20000-30 30000-30 40000-30];
gmSEQ.CHN(numel(gmSEQ.CHN)).DT = [gmSEQ.halfpi+54 gmSEQ.halfpi+54 gmSEQ.halfpi+54 gmSEQ.halfpi+54];
for n = 1 : gmSEQ.CoolCycle
    gmSEQ.CHN(numel(gmSEQ.CHN)).T = [gmSEQ.CHN(numel(gmSEQ.CHN)).T, ...
        Wait_p + (n - 1) * CoolCycleT + Cooling_Readout + AfterLaser - 30]; % double the buffer around IQ.
    gmSEQ.CHN(numel(gmSEQ.CHN)).DT = [gmSEQ.CHN(numel(gmSEQ.CHN)).DT, ...
        gmSEQ.halfpi + LockLenCool + gmSEQ.halfpi + 54];
end

% ODMR measurement
gmSEQ.CHN(numel(gmSEQ.CHN)).T = [gmSEQ.CHN(numel(gmSEQ.CHN)).T, ...
    Wait_p + gmSEQ.CoolCycle * CoolCycleT + gmSEQ.CoolWait + gmSEQ.readout + AfterLaser - 30];
gmSEQ.CHN(numel(gmSEQ.CHN)).DT = [gmSEQ.CHN(numel(gmSEQ.CHN)).DT, ...
    LockLenMeasure + 54];
% Differential Cooling -> Differential Cooling - Measurement


gmSEQ.CHN(numel(gmSEQ.CHN)).T = [gmSEQ.CHN(numel(gmSEQ.CHN)).T, ...
    Start_Sig_D-Wait_p+10000-30 Start_Sig_D-Wait_p+20000-30 Start_Sig_D-Wait_p+30000-30 Start_Sig_D-Wait_p+40000-30];
gmSEQ.CHN(numel(gmSEQ.CHN)).DT = [gmSEQ.CHN(numel(gmSEQ.CHN)).DT gmSEQ.halfpi+54 gmSEQ.halfpi+54 gmSEQ.halfpi+54 gmSEQ.halfpi+54];

for n = 1 : gmSEQ.CoolCycle
    gmSEQ.CHN(numel(gmSEQ.CHN)).T = [gmSEQ.CHN(numel(gmSEQ.CHN)).T, ...
        Start_Sig_D + (n - 1) * CoolCycleT + Cooling_Readout + AfterLaser - 30];
    gmSEQ.CHN(numel(gmSEQ.CHN)).DT = [gmSEQ.CHN(numel(gmSEQ.CHN)).DT, ...
        gmSEQ.halfpi + LockLenCool + gmSEQ.halfpi + 54];
end
% ODMR measurement
gmSEQ.CHN(numel(gmSEQ.CHN)).T = [gmSEQ.CHN(numel(gmSEQ.CHN)).T, ...
    Start_Sig_D + gmSEQ.CoolCycle * CoolCycleT + gmSEQ.CoolWait + gmSEQ.readout + AfterLaser - 30];
gmSEQ.CHN(numel(gmSEQ.CHN)).DT = [gmSEQ.CHN(numel(gmSEQ.CHN)).DT, ...
    LockLenMeasure + PulseGap + gmSEQ.pi + 54];


%%% Dummy 1: to check the total length of the sequence.
Max_length = 2 * Wait_p + 2 * gmSEQ.CoolCycle * CoolCycleT ...
    + 2 * gmSEQ.CoolWait + 2 * gmSEQ.readout + 2 * Detect_Window ...
    + 2 * (AfterLaser + AfterPi + LockLenMeasure + PulseGap + gmSEQ.pi);
gmSEQ.CHN(numel(gmSEQ.CHN) + 1).PBN = PBDictionary('dummy1');
gmSEQ.CHN(numel(gmSEQ.CHN)).NRise = 2;
gmSEQ.CHN(numel(gmSEQ.CHN)).T = [0, Max_length-200];
gmSEQ.CHN(numel(gmSEQ.CHN)).DT = [200, 200];

%%% AWG Trigger
% Each repeatition of the segement need one trigger, a total of 2 *
% (CoolCycle + 1) triggers are needed.
% Cooling -> Cooling - Measurement
gmSEQ.CHN(numel(gmSEQ.CHN)+1).PBN = PBDictionary('AWGTrig');
gmSEQ.CHN(numel(gmSEQ.CHN)).NRise = 2 + 2 + gmSEQ.CoolCycle * 2;
gmSEQ.CHN(numel(gmSEQ.CHN)).T = [10000];
gmSEQ.CHN(numel(gmSEQ.CHN)).DT = [1000];
for n = 1 : gmSEQ.CoolCycle
gmSEQ.CHN(numel(gmSEQ.CHN)).T = [gmSEQ.CHN(numel(gmSEQ.CHN)).T, ... 
    Wait_p + (n - 1) * CoolCycleT + Cooling_Readout + AfterLaser];
gmSEQ.CHN(numel(gmSEQ.CHN)).DT = [gmSEQ.CHN(numel(gmSEQ.CHN)).DT, 500];
end

gmSEQ.CHN(numel(gmSEQ.CHN)).T = [gmSEQ.CHN(numel(gmSEQ.CHN)).T, ...
    Wait_p + gmSEQ.CoolCycle * CoolCycleT + gmSEQ.CoolWait + gmSEQ.readout + AfterLaser];
gmSEQ.CHN(numel(gmSEQ.CHN)).DT=[gmSEQ.CHN(numel(gmSEQ.CHN)).DT, 500];

gmSEQ.CHN(numel(gmSEQ.CHN)).T = [gmSEQ.CHN(numel(gmSEQ.CHN)).T, ...
    Start_Sig_D-Wait_p+10000];
gmSEQ.CHN(numel(gmSEQ.CHN)).DT=[gmSEQ.CHN(numel(gmSEQ.CHN)).DT, 1000];

% Differential Cooling -> Differential Cooling - Measurement
for n = 1:gmSEQ.CoolCycle
gmSEQ.CHN(numel(gmSEQ.CHN)).T = [gmSEQ.CHN(numel(gmSEQ.CHN)).T, ...
    Start_Sig_D + (n - 1) * CoolCycleT + Cooling_Readout + AfterLaser];
gmSEQ.CHN(numel(gmSEQ.CHN)).DT = [gmSEQ.CHN(numel(gmSEQ.CHN)).DT, 500];
end
gmSEQ.CHN(numel(gmSEQ.CHN)).T = [gmSEQ.CHN(numel(gmSEQ.CHN)).T, ...
    Start_Sig_D + gmSEQ.CoolCycle * CoolCycleT + gmSEQ.CoolWait + gmSEQ.readout + AfterLaser];
gmSEQ.CHN(numel(gmSEQ.CHN)).DT = [gmSEQ.CHN(numel(gmSEQ.CHN)).DT, 500]; 

%% AWG
%%% Initialization
chaseFunctionPool('stopChase', 1)
%%% Generating wave form
if gSG.ACmodAWG 
    WaveForm_1I = [];
    WaveForm_1Q = [];
%%%% Cooling / Heating Waveforms.
% |gmSEQ.CoolSwitch| controls whether cooling / heating is turned on. 
    if gmSEQ.CoolSwitch == 1 % Cooling
        WaveForm_1I = [WaveForm_1I; ...
            0, gmSEQ.halfpi, gSG.AWGFreq, 0, gSG.AWGAmp]; % The 1st pi/2_x pulse.
        WaveForm_1Q = [WaveForm_1Q; ...
            0, gmSEQ.halfpi, gSG.AWGFreq, - pi / 2, gSG.AWGAmp];
    elseif gmSEQ.CoolSwitch == 2 % Heating
        WaveForm_1I = [WaveForm_1I; ...
            0, gmSEQ.halfpi, gSG.AWGFreq, pi, gSG.AWGAmp];
        WaveForm_1Q = [WaveForm_1Q; ...
            0, gmSEQ.halfpi, gSG.AWGFreq, pi - pi / 2, gSG.AWGAmp];
    elseif gmSEQ.CoolSwitch == 0 % Nothing
        WaveForm_1I = [WaveForm_1I; ...
            0, gmSEQ.halfpi, 0, 0, 0];
        WaveForm_1Q = [WaveForm_1Q; ...
            0, gmSEQ.halfpi, 0, 0, 0];
    end
    
    for n = 1 : gmSEQ.LockN0 % add segments of [t1(Omega_y) -> t2(-Omega_y)]
       WaveForm_1I = [WaveForm_1I; ...
           gmSEQ.halfpi + (n - 1) * SingleLen_C + SpinLockGap, ...
               gmSEQ.halfpi + (n - 1) * SingleLen_C + SpinLockGap + gmSEQ.SLockT1, ...
               gSG.AWGFreq, ...
               pi / 2, ...
               gSG.AWGAmp * gmSEQ.SAmp1; ...
           gmSEQ.halfpi + (n - 1) * SingleLen_C + SpinLockGap + gmSEQ.SLockT1 + SpinLockGap, ...
               gmSEQ.halfpi + (n - 1) * SingleLen_C + SpinLockGap + gmSEQ.SLockT1 + SpinLockGap + gmSEQ.SLockT2, ...
               gSG.AWGFreq, ...
               3 * pi / 2, ...
               gSG.AWGAmp * gmSEQ.SAmp2];
       WaveForm_1Q = [WaveForm_1Q; ...
           gmSEQ.halfpi + (n - 1) * SingleLen_C + SpinLockGap, ...
               gmSEQ.halfpi + (n - 1) * SingleLen_C + SpinLockGap + gmSEQ.SLockT1, ...
               gSG.AWGFreq, ...
               pi / 2 - pi / 2, ...
               gSG.AWGAmp * gmSEQ.SAmp1; ...
           gmSEQ.halfpi + (n - 1) * SingleLen_C + SpinLockGap + gmSEQ.SLockT1 + SpinLockGap, ...
               gmSEQ.halfpi + (n - 1) * SingleLen_C + SpinLockGap + gmSEQ.SLockT1 + SpinLockGap + gmSEQ.SLockT2, ...
               gSG.AWGFreq, ...
               3 * pi / 2 - pi/2, ...
               gSG.AWGAmp * gmSEQ.SAmp2];     
    end
    
    if gmSEQ.CoolSwitch == 1
        WaveForm_1I = [WaveForm_1I; ...
            gmSEQ.halfpi+gmSEQ.LockN0*SingleLen_C+SpinLockGap, ...
            gmSEQ.halfpi+gmSEQ.LockN0*SingleLen_C+SpinLockGap+gmSEQ.halfpi, ...
             gSG.AWGFreq, ...
             2 * pi / 2, ...
             gSG.AWGAmp];
         WaveForm_1Q = [WaveForm_1Q; ...
            gmSEQ.halfpi+gmSEQ.LockN0*SingleLen_C+SpinLockGap, ...
            gmSEQ.halfpi+gmSEQ.LockN0*SingleLen_C+SpinLockGap+gmSEQ.halfpi, ...
             gSG.AWGFreq, ...
             2 * pi / 2 - pi / 2, ...
             gSG.AWGAmp];
                      
    elseif gmSEQ.CoolSwitch == 2
         WaveForm_1I = [WaveForm_1I; ...
            gmSEQ.halfpi+gmSEQ.LockN0*SingleLen_C+SpinLockGap, ...
            gmSEQ.halfpi+gmSEQ.LockN0*SingleLen_C+SpinLockGap+gmSEQ.halfpi, ...
             gSG.AWGFreq, ...
             0 * pi / 2, ...
             gSG.AWGAmp];
         WaveForm_1Q = [WaveForm_1Q; ...
            gmSEQ.halfpi+gmSEQ.LockN0*SingleLen_C+SpinLockGap, ...
            gmSEQ.halfpi+gmSEQ.LockN0*SingleLen_C+SpinLockGap+gmSEQ.halfpi, ...
             gSG.AWGFreq, ...
             0 * pi / 2 - pi / 2, ...
             gSG.AWGAmp];
        
    end
    
    WaveForm_1Length = ceil((gmSEQ.halfpi + LockLenCool + gmSEQ.halfpi + 1000) / (16 / gSG.AWGClockRate)) ...
        *(16 / gSG.AWGClockRate);
    WaveForm_1PointNum = WaveForm_1Length * gSG.AWGClockRate;
    
%%%% Measuring Waveforms.    
        WaveForm_2I = [0, ODMR_pi, gmSEQ.m, 0, ODMR_Amp]; 
        WaveForm_2Q = [0, ODMR_pi, gmSEQ.m, -pi/2, ODMR_Amp];    
   
%%%% Differential Measuring Waveforms. Just add another pi_y pulse at the
%%%% end.
    WaveForm_3I = WaveForm_2I;
    WaveForm_3Q = WaveForm_2Q; 
    
    WaveForm_2Length = ceil((ODMR_pi + PulseGap + gmSEQ.pi + 1000) / (16 / gSG.AWGClockRate)) ...
        * (16 / gSG.AWGClockRate);
    WaveForm_2PointNum = WaveForm_2Length * gSG.AWGClockRate;
    WaveForm_3Length = WaveForm_2Length;
    WaveForm_3PointNum = WaveForm_2PointNum;
    
    % NV pulse to mix up NV
     WaveForm_4I = [0, gmSEQ.halfpi, gSG.AWGFreq, 0, gSG.AWGAmp; ...
         10000, 10000+gmSEQ.halfpi,  gSG.AWGFreq, 0, gSG.AWGAmp; ...
         20000, 20000+gmSEQ.halfpi,  gSG.AWGFreq, 0, gSG.AWGAmp; ...
         30000, 30000+gmSEQ.halfpi,  gSG.AWGFreq, 0, gSG.AWGAmp];
     WaveForm_4Q = [0, gmSEQ.halfpi, gSG.AWGFreq, -pi/2, gSG.AWGAmp; ...
         10000, 10000+gmSEQ.halfpi,  gSG.AWGFreq, -pi/2, gSG.AWGAmp; ...
         20000, 20000+gmSEQ.halfpi,  gSG.AWGFreq, -pi/2, gSG.AWGAmp; ...
         30000, 30000+gmSEQ.halfpi,  gSG.AWGFreq, -pi/2, gSG.AWGAmp];
    
    WaveForm_4Length = ceil((30000+gmSEQ.halfpi+1000) / (16 / gSG.AWGClockRate)) ...
        * (16 / gSG.AWGClockRate);
    WaveForm_4PointNum = WaveForm_4Length * gSG.AWGClockRate;
    
    
else
    questdlg('Only AC mnodulation works for now, please check AC modulation~',...
        'Heating / Cooling Sequence', 'Cancel');
end
%%% Create Wave Form Text Files
chaseFunctionPool('createWaveform', WaveForm_1I, gSG.AWGClockRate, WaveForm_1Length, 'SpecialCooling_I_seg1.txt'); pause(0.5);
chaseFunctionPool('createWaveform', WaveForm_1Q, gSG.AWGClockRate, WaveForm_1Length, 'SpecialCooling_Q_seg1.txt'); pause(0.5);
chaseFunctionPool('createWaveform', WaveForm_2I, gSG.AWGClockRate, WaveForm_2Length, 'SpecialCooling_I_seg2.txt'); pause(0.5);
chaseFunctionPool('createWaveform', WaveForm_2Q, gSG.AWGClockRate, WaveForm_2Length, 'SpecialCooling_Q_seg2.txt'); pause(0.5);
chaseFunctionPool('createWaveform', WaveForm_3I, gSG.AWGClockRate, WaveForm_3Length, 'SpecialCooling_I_seg3.txt'); pause(0.5);
chaseFunctionPool('createWaveform', WaveForm_3Q, gSG.AWGClockRate, WaveForm_3Length, 'SpecialCooling_Q_seg3.txt'); pause(0.5);
chaseFunctionPool('createWaveform', WaveForm_4I, gSG.AWGClockRate, WaveForm_4Length, 'SpecialCooling_I_seg4.txt'); pause(0.5);
chaseFunctionPool('createWaveform', WaveForm_4Q, gSG.AWGClockRate, WaveForm_4Length, 'SpecialCooling_Q_seg4.txt'); pause(0.5);

%%% Create Wave Form Structs -> Pass Segments to AWG
if gmSEQ.CoolCycle == 0
    chaseFunctionPool('createSegStruct', 'SpecialCooling_SegStruct_I.txt', ...
        'SpecialCooling_I_seg4.txt', WaveForm_4PointNum, 1, 1, ...
        'SpecialCooling_I_seg2.txt', WaveForm_2PointNum, 1, 1, ...
        'SpecialCooling_I_seg4.txt', WaveForm_4PointNum, 1, 1, ...
        'SpecialCooling_I_seg3.txt', WaveForm_3PointNum, 1, 1);
    pause(0.5);
    chaseFunctionPool('createSegStruct', 'SpecialCooling_SegStruct_Q.txt', ...
        'SpecialCooling_Q_seg4.txt', WaveForm_4PointNum, 1, 1, ...
        'SpecialCooling_Q_seg2.txt', WaveForm_2PointNum, 1, 1, ...
        'SpecialCooling_Q_seg4.txt', WaveForm_4PointNum, 1, 1, ...
        'SpecialCooling_Q_seg3.txt', WaveForm_3PointNum, 1, 1);
    pause(0.5);
    chaseFunctionPool('CreateSegments', 1, 1, ...
        4, ...
        2047, 2047, 'SpecialCooling_SegStruct_I.txt', 'false');
    pause(1); % this pause seems to be important, otherwise the loading is not right occassionally
    chaseFunctionPool('CreateSegments', 1, 2, ...
        4, ...
        2047, 2047, 'SpecialCooling_SegStruct_Q.txt', 'false');
    pause(1); % this pause seems to be important, otherwise the loading is not right occassionally
    chaseFunctionPool('runChase', 1, 'false');
elseif gmSEQ.CoolCycle == 1
    chaseFunctionPool('createSegStruct', 'SpecialCooling_SegStruct_I.txt', ...
        'SpecialCooling_I_seg4.txt', WaveForm_4PointNum, 1, 1, ...
        'SpecialCooling_I_seg1.txt', WaveForm_1PointNum, 1, 1, ...
        'SpecialCooling_I_seg2.txt', WaveForm_2PointNum, 1, 1, ...
        'SpecialCooling_I_seg4.txt', WaveForm_4PointNum, 1, 1, ...
        'SpecialCooling_I_seg1.txt', WaveForm_1PointNum, 1, 1, ...
        'SpecialCooling_I_seg3.txt', WaveForm_3PointNum, 1, 1);
    pause(0.5);
    chaseFunctionPool('createSegStruct', 'SpecialCooling_SegStruct_Q.txt', ...
        'SpecialCooling_Q_seg4.txt', WaveForm_4PointNum, 1, 1, ...
        'SpecialCooling_Q_seg1.txt', WaveForm_1PointNum, 1, 1, ...
        'SpecialCooling_Q_seg2.txt', WaveForm_2PointNum, 1, 1, ...
        'SpecialCooling_Q_seg4.txt', WaveForm_4PointNum, 1, 1, ...
        'SpecialCooling_Q_seg1.txt', WaveForm_1PointNum, 1, 1, ...
        'SpecialCooling_Q_seg3.txt', WaveForm_3PointNum, 1, 1);
    pause(0.5);
    chaseFunctionPool('CreateSegments', 1, 1, ...
        6, ...
        2047, 2047, 'SpecialCooling_SegStruct_I.txt', 'false');
    pause(1); % this pause seems to be important, otherwise the loading is not right occassionally
    chaseFunctionPool('CreateSegments', 1, 2, ...
        6, ...
        2047, 2047, 'SpecialCooling_SegStruct_Q.txt', 'false');
    pause(1); % this pause seems to be important, otherwise the loading is not right occassionally
    chaseFunctionPool('runChase', 1, 'false');
elseif gmSEQ.CoolCycle < 500
chaseFunctionPool('createSegStruct', 'SpecialCooling_SegStruct_I.txt', ...
    'SpecialCooling_I_seg4.txt', WaveForm_4PointNum, 1, 1, ...
    'SpecialCooling_I_seg1.txt', WaveForm_1PointNum, 1, 1, ... % The first repeatition cannot be looped and must be triggered, so must be left out.
    'SpecialCooling_I_seg1.txt', WaveForm_1PointNum, gmSEQ.CoolCycle - 1, 1, ...
    'SpecialCooling_I_seg2.txt', WaveForm_2PointNum, 1, 1, ...
    'SpecialCooling_I_seg4.txt', WaveForm_4PointNum, 1, 1, ...
    'SpecialCooling_I_seg1.txt', WaveForm_1PointNum, 1, 1, ... % This one just to make sure things are symmetric.
    'SpecialCooling_I_seg1.txt', WaveForm_1PointNum, gmSEQ.CoolCycle - 1, 1, ...
    'SpecialCooling_I_seg3.txt', WaveForm_3PointNum, 1, 1);
pause(0.5);
chaseFunctionPool('createSegStruct', 'SpecialCooling_SegStruct_Q.txt', ...
    'SpecialCooling_Q_seg4.txt', WaveForm_4PointNum, 1, 1, ...
    'SpecialCooling_Q_seg1.txt', WaveForm_1PointNum, 1, 1, ... 
    'SpecialCooling_Q_seg1.txt', WaveForm_1PointNum, gmSEQ.CoolCycle - 1, 1, ...
    'SpecialCooling_Q_seg2.txt', WaveForm_2PointNum, 1, 1, ...
    'SpecialCooling_Q_seg4.txt', WaveForm_4PointNum, 1, 1, ...
    'SpecialCooling_Q_seg1.txt', WaveForm_1PointNum, 1, 1, ...
    'SpecialCooling_Q_seg1.txt', WaveForm_1PointNum, gmSEQ.CoolCycle - 1, 1, ...
    'SpecialCooling_Q_seg3.txt', WaveForm_3PointNum, 1, 1);
pause(0.5);    
chaseFunctionPool('CreateSegments', 1, 1, ...
    8, ...
    2047, 2047, 'SpecialCooling_SegStruct_I.txt', 'false');
pause(3); % this pause seems to be important, otherwise the loading is not right occassionally
chaseFunctionPool('CreateSegments', 1, 2, ...
    8, ...
    2047, 2047, 'SpecialCooling_SegStruct_Q.txt', 'false');
pause(3); % this pause seems to be important, otherwise the loading is not right occassionally
%%% Run AWG.
chaseFunctionPool('runChase', 1, 'false');

% else
%     chaseFunctionPool('createSegStruct', 'SpecialCooling_SegStruct_I.txt', ...
%     'SpecialCooling_I_seg1.txt', WaveForm_1PointNum, 1, 1, ... % The first repeatition cannot be looped and must be triggered, so must be left out.
%     'SpecialCooling_I_seg1.txt', WaveForm_1PointNum, 300, 1, ...
%     'SpecialCooling_I_seg1.txt', WaveForm_1PointNum, gmSEQ.CoolCycle-300-1, 1, ...
%     'SpecialCooling_I_seg2.txt', WaveForm_2PointNum, 1, 1, ...
%     'SpecialCooling_I_seg1.txt', WaveForm_1PointNum, 1, 1, ... % This one just to make sure things are symmetric.
%     'SpecialCooling_I_seg1.txt', WaveForm_1PointNum, 300, 1, ...
%     'SpecialCooling_I_seg1.txt', WaveForm_1PointNum, gmSEQ.CoolCycle-300-1, 1, ...
%     'SpecialCooling_I_seg3.txt', WaveForm_3PointNum, 1, 1);
% pause(0.5);
% chaseFunctionPool('createSegStruct', 'SpecialCooling_SegStruct_Q.txt', ...
%     'SpecialCooling_Q_seg1.txt', WaveForm_1PointNum, 1, 1, ... 
%     'SpecialCooling_Q_seg1.txt', WaveForm_1PointNum, 300, 1, ...
%     'SpecialCooling_Q_seg1.txt', WaveForm_1PointNum, gmSEQ.CoolCycle-300-1, 1, ...
%     'SpecialCooling_Q_seg2.txt', WaveForm_2PointNum, 1, 1, ...
%     'SpecialCooling_Q_seg1.txt', WaveForm_1PointNum, 1, 1, ...
%     'SpecialCooling_Q_seg1.txt', WaveForm_1PointNum, 300, 1, ...
%     'SpecialCooling_Q_seg1.txt', WaveForm_1PointNum, gmSEQ.CoolCycle-300-1, 1, ...
%     'SpecialCooling_Q_seg3.txt', WaveForm_3PointNum, 1, 1);
% pause(0.5);    
% chaseFunctionPool('CreateSegments', 1, 1, ...
%     8, ...
%     2047, 2047, 'SpecialCooling_SegStruct_I.txt', 'false');
% pause(3); % this pause seems to be important, otherwise the loading is not right occassionally
% chaseFunctionPool('CreateSegments', 1, 2, ...
%     8, ...
%     2047, 2047, 'SpecialCooling_SegStruct_Q.txt', 'false');
% pause(3); % this pause seems to be important, otherwise the loading is not right occassionally
% %%% Run AWG.
% chaseFunctionPool('runChase', 1, 'false');
end
ApplyDelays();    

function DEER_ODMR
global gmSEQ gSG gSG2
gSG.bfixedPow=1;
gSG.bfixedFreq=1;
gSG.bMod='IQ';
gSG.bModSrc='External';

gmSEQ.ScaleStr = "GHz";
gmSEQ.ScaleT = 1;

% gSG2.bMod=' ';
gSG2.bMod='IQ';
gSG2.bModSrc='External';

SignalGeneratorFunctionPool2('SetMod');

if gSG.ACmodAWG
    gSG2.Freq = (gmSEQ.m - gSG2.AWGFreq)*1e9;
else
    gSG2.Freq = gmSEQ.m*1e9;
end

SignalGeneratorFunctionPool2('WritePow');
SignalGeneratorFunctionPool2('WriteFreq');
gSG2.bOn=1; SignalGeneratorFunctionPool2('RFOnOff');

AfterPi = 2000;
% AfterLaser = 2000;
AfterLaser = 0.03e6; % changed by Weijie 12/03/2021
PulseGap = 30;
Wait_p = 0.01e6;
Detect_Window = 5000;
%%%%% Fixed sequence length %%%%%%

Sig_D_start = Wait_p+gmSEQ.readout+AfterLaser+gmSEQ.halfpi+gmSEQ.DEERt/2+gmSEQ.pi+gmSEQ.DEERt/2+gmSEQ.halfpi+PulseGap+gmSEQ.pi+AfterPi+Detect_Window+Wait_p;

gmSEQ.CHN(1).PBN=PBDictionary('ctr0');
gmSEQ.CHN(1).NRise=4;
gmSEQ.CHN(1).T=[Wait_p+gmSEQ.readout-1000-gmSEQ.CtrGateDur, Wait_p+gmSEQ.readout+AfterLaser+gmSEQ.halfpi+gmSEQ.DEERt/2+gmSEQ.pi+gmSEQ.DEERt/2+gmSEQ.halfpi+PulseGap+gmSEQ.pi+AfterPi, ...
    Sig_D_start+gmSEQ.readout-1000-gmSEQ.CtrGateDur, Sig_D_start+gmSEQ.readout+AfterLaser+gmSEQ.halfpi+gmSEQ.DEERt/2+gmSEQ.pi+gmSEQ.DEERt/2+gmSEQ.halfpi+PulseGap+gmSEQ.pi+AfterPi];
if strcmp(gmSEQ.meas,'SPCM')
    gmSEQ.CHN(1).DT=[gmSEQ.CtrGateDur gmSEQ.CtrGateDur gmSEQ.CtrGateDur gmSEQ.CtrGateDur];
elseif strcmp(gmSEQ.meas,'APD')
    gmSEQ.CHN(1).DT=[1000 1000 1000 1000];
end

gmSEQ.CHN(numel(gmSEQ.CHN)+1).PBN=PBDictionary('AOM');
gmSEQ.CHN(numel(gmSEQ.CHN)).NRise=4;
gmSEQ.CHN(numel(gmSEQ.CHN)).T = [Wait_p, Wait_p+gmSEQ.readout+AfterLaser+gmSEQ.halfpi+gmSEQ.DEERt/2+gmSEQ.pi+gmSEQ.DEERt/2+gmSEQ.halfpi+PulseGap+gmSEQ.pi+AfterPi, ...
    Sig_D_start, Sig_D_start+gmSEQ.readout+AfterLaser+gmSEQ.halfpi+gmSEQ.DEERt/2+gmSEQ.pi+gmSEQ.DEERt/2+gmSEQ.halfpi+PulseGap+gmSEQ.pi+AfterPi];
gmSEQ.CHN(numel(gmSEQ.CHN)).DT = [gmSEQ.readout Detect_Window gmSEQ.readout Detect_Window];
%

gmSEQ.CHN(numel(gmSEQ.CHN)+1).PBN=PBDictionary('AWGTrig');
gmSEQ.CHN(numel(gmSEQ.CHN)).NRise=2;
gmSEQ.CHN(numel(gmSEQ.CHN)).T=[Wait_p+gmSEQ.readout+AfterLaser, ...
    Sig_D_start+gmSEQ.readout+AfterLaser];
% gmSEQ.CHN(numel(gmSEQ.CHN)).DT=repelem(gmSEQ.halfpi+gmSEQ.DEERt/2+gmSEQ.pi+gmSEQ.DEERt/2+gmSEQ.halfpi+200, 2);
gmSEQ.CHN(numel(gmSEQ.CHN)).DT=repelem(gmSEQ.halfpi+500, 2);

SwitchPi = max(gmSEQ.DEERpi, gmSEQ.pi);

gmSEQ.CHN(numel(gmSEQ.CHN)+1).PBN=PBDictionary('AWGTrig2');
gmSEQ.CHN(numel(gmSEQ.CHN)).NRise=2;
gmSEQ.CHN(numel(gmSEQ.CHN)).T=[Wait_p+gmSEQ.readout+AfterLaser+gmSEQ.halfpi+gmSEQ.DEERt/2+gmSEQ.pi/2-gmSEQ.DEERpi/2, ...
    Sig_D_start+gmSEQ.readout+AfterLaser+gmSEQ.halfpi+gmSEQ.DEERt/2+gmSEQ.pi/2-gmSEQ.DEERpi/2];
% gmSEQ.CHN(numel(gmSEQ.CHN)).DT=repelem(gmSEQ.pi+gmSEQ.DEERt/2+gmSEQ.halfpi+200, 2);
gmSEQ.CHN(numel(gmSEQ.CHN)).DT=repelem(SwitchPi+500, 2);

BeforeSwitch = 20;
AfterSwitch = 20;
TotSwitch = BeforeSwitch + AfterSwitch;
gmSEQ.CHN(numel(gmSEQ.CHN)+1).PBN=PBDictionary('MWSwitch');
if gmSEQ.DEERt/2 < 200
    gmSEQ.CHN(numel(gmSEQ.CHN)).NRise=2;
    gmSEQ.CHN(numel(gmSEQ.CHN)).T=[Wait_p+gmSEQ.readout+AfterLaser-BeforeSwitch, Sig_D_start+gmSEQ.readout+AfterLaser-BeforeSwitch];
    gmSEQ.CHN(numel(gmSEQ.CHN)).DT=[gmSEQ.halfpi+gmSEQ.DEERt/2+gmSEQ.pi+gmSEQ.DEERt/2+gmSEQ.halfpi+TotSwitch, ... 
    gmSEQ.halfpi+gmSEQ.DEERt/2+gmSEQ.pi+gmSEQ.DEERt/2+gmSEQ.halfpi+PulseGap+gmSEQ.pi+TotSwitch];
else
    gmSEQ.CHN(numel(gmSEQ.CHN)).NRise=6;
    gmSEQ.CHN(numel(gmSEQ.CHN)).T=[Wait_p+gmSEQ.readout+AfterLaser-BeforeSwitch, ... 
        Wait_p+gmSEQ.readout+AfterLaser+gmSEQ.halfpi+gmSEQ.DEERt/2+gmSEQ.pi/2-SwitchPi/2-BeforeSwitch, ...
        Wait_p+gmSEQ.readout+AfterLaser+gmSEQ.halfpi+gmSEQ.DEERt/2+gmSEQ.pi+gmSEQ.DEERt/2-BeforeSwitch, ...
        Sig_D_start+gmSEQ.readout+AfterLaser-BeforeSwitch, ...
        Sig_D_start+gmSEQ.readout+AfterLaser+gmSEQ.halfpi+gmSEQ.DEERt/2+gmSEQ.pi/2-SwitchPi/2-BeforeSwitch, ...
        Sig_D_start+gmSEQ.readout+AfterLaser+gmSEQ.halfpi+gmSEQ.DEERt/2+gmSEQ.pi+gmSEQ.DEERt/2-BeforeSwitch];
    gmSEQ.CHN(numel(gmSEQ.CHN)).DT=[gmSEQ.halfpi+TotSwitch, SwitchPi+TotSwitch, gmSEQ.halfpi+TotSwitch, ... 
    gmSEQ.halfpi+TotSwitch, SwitchPi+TotSwitch, gmSEQ.halfpi+PulseGap+gmSEQ.pi+TotSwitch];
end

gmSEQ.CHN(numel(gmSEQ.CHN)+1).PBN=PBDictionary('MWSwitch2');
gmSEQ.CHN(numel(gmSEQ.CHN)).NRise=2;
gmSEQ.CHN(numel(gmSEQ.CHN)).T=[Wait_p+gmSEQ.readout+AfterLaser+gmSEQ.halfpi+gmSEQ.DEERt/2+gmSEQ.pi/2-SwitchPi/2-BeforeSwitch, ...
Sig_D_start+gmSEQ.readout+AfterLaser+gmSEQ.halfpi+gmSEQ.DEERt/2+gmSEQ.pi/2-SwitchPi/2-BeforeSwitch];
gmSEQ.CHN(numel(gmSEQ.CHN)).DT=[SwitchPi+TotSwitch SwitchPi+TotSwitch];

gmSEQ.CHN(numel(gmSEQ.CHN)+1).PBN=PBDictionary('dummy1');
gmSEQ.CHN(numel(gmSEQ.CHN)).NRise=2;
gmSEQ.CHN(numel(gmSEQ.CHN)).T=[0 Sig_D_start+gmSEQ.readout+AfterLaser+gmSEQ.halfpi+gmSEQ.DEERt/2+gmSEQ.pi+gmSEQ.DEERt/2+gmSEQ.halfpi+PulseGap+gmSEQ.pi+AfterPi+Detect_Window-50];
gmSEQ.CHN(numel(gmSEQ.CHN)).DT=[50 50];

%% AWG
% Initialization
chaseFunctionPool('stopChase', gmSEQ.MWAWG);
chaseFunctionPool('stopChase', gmSEQ.P1AWG);

if gSG.ACmodAWG % in AC modulation mode
    
    WaveForm_1I = [0 gmSEQ.halfpi gSG.AWGFreq 0 gSG.AWGAmp;...
        gmSEQ.halfpi+gmSEQ.DEERt/2 gmSEQ.halfpi+gmSEQ.DEERt/2+gmSEQ.pi gSG.AWGFreq pi/2 gSG.AWGAmp; ...
        gmSEQ.halfpi+gmSEQ.DEERt/2+gmSEQ.pi+gmSEQ.DEERt/2 gmSEQ.halfpi+gmSEQ.DEERt/2+gmSEQ.pi+gmSEQ.DEERt/2+gmSEQ.halfpi gSG.AWGFreq pi gSG.AWGAmp];
    WaveForm_1Q = [0 gmSEQ.halfpi gSG.AWGFreq -pi/2 gSG.AWGAmp;...
        gmSEQ.halfpi+gmSEQ.DEERt/2 gmSEQ.halfpi+gmSEQ.DEERt/2+gmSEQ.pi gSG.AWGFreq pi/2-pi/2 gSG.AWGAmp; ...
        gmSEQ.halfpi+gmSEQ.DEERt/2+gmSEQ.pi+gmSEQ.DEERt/2 gmSEQ.halfpi+gmSEQ.DEERt/2+gmSEQ.pi+gmSEQ.DEERt/2+gmSEQ.halfpi gSG.AWGFreq pi-pi/2 gSG.AWGAmp];
    
    WaveForm_1Length = ceil((gmSEQ.halfpi+gmSEQ.DEERt/2+gmSEQ.pi+gmSEQ.DEERt/2+gmSEQ.halfpi+1000) / (16 / gSG.AWGClockRate)) ...
        *(16 / gSG.AWGClockRate);
    WaveForm_1PointNum = WaveForm_1Length * gSG.AWGClockRate;

    % dark sequence
    WaveForm_2I = [WaveForm_1I;...
          gmSEQ.halfpi+gmSEQ.DEERt/2+gmSEQ.pi+gmSEQ.DEERt/2+gmSEQ.halfpi+PulseGap gmSEQ.halfpi+gmSEQ.DEERt/2+gmSEQ.pi+gmSEQ.DEERt/2+gmSEQ.halfpi+PulseGap+gmSEQ.pi gSG.AWGFreq pi/2 gSG.AWGAmp];
    WaveForm_2Q = [WaveForm_1Q;...
          gmSEQ.halfpi+gmSEQ.DEERt/2+gmSEQ.pi+gmSEQ.DEERt/2+gmSEQ.halfpi+PulseGap gmSEQ.halfpi+gmSEQ.DEERt/2+gmSEQ.pi+gmSEQ.DEERt/2+gmSEQ.halfpi+PulseGap+gmSEQ.pi gSG.AWGFreq pi/2-pi/2 gSG.AWGAmp];
    
    WaveForm_2Length = ceil((gmSEQ.halfpi+gmSEQ.DEERt/2+gmSEQ.pi+gmSEQ.DEERt/2+gmSEQ.halfpi+PulseGap+gmSEQ.pi+1000) / (16 / gSG.AWGClockRate)) ...
        *(16 / gSG.AWGClockRate);
    WaveForm_2PointNum = WaveForm_2Length * gSG.AWGClockRate;
    
    % P1 sequence
    WaveForm_3I = [0 gmSEQ.DEERpi gSG2.AWGFreq 0 gSG2.AWGAmp];
    WaveForm_3Q = [0 gmSEQ.DEERpi gSG2.AWGFreq -pi/2 gSG2.AWGAmp];
    
    WaveForm_3Length = ceil((gmSEQ.DEERpi+1000) / (16 / gSG2.P1AWGClockRate)) ...
        *(16 / gSG2.P1AWGClockRate);
    WaveForm_3PointNum = WaveForm_3Length * gSG2.P1AWGClockRate;
                
else

    WaveForm_1I = [0 gmSEQ.halfpi 0 pi/2 gSG.AWGAmp;...
           gmSEQ.halfpi+gmSEQ.DEERt/2+gmSEQ.pi+gmSEQ.DEERt/2 gmSEQ.halfpi+gmSEQ.DEERt/2+gmSEQ.pi+gmSEQ.DEERt/2+gmSEQ.halfpi 0 3*pi/2 gSG.AWGAmp];
    WaveForm_1Q = [0 gmSEQ.halfpi 0 0 0;...
        gmSEQ.halfpi+gmSEQ.DEERt/2 gmSEQ.halfpi+gmSEQ.DEERt/2+gmSEQ.pi 0 pi/2 gSG.AWGAmp];
    
    WaveForm_1Length = ceil((gmSEQ.halfpi+gmSEQ.DEERt/2+gmSEQ.pi+gmSEQ.DEERt/2+gmSEQ.halfpi+1000) / (16 / gSG.AWGClockRate)) ...
        *(16 / gSG.AWGClockRate);
    WaveForm_1PointNum = WaveForm_1Length * gSG.AWGClockRate;
    
    % dark sequence
    WaveForm_2I = [0 gmSEQ.halfpi 0 pi/2 gSG.AWGAmp;...
           gmSEQ.halfpi+gmSEQ.DEERt/2+gmSEQ.pi+gmSEQ.DEERt/2 gmSEQ.halfpi+gmSEQ.DEERt/2+gmSEQ.pi+gmSEQ.DEERt/2+gmSEQ.halfpi 0 3*pi/2 gSG.AWGAmp];
    WaveForm_2Q = [0 gmSEQ.halfpi 0 0 0;...
        gmSEQ.halfpi+gmSEQ.DEERt/2 gmSEQ.halfpi+gmSEQ.DEERt/2+gmSEQ.pi 0 pi/2 gSG.AWGAmp; ...
        gmSEQ.halfpi+gmSEQ.DEERt/2+gmSEQ.pi+gmSEQ.DEERt/2+gmSEQ.halfpi+PulseGap gmSEQ.halfpi+gmSEQ.DEERt/2+gmSEQ.pi+gmSEQ.DEERt/2+gmSEQ.halfpi+PulseGap+gmSEQ.pi 0 pi/2 gSG.AWGAmp];
    
    WaveForm_2Length = ceil((gmSEQ.halfpi+gmSEQ.DEERt/2+gmSEQ.pi+gmSEQ.DEERt/2+gmSEQ.halfpi+PulseGap+gmSEQ.pi+1000) / (16 / gSG.AWGClockRate)) ...
        *(16 / gSG.AWGClockRate);
    WaveForm_2PointNum = WaveForm_2Length * gSG.AWGClockRate;
    
    % P1 sequence
    WaveForm_3I = [0 gmSEQ.DEERpi 0 0 gSG2.AWGAmp];
    WaveForm_3Q = [0 gmSEQ.DEERpi 0 -pi/2 gSG2.AWGAmp];
    
    WaveForm_3Length = ceil((gmSEQ.DEERpi+1000) / (16 / gSG2.P1AWGClockRate)) *(16 / gSG2.P1AWGClockRate);
    WaveForm_3PointNum = WaveForm_3Length * gSG2.P1AWGClockRate;

end
chaseFunctionPool('createWaveform', WaveForm_1I, gSG.AWGClockRate, WaveForm_1Length, 'DEER_ODMR_I_seg1.txt'); pause(0.5);
chaseFunctionPool('createWaveform', WaveForm_1Q, gSG.AWGClockRate, WaveForm_1Length, 'DEER_ODMR_Q_seg1.txt'); pause(0.5);
chaseFunctionPool('createWaveform', WaveForm_2I, gSG.AWGClockRate, WaveForm_2Length, 'DEER_ODMR_I_seg2.txt'); pause(0.5);
chaseFunctionPool('createWaveform', WaveForm_2Q, gSG.AWGClockRate, WaveForm_2Length, 'DEER_ODMR_Q_seg2.txt'); pause(0.5);
chaseFunctionPool('createWaveform', WaveForm_3I, gSG2.P1AWGClockRate, WaveForm_3Length, 'DEER_ODMR_I_seg3.txt'); pause(0.5);
chaseFunctionPool('createWaveform', WaveForm_3Q, gSG2.P1AWGClockRate, WaveForm_3Length, 'DEER_ODMR_Q_seg3.txt'); pause(0.5);

chaseFunctionPool('createSegStruct', 'DEER_ODMR_SegStruct_I.txt', ...
    'DEER_ODMR_I_seg1.txt', WaveForm_1PointNum, 1, 1, ...
    'DEER_ODMR_I_seg2.txt', WaveForm_2PointNum, 1, 1);
pause(0.5);
chaseFunctionPool('createSegStruct', 'DEER_ODMR_SegStruct_Q.txt', ...
    'DEER_ODMR_Q_seg1.txt', WaveForm_1PointNum, 1, 1, ...
    'DEER_ODMR_Q_seg2.txt', WaveForm_2PointNum, 1, 1);
pause(0.5);
chaseFunctionPool('createSegStruct', 'DEER_ODMR_P1_SegStruct_I.txt', ...
    'DEER_ODMR_I_seg3.txt', WaveForm_3PointNum, 1, 1, ...
    'DEER_ODMR_I_seg3.txt', WaveForm_3PointNum, 1, 1);
pause(0.5);
chaseFunctionPool('createSegStruct', 'DEER_ODMR_P1_SegStruct_Q.txt', ...
    'DEER_ODMR_Q_seg3.txt', WaveForm_3PointNum, 1, 1, ...
    'DEER_ODMR_Q_seg3.txt', WaveForm_3PointNum, 1, 1);
pause(0.5);
chaseFunctionPool('CreateSegments', gmSEQ.MWAWG, 1, ...
    2, ...
    2047, 2047, 'DEER_ODMR_SegStruct_I.txt', 'false');
pause(1); % this pause seems to be important, otherwise the loading is not right occassionally
chaseFunctionPool('CreateSegments', gmSEQ.MWAWG, 2, ...
    2, ...
    2047, 2047, 'DEER_ODMR_SegStruct_Q.txt', 'false');
pause(1); % this pause seems to be important, otherwise the loading is not right occassionally
chaseFunctionPool('CreateSegments', gmSEQ.P1AWG, 1, ...
    2, ...
    2047, 2047, 'DEER_ODMR_P1_SegStruct_I.txt', 'false');
pause(1); % this pause seems to be important, otherwise the loading is not right occassionally   
chaseFunctionPool('CreateSegments', gmSEQ.P1AWG, 2, ...
    2, ...
    2047, 2047, 'DEER_ODMR_P1_SegStruct_Q.txt', 'false');
pause(1); % this pause seems to be important, otherwise the loading is not right occassionally   
chaseFunctionPool('runChase', gmSEQ.MWAWG, 'false'); pause(1); 
chaseFunctionPool('runChase', gmSEQ.P1AWG, 'false'); pause(1);
    
ApplyDelays();

function DEER_Rabi
global gmSEQ gSG gSG2
gSG.bfixedPow=1;
gSG.bfixedFreq=1;
gSG.bMod='IQ';
gSG.bModSrc='External';

% gmSEQ.MWAWG = 2;
% gmSEQ.P1AWG = 1;
% disp(gmSEQ.MWAWG)
% disp(gmSEQ.P1AWG)

[gmSEQ.ScaleT, gmSEQ.ScaleStr] = GetScale(gmSEQ.To);

gSG2.bMod='IQ';
gSG2.bModSrc='External';
SignalGeneratorFunctionPool2('SetMod');

SignalGeneratorFunctionPool2('WritePow');
SignalGeneratorFunctionPool2('WriteFreq');
gSG2.bOn=1; SignalGeneratorFunctionPool2('RFOnOff');

AfterPi = 2000;
AfterLaser = 30e3; % changed by Weijie 12/03/2021
Wait_p = 0.01e6;
Detect_Window = 5000;
%%%%% Fixed sequence length %%%%%%

Sig_D_start = Wait_p+gmSEQ.readout+AfterLaser+gmSEQ.halfpi+gmSEQ.DEERt/2+gmSEQ.pi+gmSEQ.DEERt/2+gmSEQ.halfpi+AfterPi+Detect_Window+Wait_p;

gmSEQ.CHN(1).PBN=PBDictionary('ctr0');
gmSEQ.CHN(1).NRise=4;
gmSEQ.CHN(1).T=[Wait_p+gmSEQ.readout-1000-gmSEQ.CtrGateDur, ...
    Wait_p+gmSEQ.readout+AfterLaser+gmSEQ.halfpi+gmSEQ.DEERt/2+gmSEQ.pi+gmSEQ.DEERt/2+gmSEQ.halfpi+AfterPi, ...
    Sig_D_start+gmSEQ.readout-1000-gmSEQ.CtrGateDur, ...
    Sig_D_start+gmSEQ.readout+AfterLaser+gmSEQ.halfpi+gmSEQ.DEERt/2+gmSEQ.pi+gmSEQ.DEERt/2+gmSEQ.halfpi+AfterPi];
if strcmp(gmSEQ.meas,'SPCM')
    gmSEQ.CHN(1).DT=[gmSEQ.CtrGateDur gmSEQ.CtrGateDur gmSEQ.CtrGateDur gmSEQ.CtrGateDur];
elseif strcmp(gmSEQ.meas,'APD')
    gmSEQ.CHN(1).DT=[1000 1000 1000 1000];
end

gmSEQ.CHN(numel(gmSEQ.CHN)+1).PBN=PBDictionary('AOM');
gmSEQ.CHN(numel(gmSEQ.CHN)).NRise=4;
gmSEQ.CHN(numel(gmSEQ.CHN)).T = [Wait_p, Wait_p+gmSEQ.readout+AfterLaser+gmSEQ.halfpi+gmSEQ.DEERt/2+gmSEQ.pi+gmSEQ.DEERt/2+gmSEQ.halfpi+AfterPi, ...
    Sig_D_start, Sig_D_start+gmSEQ.readout+AfterLaser+gmSEQ.halfpi+gmSEQ.DEERt/2+gmSEQ.pi+gmSEQ.DEERt/2+gmSEQ.halfpi+AfterPi];
gmSEQ.CHN(numel(gmSEQ.CHN)).DT = [gmSEQ.readout Detect_Window gmSEQ.readout Detect_Window];

SwitchPi = max(gmSEQ.pi, gmSEQ.m);
gmSEQ.CHN(numel(gmSEQ.CHN)+1).PBN=PBDictionary('AWGTrig');
gmSEQ.CHN(numel(gmSEQ.CHN)).NRise=2;
gmSEQ.CHN(numel(gmSEQ.CHN)).T=[Wait_p+gmSEQ.readout+AfterLaser, ...
    Sig_D_start+gmSEQ.readout+AfterLaser];
gmSEQ.CHN(numel(gmSEQ.CHN)).DT=repelem(gmSEQ.halfpi+gmSEQ.DEERt/2+gmSEQ.pi+gmSEQ.DEERt/2+gmSEQ.halfpi+200, 2);

gmSEQ.CHN(numel(gmSEQ.CHN)+1).PBN=PBDictionary('AWGTrig2');
gmSEQ.CHN(numel(gmSEQ.CHN)).NRise=2;
gmSEQ.CHN(numel(gmSEQ.CHN)).T=[Wait_p+gmSEQ.readout+AfterLaser+gmSEQ.halfpi+gmSEQ.DEERt/2+gmSEQ.pi/2-gmSEQ.m/2, ...
    Sig_D_start+gmSEQ.readout+AfterLaser+gmSEQ.halfpi+gmSEQ.DEERt/2+gmSEQ.pi/2-gmSEQ.m/2];
gmSEQ.CHN(numel(gmSEQ.CHN)).DT=repelem(SwitchPi+200, 2);

gmSEQ.CHN(numel(gmSEQ.CHN)+1).PBN=PBDictionary('MWSwitch');
if gmSEQ.DEERt/2 < 200
    gmSEQ.CHN(numel(gmSEQ.CHN)).NRise=2;
    gmSEQ.CHN(numel(gmSEQ.CHN)).T=[Wait_p+gmSEQ.readout+AfterLaser-20, Sig_D_start+gmSEQ.readout+AfterLaser-20];
    gmSEQ.CHN(numel(gmSEQ.CHN)).DT=[gmSEQ.halfpi+gmSEQ.DEERt/2+gmSEQ.pi+gmSEQ.DEERt/2+gmSEQ.halfpi+40, ... 
    gmSEQ.halfpi+gmSEQ.DEERt/2+gmSEQ.pi+gmSEQ.DEERt/2+gmSEQ.halfpi+40];
else
    gmSEQ.CHN(numel(gmSEQ.CHN)).NRise=6;
    gmSEQ.CHN(numel(gmSEQ.CHN)).T=[Wait_p+gmSEQ.readout+AfterLaser-20, ...
        Wait_p+gmSEQ.readout+AfterLaser+gmSEQ.halfpi+gmSEQ.DEERt/2+gmSEQ.pi/2-SwitchPi/2-20, ...
        Wait_p+gmSEQ.readout+AfterLaser+gmSEQ.halfpi+gmSEQ.DEERt/2+gmSEQ.pi+gmSEQ.DEERt/2-20, ...
        Sig_D_start+gmSEQ.readout+AfterLaser-20, ...
        Sig_D_start+gmSEQ.readout+AfterLaser+gmSEQ.halfpi+gmSEQ.DEERt/2+gmSEQ.pi/2-SwitchPi/2-20, ...
        Sig_D_start+gmSEQ.readout+AfterLaser+gmSEQ.halfpi+gmSEQ.DEERt/2+gmSEQ.pi+gmSEQ.DEERt/2-20];
    gmSEQ.CHN(numel(gmSEQ.CHN)).DT=[gmSEQ.halfpi+40, SwitchPi+40, gmSEQ.halfpi+40, ... 
    gmSEQ.halfpi+40, SwitchPi+40, gmSEQ.halfpi+40];
end

gmSEQ.CHN(numel(gmSEQ.CHN)+1).PBN=PBDictionary('MWSwitch2');
gmSEQ.CHN(numel(gmSEQ.CHN)).NRise=2;
gmSEQ.CHN(numel(gmSEQ.CHN)).T=[Wait_p+gmSEQ.readout+AfterLaser+gmSEQ.halfpi+gmSEQ.DEERt/2+gmSEQ.pi/2-SwitchPi/2-20, ...
Sig_D_start+gmSEQ.readout+AfterLaser+gmSEQ.halfpi+gmSEQ.DEERt/2+gmSEQ.pi/2-SwitchPi/2-20];
gmSEQ.CHN(numel(gmSEQ.CHN)).DT=[SwitchPi+40 SwitchPi+40];


gmSEQ.CHN(numel(gmSEQ.CHN)+1).PBN=PBDictionary('dummy1');
gmSEQ.CHN(numel(gmSEQ.CHN)).NRise=2;
gmSEQ.CHN(numel(gmSEQ.CHN)).T=[0 Sig_D_start+gmSEQ.readout+AfterLaser+gmSEQ.halfpi+gmSEQ.DEERt/2+gmSEQ.pi+gmSEQ.DEERt/2+gmSEQ.halfpi+AfterPi+Detect_Window-50];
gmSEQ.CHN(numel(gmSEQ.CHN)).DT=[50 50];

%% AWG
% Initialization
chaseFunctionPool('stopChase', gmSEQ.MWAWG);
chaseFunctionPool('stopChase', gmSEQ.P1AWG);

WaveForm_1I = [0 gmSEQ.halfpi gSG.AWGFreq 0 gSG.AWGAmp;...
    gmSEQ.halfpi+gmSEQ.DEERt/2 gmSEQ.halfpi+gmSEQ.DEERt/2+gmSEQ.pi gSG.AWGFreq pi/2 gSG.AWGAmp; ...
    gmSEQ.halfpi+gmSEQ.DEERt/2+gmSEQ.pi+gmSEQ.DEERt/2 gmSEQ.halfpi+gmSEQ.DEERt/2+gmSEQ.pi+gmSEQ.DEERt/2+gmSEQ.halfpi gSG.AWGFreq pi gSG.AWGAmp];
WaveForm_1Q = WaveForm_1I - repmat([0 0 0 pi/2 0], size(WaveForm_1I, 1), 1);
WaveForm_1Length = ceil((gmSEQ.halfpi+gmSEQ.DEERt/2+gmSEQ.pi+gmSEQ.DEERt/2+gmSEQ.halfpi+1000) / (16 / gSG.AWGClockRate)) ...
    *(16 / gSG.AWGClockRate);
WaveForm_1PointNum = WaveForm_1Length * gSG.AWGClockRate;

WaveForm_2I = WaveForm_1I;
WaveForm_2I(size(WaveForm_1I, 1), 4) = 0; % Differential measurement
WaveForm_2Q = WaveForm_1Q;
WaveForm_2Q(size(WaveForm_1I, 1), 4) = -pi/2; % Differential measurement
WaveForm_2Length = WaveForm_1Length;
WaveForm_2PointNum = WaveForm_2Length * gSG.AWGClockRate;

% P1 sequence
WaveForm_3I = [0 gmSEQ.m gSG2.AWGFreq 0 gSG2.AWGAmp];
WaveForm_3Q = [0 gmSEQ.m gSG2.AWGFreq -pi/2 gSG2.AWGAmp];
WaveForm_3Length = ceil((gmSEQ.m+1000) / (16 / gSG2.P1AWGClockRate)) ...
    *(16 / gSG2.P1AWGClockRate);
WaveForm_3PointNum = WaveForm_3Length * gSG2.P1AWGClockRate;           

chaseFunctionPool('createWaveform', WaveForm_1I, gSG.AWGClockRate, WaveForm_1Length, 'DEER_Rabi_I_seg1.txt'); pause(0.5);
chaseFunctionPool('createWaveform', WaveForm_1Q, gSG.AWGClockRate, WaveForm_1Length, 'DEER_Rabi_Q_seg1.txt'); pause(0.5);
chaseFunctionPool('createWaveform', WaveForm_2I, gSG.AWGClockRate, WaveForm_2Length, 'DEER_Rabi_I_seg2.txt'); pause(0.5);
chaseFunctionPool('createWaveform', WaveForm_2Q, gSG.AWGClockRate, WaveForm_2Length, 'DEER_Rabi_Q_seg2.txt'); pause(0.5);
chaseFunctionPool('createWaveform', WaveForm_3I, gSG2.P1AWGClockRate, WaveForm_3Length, 'DEER_Rabi_I_seg3.txt'); pause(0.5);
chaseFunctionPool('createWaveform', WaveForm_3Q, gSG2.P1AWGClockRate, WaveForm_3Length, 'DEER_Rabi_Q_seg3.txt'); pause(0.5);

chaseFunctionPool('createSegStruct', 'DEER_Rabi_SegStruct_I.txt', ...
    'DEER_Rabi_I_seg1.txt', WaveForm_1PointNum, 1, 1, ...
    'DEER_Rabi_I_seg2.txt', WaveForm_2PointNum, 1, 1);
pause(0.5);
chaseFunctionPool('createSegStruct', 'DEER_Rabi_SegStruct_Q.txt', ...
    'DEER_Rabi_Q_seg1.txt', WaveForm_1PointNum, 1, 1, ...
    'DEER_Rabi_Q_seg2.txt', WaveForm_2PointNum, 1, 1);
pause(0.5);
chaseFunctionPool('createSegStruct', 'DEER_Rabi_P1_SegStruct_I.txt', ...
    'DEER_Rabi_I_seg3.txt', WaveForm_3PointNum, 1, 1, ...
    'DEER_Rabi_I_seg3.txt', WaveForm_3PointNum, 1, 1);
pause(0.5);
chaseFunctionPool('createSegStruct', 'DEER_Rabi_P1_SegStruct_Q.txt', ...
    'DEER_Rabi_Q_seg3.txt', WaveForm_3PointNum, 1, 1, ...
    'DEER_Rabi_Q_seg3.txt', WaveForm_3PointNum, 1, 1);
pause(0.5);
chaseFunctionPool('CreateSegments', gmSEQ.MWAWG, 1, ...
    2, ...
    2047, 2047, 'DEER_Rabi_SegStruct_I.txt', 'false');
pause(1); % this pause seems to be important, otherwise the loading is not right occassionally
chaseFunctionPool('CreateSegments', gmSEQ.MWAWG, 2, ...
    2, ...
    2047, 2047, 'DEER_Rabi_SegStruct_Q.txt', 'false');
pause(1); % this pause seems to be important, otherwise the loading is not right occassionally
chaseFunctionPool('CreateSegments', gmSEQ.P1AWG, 1, ...
    2, ...
    2047, 2047, 'DEER_Rabi_P1_SegStruct_I.txt', 'false');
pause(1); % this pause seems to be important, otherwise the loading is not right occassionally   
chaseFunctionPool('CreateSegments', gmSEQ.P1AWG, 2, ...
    2, ...
    2047, 2047, 'DEER_Rabi_P1_SegStruct_Q.txt', 'false');
pause(1); % this pause seems to be important, otherwise the loading is not right occassionally   
chaseFunctionPool('runChase', gmSEQ.MWAWG, 'false'); pause(1);
chaseFunctionPool('runChase', gmSEQ.P1AWG, 'false'); pause(1);

ApplyDelays();

function DEER_T2
global gmSEQ gSG gSG2
gSG.bfixedPow=1;
gSG.bfixedFreq=1;
gSG.bMod='IQ';
gSG.bModSrc='External';

[gmSEQ.ScaleT, gmSEQ.ScaleStr] = GetScale(gmSEQ.To);

gSG2.bMod='IQ';
gSG2.bModSrc='External';
SignalGeneratorFunctionPool2('SetMod');

SignalGeneratorFunctionPool2('WritePow');
SignalGeneratorFunctionPool2('WriteFreq');
gSG2.bOn=1; SignalGeneratorFunctionPool2('RFOnOff');

AfterPi = 2000;
% AfterLaser = 2000;
AfterLaser = 0.1e6; % changed by Weijie 12/03/2021
Wait_p = 0.01e6;
Detect_Window = 5000;
%%%%% Fixed sequence length %%%%%%

Sig_D_start = Wait_p+gmSEQ.readout+AfterLaser+gmSEQ.halfpi+gmSEQ.m/2+gmSEQ.pi+gmSEQ.m/2+gmSEQ.halfpi+AfterPi+Detect_Window+Wait_p;

gmSEQ.CHN(1).PBN=PBDictionary('ctr0');
gmSEQ.CHN(1).NRise=4;
gmSEQ.CHN(1).T=[Wait_p+gmSEQ.readout-1000-gmSEQ.CtrGateDur, ...
    Wait_p+gmSEQ.readout+AfterLaser+gmSEQ.halfpi+gmSEQ.m/2+gmSEQ.pi+gmSEQ.m/2+gmSEQ.halfpi+AfterPi, ...
    Sig_D_start+gmSEQ.readout-1000-gmSEQ.CtrGateDur, ...
    Sig_D_start+gmSEQ.readout+AfterLaser+gmSEQ.halfpi+gmSEQ.m/2+gmSEQ.pi+gmSEQ.m/2+gmSEQ.halfpi+AfterPi];
if strcmp(gmSEQ.meas,'SPCM')
    gmSEQ.CHN(1).DT=[gmSEQ.CtrGateDur gmSEQ.CtrGateDur gmSEQ.CtrGateDur gmSEQ.CtrGateDur];
elseif strcmp(gmSEQ.meas,'APD')
    gmSEQ.CHN(1).DT=[1000 1000 1000 1000];
end

gmSEQ.CHN(numel(gmSEQ.CHN)+1).PBN=PBDictionary('AOM');
gmSEQ.CHN(numel(gmSEQ.CHN)).NRise=4;
gmSEQ.CHN(numel(gmSEQ.CHN)).T = [Wait_p, Wait_p+gmSEQ.readout+AfterLaser+gmSEQ.halfpi+gmSEQ.m/2+gmSEQ.pi+gmSEQ.m/2+gmSEQ.halfpi+AfterPi, ...
    Sig_D_start, Sig_D_start+gmSEQ.readout+AfterLaser+gmSEQ.halfpi+gmSEQ.m/2+gmSEQ.pi+gmSEQ.m/2+gmSEQ.halfpi+AfterPi];
gmSEQ.CHN(numel(gmSEQ.CHN)).DT = [gmSEQ.readout Detect_Window gmSEQ.readout Detect_Window];

SwitchPi = max(gmSEQ.DEERpi, gmSEQ.pi);
gmSEQ.CHN(numel(gmSEQ.CHN)+1).PBN=PBDictionary('AWGTrig');
gmSEQ.CHN(numel(gmSEQ.CHN)).NRise=2;
gmSEQ.CHN(numel(gmSEQ.CHN)).T=[Wait_p+gmSEQ.readout+AfterLaser, ...
    Sig_D_start+gmSEQ.readout+AfterLaser];
gmSEQ.CHN(numel(gmSEQ.CHN)).DT=repelem(gmSEQ.halfpi+gmSEQ.m/2+gmSEQ.pi+gmSEQ.m/2+gmSEQ.halfpi+100, 2);

% Do P1 pi pulse only when the interval is large enough. If gmSEQ.m is too
% small, then it makes no sense to do P1 pi pulse.
if gmSEQ.m/2 + gmSEQ.pi/2 - gmSEQ.DEERpi/2 >= 0
    gmSEQ.CHN(numel(gmSEQ.CHN)+1).PBN=PBDictionary('AWGTrig2');
    gmSEQ.CHN(numel(gmSEQ.CHN)).NRise=2;
    gmSEQ.CHN(numel(gmSEQ.CHN)).T=[Wait_p+gmSEQ.readout+AfterLaser+gmSEQ.halfpi+gmSEQ.m/2+gmSEQ.pi/2-gmSEQ.DEERpi/2, ...
    Sig_D_start+gmSEQ.readout+AfterLaser+gmSEQ.halfpi+gmSEQ.m/2+gmSEQ.pi/2-gmSEQ.DEERpi/2];
    gmSEQ.CHN(numel(gmSEQ.CHN)).DT=repelem(SwitchPi+20, 2);
end


gmSEQ.CHN(numel(gmSEQ.CHN)+1).PBN=PBDictionary('MWSwitch');
if gmSEQ.m/2 < 200
    gmSEQ.CHN(numel(gmSEQ.CHN)).NRise=2;
    gmSEQ.CHN(numel(gmSEQ.CHN)).T=[Wait_p+gmSEQ.readout+AfterLaser-20, Sig_D_start+gmSEQ.readout+AfterLaser-20];
    gmSEQ.CHN(numel(gmSEQ.CHN)).DT=[gmSEQ.halfpi+gmSEQ.m/2+gmSEQ.pi+gmSEQ.m/2+gmSEQ.halfpi+40, ... 
    gmSEQ.halfpi+gmSEQ.m/2+gmSEQ.pi+gmSEQ.m/2+gmSEQ.halfpi+40];
else
    gmSEQ.CHN(numel(gmSEQ.CHN)).NRise=6;
    gmSEQ.CHN(numel(gmSEQ.CHN)).T=[Wait_p+gmSEQ.readout+AfterLaser-20, ...
        Wait_p+gmSEQ.readout+AfterLaser+gmSEQ.halfpi+gmSEQ.m/2+gmSEQ.pi/2-SwitchPi/2-20, ...
        Wait_p+gmSEQ.readout+AfterLaser+gmSEQ.halfpi+gmSEQ.m/2+gmSEQ.pi+gmSEQ.m/2-20, ...
        Sig_D_start+gmSEQ.readout+AfterLaser-20, ...
        Sig_D_start+gmSEQ.readout+AfterLaser+gmSEQ.halfpi+gmSEQ.m/2+gmSEQ.pi/2-SwitchPi/2-20, ...
        Sig_D_start+gmSEQ.readout+AfterLaser+gmSEQ.halfpi+gmSEQ.m/2+gmSEQ.pi+gmSEQ.m/2-20];
    gmSEQ.CHN(numel(gmSEQ.CHN)).DT=[gmSEQ.halfpi+40, SwitchPi+40, gmSEQ.halfpi+40, ... 
    gmSEQ.halfpi+40, SwitchPi+40, gmSEQ.halfpi+40];
end

gmSEQ.CHN(numel(gmSEQ.CHN)+1).PBN=PBDictionary('MWSwitch2');
gmSEQ.CHN(numel(gmSEQ.CHN)).NRise=2;
if gmSEQ.m/2 < 200
    gmSEQ.CHN(numel(gmSEQ.CHN)).T=[Wait_p+gmSEQ.readout+AfterLaser-20, Sig_D_start+gmSEQ.readout+AfterLaser-20];
    gmSEQ.CHN(numel(gmSEQ.CHN)).DT=[gmSEQ.halfpi+gmSEQ.m/2+gmSEQ.pi+gmSEQ.m/2+gmSEQ.halfpi+40, ... 
        gmSEQ.halfpi+gmSEQ.m/2+gmSEQ.pi+gmSEQ.m/2+gmSEQ.halfpi+40];
else
    gmSEQ.CHN(numel(gmSEQ.CHN)).T=[Wait_p+gmSEQ.readout+AfterLaser+gmSEQ.halfpi+gmSEQ.m/2+gmSEQ.pi/2-SwitchPi/2-20, ...
        Sig_D_start+gmSEQ.readout+AfterLaser+gmSEQ.halfpi+gmSEQ.m/2+gmSEQ.pi/2-SwitchPi/2-20];
    gmSEQ.CHN(numel(gmSEQ.CHN)).DT=[SwitchPi+40 SwitchPi+40];
end


gmSEQ.CHN(numel(gmSEQ.CHN)+1).PBN=PBDictionary('dummy1');
gmSEQ.CHN(numel(gmSEQ.CHN)).NRise=2;
gmSEQ.CHN(numel(gmSEQ.CHN)).T=[0 Sig_D_start+gmSEQ.readout+AfterLaser+gmSEQ.halfpi+gmSEQ.m/2+gmSEQ.pi+gmSEQ.m/2+gmSEQ.halfpi+AfterPi+Detect_Window-50];
gmSEQ.CHN(numel(gmSEQ.CHN)).DT=[50 50];

%% AWG
% Initialization
chaseFunctionPool('stopChase', gmSEQ.MWAWG);
chaseFunctionPool('stopChase', gmSEQ.P1AWG);

if gSG.ACmodAWG % in AC modulation mode
    
    WaveForm_1I = [0 gmSEQ.halfpi gSG.AWGFreq 0 gSG.AWGAmp;...
        gmSEQ.halfpi+gmSEQ.m/2 gmSEQ.halfpi+gmSEQ.m/2+gmSEQ.pi gSG.AWGFreq pi/2 gSG.AWGAmp; ...
        gmSEQ.halfpi+gmSEQ.m/2+gmSEQ.pi+gmSEQ.m/2 gmSEQ.halfpi+gmSEQ.m/2+gmSEQ.pi+gmSEQ.m/2+gmSEQ.halfpi gSG.AWGFreq pi gSG.AWGAmp];
    WaveForm_1Q = [0 gmSEQ.halfpi gSG.AWGFreq -pi/2 gSG.AWGAmp;...
        gmSEQ.halfpi+gmSEQ.m/2 gmSEQ.halfpi+gmSEQ.m/2+gmSEQ.pi gSG.AWGFreq pi/2-pi/2 gSG.AWGAmp; ...
        gmSEQ.halfpi+gmSEQ.m/2+gmSEQ.pi+gmSEQ.m/2 gmSEQ.halfpi+gmSEQ.m/2+gmSEQ.pi+gmSEQ.m/2+gmSEQ.halfpi gSG.AWGFreq pi-pi/2 gSG.AWGAmp];
    
    WaveForm_1Length = ceil((gmSEQ.halfpi+gmSEQ.m/2+gmSEQ.pi+gmSEQ.m/2+gmSEQ.halfpi+1000) / (16 / gSG.AWGClockRate)) ...
        *(16 / gSG.AWGClockRate);
    WaveForm_1PointNum = WaveForm_1Length * gSG.AWGClockRate;

    % dark sequence
    WaveForm_2I = [0 gmSEQ.halfpi gSG.AWGFreq 0 gSG.AWGAmp;...
        gmSEQ.halfpi+gmSEQ.m/2 gmSEQ.halfpi+gmSEQ.m/2+gmSEQ.pi gSG.AWGFreq pi/2 gSG.AWGAmp; ...
        gmSEQ.halfpi+gmSEQ.m/2+gmSEQ.pi+gmSEQ.m/2 gmSEQ.halfpi+gmSEQ.m/2+gmSEQ.pi+gmSEQ.m/2+gmSEQ.halfpi gSG.AWGFreq 0 gSG.AWGAmp];
    WaveForm_2Q = [0 gmSEQ.halfpi gSG.AWGFreq -pi/2 gSG.AWGAmp;...
        gmSEQ.halfpi+gmSEQ.m/2 gmSEQ.halfpi+gmSEQ.m/2+gmSEQ.pi gSG.AWGFreq pi/2-pi/2 gSG.AWGAmp; ...
        gmSEQ.halfpi+gmSEQ.m/2+gmSEQ.pi+gmSEQ.m/2 gmSEQ.halfpi+gmSEQ.m/2+gmSEQ.pi+gmSEQ.m/2+gmSEQ.halfpi gSG.AWGFreq -pi/2 gSG.AWGAmp];
    
    WaveForm_2Length = ceil((gmSEQ.halfpi+gmSEQ.m/2+gmSEQ.pi+gmSEQ.m/2+gmSEQ.halfpi+1000) / (16 / gSG.AWGClockRate)) ...
        *(16 / gSG.AWGClockRate);
    WaveForm_2PointNum = WaveForm_2Length * gSG.AWGClockRate;
    
    % P1 sequence
    WaveForm_3I = [0 gmSEQ.DEERpi gSG2.AWGFreq 0 gSG2.AWGAmp];
    WaveForm_3Q = [0 gmSEQ.DEERpi gSG2.AWGFreq -pi/2 gSG2.AWGAmp];
    
    WaveForm_3Length = ceil((gmSEQ.DEERpi+1000) / (16 / gSG2.P1AWGClockRate)) ...
        *(16 / gSG2.P1AWGClockRate);
    WaveForm_3PointNum = WaveForm_3Length * gSG2.P1AWGClockRate;
            
else

    WaveForm_1I = [0 gmSEQ.halfpi 0 0 gSG.AWGAmp;...
        gmSEQ.halfpi+gmSEQ.m/2 gmSEQ.halfpi+gmSEQ.m/2+gmSEQ.pi 0 pi/2 gSG.AWGAmp; ...
        gmSEQ.halfpi+gmSEQ.m/2+gmSEQ.pi+gmSEQ.m/2 gmSEQ.halfpi+gmSEQ.m/2+gmSEQ.pi+gmSEQ.m/2+gmSEQ.halfpi 0 pi gSG.AWGAmp];
    WaveForm_1Q = [0 gmSEQ.halfpi 0 -pi/2 gSG.AWGAmp;...
        gmSEQ.halfpi+gmSEQ.m/2 gmSEQ.halfpi+gmSEQ.m/2+gmSEQ.pi 0 pi/2-pi/2 gSG.AWGAmp; ...
        gmSEQ.halfpi+gmSEQ.m/2+gmSEQ.pi+gmSEQ.m/2 gmSEQ.halfpi+gmSEQ.m/2+gmSEQ.pi+gmSEQ.m/2+gmSEQ.halfpi 0 pi-pi/2 gSG.AWGAmp];
    
    WaveForm_1Length = ceil((gmSEQ.halfpi+gmSEQ.m/2+gmSEQ.pi+gmSEQ.m/2+gmSEQ.halfpi+1000) / (16 / gSG.AWGClockRate)) ...
        *(16 / gSG.AWGClockRate);
    WaveForm_1PointNum = WaveForm_1Length * gSG.AWGClockRate;

    % dark sequence
    WaveForm_2I = [0 gmSEQ.halfpi 0 0 gSG.AWGAmp;...
        gmSEQ.halfpi+gmSEQ.m/2 gmSEQ.halfpi+gmSEQ.m/2+gmSEQ.pi 0 pi/2 gSG.AWGAmp; ...
        gmSEQ.halfpi+gmSEQ.m/2+gmSEQ.pi+gmSEQ.m/2 gmSEQ.halfpi+gmSEQ.m/2+gmSEQ.pi+gmSEQ.m/2+gmSEQ.halfpi 0 0 gSG.AWGAmp];
    WaveForm_2Q = [0 gmSEQ.halfpi 0 -pi/2 gSG.AWGAmp;...
        gmSEQ.halfpi+gmSEQ.m/2 gmSEQ.halfpi+gmSEQ.m/2+gmSEQ.pi 0 pi/2-pi/2 gSG.AWGAmp; ...
        gmSEQ.halfpi+gmSEQ.m/2+gmSEQ.pi+gmSEQ.m/2 gmSEQ.halfpi+gmSEQ.m/2+gmSEQ.pi+gmSEQ.m/2+gmSEQ.halfpi 0 -pi/2 gSG.AWGAmp];
    
    WaveForm_2Length = ceil((gmSEQ.halfpi+gmSEQ.m/2+gmSEQ.pi+gmSEQ.m/2+gmSEQ.halfpi+1000) / (16 / gSG.AWGClockRate)) ...
        *(16 / gSG.AWGClockRate);
    WaveForm_2PointNum = WaveForm_2Length * gSG.AWGClockRate;
    
    % P1 sequence
    WaveForm_3I = [0 gmSEQ.DEERpi 0 0 gSG2.AWGAmp];
    WaveForm_3Q = [0 gmSEQ.DEERpi 0 -pi/2 gSG2.AWGAmp];
    
    WaveForm_3Length = ceil((gmSEQ.DEERpi+1000) / (16 / gSG2.P1AWGClockRate)) ...
        *(16 / gSG2.P1AWGClockRate);
    WaveForm_3PointNum = WaveForm_3Length * gSG2.P1AWGClockRate;

end
chaseFunctionPool('createWaveform', WaveForm_1I, gSG.AWGClockRate, WaveForm_1Length, 'DEER_T2_I_seg1.txt'); pause(0.5);
chaseFunctionPool('createWaveform', WaveForm_1Q, gSG.AWGClockRate, WaveForm_1Length, 'DEER_T2_Q_seg1.txt'); pause(0.5);
chaseFunctionPool('createWaveform', WaveForm_2I, gSG.AWGClockRate, WaveForm_2Length, 'DEER_T2_I_seg2.txt'); pause(0.5);
chaseFunctionPool('createWaveform', WaveForm_2Q, gSG.AWGClockRate, WaveForm_2Length, 'DEER_T2_Q_seg2.txt'); pause(0.5);
chaseFunctionPool('createWaveform', WaveForm_3I, gSG2.P1AWGClockRate, WaveForm_3Length, 'DEER_T2_I_seg3.txt'); pause(0.5);
chaseFunctionPool('createWaveform', WaveForm_3Q, gSG2.P1AWGClockRate, WaveForm_3Length, 'DEER_T2_Q_seg3.txt'); pause(0.5);

chaseFunctionPool('createSegStruct', 'DEER_T2_SegStruct_I.txt', ...
    'DEER_T2_I_seg1.txt', WaveForm_1PointNum, 1, 1, ...
    'DEER_T2_I_seg2.txt', WaveForm_2PointNum, 1, 1);
pause(0.5);
chaseFunctionPool('createSegStruct', 'DEER_T2_SegStruct_Q.txt', ...
    'DEER_T2_Q_seg1.txt', WaveForm_1PointNum, 1, 1, ...
    'DEER_T2_Q_seg2.txt', WaveForm_2PointNum, 1, 1);
pause(0.5);
chaseFunctionPool('createSegStruct', 'DEER_T2_P1_SegStruct_I.txt', ...
    'DEER_T2_I_seg3.txt', WaveForm_3PointNum, 1, 1, ...
    'DEER_T2_I_seg3.txt', WaveForm_3PointNum, 1, 1);
pause(0.5);
chaseFunctionPool('createSegStruct', 'DEER_T2_P1_SegStruct_Q.txt', ...
    'DEER_T2_Q_seg3.txt', WaveForm_3PointNum, 1, 1, ...
    'DEER_T2_Q_seg3.txt', WaveForm_3PointNum, 1, 1);
pause(0.5);
chaseFunctionPool('CreateSegments', gmSEQ.MWAWG, 1, ...
    2, ...
    2047, 2047, 'DEER_T2_SegStruct_I.txt', 'false');
pause(1); % this pause seems to be important, otherwise the loading is not right occassionally
chaseFunctionPool('CreateSegments', gmSEQ.MWAWG, 2, ...
    2, ...
    2047, 2047, 'DEER_T2_SegStruct_Q.txt', 'false');
pause(1); % this pause seems to be important, otherwise the loading is not right occassionally
chaseFunctionPool('CreateSegments', gmSEQ.P1AWG, 1, ...
    2, ...
    2047, 2047, 'DEER_T2_P1_SegStruct_I.txt', 'false');
pause(1); % this pause seems to be important, otherwise the loading is not right occassionally   
chaseFunctionPool('CreateSegments', gmSEQ.P1AWG, 2, ...
    2, ...
    2047, 2047, 'DEER_T2_P1_SegStruct_Q.txt', 'false');
pause(1); % this pause seems to be important, otherwise the loading is not right occassionally   
chaseFunctionPool('runChase', gmSEQ.MWAWG, 'false'); pause(1);
chaseFunctionPool('runChase', gmSEQ.P1AWG, 'false'); pause(1);

ApplyDelays();

function DEERNV_T2
global gmSEQ gSG gSG2
gSG.bfixedPow=1;
gSG.bfixedFreq=1;
gSG.bMod='IQ';
gSG.bModSrc='External';

gSG2.bMod='IQ';
gSG2.bModSrc='External';
SignalGeneratorFunctionPool2('SetMod');
SignalGeneratorFunctionPool2('WritePow');
SignalGeneratorFunctionPool2('WriteFreq');
gSG2.bOn=1; SignalGeneratorFunctionPool2('RFOnOff');

gmSEQ.DEERhalfpi = gmSEQ.DEERpi/2;

AfterPi = 2000;
Depol = 50e3;
AfterLaser = 50e3+gmSEQ.DEERpi/2+Depol; % changed by Weijie 12/03/2021
Wait_p = 10e3;
Detect_Window = 5000;
%%%%% Fixed sequence length %%%%%%

Sig_D_start = Wait_p+gmSEQ.readout+AfterLaser+gmSEQ.halfpi+gmSEQ.m/2+gmSEQ.pi+gmSEQ.m/2+gmSEQ.halfpi+AfterPi+Detect_Window+Wait_p;

gmSEQ.CHN(1).PBN=PBDictionary('ctr0');
gmSEQ.CHN(1).NRise=4;
gmSEQ.CHN(1).T=[Wait_p+gmSEQ.readout-1000-gmSEQ.CtrGateDur, ...
    Wait_p+gmSEQ.readout+AfterLaser+gmSEQ.halfpi+gmSEQ.m/2+gmSEQ.pi+gmSEQ.m/2+gmSEQ.halfpi+AfterPi, ...
    Sig_D_start+gmSEQ.readout-1000-gmSEQ.CtrGateDur, ...
    Sig_D_start+gmSEQ.readout+AfterLaser+gmSEQ.halfpi+gmSEQ.m/2+gmSEQ.pi+gmSEQ.m/2+gmSEQ.halfpi+AfterPi];
if strcmp(gmSEQ.meas,'SPCM')
    gmSEQ.CHN(1).DT=[gmSEQ.CtrGateDur gmSEQ.CtrGateDur gmSEQ.CtrGateDur gmSEQ.CtrGateDur];
elseif strcmp(gmSEQ.meas,'APD')
    gmSEQ.CHN(1).DT=[1000 1000 1000 1000];
end

gmSEQ.CHN(numel(gmSEQ.CHN)+1).PBN=PBDictionary('AOM');
gmSEQ.CHN(numel(gmSEQ.CHN)).NRise=4;
gmSEQ.CHN(numel(gmSEQ.CHN)).T = [Wait_p, Wait_p+gmSEQ.readout+AfterLaser+gmSEQ.halfpi+gmSEQ.m/2+gmSEQ.pi+gmSEQ.m/2+gmSEQ.halfpi+AfterPi, ...
    Sig_D_start, Sig_D_start+gmSEQ.readout+AfterLaser+gmSEQ.halfpi+gmSEQ.m/2+gmSEQ.pi+gmSEQ.m/2+gmSEQ.halfpi+AfterPi];
gmSEQ.CHN(numel(gmSEQ.CHN)).DT = [gmSEQ.readout Detect_Window gmSEQ.readout Detect_Window];


gmSEQ.CHN(numel(gmSEQ.CHN)+1).PBN=PBDictionary('AWGTrig');
gmSEQ.CHN(numel(gmSEQ.CHN)).NRise=2;
gmSEQ.CHN(numel(gmSEQ.CHN)).T=[Wait_p+gmSEQ.readout+AfterLaser, ...
    Sig_D_start+gmSEQ.readout+AfterLaser];
gmSEQ.CHN(numel(gmSEQ.CHN)).DT=[2000 2000];


gmSEQ.CHN(numel(gmSEQ.CHN)+1).PBN=PBDictionary('AWGTrig2');
gmSEQ.CHN(numel(gmSEQ.CHN)).NRise=4;
gmSEQ.CHN(numel(gmSEQ.CHN)).T=[Wait_p+gmSEQ.readout+Depol, ...
    Wait_p+gmSEQ.readout+AfterLaser+gmSEQ.halfpi+gmSEQ.m/2+gmSEQ.pi/2-gmSEQ.DEERpi/2, ...
    Sig_D_start+gmSEQ.readout+Depol, ...
    Sig_D_start+gmSEQ.readout+AfterLaser+gmSEQ.halfpi+gmSEQ.m/2+gmSEQ.pi/2-gmSEQ.DEERpi/2];
gmSEQ.CHN(numel(gmSEQ.CHN)).DT=repelem(2000, 4);

SwitchPi = max(gmSEQ.DEERpi, gmSEQ.pi);
gmSEQ.CHN(numel(gmSEQ.CHN)+1).PBN=PBDictionary('MWSwitch');
if gmSEQ.m/2 < 200
    gmSEQ.CHN(numel(gmSEQ.CHN)).NRise=2;
    gmSEQ.CHN(numel(gmSEQ.CHN)).T=[Wait_p+gmSEQ.readout+AfterLaser-20, Sig_D_start+gmSEQ.readout+AfterLaser-20];
    gmSEQ.CHN(numel(gmSEQ.CHN)).DT=[gmSEQ.halfpi+gmSEQ.m/2+gmSEQ.pi+gmSEQ.m/2+gmSEQ.halfpi+40, ... 
    gmSEQ.halfpi+gmSEQ.m/2+gmSEQ.pi+gmSEQ.m/2+gmSEQ.halfpi+40];
else
    gmSEQ.CHN(numel(gmSEQ.CHN)).NRise=6;
    gmSEQ.CHN(numel(gmSEQ.CHN)).T=[Wait_p+gmSEQ.readout+AfterLaser-20, ...
        Wait_p+gmSEQ.readout+AfterLaser+gmSEQ.halfpi+gmSEQ.m/2+gmSEQ.pi/2-SwitchPi/2-20, ...
        Wait_p+gmSEQ.readout+AfterLaser+gmSEQ.halfpi+gmSEQ.m/2+gmSEQ.pi+gmSEQ.m/2-20, ...
        Sig_D_start+gmSEQ.readout+AfterLaser-20, ...
        Sig_D_start+gmSEQ.readout+AfterLaser+gmSEQ.halfpi+gmSEQ.m/2+gmSEQ.pi/2-SwitchPi/2-20, ...
        Sig_D_start+gmSEQ.readout+AfterLaser+gmSEQ.halfpi+gmSEQ.m/2+gmSEQ.pi+gmSEQ.m/2-20];
    gmSEQ.CHN(numel(gmSEQ.CHN)).DT=[gmSEQ.halfpi+40, SwitchPi+40, gmSEQ.halfpi+40, ... 
    gmSEQ.halfpi+40, SwitchPi+40, gmSEQ.halfpi+40];
end

gmSEQ.CHN(numel(gmSEQ.CHN)+1).PBN=PBDictionary('MWSwitch2');
gmSEQ.CHN(numel(gmSEQ.CHN)).NRise=4;
if gmSEQ.m/2 < 200
    gmSEQ.CHN(numel(gmSEQ.CHN)).T=[Wait_p+gmSEQ.readout+Depol-20, ...
        Wait_p+gmSEQ.readout+AfterLaser-20, ...
        Sig_D_start+gmSEQ.readout+Depol-20, ...
        Sig_D_start+gmSEQ.readout+AfterLaser-20];
    gmSEQ.CHN(numel(gmSEQ.CHN)).DT=[gmSEQ.DEERpi/2+40 gmSEQ.halfpi+gmSEQ.m/2+gmSEQ.pi+gmSEQ.m/2+gmSEQ.halfpi+40 ...
        gmSEQ.DEERpi/2+40 gmSEQ.halfpi+gmSEQ.m/2+gmSEQ.pi+gmSEQ.m/2+gmSEQ.halfpi+40];
else
    gmSEQ.CHN(numel(gmSEQ.CHN)).T=[Wait_p+gmSEQ.readout+Depol-20, ...
        Wait_p+gmSEQ.readout+AfterLaser+gmSEQ.halfpi+gmSEQ.m/2+gmSEQ.pi/2-SwitchPi/2-20, ...
        Sig_D_start+gmSEQ.readout+Depol-20, ...
        Sig_D_start+gmSEQ.readout+AfterLaser+gmSEQ.halfpi+gmSEQ.m/2+gmSEQ.pi/2-SwitchPi/2-20];
    gmSEQ.CHN(numel(gmSEQ.CHN)).DT=[gmSEQ.DEERpi/2+40 SwitchPi+40 gmSEQ.DEERpi/2+40 SwitchPi+40];
end


gmSEQ.CHN(numel(gmSEQ.CHN)+1).PBN=PBDictionary('dummy1');
gmSEQ.CHN(numel(gmSEQ.CHN)).NRise=2;
gmSEQ.CHN(numel(gmSEQ.CHN)).T=[0 Sig_D_start+gmSEQ.readout+AfterLaser+gmSEQ.halfpi+gmSEQ.m/2+gmSEQ.pi+gmSEQ.m/2+gmSEQ.halfpi+AfterPi+Detect_Window-50];
gmSEQ.CHN(numel(gmSEQ.CHN)).DT=[50 50];

%% AWG
% Initialization
chaseFunctionPool('stopChase', gmSEQ.MWAWG);
chaseFunctionPool('stopChase', gmSEQ.P1AWG);

% This part need to be modified to accomodate the DC modulation
if ~gSG.ACmodAWG % in AC modulation mode
    gSG.AWGFreq = 0;
    gSG2.AWGFreq = 0;
end
    
WaveForm_1I = [0 gmSEQ.halfpi gSG.AWGFreq 0 gSG.AWGAmp;...
    gmSEQ.halfpi+gmSEQ.m/2 gmSEQ.halfpi+gmSEQ.m/2+gmSEQ.pi gSG.AWGFreq pi/2 gSG.AWGAmp; ...
    gmSEQ.halfpi+gmSEQ.m/2+gmSEQ.pi+gmSEQ.m/2 gmSEQ.halfpi+gmSEQ.m/2+gmSEQ.pi+gmSEQ.m/2+gmSEQ.halfpi gSG.AWGFreq pi gSG.AWGAmp];
WaveForm_1Q = [0 gmSEQ.halfpi gSG.AWGFreq -pi/2 gSG.AWGAmp;...
    gmSEQ.halfpi+gmSEQ.m/2 gmSEQ.halfpi+gmSEQ.m/2+gmSEQ.pi gSG.AWGFreq pi/2-pi/2 gSG.AWGAmp; ...
    gmSEQ.halfpi+gmSEQ.m/2+gmSEQ.pi+gmSEQ.m/2 gmSEQ.halfpi+gmSEQ.m/2+gmSEQ.pi+gmSEQ.m/2+gmSEQ.halfpi gSG.AWGFreq pi-pi/2 gSG.AWGAmp];

WaveForm_1Length = ceil((gmSEQ.halfpi+gmSEQ.m/2+gmSEQ.pi+gmSEQ.m/2+gmSEQ.halfpi+1000) / (16 / gSG.AWGClockRate)) ...
    *(16 / gSG.AWGClockRate);
WaveForm_1PointNum = WaveForm_1Length * gSG.AWGClockRate;

% dark sequence
WaveForm_2I = [0 gmSEQ.halfpi gSG.AWGFreq 0 gSG.AWGAmp;...
    gmSEQ.halfpi+gmSEQ.m/2 gmSEQ.halfpi+gmSEQ.m/2+gmSEQ.pi gSG.AWGFreq pi/2 gSG.AWGAmp; ...
    gmSEQ.halfpi+gmSEQ.m/2+gmSEQ.pi+gmSEQ.m/2 gmSEQ.halfpi+gmSEQ.m/2+gmSEQ.pi+gmSEQ.m/2+gmSEQ.halfpi gSG.AWGFreq 0 gSG.AWGAmp];
WaveForm_2Q = [0 gmSEQ.halfpi gSG.AWGFreq -pi/2 gSG.AWGAmp;...
    gmSEQ.halfpi+gmSEQ.m/2 gmSEQ.halfpi+gmSEQ.m/2+gmSEQ.pi gSG.AWGFreq pi/2-pi/2 gSG.AWGAmp; ...
    gmSEQ.halfpi+gmSEQ.m/2+gmSEQ.pi+gmSEQ.m/2 gmSEQ.halfpi+gmSEQ.m/2+gmSEQ.pi+gmSEQ.m/2+gmSEQ.halfpi gSG.AWGFreq -pi/2 gSG.AWGAmp];
WaveForm_2Length = ceil((gmSEQ.halfpi+gmSEQ.m/2+gmSEQ.pi+gmSEQ.m/2+gmSEQ.halfpi+1000) / (16 / gSG.AWGClockRate)) ...
    *(16 / gSG.AWGClockRate);
WaveForm_2PointNum = WaveForm_2Length * gSG.AWGClockRate;

% P1 sequence
WaveForm_3I = [0 gmSEQ.DEERpi gSG2.AWGFreq 0 gSG2.AWGAmp];
WaveForm_3Q = [0 gmSEQ.DEERpi gSG2.AWGFreq -pi/2 gSG2.AWGAmp];
WaveForm_3Length = ceil((gmSEQ.DEERpi+1000) / (16 / gSG2.P1AWGClockRate)) ...
    *(16 / gSG2.P1AWGClockRate);
WaveForm_3PointNum = WaveForm_3Length * gSG2.P1AWGClockRate;
            
WaveForm_4I = [0 gmSEQ.DEERhalfpi gSG2.AWGFreq 0 gSG2.AWGAmp];
WaveForm_4Q = [0 gmSEQ.DEERhalfpi gSG2.AWGFreq -pi/2 gSG2.AWGAmp];
WaveForm_4Length = ceil((gmSEQ.DEERhalfpi+1000) / (16 / gSG2.P1AWGClockRate)) ...
    *(16 / gSG2.P1AWGClockRate);
WaveForm_4PointNum = WaveForm_4Length * gSG2.P1AWGClockRate;

chaseFunctionPool('createWaveform', WaveForm_1I, gSG.AWGClockRate, WaveForm_1Length, 'DEERNV_T2_I_seg1.txt'); pause(0.5);
chaseFunctionPool('createWaveform', WaveForm_1Q, gSG.AWGClockRate, WaveForm_1Length, 'DEERNV_T2_Q_seg1.txt'); pause(0.5);
chaseFunctionPool('createWaveform', WaveForm_2I, gSG.AWGClockRate, WaveForm_2Length, 'DEERNV_T2_I_seg2.txt'); pause(0.5);
chaseFunctionPool('createWaveform', WaveForm_2Q, gSG.AWGClockRate, WaveForm_2Length, 'DEERNV_T2_Q_seg2.txt'); pause(0.5);
chaseFunctionPool('createWaveform', WaveForm_3I, gSG2.P1AWGClockRate, WaveForm_3Length, 'DEERNV_T2_I_seg3.txt'); pause(0.5);
chaseFunctionPool('createWaveform', WaveForm_3Q, gSG2.P1AWGClockRate, WaveForm_3Length, 'DEERNV_T2_Q_seg3.txt'); pause(0.5);
chaseFunctionPool('createWaveform', WaveForm_4I, gSG2.P1AWGClockRate, WaveForm_4Length, 'DEERNV_T2_I_seg4.txt'); pause(0.5);
chaseFunctionPool('createWaveform', WaveForm_4Q, gSG2.P1AWGClockRate, WaveForm_4Length, 'DEERNV_T2_Q_seg4.txt'); pause(0.5);

chaseFunctionPool('createSegStruct', 'DEERNV_T2_SegStruct_I.txt', ...
    'DEERNV_T2_I_seg1.txt', WaveForm_1PointNum, 1, 1, ...
    'DEERNV_T2_I_seg2.txt', WaveForm_2PointNum, 1, 1);
pause(0.5);
chaseFunctionPool('createSegStruct', 'DEERNV_T2_SegStruct_Q.txt', ...
    'DEERNV_T2_Q_seg1.txt', WaveForm_1PointNum, 1, 1, ...
    'DEERNV_T2_Q_seg2.txt', WaveForm_2PointNum, 1, 1);
pause(0.5);
chaseFunctionPool('createSegStruct', 'DEERNV_T2_P1_SegStruct_I.txt', ...
    'DEERNV_T2_I_seg4.txt', WaveForm_4PointNum, 1, 1, ...
    'DEERNV_T2_I_seg3.txt', WaveForm_3PointNum, 1, 1);
pause(0.5);
chaseFunctionPool('createSegStruct', 'DEERNV_T2_P1_SegStruct_Q.txt', ...
    'DEERNV_T2_Q_seg4.txt', WaveForm_4PointNum, 1, 1, ...
    'DEERNV_T2_Q_seg3.txt', WaveForm_3PointNum, 1, 1);
pause(0.5);
chaseFunctionPool('CreateSegments', gmSEQ.MWAWG, 1, ...
    2, ...
    2047, 2047, 'DEERNV_T2_SegStruct_I.txt', 'false');
pause(1); % this pause seems to be important, otherwise the loading is not right occassionally
chaseFunctionPool('CreateSegments', gmSEQ.MWAWG, 2, ...
    2, ...
    2047, 2047, 'DEERNV_T2_SegStruct_Q.txt', 'false');
pause(1); % this pause seems to be important, otherwise the loading is not right occassionally
chaseFunctionPool('CreateSegments', gmSEQ.P1AWG, 1, ...
    2, ...
    2047, 2047, 'DEERNV_T2_P1_SegStruct_I.txt', 'false');
pause(1); % this pause seems to be important, otherwise the loading is not right occassionally   
chaseFunctionPool('CreateSegments', gmSEQ.P1AWG, 2, ...
    2, ...
    2047, 2047, 'DEERNV_T2_P1_SegStruct_Q.txt', 'false');
pause(1); % this pause seems to be important, otherwise the loading is not right occassionally   
chaseFunctionPool('runChase', gmSEQ.MWAWG, 'false'); pause(1);
chaseFunctionPool('runChase', gmSEQ.P1AWG, 'false'); pause(1);

ApplyDelays();


function DEER_XY8N_old
global gmSEQ gSG gSG2
gSG.bfixedPow=1;
gSG.bfixedFreq=1;
gSG.bMod='IQ';
gSG.bModSrc='External';

gSG2.bMod='IQ';
gSG2.bModSrc='External';
SignalGeneratorFunctionPool2('SetMod');
SignalGeneratorFunctionPool2('WritePow');
SignalGeneratorFunctionPool2('WriteFreq');
gSG2.bOn=1; SignalGeneratorFunctionPool2('RFOnOff');

% TODO: add the definition for the pi and halfpi pulse AWG amp
gSG.piAWGAmp = gSG.AWGAmp; % Just for temporary use
gSG.halfpiAWGAmp = gSG.AWGAmp; % Just for temporary use
gSG2.piAWGAmp = gSG2.AWGAmp; % Just for temporary use
gSG2.halfpiAWGAmp = gSG2.AWGAmp; % Just for temporary use

gmSEQ.Ntomo = 2;

% gmSEQ.m here is the repetition number of XY8 block
gmSEQ.m = round(gmSEQ.m);

AfterPi = 2000;
Depol = 0.1e6;
AfterRot = 5000;
AfterLaser = Depol+gmSEQ.DEERpi/2+AfterRot; 
Wait_p = 0.1e6;
Detect_Window = 5000;

gmSEQ.DEERhalfpi = gmSEQ.DEERpi/2;
Pi = max(gmSEQ.pi, gmSEQ.DEERpi);
HalfPi = max(gmSEQ.halfpi, gmSEQ.DEERhalfpi);
Cycle = (gmSEQ.interval + Pi)*8;
Sig_D_start = Wait_p+gmSEQ.readout+AfterLaser+HalfPi+Cycle*gmSEQ.m+HalfPi+AfterPi+Detect_Window+Wait_p;

gmSEQ.CHN(1).PBN=PBDictionary('ctr0');
gmSEQ.CHN(1).NRise=4;
gmSEQ.CHN(1).T=[Wait_p+gmSEQ.readout-1000-gmSEQ.CtrGateDur, ...
    Wait_p+gmSEQ.readout+AfterLaser+HalfPi+Cycle*gmSEQ.m+HalfPi+AfterPi, ...
    Sig_D_start+gmSEQ.readout-1000-gmSEQ.CtrGateDur, ... 
    Sig_D_start+gmSEQ.readout+AfterLaser+HalfPi+Cycle*gmSEQ.m+HalfPi+AfterPi];
if strcmp(gmSEQ.meas,'SPCM')
    gmSEQ.CHN(1).DT=[gmSEQ.CtrGateDur gmSEQ.CtrGateDur gmSEQ.CtrGateDur gmSEQ.CtrGateDur];
elseif strcmp(gmSEQ.meas,'APD')
    gmSEQ.CHN(1).DT=[1000 1000 1000 1000];
end

gmSEQ.CHN(numel(gmSEQ.CHN)+1).PBN=PBDictionary('AOM');
gmSEQ.CHN(numel(gmSEQ.CHN)).NRise=4;
gmSEQ.CHN(numel(gmSEQ.CHN)).T = [Wait_p, Wait_p+gmSEQ.readout+AfterLaser+HalfPi+Cycle*gmSEQ.m+HalfPi+AfterPi, ...
    Sig_D_start, Sig_D_start+gmSEQ.readout+AfterLaser+HalfPi+Cycle*gmSEQ.m+HalfPi+AfterPi];
gmSEQ.CHN(numel(gmSEQ.CHN)).DT = [gmSEQ.readout Detect_Window gmSEQ.readout Detect_Window];

gmSEQ.CHN(numel(gmSEQ.CHN)+1).PBN=PBDictionary('AWGTrig');
gmSEQ.CHN(numel(gmSEQ.CHN)).NRise=2;
gmSEQ.CHN(numel(gmSEQ.CHN)).T=[Wait_p+gmSEQ.readout+AfterLaser, Sig_D_start+gmSEQ.readout+AfterLaser];
gmSEQ.CHN(numel(gmSEQ.CHN)).DT=repelem(HalfPi+Cycle*gmSEQ.m+HalfPi+200, 2);

gmSEQ.CHN(numel(gmSEQ.CHN)+1).PBN=PBDictionary('AWGTrig2');
gmSEQ.CHN(numel(gmSEQ.CHN)).NRise=2;
gmSEQ.CHN(numel(gmSEQ.CHN)).T=[Wait_p+gmSEQ.readout+Depol, Sig_D_start+gmSEQ.readout+Depol];
gmSEQ.CHN(numel(gmSEQ.CHN)).DT=repelem(gmSEQ.DEERpi/2+200, 2);

gmSEQ.CHN(numel(gmSEQ.CHN)+1).PBN=PBDictionary('MWSwitch');
if gmSEQ.interval < 150 || gmSEQ.m == 0
    gmSEQ.CHN(numel(gmSEQ.CHN)).NRise=2;
    gmSEQ.CHN(numel(gmSEQ.CHN)).T=[Wait_p+gmSEQ.readout+AfterLaser-20, Sig_D_start+gmSEQ.readout+AfterLaser-20];
    gmSEQ.CHN(numel(gmSEQ.CHN)).DT=[HalfPi+Cycle*gmSEQ.m+HalfPi+40, HalfPi+Cycle*gmSEQ.m+HalfPi+40];
else
    gmSEQ.CHN(numel(gmSEQ.CHN)).NRise=2*(8*gmSEQ.m + 2);
    gmSEQ.CHN(numel(gmSEQ.CHN)).T = zeros(1, 2*(8*gmSEQ.m + 2));
    gmSEQ.CHN(numel(gmSEQ.CHN)).T(1) = Wait_p+gmSEQ.readout+AfterLaser-20;
    for i = 1:gmSEQ.m
        for j = 1:8
            gmSEQ.CHN(numel(gmSEQ.CHN)).T(1+(i-1)*8+j) = Wait_p+gmSEQ.readout+AfterLaser+HalfPi+gmSEQ.interval/2+(i-1+(j-1)/8)*Cycle-20;
        end
    end
    gmSEQ.CHN(numel(gmSEQ.CHN)).T(1+8*gmSEQ.m+1) = Wait_p+gmSEQ.readout+AfterLaser+HalfPi+gmSEQ.m*Cycle-20;
    gmSEQ.CHN(numel(gmSEQ.CHN)).T(1+8*gmSEQ.m+2) = Sig_D_start+gmSEQ.readout+AfterLaser-20;
    for i = 1:gmSEQ.m
        for j = 1:8
            gmSEQ.CHN(numel(gmSEQ.CHN)).T(3+8*gmSEQ.m+(i-1)*8+j) = Sig_D_start+gmSEQ.readout+AfterLaser+HalfPi+gmSEQ.interval/2+(i-1+(j-1)/8)*Cycle-20;
        end
    end
    gmSEQ.CHN(numel(gmSEQ.CHN)).T(3+16*gmSEQ.m+1) = Sig_D_start+gmSEQ.readout+AfterLaser+HalfPi+gmSEQ.m*Cycle-20;
    gmSEQ.CHN(numel(gmSEQ.CHN)).DT=[HalfPi+40, repelem(Pi+40, 8*gmSEQ.m), HalfPi+40, ... 
        HalfPi+40, repelem(Pi+40, 8*gmSEQ.m), HalfPi+40];
end

gmSEQ.CHN(numel(gmSEQ.CHN)+1).PBN=PBDictionary('MWSwitch2');
if gmSEQ.interval < 150 || gmSEQ.m == 0
    gmSEQ.CHN(numel(gmSEQ.CHN)).NRise=4;
    gmSEQ.CHN(numel(gmSEQ.CHN)).T=[Wait_p+gmSEQ.readout+Depol-20, Wait_p+gmSEQ.readout+AfterLaser-20, ...
        Sig_D_start+gmSEQ.readout+Depol-20, Sig_D_start+gmSEQ.readout+AfterLaser-20];
    gmSEQ.CHN(numel(gmSEQ.CHN)).DT=[gmSEQ.DEERhalfpi+40, HalfPi+Cycle*gmSEQ.m+HalfPi+40, ...
        gmSEQ.DEERhalfpi+40, HalfPi+Cycle*gmSEQ.m+HalfPi+40];
else
    gmSEQ.CHN(numel(gmSEQ.CHN)).NRise=2*(8*gmSEQ.m + 1);
    gmSEQ.CHN(numel(gmSEQ.CHN)).T = zeros(1, 2*(8*gmSEQ.m + 1));
    gmSEQ.CHN(numel(gmSEQ.CHN)).T(1) = Wait_p+gmSEQ.readout+Depol-20;
    for i = 1:gmSEQ.m
        for j = 1:8
            gmSEQ.CHN(numel(gmSEQ.CHN)).T(1+(i-1)*8+j) = Wait_p+gmSEQ.readout+AfterLaser+HalfPi+gmSEQ.interval/2+(i-1+(j-1)/8)*Cycle-20;
        end
    end
    gmSEQ.CHN(numel(gmSEQ.CHN)).T(1+8*gmSEQ.m+1) = Sig_D_start+gmSEQ.readout+Depol-20;
    for i = 1:gmSEQ.m
        for j = 1:8
            gmSEQ.CHN(numel(gmSEQ.CHN)).T(2+8*gmSEQ.m+(i-1)*8+j) = Sig_D_start+gmSEQ.readout+AfterLaser+HalfPi+gmSEQ.interval/2+(i-1+(j-1)/8)*Cycle-20;
        end
    end
    gmSEQ.CHN(numel(gmSEQ.CHN)).DT=[gmSEQ.DEERhalfpi+40, repelem(Pi+40, 8*gmSEQ.m), gmSEQ.DEERhalfpi+40, repelem(Pi+40, 8*gmSEQ.m)];
end

gmSEQ.CHN(numel(gmSEQ.CHN)+1).PBN=PBDictionary('dummy1');
gmSEQ.CHN(numel(gmSEQ.CHN)).NRise=2;
gmSEQ.CHN(numel(gmSEQ.CHN)).T=[0 Sig_D_start+gmSEQ.readout+AfterLaser+HalfPi+gmSEQ.m*Cycle+HalfPi+AfterPi+Detect_Window-50];
gmSEQ.CHN(numel(gmSEQ.CHN)).DT=[50 50];

%% AWG
% Initialization
chaseFunctionPool('stopChase',  gmSEQ.MWAWG)
chaseFunctionPool('stopChase',  gmSEQ.P1AWG)

% This part need to be modified to accomodate the DC modulation
if ~gSG.ACmodAWG % in AC modulation mode
    gSG.AWGFreq = 0;
    gSG2.AWGFreq = 0;
end

if gmSEQ.m == 0
   WaveForm_1I = [0 gmSEQ.halfpi*2 gSG.AWGFreq 0 0];
%      WaveForm_1I = [0 gmSEQ.halfpi gSG.AWGFreq 0 gSG.halfpiAWGAmp; ...
%          gmSEQ.halfpi+0 2*gmSEQ.halfpi+0 gSG.AWGFreq pi gSG.halfpiAWGAmp];
else
    WaveForm_1I = zeros(2 + 8*gmSEQ.m, 5);
    WaveForm_1I(1, :) = [0 gmSEQ.halfpi gSG.AWGFreq 0 gSG.halfpiAWGAmp];
    for i = 1:gmSEQ.m
        WaveForm_1I(1 + (i-1)*8 + 1, :) = [HalfPi+gmSEQ.interval/2+(i-1+0/8)*Cycle HalfPi+gmSEQ.interval/2+(i-1+0/8)*Cycle+gmSEQ.pi gSG.AWGFreq 0 gSG.piAWGAmp]; % pi_x
        WaveForm_1I(1 + (i-1)*8 + 2, :) = [HalfPi+gmSEQ.interval/2+(i-1+1/8)*Cycle HalfPi+gmSEQ.interval/2+(i-1+1/8)*Cycle+gmSEQ.pi gSG.AWGFreq pi/2 gSG.piAWGAmp]; % pi_y
        WaveForm_1I(1 + (i-1)*8 + 3, :) = [HalfPi+gmSEQ.interval/2+(i-1+2/8)*Cycle HalfPi+gmSEQ.interval/2+(i-1+2/8)*Cycle+gmSEQ.pi gSG.AWGFreq 0 gSG.piAWGAmp]; % pi_x
        WaveForm_1I(1 + (i-1)*8 + 4, :) = [HalfPi+gmSEQ.interval/2+(i-1+3/8)*Cycle HalfPi+gmSEQ.interval/2+(i-1+3/8)*Cycle+gmSEQ.pi gSG.AWGFreq pi/2 gSG.piAWGAmp]; % pi_y
        WaveForm_1I(1 + (i-1)*8 + 5, :) = [HalfPi+gmSEQ.interval/2+(i-1+4/8)*Cycle HalfPi+gmSEQ.interval/2+(i-1+4/8)*Cycle+gmSEQ.pi gSG.AWGFreq pi/2 gSG.piAWGAmp]; % pi_y
        WaveForm_1I(1 + (i-1)*8 + 6, :) = [HalfPi+gmSEQ.interval/2+(i-1+5/8)*Cycle HalfPi+gmSEQ.interval/2+(i-1+5/8)*Cycle+gmSEQ.pi gSG.AWGFreq 0 gSG.piAWGAmp]; % pi_x
        WaveForm_1I(1 + (i-1)*8 + 7, :) = [HalfPi+gmSEQ.interval/2+(i-1+6/8)*Cycle HalfPi+gmSEQ.interval/2+(i-1+6/8)*Cycle+gmSEQ.pi gSG.AWGFreq pi/2 gSG.piAWGAmp]; % pi_y
        WaveForm_1I(1 + (i-1)*8 + 8, :) = [HalfPi+gmSEQ.interval/2+(i-1+7/8)*Cycle HalfPi+gmSEQ.interval/2+(i-1+7/8)*Cycle+gmSEQ.pi gSG.AWGFreq 0 gSG.piAWGAmp]; % pi_x
    end
    WaveForm_1I(2 + 8*gmSEQ.m, :) = [HalfPi+gmSEQ.m*Cycle HalfPi+gmSEQ.m*Cycle+gmSEQ.halfpi gSG.AWGFreq pi gSG.halfpiAWGAmp];
end
WaveForm_1Q = WaveForm_1I - repmat([0 0 0 pi/2 0], size(WaveForm_1I, 1), 1);
WaveForm_1Length = ceil((HalfPi+gmSEQ.m*Cycle+HalfPi+1000) / (16 / gSG.AWGClockRate)) ...
    *(16 / gSG.AWGClockRate);
WaveForm_1PointNum = WaveForm_1Length * gSG.AWGClockRate;

if gmSEQ.m == 0
    WaveForm_2I = [0 gmSEQ.halfpi*2 gSG.AWGFreq 0 gSG.halfpiAWGAmp];
    WaveForm_2Q = WaveForm_2I - repmat([0 0 0 pi/2 0], size(WaveForm_2I, 1), 1);
    WaveForm_2Length = ceil((gmSEQ.halfpi+gmSEQ.halfpi+1000) / (16 / gSG.AWGClockRate)) * (16 / gSG.AWGClockRate);
    WaveForm_2PointNum = WaveForm_2Length * gSG.AWGClockRate;
else
    WaveForm_2I = WaveForm_1I;
    WaveForm_2I(size(WaveForm_1I, 1), 4) = 0; % Differential measurement
    WaveForm_2Q = WaveForm_1Q;
    WaveForm_2Q(size(WaveForm_1I, 1), 4) = -pi/2; % Differential measurement
    WaveForm_2Length = WaveForm_1Length;
    WaveForm_2PointNum = WaveForm_2Length * gSG.AWGClockRate;
end

WaveForm_3I = zeros(2 + 8*gmSEQ.m, 5);
if gmSEQ.CoolSwitch == 0 
    WaveForm_3I(1, :) = [0 gmSEQ.DEERhalfpi gSG2.AWGFreq 0 gSG2.piAWGAmp];
else
    WaveForm_3I(1, :) = [0 gmSEQ.DEERhalfpi gSG2.AWGFreq 0 0];
end
for i = 1:gmSEQ.m
    WaveForm_3I(1 + (i-1)*8 + 1, :) = [gmSEQ.DEERhalfpi+AfterRot+HalfPi+gmSEQ.interval/2+(i-1+0/8)*Cycle gmSEQ.DEERhalfpi+AfterRot+HalfPi+gmSEQ.interval/2+(i-1+0/8)*Cycle+gmSEQ.DEERpi gSG2.AWGFreq 0 gSG2.piAWGAmp]; % pi_x
    WaveForm_3I(1 + (i-1)*8 + 2, :) = [gmSEQ.DEERhalfpi+AfterRot+HalfPi+gmSEQ.interval/2+(i-1+1/8)*Cycle gmSEQ.DEERhalfpi+AfterRot+HalfPi+gmSEQ.interval/2+(i-1+1/8)*Cycle+gmSEQ.DEERpi gSG2.AWGFreq pi/2 gSG2.piAWGAmp]; % pi_y
    WaveForm_3I(1 + (i-1)*8 + 3, :) = [gmSEQ.DEERhalfpi+AfterRot+HalfPi+gmSEQ.interval/2+(i-1+2/8)*Cycle gmSEQ.DEERhalfpi+AfterRot+HalfPi+gmSEQ.interval/2+(i-1+2/8)*Cycle+gmSEQ.DEERpi gSG2.AWGFreq 0 gSG2.piAWGAmp]; % pi_x
    WaveForm_3I(1 + (i-1)*8 + 4, :) = [gmSEQ.DEERhalfpi+AfterRot+HalfPi+gmSEQ.interval/2+(i-1+3/8)*Cycle gmSEQ.DEERhalfpi+AfterRot+HalfPi+gmSEQ.interval/2+(i-1+3/8)*Cycle+gmSEQ.DEERpi gSG2.AWGFreq pi/2 gSG2.piAWGAmp]; % pi_y
    WaveForm_3I(1 + (i-1)*8 + 5, :) = [gmSEQ.DEERhalfpi+AfterRot+HalfPi+gmSEQ.interval/2+(i-1+4/8)*Cycle gmSEQ.DEERhalfpi+AfterRot+HalfPi+gmSEQ.interval/2+(i-1+4/8)*Cycle+gmSEQ.DEERpi gSG2.AWGFreq pi/2 gSG2.piAWGAmp]; % pi_y
    WaveForm_3I(1 + (i-1)*8 + 6, :) = [gmSEQ.DEERhalfpi+AfterRot+HalfPi+gmSEQ.interval/2+(i-1+5/8)*Cycle gmSEQ.DEERhalfpi+AfterRot+HalfPi+gmSEQ.interval/2+(i-1+5/8)*Cycle+gmSEQ.DEERpi gSG2.AWGFreq 0 gSG2.piAWGAmp]; % pi_x
    WaveForm_3I(1 + (i-1)*8 + 7, :) = [gmSEQ.DEERhalfpi+AfterRot+HalfPi+gmSEQ.interval/2+(i-1+6/8)*Cycle gmSEQ.DEERhalfpi+AfterRot+HalfPi+gmSEQ.interval/2+(i-1+6/8)*Cycle+gmSEQ.DEERpi gSG2.AWGFreq pi/2 gSG2.piAWGAmp]; % pi_y
    WaveForm_3I(1 + (i-1)*8 + 8, :) = [gmSEQ.DEERhalfpi+AfterRot+HalfPi+gmSEQ.interval/2+(i-1+7/8)*Cycle gmSEQ.DEERhalfpi+AfterRot+HalfPi+gmSEQ.interval/2+(i-1+7/8)*Cycle+gmSEQ.DEERpi gSG2.AWGFreq 0 gSG2.piAWGAmp]; % pi_x
end
WaveForm_3I(2 + 8*gmSEQ.m, :) = [gmSEQ.DEERhalfpi+AfterRot+HalfPi+gmSEQ.m*Cycle gmSEQ.DEERhalfpi+AfterRot+HalfPi+gmSEQ.m*Cycle+gmSEQ.DEERhalfpi gSG2.AWGFreq 0 0]; % No final pi/2 pulse for bath spins

WaveForm_3Q = WaveForm_3I - repmat([0 0 0 pi/2 0], size(WaveForm_3I, 1), 1);
WaveForm_3Length = ceil((gmSEQ.DEERhalfpi+AfterRot+HalfPi+gmSEQ.m*Cycle+HalfPi+1000) / (16 / gSG2.P1AWGClockRate)) ...
    *(16 / gSG2.P1AWGClockRate);
WaveForm_3PointNum = WaveForm_3Length * gSG2.P1AWGClockRate;

chaseFunctionPool('createWaveform', WaveForm_1I, gSG.AWGClockRate, WaveForm_1Length, 'DEER_XY8N_I_seg1.txt'); pause(0.5);
chaseFunctionPool('createWaveform', WaveForm_1Q, gSG.AWGClockRate, WaveForm_1Length, 'DEER_XY8N_Q_seg1.txt'); pause(0.5);
chaseFunctionPool('createWaveform', WaveForm_2I, gSG.AWGClockRate, WaveForm_2Length, 'DEER_XY8N_I_seg2.txt'); pause(0.5);
chaseFunctionPool('createWaveform', WaveForm_2Q, gSG.AWGClockRate, WaveForm_2Length, 'DEER_XY8N_Q_seg2.txt'); pause(0.5);
chaseFunctionPool('createWaveform', WaveForm_3I, gSG2.P1AWGClockRate, WaveForm_3Length, 'DEER_XY8N_I_seg3.txt'); pause(0.5);
chaseFunctionPool('createWaveform', WaveForm_3Q, gSG2.P1AWGClockRate, WaveForm_3Length, 'DEER_XY8N_Q_seg3.txt'); pause(0.5);

chaseFunctionPool('createSegStruct', 'DEER_XY8N_SegStruct_I.txt', ...
    'DEER_XY8N_I_seg1.txt', WaveForm_1PointNum, 1, 1, ...
    'DEER_XY8N_I_seg2.txt', WaveForm_2PointNum, 1, 1);
pause(0.5);
chaseFunctionPool('createSegStruct', 'DEER_XY8N_SegStruct_Q.txt', ...
    'DEER_XY8N_Q_seg1.txt', WaveForm_1PointNum, 1, 1, ...
    'DEER_XY8N_Q_seg2.txt', WaveForm_2PointNum, 1, 1);
pause(0.5);
chaseFunctionPool('createSegStruct', 'DEER_XY8N_P1_SegStruct_I.txt', ...
    'DEER_XY8N_I_seg3.txt', WaveForm_3PointNum, 1, 1, ...
    'DEER_XY8N_I_seg3.txt', WaveForm_3PointNum, 1, 1);
pause(0.5);
chaseFunctionPool('createSegStruct', 'DEER_XY8N_P1_SegStruct_Q.txt', ...
    'DEER_XY8N_Q_seg3.txt', WaveForm_3PointNum, 1, 1, ...
    'DEER_XY8N_Q_seg3.txt', WaveForm_3PointNum, 1, 1);
pause(0.5);

%% Load waveform to AWG
chaseFunctionPool('CreateSegments', gmSEQ.MWAWG, 1, ...
    2, ...
    2047, 2047, 'DEER_XY8N_SegStruct_I.txt', 'false');
pause(1); % this pause seems to be important, otherwise the loading is not right occassionally
chaseFunctionPool('CreateSegments', gmSEQ.MWAWG, 2, ...
    2, ...
    2047, 2047, 'DEER_XY8N_SegStruct_Q.txt', 'false');
pause(1); % this pause seems to be important, otherwise the loading is not right occassionally
chaseFunctionPool('CreateSegments', gmSEQ.P1AWG, 1, ...
    2, ...
    2047, 2047, 'DEER_XY8N_P1_SegStruct_I.txt', 'false');
pause(1); % this pause seems to be important, otherwise the loading is not right occassionally
chaseFunctionPool('CreateSegments', gmSEQ.P1AWG, 2, ...
    2, ...
    2047, 2047, 'DEER_XY8N_P1_SegStruct_Q.txt', 'false');
pause(1); % this pause seems to be important, otherwise the loading is not right occassionally

%% Run waveform
chaseFunctionPool('runChase', gmSEQ.MWAWG, 'false'); pause(1);
chaseFunctionPool('runChase', gmSEQ.P1AWG, 'false'); pause(1);
ApplyDelays();

function DEER_XY8N
global gmSEQ gSG gSG2
gSG.bfixedPow=1;
gSG.bfixedFreq=1;
gSG.bMod='IQ';
gSG.bModSrc='External';

gSG2.bMod='IQ';
gSG2.bModSrc='External';
SignalGeneratorFunctionPool2('SetMod');
SignalGeneratorFunctionPool2('WritePow');
SignalGeneratorFunctionPool2('WriteFreq');
gSG2.bOn=1; SignalGeneratorFunctionPool2('RFOnOff');

% TODO: add the definition for the pi and halfpi pulse AWG amp
gSG.piAWGAmp = gSG.AWGAmp; % Just for temporary use
gSG.halfpiAWGAmp = gSG.AWGAmp; % Just for temporary use
gSG2.piAWGAmp = gSG2.AWGAmp; % Just for temporary use
gSG2.halfpiAWGAmp = gSG2.AWGAmp; % Just for temporary use

gmSEQ.Ntomo = 2;

% gmSEQ.m here is the repetition number of XY8 block
gmSEQ.m = round(gmSEQ.m);

AfterPi = 2000;
Depol = 0.1e6;
AfterRot = 5000;
AfterLaser = Depol+gmSEQ.DEERpi/2+AfterRot; 
Wait_p = 0.1e6;
Detect_Window = 5000;

gmSEQ.DEERhalfpi = gmSEQ.DEERpi/2;
Pi = max(gmSEQ.pi, gmSEQ.DEERpi);
HalfPi = max(gmSEQ.halfpi, gmSEQ.DEERhalfpi);
Cycle = (gmSEQ.interval + Pi)*8;
Sig_D_start = Wait_p+gmSEQ.readout+AfterLaser+HalfPi+Cycle*gmSEQ.m+HalfPi+AfterPi+Detect_Window+Wait_p;

gmSEQ.CHN(1).PBN=PBDictionary('ctr0');
gmSEQ.CHN(1).NRise=4;
gmSEQ.CHN(1).T=[Wait_p+gmSEQ.readout-1000-gmSEQ.CtrGateDur, ...
    Wait_p+gmSEQ.readout+AfterLaser+HalfPi+Cycle*gmSEQ.m+HalfPi+AfterPi, ...
    Sig_D_start+gmSEQ.readout-1000-gmSEQ.CtrGateDur, ... 
    Sig_D_start+gmSEQ.readout+AfterLaser+HalfPi+Cycle*gmSEQ.m+HalfPi+AfterPi];
if strcmp(gmSEQ.meas,'SPCM')
    gmSEQ.CHN(1).DT=[gmSEQ.CtrGateDur gmSEQ.CtrGateDur gmSEQ.CtrGateDur gmSEQ.CtrGateDur];
elseif strcmp(gmSEQ.meas,'APD')
    gmSEQ.CHN(1).DT=[1000 1000 1000 1000];
end

gmSEQ.CHN(numel(gmSEQ.CHN)+1).PBN=PBDictionary('AOM');
gmSEQ.CHN(numel(gmSEQ.CHN)).NRise=4;
gmSEQ.CHN(numel(gmSEQ.CHN)).T = [Wait_p, Wait_p+gmSEQ.readout+AfterLaser+HalfPi+Cycle*gmSEQ.m+HalfPi+AfterPi, ...
    Sig_D_start, Sig_D_start+gmSEQ.readout+AfterLaser+HalfPi+Cycle*gmSEQ.m+HalfPi+AfterPi];
gmSEQ.CHN(numel(gmSEQ.CHN)).DT = [gmSEQ.readout Detect_Window gmSEQ.readout Detect_Window];

gmSEQ.CHN(numel(gmSEQ.CHN)+1).PBN=PBDictionary('AWGTrig2');
gmSEQ.CHN(numel(gmSEQ.CHN)).NRise=2;
gmSEQ.CHN(numel(gmSEQ.CHN)).T=[Wait_p+gmSEQ.readout+AfterLaser, Sig_D_start+gmSEQ.readout+AfterLaser];
gmSEQ.CHN(numel(gmSEQ.CHN)).DT=repelem(HalfPi+Cycle*gmSEQ.m+HalfPi+200, 2);

gmSEQ.CHN(numel(gmSEQ.CHN)+1).PBN=PBDictionary('AWGTrig');
gmSEQ.CHN(numel(gmSEQ.CHN)).NRise=2;
gmSEQ.CHN(numel(gmSEQ.CHN)).T=[Wait_p+gmSEQ.readout+Depol, Sig_D_start+gmSEQ.readout+Depol];
gmSEQ.CHN(numel(gmSEQ.CHN)).DT=repelem(gmSEQ.DEERpi/2+200, 2);

bufferTime = 10;
gmSEQ.CHN(numel(gmSEQ.CHN)+1).PBN=PBDictionary('MWSwitch2');
if gmSEQ.interval < 150 || gmSEQ.m == 0
    gmSEQ.CHN(numel(gmSEQ.CHN)).NRise=2;
    gmSEQ.CHN(numel(gmSEQ.CHN)).T=[Wait_p+gmSEQ.readout+AfterLaser-bufferTime, Sig_D_start+gmSEQ.readout+AfterLaser-bufferTime];
    gmSEQ.CHN(numel(gmSEQ.CHN)).DT=[HalfPi+Cycle*gmSEQ.m+HalfPi+2*bufferTime, HalfPi+Cycle*gmSEQ.m+HalfPi+2*bufferTime];
else
    gmSEQ.CHN(numel(gmSEQ.CHN)).NRise=2*(8*gmSEQ.m + 2);
    gmSEQ.CHN(numel(gmSEQ.CHN)).T = zeros(1, 2*(8*gmSEQ.m + 2));
    gmSEQ.CHN(numel(gmSEQ.CHN)).T(1) = Wait_p+gmSEQ.readout+AfterLaser-bufferTime;
    for i = 1:gmSEQ.m
        for j = 1:8
            gmSEQ.CHN(numel(gmSEQ.CHN)).T(1+(i-1)*8+j) = Wait_p+gmSEQ.readout+AfterLaser+HalfPi+gmSEQ.interval/2+(i-1+(j-1)/8)*Cycle-bufferTime;
        end
    end
    gmSEQ.CHN(numel(gmSEQ.CHN)).T(1+8*gmSEQ.m+1) = Wait_p+gmSEQ.readout+AfterLaser+HalfPi+gmSEQ.m*Cycle-bufferTime;
    gmSEQ.CHN(numel(gmSEQ.CHN)).T(1+8*gmSEQ.m+2) = Sig_D_start+gmSEQ.readout+AfterLaser-bufferTime;
    for i = 1:gmSEQ.m
        for j = 1:8
            gmSEQ.CHN(numel(gmSEQ.CHN)).T(3+8*gmSEQ.m+(i-1)*8+j) = Sig_D_start+gmSEQ.readout+AfterLaser+HalfPi+gmSEQ.interval/2+(i-1+(j-1)/8)*Cycle-bufferTime;
        end
    end
    gmSEQ.CHN(numel(gmSEQ.CHN)).T(3+16*gmSEQ.m+1) = Sig_D_start+gmSEQ.readout+AfterLaser+HalfPi+gmSEQ.m*Cycle-bufferTime;
    gmSEQ.CHN(numel(gmSEQ.CHN)).DT=[HalfPi+2*bufferTime, repelem(Pi+2*bufferTime, 8*gmSEQ.m), HalfPi+2*bufferTime, ... 
        HalfPi+2*bufferTime, repelem(Pi+2*bufferTime, 8*gmSEQ.m), HalfPi+2*bufferTime];
end

gmSEQ.CHN(numel(gmSEQ.CHN)+1).PBN=PBDictionary('MWSwitch');
if gmSEQ.interval < 150 || gmSEQ.m == 0
    gmSEQ.CHN(numel(gmSEQ.CHN)).NRise=4;
    gmSEQ.CHN(numel(gmSEQ.CHN)).T=[Wait_p+gmSEQ.readout+Depol-bufferTime, Wait_p+gmSEQ.readout+AfterLaser-bufferTime, ...
        Sig_D_start+gmSEQ.readout+Depol-bufferTime, Sig_D_start+gmSEQ.readout+AfterLaser-bufferTime];
    gmSEQ.CHN(numel(gmSEQ.CHN)).DT=[gmSEQ.DEERhalfpi+2*bufferTime, HalfPi+Cycle*gmSEQ.m+HalfPi+2*bufferTime, ...
        gmSEQ.DEERhalfpi+2*bufferTime, HalfPi+Cycle*gmSEQ.m+HalfPi+2*bufferTime];
else
    gmSEQ.CHN(numel(gmSEQ.CHN)).NRise=2*(8*gmSEQ.m + 1);
    gmSEQ.CHN(numel(gmSEQ.CHN)).T = zeros(1, 2*(8*gmSEQ.m + 1));
    gmSEQ.CHN(numel(gmSEQ.CHN)).T(1) = Wait_p+gmSEQ.readout+Depol-bufferTime;
    for i = 1:gmSEQ.m
        for j = 1:8
            gmSEQ.CHN(numel(gmSEQ.CHN)).T(1+(i-1)*8+j) = Wait_p+gmSEQ.readout+AfterLaser+HalfPi+gmSEQ.interval/2+(i-1+(j-1)/8)*Cycle-bufferTime;
        end
    end
    gmSEQ.CHN(numel(gmSEQ.CHN)).T(1+8*gmSEQ.m+1) = Sig_D_start+gmSEQ.readout+Depol-bufferTime;
    for i = 1:gmSEQ.m
        for j = 1:8
            gmSEQ.CHN(numel(gmSEQ.CHN)).T(2+8*gmSEQ.m+(i-1)*8+j) = Sig_D_start+gmSEQ.readout+AfterLaser+HalfPi+gmSEQ.interval/2+(i-1+(j-1)/8)*Cycle-bufferTime;
        end
    end
    gmSEQ.CHN(numel(gmSEQ.CHN)).DT=[gmSEQ.DEERhalfpi+2*bufferTime, repelem(Pi+2*bufferTime, 8*gmSEQ.m), gmSEQ.DEERhalfpi+2*bufferTime, repelem(Pi+2*bufferTime, 8*gmSEQ.m)];
end

gmSEQ.CHN(numel(gmSEQ.CHN)+1).PBN=PBDictionary('dummy1');
gmSEQ.CHN(numel(gmSEQ.CHN)).NRise=2;
gmSEQ.CHN(numel(gmSEQ.CHN)).T=[0 Sig_D_start+gmSEQ.readout+AfterLaser+HalfPi+gmSEQ.m*Cycle+HalfPi+AfterPi+Detect_Window-50];
gmSEQ.CHN(numel(gmSEQ.CHN)).DT=[50 50];

%% AWG
% Initialization
chaseFunctionPool('stopChase',  gmSEQ.MWAWG)
chaseFunctionPool('stopChase',  gmSEQ.P1AWG)

% This part need to be modified to accomodate the DC modulation
if ~gSG.ACmodAWG % in AC modulation mode
    gSG2.AWGFreq = 0;
    gSG.AWGFreq = 0;
end

if gmSEQ.m == 0
   WaveForm_1I = [0 gmSEQ.halfpi*2 gSG2.AWGFreq 0 0];
%      WaveForm_1I = [0 gmSEQ.halfpi gSG2.AWGFreq 0 gSG.halfpiAWGAmp; ...
%          gmSEQ.halfpi+0 2*gmSEQ.halfpi+0 gSG2.AWGFreq pi gSG.halfpiAWGAmp];
else
    WaveForm_1I = zeros(2 + 8*gmSEQ.m, 5);
    WaveForm_1I(1, :) = [0 gmSEQ.halfpi gSG2.AWGFreq 0 gSG2.halfpiAWGAmp];
    for i = 1:gmSEQ.m
        WaveForm_1I(1 + (i-1)*8 + 1, :) = [HalfPi+gmSEQ.interval/2+(i-1+0/8)*Cycle HalfPi+gmSEQ.interval/2+(i-1+0/8)*Cycle+gmSEQ.pi gSG2.AWGFreq 0 gSG2.piAWGAmp]; % pi_x
        WaveForm_1I(1 + (i-1)*8 + 2, :) = [HalfPi+gmSEQ.interval/2+(i-1+1/8)*Cycle HalfPi+gmSEQ.interval/2+(i-1+1/8)*Cycle+gmSEQ.pi gSG2.AWGFreq pi/2 gSG2.piAWGAmp]; % pi_y
        WaveForm_1I(1 + (i-1)*8 + 3, :) = [HalfPi+gmSEQ.interval/2+(i-1+2/8)*Cycle HalfPi+gmSEQ.interval/2+(i-1+2/8)*Cycle+gmSEQ.pi gSG2.AWGFreq 0 gSG2.piAWGAmp]; % pi_x
        WaveForm_1I(1 + (i-1)*8 + 4, :) = [HalfPi+gmSEQ.interval/2+(i-1+3/8)*Cycle HalfPi+gmSEQ.interval/2+(i-1+3/8)*Cycle+gmSEQ.pi gSG2.AWGFreq pi/2 gSG2.piAWGAmp]; % pi_y
        WaveForm_1I(1 + (i-1)*8 + 5, :) = [HalfPi+gmSEQ.interval/2+(i-1+4/8)*Cycle HalfPi+gmSEQ.interval/2+(i-1+4/8)*Cycle+gmSEQ.pi gSG2.AWGFreq pi/2 gSG2.piAWGAmp]; % pi_y
        WaveForm_1I(1 + (i-1)*8 + 6, :) = [HalfPi+gmSEQ.interval/2+(i-1+5/8)*Cycle HalfPi+gmSEQ.interval/2+(i-1+5/8)*Cycle+gmSEQ.pi gSG2.AWGFreq 0 gSG2.piAWGAmp]; % pi_x
        WaveForm_1I(1 + (i-1)*8 + 7, :) = [HalfPi+gmSEQ.interval/2+(i-1+6/8)*Cycle HalfPi+gmSEQ.interval/2+(i-1+6/8)*Cycle+gmSEQ.pi gSG2.AWGFreq pi/2 gSG2.piAWGAmp]; % pi_y
        WaveForm_1I(1 + (i-1)*8 + 8, :) = [HalfPi+gmSEQ.interval/2+(i-1+7/8)*Cycle HalfPi+gmSEQ.interval/2+(i-1+7/8)*Cycle+gmSEQ.pi gSG2.AWGFreq 0 gSG2.piAWGAmp]; % pi_x
    end
    WaveForm_1I(2 + 8*gmSEQ.m, :) = [HalfPi+gmSEQ.m*Cycle HalfPi+gmSEQ.m*Cycle+gmSEQ.halfpi gSG2.AWGFreq pi gSG2.halfpiAWGAmp];
end
WaveForm_1Q = WaveForm_1I - repmat([0 0 0 pi/2 0], size(WaveForm_1I, 1), 1);
WaveForm_1Length = ceil((HalfPi+gmSEQ.m*Cycle+HalfPi+1000) / (16 / gSG2.P1AWGClockRate)) ...
    *(16 / gSG2.P1AWGClockRate);
WaveForm_1PointNum = WaveForm_1Length * gSG2.P1AWGClockRate;

if gmSEQ.m == 0
    WaveForm_2I = [0 gmSEQ.halfpi*2 gSG2.AWGFreq 0 gSG2.halfpiAWGAmp];
    WaveForm_2Q = WaveForm_2I - repmat([0 0 0 pi/2 0], size(WaveForm_2I, 1), 1);
    WaveForm_2Length = ceil((gmSEQ.halfpi+gmSEQ.halfpi+1000) / (16 / gSG2.P1AWGClockRate)) * (16 / gSG2.P1AWGClockRate);
    WaveForm_2PointNum = WaveForm_2Length * gSG2.P1AWGClockRate;
else
    WaveForm_2I = WaveForm_1I;
    WaveForm_2I(size(WaveForm_1I, 1), 4) = 0; % Differential measurement
    WaveForm_2Q = WaveForm_1Q;
    WaveForm_2Q(size(WaveForm_1I, 1), 4) = -pi/2; % Differential measurement
    WaveForm_2Length = WaveForm_1Length;
    WaveForm_2PointNum = WaveForm_2Length * gSG2.P1AWGClockRate;
end

WaveForm_3I = zeros(2 + 8*gmSEQ.m, 5);
if gmSEQ.CoolSwitch == 0 
    WaveForm_3I(1, :) = [0 gmSEQ.DEERhalfpi gSG.AWGFreq 0 gSG.piAWGAmp];
else
    WaveForm_3I(1, :) = [0 gmSEQ.DEERhalfpi gSG.AWGFreq 0 0];
end
for i = 1:gmSEQ.m
    WaveForm_3I(1 + (i-1)*8 + 1, :) = [gmSEQ.DEERhalfpi+AfterRot+HalfPi+gmSEQ.interval/2+(i-1+0/8)*Cycle gmSEQ.DEERhalfpi+AfterRot+HalfPi+gmSEQ.interval/2+(i-1+0/8)*Cycle+gmSEQ.DEERpi gSG.AWGFreq 0 gSG.piAWGAmp]; % pi_x
    WaveForm_3I(1 + (i-1)*8 + 2, :) = [gmSEQ.DEERhalfpi+AfterRot+HalfPi+gmSEQ.interval/2+(i-1+1/8)*Cycle gmSEQ.DEERhalfpi+AfterRot+HalfPi+gmSEQ.interval/2+(i-1+1/8)*Cycle+gmSEQ.DEERpi gSG.AWGFreq pi/2 gSG.piAWGAmp]; % pi_y
    WaveForm_3I(1 + (i-1)*8 + 3, :) = [gmSEQ.DEERhalfpi+AfterRot+HalfPi+gmSEQ.interval/2+(i-1+2/8)*Cycle gmSEQ.DEERhalfpi+AfterRot+HalfPi+gmSEQ.interval/2+(i-1+2/8)*Cycle+gmSEQ.DEERpi gSG.AWGFreq 0 gSG.piAWGAmp]; % pi_x
    WaveForm_3I(1 + (i-1)*8 + 4, :) = [gmSEQ.DEERhalfpi+AfterRot+HalfPi+gmSEQ.interval/2+(i-1+3/8)*Cycle gmSEQ.DEERhalfpi+AfterRot+HalfPi+gmSEQ.interval/2+(i-1+3/8)*Cycle+gmSEQ.DEERpi gSG.AWGFreq pi/2 gSG.piAWGAmp]; % pi_y
    WaveForm_3I(1 + (i-1)*8 + 5, :) = [gmSEQ.DEERhalfpi+AfterRot+HalfPi+gmSEQ.interval/2+(i-1+4/8)*Cycle gmSEQ.DEERhalfpi+AfterRot+HalfPi+gmSEQ.interval/2+(i-1+4/8)*Cycle+gmSEQ.DEERpi gSG.AWGFreq pi/2 gSG.piAWGAmp]; % pi_y
    WaveForm_3I(1 + (i-1)*8 + 6, :) = [gmSEQ.DEERhalfpi+AfterRot+HalfPi+gmSEQ.interval/2+(i-1+5/8)*Cycle gmSEQ.DEERhalfpi+AfterRot+HalfPi+gmSEQ.interval/2+(i-1+5/8)*Cycle+gmSEQ.DEERpi gSG.AWGFreq 0 gSG.piAWGAmp]; % pi_x
    WaveForm_3I(1 + (i-1)*8 + 7, :) = [gmSEQ.DEERhalfpi+AfterRot+HalfPi+gmSEQ.interval/2+(i-1+6/8)*Cycle gmSEQ.DEERhalfpi+AfterRot+HalfPi+gmSEQ.interval/2+(i-1+6/8)*Cycle+gmSEQ.DEERpi gSG.AWGFreq pi/2 gSG.piAWGAmp]; % pi_y
    WaveForm_3I(1 + (i-1)*8 + 8, :) = [gmSEQ.DEERhalfpi+AfterRot+HalfPi+gmSEQ.interval/2+(i-1+7/8)*Cycle gmSEQ.DEERhalfpi+AfterRot+HalfPi+gmSEQ.interval/2+(i-1+7/8)*Cycle+gmSEQ.DEERpi gSG.AWGFreq 0 gSG.piAWGAmp]; % pi_x
end
WaveForm_3I(2 + 8*gmSEQ.m, :) = [gmSEQ.DEERhalfpi+AfterRot+HalfPi+gmSEQ.m*Cycle gmSEQ.DEERhalfpi+AfterRot+HalfPi+gmSEQ.m*Cycle+gmSEQ.DEERhalfpi gSG.AWGFreq 0 0]; % No final pi/2 pulse for bath spins

WaveForm_3Q = WaveForm_3I - repmat([0 0 0 pi/2 0], size(WaveForm_3I, 1), 1);
WaveForm_3Length = ceil((gmSEQ.DEERhalfpi+AfterRot+HalfPi+gmSEQ.m*Cycle+HalfPi+1000) / (16 / gSG.AWGClockRate)) ...
    *(16 / gSG.AWGClockRate);
WaveForm_3PointNum = WaveForm_3Length * gSG.AWGClockRate;

chaseFunctionPool('createWaveform', WaveForm_1I, gSG2.P1AWGClockRate, WaveForm_1Length, 'DEER_XY8N_I_seg1.txt'); pause(0.5);
chaseFunctionPool('createWaveform', WaveForm_1Q, gSG2.P1AWGClockRate, WaveForm_1Length, 'DEER_XY8N_Q_seg1.txt'); pause(0.5);
chaseFunctionPool('createWaveform', WaveForm_2I, gSG2.P1AWGClockRate, WaveForm_2Length, 'DEER_XY8N_I_seg2.txt'); pause(0.5);
chaseFunctionPool('createWaveform', WaveForm_2Q, gSG2.P1AWGClockRate, WaveForm_2Length, 'DEER_XY8N_Q_seg2.txt'); pause(0.5);
chaseFunctionPool('createWaveform', WaveForm_3I, gSG.AWGClockRate, WaveForm_3Length, 'DEER_XY8N_I_seg3.txt'); pause(0.5);
chaseFunctionPool('createWaveform', WaveForm_3Q, gSG.AWGClockRate, WaveForm_3Length, 'DEER_XY8N_Q_seg3.txt'); pause(0.5);

chaseFunctionPool('createSegStruct', 'DEER_XY8N_SegStruct_I.txt', ...
    'DEER_XY8N_I_seg1.txt', WaveForm_1PointNum, 1, 1, ...
    'DEER_XY8N_I_seg2.txt', WaveForm_2PointNum, 1, 1);
pause(0.5);
chaseFunctionPool('createSegStruct', 'DEER_XY8N_SegStruct_Q.txt', ...
    'DEER_XY8N_Q_seg1.txt', WaveForm_1PointNum, 1, 1, ...
    'DEER_XY8N_Q_seg2.txt', WaveForm_2PointNum, 1, 1);
pause(0.5);
chaseFunctionPool('createSegStruct', 'DEER_XY8N_P1_SegStruct_I.txt', ...
    'DEER_XY8N_I_seg3.txt', WaveForm_3PointNum, 1, 1, ...
    'DEER_XY8N_I_seg3.txt', WaveForm_3PointNum, 1, 1);
pause(0.5);
chaseFunctionPool('createSegStruct', 'DEER_XY8N_P1_SegStruct_Q.txt', ...
    'DEER_XY8N_Q_seg3.txt', WaveForm_3PointNum, 1, 1, ...
    'DEER_XY8N_Q_seg3.txt', WaveForm_3PointNum, 1, 1);
pause(0.5);

%% Load waveform to AWG
chaseFunctionPool('CreateSegments', gmSEQ.P1AWG, 1, ...
    2, ...
    2047, 2047, 'DEER_XY8N_SegStruct_I.txt', 'false');
pause(1); % this pause seems to be important, otherwise the loading is not right occassionally
chaseFunctionPool('CreateSegments', gmSEQ.P1AWG, 2, ...
    2, ...
    2047, 2047, 'DEER_XY8N_SegStruct_Q.txt', 'false');
pause(1); % this pause seems to be important, otherwise the loading is not right occassionally
chaseFunctionPool('CreateSegments', gmSEQ.MWAWG, 1, ...
    2, ...
    2047, 2047, 'DEER_XY8N_P1_SegStruct_I.txt', 'false');
pause(1); % this pause seems to be important, otherwise the loading is not right occassionally
chaseFunctionPool('CreateSegments', gmSEQ.MWAWG, 2, ...
    2, ...
    2047, 2047, 'DEER_XY8N_P1_SegStruct_Q.txt', 'false');
pause(1); % this pause seems to be important, otherwise the loading is not right occassionally

%% Run waveform
chaseFunctionPool('runChase', gmSEQ.MWAWG, 'false'); pause(1);
chaseFunctionPool('runChase', gmSEQ.P1AWG, 'false'); pause(1);
ApplyDelays();

function Squeezing_T2XY8_SwpDetN
global gmSEQ gSG gSG2
gSG.bfixedPow=1;
gSG.bfixedFreq=1;
gSG.bMod='IQ';
gSG.bModSrc='External';

gSG2.bMod='IQ';
gSG2.bModSrc='External';
SignalGeneratorFunctionPool2('SetMod');
SignalGeneratorFunctionPool2('WritePow');
SignalGeneratorFunctionPool2('WriteFreq');
gSG2.bOn=1; SignalGeneratorFunctionPool2('RFOnOff');

% gSG3.bMod='IQ';
% gSG3.bModSrc='External';
% SignalGeneratorFunctionPool3('SetMod');
% SignalGeneratorFunctionPool3('WritePow');
% SignalGeneratorFunctionPool3('WriteFreq');
% gSG3.bOn=1; SignalGeneratorFunctionPool3('RFOnOff');

% Add more tomographical measurements later. 
% gmSEQ.Ntomo = 2;

% Parameters. Need to be binded with the variables provided by the GUI
gmSEQ.DEERhalfpi = gmSEQ.pi/2;
gmSEQ.DEERhalfpi = gmSEQ.DEERpi/2;
Pi = max(gmSEQ.pi, gmSEQ.DEERpi);
HalfPi = max(gmSEQ.DEERhalfpi, gmSEQ.DEERhalfpi);

SquInterval = gmSEQ.SLockT1; % XY8 interval to generate the squeezing
SquN = round(gmSEQ.SLockT2); % XY8 number
SquTime = SquN * (SquInterval + gmSEQ.DEERpi)*8;

DetInterval = gmSEQ.SLockT1_M;
DetN = round(gmSEQ.m);
DetTime = gmSEQ.DEERhalfpi + DetN * (DetInterval + Pi)*8 + gmSEQ.DEERhalfpi;
RotTime = gmSEQ.DEERt;
AfterPi = 2000;
AfterLaser = 100e3; 
Wait_p = 0.1e6;
Detect_Window = 5000;


Sig_D_start = Wait_p+gmSEQ.readout+AfterLaser+gmSEQ.DEERhalfpi+SquTime+RotTime+DetTime+AfterPi+Detect_Window+Wait_p;

gmSEQ.CHN(1).PBN=PBDictionary('ctr0');
gmSEQ.CHN(1).NRise=4;
gmSEQ.CHN(1).T=[Wait_p+gmSEQ.readout-1000-gmSEQ.CtrGateDur, ...
    Wait_p+gmSEQ.readout+AfterLaser+gmSEQ.DEERhalfpi+SquTime+RotTime+DetTime+AfterPi, ...
    Sig_D_start+gmSEQ.readout-1000-gmSEQ.CtrGateDur, ... 
    Sig_D_start+gmSEQ.readout+AfterLaser+gmSEQ.DEERhalfpi+SquTime+RotTime+DetTime+AfterPi];
if strcmp(gmSEQ.meas,'SPCM')
    gmSEQ.CHN(1).DT=[gmSEQ.CtrGateDur gmSEQ.CtrGateDur gmSEQ.CtrGateDur gmSEQ.CtrGateDur];
elseif strcmp(gmSEQ.meas,'APD')
    gmSEQ.CHN(1).DT=[1000 1000 1000 1000];
end

gmSEQ.CHN(numel(gmSEQ.CHN)+1).PBN=PBDictionary('AOM');
gmSEQ.CHN(numel(gmSEQ.CHN)).NRise=4;
gmSEQ.CHN(numel(gmSEQ.CHN)).T = [Wait_p, Wait_p+gmSEQ.readout+AfterLaser+gmSEQ.DEERhalfpi+SquTime+RotTime+DetTime+AfterPi, ...
    Sig_D_start, Sig_D_start+gmSEQ.readout+AfterLaser+gmSEQ.DEERhalfpi+SquTime+RotTime+DetTime+AfterPi];
gmSEQ.CHN(numel(gmSEQ.CHN)).DT = [gmSEQ.readout Detect_Window gmSEQ.readout Detect_Window];

% MW for probe spin
gmSEQ.CHN(numel(gmSEQ.CHN)+1).PBN=PBDictionary('AWGTrig2');
gmSEQ.CHN(numel(gmSEQ.CHN)).NRise=2;
gmSEQ.CHN(numel(gmSEQ.CHN)).T=[Wait_p+gmSEQ.readout+AfterLaser+gmSEQ.DEERhalfpi+SquTime+RotTime, Sig_D_start+gmSEQ.readout+AfterLaser+gmSEQ.DEERhalfpi+SquTime+RotTime];
gmSEQ.CHN(numel(gmSEQ.CHN)).DT=repelem(DetTime+200, 2);

% MW for squeezed spin
gmSEQ.CHN(numel(gmSEQ.CHN)+1).PBN=PBDictionary('AWGTrig');
gmSEQ.CHN(numel(gmSEQ.CHN)).NRise=2;
gmSEQ.CHN(numel(gmSEQ.CHN)).T=[Wait_p+gmSEQ.readout+AfterLaser, Sig_D_start+gmSEQ.readout+AfterLaser];
gmSEQ.CHN(numel(gmSEQ.CHN)).DT=repelem(gmSEQ.DEERhalfpi+SquTime+RotTime+DetTime+200, 2);

% MW for probe spin
gmSEQ.CHN(numel(gmSEQ.CHN)+1).PBN=PBDictionary('MWSwitch2');
if DetN == 0
    gmSEQ.CHN(numel(gmSEQ.CHN)).NRise=2;
    gmSEQ.CHN(numel(gmSEQ.CHN)).T = [Wait_p+gmSEQ.readout+AfterLaser+gmSEQ.DEERhalfpi+SquTime+RotTime-16, Sig_D_start+gmSEQ.readout+AfterLaser+gmSEQ.DEERhalfpi+SquTime+RotTime-16];
    gmSEQ.CHN(numel(gmSEQ.CHN)).DT = repelem(gmSEQ.DEERhalfpi+gmSEQ.DEERhalfpi+36, 2);
else
    gmSEQ.CHN(numel(gmSEQ.CHN)).NRise=2*(8*DetN + 2);
    gmSEQ.CHN(numel(gmSEQ.CHN)).T = zeros(1, gmSEQ.CHN(numel(gmSEQ.CHN)).NRise);
    gmSEQ.CHN(numel(gmSEQ.CHN)).T(1) = Wait_p+gmSEQ.readout+AfterLaser+gmSEQ.DEERhalfpi+SquTime+RotTime-16;
    for i = 1:DetN
        for j = 1:8
            gmSEQ.CHN(numel(gmSEQ.CHN)).T(1+(i-1)*8+j) = Wait_p+gmSEQ.readout+AfterLaser+gmSEQ.DEERhalfpi+SquTime+RotTime+gmSEQ.DEERhalfpi+DetInterval/2+(8*(i-1)+j-1)*(DetInterval + Pi)-20;
        end
    end
    gmSEQ.CHN(numel(gmSEQ.CHN)).T(1+8*DetN+1) = Wait_p+gmSEQ.readout+AfterLaser+gmSEQ.DEERhalfpi+SquTime+RotTime+gmSEQ.DEERhalfpi+DetN*(DetInterval+Pi)*8-20;
    gmSEQ.CHN(numel(gmSEQ.CHN)).T(1+8*DetN+2) = Sig_D_start+gmSEQ.readout+AfterLaser+gmSEQ.DEERhalfpi+SquTime+RotTime-16;
    for i = 1:DetN
        for j = 1:8
            gmSEQ.CHN(numel(gmSEQ.CHN)).T(3+8*DetN+(i-1)*8+j) = Sig_D_start+gmSEQ.readout+AfterLaser+gmSEQ.DEERhalfpi+SquTime+RotTime+gmSEQ.DEERhalfpi+DetInterval/2+(8*(i-1)+j-1)*(DetInterval + Pi)-20;
        end
    end
    gmSEQ.CHN(numel(gmSEQ.CHN)).T(3+16*DetN+1) = Sig_D_start+gmSEQ.readout+AfterLaser+gmSEQ.DEERhalfpi+SquTime+RotTime+gmSEQ.DEERhalfpi+DetN*(DetInterval+Pi)*8-20;
    gmSEQ.CHN(numel(gmSEQ.CHN)).DT=[gmSEQ.DEERhalfpi+36, repelem(Pi+40, 8*DetN), gmSEQ.DEERhalfpi+40, ... 
        gmSEQ.DEERhalfpi+36, repelem(Pi+40, 8*DetN), gmSEQ.DEERhalfpi+40];    
end


% MW for squeezed spin
gmSEQ.CHN(numel(gmSEQ.CHN)+1).PBN=PBDictionary('MWSwitch');
gmSEQ.CHN(numel(gmSEQ.CHN)).NRise=2*(8*SquN + 8*DetN + 2);
gmSEQ.CHN(numel(gmSEQ.CHN)).T = zeros(1, gmSEQ.CHN(numel(gmSEQ.CHN)).NRise);
gmSEQ.CHN(numel(gmSEQ.CHN)).T(1) = Wait_p+gmSEQ.readout+AfterLaser-20;
for i = 1:SquN
    for j = 1:8
        gmSEQ.CHN(numel(gmSEQ.CHN)).T(1+(i-1)*8+j) = Wait_p+gmSEQ.readout+AfterLaser+gmSEQ.DEERhalfpi+SquInterval/2+((i-1)*8+j-1)*(SquInterval+gmSEQ.DEERpi)-20;
    end
end
gmSEQ.CHN(numel(gmSEQ.CHN)).T(2+SquN*8) = Wait_p+gmSEQ.readout+AfterLaser+gmSEQ.DEERhalfpi+SquTime-24;
for i = 1:DetN
    for j = 1:8
        gmSEQ.CHN(numel(gmSEQ.CHN)).T(2+SquN*8+(i-1)*8+j) = Wait_p+gmSEQ.readout+AfterLaser+gmSEQ.DEERhalfpi+SquTime+RotTime+gmSEQ.DEERhalfpi+DetInterval/2+(8*(i-1)+j-1)*(DetInterval+Pi)-20;
    end
end
gmSEQ.CHN(numel(gmSEQ.CHN)).T(8*SquN+8*DetN+3) = Sig_D_start+gmSEQ.readout+AfterLaser-20;
for i = 1:SquN
    for j = 1:8
        gmSEQ.CHN(numel(gmSEQ.CHN)).T(8*SquN+8*DetN+3+(i-1)*8+j) = Sig_D_start+gmSEQ.readout+AfterLaser+gmSEQ.DEERhalfpi+SquInterval/2+((i-1)*8+j-1)*(SquInterval+gmSEQ.DEERpi)-20;
    end
end
gmSEQ.CHN(numel(gmSEQ.CHN)).T(4+16*SquN+8*DetN) = Sig_D_start+gmSEQ.readout+AfterLaser+gmSEQ.DEERhalfpi+SquTime-24;
for i = 1:DetN
    for j = 1:8
        gmSEQ.CHN(numel(gmSEQ.CHN)).T(4+16*SquN+8*DetN+(i-1)*8+j) = Sig_D_start+gmSEQ.readout+AfterLaser+gmSEQ.DEERhalfpi+SquTime+RotTime+gmSEQ.DEERhalfpi+DetInterval/2+(8*(i-1)+j-1)*(DetInterval+Pi)-20;
    end
end
gmSEQ.CHN(numel(gmSEQ.CHN)).DT=[gmSEQ.DEERhalfpi+40, repelem(gmSEQ.DEERpi+40, 8*SquN), RotTime+44,  repelem(Pi+40, 8*DetN), ... 
    gmSEQ.DEERhalfpi+40, repelem(gmSEQ.DEERpi+40, 8*SquN), RotTime+44,  repelem(Pi+40, 8*DetN)];

gmSEQ.CHN(numel(gmSEQ.CHN)+1).PBN=PBDictionary('dummy1');
gmSEQ.CHN(numel(gmSEQ.CHN)).NRise=2;
gmSEQ.CHN(numel(gmSEQ.CHN)).T=[0 2*(Sig_D_start-Wait_p)-50];
gmSEQ.CHN(numel(gmSEQ.CHN)).DT=[50 50];

%% AWG
% Initialization
chaseFunctionPool('stopChase',  gmSEQ.MWAWG)
chaseFunctionPool('stopChase',  gmSEQ.P1AWG)

% This part need to be modified to accomodate the DC modulation
if ~gSG.ACmodAWG % in AC modulation mode
    gSG.AWGFreq = 0;
    gSG2.AWGFreq = 0;
end

% probe spin
WaveForm_1I = zeros(2 + 8*DetN, 5);
WaveForm_1I(1, :) = [0 gmSEQ.DEERhalfpi gSG2.AWGFreq 0 gSG2.AWGAmp];
for i = 1:DetN
    WaveForm_1I(1 + (i-1)*8 + 1, :) = [gmSEQ.DEERhalfpi+DetInterval/2+(8*(i-1)+0)*(DetInterval+Pi) gmSEQ.DEERhalfpi+DetInterval/2+(8*(i-1)+0)*(DetInterval+Pi)+gmSEQ.pi gSG2.AWGFreq 0 gSG2.AWGAmp]; % pi_x
    WaveForm_1I(1 + (i-1)*8 + 2, :) = [gmSEQ.DEERhalfpi+DetInterval/2+(8*(i-1)+1)*(DetInterval+Pi) gmSEQ.DEERhalfpi+DetInterval/2+(8*(i-1)+1)*(DetInterval+Pi)+gmSEQ.pi gSG2.AWGFreq pi/2 gSG2.AWGAmp]; % pi_y
    WaveForm_1I(1 + (i-1)*8 + 3, :) = [gmSEQ.DEERhalfpi+DetInterval/2+(8*(i-1)+2)*(DetInterval+Pi) gmSEQ.DEERhalfpi+DetInterval/2+(8*(i-1)+2)*(DetInterval+Pi)+gmSEQ.pi gSG2.AWGFreq 0 gSG2.AWGAmp]; % pi_x
    WaveForm_1I(1 + (i-1)*8 + 4, :) = [gmSEQ.DEERhalfpi+DetInterval/2+(8*(i-1)+3)*(DetInterval+Pi) gmSEQ.DEERhalfpi+DetInterval/2+(8*(i-1)+3)*(DetInterval+Pi)+gmSEQ.pi gSG2.AWGFreq pi/2 gSG2.AWGAmp]; % pi_y
    WaveForm_1I(1 + (i-1)*8 + 5, :) = [gmSEQ.DEERhalfpi+DetInterval/2+(8*(i-1)+4)*(DetInterval+Pi) gmSEQ.DEERhalfpi+DetInterval/2+(8*(i-1)+4)*(DetInterval+Pi)+gmSEQ.pi gSG2.AWGFreq pi/2 gSG2.AWGAmp]; % pi_y
    WaveForm_1I(1 + (i-1)*8 + 6, :) = [gmSEQ.DEERhalfpi+DetInterval/2+(8*(i-1)+5)*(DetInterval+Pi) gmSEQ.DEERhalfpi+DetInterval/2+(8*(i-1)+5)*(DetInterval+Pi)+gmSEQ.pi gSG2.AWGFreq 0 gSG2.AWGAmp]; % pi_x
    WaveForm_1I(1 + (i-1)*8 + 7, :) = [gmSEQ.DEERhalfpi+DetInterval/2+(8*(i-1)+6)*(DetInterval+Pi) gmSEQ.DEERhalfpi+DetInterval/2+(8*(i-1)+6)*(DetInterval+Pi)+gmSEQ.pi gSG2.AWGFreq pi/2 gSG2.AWGAmp]; % pi_y
    WaveForm_1I(1 + (i-1)*8 + 8, :) = [gmSEQ.DEERhalfpi+DetInterval/2+(8*(i-1)+7)*(DetInterval+Pi) gmSEQ.DEERhalfpi+DetInterval/2+(8*(i-1)+7)*(DetInterval+Pi)+gmSEQ.pi gSG2.AWGFreq 0 gSG2.AWGAmp]; % pi_x
end
WaveForm_1I(2 + 8*DetN, :) = [gmSEQ.DEERhalfpi+8*DetN*(DetInterval+Pi) gmSEQ.DEERhalfpi+8*DetN*(DetInterval+Pi)+gmSEQ.DEERhalfpi gSG2.AWGFreq pi gSG2.AWGAmp];
% WaveForm_1I(2 + 8*gmSEQ.m, :) = [HalfPi+gmSEQ.m*Cycle HalfPi+gmSEQ.m*Cycle+gmSEQ.DEERhalfpi gSG2.AWGFreq pi 0];

WaveForm_1Q = WaveForm_1I - repmat([0 0 0 pi/2 0], size(WaveForm_1I, 1), 1);
WaveForm_1Length = ceil((gmSEQ.DEERhalfpi+8*DetN*(DetInterval+Pi)+gmSEQ.DEERhalfpi+1000) / (16 / gSG2.P1AWGClockRate)) ...
    *(16 / gSG2.P1AWGClockRate);
WaveForm_1PointNum = WaveForm_1Length * gSG2.P1AWGClockRate;

WaveForm_2I = WaveForm_1I;
WaveForm_2I(size(WaveForm_1I, 1), 4) = 0; % Differential measurement
WaveForm_2Q = WaveForm_1Q;
WaveForm_2Q(size(WaveForm_1I, 1), 4) = -pi/2; % Differential measurement
WaveForm_2Length = WaveForm_1Length;
WaveForm_2PointNum = WaveForm_2Length * gSG2.P1AWGClockRate;

% Squeezed spin
WaveForm_3I = zeros(2 + 8*SquN + 8*DetN, 5);
WaveForm_3I(1, :) = [0 gmSEQ.DEERhalfpi gSG.AWGFreq 0 gSG.AWGAmp];
for i = 1:SquN
    WaveForm_3I(1 + (i-1)*8 + 1, :) = [gmSEQ.DEERhalfpi+SquInterval/2+(8*(i-1)+0)*(SquInterval+gmSEQ.DEERpi) gmSEQ.DEERhalfpi+SquInterval/2+(8*(i-1)+0)*(SquInterval+gmSEQ.DEERpi)+gmSEQ.DEERpi gSG.AWGFreq 0 gSG.AWGAmp]; % pi_x
    WaveForm_3I(1 + (i-1)*8 + 2, :) = [gmSEQ.DEERhalfpi+SquInterval/2+(8*(i-1)+1)*(SquInterval+gmSEQ.DEERpi) gmSEQ.DEERhalfpi+SquInterval/2+(8*(i-1)+1)*(SquInterval+gmSEQ.DEERpi)+gmSEQ.DEERpi gSG.AWGFreq pi/2 gSG.AWGAmp]; % pi_y
    WaveForm_3I(1 + (i-1)*8 + 3, :) = [gmSEQ.DEERhalfpi+SquInterval/2+(8*(i-1)+2)*(SquInterval+gmSEQ.DEERpi) gmSEQ.DEERhalfpi+SquInterval/2+(8*(i-1)+2)*(SquInterval+gmSEQ.DEERpi)+gmSEQ.DEERpi gSG.AWGFreq 0 gSG.AWGAmp]; % pi_x
    WaveForm_3I(1 + (i-1)*8 + 4, :) = [gmSEQ.DEERhalfpi+SquInterval/2+(8*(i-1)+3)*(SquInterval+gmSEQ.DEERpi) gmSEQ.DEERhalfpi+SquInterval/2+(8*(i-1)+3)*(SquInterval+gmSEQ.DEERpi)+gmSEQ.DEERpi gSG.AWGFreq pi/2 gSG.AWGAmp]; % pi_y
    WaveForm_3I(1 + (i-1)*8 + 5, :) = [gmSEQ.DEERhalfpi+SquInterval/2+(8*(i-1)+4)*(SquInterval+gmSEQ.DEERpi) gmSEQ.DEERhalfpi+SquInterval/2+(8*(i-1)+4)*(SquInterval+gmSEQ.DEERpi)+gmSEQ.DEERpi gSG.AWGFreq pi/2 gSG.AWGAmp]; % pi_y
    WaveForm_3I(1 + (i-1)*8 + 6, :) = [gmSEQ.DEERhalfpi+SquInterval/2+(8*(i-1)+5)*(SquInterval+gmSEQ.DEERpi) gmSEQ.DEERhalfpi+SquInterval/2+(8*(i-1)+5)*(SquInterval+gmSEQ.DEERpi)+gmSEQ.DEERpi gSG.AWGFreq 0 gSG.AWGAmp]; % pi_x
    WaveForm_3I(1 + (i-1)*8 + 7, :) = [gmSEQ.DEERhalfpi+SquInterval/2+(8*(i-1)+6)*(SquInterval+gmSEQ.DEERpi) gmSEQ.DEERhalfpi+SquInterval/2+(8*(i-1)+6)*(SquInterval+gmSEQ.DEERpi)+gmSEQ.DEERpi gSG.AWGFreq pi/2 gSG.AWGAmp]; % pi_y
    WaveForm_3I(1 + (i-1)*8 + 8, :) = [gmSEQ.DEERhalfpi+SquInterval/2+(8*(i-1)+7)*(SquInterval+gmSEQ.DEERpi) gmSEQ.DEERhalfpi+SquInterval/2+(8*(i-1)+7)*(SquInterval+gmSEQ.DEERpi)+gmSEQ.DEERpi gSG.AWGFreq 0 gSG.AWGAmp]; % pi_x
end
WaveForm_3I(2 + 8*SquN, :) = [gmSEQ.DEERhalfpi+SquTime gmSEQ.DEERhalfpi+SquTime+RotTime gSG.AWGFreq pi/2 gSG.AWGAmp]; % theta pulse along y direction
for i = 1:DetN
    WaveForm_3I(2 + 8*SquN + (i-1)*8 + 1, :) = [gmSEQ.DEERhalfpi+SquTime+RotTime+gmSEQ.DEERhalfpi+DetInterval/2+(8*(i-1)+0)*(DetInterval+Pi) gmSEQ.DEERhalfpi+SquTime+RotTime+gmSEQ.DEERhalfpi+DetInterval/2+(8*(i-1)+0)*(DetInterval+Pi)+gmSEQ.DEERpi gSG.AWGFreq 0 gSG.AWGAmp]; % pi_x
    WaveForm_3I(2 + 8*SquN + (i-1)*8 + 2, :) = [gmSEQ.DEERhalfpi+SquTime+RotTime+gmSEQ.DEERhalfpi+DetInterval/2+(8*(i-1)+1)*(DetInterval+Pi) gmSEQ.DEERhalfpi+SquTime+RotTime+gmSEQ.DEERhalfpi+DetInterval/2+(8*(i-1)+1)*(DetInterval+Pi)+gmSEQ.DEERpi gSG.AWGFreq pi/2 gSG.AWGAmp]; % pi_y
    WaveForm_3I(2 + 8*SquN + (i-1)*8 + 3, :) = [gmSEQ.DEERhalfpi+SquTime+RotTime+gmSEQ.DEERhalfpi+DetInterval/2+(8*(i-1)+2)*(DetInterval+Pi) gmSEQ.DEERhalfpi+SquTime+RotTime+gmSEQ.DEERhalfpi+DetInterval/2+(8*(i-1)+2)*(DetInterval+Pi)+gmSEQ.DEERpi gSG.AWGFreq 0 gSG.AWGAmp]; % pi_x
    WaveForm_3I(2 + 8*SquN + (i-1)*8 + 4, :) = [gmSEQ.DEERhalfpi+SquTime+RotTime+gmSEQ.DEERhalfpi+DetInterval/2+(8*(i-1)+3)*(DetInterval+Pi) gmSEQ.DEERhalfpi+SquTime+RotTime+gmSEQ.DEERhalfpi+DetInterval/2+(8*(i-1)+3)*(DetInterval+Pi)+gmSEQ.DEERpi gSG.AWGFreq pi/2 gSG.AWGAmp]; % pi_y
    WaveForm_3I(2 + 8*SquN + (i-1)*8 + 5, :) = [gmSEQ.DEERhalfpi+SquTime+RotTime+gmSEQ.DEERhalfpi+DetInterval/2+(8*(i-1)+4)*(DetInterval+Pi) gmSEQ.DEERhalfpi+SquTime+RotTime+gmSEQ.DEERhalfpi+DetInterval/2+(8*(i-1)+4)*(DetInterval+Pi)+gmSEQ.DEERpi gSG.AWGFreq pi/2 gSG.AWGAmp]; % pi_y
    WaveForm_3I(2 + 8*SquN + (i-1)*8 + 6, :) = [gmSEQ.DEERhalfpi+SquTime+RotTime+gmSEQ.DEERhalfpi+DetInterval/2+(8*(i-1)+5)*(DetInterval+Pi) gmSEQ.DEERhalfpi+SquTime+RotTime+gmSEQ.DEERhalfpi+DetInterval/2+(8*(i-1)+5)*(DetInterval+Pi)+gmSEQ.DEERpi gSG.AWGFreq 0 gSG.AWGAmp]; % pi_x
    WaveForm_3I(2 + 8*SquN + (i-1)*8 + 7, :) = [gmSEQ.DEERhalfpi+SquTime+RotTime+gmSEQ.DEERhalfpi+DetInterval/2+(8*(i-1)+6)*(DetInterval+Pi) gmSEQ.DEERhalfpi+SquTime+RotTime+gmSEQ.DEERhalfpi+DetInterval/2+(8*(i-1)+6)*(DetInterval+Pi)+gmSEQ.DEERpi gSG.AWGFreq pi/2 gSG.AWGAmp]; % pi_y
    WaveForm_3I(2 + 8*SquN + (i-1)*8 + 8, :) = [gmSEQ.DEERhalfpi+SquTime+RotTime+gmSEQ.DEERhalfpi+DetInterval/2+(8*(i-1)+7)*(DetInterval+Pi) gmSEQ.DEERhalfpi+SquTime+RotTime+gmSEQ.DEERhalfpi+DetInterval/2+(8*(i-1)+7)*(DetInterval+Pi)+gmSEQ.DEERpi gSG.AWGFreq 0 gSG.AWGAmp]; % pi_x
end

WaveForm_3Q = WaveForm_3I - repmat([0 0 0 pi/2 0], size(WaveForm_3I, 1), 1);
WaveForm_3Length = ceil((gmSEQ.DEERhalfpi+SquTime+RotTime+gmSEQ.DEERhalfpi+8*DetN*(DetInterval+Pi)+1000) / (16 / gSG.AWGClockRate)) ...
    *(16 / gSG.AWGClockRate);
WaveForm_3PointNum = WaveForm_3Length * gSG.AWGClockRate;

chaseFunctionPool('createWaveform', WaveForm_1I, gSG2.P1AWGClockRate, WaveForm_1Length, 'Squeezing_T2XY8_I_seg1.txt'); pause(0.5);
chaseFunctionPool('createWaveform', WaveForm_1Q, gSG2.P1AWGClockRate, WaveForm_1Length, 'Squeezing_T2XY8_Q_seg1.txt'); pause(0.5);
chaseFunctionPool('createWaveform', WaveForm_2I, gSG2.P1AWGClockRate, WaveForm_2Length, 'Squeezing_T2XY8_I_seg2.txt'); pause(0.5);
chaseFunctionPool('createWaveform', WaveForm_2Q, gSG2.P1AWGClockRate, WaveForm_2Length, 'Squeezing_T2XY8_Q_seg2.txt'); pause(0.5);
chaseFunctionPool('createWaveform', WaveForm_3I, gSG.AWGClockRate, WaveForm_3Length, 'Squeezing_T2XY8_I_seg3.txt'); pause(0.5);
chaseFunctionPool('createWaveform', WaveForm_3Q, gSG.AWGClockRate, WaveForm_3Length, 'Squeezing_T2XY8_Q_seg3.txt'); pause(0.5);

chaseFunctionPool('createSegStruct', 'Squeezing_T2XY8_SegStruct_I.txt', ...
    'Squeezing_T2XY8_I_seg1.txt', WaveForm_1PointNum, 1, 1, ...
    'Squeezing_T2XY8_I_seg2.txt', WaveForm_2PointNum, 1, 1);
pause(0.5);
chaseFunctionPool('createSegStruct', 'Squeezing_T2XY8_SegStruct_Q.txt', ...
    'Squeezing_T2XY8_Q_seg1.txt', WaveForm_1PointNum, 1, 1, ...
    'Squeezing_T2XY8_Q_seg2.txt', WaveForm_2PointNum, 1, 1);
pause(0.5);
chaseFunctionPool('createSegStruct', 'Squeezing_T2XY8_2_SegStruct_I.txt', ...
    'Squeezing_T2XY8_I_seg3.txt', WaveForm_3PointNum, 1, 1, ...
    'Squeezing_T2XY8_I_seg3.txt', WaveForm_3PointNum, 1, 1);
pause(0.5);
chaseFunctionPool('createSegStruct', 'Squeezing_T2XY8_2_SegStruct_Q.txt', ...
    'Squeezing_T2XY8_Q_seg3.txt', WaveForm_3PointNum, 1, 1, ...
    'Squeezing_T2XY8_Q_seg3.txt', WaveForm_3PointNum, 1, 1);
pause(0.5);

%% Load waveform to AWG
chaseFunctionPool('CreateSegments', gmSEQ.P1AWG, 1, ...
    2, ...
    2047, 2047, 'Squeezing_T2XY8_SegStruct_I.txt', 'false');
pause(1); % this pause seems to be important, otherwise the loading is not right occassionally
chaseFunctionPool('CreateSegments', gmSEQ.P1AWG, 2, ...
    2, ...
    2047, 2047, 'Squeezing_T2XY8_SegStruct_Q.txt', 'false');
pause(1); % this pause seems to be important, otherwise the loading is not right occassionally
chaseFunctionPool('CreateSegments', gmSEQ.MWAWG, 1, ...
    2, ...
    2047, 2047, 'Squeezing_T2XY8_2_SegStruct_I.txt', 'false');
pause(1); % this pause seems to be important, otherwise the loading is not right occassionally
chaseFunctionPool('CreateSegments', gmSEQ.MWAWG, 2, ...
    2, ...
    2047, 2047, 'Squeezing_T2XY8_2_SegStruct_Q.txt', 'false');
pause(1); % this pause seems to be important, otherwise the loading is not right occassionally

%% Run waveform
chaseFunctionPool('runChase', gmSEQ.MWAWG, 'false'); pause(1);
chaseFunctionPool('runChase', gmSEQ.P1AWG, 'false'); pause(1);
ApplyDelays();

function Squeezing_T2XY8_SwpTheta
global gmSEQ gSG gSG2
gSG.bfixedPow=1;
gSG.bfixedFreq=1;
gSG.bMod='IQ';
gSG.bModSrc='External';

gSG2.bMod='IQ';
gSG2.bModSrc='External';
SignalGeneratorFunctionPool2('SetMod');
SignalGeneratorFunctionPool2('WritePow');
SignalGeneratorFunctionPool2('WriteFreq');
gSG2.bOn=1; SignalGeneratorFunctionPool2('RFOnOff');

% gSG3.bMod='IQ';
% gSG3.bModSrc='External';
% SignalGeneratorFunctionPool3('SetMod');
% SignalGeneratorFunctionPool3('WritePow');
% SignalGeneratorFunctionPool3('WriteFreq');
% gSG3.bOn=1; SignalGeneratorFunctionPool3('RFOnOff');

% Add more tomographical measurements later. 
% gmSEQ.Ntomo = 2;

% Parameters. Need to be binded with the variables provided by the GUI
gmSEQ.DEERhalfpi = gmSEQ.pi/2;
gmSEQ.DEERhalfpi = gmSEQ.DEERpi/2;
Pi = max(gmSEQ.pi, gmSEQ.DEERpi);
HalfPi = max(gmSEQ.DEERhalfpi, gmSEQ.DEERhalfpi);

SquInterval = gmSEQ.SLockT1; % XY8 interval to generate the squeezing
SquN = round(gmSEQ.SLockT2); % XY8 number
SquTime = SquN * (SquInterval + gmSEQ.DEERpi)*8;

DetInterval = gmSEQ.SLockT1_M;
DetN = round(gmSEQ.SLockT2_M);
DetTime = gmSEQ.DEERhalfpi + DetN * (DetInterval + Pi)*8 + gmSEQ.DEERhalfpi;
RotTime = gmSEQ.m;
AfterPi = 2000;
AfterLaser = 100e3; 
Wait_p = 0.1e6;
Detect_Window = 5000;

Sig_D_start = Wait_p+gmSEQ.readout+AfterLaser+gmSEQ.DEERhalfpi+SquTime+RotTime+DetTime+AfterPi+Detect_Window+Wait_p;

gmSEQ.CHN(1).PBN=PBDictionary('ctr0');
gmSEQ.CHN(1).NRise=4;
gmSEQ.CHN(1).T=[Wait_p+gmSEQ.readout-1000-gmSEQ.CtrGateDur, ...
    Wait_p+gmSEQ.readout+AfterLaser+gmSEQ.DEERhalfpi+SquTime+RotTime+DetTime+AfterPi, ...
    Sig_D_start+gmSEQ.readout-1000-gmSEQ.CtrGateDur, ... 
    Sig_D_start+gmSEQ.readout+AfterLaser+gmSEQ.DEERhalfpi+SquTime+RotTime+DetTime+AfterPi];
if strcmp(gmSEQ.meas,'SPCM')
    gmSEQ.CHN(1).DT=[gmSEQ.CtrGateDur gmSEQ.CtrGateDur gmSEQ.CtrGateDur gmSEQ.CtrGateDur];
elseif strcmp(gmSEQ.meas,'APD')
    gmSEQ.CHN(1).DT=[1000 1000 1000 1000];
end

gmSEQ.CHN(numel(gmSEQ.CHN)+1).PBN=PBDictionary('AOM');
gmSEQ.CHN(numel(gmSEQ.CHN)).NRise=4;
gmSEQ.CHN(numel(gmSEQ.CHN)).T = [Wait_p, Wait_p+gmSEQ.readout+AfterLaser+gmSEQ.DEERhalfpi+SquTime+RotTime+DetTime+AfterPi, ...
    Sig_D_start, Sig_D_start+gmSEQ.readout+AfterLaser+gmSEQ.DEERhalfpi+SquTime+RotTime+DetTime+AfterPi];
gmSEQ.CHN(numel(gmSEQ.CHN)).DT = [gmSEQ.readout Detect_Window gmSEQ.readout Detect_Window];

% MW for probe spin
gmSEQ.CHN(numel(gmSEQ.CHN)+1).PBN=PBDictionary('AWGTrig2');
gmSEQ.CHN(numel(gmSEQ.CHN)).NRise=2;
gmSEQ.CHN(numel(gmSEQ.CHN)).T=[Wait_p+gmSEQ.readout+AfterLaser+gmSEQ.DEERhalfpi+SquTime+RotTime, Sig_D_start+gmSEQ.readout+AfterLaser+gmSEQ.DEERhalfpi+SquTime+RotTime];
gmSEQ.CHN(numel(gmSEQ.CHN)).DT=repelem(DetTime+200, 2);

% MW for squeezed spin
gmSEQ.CHN(numel(gmSEQ.CHN)+1).PBN=PBDictionary('AWGTrig');
gmSEQ.CHN(numel(gmSEQ.CHN)).NRise=2;
gmSEQ.CHN(numel(gmSEQ.CHN)).T=[Wait_p+gmSEQ.readout+AfterLaser, Sig_D_start+gmSEQ.readout+AfterLaser];
gmSEQ.CHN(numel(gmSEQ.CHN)).DT=repelem(gmSEQ.DEERhalfpi+SquTime+RotTime+DetTime+200, 2);

% MW for probe spin
gmSEQ.CHN(numel(gmSEQ.CHN)+1).PBN=PBDictionary('MWSwitch2');
if DetN == 0
    gmSEQ.CHN(numel(gmSEQ.CHN)).NRise=2;
    gmSEQ.CHN(numel(gmSEQ.CHN)).T = [Wait_p+gmSEQ.readout+AfterLaser+gmSEQ.DEERhalfpi+SquTime+RotTime-16, Sig_D_start+gmSEQ.readout+AfterLaser+gmSEQ.DEERhalfpi+SquTime+RotTime-16];
    gmSEQ.CHN(numel(gmSEQ.CHN)).DT = repelem(gmSEQ.DEERhalfpi+gmSEQ.DEERhalfpi+36, 2);
else
    gmSEQ.CHN(numel(gmSEQ.CHN)).NRise=2*(8*DetN + 2);
    gmSEQ.CHN(numel(gmSEQ.CHN)).T = zeros(1, gmSEQ.CHN(numel(gmSEQ.CHN)).NRise);
    gmSEQ.CHN(numel(gmSEQ.CHN)).T(1) = Wait_p+gmSEQ.readout+AfterLaser+gmSEQ.DEERhalfpi+SquTime+RotTime-16;
    for i = 1:DetN
        for j = 1:8
            gmSEQ.CHN(numel(gmSEQ.CHN)).T(1+(i-1)*8+j) = Wait_p+gmSEQ.readout+AfterLaser+gmSEQ.DEERhalfpi+SquTime+RotTime+gmSEQ.DEERhalfpi+DetInterval/2+(8*(i-1)+j-1)*(DetInterval + Pi)-20;
        end
    end
    gmSEQ.CHN(numel(gmSEQ.CHN)).T(1+8*DetN+1) = Wait_p+gmSEQ.readout+AfterLaser+gmSEQ.DEERhalfpi+SquTime+RotTime+gmSEQ.DEERhalfpi+DetN*(DetInterval+Pi)*8-20;
    gmSEQ.CHN(numel(gmSEQ.CHN)).T(1+8*DetN+2) = Sig_D_start+gmSEQ.readout+AfterLaser+gmSEQ.DEERhalfpi+SquTime+RotTime-16;
    for i = 1:DetN
        for j = 1:8
            gmSEQ.CHN(numel(gmSEQ.CHN)).T(3+8*DetN+(i-1)*8+j) = Sig_D_start+gmSEQ.readout+AfterLaser+gmSEQ.DEERhalfpi+SquTime+RotTime+gmSEQ.DEERhalfpi+DetInterval/2+(8*(i-1)+j-1)*(DetInterval + Pi)-20;
        end
    end
    gmSEQ.CHN(numel(gmSEQ.CHN)).T(3+16*DetN+1) = Sig_D_start+gmSEQ.readout+AfterLaser+gmSEQ.DEERhalfpi+SquTime+RotTime+gmSEQ.DEERhalfpi+DetN*(DetInterval+Pi)*8-20;
    gmSEQ.CHN(numel(gmSEQ.CHN)).DT=[gmSEQ.DEERhalfpi+36, repelem(Pi+40, 8*DetN), gmSEQ.DEERhalfpi+40, ... 
        gmSEQ.DEERhalfpi+36, repelem(Pi+40, 8*DetN), gmSEQ.DEERhalfpi+40];    
end


% MW for squeezed spin
gmSEQ.CHN(numel(gmSEQ.CHN)+1).PBN=PBDictionary('MWSwitch');
gmSEQ.CHN(numel(gmSEQ.CHN)).NRise=2*(8*SquN + 8*DetN + 2);
gmSEQ.CHN(numel(gmSEQ.CHN)).T = zeros(1, gmSEQ.CHN(numel(gmSEQ.CHN)).NRise);
gmSEQ.CHN(numel(gmSEQ.CHN)).T(1) = Wait_p+gmSEQ.readout+AfterLaser-20;
for i = 1:SquN
    for j = 1:8
        gmSEQ.CHN(numel(gmSEQ.CHN)).T(1+(i-1)*8+j) = Wait_p+gmSEQ.readout+AfterLaser+gmSEQ.DEERhalfpi+SquInterval/2+((i-1)*8+j-1)*(SquInterval+gmSEQ.DEERpi)-20;
    end
end
gmSEQ.CHN(numel(gmSEQ.CHN)).T(2+SquN*8) = Wait_p+gmSEQ.readout+AfterLaser+gmSEQ.DEERhalfpi+SquTime-24;
for i = 1:DetN
    for j = 1:8
        gmSEQ.CHN(numel(gmSEQ.CHN)).T(2+SquN*8+(i-1)*8+j) = Wait_p+gmSEQ.readout+AfterLaser+gmSEQ.DEERhalfpi+SquTime+RotTime+gmSEQ.DEERhalfpi+DetInterval/2+(8*(i-1)+j-1)*(DetInterval+Pi)-20;
    end
end
gmSEQ.CHN(numel(gmSEQ.CHN)).T(8*SquN+8*DetN+3) = Sig_D_start+gmSEQ.readout+AfterLaser-20;
for i = 1:SquN
    for j = 1:8
        gmSEQ.CHN(numel(gmSEQ.CHN)).T(8*SquN+8*DetN+3+(i-1)*8+j) = Sig_D_start+gmSEQ.readout+AfterLaser+gmSEQ.DEERhalfpi+SquInterval/2+((i-1)*8+j-1)*(SquInterval+gmSEQ.DEERpi)-20;
    end
end
gmSEQ.CHN(numel(gmSEQ.CHN)).T(4+16*SquN+8*DetN) = Sig_D_start+gmSEQ.readout+AfterLaser+gmSEQ.DEERhalfpi+SquTime-24;
for i = 1:DetN
    for j = 1:8
        gmSEQ.CHN(numel(gmSEQ.CHN)).T(4+16*SquN+8*DetN+(i-1)*8+j) = Sig_D_start+gmSEQ.readout+AfterLaser+gmSEQ.DEERhalfpi+SquTime+RotTime+gmSEQ.DEERhalfpi+DetInterval/2+(8*(i-1)+j-1)*(DetInterval+Pi)-20;
    end
end
gmSEQ.CHN(numel(gmSEQ.CHN)).DT=[gmSEQ.DEERhalfpi+40, repelem(gmSEQ.DEERpi+40, 8*SquN), RotTime+44,  repelem(Pi+40, 8*DetN), ... 
    gmSEQ.DEERhalfpi+40, repelem(gmSEQ.DEERpi+40, 8*SquN), RotTime+44,  repelem(Pi+40, 8*DetN)];

gmSEQ.CHN(numel(gmSEQ.CHN)+1).PBN=PBDictionary('dummy1');
gmSEQ.CHN(numel(gmSEQ.CHN)).NRise=2;
gmSEQ.CHN(numel(gmSEQ.CHN)).T=[0 2*(Sig_D_start-Wait_p)-50];
gmSEQ.CHN(numel(gmSEQ.CHN)).DT=[50 50];

%% AWG
% Initialization
chaseFunctionPool('stopChase',  gmSEQ.MWAWG)
chaseFunctionPool('stopChase',  gmSEQ.P1AWG)

% This part need to be modified to accomodate the DC modulation
if ~gSG.ACmodAWG % in AC modulation mode
    gSG.AWGFreq = 0;
    gSG2.AWGFreq = 0;
end

% probe spin
WaveForm_1I = zeros(2 + 8*DetN, 5);
WaveForm_1I(1, :) = [0 gmSEQ.DEERhalfpi gSG2.AWGFreq 0 gSG2.AWGAmp];
for i = 1:DetN
    WaveForm_1I(1 + (i-1)*8 + 1, :) = [gmSEQ.DEERhalfpi+DetInterval/2+(8*(i-1)+0)*(DetInterval+Pi) gmSEQ.DEERhalfpi+DetInterval/2+(8*(i-1)+0)*(DetInterval+Pi)+gmSEQ.pi gSG2.AWGFreq 0 gSG2.AWGAmp]; % pi_x
    WaveForm_1I(1 + (i-1)*8 + 2, :) = [gmSEQ.DEERhalfpi+DetInterval/2+(8*(i-1)+1)*(DetInterval+Pi) gmSEQ.DEERhalfpi+DetInterval/2+(8*(i-1)+1)*(DetInterval+Pi)+gmSEQ.pi gSG2.AWGFreq pi/2 gSG2.AWGAmp]; % pi_y
    WaveForm_1I(1 + (i-1)*8 + 3, :) = [gmSEQ.DEERhalfpi+DetInterval/2+(8*(i-1)+2)*(DetInterval+Pi) gmSEQ.DEERhalfpi+DetInterval/2+(8*(i-1)+2)*(DetInterval+Pi)+gmSEQ.pi gSG2.AWGFreq 0 gSG2.AWGAmp]; % pi_x
    WaveForm_1I(1 + (i-1)*8 + 4, :) = [gmSEQ.DEERhalfpi+DetInterval/2+(8*(i-1)+3)*(DetInterval+Pi) gmSEQ.DEERhalfpi+DetInterval/2+(8*(i-1)+3)*(DetInterval+Pi)+gmSEQ.pi gSG2.AWGFreq pi/2 gSG2.AWGAmp]; % pi_y
    WaveForm_1I(1 + (i-1)*8 + 5, :) = [gmSEQ.DEERhalfpi+DetInterval/2+(8*(i-1)+4)*(DetInterval+Pi) gmSEQ.DEERhalfpi+DetInterval/2+(8*(i-1)+4)*(DetInterval+Pi)+gmSEQ.pi gSG2.AWGFreq pi/2 gSG2.AWGAmp]; % pi_y
    WaveForm_1I(1 + (i-1)*8 + 6, :) = [gmSEQ.DEERhalfpi+DetInterval/2+(8*(i-1)+5)*(DetInterval+Pi) gmSEQ.DEERhalfpi+DetInterval/2+(8*(i-1)+5)*(DetInterval+Pi)+gmSEQ.pi gSG2.AWGFreq 0 gSG2.AWGAmp]; % pi_x
    WaveForm_1I(1 + (i-1)*8 + 7, :) = [gmSEQ.DEERhalfpi+DetInterval/2+(8*(i-1)+6)*(DetInterval+Pi) gmSEQ.DEERhalfpi+DetInterval/2+(8*(i-1)+6)*(DetInterval+Pi)+gmSEQ.pi gSG2.AWGFreq pi/2 gSG2.AWGAmp]; % pi_y
    WaveForm_1I(1 + (i-1)*8 + 8, :) = [gmSEQ.DEERhalfpi+DetInterval/2+(8*(i-1)+7)*(DetInterval+Pi) gmSEQ.DEERhalfpi+DetInterval/2+(8*(i-1)+7)*(DetInterval+Pi)+gmSEQ.pi gSG2.AWGFreq 0 gSG2.AWGAmp]; % pi_x
end
WaveForm_1I(2 + 8*DetN, :) = [gmSEQ.DEERhalfpi+8*DetN*(DetInterval+Pi) gmSEQ.DEERhalfpi+8*DetN*(DetInterval+Pi)+gmSEQ.DEERhalfpi gSG2.AWGFreq pi gSG2.AWGAmp];
% WaveForm_1I(2 + 8*gmSEQ.m, :) = [HalfPi+gmSEQ.m*Cycle HalfPi+gmSEQ.m*Cycle+gmSEQ.DEERhalfpi gSG2.AWGFreq pi 0];

WaveForm_1Q = WaveForm_1I - repmat([0 0 0 pi/2 0], size(WaveForm_1I, 1), 1);
WaveForm_1Length = ceil((gmSEQ.DEERhalfpi+8*DetN*(DetInterval+Pi)+gmSEQ.DEERhalfpi+1000) / (16 / gSG2.P1AWGClockRate)) ...
    *(16 / gSG2.P1AWGClockRate);
WaveForm_1PointNum = WaveForm_1Length * gSG2.P1AWGClockRate;

WaveForm_2I = WaveForm_1I;
WaveForm_2I(size(WaveForm_1I, 1), 4) = 0; % Differential measurement
WaveForm_2Q = WaveForm_1Q;
WaveForm_2Q(size(WaveForm_1I, 1), 4) = -pi/2; % Differential measurement
WaveForm_2Length = WaveForm_1Length;
WaveForm_2PointNum = WaveForm_2Length * gSG2.P1AWGClockRate;

% Squeezed spin
WaveForm_3I = zeros(2 + 8*SquN + 8*DetN, 5);
WaveForm_3I(1, :) = [0 gmSEQ.DEERhalfpi gSG.AWGFreq 0 gSG.AWGAmp];
for i = 1:SquN
    WaveForm_3I(1 + (i-1)*8 + 1, :) = [gmSEQ.DEERhalfpi+SquInterval/2+(8*(i-1)+0)*(SquInterval+gmSEQ.DEERpi) gmSEQ.DEERhalfpi+SquInterval/2+(8*(i-1)+0)*(SquInterval+gmSEQ.DEERpi)+gmSEQ.DEERpi gSG.AWGFreq 0 gSG.AWGAmp]; % pi_x
    WaveForm_3I(1 + (i-1)*8 + 2, :) = [gmSEQ.DEERhalfpi+SquInterval/2+(8*(i-1)+1)*(SquInterval+gmSEQ.DEERpi) gmSEQ.DEERhalfpi+SquInterval/2+(8*(i-1)+1)*(SquInterval+gmSEQ.DEERpi)+gmSEQ.DEERpi gSG.AWGFreq pi/2 gSG.AWGAmp]; % pi_y
    WaveForm_3I(1 + (i-1)*8 + 3, :) = [gmSEQ.DEERhalfpi+SquInterval/2+(8*(i-1)+2)*(SquInterval+gmSEQ.DEERpi) gmSEQ.DEERhalfpi+SquInterval/2+(8*(i-1)+2)*(SquInterval+gmSEQ.DEERpi)+gmSEQ.DEERpi gSG.AWGFreq 0 gSG.AWGAmp]; % pi_x
    WaveForm_3I(1 + (i-1)*8 + 4, :) = [gmSEQ.DEERhalfpi+SquInterval/2+(8*(i-1)+3)*(SquInterval+gmSEQ.DEERpi) gmSEQ.DEERhalfpi+SquInterval/2+(8*(i-1)+3)*(SquInterval+gmSEQ.DEERpi)+gmSEQ.DEERpi gSG.AWGFreq pi/2 gSG.AWGAmp]; % pi_y
    WaveForm_3I(1 + (i-1)*8 + 5, :) = [gmSEQ.DEERhalfpi+SquInterval/2+(8*(i-1)+4)*(SquInterval+gmSEQ.DEERpi) gmSEQ.DEERhalfpi+SquInterval/2+(8*(i-1)+4)*(SquInterval+gmSEQ.DEERpi)+gmSEQ.DEERpi gSG.AWGFreq pi/2 gSG.AWGAmp]; % pi_y
    WaveForm_3I(1 + (i-1)*8 + 6, :) = [gmSEQ.DEERhalfpi+SquInterval/2+(8*(i-1)+5)*(SquInterval+gmSEQ.DEERpi) gmSEQ.DEERhalfpi+SquInterval/2+(8*(i-1)+5)*(SquInterval+gmSEQ.DEERpi)+gmSEQ.DEERpi gSG.AWGFreq 0 gSG.AWGAmp]; % pi_x
    WaveForm_3I(1 + (i-1)*8 + 7, :) = [gmSEQ.DEERhalfpi+SquInterval/2+(8*(i-1)+6)*(SquInterval+gmSEQ.DEERpi) gmSEQ.DEERhalfpi+SquInterval/2+(8*(i-1)+6)*(SquInterval+gmSEQ.DEERpi)+gmSEQ.DEERpi gSG.AWGFreq pi/2 gSG.AWGAmp]; % pi_y
    WaveForm_3I(1 + (i-1)*8 + 8, :) = [gmSEQ.DEERhalfpi+SquInterval/2+(8*(i-1)+7)*(SquInterval+gmSEQ.DEERpi) gmSEQ.DEERhalfpi+SquInterval/2+(8*(i-1)+7)*(SquInterval+gmSEQ.DEERpi)+gmSEQ.DEERpi gSG.AWGFreq 0 gSG.AWGAmp]; % pi_x
end
WaveForm_3I(2 + 8*SquN, :) = [gmSEQ.DEERhalfpi+SquTime gmSEQ.DEERhalfpi+SquTime+RotTime gSG.AWGFreq pi/2 gSG.AWGAmp]; % theta pulse along y direction
for i = 1:DetN
    WaveForm_3I(2 + 8*SquN + (i-1)*8 + 1, :) = [gmSEQ.DEERhalfpi+SquTime+RotTime+gmSEQ.DEERhalfpi+DetInterval/2+(8*(i-1)+0)*(DetInterval+Pi) gmSEQ.DEERhalfpi+SquTime+RotTime+gmSEQ.DEERhalfpi+DetInterval/2+(8*(i-1)+0)*(DetInterval+Pi)+gmSEQ.DEERpi gSG.AWGFreq 0 gSG.AWGAmp]; % pi_x
    WaveForm_3I(2 + 8*SquN + (i-1)*8 + 2, :) = [gmSEQ.DEERhalfpi+SquTime+RotTime+gmSEQ.DEERhalfpi+DetInterval/2+(8*(i-1)+1)*(DetInterval+Pi) gmSEQ.DEERhalfpi+SquTime+RotTime+gmSEQ.DEERhalfpi+DetInterval/2+(8*(i-1)+1)*(DetInterval+Pi)+gmSEQ.DEERpi gSG.AWGFreq pi/2 gSG.AWGAmp]; % pi_y
    WaveForm_3I(2 + 8*SquN + (i-1)*8 + 3, :) = [gmSEQ.DEERhalfpi+SquTime+RotTime+gmSEQ.DEERhalfpi+DetInterval/2+(8*(i-1)+2)*(DetInterval+Pi) gmSEQ.DEERhalfpi+SquTime+RotTime+gmSEQ.DEERhalfpi+DetInterval/2+(8*(i-1)+2)*(DetInterval+Pi)+gmSEQ.DEERpi gSG.AWGFreq 0 gSG.AWGAmp]; % pi_x
    WaveForm_3I(2 + 8*SquN + (i-1)*8 + 4, :) = [gmSEQ.DEERhalfpi+SquTime+RotTime+gmSEQ.DEERhalfpi+DetInterval/2+(8*(i-1)+3)*(DetInterval+Pi) gmSEQ.DEERhalfpi+SquTime+RotTime+gmSEQ.DEERhalfpi+DetInterval/2+(8*(i-1)+3)*(DetInterval+Pi)+gmSEQ.DEERpi gSG.AWGFreq pi/2 gSG.AWGAmp]; % pi_y
    WaveForm_3I(2 + 8*SquN + (i-1)*8 + 5, :) = [gmSEQ.DEERhalfpi+SquTime+RotTime+gmSEQ.DEERhalfpi+DetInterval/2+(8*(i-1)+4)*(DetInterval+Pi) gmSEQ.DEERhalfpi+SquTime+RotTime+gmSEQ.DEERhalfpi+DetInterval/2+(8*(i-1)+4)*(DetInterval+Pi)+gmSEQ.DEERpi gSG.AWGFreq pi/2 gSG.AWGAmp]; % pi_y
    WaveForm_3I(2 + 8*SquN + (i-1)*8 + 6, :) = [gmSEQ.DEERhalfpi+SquTime+RotTime+gmSEQ.DEERhalfpi+DetInterval/2+(8*(i-1)+5)*(DetInterval+Pi) gmSEQ.DEERhalfpi+SquTime+RotTime+gmSEQ.DEERhalfpi+DetInterval/2+(8*(i-1)+5)*(DetInterval+Pi)+gmSEQ.DEERpi gSG.AWGFreq 0 gSG.AWGAmp]; % pi_x
    WaveForm_3I(2 + 8*SquN + (i-1)*8 + 7, :) = [gmSEQ.DEERhalfpi+SquTime+RotTime+gmSEQ.DEERhalfpi+DetInterval/2+(8*(i-1)+6)*(DetInterval+Pi) gmSEQ.DEERhalfpi+SquTime+RotTime+gmSEQ.DEERhalfpi+DetInterval/2+(8*(i-1)+6)*(DetInterval+Pi)+gmSEQ.DEERpi gSG.AWGFreq pi/2 gSG.AWGAmp]; % pi_y
    WaveForm_3I(2 + 8*SquN + (i-1)*8 + 8, :) = [gmSEQ.DEERhalfpi+SquTime+RotTime+gmSEQ.DEERhalfpi+DetInterval/2+(8*(i-1)+7)*(DetInterval+Pi) gmSEQ.DEERhalfpi+SquTime+RotTime+gmSEQ.DEERhalfpi+DetInterval/2+(8*(i-1)+7)*(DetInterval+Pi)+gmSEQ.DEERpi gSG.AWGFreq 0 gSG.AWGAmp]; % pi_x
end

WaveForm_3Q = WaveForm_3I - repmat([0 0 0 pi/2 0], size(WaveForm_3I, 1), 1);
WaveForm_3Length = ceil((gmSEQ.DEERhalfpi+SquTime+RotTime+gmSEQ.DEERhalfpi+8*DetN*(DetInterval+Pi)+1000) / (16 / gSG.AWGClockRate)) ...
    *(16 / gSG.AWGClockRate);
WaveForm_3PointNum = WaveForm_3Length * gSG.AWGClockRate;

chaseFunctionPool('createWaveform', WaveForm_1I, gSG2.P1AWGClockRate, WaveForm_1Length, 'Squeezing_T2XY8_I_seg1.txt'); pause(0.5);
chaseFunctionPool('createWaveform', WaveForm_1Q, gSG2.P1AWGClockRate, WaveForm_1Length, 'Squeezing_T2XY8_Q_seg1.txt'); pause(0.5);
chaseFunctionPool('createWaveform', WaveForm_2I, gSG2.P1AWGClockRate, WaveForm_2Length, 'Squeezing_T2XY8_I_seg2.txt'); pause(0.5);
chaseFunctionPool('createWaveform', WaveForm_2Q, gSG2.P1AWGClockRate, WaveForm_2Length, 'Squeezing_T2XY8_Q_seg2.txt'); pause(0.5);
chaseFunctionPool('createWaveform', WaveForm_3I, gSG.AWGClockRate, WaveForm_3Length, 'Squeezing_T2XY8_I_seg3.txt'); pause(0.5);
chaseFunctionPool('createWaveform', WaveForm_3Q, gSG.AWGClockRate, WaveForm_3Length, 'Squeezing_T2XY8_Q_seg3.txt'); pause(0.5);

chaseFunctionPool('createSegStruct', 'Squeezing_T2XY8_SegStruct_I.txt', ...
    'Squeezing_T2XY8_I_seg1.txt', WaveForm_1PointNum, 1, 1, ...
    'Squeezing_T2XY8_I_seg2.txt', WaveForm_2PointNum, 1, 1);
pause(0.5);
chaseFunctionPool('createSegStruct', 'Squeezing_T2XY8_SegStruct_Q.txt', ...
    'Squeezing_T2XY8_Q_seg1.txt', WaveForm_1PointNum, 1, 1, ...
    'Squeezing_T2XY8_Q_seg2.txt', WaveForm_2PointNum, 1, 1);
pause(0.5);
chaseFunctionPool('createSegStruct', 'Squeezing_T2XY8_2_SegStruct_I.txt', ...
    'Squeezing_T2XY8_I_seg3.txt', WaveForm_3PointNum, 1, 1, ...
    'Squeezing_T2XY8_I_seg3.txt', WaveForm_3PointNum, 1, 1);
pause(0.5);
chaseFunctionPool('createSegStruct', 'Squeezing_T2XY8_2_SegStruct_Q.txt', ...
    'Squeezing_T2XY8_Q_seg3.txt', WaveForm_3PointNum, 1, 1, ...
    'Squeezing_T2XY8_Q_seg3.txt', WaveForm_3PointNum, 1, 1);
pause(0.5);

%% Load waveform to AWG
chaseFunctionPool('CreateSegments', gmSEQ.P1AWG, 1, ...
    2, ...
    2047, 2047, 'Squeezing_T2XY8_SegStruct_I.txt', 'false');
pause(1); % this pause seems to be important, otherwise the loading is not right occassionally
chaseFunctionPool('CreateSegments', gmSEQ.P1AWG, 2, ...
    2, ...
    2047, 2047, 'Squeezing_T2XY8_SegStruct_Q.txt', 'false');
pause(1); % this pause seems to be important, otherwise the loading is not right occassionally
chaseFunctionPool('CreateSegments', gmSEQ.MWAWG, 1, ...
    2, ...
    2047, 2047, 'Squeezing_T2XY8_2_SegStruct_I.txt', 'false');
pause(1); % this pause seems to be important, otherwise the loading is not right occassionally
chaseFunctionPool('CreateSegments', gmSEQ.MWAWG, 2, ...
    2, ...
    2047, 2047, 'Squeezing_T2XY8_2_SegStruct_Q.txt', 'false');
pause(1); % this pause seems to be important, otherwise the loading is not right occassionally

%% Run waveform
chaseFunctionPool('runChase', gmSEQ.MWAWG, 'false'); pause(1);
chaseFunctionPool('runChase', gmSEQ.P1AWG, 'false'); pause(1);
ApplyDelays();

function Squeezing_Double_T2XY8_SwpDetN
global gmSEQ gSG gSG2 gSG3
gSG.bfixedPow=1;
gSG.bfixedFreq=1;
gSG.bMod='IQ';
gSG.bModSrc='External';

gSG2.bMod='IQ';
gSG2.bModSrc='External';
SignalGeneratorFunctionPool2('SetMod');
SignalGeneratorFunctionPool2('WritePow');
SignalGeneratorFunctionPool2('WriteFreq');
gSG2.bOn=1; SignalGeneratorFunctionPool2('RFOnOff');

gSG3.bMod='IQ';
gSG3.bModSrc='External';
SignalGeneratorFunctionPool3('SetMod');
SignalGeneratorFunctionPool3('WritePow');
SignalGeneratorFunctionPool3('WriteFreq');
gSG3.bOn=1; SignalGeneratorFunctionPool3('RFOnOff');

% Add more tomographical measurements later. 
% gmSEQ.Ntomo = 2;

% Parameters. Need to be binded with the variables provided by the GUI
gmSEQ.halfpi = gmSEQ.pi/2;
gmSEQ.DEERhalfpi = gmSEQ.DEERpi/2;
% Pi = max(gmSEQ.pi, gmSEQ.pi);
% HalfPi = max(gmSEQ.halfpi, gmSEQ.halfpi);

SquInterval = gmSEQ.SLockT1; % XY8 interval to generate the squeezing
SquN = round(gmSEQ.SLockT2); % XY8 number
SquTime = SquN * (SquInterval + gmSEQ.pi)*8;
SquAmp = gmSEQ.SAmp1;

PulseGap = 2;
DetInterval = gmSEQ.SLockT1_M;
DetN = round(gmSEQ.m);
DetUnit = DetInterval + 3*gmSEQ.pi + 2*PulseGap;
DetTime = gmSEQ.DEERhalfpi + DetN * DetUnit*8 + gmSEQ.DEERhalfpi;
RotAngle = gmSEQ.DEERt;
RotTime = gmSEQ.DEERpi + PulseGap + gmSEQ.pi;
AfterPi = 2000;
AfterLaser = 100e3; 
Wait_p = 0.1e6;
Detect_Window = 5000;
MWBuffer = 10;

Sig_D_start = Wait_p+gmSEQ.readout+AfterLaser+gmSEQ.halfpi+SquTime+RotTime+DetTime+AfterPi+Detect_Window+Wait_p;

gmSEQ.CHN(1).PBN=PBDictionary('ctr0');
gmSEQ.CHN(1).NRise=4;
gmSEQ.CHN(1).T=[Wait_p+gmSEQ.readout-1000-gmSEQ.CtrGateDur, ...
    Wait_p+gmSEQ.readout+AfterLaser+gmSEQ.halfpi+SquTime+RotTime+DetTime+AfterPi, ...
    Sig_D_start+gmSEQ.readout-1000-gmSEQ.CtrGateDur, ... 
    Sig_D_start+gmSEQ.readout+AfterLaser+gmSEQ.halfpi+SquTime+RotTime+DetTime+AfterPi];
if strcmp(gmSEQ.meas,'SPCM')
    gmSEQ.CHN(1).DT=[gmSEQ.CtrGateDur gmSEQ.CtrGateDur gmSEQ.CtrGateDur gmSEQ.CtrGateDur];
elseif strcmp(gmSEQ.meas,'APD')
    gmSEQ.CHN(1).DT=[1000 1000 1000 1000];
end

gmSEQ.CHN(numel(gmSEQ.CHN)+1).PBN=PBDictionary('AOM');
gmSEQ.CHN(numel(gmSEQ.CHN)).NRise=4;
gmSEQ.CHN(numel(gmSEQ.CHN)).T = [Wait_p, Wait_p+gmSEQ.readout+AfterLaser+gmSEQ.halfpi+SquTime+RotTime+DetTime+AfterPi, ...
    Sig_D_start, Sig_D_start+gmSEQ.readout+AfterLaser+gmSEQ.halfpi+SquTime+RotTime+DetTime+AfterPi];
gmSEQ.CHN(numel(gmSEQ.CHN)).DT = [gmSEQ.readout Detect_Window gmSEQ.readout Detect_Window];

% MW for probe spin
gmSEQ.CHN(numel(gmSEQ.CHN)+1).PBN=PBDictionary('AWGTrig2');
gmSEQ.CHN(numel(gmSEQ.CHN)).NRise=2;
gmSEQ.CHN(numel(gmSEQ.CHN)).T=[Wait_p+gmSEQ.readout+AfterLaser+gmSEQ.halfpi+SquTime+RotTime, Sig_D_start+gmSEQ.readout+AfterLaser+gmSEQ.halfpi+SquTime+RotTime];
gmSEQ.CHN(numel(gmSEQ.CHN)).DT=repelem(DetTime+200, 2);

% MW for squeezed spin
gmSEQ.CHN(numel(gmSEQ.CHN)+1).PBN=PBDictionary('AWGTrig');
gmSEQ.CHN(numel(gmSEQ.CHN)).NRise=2;
gmSEQ.CHN(numel(gmSEQ.CHN)).T=[Wait_p+gmSEQ.readout+AfterLaser, Sig_D_start+gmSEQ.readout+AfterLaser];
gmSEQ.CHN(numel(gmSEQ.CHN)).DT=repelem(gmSEQ.halfpi+SquTime+RotTime+DetTime+200, 2);

% MW for squeezed spin 2
% Start the triggers of the probe spin at the same time
gmSEQ.CHN(numel(gmSEQ.CHN)+1).PBN=PBDictionary('AWGTrig3');
gmSEQ.CHN(numel(gmSEQ.CHN)).NRise=2;
gmSEQ.CHN(numel(gmSEQ.CHN)).T=[Wait_p+gmSEQ.readout+AfterLaser, Sig_D_start+gmSEQ.readout+AfterLaser];
gmSEQ.CHN(numel(gmSEQ.CHN)).DT=repelem(gmSEQ.halfpi+SquTime+RotTime+DetTime+200, 2);

% MW for probe spin
gmSEQ.CHN(numel(gmSEQ.CHN)+1).PBN=PBDictionary('MWSwitch2');
if DetN == 0
    gmSEQ.CHN(numel(gmSEQ.CHN)).NRise=2;
    gmSEQ.CHN(numel(gmSEQ.CHN)).T = [Wait_p+gmSEQ.readout+AfterLaser+gmSEQ.halfpi+SquTime+RotTime-MWBuffer, Sig_D_start+gmSEQ.readout+AfterLaser+gmSEQ.halfpi+SquTime+RotTime-MWBuffer];
    gmSEQ.CHN(numel(gmSEQ.CHN)).DT = repelem(gmSEQ.DEERhalfpi+gmSEQ.DEERhalfpi+2*MWBuffer, 2);
else
    gmSEQ.CHN(numel(gmSEQ.CHN)).NRise=2*(8*DetN + 2);
    gmSEQ.CHN(numel(gmSEQ.CHN)).T = zeros(1, gmSEQ.CHN(numel(gmSEQ.CHN)).NRise);
    gmSEQ.CHN(numel(gmSEQ.CHN)).T(1) = Wait_p+gmSEQ.readout+AfterLaser+gmSEQ.halfpi+SquTime+RotTime-MWBuffer;
    for i = 1:DetN
        for j = 1:8
            gmSEQ.CHN(numel(gmSEQ.CHN)).T(1+(i-1)*8+j) = Wait_p+gmSEQ.readout+AfterLaser+gmSEQ.halfpi+SquTime+RotTime+gmSEQ.DEERhalfpi+DetInterval/2+(8*(i-1)+j-1)*DetUnit-MWBuffer;
        end
    end
    gmSEQ.CHN(numel(gmSEQ.CHN)).T(1+8*DetN+1) = Wait_p+gmSEQ.readout+AfterLaser+gmSEQ.halfpi+SquTime+RotTime+gmSEQ.DEERhalfpi+DetN*DetUnit*8-MWBuffer;
    gmSEQ.CHN(numel(gmSEQ.CHN)).T(1+8*DetN+2) = Sig_D_start+gmSEQ.readout+AfterLaser+gmSEQ.halfpi+SquTime+RotTime-MWBuffer;
    for i = 1:DetN
        for j = 1:8
            gmSEQ.CHN(numel(gmSEQ.CHN)).T(3+8*DetN+(i-1)*8+j) = Sig_D_start+gmSEQ.readout+AfterLaser+gmSEQ.halfpi+SquTime+RotTime+gmSEQ.DEERhalfpi+DetInterval/2+(8*(i-1)+j-1)*DetUnit-MWBuffer;
        end
    end
    gmSEQ.CHN(numel(gmSEQ.CHN)).T(3+16*DetN+1) = Sig_D_start+gmSEQ.readout+AfterLaser+gmSEQ.halfpi+SquTime+RotTime+gmSEQ.DEERhalfpi+DetN*DetUnit*8-MWBuffer;
    gmSEQ.CHN(numel(gmSEQ.CHN)).DT=[gmSEQ.DEERhalfpi+2*MWBuffer, repelem(3*gmSEQ.pi+2*PulseGap+2*MWBuffer, 8*DetN), gmSEQ.DEERhalfpi+2*MWBuffer, ... 
        gmSEQ.DEERhalfpi+2*MWBuffer, repelem(3*gmSEQ.pi+2*PulseGap+2*MWBuffer, 8*DetN), gmSEQ.DEERhalfpi+2*MWBuffer];    
end

% MW for squeezed spin
gmSEQ.CHN(numel(gmSEQ.CHN)+1).PBN=PBDictionary('MWSwitch');
gmSEQ.CHN(numel(gmSEQ.CHN)).NRise=2*(8*SquN + 8*DetN + 2);
gmSEQ.CHN(numel(gmSEQ.CHN)).T = zeros(1, gmSEQ.CHN(numel(gmSEQ.CHN)).NRise);
gmSEQ.CHN(numel(gmSEQ.CHN)).T(1) = Wait_p+gmSEQ.readout+AfterLaser-MWBuffer;
for i = 1:SquN
    for j = 1:8
        gmSEQ.CHN(numel(gmSEQ.CHN)).T(1+(i-1)*8+j) = Wait_p+gmSEQ.readout+AfterLaser+gmSEQ.halfpi+SquInterval/2+((i-1)*8+j-1)*(SquInterval+gmSEQ.pi)-MWBuffer;
    end
end
gmSEQ.CHN(numel(gmSEQ.CHN)).T(2+SquN*8) = Wait_p+gmSEQ.readout+AfterLaser+gmSEQ.halfpi+SquTime-MWBuffer;
for i = 1:DetN
    for j = 1:8
        gmSEQ.CHN(numel(gmSEQ.CHN)).T(2+SquN*8+(i-1)*8+j) = Wait_p+gmSEQ.readout+AfterLaser+gmSEQ.halfpi+SquTime+RotTime+gmSEQ.DEERhalfpi+DetInterval/2+(8*(i-1)+j-1)*DetUnit-MWBuffer;
    end
end
gmSEQ.CHN(numel(gmSEQ.CHN)).T(8*SquN+8*DetN+3) = Sig_D_start+gmSEQ.readout+AfterLaser-MWBuffer;
for i = 1:SquN
    for j = 1:8
        gmSEQ.CHN(numel(gmSEQ.CHN)).T(8*SquN+8*DetN+3+(i-1)*8+j) = Sig_D_start+gmSEQ.readout+AfterLaser+gmSEQ.halfpi+SquInterval/2+((i-1)*8+j-1)*(SquInterval+gmSEQ.pi)-MWBuffer;
    end
end
gmSEQ.CHN(numel(gmSEQ.CHN)).T(4+16*SquN+8*DetN) = Sig_D_start+gmSEQ.readout+AfterLaser+gmSEQ.halfpi+SquTime-MWBuffer;
for i = 1:DetN
    for j = 1:8
        gmSEQ.CHN(numel(gmSEQ.CHN)).T(4+16*SquN+8*DetN+(i-1)*8+j) = Sig_D_start+gmSEQ.readout+AfterLaser+gmSEQ.halfpi+SquTime+RotTime+gmSEQ.DEERhalfpi+DetInterval/2+(8*(i-1)+j-1)*DetUnit-MWBuffer;
    end
end
gmSEQ.CHN(numel(gmSEQ.CHN)).DT=[gmSEQ.halfpi+2*MWBuffer, repelem(gmSEQ.pi+2*MWBuffer, 8*SquN), RotTime+2*MWBuffer,  repelem(3*gmSEQ.pi+2*PulseGap+2*MWBuffer, 8*DetN), ... 
    gmSEQ.halfpi+2*MWBuffer, repelem(gmSEQ.pi+2*MWBuffer, 8*SquN), RotTime+2*MWBuffer,  repelem(3*gmSEQ.pi+2*PulseGap+2*MWBuffer, 8*DetN)];

% gmSEQ.CHN(numel(gmSEQ.CHN)+1).PBN=PBDictionary('MWSwitch');
% gmSEQ.CHN(numel(gmSEQ.CHN)).NRise=2*(8*DetN + 1);
% gmSEQ.CHN(numel(gmSEQ.CHN)).T = zeros(1, gmSEQ.CHN(numel(gmSEQ.CHN)).NRise);
% gmSEQ.CHN(numel(gmSEQ.CHN)).T(1) = Wait_p+gmSEQ.readout+AfterLaser-20;
% for i = 1:DetN
%     for j = 1:8
%         gmSEQ.CHN(numel(gmSEQ.CHN)).T(1+(i-1)*8+j) = Wait_p+gmSEQ.readout+AfterLaser+gmSEQ.halfpi+SquTime+RotTime+gmSEQ.halfpi+DetInterval/2+(8*(i-1)+j-1)*DetUnit-20;
%     end
% end
% gmSEQ.CHN(numel(gmSEQ.CHN)).T(8*DetN+2) = Sig_D_start+gmSEQ.readout+AfterLaser-20;
% for i = 1:DetN
%     for j = 1:8
%         gmSEQ.CHN(numel(gmSEQ.CHN)).T(8*DetN+2+(i-1)*8+j) = Sig_D_start+gmSEQ.readout+AfterLaser+gmSEQ.halfpi+SquTime+RotTime+gmSEQ.halfpi+DetInterval/2+(8*(i-1)+j-1)*DetUnit-20;
%     end
% end
% gmSEQ.CHN(numel(gmSEQ.CHN)).DT=[gmSEQ.halfpi+SquTime+RotAngle+40,  repelem(3*gmSEQ.pi+2*PulseGap+40, 8*DetN), gmSEQ.halfpi+SquTime+RotAngle+40,  repelem(3*gmSEQ.pi+2*PulseGap+40, 8*DetN)];

gmSEQ.CHN(numel(gmSEQ.CHN)+1).PBN=PBDictionary('MWSwitch3');
gmSEQ.CHN(numel(gmSEQ.CHN)).NRise=2*(8*DetN + 1);
gmSEQ.CHN(numel(gmSEQ.CHN)).T = zeros(1, gmSEQ.CHN(numel(gmSEQ.CHN)).NRise);
gmSEQ.CHN(numel(gmSEQ.CHN)).T(1) = Wait_p+gmSEQ.readout+AfterLaser+gmSEQ.halfpi+SquTime+gmSEQ.DEERpi+PulseGap-MWBuffer-2;
for i = 1:DetN
    for j = 1:8
        gmSEQ.CHN(numel(gmSEQ.CHN)).T(1+(i-1)*8+j) = Wait_p+gmSEQ.readout+AfterLaser+gmSEQ.halfpi+SquTime+RotTime+gmSEQ.DEERhalfpi+DetInterval/2+(8*(i-1)+j-1)*DetUnit-MWBuffer;
    end
end
gmSEQ.CHN(numel(gmSEQ.CHN)).T(2+8*DetN) = Sig_D_start+gmSEQ.readout+AfterLaser+gmSEQ.halfpi+SquTime+gmSEQ.DEERpi+PulseGap-MWBuffer-2;
for i = 1:DetN
    for j = 1:8
        gmSEQ.CHN(numel(gmSEQ.CHN)).T(2+8*DetN+(i-1)*8+j) = Sig_D_start+gmSEQ.readout+AfterLaser+gmSEQ.halfpi+SquTime+RotTime+gmSEQ.DEERhalfpi+DetInterval/2+(8*(i-1)+j-1)*DetUnit-MWBuffer;
    end
end
gmSEQ.CHN(numel(gmSEQ.CHN)).DT=[gmSEQ.pi+2*MWBuffer+8,  repelem(3*gmSEQ.pi+2*PulseGap+2*MWBuffer, 8*DetN), ... 
    gmSEQ.pi+2*MWBuffer+8,  repelem(3*gmSEQ.pi+2*PulseGap+2*MWBuffer, 8*DetN)];

gmSEQ.CHN(numel(gmSEQ.CHN)+1).PBN=PBDictionary('dummy1');
gmSEQ.CHN(numel(gmSEQ.CHN)).NRise=2;
gmSEQ.CHN(numel(gmSEQ.CHN)).T=[0 2*(Sig_D_start-Wait_p)-50];
gmSEQ.CHN(numel(gmSEQ.CHN)).DT=[50 50];

%% AWG
% Initialization
chaseFunctionPool('stopChase',  gmSEQ.MWAWG)
chaseFunctionPool('stopChase',  gmSEQ.P1AWG)
chaseFunctionPool('stopChase',  gmSEQ.MWAWG2)

% This part need to be modified to accomodate the DC modulation
if ~gSG.ACmodAWG % in AC modulation mode
    gSG.AWGFreq = 0;
    gSG2.AWGFreq = 0;
    gSG3.AWGFreq = 0;
end

% probe spin
ComposePi = 3*gmSEQ.pi+2*PulseGap;
if gmSEQ.DEERpi >= ComposePi
   warning("Probe pi pulse is too long. Sequence is incorrect.") 
end

if gmSEQ.m == 0
    WaveForm_1I = [0 2*gmSEQ.DEERhalfpi gSG2.AWGFreq 0 0];
else
    WaveForm_1I = zeros(2 + 8*DetN, 5);
    WaveForm_1I(1, :) = [0 gmSEQ.DEERhalfpi gSG2.AWGFreq 0 gSG2.AWGAmp];
    for i = 1:DetN
        WaveForm_1I(1 + (i-1)*8 + 1, :) = [gmSEQ.DEERhalfpi+DetInterval/2+(8*(i-1)+0)*DetUnit+(ComposePi-gmSEQ.DEERpi)/2 gmSEQ.DEERhalfpi+DetInterval/2+(8*(i-1)+0)*DetUnit+(ComposePi+gmSEQ.DEERpi)/2 gSG2.AWGFreq 0 gSG2.AWGAmp]; % pi_x
        WaveForm_1I(1 + (i-1)*8 + 2, :) = [gmSEQ.DEERhalfpi+DetInterval/2+(8*(i-1)+1)*DetUnit+(ComposePi-gmSEQ.DEERpi)/2 gmSEQ.DEERhalfpi+DetInterval/2+(8*(i-1)+1)*DetUnit+(ComposePi+gmSEQ.DEERpi)/2 gSG2.AWGFreq pi/2 gSG2.AWGAmp]; % pi_y
        WaveForm_1I(1 + (i-1)*8 + 3, :) = [gmSEQ.DEERhalfpi+DetInterval/2+(8*(i-1)+2)*DetUnit+(ComposePi-gmSEQ.DEERpi)/2 gmSEQ.DEERhalfpi+DetInterval/2+(8*(i-1)+2)*DetUnit+(ComposePi+gmSEQ.DEERpi)/2 gSG2.AWGFreq 0 gSG2.AWGAmp]; % pi_x
        WaveForm_1I(1 + (i-1)*8 + 4, :) = [gmSEQ.DEERhalfpi+DetInterval/2+(8*(i-1)+3)*DetUnit+(ComposePi-gmSEQ.DEERpi)/2 gmSEQ.DEERhalfpi+DetInterval/2+(8*(i-1)+3)*DetUnit+(ComposePi+gmSEQ.DEERpi)/2 gSG2.AWGFreq pi/2 gSG2.AWGAmp]; % pi_y
        WaveForm_1I(1 + (i-1)*8 + 5, :) = [gmSEQ.DEERhalfpi+DetInterval/2+(8*(i-1)+4)*DetUnit+(ComposePi-gmSEQ.DEERpi)/2 gmSEQ.DEERhalfpi+DetInterval/2+(8*(i-1)+4)*DetUnit+(ComposePi+gmSEQ.DEERpi)/2 gSG2.AWGFreq pi/2 gSG2.AWGAmp]; % pi_y
        WaveForm_1I(1 + (i-1)*8 + 6, :) = [gmSEQ.DEERhalfpi+DetInterval/2+(8*(i-1)+5)*DetUnit+(ComposePi-gmSEQ.DEERpi)/2 gmSEQ.DEERhalfpi+DetInterval/2+(8*(i-1)+5)*DetUnit+(ComposePi+gmSEQ.DEERpi)/2 gSG2.AWGFreq 0 gSG2.AWGAmp]; % pi_x
        WaveForm_1I(1 + (i-1)*8 + 7, :) = [gmSEQ.DEERhalfpi+DetInterval/2+(8*(i-1)+6)*DetUnit+(ComposePi-gmSEQ.DEERpi)/2 gmSEQ.DEERhalfpi+DetInterval/2+(8*(i-1)+6)*DetUnit+(ComposePi+gmSEQ.DEERpi)/2 gSG2.AWGFreq pi/2 gSG2.AWGAmp]; % pi_y
        WaveForm_1I(1 + (i-1)*8 + 8, :) = [gmSEQ.DEERhalfpi+DetInterval/2+(8*(i-1)+7)*DetUnit+(ComposePi-gmSEQ.DEERpi)/2 gmSEQ.DEERhalfpi+DetInterval/2+(8*(i-1)+7)*DetUnit+(ComposePi+gmSEQ.DEERpi)/2 gSG2.AWGFreq 0 gSG2.AWGAmp]; % pi_x
    end
    WaveForm_1I(2 + 8*DetN, :) = [gmSEQ.DEERhalfpi+8*DetN*DetUnit gmSEQ.DEERhalfpi+8*DetN*DetUnit+gmSEQ.DEERhalfpi gSG2.AWGFreq pi gSG2.AWGAmp];
end
WaveForm_1Q = WaveForm_1I - repmat([0 0 0 pi/2 0], size(WaveForm_1I, 1), 1);
WaveForm_1Length = ceil((gmSEQ.DEERhalfpi+8*DetN*DetUnit+gmSEQ.DEERhalfpi+1000) / (16 / gSG2.P1AWGClockRate)) ...
    *(16 / gSG2.P1AWGClockRate);
WaveForm_1PointNum = WaveForm_1Length * gSG2.P1AWGClockRate;

if gmSEQ.m == 0
    WaveForm_2I = [0 2*gmSEQ.DEERhalfpi gSG2.AWGFreq 0 gSG2.AWGAmp];
    WaveForm_2Q = WaveForm_2I - repmat([0 0 0 pi/2 0], size(WaveForm_2I, 1), 1);
else
    WaveForm_2I = WaveForm_1I;
    WaveForm_2I(size(WaveForm_1I, 1), 4) = 0; % Differential measurement
    WaveForm_2Q = WaveForm_1Q;
    WaveForm_2Q(size(WaveForm_1I, 1), 4) = -pi/2; % Differential measurement
end
WaveForm_2Length = WaveForm_1Length;
WaveForm_2PointNum = WaveForm_2Length * gSG2.P1AWGClockRate;

% Squeezed spin
WaveForm_3I = zeros(2 + 8*SquN + 8*DetN, 5);
WaveForm_3I(1, :) = [0 gmSEQ.halfpi gSG.AWGFreq 0 SquAmp];
% WaveForm_3I(1, :) = [0 gmSEQ.halfpi gSG.AWGFreq 0 gSG.AWGAmp];
for i = 1:SquN
    WaveForm_3I(1 + (i-1)*8 + 1, :) = [gmSEQ.halfpi+SquInterval/2+(8*(i-1)+0)*(SquInterval+gmSEQ.pi) gmSEQ.halfpi+SquInterval/2+(8*(i-1)+0)*(SquInterval+gmSEQ.pi)+gmSEQ.pi gSG.AWGFreq 0 SquAmp]; % pi_x
    WaveForm_3I(1 + (i-1)*8 + 2, :) = [gmSEQ.halfpi+SquInterval/2+(8*(i-1)+1)*(SquInterval+gmSEQ.pi) gmSEQ.halfpi+SquInterval/2+(8*(i-1)+1)*(SquInterval+gmSEQ.pi)+gmSEQ.pi gSG.AWGFreq pi/2 SquAmp]; % pi_y
    WaveForm_3I(1 + (i-1)*8 + 3, :) = [gmSEQ.halfpi+SquInterval/2+(8*(i-1)+2)*(SquInterval+gmSEQ.pi) gmSEQ.halfpi+SquInterval/2+(8*(i-1)+2)*(SquInterval+gmSEQ.pi)+gmSEQ.pi gSG.AWGFreq 0 SquAmp]; % pi_x
    WaveForm_3I(1 + (i-1)*8 + 4, :) = [gmSEQ.halfpi+SquInterval/2+(8*(i-1)+3)*(SquInterval+gmSEQ.pi) gmSEQ.halfpi+SquInterval/2+(8*(i-1)+3)*(SquInterval+gmSEQ.pi)+gmSEQ.pi gSG.AWGFreq pi/2 SquAmp]; % pi_y
    WaveForm_3I(1 + (i-1)*8 + 5, :) = [gmSEQ.halfpi+SquInterval/2+(8*(i-1)+4)*(SquInterval+gmSEQ.pi) gmSEQ.halfpi+SquInterval/2+(8*(i-1)+4)*(SquInterval+gmSEQ.pi)+gmSEQ.pi gSG.AWGFreq pi/2 SquAmp]; % pi_y
    WaveForm_3I(1 + (i-1)*8 + 6, :) = [gmSEQ.halfpi+SquInterval/2+(8*(i-1)+5)*(SquInterval+gmSEQ.pi) gmSEQ.halfpi+SquInterval/2+(8*(i-1)+5)*(SquInterval+gmSEQ.pi)+gmSEQ.pi gSG.AWGFreq 0 SquAmp]; % pi_x
    WaveForm_3I(1 + (i-1)*8 + 7, :) = [gmSEQ.halfpi+SquInterval/2+(8*(i-1)+6)*(SquInterval+gmSEQ.pi) gmSEQ.halfpi+SquInterval/2+(8*(i-1)+6)*(SquInterval+gmSEQ.pi)+gmSEQ.pi gSG.AWGFreq pi/2 SquAmp]; % pi_y
    WaveForm_3I(1 + (i-1)*8 + 8, :) = [gmSEQ.halfpi+SquInterval/2+(8*(i-1)+7)*(SquInterval+gmSEQ.pi) gmSEQ.halfpi+SquInterval/2+(8*(i-1)+7)*(SquInterval+gmSEQ.pi)+gmSEQ.pi gSG.AWGFreq 0 SquAmp]; % pi_x
end
WaveForm_3I(2 + 8*SquN, :) = [gmSEQ.halfpi+SquTime gmSEQ.halfpi+SquTime+RotAngle gSG.AWGFreq pi/2 SquAmp]; % theta pulse along y direction
for i = 1:DetN
    WaveForm_3I(2 + 8*SquN + (i-1)*8 + 1, :) = [gmSEQ.halfpi+SquTime+RotTime+gmSEQ.DEERhalfpi+DetInterval/2+(8*(i-1)+0)*DetUnit+gmSEQ.pi+PulseGap gmSEQ.halfpi+SquTime+RotTime+gmSEQ.DEERhalfpi+DetInterval/2+(8*(i-1)+0)*DetUnit+2*gmSEQ.pi+PulseGap gSG.AWGFreq 0 gSG.AWGAmp]; % pi_x
    WaveForm_3I(2 + 8*SquN + (i-1)*8 + 2, :) = [gmSEQ.halfpi+SquTime+RotTime+gmSEQ.DEERhalfpi+DetInterval/2+(8*(i-1)+1)*DetUnit+gmSEQ.pi+PulseGap gmSEQ.halfpi+SquTime+RotTime+gmSEQ.DEERhalfpi+DetInterval/2+(8*(i-1)+1)*DetUnit+2*gmSEQ.pi+PulseGap gSG.AWGFreq pi/2 gSG.AWGAmp]; % pi_y
    WaveForm_3I(2 + 8*SquN + (i-1)*8 + 3, :) = [gmSEQ.halfpi+SquTime+RotTime+gmSEQ.DEERhalfpi+DetInterval/2+(8*(i-1)+2)*DetUnit+gmSEQ.pi+PulseGap gmSEQ.halfpi+SquTime+RotTime+gmSEQ.DEERhalfpi+DetInterval/2+(8*(i-1)+2)*DetUnit+2*gmSEQ.pi+PulseGap gSG.AWGFreq 0 gSG.AWGAmp]; % pi_x
    WaveForm_3I(2 + 8*SquN + (i-1)*8 + 4, :) = [gmSEQ.halfpi+SquTime+RotTime+gmSEQ.DEERhalfpi+DetInterval/2+(8*(i-1)+3)*DetUnit+gmSEQ.pi+PulseGap gmSEQ.halfpi+SquTime+RotTime+gmSEQ.DEERhalfpi+DetInterval/2+(8*(i-1)+3)*DetUnit+2*gmSEQ.pi+PulseGap gSG.AWGFreq pi/2 gSG.AWGAmp]; % pi_y
    WaveForm_3I(2 + 8*SquN + (i-1)*8 + 5, :) = [gmSEQ.halfpi+SquTime+RotTime+gmSEQ.DEERhalfpi+DetInterval/2+(8*(i-1)+4)*DetUnit+gmSEQ.pi+PulseGap gmSEQ.halfpi+SquTime+RotTime+gmSEQ.DEERhalfpi+DetInterval/2+(8*(i-1)+4)*DetUnit+2*gmSEQ.pi+PulseGap gSG.AWGFreq pi/2 gSG.AWGAmp]; % pi_y
    WaveForm_3I(2 + 8*SquN + (i-1)*8 + 6, :) = [gmSEQ.halfpi+SquTime+RotTime+gmSEQ.DEERhalfpi+DetInterval/2+(8*(i-1)+5)*DetUnit+gmSEQ.pi+PulseGap gmSEQ.halfpi+SquTime+RotTime+gmSEQ.DEERhalfpi+DetInterval/2+(8*(i-1)+5)*DetUnit+2*gmSEQ.pi+PulseGap gSG.AWGFreq 0 gSG.AWGAmp]; % pi_x
    WaveForm_3I(2 + 8*SquN + (i-1)*8 + 7, :) = [gmSEQ.halfpi+SquTime+RotTime+gmSEQ.DEERhalfpi+DetInterval/2+(8*(i-1)+6)*DetUnit+gmSEQ.pi+PulseGap gmSEQ.halfpi+SquTime+RotTime+gmSEQ.DEERhalfpi+DetInterval/2+(8*(i-1)+6)*DetUnit+2*gmSEQ.pi+PulseGap gSG.AWGFreq pi/2 gSG.AWGAmp]; % pi_y
    WaveForm_3I(2 + 8*SquN + (i-1)*8 + 8, :) = [gmSEQ.halfpi+SquTime+RotTime+gmSEQ.DEERhalfpi+DetInterval/2+(8*(i-1)+7)*DetUnit+gmSEQ.pi+PulseGap gmSEQ.halfpi+SquTime+RotTime+gmSEQ.DEERhalfpi+DetInterval/2+(8*(i-1)+7)*DetUnit+2*gmSEQ.pi+PulseGap gSG.AWGFreq 0 gSG.AWGAmp]; % pi_x
end
WaveForm_3Q = WaveForm_3I - repmat([0 0 0 pi/2 0], size(WaveForm_3I, 1), 1);
WaveForm_3Length = ceil((gmSEQ.halfpi+SquTime+RotTime+gmSEQ.DEERhalfpi+8*DetN*DetUnit+1000) / (16 / gSG.AWGClockRate)) ...
    *(16 / gSG.AWGClockRate);
WaveForm_3PointNum = WaveForm_3Length * gSG.AWGClockRate;

% Squeezed spin 2
WaveForm_4I = zeros(2 + 16*DetN, 5);
WaveForm_4I(1, :) = [0 gmSEQ.halfpi+SquTime+RotAngle+PulseGap gSG2.AWGFreq 0 0];
WaveForm_4I(2, :) = [gmSEQ.halfpi+SquTime+RotAngle+PulseGap gmSEQ.halfpi+SquTime+RotAngle+PulseGap+gmSEQ.pi gSG2.AWGFreq pi gSG3.AWGAmp];
timeOffset = gmSEQ.halfpi+SquTime+RotTime+gmSEQ.DEERhalfpi+DetInterval/2;
for i = 1:DetN
    WaveForm_4I(2 + (i-1)*16 + 1, :) = [timeOffset+(8*(i-1)+0)*DetUnit timeOffset+(8*(i-1)+0)*DetUnit+gmSEQ.pi gSG3.AWGFreq 0 gSG3.AWGAmp];
    WaveForm_4I(2 + (i-1)*16 + 2, :) = [timeOffset+(8*(i-1)+0)*DetUnit+2*gmSEQ.pi+2*PulseGap timeOffset+(8*(i-1)+0)*DetUnit+3*gmSEQ.pi+2*PulseGap gSG3.AWGFreq pi gSG3.AWGAmp]; 
    WaveForm_4I(2 + (i-1)*16 + 3, :) = [timeOffset+(8*(i-1)+1)*DetUnit timeOffset+(8*(i-1)+1)*DetUnit+gmSEQ.pi gSG3.AWGFreq 0 gSG3.AWGAmp];
    WaveForm_4I(2 + (i-1)*16 + 4, :) = [timeOffset+(8*(i-1)+1)*DetUnit+2*gmSEQ.pi+2*PulseGap  timeOffset+(8*(i-1)+1)*DetUnit+3*gmSEQ.pi+2*PulseGap gSG3.AWGFreq pi gSG3.AWGAmp];
    WaveForm_4I(2 + (i-1)*16 + 5, :) = [timeOffset+(8*(i-1)+2)*DetUnit timeOffset+(8*(i-1)+2)*DetUnit+gmSEQ.pi gSG3.AWGFreq 0 gSG3.AWGAmp];
    WaveForm_4I(2 + (i-1)*16 + 6, :) = [timeOffset+(8*(i-1)+2)*DetUnit+2*gmSEQ.pi+2*PulseGap  timeOffset+(8*(i-1)+2)*DetUnit+3*gmSEQ.pi+2*PulseGap gSG3.AWGFreq pi gSG3.AWGAmp];
    WaveForm_4I(2 + (i-1)*16 + 7, :) = [timeOffset+(8*(i-1)+3)*DetUnit timeOffset+(8*(i-1)+3)*DetUnit+gmSEQ.pi gSG3.AWGFreq 0 gSG3.AWGAmp]; 
    WaveForm_4I(2 + (i-1)*16 + 8, :) = [timeOffset+(8*(i-1)+3)*DetUnit+2*gmSEQ.pi+2*PulseGap  timeOffset+(8*(i-1)+3)*DetUnit+3*gmSEQ.pi+2*PulseGap gSG3.AWGFreq pi gSG3.AWGAmp]; 
    WaveForm_4I(2 + (i-1)*16 + 9, :) = [timeOffset+(8*(i-1)+4)*DetUnit timeOffset+(8*(i-1)+4)*DetUnit+gmSEQ.pi gSG3.AWGFreq 0 gSG3.AWGAmp]; 
    WaveForm_4I(2 + (i-1)*16 + 10, :) = [timeOffset+(8*(i-1)+4)*DetUnit+2*gmSEQ.pi+2*PulseGap  timeOffset+(8*(i-1)+4)*DetUnit+3*gmSEQ.pi+2*PulseGap gSG3.AWGFreq pi gSG3.AWGAmp]; 
    WaveForm_4I(2 + (i-1)*16 + 11, :) = [timeOffset+(8*(i-1)+5)*DetUnit timeOffset+(8*(i-1)+5)*DetUnit+gmSEQ.pi gSG3.AWGFreq 0 gSG3.AWGAmp];
    WaveForm_4I(2 + (i-1)*16 + 12, :) = [timeOffset+(8*(i-1)+5)*DetUnit+2*gmSEQ.pi+2*PulseGap  timeOffset+(8*(i-1)+5)*DetUnit+3*gmSEQ.pi+2*PulseGap gSG3.AWGFreq pi gSG3.AWGAmp];
    WaveForm_4I(2 + (i-1)*16 + 13, :) = [timeOffset+(8*(i-1)+6)*DetUnit timeOffset+(8*(i-1)+6)*DetUnit+gmSEQ.pi gSG3.AWGFreq 0 gSG3.AWGAmp]; 
    WaveForm_4I(2 + (i-1)*16 + 14, :) = [timeOffset+(8*(i-1)+6)*DetUnit+2*gmSEQ.pi+2*PulseGap  timeOffset+(8*(i-1)+6)*DetUnit+3*gmSEQ.pi+2*PulseGap gSG3.AWGFreq pi gSG3.AWGAmp]; 
    WaveForm_4I(2 + (i-1)*16 + 15, :) = [timeOffset+(8*(i-1)+7)*DetUnit timeOffset+(8*(i-1)+7)*DetUnit+gmSEQ.pi gSG3.AWGFreq 0 gSG3.AWGAmp]; 
    WaveForm_4I(2 + (i-1)*16 + 16, :) = [timeOffset+(8*(i-1)+7)*DetUnit+2*gmSEQ.pi+2*PulseGap  timeOffset+(8*(i-1)+7)*DetUnit+3*gmSEQ.pi+2*PulseGap gSG3.AWGFreq pi gSG3.AWGAmp]; 
end
WaveForm_4Q = WaveForm_4I - repmat([0 0 0 pi/2 0], size(WaveForm_4I, 1), 1);
WaveForm_4Length = ceil((gmSEQ.halfpi+SquTime+RotTime+gmSEQ.DEERhalfpi+8*DetN*DetUnit+1000) / (16 / gSG3.AWGClockRate)) ...
    *(16 / gSG3.AWGClockRate);
WaveForm_4PointNum = WaveForm_4Length * gSG3.AWGClockRate;

chaseFunctionPool('createWaveform', WaveForm_1I, gSG2.P1AWGClockRate, WaveForm_1Length, 'Squeezing_Double_T2XY8_I_seg1.txt'); pause(0.5);
chaseFunctionPool('createWaveform', WaveForm_1Q, gSG2.P1AWGClockRate, WaveForm_1Length, 'Squeezing_Double_T2XY8_Q_seg1.txt'); pause(0.5);
chaseFunctionPool('createWaveform', WaveForm_2I, gSG2.P1AWGClockRate, WaveForm_2Length, 'Squeezing_Double_T2XY8_I_seg2.txt'); pause(0.5);
chaseFunctionPool('createWaveform', WaveForm_2Q, gSG2.P1AWGClockRate, WaveForm_2Length, 'Squeezing_Double_T2XY8_Q_seg2.txt'); pause(0.5);
chaseFunctionPool('createWaveform', WaveForm_3I, gSG.AWGClockRate, WaveForm_3Length, 'Squeezing_Double_T2XY8_I_seg3.txt'); pause(0.5);
chaseFunctionPool('createWaveform', WaveForm_3Q, gSG.AWGClockRate, WaveForm_3Length, 'Squeezing_Double_T2XY8_Q_seg3.txt'); pause(0.5);
chaseFunctionPool('createWaveform', WaveForm_4I, gSG3.AWGClockRate, WaveForm_4Length, 'Squeezing_Double_T2XY8_I_seg4.txt'); pause(0.5);
chaseFunctionPool('createWaveform', WaveForm_4Q, gSG3.AWGClockRate, WaveForm_4Length, 'Squeezing_Double_T2XY8_Q_seg4.txt'); pause(0.5);

chaseFunctionPool('createSegStruct', 'Squeezing_Double_T2XY8_SegStruct_I.txt', ...
    'Squeezing_Double_T2XY8_I_seg1.txt', WaveForm_1PointNum, 1, 1, ...
    'Squeezing_Double_T2XY8_I_seg2.txt', WaveForm_2PointNum, 1, 1);
pause(0.5);
chaseFunctionPool('createSegStruct', 'Squeezing_Double_T2XY8_SegStruct_Q.txt', ...
    'Squeezing_Double_T2XY8_Q_seg1.txt', WaveForm_1PointNum, 1, 1, ...
    'Squeezing_Double_T2XY8_Q_seg2.txt', WaveForm_2PointNum, 1, 1);
pause(0.5);
chaseFunctionPool('createSegStruct', 'Squeezing_Double_T2XY8_2_SegStruct_I.txt', ...
    'Squeezing_Double_T2XY8_I_seg3.txt', WaveForm_3PointNum, 1, 1, ...
    'Squeezing_Double_T2XY8_I_seg3.txt', WaveForm_3PointNum, 1, 1);
pause(0.5);
chaseFunctionPool('createSegStruct', 'Squeezing_Double_T2XY8_2_SegStruct_Q.txt', ...
    'Squeezing_Double_T2XY8_Q_seg3.txt', WaveForm_3PointNum, 1, 1, ...
    'Squeezing_Double_T2XY8_Q_seg3.txt', WaveForm_3PointNum, 1, 1);
pause(0.5);
chaseFunctionPool('createSegStruct', 'Squeezing_Double_T2XY8_3_SegStruct_I.txt', ...
    'Squeezing_Double_T2XY8_I_seg4.txt', WaveForm_4PointNum, 1, 1, ...
    'Squeezing_Double_T2XY8_I_seg4.txt', WaveForm_4PointNum, 1, 1);
pause(0.5);
chaseFunctionPool('createSegStruct', 'Squeezing_Double_T2XY8_3_SegStruct_Q.txt', ...
    'Squeezing_Double_T2XY8_Q_seg4.txt', WaveForm_4PointNum, 1, 1, ...
    'Squeezing_Double_T2XY8_Q_seg4.txt', WaveForm_4PointNum, 1, 1);
pause(0.5);

%% Load waveform to AWG
chaseFunctionPool('CreateSegments', gmSEQ.P1AWG, 1, ...
    2, ...
    2047, 2047, 'Squeezing_Double_T2XY8_SegStruct_I.txt', 'false');
pause(1); % this pause seems to be important, otherwise the loading is not right occassionally
chaseFunctionPool('CreateSegments', gmSEQ.P1AWG, 2, ...
    2, ...
    2047, 2047, 'Squeezing_Double_T2XY8_SegStruct_Q.txt', 'false');
pause(1); % this pause seems to be important, otherwise the loading is not right occassionally
chaseFunctionPool('CreateSegments', gmSEQ.MWAWG, 1, ...
    2, ...
    2047, 2047, 'Squeezing_Double_T2XY8_2_SegStruct_I.txt', 'false');
pause(1); % this pause seems to be important, otherwise the loading is not right occassionally
chaseFunctionPool('CreateSegments', gmSEQ.MWAWG, 2, ...
    2, ...
    2047, 2047, 'Squeezing_Double_T2XY8_2_SegStruct_Q.txt', 'false');
pause(1); % this pause seems to be important, otherwise the loading is not right occassionally
chaseFunctionPool('CreateSegments', gmSEQ.MWAWG2, 1, ...
    2, ...
    2047, 2047, 'Squeezing_Double_T2XY8_3_SegStruct_I.txt', 'false');
pause(1); % this pause seems to be important, otherwise the loading is not right occassionally
chaseFunctionPool('CreateSegments', gmSEQ.MWAWG2, 2, ...
    2, ...
    2047, 2047, 'Squeezing_Double_T2XY8_3_SegStruct_Q.txt', 'false');
pause(1); % this pause seems to be important, otherwise the loading is not right occassionally

%% Run waveform
chaseFunctionPool('runChase', gmSEQ.MWAWG, 'false'); pause(1);
chaseFunctionPool('runChase', gmSEQ.P1AWG, 'false'); pause(1);
chaseFunctionPool('runChase', gmSEQ.MWAWG2, 'false'); pause(1);
ApplyDelays();


function Squeezing_Double_T2XY8_SwpSquN
global gmSEQ gSG gSG2 gSG3
gSG.bfixedPow=1;
gSG.bfixedFreq=1;
gSG.bMod='IQ';
gSG.bModSrc='External';

gSG2.bMod='IQ';
gSG2.bModSrc='External';
SignalGeneratorFunctionPool2('SetMod');
SignalGeneratorFunctionPool2('WritePow');
SignalGeneratorFunctionPool2('WriteFreq');
gSG2.bOn=1; SignalGeneratorFunctionPool2('RFOnOff');

gSG3.bMod='IQ';
gSG3.bModSrc='External';
SignalGeneratorFunctionPool3('SetMod');
SignalGeneratorFunctionPool3('WritePow');
SignalGeneratorFunctionPool3('WriteFreq');
gSG3.bOn=1; SignalGeneratorFunctionPool3('RFOnOff');

% Add more tomographical measurements later. 
% gmSEQ.Ntomo = 2;

% Parameters. Need to be binded with the variables provided by the GUI
gmSEQ.halfpi = gmSEQ.pi/2;
gmSEQ.DEERhalfpi = gmSEQ.DEERpi/2;
% Pi = max(gmSEQ.pi, gmSEQ.pi);
% HalfPi = max(gmSEQ.halfpi, gmSEQ.halfpi);

SquInterval = gmSEQ.SLockT1; % XY8 interval to generate the squeezing
SquN = round(gmSEQ.SLockT2); % XY8 number
SquTime = SquN * (SquInterval + gmSEQ.pi)*8;
SquAmp = gSG.AWGAmp;

PulseGap = 2;
DetInterval = gmSEQ.SLockT1_M;
DetN = round(gmSEQ.SLockT2_M);
DetUnit = DetInterval + 3*gmSEQ.pi + 2*PulseGap;
DetTime = gmSEQ.DEERhalfpi + DetN * DetUnit*8 + gmSEQ.DEERhalfpi;
RotAngle = gmSEQ.DEERt;
RotTime = gmSEQ.DEERpi + PulseGap + gmSEQ.pi;
AfterPi = 2000;
AfterLaser = 100e3; 
Wait_p = 0.1e6;
Detect_Window = 5000;
MWBuffer = 10;

Sig_D_start = Wait_p+gmSEQ.readout+AfterLaser+gmSEQ.halfpi+SquTime+RotTime+DetTime+AfterPi+Detect_Window+Wait_p;

gmSEQ.CHN(1).PBN=PBDictionary('ctr0');
gmSEQ.CHN(1).NRise=4;
gmSEQ.CHN(1).T=[Wait_p+gmSEQ.readout-1000-gmSEQ.CtrGateDur, ...
    Wait_p+gmSEQ.readout+AfterLaser+gmSEQ.halfpi+SquTime+RotTime+DetTime+AfterPi, ...
    Sig_D_start+gmSEQ.readout-1000-gmSEQ.CtrGateDur, ... 
    Sig_D_start+gmSEQ.readout+AfterLaser+gmSEQ.halfpi+SquTime+RotTime+DetTime+AfterPi];
if strcmp(gmSEQ.meas,'SPCM')
    gmSEQ.CHN(1).DT=[gmSEQ.CtrGateDur gmSEQ.CtrGateDur gmSEQ.CtrGateDur gmSEQ.CtrGateDur];
elseif strcmp(gmSEQ.meas,'APD')
    gmSEQ.CHN(1).DT=[1000 1000 1000 1000];
end

gmSEQ.CHN(numel(gmSEQ.CHN)+1).PBN=PBDictionary('AOM');
gmSEQ.CHN(numel(gmSEQ.CHN)).NRise=4;
gmSEQ.CHN(numel(gmSEQ.CHN)).T = [Wait_p, Wait_p+gmSEQ.readout+AfterLaser+gmSEQ.halfpi+SquTime+RotTime+DetTime+AfterPi, ...
    Sig_D_start, Sig_D_start+gmSEQ.readout+AfterLaser+gmSEQ.halfpi+SquTime+RotTime+DetTime+AfterPi];
gmSEQ.CHN(numel(gmSEQ.CHN)).DT = [gmSEQ.readout Detect_Window gmSEQ.readout Detect_Window];

% MW for probe spin
gmSEQ.CHN(numel(gmSEQ.CHN)+1).PBN=PBDictionary('AWGTrig2');
gmSEQ.CHN(numel(gmSEQ.CHN)).NRise=2;
gmSEQ.CHN(numel(gmSEQ.CHN)).T=[Wait_p+gmSEQ.readout+AfterLaser+gmSEQ.halfpi+SquTime+RotTime, Sig_D_start+gmSEQ.readout+AfterLaser+gmSEQ.halfpi+SquTime+RotTime];
gmSEQ.CHN(numel(gmSEQ.CHN)).DT=repelem(DetTime+200, 2);

% MW for squeezed spin
gmSEQ.CHN(numel(gmSEQ.CHN)+1).PBN=PBDictionary('AWGTrig');
gmSEQ.CHN(numel(gmSEQ.CHN)).NRise=2;
gmSEQ.CHN(numel(gmSEQ.CHN)).T=[Wait_p+gmSEQ.readout+AfterLaser, Sig_D_start+gmSEQ.readout+AfterLaser];
gmSEQ.CHN(numel(gmSEQ.CHN)).DT=repelem(gmSEQ.halfpi+SquTime+RotTime+DetTime+200, 2);

% MW for squeezed spin 2
% Start the triggers of the probe spin at the same time
gmSEQ.CHN(numel(gmSEQ.CHN)+1).PBN=PBDictionary('AWGTrig3');
gmSEQ.CHN(numel(gmSEQ.CHN)).NRise=2;
gmSEQ.CHN(numel(gmSEQ.CHN)).T=[Wait_p+gmSEQ.readout+AfterLaser, Sig_D_start+gmSEQ.readout+AfterLaser];
gmSEQ.CHN(numel(gmSEQ.CHN)).DT=repelem(gmSEQ.halfpi+SquTime+RotTime+DetTime+200, 2);

% MW for probe spin
gmSEQ.CHN(numel(gmSEQ.CHN)+1).PBN=PBDictionary('MWSwitch2');
if DetN == 0
    gmSEQ.CHN(numel(gmSEQ.CHN)).NRise=2;
    gmSEQ.CHN(numel(gmSEQ.CHN)).T = [Wait_p+gmSEQ.readout+AfterLaser+gmSEQ.halfpi+SquTime+RotTime-MWBuffer, Sig_D_start+gmSEQ.readout+AfterLaser+gmSEQ.halfpi+SquTime+RotTime-MWBuffer];
    gmSEQ.CHN(numel(gmSEQ.CHN)).DT = repelem(gmSEQ.DEERhalfpi+gmSEQ.DEERhalfpi+2*MWBuffer, 2);
else
    gmSEQ.CHN(numel(gmSEQ.CHN)).NRise=2*(8*DetN + 2);
    gmSEQ.CHN(numel(gmSEQ.CHN)).T = zeros(1, gmSEQ.CHN(numel(gmSEQ.CHN)).NRise);
    gmSEQ.CHN(numel(gmSEQ.CHN)).T(1) = Wait_p+gmSEQ.readout+AfterLaser+gmSEQ.halfpi+SquTime+RotTime-MWBuffer;
    for i = 1:DetN
        for j = 1:8
            gmSEQ.CHN(numel(gmSEQ.CHN)).T(1+(i-1)*8+j) = Wait_p+gmSEQ.readout+AfterLaser+gmSEQ.halfpi+SquTime+RotTime+gmSEQ.DEERhalfpi+DetInterval/2+(8*(i-1)+j-1)*DetUnit-MWBuffer;
        end
    end
    gmSEQ.CHN(numel(gmSEQ.CHN)).T(1+8*DetN+1) = Wait_p+gmSEQ.readout+AfterLaser+gmSEQ.halfpi+SquTime+RotTime+gmSEQ.DEERhalfpi+DetN*DetUnit*8-MWBuffer;
    gmSEQ.CHN(numel(gmSEQ.CHN)).T(1+8*DetN+2) = Sig_D_start+gmSEQ.readout+AfterLaser+gmSEQ.halfpi+SquTime+RotTime-MWBuffer;
    for i = 1:DetN
        for j = 1:8
            gmSEQ.CHN(numel(gmSEQ.CHN)).T(3+8*DetN+(i-1)*8+j) = Sig_D_start+gmSEQ.readout+AfterLaser+gmSEQ.halfpi+SquTime+RotTime+gmSEQ.DEERhalfpi+DetInterval/2+(8*(i-1)+j-1)*DetUnit-MWBuffer;
        end
    end
    gmSEQ.CHN(numel(gmSEQ.CHN)).T(3+16*DetN+1) = Sig_D_start+gmSEQ.readout+AfterLaser+gmSEQ.halfpi+SquTime+RotTime+gmSEQ.DEERhalfpi+DetN*DetUnit*8-MWBuffer;
    gmSEQ.CHN(numel(gmSEQ.CHN)).DT=[gmSEQ.DEERhalfpi+2*MWBuffer, repelem(3*gmSEQ.pi+2*PulseGap+2*MWBuffer, 8*DetN), gmSEQ.DEERhalfpi+2*MWBuffer, ... 
        gmSEQ.DEERhalfpi+2*MWBuffer, repelem(3*gmSEQ.pi+2*PulseGap+2*MWBuffer, 8*DetN), gmSEQ.DEERhalfpi+2*MWBuffer];    
end

% MW for squeezed spin
gmSEQ.CHN(numel(gmSEQ.CHN)+1).PBN=PBDictionary('MWSwitch');
gmSEQ.CHN(numel(gmSEQ.CHN)).NRise=2*(8*SquN + 8*DetN + 2);
gmSEQ.CHN(numel(gmSEQ.CHN)).T = zeros(1, gmSEQ.CHN(numel(gmSEQ.CHN)).NRise);
gmSEQ.CHN(numel(gmSEQ.CHN)).T(1) = Wait_p+gmSEQ.readout+AfterLaser-MWBuffer;
for i = 1:SquN
    for j = 1:8
        gmSEQ.CHN(numel(gmSEQ.CHN)).T(1+(i-1)*8+j) = Wait_p+gmSEQ.readout+AfterLaser+gmSEQ.halfpi+SquInterval/2+((i-1)*8+j-1)*(SquInterval+gmSEQ.pi)-MWBuffer;
    end
end
gmSEQ.CHN(numel(gmSEQ.CHN)).T(2+SquN*8) = Wait_p+gmSEQ.readout+AfterLaser+gmSEQ.halfpi+SquTime-MWBuffer;
for i = 1:DetN
    for j = 1:8
        gmSEQ.CHN(numel(gmSEQ.CHN)).T(2+SquN*8+(i-1)*8+j) = Wait_p+gmSEQ.readout+AfterLaser+gmSEQ.halfpi+SquTime+RotTime+gmSEQ.DEERhalfpi+DetInterval/2+(8*(i-1)+j-1)*DetUnit-MWBuffer;
    end
end
gmSEQ.CHN(numel(gmSEQ.CHN)).T(8*SquN+8*DetN+3) = Sig_D_start+gmSEQ.readout+AfterLaser-MWBuffer;
for i = 1:SquN
    for j = 1:8
        gmSEQ.CHN(numel(gmSEQ.CHN)).T(8*SquN+8*DetN+3+(i-1)*8+j) = Sig_D_start+gmSEQ.readout+AfterLaser+gmSEQ.halfpi+SquInterval/2+((i-1)*8+j-1)*(SquInterval+gmSEQ.pi)-MWBuffer;
    end
end
gmSEQ.CHN(numel(gmSEQ.CHN)).T(4+16*SquN+8*DetN) = Sig_D_start+gmSEQ.readout+AfterLaser+gmSEQ.halfpi+SquTime-MWBuffer;
for i = 1:DetN
    for j = 1:8
        gmSEQ.CHN(numel(gmSEQ.CHN)).T(4+16*SquN+8*DetN+(i-1)*8+j) = Sig_D_start+gmSEQ.readout+AfterLaser+gmSEQ.halfpi+SquTime+RotTime+gmSEQ.DEERhalfpi+DetInterval/2+(8*(i-1)+j-1)*DetUnit-MWBuffer;
    end
end
gmSEQ.CHN(numel(gmSEQ.CHN)).DT=[gmSEQ.halfpi+2*MWBuffer, repelem(gmSEQ.pi+2*MWBuffer, 8*SquN), RotTime+2*MWBuffer,  repelem(3*gmSEQ.pi+2*PulseGap+2*MWBuffer, 8*DetN), ... 
    gmSEQ.halfpi+2*MWBuffer, repelem(gmSEQ.pi+2*MWBuffer, 8*SquN), RotTime+2*MWBuffer,  repelem(3*gmSEQ.pi+2*PulseGap+2*MWBuffer, 8*DetN)];

% gmSEQ.CHN(numel(gmSEQ.CHN)+1).PBN=PBDictionary('MWSwitch');
% gmSEQ.CHN(numel(gmSEQ.CHN)).NRise=2*(8*DetN + 1);
% gmSEQ.CHN(numel(gmSEQ.CHN)).T = zeros(1, gmSEQ.CHN(numel(gmSEQ.CHN)).NRise);
% gmSEQ.CHN(numel(gmSEQ.CHN)).T(1) = Wait_p+gmSEQ.readout+AfterLaser-20;
% for i = 1:DetN
%     for j = 1:8
%         gmSEQ.CHN(numel(gmSEQ.CHN)).T(1+(i-1)*8+j) = Wait_p+gmSEQ.readout+AfterLaser+gmSEQ.halfpi+SquTime+RotTime+gmSEQ.halfpi+DetInterval/2+(8*(i-1)+j-1)*DetUnit-20;
%     end
% end
% gmSEQ.CHN(numel(gmSEQ.CHN)).T(8*DetN+2) = Sig_D_start+gmSEQ.readout+AfterLaser-20;
% for i = 1:DetN
%     for j = 1:8
%         gmSEQ.CHN(numel(gmSEQ.CHN)).T(8*DetN+2+(i-1)*8+j) = Sig_D_start+gmSEQ.readout+AfterLaser+gmSEQ.halfpi+SquTime+RotTime+gmSEQ.halfpi+DetInterval/2+(8*(i-1)+j-1)*DetUnit-20;
%     end
% end
% gmSEQ.CHN(numel(gmSEQ.CHN)).DT=[gmSEQ.halfpi+SquTime+RotAngle+40,  repelem(3*gmSEQ.pi+2*PulseGap+40, 8*DetN), gmSEQ.halfpi+SquTime+RotAngle+40,  repelem(3*gmSEQ.pi+2*PulseGap+40, 8*DetN)];

gmSEQ.CHN(numel(gmSEQ.CHN)+1).PBN=PBDictionary('MWSwitch3');
gmSEQ.CHN(numel(gmSEQ.CHN)).NRise=2*(8*DetN + 1);
gmSEQ.CHN(numel(gmSEQ.CHN)).T = zeros(1, gmSEQ.CHN(numel(gmSEQ.CHN)).NRise);
gmSEQ.CHN(numel(gmSEQ.CHN)).T(1) = Wait_p+gmSEQ.readout+AfterLaser+gmSEQ.halfpi+SquTime+gmSEQ.DEERpi+PulseGap-MWBuffer-2;
for i = 1:DetN
    for j = 1:8
        gmSEQ.CHN(numel(gmSEQ.CHN)).T(1+(i-1)*8+j) = Wait_p+gmSEQ.readout+AfterLaser+gmSEQ.halfpi+SquTime+RotTime+gmSEQ.DEERhalfpi+DetInterval/2+(8*(i-1)+j-1)*DetUnit-MWBuffer;
    end
end
gmSEQ.CHN(numel(gmSEQ.CHN)).T(2+8*DetN) = Sig_D_start+gmSEQ.readout+AfterLaser+gmSEQ.halfpi+SquTime+gmSEQ.DEERpi+PulseGap-MWBuffer-2;
for i = 1:DetN
    for j = 1:8
        gmSEQ.CHN(numel(gmSEQ.CHN)).T(2+8*DetN+(i-1)*8+j) = Sig_D_start+gmSEQ.readout+AfterLaser+gmSEQ.halfpi+SquTime+RotTime+gmSEQ.DEERhalfpi+DetInterval/2+(8*(i-1)+j-1)*DetUnit-MWBuffer;
    end
end
gmSEQ.CHN(numel(gmSEQ.CHN)).DT=[gmSEQ.pi+2*MWBuffer+8,  repelem(3*gmSEQ.pi+2*PulseGap+2*MWBuffer, 8*DetN), ... 
    gmSEQ.pi+2*MWBuffer+8,  repelem(3*gmSEQ.pi+2*PulseGap+2*MWBuffer, 8*DetN)];

gmSEQ.CHN(numel(gmSEQ.CHN)+1).PBN=PBDictionary('dummy1');
gmSEQ.CHN(numel(gmSEQ.CHN)).NRise=2;
gmSEQ.CHN(numel(gmSEQ.CHN)).T=[0 2*(Sig_D_start-Wait_p)-50];
gmSEQ.CHN(numel(gmSEQ.CHN)).DT=[50 50];

%% AWG
% Initialization
chaseFunctionPool('stopChase',  gmSEQ.MWAWG)
chaseFunctionPool('stopChase',  gmSEQ.P1AWG)
chaseFunctionPool('stopChase',  gmSEQ.MWAWG2)

% This part need to be modified to accomodate the DC modulation
if ~gSG.ACmodAWG % in AC modulation mode
    gSG.AWGFreq = 0;
    gSG2.AWGFreq = 0;
    gSG3.AWGFreq = 0;
end

% probe spin
ComposePi = 3*gmSEQ.pi+2*PulseGap;
if gmSEQ.DEERpi >= ComposePi
   warning("Probe pi pulse is too long. Sequence is incorrect.") 
end

if gmSEQ.m == 0
    WaveForm_1I = [0 2*gmSEQ.DEERhalfpi gSG2.AWGFreq 0 0];
else
    WaveForm_1I = zeros(2 + 8*DetN, 5);
    WaveForm_1I(1, :) = [0 gmSEQ.DEERhalfpi gSG2.AWGFreq 0 gSG2.AWGAmp];
    for i = 1:DetN
        WaveForm_1I(1 + (i-1)*8 + 1, :) = [gmSEQ.DEERhalfpi+DetInterval/2+(8*(i-1)+0)*DetUnit+(ComposePi-gmSEQ.DEERpi)/2 gmSEQ.DEERhalfpi+DetInterval/2+(8*(i-1)+0)*DetUnit+(ComposePi+gmSEQ.DEERpi)/2 gSG2.AWGFreq 0 gSG2.AWGAmp]; % pi_x
        WaveForm_1I(1 + (i-1)*8 + 2, :) = [gmSEQ.DEERhalfpi+DetInterval/2+(8*(i-1)+1)*DetUnit+(ComposePi-gmSEQ.DEERpi)/2 gmSEQ.DEERhalfpi+DetInterval/2+(8*(i-1)+1)*DetUnit+(ComposePi+gmSEQ.DEERpi)/2 gSG2.AWGFreq pi/2 gSG2.AWGAmp]; % pi_y
        WaveForm_1I(1 + (i-1)*8 + 3, :) = [gmSEQ.DEERhalfpi+DetInterval/2+(8*(i-1)+2)*DetUnit+(ComposePi-gmSEQ.DEERpi)/2 gmSEQ.DEERhalfpi+DetInterval/2+(8*(i-1)+2)*DetUnit+(ComposePi+gmSEQ.DEERpi)/2 gSG2.AWGFreq 0 gSG2.AWGAmp]; % pi_x
        WaveForm_1I(1 + (i-1)*8 + 4, :) = [gmSEQ.DEERhalfpi+DetInterval/2+(8*(i-1)+3)*DetUnit+(ComposePi-gmSEQ.DEERpi)/2 gmSEQ.DEERhalfpi+DetInterval/2+(8*(i-1)+3)*DetUnit+(ComposePi+gmSEQ.DEERpi)/2 gSG2.AWGFreq pi/2 gSG2.AWGAmp]; % pi_y
        WaveForm_1I(1 + (i-1)*8 + 5, :) = [gmSEQ.DEERhalfpi+DetInterval/2+(8*(i-1)+4)*DetUnit+(ComposePi-gmSEQ.DEERpi)/2 gmSEQ.DEERhalfpi+DetInterval/2+(8*(i-1)+4)*DetUnit+(ComposePi+gmSEQ.DEERpi)/2 gSG2.AWGFreq pi/2 gSG2.AWGAmp]; % pi_y
        WaveForm_1I(1 + (i-1)*8 + 6, :) = [gmSEQ.DEERhalfpi+DetInterval/2+(8*(i-1)+5)*DetUnit+(ComposePi-gmSEQ.DEERpi)/2 gmSEQ.DEERhalfpi+DetInterval/2+(8*(i-1)+5)*DetUnit+(ComposePi+gmSEQ.DEERpi)/2 gSG2.AWGFreq 0 gSG2.AWGAmp]; % pi_x
        WaveForm_1I(1 + (i-1)*8 + 7, :) = [gmSEQ.DEERhalfpi+DetInterval/2+(8*(i-1)+6)*DetUnit+(ComposePi-gmSEQ.DEERpi)/2 gmSEQ.DEERhalfpi+DetInterval/2+(8*(i-1)+6)*DetUnit+(ComposePi+gmSEQ.DEERpi)/2 gSG2.AWGFreq pi/2 gSG2.AWGAmp]; % pi_y
        WaveForm_1I(1 + (i-1)*8 + 8, :) = [gmSEQ.DEERhalfpi+DetInterval/2+(8*(i-1)+7)*DetUnit+(ComposePi-gmSEQ.DEERpi)/2 gmSEQ.DEERhalfpi+DetInterval/2+(8*(i-1)+7)*DetUnit+(ComposePi+gmSEQ.DEERpi)/2 gSG2.AWGFreq 0 gSG2.AWGAmp]; % pi_x
    end
    WaveForm_1I(2 + 8*DetN, :) = [gmSEQ.DEERhalfpi+8*DetN*DetUnit gmSEQ.DEERhalfpi+8*DetN*DetUnit+gmSEQ.DEERhalfpi gSG2.AWGFreq pi gSG2.AWGAmp];
end
WaveForm_1Q = WaveForm_1I - repmat([0 0 0 pi/2 0], size(WaveForm_1I, 1), 1);
WaveForm_1Length = ceil((gmSEQ.DEERhalfpi+8*DetN*DetUnit+gmSEQ.DEERhalfpi+1000) / (16 / gSG2.P1AWGClockRate)) ...
    *(16 / gSG2.P1AWGClockRate);
WaveForm_1PointNum = WaveForm_1Length * gSG2.P1AWGClockRate;

if gmSEQ.m == 0
    WaveForm_2I = [0 2*gmSEQ.DEERhalfpi gSG2.AWGFreq 0 gSG2.AWGAmp];
    WaveForm_2Q = WaveForm_2I - repmat([0 0 0 pi/2 0], size(WaveForm_2I, 1), 1);
else
    WaveForm_2I = WaveForm_1I;
    WaveForm_2I(size(WaveForm_1I, 1), 4) = 0; % Differential measurement
    WaveForm_2Q = WaveForm_1Q;
    WaveForm_2Q(size(WaveForm_1I, 1), 4) = -pi/2; % Differential measurement
end
WaveForm_2Length = WaveForm_1Length;
WaveForm_2PointNum = WaveForm_2Length * gSG2.P1AWGClockRate;

% Squeezed spin
WaveForm_3I = zeros(2 + 8*SquN + 8*DetN, 5);
WaveForm_3I(1, :) = [0 gmSEQ.halfpi gSG.AWGFreq 0 SquAmp];
% WaveForm_3I(1, :) = [0 gmSEQ.halfpi gSG.AWGFreq 0 gSG.AWGAmp];
for i = 1:SquN
    WaveForm_3I(1 + (i-1)*8 + 1, :) = [gmSEQ.halfpi+SquInterval/2+(8*(i-1)+0)*(SquInterval+gmSEQ.pi) gmSEQ.halfpi+SquInterval/2+(8*(i-1)+0)*(SquInterval+gmSEQ.pi)+gmSEQ.pi gSG.AWGFreq 0 SquAmp]; % pi_x
    WaveForm_3I(1 + (i-1)*8 + 2, :) = [gmSEQ.halfpi+SquInterval/2+(8*(i-1)+1)*(SquInterval+gmSEQ.pi) gmSEQ.halfpi+SquInterval/2+(8*(i-1)+1)*(SquInterval+gmSEQ.pi)+gmSEQ.pi gSG.AWGFreq pi/2 SquAmp]; % pi_y
    WaveForm_3I(1 + (i-1)*8 + 3, :) = [gmSEQ.halfpi+SquInterval/2+(8*(i-1)+2)*(SquInterval+gmSEQ.pi) gmSEQ.halfpi+SquInterval/2+(8*(i-1)+2)*(SquInterval+gmSEQ.pi)+gmSEQ.pi gSG.AWGFreq 0 SquAmp]; % pi_x
    WaveForm_3I(1 + (i-1)*8 + 4, :) = [gmSEQ.halfpi+SquInterval/2+(8*(i-1)+3)*(SquInterval+gmSEQ.pi) gmSEQ.halfpi+SquInterval/2+(8*(i-1)+3)*(SquInterval+gmSEQ.pi)+gmSEQ.pi gSG.AWGFreq pi/2 SquAmp]; % pi_y
    WaveForm_3I(1 + (i-1)*8 + 5, :) = [gmSEQ.halfpi+SquInterval/2+(8*(i-1)+4)*(SquInterval+gmSEQ.pi) gmSEQ.halfpi+SquInterval/2+(8*(i-1)+4)*(SquInterval+gmSEQ.pi)+gmSEQ.pi gSG.AWGFreq pi/2 SquAmp]; % pi_y
    WaveForm_3I(1 + (i-1)*8 + 6, :) = [gmSEQ.halfpi+SquInterval/2+(8*(i-1)+5)*(SquInterval+gmSEQ.pi) gmSEQ.halfpi+SquInterval/2+(8*(i-1)+5)*(SquInterval+gmSEQ.pi)+gmSEQ.pi gSG.AWGFreq 0 SquAmp]; % pi_x
    WaveForm_3I(1 + (i-1)*8 + 7, :) = [gmSEQ.halfpi+SquInterval/2+(8*(i-1)+6)*(SquInterval+gmSEQ.pi) gmSEQ.halfpi+SquInterval/2+(8*(i-1)+6)*(SquInterval+gmSEQ.pi)+gmSEQ.pi gSG.AWGFreq pi/2 SquAmp]; % pi_y
    WaveForm_3I(1 + (i-1)*8 + 8, :) = [gmSEQ.halfpi+SquInterval/2+(8*(i-1)+7)*(SquInterval+gmSEQ.pi) gmSEQ.halfpi+SquInterval/2+(8*(i-1)+7)*(SquInterval+gmSEQ.pi)+gmSEQ.pi gSG.AWGFreq 0 SquAmp]; % pi_x
end
WaveForm_3I(2 + 8*SquN, :) = [gmSEQ.halfpi+SquTime gmSEQ.halfpi+SquTime+RotAngle gSG.AWGFreq pi/2 SquAmp]; % theta pulse along y direction
for i = 1:DetN
    WaveForm_3I(2 + 8*SquN + (i-1)*8 + 1, :) = [gmSEQ.halfpi+SquTime+RotTime+gmSEQ.DEERhalfpi+DetInterval/2+(8*(i-1)+0)*DetUnit+gmSEQ.pi+PulseGap gmSEQ.halfpi+SquTime+RotTime+gmSEQ.DEERhalfpi+DetInterval/2+(8*(i-1)+0)*DetUnit+2*gmSEQ.pi+PulseGap gSG.AWGFreq 0 gSG.AWGAmp]; % pi_x
    WaveForm_3I(2 + 8*SquN + (i-1)*8 + 2, :) = [gmSEQ.halfpi+SquTime+RotTime+gmSEQ.DEERhalfpi+DetInterval/2+(8*(i-1)+1)*DetUnit+gmSEQ.pi+PulseGap gmSEQ.halfpi+SquTime+RotTime+gmSEQ.DEERhalfpi+DetInterval/2+(8*(i-1)+1)*DetUnit+2*gmSEQ.pi+PulseGap gSG.AWGFreq pi/2 gSG.AWGAmp]; % pi_y
    WaveForm_3I(2 + 8*SquN + (i-1)*8 + 3, :) = [gmSEQ.halfpi+SquTime+RotTime+gmSEQ.DEERhalfpi+DetInterval/2+(8*(i-1)+2)*DetUnit+gmSEQ.pi+PulseGap gmSEQ.halfpi+SquTime+RotTime+gmSEQ.DEERhalfpi+DetInterval/2+(8*(i-1)+2)*DetUnit+2*gmSEQ.pi+PulseGap gSG.AWGFreq 0 gSG.AWGAmp]; % pi_x
    WaveForm_3I(2 + 8*SquN + (i-1)*8 + 4, :) = [gmSEQ.halfpi+SquTime+RotTime+gmSEQ.DEERhalfpi+DetInterval/2+(8*(i-1)+3)*DetUnit+gmSEQ.pi+PulseGap gmSEQ.halfpi+SquTime+RotTime+gmSEQ.DEERhalfpi+DetInterval/2+(8*(i-1)+3)*DetUnit+2*gmSEQ.pi+PulseGap gSG.AWGFreq pi/2 gSG.AWGAmp]; % pi_y
    WaveForm_3I(2 + 8*SquN + (i-1)*8 + 5, :) = [gmSEQ.halfpi+SquTime+RotTime+gmSEQ.DEERhalfpi+DetInterval/2+(8*(i-1)+4)*DetUnit+gmSEQ.pi+PulseGap gmSEQ.halfpi+SquTime+RotTime+gmSEQ.DEERhalfpi+DetInterval/2+(8*(i-1)+4)*DetUnit+2*gmSEQ.pi+PulseGap gSG.AWGFreq pi/2 gSG.AWGAmp]; % pi_y
    WaveForm_3I(2 + 8*SquN + (i-1)*8 + 6, :) = [gmSEQ.halfpi+SquTime+RotTime+gmSEQ.DEERhalfpi+DetInterval/2+(8*(i-1)+5)*DetUnit+gmSEQ.pi+PulseGap gmSEQ.halfpi+SquTime+RotTime+gmSEQ.DEERhalfpi+DetInterval/2+(8*(i-1)+5)*DetUnit+2*gmSEQ.pi+PulseGap gSG.AWGFreq 0 gSG.AWGAmp]; % pi_x
    WaveForm_3I(2 + 8*SquN + (i-1)*8 + 7, :) = [gmSEQ.halfpi+SquTime+RotTime+gmSEQ.DEERhalfpi+DetInterval/2+(8*(i-1)+6)*DetUnit+gmSEQ.pi+PulseGap gmSEQ.halfpi+SquTime+RotTime+gmSEQ.DEERhalfpi+DetInterval/2+(8*(i-1)+6)*DetUnit+2*gmSEQ.pi+PulseGap gSG.AWGFreq pi/2 gSG.AWGAmp]; % pi_y
    WaveForm_3I(2 + 8*SquN + (i-1)*8 + 8, :) = [gmSEQ.halfpi+SquTime+RotTime+gmSEQ.DEERhalfpi+DetInterval/2+(8*(i-1)+7)*DetUnit+gmSEQ.pi+PulseGap gmSEQ.halfpi+SquTime+RotTime+gmSEQ.DEERhalfpi+DetInterval/2+(8*(i-1)+7)*DetUnit+2*gmSEQ.pi+PulseGap gSG.AWGFreq 0 gSG.AWGAmp]; % pi_x
end
WaveForm_3Q = WaveForm_3I - repmat([0 0 0 pi/2 0], size(WaveForm_3I, 1), 1);
WaveForm_3Length = ceil((gmSEQ.halfpi+SquTime+RotTime+gmSEQ.DEERhalfpi+8*DetN*DetUnit+1000) / (16 / gSG.AWGClockRate)) ...
    *(16 / gSG.AWGClockRate);
WaveForm_3PointNum = WaveForm_3Length * gSG.AWGClockRate;

% Squeezed spin 2
WaveForm_4I = zeros(2 + 16*DetN, 5);
WaveForm_4I(1, :) = [0 gmSEQ.halfpi+SquTime+RotAngle+PulseGap gSG2.AWGFreq 0 0];
WaveForm_4I(2, :) = [gmSEQ.halfpi+SquTime+RotAngle+PulseGap gmSEQ.halfpi+SquTime+RotAngle+PulseGap+gmSEQ.pi gSG2.AWGFreq pi gSG3.AWGAmp];
timeOffset = gmSEQ.halfpi+SquTime+RotTime+gmSEQ.DEERhalfpi+DetInterval/2;
for i = 1:DetN
    WaveForm_4I(2 + (i-1)*16 + 1, :) = [timeOffset+(8*(i-1)+0)*DetUnit timeOffset+(8*(i-1)+0)*DetUnit+gmSEQ.pi gSG3.AWGFreq 0 gSG3.AWGAmp];
    WaveForm_4I(2 + (i-1)*16 + 2, :) = [timeOffset+(8*(i-1)+0)*DetUnit+2*gmSEQ.pi+2*PulseGap timeOffset+(8*(i-1)+0)*DetUnit+3*gmSEQ.pi+2*PulseGap gSG3.AWGFreq pi gSG3.AWGAmp]; 
    WaveForm_4I(2 + (i-1)*16 + 3, :) = [timeOffset+(8*(i-1)+1)*DetUnit timeOffset+(8*(i-1)+1)*DetUnit+gmSEQ.pi gSG3.AWGFreq 0 gSG3.AWGAmp];
    WaveForm_4I(2 + (i-1)*16 + 4, :) = [timeOffset+(8*(i-1)+1)*DetUnit+2*gmSEQ.pi+2*PulseGap  timeOffset+(8*(i-1)+1)*DetUnit+3*gmSEQ.pi+2*PulseGap gSG3.AWGFreq pi gSG3.AWGAmp];
    WaveForm_4I(2 + (i-1)*16 + 5, :) = [timeOffset+(8*(i-1)+2)*DetUnit timeOffset+(8*(i-1)+2)*DetUnit+gmSEQ.pi gSG3.AWGFreq 0 gSG3.AWGAmp];
    WaveForm_4I(2 + (i-1)*16 + 6, :) = [timeOffset+(8*(i-1)+2)*DetUnit+2*gmSEQ.pi+2*PulseGap  timeOffset+(8*(i-1)+2)*DetUnit+3*gmSEQ.pi+2*PulseGap gSG3.AWGFreq pi gSG3.AWGAmp];
    WaveForm_4I(2 + (i-1)*16 + 7, :) = [timeOffset+(8*(i-1)+3)*DetUnit timeOffset+(8*(i-1)+3)*DetUnit+gmSEQ.pi gSG3.AWGFreq 0 gSG3.AWGAmp]; 
    WaveForm_4I(2 + (i-1)*16 + 8, :) = [timeOffset+(8*(i-1)+3)*DetUnit+2*gmSEQ.pi+2*PulseGap  timeOffset+(8*(i-1)+3)*DetUnit+3*gmSEQ.pi+2*PulseGap gSG3.AWGFreq pi gSG3.AWGAmp]; 
    WaveForm_4I(2 + (i-1)*16 + 9, :) = [timeOffset+(8*(i-1)+4)*DetUnit timeOffset+(8*(i-1)+4)*DetUnit+gmSEQ.pi gSG3.AWGFreq 0 gSG3.AWGAmp]; 
    WaveForm_4I(2 + (i-1)*16 + 10, :) = [timeOffset+(8*(i-1)+4)*DetUnit+2*gmSEQ.pi+2*PulseGap  timeOffset+(8*(i-1)+4)*DetUnit+3*gmSEQ.pi+2*PulseGap gSG3.AWGFreq pi gSG3.AWGAmp]; 
    WaveForm_4I(2 + (i-1)*16 + 11, :) = [timeOffset+(8*(i-1)+5)*DetUnit timeOffset+(8*(i-1)+5)*DetUnit+gmSEQ.pi gSG3.AWGFreq 0 gSG3.AWGAmp];
    WaveForm_4I(2 + (i-1)*16 + 12, :) = [timeOffset+(8*(i-1)+5)*DetUnit+2*gmSEQ.pi+2*PulseGap  timeOffset+(8*(i-1)+5)*DetUnit+3*gmSEQ.pi+2*PulseGap gSG3.AWGFreq pi gSG3.AWGAmp];
    WaveForm_4I(2 + (i-1)*16 + 13, :) = [timeOffset+(8*(i-1)+6)*DetUnit timeOffset+(8*(i-1)+6)*DetUnit+gmSEQ.pi gSG3.AWGFreq 0 gSG3.AWGAmp]; 
    WaveForm_4I(2 + (i-1)*16 + 14, :) = [timeOffset+(8*(i-1)+6)*DetUnit+2*gmSEQ.pi+2*PulseGap  timeOffset+(8*(i-1)+6)*DetUnit+3*gmSEQ.pi+2*PulseGap gSG3.AWGFreq pi gSG3.AWGAmp]; 
    WaveForm_4I(2 + (i-1)*16 + 15, :) = [timeOffset+(8*(i-1)+7)*DetUnit timeOffset+(8*(i-1)+7)*DetUnit+gmSEQ.pi gSG3.AWGFreq 0 gSG3.AWGAmp]; 
    WaveForm_4I(2 + (i-1)*16 + 16, :) = [timeOffset+(8*(i-1)+7)*DetUnit+2*gmSEQ.pi+2*PulseGap  timeOffset+(8*(i-1)+7)*DetUnit+3*gmSEQ.pi+2*PulseGap gSG3.AWGFreq pi gSG3.AWGAmp]; 
end
WaveForm_4Q = WaveForm_4I - repmat([0 0 0 pi/2 0], size(WaveForm_4I, 1), 1);
WaveForm_4Length = ceil((gmSEQ.halfpi+SquTime+RotTime+gmSEQ.DEERhalfpi+8*DetN*DetUnit+1000) / (16 / gSG3.AWGClockRate)) ...
    *(16 / gSG3.AWGClockRate);
WaveForm_4PointNum = WaveForm_4Length * gSG3.AWGClockRate;

chaseFunctionPool('createWaveform', WaveForm_1I, gSG2.P1AWGClockRate, WaveForm_1Length, 'Squeezing_Double_T2XY8_I_seg1.txt'); pause(0.5);
chaseFunctionPool('createWaveform', WaveForm_1Q, gSG2.P1AWGClockRate, WaveForm_1Length, 'Squeezing_Double_T2XY8_Q_seg1.txt'); pause(0.5);
chaseFunctionPool('createWaveform', WaveForm_2I, gSG2.P1AWGClockRate, WaveForm_2Length, 'Squeezing_Double_T2XY8_I_seg2.txt'); pause(0.5);
chaseFunctionPool('createWaveform', WaveForm_2Q, gSG2.P1AWGClockRate, WaveForm_2Length, 'Squeezing_Double_T2XY8_Q_seg2.txt'); pause(0.5);
chaseFunctionPool('createWaveform', WaveForm_3I, gSG.AWGClockRate, WaveForm_3Length, 'Squeezing_Double_T2XY8_I_seg3.txt'); pause(0.5);
chaseFunctionPool('createWaveform', WaveForm_3Q, gSG.AWGClockRate, WaveForm_3Length, 'Squeezing_Double_T2XY8_Q_seg3.txt'); pause(0.5);
chaseFunctionPool('createWaveform', WaveForm_4I, gSG3.AWGClockRate, WaveForm_4Length, 'Squeezing_Double_T2XY8_I_seg4.txt'); pause(0.5);
chaseFunctionPool('createWaveform', WaveForm_4Q, gSG3.AWGClockRate, WaveForm_4Length, 'Squeezing_Double_T2XY8_Q_seg4.txt'); pause(0.5);

chaseFunctionPool('createSegStruct', 'Squeezing_Double_T2XY8_SegStruct_I.txt', ...
    'Squeezing_Double_T2XY8_I_seg1.txt', WaveForm_1PointNum, 1, 1, ...
    'Squeezing_Double_T2XY8_I_seg2.txt', WaveForm_2PointNum, 1, 1);
pause(0.5);
chaseFunctionPool('createSegStruct', 'Squeezing_Double_T2XY8_SegStruct_Q.txt', ...
    'Squeezing_Double_T2XY8_Q_seg1.txt', WaveForm_1PointNum, 1, 1, ...
    'Squeezing_Double_T2XY8_Q_seg2.txt', WaveForm_2PointNum, 1, 1);
pause(0.5);
chaseFunctionPool('createSegStruct', 'Squeezing_Double_T2XY8_2_SegStruct_I.txt', ...
    'Squeezing_Double_T2XY8_I_seg3.txt', WaveForm_3PointNum, 1, 1, ...
    'Squeezing_Double_T2XY8_I_seg3.txt', WaveForm_3PointNum, 1, 1);
pause(0.5);
chaseFunctionPool('createSegStruct', 'Squeezing_Double_T2XY8_2_SegStruct_Q.txt', ...
    'Squeezing_Double_T2XY8_Q_seg3.txt', WaveForm_3PointNum, 1, 1, ...
    'Squeezing_Double_T2XY8_Q_seg3.txt', WaveForm_3PointNum, 1, 1);
pause(0.5);
chaseFunctionPool('createSegStruct', 'Squeezing_Double_T2XY8_3_SegStruct_I.txt', ...
    'Squeezing_Double_T2XY8_I_seg4.txt', WaveForm_4PointNum, 1, 1, ...
    'Squeezing_Double_T2XY8_I_seg4.txt', WaveForm_4PointNum, 1, 1);
pause(0.5);
chaseFunctionPool('createSegStruct', 'Squeezing_Double_T2XY8_3_SegStruct_Q.txt', ...
    'Squeezing_Double_T2XY8_Q_seg4.txt', WaveForm_4PointNum, 1, 1, ...
    'Squeezing_Double_T2XY8_Q_seg4.txt', WaveForm_4PointNum, 1, 1);
pause(0.5);

%% Load waveform to AWG
chaseFunctionPool('CreateSegments', gmSEQ.P1AWG, 1, ...
    2, ...
    2047, 2047, 'Squeezing_Double_T2XY8_SegStruct_I.txt', 'false');
pause(1); % this pause seems to be important, otherwise the loading is not right occassionally
chaseFunctionPool('CreateSegments', gmSEQ.P1AWG, 2, ...
    2, ...
    2047, 2047, 'Squeezing_Double_T2XY8_SegStruct_Q.txt', 'false');
pause(1); % this pause seems to be important, otherwise the loading is not right occassionally
chaseFunctionPool('CreateSegments', gmSEQ.MWAWG, 1, ...
    2, ...
    2047, 2047, 'Squeezing_Double_T2XY8_2_SegStruct_I.txt', 'false');
pause(1); % this pause seems to be important, otherwise the loading is not right occassionally
chaseFunctionPool('CreateSegments', gmSEQ.MWAWG, 2, ...
    2, ...
    2047, 2047, 'Squeezing_Double_T2XY8_2_SegStruct_Q.txt', 'false');
pause(1); % this pause seems to be important, otherwise the loading is not right occassionally
chaseFunctionPool('CreateSegments', gmSEQ.MWAWG2, 1, ...
    2, ...
    2047, 2047, 'Squeezing_Double_T2XY8_3_SegStruct_I.txt', 'false');
pause(1); % this pause seems to be important, otherwise the loading is not right occassionally
chaseFunctionPool('CreateSegments', gmSEQ.MWAWG2, 2, ...
    2, ...
    2047, 2047, 'Squeezing_Double_T2XY8_3_SegStruct_Q.txt', 'false');
pause(1); % this pause seems to be important, otherwise the loading is not right occassionally

%% Run waveform
chaseFunctionPool('runChase', gmSEQ.MWAWG, 'false'); pause(1);
chaseFunctionPool('runChase', gmSEQ.P1AWG, 'false'); pause(1);
chaseFunctionPool('runChase', gmSEQ.MWAWG2, 'false'); pause(1);
ApplyDelays();

function ENDOR_ODMR
global gmSEQ gSG gSG2
gSG.bfixedPow=1;
gSG.bfixedFreq=1;
gSG.bMod='IQ';
gSG.bModSrc='External';

gmSEQ.ScaleStr = "MHz";
gmSEQ.ScaleT = 1e3;

if gSG2.AWGAmp > 0.3
   error("Nuclear driving amplitude is beyond the safety limit.") 
end

ENDOR_freq = gmSEQ.m; % Freq of nuclear spin driving (in GHz)
ENDOR_time = gmSEQ.DEERpi;

AfterPi = 1000;
AfterLaser = 20000;
PulseGap = 50;
Detect_Window = 5000;

%%%%% Fixed sequence length %%%%%%

gmSEQ.CHN(1).PBN=PBDictionary('AOM');
gmSEQ.CHN(1).NRise=2;
gmSEQ.CHN(1).T=[0 gmSEQ.readout+AfterLaser+gmSEQ.pi+PulseGap+ENDOR_time+PulseGap+gmSEQ.pi+AfterPi];
gmSEQ.CHN(1).DT=[gmSEQ.readout Detect_Window];

gmSEQ.CHN(numel(gmSEQ.CHN)+1).PBN=PBDictionary('ctr0');
gmSEQ.CHN(numel(gmSEQ.CHN)).NRise=2;
gmSEQ.CHN(numel(gmSEQ.CHN)).T=[gmSEQ.readout-1000-gmSEQ.CtrGateDur gmSEQ.readout+AfterLaser+gmSEQ.pi+PulseGap+ENDOR_time+PulseGap+gmSEQ.pi+AfterPi];
gmSEQ.CHN(numel(gmSEQ.CHN)).DT=[gmSEQ.CtrGateDur gmSEQ.CtrGateDur];

gmSEQ.CHN(numel(gmSEQ.CHN)+1).PBN=PBDictionary('MWSwitch');
gmSEQ.CHN(numel(gmSEQ.CHN)).NRise=2;
gmSEQ.CHN(numel(gmSEQ.CHN)).T=[gmSEQ.readout+AfterLaser-20 gmSEQ.readout+AfterLaser+gmSEQ.pi+PulseGap+ENDOR_time+PulseGap-20];
gmSEQ.CHN(numel(gmSEQ.CHN)).DT=[gmSEQ.pi+40 gmSEQ.pi+40];

wait = 50e3;
gmSEQ.CHN(numel(gmSEQ.CHN)+1).PBN=PBDictionary('dummy1');
gmSEQ.CHN(numel(gmSEQ.CHN)).NRise=1;
gmSEQ.CHN(numel(gmSEQ.CHN)).T=gmSEQ.readout+AfterLaser+gmSEQ.pi+PulseGap+ENDOR_time+PulseGap+gmSEQ.pi+AfterPi+Detect_Window+wait-100;
gmSEQ.CHN(numel(gmSEQ.CHN)).DT=100;

gmSEQ.CHN(numel(gmSEQ.CHN) + 1).PBN = PBDictionary('AWGTrig');
gmSEQ.CHN(numel(gmSEQ.CHN)).NRise = 1;
gmSEQ.CHN(numel(gmSEQ.CHN)).T = gmSEQ.readout+AfterLaser;
gmSEQ.CHN(numel(gmSEQ.CHN)).DT = 200;

gmSEQ.CHN(numel(gmSEQ.CHN) + 1).PBN = PBDictionary('AWGTrig2');
gmSEQ.CHN(numel(gmSEQ.CHN)).NRise = 1;
gmSEQ.CHN(numel(gmSEQ.CHN)).T = gmSEQ.readout+AfterLaser+gmSEQ.pi+PulseGap;
gmSEQ.CHN(numel(gmSEQ.CHN)).DT = 200;

%% AWG
% Initialization
chaseFunctionPool('stopChase', gmSEQ.MWAWG);
chaseFunctionPool('stopChase', gmSEQ.P1AWG);

if ~gSG.ACmodAWG % in AC modulation mode
    gSG.AWGFreq = 0;
end
    
WaveForm_1I = [0 gmSEQ.pi gSG.AWGFreq 0 gSG.AWGAmp; ...
    gmSEQ.pi+PulseGap+ENDOR_time+PulseGap gmSEQ.pi+PulseGap+ENDOR_time+PulseGap+gmSEQ.pi gSG.AWGFreq pi gSG.AWGAmp;];
WaveForm_1Q = [0 gmSEQ.pi gSG.AWGFreq -pi/2 gSG.AWGAmp; ...
    gmSEQ.pi+PulseGap+ENDOR_time+PulseGap gmSEQ.pi+PulseGap+ENDOR_time+PulseGap+gmSEQ.pi gSG.AWGFreq pi/2 gSG.AWGAmp;];
WaveForm_1Length = ceil((gmSEQ.pi+PulseGap+ENDOR_time+PulseGap+gmSEQ.pi+1000) / (16 / gSG.AWGClockRate)) ...
    *(16 / gSG.AWGClockRate);
WaveForm_1PointNum = WaveForm_1Length * gSG.AWGClockRate;

% P1 sequence
WaveForm_2I = [0 ENDOR_time ENDOR_freq 0 gSG2.AWGAmp];
WaveForm_2Q = [0 ENDOR_time ENDOR_freq -pi/2 gSG2.AWGAmp];
WaveForm_2Length = ceil((ENDOR_time+1000) / (16 / gSG2.P1AWGClockRate)) ...
    *(16 / gSG2.P1AWGClockRate);
WaveForm_2PointNum = WaveForm_2Length * gSG2.P1AWGClockRate;
                
chaseFunctionPool('createWaveform', WaveForm_1I, gSG.AWGClockRate, WaveForm_1Length, 'ENDOR_ODMR_I_seg1.txt'); pause(0.5);
chaseFunctionPool('createWaveform', WaveForm_1Q, gSG.AWGClockRate, WaveForm_1Length, 'ENDOR_ODMR_Q_seg1.txt'); pause(0.5);
chaseFunctionPool('createWaveform', WaveForm_2I, gSG.AWGClockRate, WaveForm_2Length, 'ENDOR_ODMR_I_seg2.txt'); pause(0.5);
chaseFunctionPool('createWaveform', WaveForm_2Q, gSG.AWGClockRate, WaveForm_2Length, 'ENDOR_ODMR_Q_seg2.txt'); pause(0.5);

chaseFunctionPool('createSegStruct', 'ENDOR_ODMR_SegStruct_I.txt', ...
    'ENDOR_ODMR_I_seg1.txt', WaveForm_1PointNum, 1, 1);
pause(0.5);
chaseFunctionPool('createSegStruct', 'ENDOR_ODMR_SegStruct_Q.txt', ...
    'ENDOR_ODMR_Q_seg1.txt', WaveForm_1PointNum, 1, 1);
pause(0.5);
chaseFunctionPool('createSegStruct', 'ENDOR_ODMR_P1_SegStruct_I.txt', ...
    'ENDOR_ODMR_I_seg2.txt', WaveForm_2PointNum, 1, 1);
pause(0.5);
chaseFunctionPool('createSegStruct', 'ENDOR_ODMR_P1_SegStruct_Q.txt', ...
    'ENDOR_ODMR_Q_seg2.txt', WaveForm_2PointNum, 1, 1);
pause(0.5);
chaseFunctionPool('CreateSegments', gmSEQ.MWAWG, 1, ...
    1, ...
    2047, 2047, 'ENDOR_ODMR_SegStruct_I.txt', 'false');
pause(1); % this pause seems to be important, otherwise the loading is not right occassionally
chaseFunctionPool('CreateSegments', gmSEQ.MWAWG, 2, ...
    1, ...
    2047, 2047, 'ENDOR_ODMR_SegStruct_Q.txt', 'false');
pause(1); % this pause seems to be important, otherwise the loading is not right occassionally
chaseFunctionPool('CreateSegments', gmSEQ.P1AWG, 1, ...
    1, ...
    2047, 2047, 'ENDOR_ODMR_P1_SegStruct_I.txt', 'false');
pause(1); % this pause seems to be important, otherwise the loading is not right occassionally   
chaseFunctionPool('CreateSegments', gmSEQ.P1AWG, 2, ...
    1, ...
    2047, 2047, 'ENDOR_ODMR_P1_SegStruct_Q.txt', 'false');
pause(1); % this pause seems to be important, otherwise the loading is not right occassionally   
chaseFunctionPool('runChase', gmSEQ.MWAWG, 'false'); pause(1); 
chaseFunctionPool('runChase', gmSEQ.P1AWG, 'false'); pause(1);
    
ApplyDelays();

function ENDOR_Rabi
global gmSEQ gSG gSG2
gSG.bfixedPow=1;
gSG.bfixedFreq=1;
gSG.bMod='IQ';
gSG.bModSrc='External';

[gmSEQ.ScaleT, gmSEQ.ScaleStr] = GetScale(gmSEQ.To);

if gSG2.AWGAmp > 0.3
   error("Nuclear driving amplitude is beyond the safety limit.") 
end

ENDOR_freq = gSG2.AWGFreq; % Freq of nuclear spin driving
% ENDOR_time = gmSEQ.m;
ENDOR_time = gmSEQ.To;

AfterPi = 1000;
AfterLaser = 20000;
PulseGap = 50;
Detect_Window = 5000;
disp(PulseGap)

%%%%% Fixed sequence length %%%%%%
gmSEQ.CHN(1).PBN=PBDictionary('AOM');
gmSEQ.CHN(1).NRise=2;
gmSEQ.CHN(1).T=[0 gmSEQ.readout+AfterLaser+gmSEQ.pi+PulseGap+ENDOR_time+PulseGap+gmSEQ.pi+AfterPi];
gmSEQ.CHN(1).DT=[gmSEQ.readout Detect_Window];

gmSEQ.CHN(numel(gmSEQ.CHN)+1).PBN=PBDictionary('ctr0');
gmSEQ.CHN(numel(gmSEQ.CHN)).NRise=2;
gmSEQ.CHN(numel(gmSEQ.CHN)).T=[gmSEQ.readout-1000-gmSEQ.CtrGateDur gmSEQ.readout+AfterLaser+gmSEQ.pi+PulseGap+ENDOR_time+PulseGap+gmSEQ.pi+AfterPi];
gmSEQ.CHN(numel(gmSEQ.CHN)).DT=[gmSEQ.CtrGateDur gmSEQ.CtrGateDur];

gmSEQ.CHN(numel(gmSEQ.CHN)+1).PBN=PBDictionary('MWSwitch');
gmSEQ.CHN(numel(gmSEQ.CHN)).NRise=2;
gmSEQ.CHN(numel(gmSEQ.CHN)).T=[gmSEQ.readout+AfterLaser-20 gmSEQ.readout+AfterLaser+gmSEQ.pi+PulseGap+ENDOR_time+PulseGap-20];
gmSEQ.CHN(numel(gmSEQ.CHN)).DT=[gmSEQ.pi+40 gmSEQ.pi+40];

wait = 50e3;
% wait = 10e3;
gmSEQ.CHN(numel(gmSEQ.CHN)+1).PBN=PBDictionary('dummy1');
gmSEQ.CHN(numel(gmSEQ.CHN)).NRise=1;
gmSEQ.CHN(numel(gmSEQ.CHN)).T=gmSEQ.readout+AfterLaser+gmSEQ.pi+PulseGap+ENDOR_time+PulseGap+gmSEQ.pi+AfterPi+Detect_Window+wait-100;
gmSEQ.CHN(numel(gmSEQ.CHN)).DT=100;

gmSEQ.CHN(numel(gmSEQ.CHN) + 1).PBN = PBDictionary('AWGTrig');
gmSEQ.CHN(numel(gmSEQ.CHN)).NRise = 1;
gmSEQ.CHN(numel(gmSEQ.CHN)).T = gmSEQ.readout+AfterLaser;
gmSEQ.CHN(numel(gmSEQ.CHN)).DT = 200;

gmSEQ.CHN(numel(gmSEQ.CHN) + 1).PBN = PBDictionary('AWGTrig2');
gmSEQ.CHN(numel(gmSEQ.CHN)).NRise = 1;
gmSEQ.CHN(numel(gmSEQ.CHN)).T = gmSEQ.readout+AfterLaser+gmSEQ.pi+PulseGap;
gmSEQ.CHN(numel(gmSEQ.CHN)).DT = 200;

%% AWG
% Initialization
chaseFunctionPool('stopChase', gmSEQ.MWAWG);
chaseFunctionPool('stopChase', gmSEQ.P1AWG);

if ~gSG.ACmodAWG % in AC modulation mode
    gSG.AWGFreq = 0;
end
    
WaveForm_1I = [0 gmSEQ.pi gSG.AWGFreq 0 gSG.AWGAmp; ...
    gmSEQ.pi+PulseGap+ENDOR_time+PulseGap gmSEQ.pi+PulseGap+ENDOR_time+PulseGap+gmSEQ.pi gSG.AWGFreq pi gSG.AWGAmp;];
WaveForm_1Q = [0 gmSEQ.pi gSG.AWGFreq -pi/2 gSG.AWGAmp; ...
    gmSEQ.pi+PulseGap+ENDOR_time+PulseGap gmSEQ.pi+PulseGap+ENDOR_time+PulseGap+gmSEQ.pi gSG.AWGFreq pi/2 gSG.AWGAmp;];
WaveForm_1Length = ceil((gmSEQ.pi+PulseGap+ENDOR_time+PulseGap+gmSEQ.pi+1000) / (16 / gSG.AWGClockRate)) ...
    *(16 / gSG.AWGClockRate);
WaveForm_1PointNum = WaveForm_1Length * gSG.AWGClockRate;

% P1 sequence
WaveForm_2I = [0 gmSEQ.m ENDOR_freq 0 gSG2.AWGAmp];
WaveForm_2Q = [0 gmSEQ.m ENDOR_freq -pi/2 gSG2.AWGAmp];
WaveForm_2Length = ceil((ENDOR_time+1000) / (16 / gSG2.P1AWGClockRate)) ...
    *(16 / gSG2.P1AWGClockRate);
WaveForm_2PointNum = WaveForm_2Length * gSG2.P1AWGClockRate;

chaseFunctionPool('createWaveform', WaveForm_1I, gSG.AWGClockRate, WaveForm_1Length, 'ENDOR_Rabi_I_seg1.txt'); pause(0.5);
chaseFunctionPool('createWaveform', WaveForm_1Q, gSG.AWGClockRate, WaveForm_1Length, 'ENDOR_Rabi_Q_seg1.txt'); pause(0.5);
chaseFunctionPool('createWaveform', WaveForm_2I, gSG.AWGClockRate, WaveForm_2Length, 'ENDOR_Rabi_I_seg2.txt'); pause(0.5);
chaseFunctionPool('createWaveform', WaveForm_2Q, gSG.AWGClockRate, WaveForm_2Length, 'ENDOR_Rabi_Q_seg2.txt'); pause(0.5);

chaseFunctionPool('createSegStruct', 'ENDOR_Rabi_SegStruct_I.txt', ...
    'ENDOR_Rabi_I_seg1.txt', WaveForm_1PointNum, 1, 1);
pause(0.5);
chaseFunctionPool('createSegStruct', 'ENDOR_Rabi_SegStruct_Q.txt', ...
    'ENDOR_Rabi_Q_seg1.txt', WaveForm_1PointNum, 1, 1);
pause(0.5);
chaseFunctionPool('createSegStruct', 'ENDOR_Rabi_P1_SegStruct_I.txt', ...
    'ENDOR_Rabi_I_seg2.txt', WaveForm_2PointNum, 1, 1);
pause(0.5);
chaseFunctionPool('createSegStruct', 'ENDOR_Rabi_P1_SegStruct_Q.txt', ...
    'ENDOR_Rabi_Q_seg2.txt', WaveForm_2PointNum, 1, 1);
pause(0.5);
chaseFunctionPool('CreateSegments', gmSEQ.MWAWG, 1, ...
    1, ...
    2047, 2047, 'ENDOR_Rabi_SegStruct_I.txt', 'false');
pause(1); % this pause seems to be important, otherwise the loading is not right occassionally
chaseFunctionPool('CreateSegments', gmSEQ.MWAWG, 2, ...
    1, ...
    2047, 2047, 'ENDOR_Rabi_SegStruct_Q.txt', 'false');
pause(1); % this pause seems to be important, otherwise the loading is not right occassionally
chaseFunctionPool('CreateSegments', gmSEQ.P1AWG, 1, ...
    1, ...
    2047, 2047, 'ENDOR_Rabi_P1_SegStruct_I.txt', 'false');
pause(1); % this pause seems to be important, otherwise the loading is not right occassionally   
chaseFunctionPool('CreateSegments', gmSEQ.P1AWG, 2, ...
    1, ...
    2047, 2047, 'ENDOR_Rabi_P1_SegStruct_Q.txt', 'false');
pause(1); % this pause seems to be important, otherwise the loading is not right occassionally   
chaseFunctionPool('runChase', gmSEQ.MWAWG, 'false'); pause(1); 
chaseFunctionPool('runChase', gmSEQ.P1AWG, 'false'); pause(1);
    
ApplyDelays();

function ENDOR_NV_ODMR
global gmSEQ gSG gSG2
gSG.bfixedPow=1;
gSG.bfixedFreq=1;
gSG.bMod='IQ';
gSG.bModSrc='External';

gmSEQ.ScaleT = 1e3;
gmSEQ.ScaleStr = "MHz";

if gSG2.AWGAmp > 0.3
   error("Nuclear driving amplitude is beyond the safety limit.") 
end

ENDOR_freq = gSG2.AWGFreq; % Freq of nuclear spin driving
ENDOR_time = gmSEQ.DEERpi;

AfterPi = 2000;
AfterLaser = 2000;
PulseGap = 50;
Detect_Window = 5000;

%%%%% Fixed sequence length %%%%%%

gmSEQ.CHN(1).PBN=PBDictionary('AOM');
gmSEQ.CHN(1).NRise=2;
gmSEQ.CHN(1).T=[0 gmSEQ.readout+AfterLaser+gmSEQ.pi+PulseGap+ENDOR_time+PulseGap+gmSEQ.pi+AfterPi];
gmSEQ.CHN(1).DT=[gmSEQ.readout Detect_Window];

gmSEQ.CHN(numel(gmSEQ.CHN)+1).PBN=PBDictionary('ctr0');
gmSEQ.CHN(numel(gmSEQ.CHN)).NRise=2;
gmSEQ.CHN(numel(gmSEQ.CHN)).T=[gmSEQ.readout-1000-gmSEQ.CtrGateDur gmSEQ.readout+AfterLaser+gmSEQ.pi+PulseGap+ENDOR_time+PulseGap+gmSEQ.pi+AfterPi];
gmSEQ.CHN(numel(gmSEQ.CHN)).DT=[gmSEQ.CtrGateDur gmSEQ.CtrGateDur];

gmSEQ.CHN(numel(gmSEQ.CHN)+1).PBN=PBDictionary('MWSwitch');
gmSEQ.CHN(numel(gmSEQ.CHN)).NRise=2;
gmSEQ.CHN(numel(gmSEQ.CHN)).T=[gmSEQ.readout+AfterLaser-20 gmSEQ.readout+AfterLaser+gmSEQ.pi+PulseGap+ENDOR_time+PulseGap-20];
gmSEQ.CHN(numel(gmSEQ.CHN)).DT=[gmSEQ.pi+40 gmSEQ.pi+40];

wait = 50e3;
gmSEQ.CHN(numel(gmSEQ.CHN)+1).PBN=PBDictionary('dummy1');
gmSEQ.CHN(numel(gmSEQ.CHN)).NRise=1;
gmSEQ.CHN(numel(gmSEQ.CHN)).T=gmSEQ.readout+AfterLaser+gmSEQ.pi+PulseGap+ENDOR_time+PulseGap+gmSEQ.pi+AfterPi+Detect_Window+wait-100;
gmSEQ.CHN(numel(gmSEQ.CHN)).DT=100;

gmSEQ.CHN(numel(gmSEQ.CHN) + 1).PBN = PBDictionary('AWGTrig');
gmSEQ.CHN(numel(gmSEQ.CHN)).NRise = 1;
gmSEQ.CHN(numel(gmSEQ.CHN)).T = gmSEQ.readout+AfterLaser;
gmSEQ.CHN(numel(gmSEQ.CHN)).DT = 200;

gmSEQ.CHN(numel(gmSEQ.CHN) + 1).PBN = PBDictionary('AWGTrig2');
gmSEQ.CHN(numel(gmSEQ.CHN)).NRise = 1;
gmSEQ.CHN(numel(gmSEQ.CHN)).T = gmSEQ.readout+AfterLaser+gmSEQ.pi+PulseGap;
gmSEQ.CHN(numel(gmSEQ.CHN)).DT = 200;

%% AWG
% Initialization
chaseFunctionPool('stopChase', gmSEQ.MWAWG);
chaseFunctionPool('stopChase', gmSEQ.P1AWG);

if ~gSG.ACmodAWG % in AC modulation mode
    gSG.AWGFreq = 0;
end
    
WaveForm_1I = [0 gmSEQ.pi gSG.AWGFreq 0 gSG.AWGAmp; ...
    gmSEQ.pi+PulseGap+ENDOR_time+PulseGap gmSEQ.pi+PulseGap+ENDOR_time+PulseGap+gmSEQ.pi gSG.AWGFreq-gmSEQ.m 0 gSG.AWGAmp;];
WaveForm_1Q = [0 gmSEQ.pi gSG.AWGFreq -pi/2 gSG.AWGAmp; ...
    gmSEQ.pi+PulseGap+ENDOR_time+PulseGap gmSEQ.pi+PulseGap+ENDOR_time+PulseGap+gmSEQ.pi gSG.AWGFreq-gmSEQ.m -pi/2 gSG.AWGAmp;];
WaveForm_1Length = ceil((gmSEQ.pi+PulseGap+ENDOR_time+PulseGap+gmSEQ.pi+1000) / (16 / gSG.AWGClockRate)) ...
    *(16 / gSG.AWGClockRate);
WaveForm_1PointNum = WaveForm_1Length * gSG.AWGClockRate;

% P1 sequence
WaveForm_2I = [0 ENDOR_time ENDOR_freq 0 gSG2.AWGAmp];
WaveForm_2Q = [0 ENDOR_time ENDOR_freq -pi/2 gSG2.AWGAmp];
WaveForm_2Length = ceil((ENDOR_time+1000) / (16 / gSG2.P1AWGClockRate)) ...
    *(16 / gSG2.P1AWGClockRate);
WaveForm_2PointNum = WaveForm_2Length * gSG2.P1AWGClockRate;

chaseFunctionPool('createWaveform', WaveForm_1I, gSG.AWGClockRate, WaveForm_1Length, 'ENDOR_Rabi_I_seg1.txt'); pause(0.5);
chaseFunctionPool('createWaveform', WaveForm_1Q, gSG.AWGClockRate, WaveForm_1Length, 'ENDOR_Rabi_Q_seg1.txt'); pause(0.5);
chaseFunctionPool('createWaveform', WaveForm_2I, gSG.AWGClockRate, WaveForm_2Length, 'ENDOR_Rabi_I_seg2.txt'); pause(0.5);
chaseFunctionPool('createWaveform', WaveForm_2Q, gSG.AWGClockRate, WaveForm_2Length, 'ENDOR_Rabi_Q_seg2.txt'); pause(0.5);

chaseFunctionPool('createSegStruct', 'ENDOR_Rabi_SegStruct_I.txt', ...
    'ENDOR_Rabi_I_seg1.txt', WaveForm_1PointNum, 1, 1);
pause(0.5);
chaseFunctionPool('createSegStruct', 'ENDOR_Rabi_SegStruct_Q.txt', ...
    'ENDOR_Rabi_Q_seg1.txt', WaveForm_1PointNum, 1, 1);
pause(0.5);
chaseFunctionPool('createSegStruct', 'ENDOR_Rabi_P1_SegStruct_I.txt', ...
    'ENDOR_Rabi_I_seg2.txt', WaveForm_2PointNum, 1, 1);
pause(0.5);
chaseFunctionPool('createSegStruct', 'ENDOR_Rabi_P1_SegStruct_Q.txt', ...
    'ENDOR_Rabi_Q_seg2.txt', WaveForm_2PointNum, 1, 1);
pause(0.5);
chaseFunctionPool('CreateSegments', gmSEQ.MWAWG, 1, ...
    1, ...
    2047, 2047, 'ENDOR_Rabi_SegStruct_I.txt', 'false');
pause(1); % this pause seems to be important, otherwise the loading is not right occassionally
chaseFunctionPool('CreateSegments', gmSEQ.MWAWG, 2, ...
    1, ...
    2047, 2047, 'ENDOR_Rabi_SegStruct_Q.txt', 'false');
pause(1); % this pause seems to be important, otherwise the loading is not right occassionally
chaseFunctionPool('CreateSegments', gmSEQ.P1AWG, 1, ...
    1, ...
    2047, 2047, 'ENDOR_Rabi_P1_SegStruct_I.txt', 'false');
pause(1); % this pause seems to be important, otherwise the loading is not right occassionally   
chaseFunctionPool('CreateSegments', gmSEQ.P1AWG, 2, ...
    1, ...
    2047, 2047, 'ENDOR_Rabi_P1_SegStruct_Q.txt', 'false');
pause(1); % this pause seems to be important, otherwise the loading is not right occassionally   
chaseFunctionPool('runChase', gmSEQ.MWAWG, 'false'); pause(1); 
chaseFunctionPool('runChase', gmSEQ.P1AWG, 'false'); pause(1);
    
ApplyDelays();

function ENDOR_NV_Rabi
global gmSEQ gSG gSG2
gSG.bfixedPow=1;
gSG.bfixedFreq=1;
gSG.bMod='IQ';
gSG.bModSrc='External';

[gmSEQ.ScaleT, gmSEQ.ScaleStr] = GetScale(gmSEQ.To);

if gSG2.AWGAmp > 0.3
   error("Nuclear driving amplitude is beyond the safety limit.") 
end

ENDOR_freq = gSG2.AWGFreq; % Freq of nuclear spin driving
ENDOR_time = gmSEQ.DEERpi;

AfterPi = 1000;
AfterLaser = 20000;
PulseGap = 50;
Detect_Window = 5000;

%%%%% Fixed sequence length %%%%%%

gmSEQ.CHN(1).PBN=PBDictionary('AOM');
gmSEQ.CHN(1).NRise=2;
gmSEQ.CHN(1).T=[0 gmSEQ.readout+AfterLaser+gmSEQ.pi+PulseGap+ENDOR_time+PulseGap+gmSEQ.m+AfterPi];
gmSEQ.CHN(1).DT=[gmSEQ.readout Detect_Window];

gmSEQ.CHN(numel(gmSEQ.CHN)+1).PBN=PBDictionary('ctr0');
gmSEQ.CHN(numel(gmSEQ.CHN)).NRise=2;
gmSEQ.CHN(numel(gmSEQ.CHN)).T=[gmSEQ.readout-1000-gmSEQ.CtrGateDur gmSEQ.readout+AfterLaser+gmSEQ.pi+PulseGap+ENDOR_time+PulseGap+gmSEQ.m+AfterPi];
gmSEQ.CHN(numel(gmSEQ.CHN)).DT=[gmSEQ.CtrGateDur gmSEQ.CtrGateDur];

gmSEQ.CHN(numel(gmSEQ.CHN)+1).PBN=PBDictionary('MWSwitch');
gmSEQ.CHN(numel(gmSEQ.CHN)).NRise=2;
gmSEQ.CHN(numel(gmSEQ.CHN)).T=[gmSEQ.readout+AfterLaser-20 gmSEQ.readout+AfterLaser+gmSEQ.pi+PulseGap+ENDOR_time+PulseGap-20];
gmSEQ.CHN(numel(gmSEQ.CHN)).DT=[gmSEQ.pi+40 gmSEQ.m+40];

wait = 1e3;
gmSEQ.CHN(numel(gmSEQ.CHN)+1).PBN=PBDictionary('dummy1');
gmSEQ.CHN(numel(gmSEQ.CHN)).NRise=1;
gmSEQ.CHN(numel(gmSEQ.CHN)).T=gmSEQ.readout+AfterLaser+gmSEQ.pi+PulseGap+ENDOR_time+PulseGap+gmSEQ.m+AfterPi+Detect_Window+wait-100;
gmSEQ.CHN(numel(gmSEQ.CHN)).DT=100;

gmSEQ.CHN(numel(gmSEQ.CHN) + 1).PBN = PBDictionary('AWGTrig');
gmSEQ.CHN(numel(gmSEQ.CHN)).NRise = 1;
gmSEQ.CHN(numel(gmSEQ.CHN)).T = gmSEQ.readout+AfterLaser;
gmSEQ.CHN(numel(gmSEQ.CHN)).DT = 200;

gmSEQ.CHN(numel(gmSEQ.CHN) + 1).PBN = PBDictionary('AWGTrig2');
gmSEQ.CHN(numel(gmSEQ.CHN)).NRise = 1;
gmSEQ.CHN(numel(gmSEQ.CHN)).T = gmSEQ.readout+AfterLaser+gmSEQ.pi+PulseGap;
gmSEQ.CHN(numel(gmSEQ.CHN)).DT = 200;

%% AWG
% Initialization
chaseFunctionPool('stopChase', gmSEQ.MWAWG);
chaseFunctionPool('stopChase', gmSEQ.P1AWG);

if ~gSG.ACmodAWG % in AC modulation mode
    gSG.AWGFreq = 0;
end
    
WaveForm_1I = [0 gmSEQ.pi gSG.AWGFreq 0 gSG.AWGAmp; ...
    gmSEQ.pi+PulseGap+ENDOR_time+PulseGap gmSEQ.pi+PulseGap+ENDOR_time+PulseGap+gmSEQ.m gSG.AWGFreq-gmSEQ.SAmp1 0 gSG.AWGAmp;];
WaveForm_1Q = [0 gmSEQ.pi gSG.AWGFreq -pi/2 gSG.AWGAmp; ...
    gmSEQ.pi+PulseGap+ENDOR_time+PulseGap gmSEQ.pi+PulseGap+ENDOR_time+PulseGap+gmSEQ.m gSG.AWGFreq-gmSEQ.SAmp1 -pi/2 gSG.AWGAmp;];
WaveForm_1Length = ceil((gmSEQ.pi+PulseGap+ENDOR_time+PulseGap+gmSEQ.m+1000) / (16 / gSG.AWGClockRate)) ...
    *(16 / gSG.AWGClockRate);
WaveForm_1PointNum = WaveForm_1Length * gSG.AWGClockRate;

% P1 sequence
WaveForm_2I = [0 ENDOR_time ENDOR_freq 0 gSG2.AWGAmp];
WaveForm_2Q = [0 ENDOR_time ENDOR_freq -pi/2 gSG2.AWGAmp];
WaveForm_2Length = ceil((ENDOR_time+1000) / (16 / gSG2.P1AWGClockRate)) ...
    *(16 / gSG2.P1AWGClockRate);
WaveForm_2PointNum = WaveForm_2Length * gSG2.P1AWGClockRate;

chaseFunctionPool('createWaveform', WaveForm_1I, gSG.AWGClockRate, WaveForm_1Length, 'ENDOR_Rabi_I_seg1.txt'); pause(0.5);
chaseFunctionPool('createWaveform', WaveForm_1Q, gSG.AWGClockRate, WaveForm_1Length, 'ENDOR_Rabi_Q_seg1.txt'); pause(0.5);
chaseFunctionPool('createWaveform', WaveForm_2I, gSG.AWGClockRate, WaveForm_2Length, 'ENDOR_Rabi_I_seg2.txt'); pause(0.5);
chaseFunctionPool('createWaveform', WaveForm_2Q, gSG.AWGClockRate, WaveForm_2Length, 'ENDOR_Rabi_Q_seg2.txt'); pause(0.5);

chaseFunctionPool('createSegStruct', 'ENDOR_Rabi_SegStruct_I.txt', ...
    'ENDOR_Rabi_I_seg1.txt', WaveForm_1PointNum, 1, 1);
pause(0.5);
chaseFunctionPool('createSegStruct', 'ENDOR_Rabi_SegStruct_Q.txt', ...
    'ENDOR_Rabi_Q_seg1.txt', WaveForm_1PointNum, 1, 1);
pause(0.5);
chaseFunctionPool('createSegStruct', 'ENDOR_Rabi_P1_SegStruct_I.txt', ...
    'ENDOR_Rabi_I_seg2.txt', WaveForm_2PointNum, 1, 1);
pause(0.5);
chaseFunctionPool('createSegStruct', 'ENDOR_Rabi_P1_SegStruct_Q.txt', ...
    'ENDOR_Rabi_Q_seg2.txt', WaveForm_2PointNum, 1, 1);
pause(0.5);
chaseFunctionPool('CreateSegments', gmSEQ.MWAWG, 1, ...
    1, ...
    2047, 2047, 'ENDOR_Rabi_SegStruct_I.txt', 'false');
pause(1); % this pause seems to be important, otherwise the loading is not right occassionally
chaseFunctionPool('CreateSegments', gmSEQ.MWAWG, 2, ...
    1, ...
    2047, 2047, 'ENDOR_Rabi_SegStruct_Q.txt', 'false');
pause(1); % this pause seems to be important, otherwise the loading is not right occassionally
chaseFunctionPool('CreateSegments', gmSEQ.P1AWG, 1, ...
    1, ...
    2047, 2047, 'ENDOR_Rabi_P1_SegStruct_I.txt', 'false');
pause(1); % this pause seems to be important, otherwise the loading is not right occassionally   
chaseFunctionPool('CreateSegments', gmSEQ.P1AWG, 2, ...
    1, ...
    2047, 2047, 'ENDOR_Rabi_P1_SegStruct_Q.txt', 'false');
pause(1); % this pause seems to be important, otherwise the loading is not right occassionally   
chaseFunctionPool('runChase', gmSEQ.MWAWG, 'false'); pause(1); 
chaseFunctionPool('runChase', gmSEQ.P1AWG, 'false'); pause(1);
    
ApplyDelays();

function ENDOR_NV_Rabi2
global gmSEQ gSG gSG2
gSG.bfixedPow=1;
gSG.bfixedFreq=1;
gSG.bMod='IQ';
gSG.bModSrc='External';

if gSG2.AWGAmp > 0.3
   error("Nuclear driving amplitude is beyond the safety limit.") 
end

ENDOR_freq = gSG2.AWGFreq; % Freq of nuclear spin driving
ENDOR_time = gmSEQ.DEERpi;

AfterPi = 1000;
AfterLaser = 20000;
PulseGap = 4000;
Detect_Window = 5000;

%%%%% Fixed sequence length %%%%%%
gmSEQ.CHN(1).PBN=PBDictionary('AOM');
gmSEQ.CHN(1).NRise=2;
gmSEQ.CHN(1).T=[0 gmSEQ.readout+AfterLaser+ENDOR_time+PulseGap+gmSEQ.To+AfterPi];
gmSEQ.CHN(1).DT=[gmSEQ.readout Detect_Window];

gmSEQ.CHN(numel(gmSEQ.CHN)+1).PBN=PBDictionary('ctr0');
gmSEQ.CHN(numel(gmSEQ.CHN)).NRise=2;
gmSEQ.CHN(numel(gmSEQ.CHN)).T=[gmSEQ.readout-1000-gmSEQ.CtrGateDur gmSEQ.readout+AfterLaser+ENDOR_time+PulseGap+gmSEQ.To+AfterPi];
gmSEQ.CHN(numel(gmSEQ.CHN)).DT=[gmSEQ.CtrGateDur gmSEQ.CtrGateDur];

gmSEQ.CHN(numel(gmSEQ.CHN)+1).PBN=PBDictionary('MWSwitch');
gmSEQ.CHN(numel(gmSEQ.CHN)).NRise=1;
gmSEQ.CHN(numel(gmSEQ.CHN)).T=[gmSEQ.readout+AfterLaser+ENDOR_time+PulseGap-20];
gmSEQ.CHN(numel(gmSEQ.CHN)).DT=[gmSEQ.m+40];

wait = 2e3;
gmSEQ.CHN(numel(gmSEQ.CHN)+1).PBN=PBDictionary('dummy1');
gmSEQ.CHN(numel(gmSEQ.CHN)).NRise=1;
gmSEQ.CHN(numel(gmSEQ.CHN)).T=gmSEQ.readout+AfterLaser+ENDOR_time+PulseGap+gmSEQ.To+AfterPi+Detect_Window+wait-100;
gmSEQ.CHN(numel(gmSEQ.CHN)).DT=100;

gmSEQ.CHN(numel(gmSEQ.CHN) + 1).PBN = PBDictionary('AWGTrig');
gmSEQ.CHN(numel(gmSEQ.CHN)).NRise = 1;
gmSEQ.CHN(numel(gmSEQ.CHN)).T = gmSEQ.readout+AfterLaser+ENDOR_time+PulseGap;
gmSEQ.CHN(numel(gmSEQ.CHN)).DT = 200;

gmSEQ.CHN(numel(gmSEQ.CHN) + 1).PBN = PBDictionary('AWGTrig2');
gmSEQ.CHN(numel(gmSEQ.CHN)).NRise = 1;
gmSEQ.CHN(numel(gmSEQ.CHN)).T = gmSEQ.readout+AfterLaser;
gmSEQ.CHN(numel(gmSEQ.CHN)).DT = 200;

%% AWG
% Initialization
chaseFunctionPool('stopChase', gmSEQ.MWAWG);
chaseFunctionPool('stopChase', gmSEQ.P1AWG);

if ~gSG.ACmodAWG % in AC modulation mode
    gSG.AWGFreq = 0;
end
    
WaveForm_1I = [0 gmSEQ.m gSG.AWGFreq 0 gSG.AWGAmp;];
WaveForm_1Q = [0 gmSEQ.m gSG.AWGFreq -pi/2 gSG.AWGAmp;];
WaveForm_1Length = ceil((gmSEQ.m+1000) / (16 / gSG.AWGClockRate)) ...
    *(16 / gSG.AWGClockRate);
WaveForm_1PointNum = WaveForm_1Length * gSG.AWGClockRate;

% P1 sequence
WaveForm_2I = [0 ENDOR_time ENDOR_freq 0 gSG2.AWGAmp];
WaveForm_2Q = [0 ENDOR_time ENDOR_freq -pi/2 gSG2.AWGAmp];
WaveForm_2Length = ceil((ENDOR_time+1000) / (16 / gSG2.P1AWGClockRate)) ...
    *(16 / gSG2.P1AWGClockRate);
WaveForm_2PointNum = WaveForm_2Length * gSG2.P1AWGClockRate;

chaseFunctionPool('createWaveform', WaveForm_1I, gSG.AWGClockRate, WaveForm_1Length, 'ENDOR_Rabi_I_seg1.txt'); pause(0.5);
chaseFunctionPool('createWaveform', WaveForm_1Q, gSG.AWGClockRate, WaveForm_1Length, 'ENDOR_Rabi_Q_seg1.txt'); pause(0.5);
chaseFunctionPool('createWaveform', WaveForm_2I, gSG.AWGClockRate, WaveForm_2Length, 'ENDOR_Rabi_I_seg2.txt'); pause(0.5);
chaseFunctionPool('createWaveform', WaveForm_2Q, gSG.AWGClockRate, WaveForm_2Length, 'ENDOR_Rabi_Q_seg2.txt'); pause(0.5);

chaseFunctionPool('createSegStruct', 'ENDOR_Rabi_SegStruct_I.txt', ...
    'ENDOR_Rabi_I_seg1.txt', WaveForm_1PointNum, 1, 1);
pause(0.5);
chaseFunctionPool('createSegStruct', 'ENDOR_Rabi_SegStruct_Q.txt', ...
    'ENDOR_Rabi_Q_seg1.txt', WaveForm_1PointNum, 1, 1);
pause(0.5);
chaseFunctionPool('createSegStruct', 'ENDOR_Rabi_P1_SegStruct_I.txt', ...
    'ENDOR_Rabi_I_seg2.txt', WaveForm_2PointNum, 1, 1);
pause(0.5);
chaseFunctionPool('createSegStruct', 'ENDOR_Rabi_P1_SegStruct_Q.txt', ...
    'ENDOR_Rabi_Q_seg2.txt', WaveForm_2PointNum, 1, 1);
pause(0.5);
chaseFunctionPool('CreateSegments', gmSEQ.MWAWG, 1, ...
    1, ...
    2047, 2047, 'ENDOR_Rabi_SegStruct_I.txt', 'false');
pause(1); % this pause seems to be important, otherwise the loading is not right occassionally
chaseFunctionPool('CreateSegments', gmSEQ.MWAWG, 2, ...
    1, ...
    2047, 2047, 'ENDOR_Rabi_SegStruct_Q.txt', 'false');
pause(1); % this pause seems to be important, otherwise the loading is not right occassionally
chaseFunctionPool('CreateSegments', gmSEQ.P1AWG, 1, ...
    1, ...
    2047, 2047, 'ENDOR_Rabi_P1_SegStruct_I.txt', 'false');
pause(1); % this pause seems to be important, otherwise the loading is not right occassionally   
chaseFunctionPool('CreateSegments', gmSEQ.P1AWG, 2, ...
    1, ...
    2047, 2047, 'ENDOR_Rabi_P1_SegStruct_Q.txt', 'false');
pause(1); % this pause seems to be important, otherwise the loading is not right occassionally   
chaseFunctionPool('runChase', gmSEQ.MWAWG, 'false'); pause(1); 
chaseFunctionPool('runChase', gmSEQ.P1AWG, 'false'); pause(1);
    
ApplyDelays();

function ENDOR_ODMR2
global gmSEQ gSG gSG2
gSG.bfixedPow=1;
gSG.bfixedFreq=1;
gSG.bMod='IQ';
gSG.bModSrc='External';

gmSEQ.ScaleStr = "MHz";
gmSEQ.ScaleT = 1e3;

if gSG2.AWGAmp > 0.3
   error("Nuclear driving amplitude is beyond the safety limit.") 
end

ENDOR_freq = gmSEQ.m; % Freq of nuclear spin driving (in GHz)
ENDOR_time = gmSEQ.DEERpi;

AfterPi = 1000;
AfterLaser = 10000;
PulseGap = 50;
PulseGap_long = 10000;
Detect_Window = 5000;

%%%%% Fixed sequence length %%%%%%

gmSEQ.CHN(1).PBN=PBDictionary('AOM');
gmSEQ.CHN(1).NRise=2;
gmSEQ.CHN(1).T=[0 gmSEQ.readout+AfterLaser+gmSEQ.halfpi+PulseGap_long+ENDOR_time+PulseGap+gmSEQ.pi+AfterPi];
gmSEQ.CHN(1).DT=[gmSEQ.readout Detect_Window];

gmSEQ.CHN(numel(gmSEQ.CHN)+1).PBN=PBDictionary('ctr0');
gmSEQ.CHN(numel(gmSEQ.CHN)).NRise=2;
gmSEQ.CHN(numel(gmSEQ.CHN)).T=[gmSEQ.readout-1000-gmSEQ.CtrGateDur gmSEQ.readout+AfterLaser+gmSEQ.halfpi+PulseGap_long+ENDOR_time+PulseGap+gmSEQ.pi+AfterPi];
gmSEQ.CHN(numel(gmSEQ.CHN)).DT=[gmSEQ.CtrGateDur gmSEQ.CtrGateDur];

gmSEQ.CHN(numel(gmSEQ.CHN)+1).PBN=PBDictionary('MWSwitch');
gmSEQ.CHN(numel(gmSEQ.CHN)).NRise=2;
gmSEQ.CHN(numel(gmSEQ.CHN)).T=[gmSEQ.readout+AfterLaser-20 gmSEQ.readout+AfterLaser+gmSEQ.halfpi+PulseGap_long+ENDOR_time+PulseGap-20];
gmSEQ.CHN(numel(gmSEQ.CHN)).DT=[gmSEQ.halfpi+40 gmSEQ.pi+40];

wait = 50e3;
gmSEQ.CHN(numel(gmSEQ.CHN)+1).PBN=PBDictionary('dummy1');
gmSEQ.CHN(numel(gmSEQ.CHN)).NRise=1;
gmSEQ.CHN(numel(gmSEQ.CHN)).T=gmSEQ.readout+AfterLaser+gmSEQ.halfpi+PulseGap_long+ENDOR_time+PulseGap+gmSEQ.pi+AfterPi+Detect_Window+wait-100;
gmSEQ.CHN(numel(gmSEQ.CHN)).DT=100;

gmSEQ.CHN(numel(gmSEQ.CHN) + 1).PBN = PBDictionary('AWGTrig');
gmSEQ.CHN(numel(gmSEQ.CHN)).NRise = 1;
gmSEQ.CHN(numel(gmSEQ.CHN)).T = gmSEQ.readout+AfterLaser;
gmSEQ.CHN(numel(gmSEQ.CHN)).DT = 200;

gmSEQ.CHN(numel(gmSEQ.CHN) + 1).PBN = PBDictionary('AWGTrig2');
gmSEQ.CHN(numel(gmSEQ.CHN)).NRise = 1;
gmSEQ.CHN(numel(gmSEQ.CHN)).T = gmSEQ.readout+AfterLaser+gmSEQ.halfpi+PulseGap_long;
gmSEQ.CHN(numel(gmSEQ.CHN)).DT = 200;

%% AWG
% Initialization
chaseFunctionPool('stopChase', gmSEQ.MWAWG);
chaseFunctionPool('stopChase', gmSEQ.P1AWG);

if ~gSG.ACmodAWG % in AC modulation mode
    gSG.AWGFreq = 0;
end
    
WaveForm_1I = [0 gmSEQ.halfpi gSG.AWGFreq 0 gSG.AWGAmp; ...
    gmSEQ.halfpi+PulseGap_long+ENDOR_time+PulseGap gmSEQ.halfpi+PulseGap_long+ENDOR_time+PulseGap+gmSEQ.pi gSG.AWGFreq 0 gSG.AWGAmp;];
WaveForm_1Q = [0 gmSEQ.halfpi gSG.AWGFreq -pi/2 gSG.AWGAmp; ...
    gmSEQ.halfpi+PulseGap_long+ENDOR_time+PulseGap gmSEQ.halfpi+PulseGap_long+ENDOR_time+PulseGap+gmSEQ.pi gSG.AWGFreq -pi/2 gSG.AWGAmp;];
WaveForm_1Length = ceil((gmSEQ.halfpi+PulseGap_long+ENDOR_time+PulseGap+gmSEQ.pi+1000) / (16 / gSG.AWGClockRate)) ...
    *(16 / gSG.AWGClockRate);
WaveForm_1PointNum = WaveForm_1Length * gSG.AWGClockRate;

% P1 sequence
WaveForm_2I = [0 ENDOR_time ENDOR_freq 0 gSG2.AWGAmp];
WaveForm_2Q = [0 ENDOR_time ENDOR_freq -pi/2 gSG2.AWGAmp];
WaveForm_2Length = ceil((ENDOR_time+1000) / (16 / gSG2.P1AWGClockRate)) ...
    *(16 / gSG2.P1AWGClockRate);
WaveForm_2PointNum = WaveForm_2Length * gSG2.P1AWGClockRate;
                
chaseFunctionPool('createWaveform', WaveForm_1I, gSG.AWGClockRate, WaveForm_1Length, 'ENDOR_ODMR_I_seg1.txt'); pause(0.5);
chaseFunctionPool('createWaveform', WaveForm_1Q, gSG.AWGClockRate, WaveForm_1Length, 'ENDOR_ODMR_Q_seg1.txt'); pause(0.5);
chaseFunctionPool('createWaveform', WaveForm_2I, gSG2.P1AWGClockRate, WaveForm_2Length, 'ENDOR_ODMR_I_seg2.txt'); pause(0.5);
chaseFunctionPool('createWaveform', WaveForm_2Q, gSG2.P1AWGClockRate, WaveForm_2Length, 'ENDOR_ODMR_Q_seg2.txt'); pause(0.5);

chaseFunctionPool('createSegStruct', 'ENDOR_ODMR_SegStruct_I.txt', ...
    'ENDOR_ODMR_I_seg1.txt', WaveForm_1PointNum, 1, 1);
pause(0.5);
chaseFunctionPool('createSegStruct', 'ENDOR_ODMR_SegStruct_Q.txt', ...
    'ENDOR_ODMR_Q_seg1.txt', WaveForm_1PointNum, 1, 1);
pause(0.5);
chaseFunctionPool('createSegStruct', 'ENDOR_ODMR_P1_SegStruct_I.txt', ...
    'ENDOR_ODMR_I_seg2.txt', WaveForm_2PointNum, 1, 1);
pause(0.5);
chaseFunctionPool('createSegStruct', 'ENDOR_ODMR_P1_SegStruct_Q.txt', ...
    'ENDOR_ODMR_Q_seg2.txt', WaveForm_2PointNum, 1, 1);
pause(0.5);
chaseFunctionPool('CreateSegments', gmSEQ.MWAWG, 1, ...
    1, ...
    2047, 2047, 'ENDOR_ODMR_SegStruct_I.txt', 'false');
pause(1); % this pause seems to be important, otherwise the loading is not right occassionally
chaseFunctionPool('CreateSegments', gmSEQ.MWAWG, 2, ...
    1, ...
    2047, 2047, 'ENDOR_ODMR_SegStruct_Q.txt', 'false');
pause(1); % this pause seems to be important, otherwise the loading is not right occassionally
chaseFunctionPool('CreateSegments', gmSEQ.P1AWG, 1, ...
    1, ...
    2047, 2047, 'ENDOR_ODMR_P1_SegStruct_I.txt', 'false');
pause(1); % this pause seems to be important, otherwise the loading is not right occassionally   
chaseFunctionPool('CreateSegments', gmSEQ.P1AWG, 2, ...
    1, ...
    2047, 2047, 'ENDOR_ODMR_P1_SegStruct_Q.txt', 'false');
pause(1); % this pause seems to be important, otherwise the loading is not right occassionally   
chaseFunctionPool('runChase', gmSEQ.MWAWG, 'false'); pause(1); 
chaseFunctionPool('runChase', gmSEQ.P1AWG, 'false'); pause(1);
    
ApplyDelays();

function Elec_Pol_Extract
global gmSEQ gSG gSG2
gSG.bfixedPow=1;
gSG.bfixedFreq=1;
gSG.bMod='IQ';
gSG.bModSrc='External';

if gSG2.AWGAmp > 0.3
   error("Nuclear driving amplitude is beyond the safety limit.") 
end

ENDOR_freq = gSG2.AWGFreq; % Freq of nuclear spin driving
ENDOR_time = gmSEQ.DEERpi;

AfterPi = 1000;
AfterLaser = 20000;
PulseGap = gmSEQ.SAmp2;
PulseGap_long = 20000;
Detect_Window = 5000;
wait = 20e3;
Sig_D_start = gmSEQ.readout+AfterLaser+gmSEQ.halfpi+PulseGap_long+ENDOR_time+PulseGap+gmSEQ.To+AfterPi+Detect_Window+wait;

% disp(PulseGap)

%%%%% Fixed sequence length %%%%%%
gmSEQ.CHN(1).PBN=PBDictionary('AOM');
gmSEQ.CHN(1).NRise=4;
gmSEQ.CHN(1).T=[0 gmSEQ.readout+AfterLaser+gmSEQ.halfpi+PulseGap_long+ENDOR_time+PulseGap+gmSEQ.To+AfterPi ... 
    Sig_D_start Sig_D_start+gmSEQ.readout+AfterLaser+gmSEQ.halfpi+PulseGap_long+ENDOR_time+PulseGap+gmSEQ.To+AfterPi];
gmSEQ.CHN(1).DT=[gmSEQ.readout Detect_Window gmSEQ.readout Detect_Window];

gmSEQ.CHN(numel(gmSEQ.CHN)+1).PBN=PBDictionary('ctr0');
gmSEQ.CHN(numel(gmSEQ.CHN)).NRise=4;
gmSEQ.CHN(numel(gmSEQ.CHN)).T=[gmSEQ.readout-1000-gmSEQ.CtrGateDur gmSEQ.readout+AfterLaser+gmSEQ.halfpi+PulseGap_long+ENDOR_time+PulseGap+gmSEQ.To+AfterPi ...
    Sig_D_start+gmSEQ.readout-1000-gmSEQ.CtrGateDur Sig_D_start+gmSEQ.readout+AfterLaser+gmSEQ.halfpi+PulseGap_long+ENDOR_time+PulseGap+gmSEQ.To+AfterPi];
gmSEQ.CHN(numel(gmSEQ.CHN)).DT=[gmSEQ.CtrGateDur gmSEQ.CtrGateDur gmSEQ.CtrGateDur gmSEQ.CtrGateDur];

gmSEQ.CHN(numel(gmSEQ.CHN)+1).PBN=PBDictionary('MWSwitch');
gmSEQ.CHN(numel(gmSEQ.CHN)).NRise=4;
gmSEQ.CHN(numel(gmSEQ.CHN)).T=[gmSEQ.readout+AfterLaser-20 gmSEQ.readout+AfterLaser+gmSEQ.halfpi+PulseGap_long+ENDOR_time+PulseGap-20 ...
    Sig_D_start+gmSEQ.readout+AfterLaser-20 Sig_D_start+gmSEQ.readout+AfterLaser+gmSEQ.halfpi+PulseGap_long+ENDOR_time+PulseGap-20];
gmSEQ.CHN(numel(gmSEQ.CHN)).DT=[gmSEQ.halfpi+40 gmSEQ.m+40 gmSEQ.halfpi+40 gmSEQ.m+40];


gmSEQ.CHN(numel(gmSEQ.CHN)+1).PBN=PBDictionary('dummy1');
gmSEQ.CHN(numel(gmSEQ.CHN)).NRise=1;
gmSEQ.CHN(numel(gmSEQ.CHN)).T=2*Sig_D_start-100;
gmSEQ.CHN(numel(gmSEQ.CHN)).DT=100;

gmSEQ.CHN(numel(gmSEQ.CHN) + 1).PBN = PBDictionary('AWGTrig');
gmSEQ.CHN(numel(gmSEQ.CHN)).NRise = 2;
gmSEQ.CHN(numel(gmSEQ.CHN)).T = [gmSEQ.readout+AfterLaser Sig_D_start+gmSEQ.readout+AfterLaser];
gmSEQ.CHN(numel(gmSEQ.CHN)).DT = [200 200];

gmSEQ.CHN(numel(gmSEQ.CHN) + 1).PBN = PBDictionary('AWGTrig2');
gmSEQ.CHN(numel(gmSEQ.CHN)).NRise = 2;
gmSEQ.CHN(numel(gmSEQ.CHN)).T = [gmSEQ.readout+AfterLaser+gmSEQ.halfpi+PulseGap_long Sig_D_start+gmSEQ.readout+AfterLaser+gmSEQ.halfpi+PulseGap_long];
gmSEQ.CHN(numel(gmSEQ.CHN)).DT = [200 200];

%% AWG
% Initialization
chaseFunctionPool('stopChase', gmSEQ.MWAWG);
chaseFunctionPool('stopChase', gmSEQ.P1AWG);

if ~gSG.ACmodAWG % in AC modulation mode
    gSG.AWGFreq = 0;
end
    
WaveForm_1I = [0 gmSEQ.halfpi gSG.AWGFreq 0 gSG.AWGAmp; ...
    gmSEQ.halfpi+PulseGap_long+ENDOR_time+PulseGap gmSEQ.halfpi+PulseGap_long+ENDOR_time+PulseGap+gmSEQ.m gSG.AWGFreq 0 gSG.AWGAmp;];
WaveForm_1Q = [0 gmSEQ.halfpi gSG.AWGFreq -pi/2 gSG.AWGAmp;... 
    gmSEQ.halfpi+PulseGap_long+ENDOR_time+PulseGap gmSEQ.halfpi+PulseGap_long+ENDOR_time+PulseGap+gmSEQ.m gSG.AWGFreq -pi/2 gSG.AWGAmp;];
WaveForm_1Length = ceil((gmSEQ.halfpi+PulseGap_long+ENDOR_time+PulseGap+gmSEQ.m+1000) / (16 / gSG.AWGClockRate)) ...
    *(16 / gSG.AWGClockRate);
WaveForm_1PointNum = WaveForm_1Length * gSG.AWGClockRate;

% P1 sequence
WaveForm_2I = [0 ENDOR_time ENDOR_freq 0 gSG2.AWGAmp];
WaveForm_2Q = [0 ENDOR_time ENDOR_freq -pi/2 gSG2.AWGAmp];
WaveForm_2Length = ceil((ENDOR_time+1000) / (16 / gSG2.P1AWGClockRate)) ...
    *(16 / gSG2.P1AWGClockRate);
WaveForm_2PointNum = WaveForm_2Length * gSG2.P1AWGClockRate;

Dummy_freq = gmSEQ.SAmp1;
Dummy_AWGAmp = gSG2.AWGAmp;
% Dummy_AWGAmp = 0.0;
% disp(Dummy_AWGAmp)
WaveForm_3I = [0 ENDOR_time Dummy_freq 0 Dummy_AWGAmp];
WaveForm_3Q = [0 ENDOR_time Dummy_freq -pi/2 Dummy_AWGAmp];
WaveForm_3Length = ceil((ENDOR_time+1000) / (16 / gSG2.P1AWGClockRate)) ...
    *(16 / gSG2.P1AWGClockRate);
WaveForm_3PointNum = WaveForm_3Length * gSG2.P1AWGClockRate;

chaseFunctionPool('createWaveform', WaveForm_1I, gSG.AWGClockRate, WaveForm_1Length, 'ENDOR_Rabi_I_seg1.txt'); pause(0.5);
chaseFunctionPool('createWaveform', WaveForm_1Q, gSG.AWGClockRate, WaveForm_1Length, 'ENDOR_Rabi_Q_seg1.txt'); pause(0.5);
chaseFunctionPool('createWaveform', WaveForm_2I, gSG2.P1AWGClockRate, WaveForm_2Length, 'ENDOR_Rabi_I_seg2.txt'); pause(0.5);
chaseFunctionPool('createWaveform', WaveForm_2Q, gSG2.P1AWGClockRate, WaveForm_2Length, 'ENDOR_Rabi_Q_seg2.txt'); pause(0.5);
chaseFunctionPool('createWaveform', WaveForm_3I, gSG2.P1AWGClockRate, WaveForm_3Length, 'ENDOR_Rabi_I_seg3.txt'); pause(0.5);
chaseFunctionPool('createWaveform', WaveForm_3Q, gSG2.P1AWGClockRate, WaveForm_3Length, 'ENDOR_Rabi_Q_seg3.txt'); pause(0.5);

chaseFunctionPool('createSegStruct', 'ENDOR_Rabi_SegStruct_I.txt', ...
    'ENDOR_Rabi_I_seg1.txt', WaveForm_1PointNum, 1, 1);
pause(0.5);
chaseFunctionPool('createSegStruct', 'ENDOR_Rabi_SegStruct_Q.txt', ...
    'ENDOR_Rabi_Q_seg1.txt', WaveForm_1PointNum, 1, 1);
pause(0.5);
chaseFunctionPool('createSegStruct', 'ENDOR_Rabi_P1_SegStruct_I.txt', ...
    'ENDOR_Rabi_I_seg2.txt', WaveForm_2PointNum, 1, 1, ...
    'ENDOR_Rabi_I_seg3.txt', WaveForm_3PointNum, 1, 1);
pause(0.5);
chaseFunctionPool('createSegStruct', 'ENDOR_Rabi_P1_SegStruct_Q.txt', ...
    'ENDOR_Rabi_Q_seg2.txt', WaveForm_2PointNum, 1, 1, ...
    'ENDOR_Rabi_Q_seg3.txt', WaveForm_3PointNum, 1, 1);
pause(0.5);
chaseFunctionPool('CreateSegments', gmSEQ.MWAWG, 1, ...
    1, ...
    2047, 2047, 'ENDOR_Rabi_SegStruct_I.txt', 'false');
pause(1); % this pause seems to be important, otherwise the loading is not right occassionally
chaseFunctionPool('CreateSegments', gmSEQ.MWAWG, 2, ...
    1, ...
    2047, 2047, 'ENDOR_Rabi_SegStruct_Q.txt', 'false');
pause(1); % this pause seems to be important, otherwise the loading is not right occassionally
chaseFunctionPool('CreateSegments', gmSEQ.P1AWG, 1, ...
    2, ...
    2047, 2047, 'ENDOR_Rabi_P1_SegStruct_I.txt', 'false');
pause(1); % this pause seems to be important, otherwise the loading is not right occassionally   
chaseFunctionPool('CreateSegments', gmSEQ.P1AWG, 2, ...
    2, ...
    2047, 2047, 'ENDOR_Rabi_P1_SegStruct_Q.txt', 'false');
pause(1); % this pause seems to be important, otherwise the loading is not right occassionally   
chaseFunctionPool('runChase', gmSEQ.MWAWG, 'false'); pause(1); 
chaseFunctionPool('runChase', gmSEQ.P1AWG, 'false'); pause(1);
    
ApplyDelays();

function AWGSyncTest() % for sync testing on AWG Yuanqi Lyu (Sep 30, 2020).
global gmSEQ gSG
gSG.bfixedPow = 1;
gSG.bfixedFreq = 1;
gSG.bMod = 'IQ';
gSG.bModSrc = 'External';
T_BeforePulses = 5000;
T_TrigWidth = 500;

if strcmp(gmSEQ.meas,'APD')
    gmSEQ.CtrGateDur = 1000;
end

% Pulse blaster.
gmSEQ.CHN(1).PBN = PBDictionary('AWGTrig');
gmSEQ.CHN(1).NRise = 7;
gmSEQ.CHN(1).T = [T_BeforePulses, ...
    T_BeforePulses + 2000, T_BeforePulses + 4000, T_BeforePulses + 6000, T_BeforePulses + 8000, T_BeforePulses + 10000,...
    T_BeforePulses + 20000];
gmSEQ.CHN(1).DT = [T_TrigWidth, T_TrigWidth, T_TrigWidth, T_TrigWidth, T_TrigWidth, T_TrigWidth, T_TrigWidth];

gmSEQ.CHN(numel(gmSEQ.CHN) + 1).PBN = PBDictionary('MWSwitch');
gmSEQ.CHN(numel(gmSEQ.CHN)).NRise = 1;
gmSEQ.CHN(numel(gmSEQ.CHN)).T = T_BeforePulses;
gmSEQ.CHN(numel(gmSEQ.CHN)).DT = 20000 + gmSEQ.CtrGateDur + 1000;

gmSEQ.CHN(numel(gmSEQ.CHN)+1).PBN=PBDictionary('dummy1'); % for external 
% mornitoring of the pulses
gmSEQ.CHN(numel(gmSEQ.CHN)).NRise = 2;
gmSEQ.CHN(numel(gmSEQ.CHN)).T = [T_BeforePulses, T_BeforePulses + 20000];
gmSEQ.CHN(numel(gmSEQ.CHN)).DT = [T_TrigWidth, T_TrigWidth];

gmSEQ.CHN(numel(gmSEQ.CHN)+1).PBN=PBDictionary('dummy2'); % make sure there
% is a buffer period at the beginning of each sequence.
gmSEQ.CHN(numel(gmSEQ.CHN)).NRise = 2;
gmSEQ.CHN(numel(gmSEQ.CHN)).T = [T_TrigWidth, T_BeforePulses + 20000];
gmSEQ.CHN(numel(gmSEQ.CHN)).DT = [T_TrigWidth, gmSEQ.CtrGateDur + 1000];

gmSEQ.CHN(numel(gmSEQ.CHN)+1).PBN=PBDictionary('ctr0'); % To make sure data
% taking was able to work properly.
gmSEQ.CHN(numel(gmSEQ.CHN)).NRise=2;
gmSEQ.CHN(numel(gmSEQ.CHN)).T = [T_BeforePulses, T_BeforePulses + 20000];
gmSEQ.CHN(numel(gmSEQ.CHN)).DT = [gmSEQ.CtrGateDur, gmSEQ.CtrGateDur];

% AWG.
chaseFunctionPool('stopChase', 1)
WaveForm(1).Shape = [0, 400, gSG.IQVoltage1; ...
    400, 800, 0]; % A single pulse.
WaveForm(2).Shape = [0, 400, gSG.IQVoltage1 / 2; ...
    400, 800, 0]; % A single pulse. with 1/2 amplitude
WaveForm(3).Shape = [0, 400, -gSG.IQVoltage1; ...
    400, 800, 0]; % A single pulse.
for n = 1 : 3
    WaveForm(n).Length = WaveForm(n).Shape(end, 2);
    WaveForm(n).NPoints = WaveForm(n).Length * gSG.AWGClockRate;
end

chaseFunctionPool('createWaveform', WaveForm(1).Shape, gSG.AWGClockRate, ...
    WaveForm(1).Length, 'Single_Pulse_800ns.txt'); pause(0.5);
chaseFunctionPool('createWaveform', WaveForm(2).Shape, gSG.AWGClockRate, ...
    WaveForm(2).Length, 'Single_HalfPulse_800ns.txt'); pause(0.5);
chaseFunctionPool('createWaveform', WaveForm(3).Shape, gSG.AWGClockRate, ...
    WaveForm(3).Length, 'Single_NegPulse_800ns.txt'); pause(0.5);
chaseFunctionPool('createSegStruct', 'SegStruct.txt', ...
    'Single_Pulse_800ns.txt', WaveForm(1).NPoints, 1, 1, ...
    'Single_HalfPulse_800ns.txt', WaveForm(2).NPoints, 5, 1, ...
    'Single_HalfPulse_800ns.txt', WaveForm(2).NPoints, 5, 0, ...
    'Single_NegPulse_800ns.txt', WaveForm(3).NPoints, 1, 1); 
pause(0.5);
chaseFunctionPool('CreateSegments', 1, 1, 4, 2047, 2047, ...
    'SegStruct.txt', 'false');
chaseFunctionPool('CreateSegments', 1, 2, 4, 2047, 2047, ...
    'SegStruct.txt', 'false');
pause(1); 
% This pause seems to be important, otherwise the loading is not right
% occassionally.

chaseFunctionPool('runChase', 1, 'false')

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

if strcmp(gmSEQ.meas,'APD')
    gmSEQ.CtrGateDur = 1000;
end

gmSEQ.CHN(1).PBN=PBDictionary('ctr0');
gmSEQ.CHN(1).NRise=1;
gmSEQ.CHN(1).T=[gmSEQ.m];
gmSEQ.CHN(1).DT=[gmSEQ.CtrGateDur];

gmSEQ.CHN(2).PBN=PBDictionary('AOM');
gmSEQ.CHN(2).NRise=1;
gmSEQ.CHN(2).T=[2000];
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
gSG.bMod='IQ';
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

gmSEQ.CHN(numel(gmSEQ.CHN)+1).PBN=PBDictionary('AWGTrig');
gmSEQ.CHN(numel(gmSEQ.CHN)).NRise=2;
gmSEQ.CHN(numel(gmSEQ.CHN)).T=[Wait_p+gmSEQ.readout+AfterLaser, ...
    Sig_D_start+gmSEQ.readout+AfterLaser];
gmSEQ.CHN(numel(gmSEQ.CHN)).DT=[2150 2150];

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

%% AWG
% Initialization
chaseFunctionPool('stopChase',  gmSEQ.MWAWG)

if gSG.ACmodAWG % in AC modulation mode
    WaveForm_1I = [0 gmSEQ.halfpi gSG.AWGFreq 0 gSG.AWGAmp;...
        gmSEQ.halfpi+gmSEQ.m gmSEQ.halfpi+gmSEQ.m+gmSEQ.halfpi gSG.AWGFreq pi gSG.AWGAmp];
    WaveForm_1Q = [0 gmSEQ.halfpi gSG.AWGFreq -pi/2 gSG.AWGAmp;...
        gmSEQ.halfpi+gmSEQ.m gmSEQ.halfpi+gmSEQ.m+gmSEQ.halfpi gSG.AWGFreq pi-pi/2 gSG.AWGAmp];

    WaveForm_1Length = ceil((gmSEQ.halfpi+gmSEQ.m+gmSEQ.halfpi+1000) / (16 / gSG.AWGClockRate)) ...
        *(16 / gSG.AWGClockRate);
    WaveForm_1PointNum = WaveForm_1Length * gSG.AWGClockRate;

    WaveForm_2I = [0 gmSEQ.halfpi gSG.AWGFreq 0 gSG.AWGAmp;...
        gmSEQ.halfpi+gmSEQ.m gmSEQ.halfpi+gmSEQ.m+gmSEQ.halfpi gSG.AWGFreq 0 gSG.AWGAmp];
    WaveForm_2Q = [0 gmSEQ.halfpi gSG.AWGFreq -pi/2 gSG.AWGAmp;...
        gmSEQ.halfpi+gmSEQ.m gmSEQ.halfpi+gmSEQ.m+gmSEQ.halfpi gSG.AWGFreq -pi/2 gSG.AWGAmp];

    WaveForm_2Length = ceil((gmSEQ.halfpi+gmSEQ.m+gmSEQ.halfpi+1000) / (16 / gSG.AWGClockRate)) ...
        *(16 / gSG.AWGClockRate);
    WaveForm_2PointNum = WaveForm_2Length * gSG.AWGClockRate;
            
else

    WaveForm_1I = [0 gmSEQ.halfpi 0 pi/2 gSG.AWGAmp;...
           gmSEQ.halfpi+gmSEQ.m gmSEQ.halfpi+gmSEQ.m+gmSEQ.halfpi 0 3*pi/2 gSG.AWGAmp];
    WaveForm_1Q = [0 gmSEQ.halfpi 0 0 0;];
    
    WaveForm_1Length = ceil((gmSEQ.halfpi+gmSEQ.m+gmSEQ.halfpi+1000) / (16 / gSG.AWGClockRate)) ...
        *(16 / gSG.AWGClockRate);
    WaveForm_1PointNum = WaveForm_1Length * gSG.AWGClockRate;
    
    % dark sequence
    WaveForm_2I = [0 gmSEQ.halfpi 0 pi/2 gSG.AWGAmp;...
           gmSEQ.halfpi+gmSEQ.m gmSEQ.halfpi+gmSEQ.m+gmSEQ.halfpi 0 pi/2 gSG.AWGAmp];
    WaveForm_2Q = [0 gmSEQ.halfpi 0 0 0;];
    
    WaveForm_2Length = ceil((gmSEQ.halfpi+gmSEQ.m+gmSEQ.halfpi+PulseGap+gmSEQ.pi+1000) / (16 / gSG.AWGClockRate)) ...
        *(16 / gSG.AWGClockRate);
    WaveForm_2PointNum = WaveForm_2Length * gSG.AWGClockRate;

end
    chaseFunctionPool('createWaveform', WaveForm_1I, gSG.AWGClockRate, WaveForm_1Length, 'Ramsey_I_seg1.txt'); pause(0.5);
    chaseFunctionPool('createWaveform', WaveForm_1Q, gSG.AWGClockRate, WaveForm_1Length, 'Ramsey_Q_seg1.txt'); pause(0.5);
    chaseFunctionPool('createWaveform', WaveForm_2I, gSG.AWGClockRate, WaveForm_2Length, 'Ramsey_I_seg2.txt'); pause(0.5);
    chaseFunctionPool('createWaveform', WaveForm_2Q, gSG.AWGClockRate, WaveForm_2Length, 'Ramsey_Q_seg2.txt'); pause(0.5);

    chaseFunctionPool('createSegStruct', 'Ramsey_SegStruct_I.txt', ...
        'Ramsey_I_seg1.txt', WaveForm_1PointNum, 1, 1, ...
        'Ramsey_I_seg2.txt', WaveForm_2PointNum, 1, 1);
    pause(0.5);
    chaseFunctionPool('createSegStruct', 'Ramsey_SegStruct_Q.txt', ...
        'Ramsey_Q_seg1.txt', WaveForm_1PointNum, 1, 1, ...
        'Ramsey_Q_seg2.txt', WaveForm_2PointNum, 1, 1);
    pause(0.5);
    chaseFunctionPool('CreateSegments', gmSEQ.MWAWG, 1, ...
        2, ...
        2047, 2047, 'Ramsey_SegStruct_I.txt', 'false');
    pause(1); % this pause seems to be important, otherwise the loading is not right occassionally
    chaseFunctionPool('CreateSegments', gmSEQ.MWAWG, 2, ...
        2, ...
        2047, 2047, 'Ramsey_SegStruct_Q.txt', 'false');
    pause(1); % this pause seems to be important, otherwise the loading is not right occassionally
    chaseFunctionPool('runChase', gmSEQ.MWAWG, 'false');

ApplyDelays();

function Echo
global gmSEQ gSG
gSG.bfixedPow=1;
gSG.bfixedFreq=1;
gSG.bMod='IQ';
gSG.bModSrc='External';

[gmSEQ.ScaleT, gmSEQ.ScaleStr] = GetScale(gmSEQ.To);

AfterPi = 2000;
AfterLaser = 0.05e6;
Wait_p = 0.01e6;
Detect_Window = 5000;

Sig_D_start = Wait_p+gmSEQ.readout+AfterLaser+gmSEQ.halfpi+gmSEQ.m/2+gmSEQ.pi+gmSEQ.m/2+gmSEQ.halfpi+AfterPi+Detect_Window+Wait_p;

gmSEQ.CHN(1).PBN=PBDictionary('ctr0');
gmSEQ.CHN(1).NRise=4;
gmSEQ.CHN(1).T=[Wait_p+gmSEQ.readout-1000-gmSEQ.CtrGateDur, ...
    Wait_p+gmSEQ.readout+AfterLaser+gmSEQ.halfpi+gmSEQ.m/2+gmSEQ.pi+gmSEQ.m/2+gmSEQ.halfpi+AfterPi, ...
    Sig_D_start+gmSEQ.readout-1000-gmSEQ.CtrGateDur, ... 
    Sig_D_start+gmSEQ.readout+AfterLaser+gmSEQ.halfpi+gmSEQ.m/2+gmSEQ.pi+gmSEQ.m/2+gmSEQ.halfpi+AfterPi];
if strcmp(gmSEQ.meas,'SPCM')
    gmSEQ.CHN(1).DT=[gmSEQ.CtrGateDur gmSEQ.CtrGateDur gmSEQ.CtrGateDur gmSEQ.CtrGateDur];
elseif strcmp(gmSEQ.meas,'APD')
    gmSEQ.CHN(1).DT=[1000 1000 1000 1000];
end

gmSEQ.CHN(numel(gmSEQ.CHN)+1).PBN=PBDictionary('AOM');
gmSEQ.CHN(numel(gmSEQ.CHN)).NRise=4;
gmSEQ.CHN(numel(gmSEQ.CHN)).T = [Wait_p, Wait_p+gmSEQ.readout+AfterLaser+gmSEQ.halfpi+gmSEQ.m/2+gmSEQ.pi+gmSEQ.m/2+gmSEQ.halfpi+AfterPi, ...
    Sig_D_start, Sig_D_start+gmSEQ.readout+AfterLaser+gmSEQ.halfpi+gmSEQ.m/2+gmSEQ.pi+gmSEQ.m/2+gmSEQ.halfpi+AfterPi];
gmSEQ.CHN(numel(gmSEQ.CHN)).DT = [gmSEQ.readout Detect_Window gmSEQ.readout Detect_Window];
%

gmSEQ.CHN(numel(gmSEQ.CHN)+1).PBN=PBDictionary('AWGTrig');
gmSEQ.CHN(numel(gmSEQ.CHN)).NRise=2;
gmSEQ.CHN(numel(gmSEQ.CHN)).T=[Wait_p+gmSEQ.readout+AfterLaser, ...
    Sig_D_start+gmSEQ.readout+AfterLaser];
gmSEQ.CHN(numel(gmSEQ.CHN)).DT = repelem(gmSEQ.halfpi+gmSEQ.m/2+gmSEQ.pi+gmSEQ.m/2+gmSEQ.halfpi+200, 2);


gmSEQ.CHN(numel(gmSEQ.CHN)+1).PBN=PBDictionary('MWSwitch');
if gmSEQ.m/2 < 200
    gmSEQ.CHN(numel(gmSEQ.CHN)).NRise=2;
    gmSEQ.CHN(numel(gmSEQ.CHN)).T=[Wait_p+gmSEQ.readout+AfterLaser-20, Sig_D_start+gmSEQ.readout+AfterLaser-20];
    gmSEQ.CHN(numel(gmSEQ.CHN)).DT=[gmSEQ.halfpi+gmSEQ.m/2+gmSEQ.pi+gmSEQ.m/2+gmSEQ.halfpi+40, ... 
    gmSEQ.halfpi+gmSEQ.m/2+gmSEQ.pi+gmSEQ.m/2+gmSEQ.halfpi+40];
else
    gmSEQ.CHN(numel(gmSEQ.CHN)).NRise=6;
    gmSEQ.CHN(numel(gmSEQ.CHN)).T=[Wait_p+gmSEQ.readout+AfterLaser-20, ...
        Wait_p+gmSEQ.readout+AfterLaser+gmSEQ.halfpi+gmSEQ.m/2-20, ...
        Wait_p+gmSEQ.readout+AfterLaser+gmSEQ.halfpi+gmSEQ.m/2+gmSEQ.pi+gmSEQ.m/2-20, ...
        Sig_D_start+gmSEQ.readout+AfterLaser-20, ... 
        Sig_D_start+gmSEQ.readout+AfterLaser+gmSEQ.halfpi+gmSEQ.m/2-20, ...
        Sig_D_start+gmSEQ.readout+AfterLaser+gmSEQ.halfpi+gmSEQ.m/2+gmSEQ.pi+gmSEQ.m/2-20];
    gmSEQ.CHN(numel(gmSEQ.CHN)).DT=[gmSEQ.halfpi+40, gmSEQ.pi+40, gmSEQ.halfpi+40, ... 
    gmSEQ.halfpi+40, gmSEQ.pi+40, gmSEQ.halfpi+40];
end

gmSEQ.CHN(numel(gmSEQ.CHN)+1).PBN=PBDictionary('dummy1');
gmSEQ.CHN(numel(gmSEQ.CHN)).NRise=2;
gmSEQ.CHN(numel(gmSEQ.CHN)).T=[0 Sig_D_start+gmSEQ.readout+AfterLaser+gmSEQ.halfpi+gmSEQ.m/2+gmSEQ.pi+gmSEQ.m/2+gmSEQ.halfpi+AfterPi+Detect_Window-50];
gmSEQ.CHN(numel(gmSEQ.CHN)).DT=[50 50];

% gmSEQ.MWAWG = 1;
% disp(gmSEQ.MWAWG)

%% AWG
% Initialization
chaseFunctionPool('stopChase',  gmSEQ.MWAWG)

if gSG.ACmodAWG % in AC modulation mode
    WaveForm_1I = [0 gmSEQ.halfpi gSG.AWGFreq 0 gSG.AWGAmp;...
        gmSEQ.halfpi+gmSEQ.m/2 gmSEQ.halfpi+gmSEQ.m/2+gmSEQ.pi gSG.AWGFreq pi/2 gSG.AWGAmp; ...
        gmSEQ.halfpi+gmSEQ.m/2+gmSEQ.pi+gmSEQ.m/2 gmSEQ.halfpi+gmSEQ.m/2+gmSEQ.pi+gmSEQ.m/2+gmSEQ.halfpi gSG.AWGFreq pi gSG.AWGAmp];
    WaveForm_1Q = [0 gmSEQ.halfpi gSG.AWGFreq -pi/2 gSG.AWGAmp;...
        gmSEQ.halfpi+gmSEQ.m/2 gmSEQ.halfpi+gmSEQ.m/2+gmSEQ.pi gSG.AWGFreq pi/2-pi/2 gSG.AWGAmp; ...
        gmSEQ.halfpi+gmSEQ.m/2+gmSEQ.pi+gmSEQ.m/2 gmSEQ.halfpi+gmSEQ.m/2+gmSEQ.pi+gmSEQ.m/2+gmSEQ.halfpi gSG.AWGFreq pi-pi/2 gSG.AWGAmp];

    WaveForm_1Length = ceil((gmSEQ.halfpi+gmSEQ.m/2+gmSEQ.pi+gmSEQ.m/2+gmSEQ.halfpi+1000) / (16 / gSG.AWGClockRate)) ...
        *(16 / gSG.AWGClockRate);
    WaveForm_1PointNum = WaveForm_1Length * gSG.AWGClockRate;

    WaveForm_2I = [0 gmSEQ.halfpi gSG.AWGFreq 0 gSG.AWGAmp;...
        gmSEQ.halfpi+gmSEQ.m/2 gmSEQ.halfpi+gmSEQ.m/2+gmSEQ.pi gSG.AWGFreq pi/2 gSG.AWGAmp; ...
        gmSEQ.halfpi+gmSEQ.m/2+gmSEQ.pi+gmSEQ.m/2 gmSEQ.halfpi+gmSEQ.m/2+gmSEQ.pi+gmSEQ.m/2+gmSEQ.halfpi gSG.AWGFreq 0 gSG.AWGAmp];
    WaveForm_2Q = [0 gmSEQ.halfpi gSG.AWGFreq -pi/2 gSG.AWGAmp;...
        gmSEQ.halfpi+gmSEQ.m/2 gmSEQ.halfpi+gmSEQ.m/2+gmSEQ.pi gSG.AWGFreq pi/2-pi/2 gSG.AWGAmp; ...
        gmSEQ.halfpi+gmSEQ.m/2+gmSEQ.pi+gmSEQ.m/2 gmSEQ.halfpi+gmSEQ.m/2+gmSEQ.pi+gmSEQ.m/2+gmSEQ.halfpi gSG.AWGFreq 0-pi/2 gSG.AWGAmp];

    WaveForm_2Length = ceil((gmSEQ.halfpi+gmSEQ.m/2+gmSEQ.pi+gmSEQ.m/2+gmSEQ.halfpi+1000) / (16 / gSG.AWGClockRate)) ...
        *(16 / gSG.AWGClockRate);
    WaveForm_2PointNum = WaveForm_2Length * gSG.AWGClockRate;
            
else
    WaveForm_1I = [0 gmSEQ.halfpi 0 pi/2 gSG.AWGAmp;...
           gmSEQ.halfpi+gmSEQ.m/2+gmSEQ.pi+gmSEQ.m/2 gmSEQ.halfpi+gmSEQ.m/2+gmSEQ.pi+gmSEQ.m/2+gmSEQ.halfpi 0 3*pi/2 gSG.AWGAmp];
    WaveForm_1Q = [0 gmSEQ.halfpi 0 0 0;...
        gmSEQ.halfpi+gmSEQ.m/2 gmSEQ.halfpi+gmSEQ.m/2+gmSEQ.pi 0 pi/2 gSG.AWGAmp];
    
    WaveForm_1Length = ceil((gmSEQ.halfpi+gmSEQ.m/2+gmSEQ.pi+gmSEQ.m/2+gmSEQ.halfpi+1000) / (16 / gSG.AWGClockRate)) ...
        *(16 / gSG.AWGClockRate);
    WaveForm_1PointNum = WaveForm_1Length * gSG.AWGClockRate;
    
    % dark sequence
    WaveForm_2I = [0 gmSEQ.halfpi 0 pi/2 gSG.AWGAmp;...
           gmSEQ.halfpi+gmSEQ.m/2+gmSEQ.pi+gmSEQ.m/2 gmSEQ.halfpi+gmSEQ.m/2+gmSEQ.pi+gmSEQ.m/2+gmSEQ.halfpi 0 pi/2 gSG.AWGAmp];
    WaveForm_2Q = [0 gmSEQ.halfpi 0 0 0;...
        gmSEQ.halfpi+gmSEQ.m/2 gmSEQ.halfpi+gmSEQ.m/2+gmSEQ.pi 0 pi/2 gSG.AWGAmp];
    
    WaveForm_2Length = ceil((gmSEQ.halfpi+gmSEQ.m/2+gmSEQ.pi+gmSEQ.m/2+gmSEQ.halfpi+PulseGap+gmSEQ.pi+1000) / (16 / gSG.AWGClockRate)) ...
        *(16 / gSG.AWGClockRate);
    WaveForm_2PointNum = WaveForm_2Length * gSG.AWGClockRate;

end
chaseFunctionPool('createWaveform', WaveForm_1I, gSG.AWGClockRate, WaveForm_1Length, 'Echo_I_seg1.txt'); pause(0.5);
chaseFunctionPool('createWaveform', WaveForm_1Q, gSG.AWGClockRate, WaveForm_1Length, 'Echo_Q_seg1.txt'); pause(0.5);
chaseFunctionPool('createWaveform', WaveForm_2I, gSG.AWGClockRate, WaveForm_2Length, 'Echo_I_seg2.txt'); pause(0.5);
chaseFunctionPool('createWaveform', WaveForm_2Q, gSG.AWGClockRate, WaveForm_2Length, 'Echo_Q_seg2.txt'); pause(0.5);

chaseFunctionPool('createSegStruct', 'Echo_SegStruct_I.txt', ...
    'Echo_I_seg1.txt', WaveForm_1PointNum, 1, 1, ...
    'Echo_I_seg2.txt', WaveForm_2PointNum, 1, 1);
pause(0.5);
chaseFunctionPool('createSegStruct', 'Echo_SegStruct_Q.txt', ...
    'Echo_Q_seg1.txt', WaveForm_1PointNum, 1, 1, ...
    'Echo_Q_seg2.txt', WaveForm_2PointNum, 1, 1);
pause(0.5);
chaseFunctionPool('CreateSegments', gmSEQ.MWAWG, 1, ...
    2, ...
    2047, 2047, 'Echo_SegStruct_I.txt', 'false');
pause(1); % this pause seems to be important, otherwise the loading is not right occassionally
chaseFunctionPool('CreateSegments', gmSEQ.MWAWG, 2, ...
    2, ...
    2047, 2047, 'Echo_SegStruct_Q.txt', 'false');
pause(1); % this pause seems to be important, otherwise the loading is not right occassionally

chaseFunctionPool('runChase', gmSEQ.MWAWG, 'false');

ApplyDelays();

function Echo_TuneDensity
global gmSEQ gSG gSG3
gSG.bfixedPow=1;
gSG.bfixedFreq=1;
gSG.bMod='IQ';
gSG.bModSrc='External';

gSG3.bMod='IQ';
gSG3.bModSrc='External';
SignalGeneratorFunctionPool3('SetMod');
SignalGeneratorFunctionPool3('WritePow');
SignalGeneratorFunctionPool3('WriteFreq');
gSG3.bOn=1; SignalGeneratorFunctionPool3('RFOnOff');

[gmSEQ.ScaleT, gmSEQ.ScaleStr] = GetScale(gmSEQ.To);

AfterPi = 2000;
AfterLaser = 0.05e6;
Wait_p = 0.01e6;
Detect_Window = 5000;
T_Depol = 10e3;

Sig_D_start = Wait_p+gmSEQ.readout+AfterLaser+gmSEQ.DEERt+T_Depol+gmSEQ.halfpi+gmSEQ.m/2+gmSEQ.pi+gmSEQ.m/2+gmSEQ.halfpi+AfterPi+Detect_Window+Wait_p;

gmSEQ.CHN(1).PBN=PBDictionary('ctr0');
gmSEQ.CHN(1).NRise=4;
gmSEQ.CHN(1).T=[Wait_p+gmSEQ.readout-1000-gmSEQ.CtrGateDur, ...
    Wait_p+gmSEQ.readout+AfterLaser+gmSEQ.DEERt+T_Depol+gmSEQ.halfpi+gmSEQ.m/2+gmSEQ.pi+gmSEQ.m/2+gmSEQ.halfpi+AfterPi, ...
    Sig_D_start+gmSEQ.readout-1000-gmSEQ.CtrGateDur, ... 
    Sig_D_start+gmSEQ.readout+AfterLaser+gmSEQ.DEERt+T_Depol+gmSEQ.halfpi+gmSEQ.m/2+gmSEQ.pi+gmSEQ.m/2+gmSEQ.halfpi+AfterPi];
if strcmp(gmSEQ.meas,'SPCM')
    gmSEQ.CHN(1).DT=[gmSEQ.CtrGateDur gmSEQ.CtrGateDur gmSEQ.CtrGateDur gmSEQ.CtrGateDur];
elseif strcmp(gmSEQ.meas,'APD')
    gmSEQ.CHN(1).DT=[1000 1000 1000 1000];
end

gmSEQ.CHN(numel(gmSEQ.CHN)+1).PBN=PBDictionary('AOM');
gmSEQ.CHN(numel(gmSEQ.CHN)).NRise=4;
gmSEQ.CHN(numel(gmSEQ.CHN)).T = [Wait_p, Wait_p+gmSEQ.readout+AfterLaser+gmSEQ.DEERt+T_Depol+gmSEQ.halfpi+gmSEQ.m/2+gmSEQ.pi+gmSEQ.m/2+gmSEQ.halfpi+AfterPi, ...
    Sig_D_start, Sig_D_start+gmSEQ.readout+AfterLaser+gmSEQ.DEERt+T_Depol+gmSEQ.halfpi+gmSEQ.m/2+gmSEQ.pi+gmSEQ.m/2+gmSEQ.halfpi+AfterPi];
gmSEQ.CHN(numel(gmSEQ.CHN)).DT = [gmSEQ.readout Detect_Window gmSEQ.readout Detect_Window];
%

gmSEQ.CHN(numel(gmSEQ.CHN)+1).PBN=PBDictionary('AWGTrig');
gmSEQ.CHN(numel(gmSEQ.CHN)).NRise=2;
gmSEQ.CHN(numel(gmSEQ.CHN)).T=[Wait_p+gmSEQ.readout+AfterLaser+gmSEQ.DEERt+T_Depol, ...
    Sig_D_start+gmSEQ.readout+AfterLaser+gmSEQ.DEERt+T_Depol];
gmSEQ.CHN(numel(gmSEQ.CHN)).DT = repelem(gmSEQ.halfpi+gmSEQ.m/2+gmSEQ.pi+gmSEQ.m/2+gmSEQ.halfpi+200, 2);


gmSEQ.CHN(numel(gmSEQ.CHN)+1).PBN=PBDictionary('MWSwitch');
if gmSEQ.m/2 < 200
    gmSEQ.CHN(numel(gmSEQ.CHN)).NRise=2;
    gmSEQ.CHN(numel(gmSEQ.CHN)).T=[Wait_p+gmSEQ.readout+AfterLaser+gmSEQ.DEERt+T_Depol-20, Sig_D_start+gmSEQ.readout+AfterLaser+gmSEQ.DEERt+T_Depol-20];
    gmSEQ.CHN(numel(gmSEQ.CHN)).DT=[gmSEQ.halfpi+gmSEQ.m/2+gmSEQ.pi+gmSEQ.m/2+gmSEQ.halfpi+40, ... 
    gmSEQ.halfpi+gmSEQ.m/2+gmSEQ.pi+gmSEQ.m/2+gmSEQ.halfpi+40];
else
    gmSEQ.CHN(numel(gmSEQ.CHN)).NRise=6;
    gmSEQ.CHN(numel(gmSEQ.CHN)).T=[Wait_p+gmSEQ.readout+AfterLaser+gmSEQ.DEERt+T_Depol-20, ...
        Wait_p+gmSEQ.readout+AfterLaser+gmSEQ.DEERt+T_Depol+gmSEQ.halfpi+gmSEQ.m/2-20, ...
        Wait_p+gmSEQ.readout+AfterLaser+gmSEQ.DEERt+T_Depol+gmSEQ.halfpi+gmSEQ.m/2+gmSEQ.pi+gmSEQ.m/2-20, ...
        Sig_D_start+gmSEQ.readout+AfterLaser+gmSEQ.DEERt+T_Depol-20, ... 
        Sig_D_start+gmSEQ.readout+AfterLaser+gmSEQ.DEERt+T_Depol+gmSEQ.halfpi+gmSEQ.m/2-20, ...
        Sig_D_start+gmSEQ.readout+AfterLaser+gmSEQ.DEERt+T_Depol+gmSEQ.halfpi+gmSEQ.m/2+gmSEQ.pi+gmSEQ.m/2-20];
    gmSEQ.CHN(numel(gmSEQ.CHN)).DT=[gmSEQ.halfpi+40, gmSEQ.pi+40, gmSEQ.halfpi+40, ... 
    gmSEQ.halfpi+40, gmSEQ.pi+40, gmSEQ.halfpi+40];
end

gmSEQ.CHN(numel(gmSEQ.CHN) + 1).PBN = PBDictionary('AWGTrig3');
gmSEQ.CHN(numel(gmSEQ.CHN)).NRise = 2;
gmSEQ.CHN(numel(gmSEQ.CHN)).T = [Wait_p+gmSEQ.readout + AfterLaser, Sig_D_start+gmSEQ.readout + AfterLaser];
gmSEQ.CHN(numel(gmSEQ.CHN)).DT = repelem(1000, 2);

gmSEQ.CHN(numel(gmSEQ.CHN) + 1).PBN = PBDictionary('MWSwitch3');
gmSEQ.CHN(numel(gmSEQ.CHN)).NRise = 2;
gmSEQ.CHN(numel(gmSEQ.CHN)).T = [Wait_p+gmSEQ.readout + AfterLaser - 20, Sig_D_start+gmSEQ.readout + AfterLaser- 20];
gmSEQ.CHN(numel(gmSEQ.CHN)).DT = repelem(gmSEQ.DEERt + 40, 2);

gmSEQ.CHN(numel(gmSEQ.CHN)+1).PBN=PBDictionary('dummy1');
gmSEQ.CHN(numel(gmSEQ.CHN)).NRise=2;
gmSEQ.CHN(numel(gmSEQ.CHN)).T=[0 Sig_D_start+gmSEQ.readout+AfterLaser+gmSEQ.DEERt+T_Depol+gmSEQ.halfpi+gmSEQ.m/2+gmSEQ.pi+gmSEQ.m/2+gmSEQ.halfpi+AfterPi+Detect_Window-50];
gmSEQ.CHN(numel(gmSEQ.CHN)).DT=[50 50];

% gmSEQ.MWAWG = 1;
% disp(gmSEQ.MWAWG)

%% AWG
% Initialization
chaseFunctionPool('stopChase',  gmSEQ.MWAWG)
chaseFunctionPool('stopChase',  gmSEQ.MWAWG2)

if ~gSG.ACmodAWG % in AC modulation mode
    gSG.AWGFreq = 0;
    gSG3.AWGFreq = 0;
end

WaveForm_1I = [0 gmSEQ.halfpi gSG.AWGFreq 0 gSG.AWGAmp;...
    gmSEQ.halfpi+gmSEQ.m/2 gmSEQ.halfpi+gmSEQ.m/2+gmSEQ.pi gSG.AWGFreq pi/2 gSG.AWGAmp; ...
    gmSEQ.halfpi+gmSEQ.m/2+gmSEQ.pi+gmSEQ.m/2 gmSEQ.halfpi+gmSEQ.m/2+gmSEQ.pi+gmSEQ.m/2+gmSEQ.halfpi gSG.AWGFreq pi gSG.AWGAmp];
WaveForm_1Q = [0 gmSEQ.halfpi gSG.AWGFreq -pi/2 gSG.AWGAmp;...
    gmSEQ.halfpi+gmSEQ.m/2 gmSEQ.halfpi+gmSEQ.m/2+gmSEQ.pi gSG.AWGFreq pi/2-pi/2 gSG.AWGAmp; ...
    gmSEQ.halfpi+gmSEQ.m/2+gmSEQ.pi+gmSEQ.m/2 gmSEQ.halfpi+gmSEQ.m/2+gmSEQ.pi+gmSEQ.m/2+gmSEQ.halfpi gSG.AWGFreq pi-pi/2 gSG.AWGAmp];

WaveForm_1Length = ceil((gmSEQ.halfpi+gmSEQ.m/2+gmSEQ.pi+gmSEQ.m/2+gmSEQ.halfpi+1000) / (16 / gSG.AWGClockRate)) ...
    *(16 / gSG.AWGClockRate);
WaveForm_1PointNum = WaveForm_1Length * gSG.AWGClockRate;

WaveForm_2I = [0 gmSEQ.halfpi gSG.AWGFreq 0 gSG.AWGAmp;...
    gmSEQ.halfpi+gmSEQ.m/2 gmSEQ.halfpi+gmSEQ.m/2+gmSEQ.pi gSG.AWGFreq pi/2 gSG.AWGAmp; ...
    gmSEQ.halfpi+gmSEQ.m/2+gmSEQ.pi+gmSEQ.m/2 gmSEQ.halfpi+gmSEQ.m/2+gmSEQ.pi+gmSEQ.m/2+gmSEQ.halfpi gSG.AWGFreq 0 gSG.AWGAmp];
WaveForm_2Q = [0 gmSEQ.halfpi gSG.AWGFreq -pi/2 gSG.AWGAmp;...
    gmSEQ.halfpi+gmSEQ.m/2 gmSEQ.halfpi+gmSEQ.m/2+gmSEQ.pi gSG.AWGFreq pi/2-pi/2 gSG.AWGAmp; ...
    gmSEQ.halfpi+gmSEQ.m/2+gmSEQ.pi+gmSEQ.m/2 gmSEQ.halfpi+gmSEQ.m/2+gmSEQ.pi+gmSEQ.m/2+gmSEQ.halfpi gSG.AWGFreq 0-pi/2 gSG.AWGAmp];

WaveForm_2Length = ceil((gmSEQ.halfpi+gmSEQ.m/2+gmSEQ.pi+gmSEQ.m/2+gmSEQ.halfpi+1000) / (16 / gSG.AWGClockRate)) ...
    *(16 / gSG.AWGClockRate);
WaveForm_2PointNum = WaveForm_2Length * gSG.AWGClockRate;

WaveForm_3I = [0, gmSEQ.DEERt, gSG3.AWGFreq, 0*pi+0, gSG3.AWGAmp];
WaveForm_3Q = [0, gmSEQ.DEERt, gSG3.AWGFreq, 0*pi-pi/2, gSG3.AWGAmp];
WaveForm_3Length = ceil((gmSEQ.DEERt + 1000) / (16/gSG3.AWGClockRate)) * (16/gSG3.AWGClockRate);
WaveForm_3PointNum = WaveForm_3Length*gSG3.AWGClockRate;
    
    
chaseFunctionPool('createWaveform', WaveForm_1I, gSG.AWGClockRate, WaveForm_1Length, 'Echo_I_seg1.txt'); pause(0.5);
chaseFunctionPool('createWaveform', WaveForm_1Q, gSG.AWGClockRate, WaveForm_1Length, 'Echo_Q_seg1.txt'); pause(0.5);
chaseFunctionPool('createWaveform', WaveForm_2I, gSG.AWGClockRate, WaveForm_2Length, 'Echo_I_seg2.txt'); pause(0.5);
chaseFunctionPool('createWaveform', WaveForm_2Q, gSG.AWGClockRate, WaveForm_2Length, 'Echo_Q_seg2.txt'); pause(0.5);
chaseFunctionPool('createWaveform', WaveForm_3I, gSG3.AWGClockRate, WaveForm_3Length, 'Echo_I_seg3.txt'); pause(0.5);
chaseFunctionPool('createWaveform', WaveForm_3Q, gSG3.AWGClockRate, WaveForm_3Length, 'Echo_Q_seg3.txt'); pause(0.5);

chaseFunctionPool('createSegStruct', 'Echo_SegStruct_I.txt', ...
    'Echo_I_seg1.txt', WaveForm_1PointNum, 1, 1, ...
    'Echo_I_seg2.txt', WaveForm_2PointNum, 1, 1);
pause(0.5);
chaseFunctionPool('createSegStruct', 'Echo_SegStruct_Q.txt', ...
    'Echo_Q_seg1.txt', WaveForm_1PointNum, 1, 1, ...
    'Echo_Q_seg2.txt', WaveForm_2PointNum, 1, 1);
pause(0.5);
chaseFunctionPool('CreateSegments', gmSEQ.MWAWG, 1, ...
    2, ...
    2047, 2047, 'Echo_SegStruct_I.txt', 'false');
pause(1); % this pause seems to be important, otherwise the loading is not right occassionally
chaseFunctionPool('CreateSegments', gmSEQ.MWAWG, 2, ...
    2, ...
    2047, 2047, 'Echo_SegStruct_Q.txt', 'false');
pause(1); % this pause seems to be important, otherwise the loading is not right occassionally
chaseFunctionPool('runChase', gmSEQ.MWAWG, 'false');
chaseFunctionPool('CreateSingleSegment', gmSEQ.MWAWG2, 1, WaveForm_3PointNum, 1, 2047, 2047, 'Echo_I_seg3.txt', 1); pause(1);
chaseFunctionPool('CreateSingleSegment', gmSEQ.MWAWG2, 2, WaveForm_3PointNum, 1, 2047, 2047, 'Echo_Q_seg3.txt', 1); pause(1);

%% Run waveform
chaseFunctionPool('runChase', gmSEQ.MWAWG, 'false'); pause(0.5);
chaseFunctionPool('runChase', gmSEQ.MWAWG2, 'false');
ApplyDelays();

function Echo_HR
global gmSEQ gSG
gSG.bfixedPow=1;
gSG.bfixedFreq=1;
gSG.bMod='IQ';
gSG.bModSrc='External';

[gmSEQ.ScaleT, gmSEQ.ScaleStr] = GetScale(gmSEQ.To);
gmSEQ.HRhalfpi = gmSEQ.SLockT1;
gSG.HRAWGAmp = gmSEQ.SAmp1;

AfterPi = 2000;
AfterLaser = 0.05e6;
Wait_p = 0.01e6;
Detect_Window = 5000;

Sig_D_start = Wait_p+gmSEQ.readout+AfterLaser+gmSEQ.halfpi+gmSEQ.m/2+gmSEQ.pi+gmSEQ.m/2+gmSEQ.HRhalfpi+AfterPi+Detect_Window+Wait_p;

gmSEQ.CHN(1).PBN=PBDictionary('ctr0');
gmSEQ.CHN(1).NRise=4;
gmSEQ.CHN(1).T=[Wait_p+gmSEQ.readout-1000-gmSEQ.CtrGateDur, ...
    Wait_p+gmSEQ.readout+AfterLaser+gmSEQ.halfpi+gmSEQ.m/2+gmSEQ.pi+gmSEQ.m/2+gmSEQ.HRhalfpi+AfterPi, ...
    Sig_D_start+gmSEQ.readout-1000-gmSEQ.CtrGateDur, ... 
    Sig_D_start+gmSEQ.readout+AfterLaser+gmSEQ.halfpi+gmSEQ.m/2+gmSEQ.pi+gmSEQ.m/2+gmSEQ.HRhalfpi+AfterPi];
if strcmp(gmSEQ.meas,'SPCM')
    gmSEQ.CHN(1).DT=[gmSEQ.CtrGateDur gmSEQ.CtrGateDur gmSEQ.CtrGateDur gmSEQ.CtrGateDur];
elseif strcmp(gmSEQ.meas,'APD')
    gmSEQ.CHN(1).DT=[1000 1000 1000 1000];
end

gmSEQ.CHN(numel(gmSEQ.CHN)+1).PBN=PBDictionary('AOM');
gmSEQ.CHN(numel(gmSEQ.CHN)).NRise=4;
gmSEQ.CHN(numel(gmSEQ.CHN)).T = [Wait_p, Wait_p+gmSEQ.readout+AfterLaser+gmSEQ.halfpi+gmSEQ.m/2+gmSEQ.pi+gmSEQ.m/2+gmSEQ.HRhalfpi+AfterPi, ...
    Sig_D_start, Sig_D_start+gmSEQ.readout+AfterLaser+gmSEQ.halfpi+gmSEQ.m/2+gmSEQ.pi+gmSEQ.m/2+gmSEQ.HRhalfpi+AfterPi];
gmSEQ.CHN(numel(gmSEQ.CHN)).DT = [gmSEQ.readout Detect_Window gmSEQ.readout Detect_Window];
%

gmSEQ.CHN(numel(gmSEQ.CHN)+1).PBN=PBDictionary('AWGTrig');
gmSEQ.CHN(numel(gmSEQ.CHN)).NRise=2;
gmSEQ.CHN(numel(gmSEQ.CHN)).T=[Wait_p+gmSEQ.readout+AfterLaser, ...
    Sig_D_start+gmSEQ.readout+AfterLaser];
gmSEQ.CHN(numel(gmSEQ.CHN)).DT = repelem(gmSEQ.halfpi+gmSEQ.m/2+gmSEQ.pi+gmSEQ.m/2+gmSEQ.HRhalfpi+200, 2);


gmSEQ.CHN(numel(gmSEQ.CHN)+1).PBN=PBDictionary('MWSwitch');
if gmSEQ.m/2 < 200
    gmSEQ.CHN(numel(gmSEQ.CHN)).NRise=2;
    gmSEQ.CHN(numel(gmSEQ.CHN)).T=[Wait_p+gmSEQ.readout+AfterLaser-20, Sig_D_start+gmSEQ.readout+AfterLaser-20];
    gmSEQ.CHN(numel(gmSEQ.CHN)).DT=[gmSEQ.halfpi+gmSEQ.m/2+gmSEQ.pi+gmSEQ.m/2+gmSEQ.HRhalfpi+40, ... 
    gmSEQ.halfpi+gmSEQ.m/2+gmSEQ.pi+gmSEQ.m/2+gmSEQ.HRhalfpi+40];
else
    gmSEQ.CHN(numel(gmSEQ.CHN)).NRise=6;
    gmSEQ.CHN(numel(gmSEQ.CHN)).T=[Wait_p+gmSEQ.readout+AfterLaser-20, ...
        Wait_p+gmSEQ.readout+AfterLaser+gmSEQ.halfpi+gmSEQ.m/2-20, ...
        Wait_p+gmSEQ.readout+AfterLaser+gmSEQ.halfpi+gmSEQ.m/2+gmSEQ.pi+gmSEQ.m/2-20, ...
        Sig_D_start+gmSEQ.readout+AfterLaser-20, ... 
        Sig_D_start+gmSEQ.readout+AfterLaser+gmSEQ.halfpi+gmSEQ.m/2-20, ...
        Sig_D_start+gmSEQ.readout+AfterLaser+gmSEQ.halfpi+gmSEQ.m/2+gmSEQ.pi+gmSEQ.m/2-20];
    gmSEQ.CHN(numel(gmSEQ.CHN)).DT=[gmSEQ.halfpi+40, gmSEQ.pi+40, gmSEQ.HRhalfpi+40, ... 
    gmSEQ.halfpi+40, gmSEQ.pi+40, gmSEQ.HRhalfpi+40];
end

gmSEQ.CHN(numel(gmSEQ.CHN)+1).PBN=PBDictionary('dummy1');
gmSEQ.CHN(numel(gmSEQ.CHN)).NRise=2;
gmSEQ.CHN(numel(gmSEQ.CHN)).T=[0 Sig_D_start+gmSEQ.readout+AfterLaser+gmSEQ.halfpi+gmSEQ.m/2+gmSEQ.pi+gmSEQ.m/2+gmSEQ.HRhalfpi+AfterPi+Detect_Window-50];
gmSEQ.CHN(numel(gmSEQ.CHN)).DT=[50 50];

% gmSEQ.MWAWG = 1;
% disp(gmSEQ.MWAWG)

%% AWG
% Initialization
chaseFunctionPool('stopChase',  gmSEQ.MWAWG)

if ~gSG.ACmodAWG % in AC modulation mode
    gSG.AWGFreq = 0;
end

WaveForm_1I = [0 gmSEQ.halfpi gSG.AWGFreq 0 gSG.AWGAmp;...
    gmSEQ.halfpi+gmSEQ.m/2 gmSEQ.halfpi+gmSEQ.m/2+gmSEQ.pi gSG.AWGFreq pi/2 gSG.AWGAmp; ...
    gmSEQ.halfpi+gmSEQ.m/2+gmSEQ.pi+gmSEQ.m/2 gmSEQ.halfpi+gmSEQ.m/2+gmSEQ.pi+gmSEQ.m/2+gmSEQ.HRhalfpi gSG.AWGFreq pi gSG.HRAWGAmp];
WaveForm_1Q = [0 gmSEQ.halfpi gSG.AWGFreq -pi/2 gSG.AWGAmp;...
    gmSEQ.halfpi+gmSEQ.m/2 gmSEQ.halfpi+gmSEQ.m/2+gmSEQ.pi gSG.AWGFreq pi/2-pi/2 gSG.AWGAmp; ...
    gmSEQ.halfpi+gmSEQ.m/2+gmSEQ.pi+gmSEQ.m/2 gmSEQ.halfpi+gmSEQ.m/2+gmSEQ.pi+gmSEQ.m/2+gmSEQ.HRhalfpi gSG.AWGFreq pi-pi/2 gSG.HRAWGAmp];

WaveForm_1Length = ceil((gmSEQ.halfpi+gmSEQ.m/2+gmSEQ.pi+gmSEQ.m/2+gmSEQ.halfpi+1000) / (16 / gSG.AWGClockRate)) ...
    *(16 / gSG.AWGClockRate);
WaveForm_1PointNum = WaveForm_1Length * gSG.AWGClockRate;

WaveForm_2I = [0 gmSEQ.halfpi gSG.AWGFreq 0 gSG.AWGAmp;...
    gmSEQ.halfpi+gmSEQ.m/2 gmSEQ.halfpi+gmSEQ.m/2+gmSEQ.pi gSG.AWGFreq pi/2 gSG.AWGAmp; ...
    gmSEQ.halfpi+gmSEQ.m/2+gmSEQ.pi+gmSEQ.m/2 gmSEQ.halfpi+gmSEQ.m/2+gmSEQ.pi+gmSEQ.m/2+gmSEQ.HRhalfpi gSG.AWGFreq 0 gSG.HRAWGAmp];
WaveForm_2Q = [0 gmSEQ.halfpi gSG.AWGFreq -pi/2 gSG.AWGAmp;...
    gmSEQ.halfpi+gmSEQ.m/2 gmSEQ.halfpi+gmSEQ.m/2+gmSEQ.pi gSG.AWGFreq pi/2-pi/2 gSG.AWGAmp; ...
    gmSEQ.halfpi+gmSEQ.m/2+gmSEQ.pi+gmSEQ.m/2 gmSEQ.halfpi+gmSEQ.m/2+gmSEQ.pi+gmSEQ.m/2+gmSEQ.HRhalfpi gSG.AWGFreq 0-pi/2 gSG.HRAWGAmp];

WaveForm_2Length = ceil((gmSEQ.halfpi+gmSEQ.m/2+gmSEQ.pi+gmSEQ.m/2+gmSEQ.halfpi+1000) / (16 / gSG.AWGClockRate)) ...
    *(16 / gSG.AWGClockRate);
WaveForm_2PointNum = WaveForm_2Length * gSG.AWGClockRate;
            

chaseFunctionPool('createWaveform', WaveForm_1I, gSG.AWGClockRate, WaveForm_1Length, 'Echo_I_seg1.txt'); pause(0.5);
chaseFunctionPool('createWaveform', WaveForm_1Q, gSG.AWGClockRate, WaveForm_1Length, 'Echo_Q_seg1.txt'); pause(0.5);
chaseFunctionPool('createWaveform', WaveForm_2I, gSG.AWGClockRate, WaveForm_2Length, 'Echo_I_seg2.txt'); pause(0.5);
chaseFunctionPool('createWaveform', WaveForm_2Q, gSG.AWGClockRate, WaveForm_2Length, 'Echo_Q_seg2.txt'); pause(0.5);

chaseFunctionPool('createSegStruct', 'Echo_SegStruct_I.txt', ...
    'Echo_I_seg1.txt', WaveForm_1PointNum, 1, 1, ...
    'Echo_I_seg2.txt', WaveForm_2PointNum, 1, 1);
pause(0.5);
chaseFunctionPool('createSegStruct', 'Echo_SegStruct_Q.txt', ...
    'Echo_Q_seg1.txt', WaveForm_1PointNum, 1, 1, ...
    'Echo_Q_seg2.txt', WaveForm_2PointNum, 1, 1);
pause(0.5);
chaseFunctionPool('CreateSegments', gmSEQ.MWAWG, 1, ...
    2, ...
    2047, 2047, 'Echo_SegStruct_I.txt', 'false');
pause(1); % this pause seems to be important, otherwise the loading is not right occassionally
chaseFunctionPool('CreateSegments', gmSEQ.MWAWG, 2, ...
    2, ...
    2047, 2047, 'Echo_SegStruct_Q.txt', 'false');
pause(1); % this pause seems to be important, otherwise the loading is not right occassionally
chaseFunctionPool('runChase', gmSEQ.MWAWG, 'false');

ApplyDelays();


function Echo_Double
global gmSEQ gSG gSG3
gSG.bfixedPow=1;
gSG.bfixedFreq=1;
gSG.bMod='IQ';
gSG.bModSrc='External';

[gmSEQ.ScaleT, gmSEQ.ScaleStr] = GetScale(gmSEQ.To);

gSG3.bMod='IQ';
gSG3.bModSrc='External';
SignalGeneratorFunctionPool3('SetMod');
SignalGeneratorFunctionPool3('WritePow');
SignalGeneratorFunctionPool3('WriteFreq');
gSG3.bOn=1; SignalGeneratorFunctionPool3('RFOnOff');

AfterPi = 2000;
AfterLaser = 0.05e6; % Should be changed to larger than 100 us later
% AfterLaser = 10000;
Wait_p = 2000;
Detect_Window = 5000;
PulseGap = 2;
gmSEQ.pi2 = gmSEQ.pi;
% PulseGap = 0;
% gmSEQ.pi2 = 0;

Sig_D_start = Wait_p+gmSEQ.readout+AfterLaser+gmSEQ.halfpi+PulseGap+gmSEQ.pi2+gmSEQ.m/2+gmSEQ.pi2+PulseGap+gmSEQ.pi+PulseGap+gmSEQ.pi2 ...
    +gmSEQ.m/2+gmSEQ.pi2+PulseGap+gmSEQ.halfpi+AfterPi+Detect_Window+Wait_p;

gmSEQ.CHN(1).PBN=PBDictionary('ctr0');
gmSEQ.CHN(1).NRise=4;
gmSEQ.CHN(1).T=[Wait_p+gmSEQ.readout-1000-gmSEQ.CtrGateDur, ...
    Wait_p+gmSEQ.readout+AfterLaser+gmSEQ.halfpi+PulseGap+gmSEQ.pi2+gmSEQ.m/2+gmSEQ.pi2+PulseGap+gmSEQ.pi+PulseGap+gmSEQ.pi2+gmSEQ.m/2+gmSEQ.pi2+PulseGap+gmSEQ.halfpi+AfterPi, ...
    Sig_D_start+gmSEQ.readout-1000-gmSEQ.CtrGateDur, ... 
    Sig_D_start+gmSEQ.readout+AfterLaser+gmSEQ.halfpi+PulseGap+gmSEQ.pi2+gmSEQ.m/2+gmSEQ.pi2+PulseGap+gmSEQ.pi+PulseGap+gmSEQ.pi2+gmSEQ.m/2+gmSEQ.pi2+PulseGap+gmSEQ.halfpi+AfterPi];
if strcmp(gmSEQ.meas,'SPCM')
    gmSEQ.CHN(1).DT=[gmSEQ.CtrGateDur gmSEQ.CtrGateDur gmSEQ.CtrGateDur gmSEQ.CtrGateDur];
elseif strcmp(gmSEQ.meas,'APD')
    gmSEQ.CHN(1).DT=[1000 1000 1000 1000];
end

gmSEQ.CHN(numel(gmSEQ.CHN)+1).PBN=PBDictionary('AOM');
gmSEQ.CHN(numel(gmSEQ.CHN)).NRise=4;
gmSEQ.CHN(numel(gmSEQ.CHN)).T = [Wait_p, Wait_p+gmSEQ.readout+AfterLaser+gmSEQ.halfpi+PulseGap+gmSEQ.pi2+gmSEQ.m/2+gmSEQ.pi2+PulseGap+gmSEQ.pi+PulseGap+gmSEQ.pi2+gmSEQ.m/2+gmSEQ.pi2+PulseGap+gmSEQ.halfpi+AfterPi, ...
    Sig_D_start, Sig_D_start+gmSEQ.readout+AfterLaser+gmSEQ.halfpi+PulseGap+gmSEQ.pi2+gmSEQ.m/2+gmSEQ.pi2+PulseGap+gmSEQ.pi+PulseGap+gmSEQ.pi2+gmSEQ.m/2+gmSEQ.pi2+PulseGap+gmSEQ.halfpi+AfterPi];
gmSEQ.CHN(numel(gmSEQ.CHN)).DT = [gmSEQ.readout Detect_Window gmSEQ.readout Detect_Window];

gmSEQ.CHN(numel(gmSEQ.CHN)+1).PBN=PBDictionary('AWGTrig');
gmSEQ.CHN(numel(gmSEQ.CHN)).NRise=2;
gmSEQ.CHN(numel(gmSEQ.CHN)).T=[Wait_p+gmSEQ.readout+AfterLaser, ...
    Sig_D_start+gmSEQ.readout+AfterLaser];
gmSEQ.CHN(numel(gmSEQ.CHN)).DT = repelem(gmSEQ.halfpi+PulseGap+gmSEQ.pi2+gmSEQ.m/2+gmSEQ.pi2+PulseGap+gmSEQ.pi+PulseGap+gmSEQ.pi2+gmSEQ.m/2+gmSEQ.pi2+PulseGap+gmSEQ.halfpi+300, 2);

gmSEQ.CHN(numel(gmSEQ.CHN)+1).PBN=PBDictionary('AWGTrig3');
gmSEQ.CHN(numel(gmSEQ.CHN)).NRise=2;
gmSEQ.CHN(numel(gmSEQ.CHN)).T=[Wait_p+gmSEQ.readout+AfterLaser, ...
    Sig_D_start+gmSEQ.readout+AfterLaser];
gmSEQ.CHN(numel(gmSEQ.CHN)).DT = repelem(gmSEQ.halfpi+PulseGap+gmSEQ.pi2+gmSEQ.m/2+gmSEQ.pi2+PulseGap+gmSEQ.pi+PulseGap+gmSEQ.pi2+gmSEQ.m/2+gmSEQ.pi2+PulseGap+gmSEQ.halfpi+300, 2);

% gmSEQ.CHN(numel(gmSEQ.CHN)+1).PBN=PBDictionary('MWSwitch');
% if gmSEQ.m/2 < 200
%     gmSEQ.CHN(numel(gmSEQ.CHN)).NRise=2;
%     gmSEQ.CHN(numel(gmSEQ.CHN)).T=[Wait_p+gmSEQ.readout+AfterLaser-100, Sig_D_start+gmSEQ.readout+AfterLaser-100];
%     gmSEQ.CHN(numel(gmSEQ.CHN)).DT=repelem(gmSEQ.halfpi+PulseGap+gmSEQ.pi2+gmSEQ.m/2+gmSEQ.pi2+PulseGap+gmSEQ.pi+PulseGap+gmSEQ.pi2+gmSEQ.m/2+gmSEQ.pi2+PulseGap+gmSEQ.halfpi+200,2);
% else
%     gmSEQ.CHN(numel(gmSEQ.CHN)).NRise=6;
%     gmSEQ.CHN(numel(gmSEQ.CHN)).T=[Wait_p+gmSEQ.readout+AfterLaser-20, ...
%         Wait_p+gmSEQ.readout+AfterLaser+gmSEQ.halfpi+PulseGap+gmSEQ.pi2+gmSEQ.m/2+gmSEQ.pi2+PulseGap-20, ...
%         Wait_p+gmSEQ.readout+AfterLaser+gmSEQ.halfpi+PulseGap+gmSEQ.pi2+gmSEQ.m/2+gmSEQ.pi2+PulseGap+gmSEQ.pi+PulseGap+gmSEQ.pi2+gmSEQ.m/2+gmSEQ.pi2+PulseGap-20, ...
%         Sig_D_start+gmSEQ.readout+AfterLaser-20, ... 
%         Sig_D_start+gmSEQ.readout+AfterLaser+gmSEQ.halfpi+PulseGap+gmSEQ.pi2+gmSEQ.m/2+gmSEQ.pi2+PulseGap-20, ...
%         Sig_D_start+gmSEQ.readout+AfterLaser+gmSEQ.halfpi+PulseGap+gmSEQ.pi2+gmSEQ.m/2+gmSEQ.pi2+PulseGap+gmSEQ.pi+PulseGap+gmSEQ.pi2+gmSEQ.m/2+gmSEQ.pi2+PulseGap-20];
%     gmSEQ.CHN(numel(gmSEQ.CHN)).DT=[gmSEQ.halfpi+40, gmSEQ.pi+40, gmSEQ.halfpi+40, ... 
%     gmSEQ.halfpi+40, gmSEQ.pi+40, gmSEQ.halfpi+40];
% end
% 
% gmSEQ.CHN(numel(gmSEQ.CHN)+1).PBN=PBDictionary('MWSwitch3');
% if gmSEQ.m/2 < 200
%     gmSEQ.CHN(numel(gmSEQ.CHN)).NRise=2;
%     gmSEQ.CHN(numel(gmSEQ.CHN)).T=[Wait_p+gmSEQ.readout+AfterLaser-20, Sig_D_start+gmSEQ.readout+AfterLaser-20];
%     gmSEQ.CHN(numel(gmSEQ.CHN)).DT=repelem(gmSEQ.halfpi+PulseGap+gmSEQ.pi2+gmSEQ.m/2+gmSEQ.pi2+PulseGap+gmSEQ.pi+PulseGap+gmSEQ.pi2+gmSEQ.m/2+gmSEQ.pi2+PulseGap+gmSEQ.halfpi+40,2);
% else
%     gmSEQ.CHN(numel(gmSEQ.CHN)).NRise=8;
%     gmSEQ.CHN(numel(gmSEQ.CHN)).T=[Wait_p+gmSEQ.readout+AfterLaser+gmSEQ.halfpi+PulseGap-20, ...
%         Wait_p+gmSEQ.readout+AfterLaser+gmSEQ.halfpi+PulseGap+gmSEQ.pi2+gmSEQ.m/2-20, ...
%         Wait_p+gmSEQ.readout+AfterLaser+gmSEQ.halfpi+PulseGap+gmSEQ.pi2+gmSEQ.m/2+gmSEQ.pi2+PulseGap+gmSEQ.pi+PulseGap-20, ...
%         Wait_p+gmSEQ.readout+AfterLaser+gmSEQ.halfpi+PulseGap+gmSEQ.pi2+gmSEQ.m/2+gmSEQ.pi2+PulseGap+gmSEQ.pi+PulseGap+gmSEQ.pi2+gmSEQ.m/2-20, ...
%         Sig_D_start+gmSEQ.readout+AfterLaser+gmSEQ.halfpi+PulseGap-20, ... 
%         Sig_D_start+gmSEQ.readout+AfterLaser+gmSEQ.halfpi+PulseGap+gmSEQ.pi2+gmSEQ.m/2-20, ...
%         Sig_D_start+gmSEQ.readout+AfterLaser+gmSEQ.halfpi+PulseGap+gmSEQ.pi2+gmSEQ.m/2+gmSEQ.pi2+PulseGap+gmSEQ.pi+PulseGap-20, ...
%         Sig_D_start+gmSEQ.readout+AfterLaser+gmSEQ.halfpi+PulseGap+gmSEQ.pi2+gmSEQ.m/2+gmSEQ.pi2+PulseGap+gmSEQ.pi+PulseGap+gmSEQ.pi2+gmSEQ.m/2-20];
%     gmSEQ.CHN(numel(gmSEQ.CHN)).DT=repelem(gmSEQ.pi2 + 40, 8);
% end

BeforeDelay = 80;
AfterDelay = 20;
FullDelay = BeforeDelay+AfterDelay;
gmSEQ.CHN(numel(gmSEQ.CHN)+1).PBN=PBDictionary('MWSwitch');
if gmSEQ.m/2 < 200
    gmSEQ.CHN(numel(gmSEQ.CHN)).NRise=2;
    gmSEQ.CHN(numel(gmSEQ.CHN)).T=[Wait_p+gmSEQ.readout+AfterLaser-BeforeDelay, Sig_D_start+gmSEQ.readout+AfterLaser-BeforeDelay];
    gmSEQ.CHN(numel(gmSEQ.CHN)).DT=repelem(gmSEQ.halfpi+PulseGap+gmSEQ.pi2+gmSEQ.m/2+gmSEQ.pi2+PulseGap+gmSEQ.pi+PulseGap+gmSEQ.pi2+gmSEQ.m/2+gmSEQ.pi2+PulseGap+gmSEQ.halfpi+FullDelay,2);
else
    gmSEQ.CHN(numel(gmSEQ.CHN)).NRise=6;
    gmSEQ.CHN(numel(gmSEQ.CHN)).T=[Wait_p+gmSEQ.readout+AfterLaser-BeforeDelay, ...
        Wait_p+gmSEQ.readout+AfterLaser+gmSEQ.halfpi+PulseGap+gmSEQ.pi2+gmSEQ.m/2-BeforeDelay, ...
        Wait_p+gmSEQ.readout+AfterLaser+gmSEQ.halfpi+PulseGap+gmSEQ.pi2+gmSEQ.m/2+gmSEQ.pi2+PulseGap+gmSEQ.pi+PulseGap+gmSEQ.pi2+gmSEQ.m/2-BeforeDelay, ...
        Sig_D_start+gmSEQ.readout+AfterLaser-BeforeDelay, ... 
        Sig_D_start+gmSEQ.readout+AfterLaser+gmSEQ.halfpi+PulseGap+gmSEQ.pi2+gmSEQ.m/2-BeforeDelay, ...
        Sig_D_start+gmSEQ.readout+AfterLaser+gmSEQ.halfpi+PulseGap+gmSEQ.pi2+gmSEQ.m/2+gmSEQ.pi2+PulseGap+gmSEQ.pi+PulseGap+gmSEQ.pi2+gmSEQ.m/2-BeforeDelay];
    gmSEQ.CHN(numel(gmSEQ.CHN)).DT=[gmSEQ.halfpi+PulseGap+gmSEQ.pi2+FullDelay, gmSEQ.pi2+PulseGap+gmSEQ.pi+PulseGap+gmSEQ.pi2+FullDelay, gmSEQ.pi2+PulseGap+gmSEQ.halfpi+FullDelay, ... 
    gmSEQ.halfpi+PulseGap+gmSEQ.pi2+FullDelay, gmSEQ.pi2+PulseGap+gmSEQ.pi+PulseGap+gmSEQ.pi2+FullDelay, gmSEQ.pi2+PulseGap+gmSEQ.halfpi+FullDelay];
end

gmSEQ.CHN(numel(gmSEQ.CHN)+1).PBN=PBDictionary('MWSwitch3');
if gmSEQ.m/2 < 200
    gmSEQ.CHN(numel(gmSEQ.CHN)).NRise=2;
    gmSEQ.CHN(numel(gmSEQ.CHN)).T=[Wait_p+gmSEQ.readout+AfterLaser-BeforeDelay, Sig_D_start+gmSEQ.readout+AfterLaser-BeforeDelay];
    gmSEQ.CHN(numel(gmSEQ.CHN)).DT=repelem(gmSEQ.halfpi+PulseGap+gmSEQ.pi2+gmSEQ.m/2+gmSEQ.pi2+PulseGap+gmSEQ.pi+PulseGap+gmSEQ.pi2+gmSEQ.m/2+gmSEQ.pi2+PulseGap+gmSEQ.halfpi+FullDelay,2);
else
    gmSEQ.CHN(numel(gmSEQ.CHN)).NRise=6;
    gmSEQ.CHN(numel(gmSEQ.CHN)).T=[Wait_p+gmSEQ.readout+AfterLaser-BeforeDelay, ...
        Wait_p+gmSEQ.readout+AfterLaser+gmSEQ.halfpi+PulseGap+gmSEQ.pi2+gmSEQ.m/2-BeforeDelay, ...
        Wait_p+gmSEQ.readout+AfterLaser+gmSEQ.halfpi+PulseGap+gmSEQ.pi2+gmSEQ.m/2+gmSEQ.pi2+PulseGap+gmSEQ.pi+PulseGap+gmSEQ.pi2+gmSEQ.m/2-BeforeDelay, ...
        Sig_D_start+gmSEQ.readout+AfterLaser-BeforeDelay, ... 
        Sig_D_start+gmSEQ.readout+AfterLaser+gmSEQ.halfpi+PulseGap+gmSEQ.pi2+gmSEQ.m/2-BeforeDelay, ...
        Sig_D_start+gmSEQ.readout+AfterLaser+gmSEQ.halfpi+PulseGap+gmSEQ.pi2+gmSEQ.m/2+gmSEQ.pi2+PulseGap+gmSEQ.pi+PulseGap+gmSEQ.pi2+gmSEQ.m/2-BeforeDelay];
    gmSEQ.CHN(numel(gmSEQ.CHN)).DT=[gmSEQ.halfpi+PulseGap+gmSEQ.pi2+FullDelay, gmSEQ.pi2+PulseGap+gmSEQ.pi+PulseGap+gmSEQ.pi2+FullDelay, gmSEQ.pi2+PulseGap+gmSEQ.halfpi+FullDelay, ... 
    gmSEQ.halfpi+PulseGap+gmSEQ.pi2+FullDelay, gmSEQ.pi2+PulseGap+gmSEQ.pi+PulseGap+gmSEQ.pi2+FullDelay, gmSEQ.pi2+PulseGap+gmSEQ.halfpi+FullDelay];
end

gmSEQ.CHN(numel(gmSEQ.CHN)+1).PBN=PBDictionary('dummy1');
gmSEQ.CHN(numel(gmSEQ.CHN)).NRise=2;
gmSEQ.CHN(numel(gmSEQ.CHN)).T=[0 2*(Sig_D_start-Wait_p)-50];
gmSEQ.CHN(numel(gmSEQ.CHN)).DT=[50 50];

%% AWG
% Initialization
chaseFunctionPool('stopChase',  gmSEQ.MWAWG)
chaseFunctionPool('stopChase',  gmSEQ.MWAWG2)

if ~gSG.ACmodAWG % in AC modulation mode
    gSG.AWGFreq = 0;
    gSG3.AWGFreq = 0;
end

% Switch bright and dark signal 
% disp("Switching bright and bark.")

WaveForm_1I = [0 gmSEQ.halfpi gSG.AWGFreq 0 gSG.AWGAmp;...
    gmSEQ.halfpi+PulseGap+gmSEQ.pi2+gmSEQ.m/2+gmSEQ.pi2+PulseGap gmSEQ.halfpi+PulseGap+gmSEQ.pi2+gmSEQ.m/2+gmSEQ.pi2+PulseGap+gmSEQ.pi gSG.AWGFreq pi/2 gSG.AWGAmp; ...
    gmSEQ.halfpi+PulseGap+gmSEQ.pi2+gmSEQ.m/2+gmSEQ.pi2+PulseGap+gmSEQ.pi+PulseGap+gmSEQ.pi2+gmSEQ.m/2+gmSEQ.pi2+PulseGap gmSEQ.halfpi+PulseGap+gmSEQ.pi2+gmSEQ.m/2+gmSEQ.pi2+PulseGap+gmSEQ.pi+PulseGap+gmSEQ.pi2+gmSEQ.m/2+gmSEQ.pi2+PulseGap+gmSEQ.halfpi gSG.AWGFreq pi gSG.AWGAmp];
WaveForm_1Q = WaveForm_1I - repmat([0 0 0 pi/2 0], size(WaveForm_1I, 1), 1);
WaveForm_1Length = ceil((gmSEQ.halfpi+PulseGap+gmSEQ.pi2+gmSEQ.m/2+gmSEQ.pi2+PulseGap+gmSEQ.pi+PulseGap+gmSEQ.pi2+gmSEQ.m/2+gmSEQ.pi2+PulseGap+gmSEQ.halfpi+1000) / (16 / gSG.AWGClockRate)) ...
    *(16 / gSG.AWGClockRate);
WaveForm_1PointNum = WaveForm_1Length * gSG.AWGClockRate;

WaveForm_2I = [0 gmSEQ.halfpi gSG.AWGFreq 0 gSG.AWGAmp;...
    gmSEQ.halfpi+PulseGap+gmSEQ.pi2+gmSEQ.m/2+gmSEQ.pi2+PulseGap gmSEQ.halfpi+PulseGap+gmSEQ.pi2+gmSEQ.m/2+gmSEQ.pi2+PulseGap+gmSEQ.pi gSG.AWGFreq pi/2 gSG.AWGAmp; ...
    gmSEQ.halfpi+PulseGap+gmSEQ.pi2+gmSEQ.m/2+gmSEQ.pi2+PulseGap+gmSEQ.pi+PulseGap+gmSEQ.pi2+gmSEQ.m/2+gmSEQ.pi2+PulseGap gmSEQ.halfpi+PulseGap+gmSEQ.pi2+gmSEQ.m/2+gmSEQ.pi2+PulseGap+gmSEQ.pi+PulseGap+gmSEQ.pi2+gmSEQ.m/2+gmSEQ.pi2+PulseGap+gmSEQ.halfpi gSG.AWGFreq 0 gSG.AWGAmp];
WaveForm_2Q = WaveForm_2I - repmat([0 0 0 pi/2 0], size(WaveForm_2I, 1), 1);
WaveForm_2Length = WaveForm_1Length;
WaveForm_2PointNum = WaveForm_2Length * gSG.AWGClockRate;

WaveForm_3I = [0 gmSEQ.halfpi+PulseGap 0 0 0;...
    gmSEQ.halfpi+PulseGap gmSEQ.halfpi+PulseGap+gmSEQ.pi2 gSG3.AWGFreq 0 gSG3.AWGAmp;...
    gmSEQ.halfpi+PulseGap+gmSEQ.pi2+gmSEQ.m/2 gmSEQ.halfpi+PulseGap+gmSEQ.pi2+gmSEQ.m/2+gmSEQ.pi2 gSG3.AWGFreq pi gSG3.AWGAmp; ...
    gmSEQ.halfpi+PulseGap+gmSEQ.pi2+gmSEQ.m/2+gmSEQ.pi2+PulseGap+gmSEQ.pi+PulseGap gmSEQ.halfpi+PulseGap+gmSEQ.pi2+gmSEQ.m/2+gmSEQ.pi2+PulseGap+gmSEQ.pi+PulseGap+gmSEQ.pi2 gSG3.AWGFreq pi gSG3.AWGAmp; ...
    gmSEQ.halfpi+PulseGap+gmSEQ.pi2+gmSEQ.m/2+gmSEQ.pi2+PulseGap+gmSEQ.pi+PulseGap+gmSEQ.pi2+gmSEQ.m/2 gmSEQ.halfpi+PulseGap+gmSEQ.pi2+gmSEQ.m/2+gmSEQ.pi2+PulseGap+gmSEQ.pi+PulseGap+gmSEQ.pi2+gmSEQ.m/2+gmSEQ.pi2 gSG3.AWGFreq 0 gSG3.AWGAmp];
WaveForm_3Q = WaveForm_3I - repmat([0 0 0 pi/2 0], size(WaveForm_3I, 1), 1);
WaveForm_3Length = ceil((gmSEQ.halfpi+PulseGap+gmSEQ.pi2+gmSEQ.m/2+gmSEQ.pi2+PulseGap+gmSEQ.pi+PulseGap+gmSEQ.pi2+gmSEQ.m/2+gmSEQ.pi2+1000) / (16 / gSG.AWGClockRate)) ...
    *(16 / gSG.AWGClockRate);
WaveForm_3PointNum = WaveForm_3Length * gSG.AWGClockRate;

chaseFunctionPool('createWaveform', WaveForm_1I, gSG.AWGClockRate, WaveForm_1Length, 'Echo_I_seg1.txt'); pause(0.5);
chaseFunctionPool('createWaveform', WaveForm_1Q, gSG.AWGClockRate, WaveForm_1Length, 'Echo_Q_seg1.txt'); pause(0.5);
chaseFunctionPool('createWaveform', WaveForm_2I, gSG.AWGClockRate, WaveForm_2Length, 'Echo_I_seg2.txt'); pause(0.5);
chaseFunctionPool('createWaveform', WaveForm_2Q, gSG.AWGClockRate, WaveForm_2Length, 'Echo_Q_seg2.txt'); pause(0.5);

chaseFunctionPool('createWaveform', WaveForm_3I, gSG3.AWGClockRate, WaveForm_3Length, 'Echo_I_seg3.txt'); pause(0.5);
chaseFunctionPool('createWaveform', WaveForm_3Q, gSG3.AWGClockRate, WaveForm_3Length, 'Echo_Q_seg3.txt'); pause(0.5);

chaseFunctionPool('createSegStruct', 'Echo_SegStruct_I.txt', ...
    'Echo_I_seg1.txt', WaveForm_1PointNum, 1, 1, ...
    'Echo_I_seg2.txt', WaveForm_2PointNum, 1, 1);
pause(0.5);
chaseFunctionPool('createSegStruct', 'Echo_SegStruct_Q.txt', ...
    'Echo_Q_seg1.txt', WaveForm_1PointNum, 1, 1, ...
    'Echo_Q_seg2.txt', WaveForm_2PointNum, 1, 1);
pause(0.5);

chaseFunctionPool('createSegStruct', 'Echo_SegStruct_H_I.txt', ...
    'Echo_I_seg3.txt', WaveForm_3PointNum, 1, 1, ...
    'Echo_I_seg3.txt', WaveForm_3PointNum, 1, 1);
pause(0.5);
chaseFunctionPool('createSegStruct', 'Echo_SegStruct_H_Q.txt', ...
    'Echo_Q_seg3.txt', WaveForm_3PointNum, 1, 1, ...
    'Echo_Q_seg3.txt', WaveForm_3PointNum, 1, 1);
pause(0.5);

chaseFunctionPool('CreateSegments', gmSEQ.MWAWG, 1, ...
    2, ...
    2047, 2047, 'Echo_SegStruct_I.txt', 'false');
pause(1); % this pause seems to be important, otherwise the loading is not right occassionally
chaseFunctionPool('CreateSegments', gmSEQ.MWAWG, 2, ...
    2, ...
    2047, 2047, 'Echo_SegStruct_Q.txt', 'false');
pause(1); % this pause seems to be important, otherwise the loading is not right occassionally

chaseFunctionPool('CreateSegments', gmSEQ.MWAWG2, 1, ...
    2, ...
    2047, 2047, 'Echo_SegStruct_H_I.txt', 'false');
pause(1); % this pause seems to be important, otherwise the loading is not right occassionally
chaseFunctionPool('CreateSegments', gmSEQ.MWAWG2, 2, ...
    2, ...
    2047, 2047, 'Echo_SegStruct_H_Q.txt', 'false');
pause(1); % this pause seems to be important, otherwise the loading is not right occassionally

chaseFunctionPool('runChase', gmSEQ.MWAWG, 'false');
pause(0.5)
chaseFunctionPool('runChase', gmSEQ.MWAWG2, 'false');

ApplyDelays();

function Sz_local_probe_old 
global gmSEQ gSG gSG2 gSG3
gSG.bfixedPow=1;
gSG.bfixedFreq=1;
gSG.bMod='IQ';
gSG.bModSrc='External';

[gmSEQ.ScaleT, gmSEQ.ScaleStr] = GetScale(gmSEQ.To);

gSG2.bMod='IQ';
gSG2.bModSrc='External';
SignalGeneratorFunctionPool2('SetMod');
SignalGeneratorFunctionPool2('WritePow');
SignalGeneratorFunctionPool2('WriteFreq');
gSG2.bOn=1; SignalGeneratorFunctionPool2('RFOnOff');

gSG3.bMod='IQ';
gSG3.bModSrc='External';
SignalGeneratorFunctionPool3('SetMod');
SignalGeneratorFunctionPool3('WritePow');
SignalGeneratorFunctionPool3('WriteFreq');
gSG3.bOn=1; SignalGeneratorFunctionPool3('RFOnOff');

AfterPi = 2000;
AfterLaser = 0.05e6; % Should be changed to larger than 100 us later
% AfterLaser = 10000;
Wait_p = 2000;
Detect_Window = 5000;
PulseGap = 2;
gmSEQ.pi2 = gmSEQ.pi;

gmSEQ.rotTime = gmSEQ.SLockT1;
AfterRot = 1000;

% PulseGap = 0;
% gmSEQ.pi2 = 0;

Sig_D_start = Wait_p+gmSEQ.readout+AfterLaser+gmSEQ.rotTime+AfterRot+gmSEQ.halfpi+PulseGap+gmSEQ.pi2+gmSEQ.m/2+gmSEQ.pi2+PulseGap+gmSEQ.pi+PulseGap+gmSEQ.pi2 ...
    +gmSEQ.m/2+gmSEQ.pi2+PulseGap+gmSEQ.halfpi+AfterPi+Detect_Window+Wait_p;

gmSEQ.CHN(1).PBN=PBDictionary('ctr0');
gmSEQ.CHN(1).NRise=4;
gmSEQ.CHN(1).T=[Wait_p+gmSEQ.readout-1000-gmSEQ.CtrGateDur, ...
    Wait_p+gmSEQ.readout+AfterLaser+gmSEQ.rotTime+AfterRot+gmSEQ.halfpi+PulseGap+gmSEQ.pi2+gmSEQ.m/2+gmSEQ.pi2+PulseGap+gmSEQ.pi+PulseGap+gmSEQ.pi2+gmSEQ.m/2+gmSEQ.pi2+PulseGap+gmSEQ.halfpi+AfterPi, ...
    Sig_D_start+gmSEQ.readout-1000-gmSEQ.CtrGateDur, ... 
    Sig_D_start+gmSEQ.readout+gmSEQ.rotTime+AfterRot+AfterLaser+gmSEQ.halfpi+PulseGap+gmSEQ.pi2+gmSEQ.m/2+gmSEQ.pi2+PulseGap+gmSEQ.pi+PulseGap+gmSEQ.pi2+gmSEQ.m/2+gmSEQ.pi2+PulseGap+gmSEQ.halfpi+AfterPi];
if strcmp(gmSEQ.meas,'SPCM')
    gmSEQ.CHN(1).DT=[gmSEQ.CtrGateDur gmSEQ.CtrGateDur gmSEQ.CtrGateDur gmSEQ.CtrGateDur];
elseif strcmp(gmSEQ.meas,'APD')
    gmSEQ.CHN(1).DT=[1000 1000 1000 1000];
end

gmSEQ.CHN(numel(gmSEQ.CHN)+1).PBN=PBDictionary('AOM');
gmSEQ.CHN(numel(gmSEQ.CHN)).NRise=4;
gmSEQ.CHN(numel(gmSEQ.CHN)).T = [Wait_p, Wait_p+gmSEQ.readout+AfterLaser+gmSEQ.rotTime+AfterRot+gmSEQ.halfpi+PulseGap+gmSEQ.pi2+gmSEQ.m/2+gmSEQ.pi2+PulseGap+gmSEQ.pi+PulseGap+gmSEQ.pi2+gmSEQ.m/2+gmSEQ.pi2+PulseGap+gmSEQ.halfpi+AfterPi, ...
    Sig_D_start, Sig_D_start+gmSEQ.readout+AfterLaser+gmSEQ.rotTime+AfterRot+gmSEQ.halfpi+PulseGap+gmSEQ.pi2+gmSEQ.m/2+gmSEQ.pi2+PulseGap+gmSEQ.pi+PulseGap+gmSEQ.pi2+gmSEQ.m/2+gmSEQ.pi2+PulseGap+gmSEQ.halfpi+AfterPi];
gmSEQ.CHN(numel(gmSEQ.CHN)).DT = [gmSEQ.readout Detect_Window gmSEQ.readout Detect_Window];

gmSEQ.CHN(numel(gmSEQ.CHN)+1).PBN=PBDictionary('AWGTrig');
gmSEQ.CHN(numel(gmSEQ.CHN)).NRise=2;
gmSEQ.CHN(numel(gmSEQ.CHN)).T=[Wait_p+gmSEQ.readout+AfterLaser+gmSEQ.rotTime+AfterRot, ...
    Sig_D_start+gmSEQ.readout+AfterLaser+gmSEQ.rotTime+AfterRot];
gmSEQ.CHN(numel(gmSEQ.CHN)).DT = repelem(gmSEQ.halfpi+PulseGap+gmSEQ.pi2+gmSEQ.m/2+gmSEQ.pi2+PulseGap+gmSEQ.pi+PulseGap+gmSEQ.pi2+gmSEQ.m/2+gmSEQ.pi2+PulseGap+gmSEQ.halfpi+300, 2);

gmSEQ.CHN(numel(gmSEQ.CHN)+1).PBN=PBDictionary('AWGTrig2');
gmSEQ.CHN(numel(gmSEQ.CHN)).NRise=2;
gmSEQ.CHN(numel(gmSEQ.CHN)).T=[Wait_p+gmSEQ.readout+AfterLaser, ...
    Sig_D_start+gmSEQ.readout+AfterLaser];
gmSEQ.CHN(numel(gmSEQ.CHN)).DT = repelem(100, 2);

gmSEQ.CHN(numel(gmSEQ.CHN)+1).PBN=PBDictionary('AWGTrig3');
gmSEQ.CHN(numel(gmSEQ.CHN)).NRise=2;
gmSEQ.CHN(numel(gmSEQ.CHN)).T=[Wait_p+gmSEQ.readout+AfterLaser+gmSEQ.rotTime+AfterRot, ...
    Sig_D_start+gmSEQ.readout+AfterLaser+gmSEQ.rotTime+AfterRot];
gmSEQ.CHN(numel(gmSEQ.CHN)).DT = repelem(gmSEQ.halfpi+PulseGap+gmSEQ.pi2+gmSEQ.m/2+gmSEQ.pi2+PulseGap+gmSEQ.pi+PulseGap+gmSEQ.pi2+gmSEQ.m/2+gmSEQ.pi2+PulseGap+gmSEQ.halfpi+300, 2);

BeforeDelay = 80;
AfterDelay = 20;
FullDelay = BeforeDelay+AfterDelay;
gmSEQ.CHN(numel(gmSEQ.CHN)+1).PBN=PBDictionary('MWSwitch');
if gmSEQ.m/2 < 200
    gmSEQ.CHN(numel(gmSEQ.CHN)).NRise=2;
    gmSEQ.CHN(numel(gmSEQ.CHN)).T=[Wait_p+gmSEQ.readout+AfterLaser+gmSEQ.rotTime+AfterRot-BeforeDelay, Sig_D_start+gmSEQ.readout+AfterLaser+gmSEQ.rotTime+AfterRot-BeforeDelay];
    gmSEQ.CHN(numel(gmSEQ.CHN)).DT=repelem(gmSEQ.halfpi+PulseGap+gmSEQ.pi2+gmSEQ.m/2+gmSEQ.pi2+PulseGap+gmSEQ.pi+PulseGap+gmSEQ.pi2+gmSEQ.m/2+gmSEQ.pi2+PulseGap+gmSEQ.halfpi+FullDelay,2);
else
    gmSEQ.CHN(numel(gmSEQ.CHN)).NRise=6;
    gmSEQ.CHN(numel(gmSEQ.CHN)).T=[Wait_p+gmSEQ.readout+AfterLaser+gmSEQ.rotTime+AfterRot-BeforeDelay, ...
        Wait_p+gmSEQ.readout+AfterLaser+gmSEQ.rotTime+AfterRot+gmSEQ.halfpi+PulseGap+gmSEQ.pi2+gmSEQ.m/2-BeforeDelay, ...
        Wait_p+gmSEQ.readout+AfterLaser+gmSEQ.rotTime+AfterRot+gmSEQ.halfpi+PulseGap+gmSEQ.pi2+gmSEQ.m/2+gmSEQ.pi2+PulseGap+gmSEQ.pi+PulseGap+gmSEQ.pi2+gmSEQ.m/2-BeforeDelay, ...
        Sig_D_start+gmSEQ.readout+AfterLaser+gmSEQ.rotTime+AfterRot-BeforeDelay, ... 
        Sig_D_start+gmSEQ.readout+AfterLaser+gmSEQ.rotTime+AfterRot+gmSEQ.halfpi+PulseGap+gmSEQ.pi2+gmSEQ.m/2-BeforeDelay, ...
        Sig_D_start+gmSEQ.readout+AfterLaser+gmSEQ.rotTime+AfterRot+gmSEQ.halfpi+PulseGap+gmSEQ.pi2+gmSEQ.m/2+gmSEQ.pi2+PulseGap+gmSEQ.pi+PulseGap+gmSEQ.pi2+gmSEQ.m/2-BeforeDelay];
    gmSEQ.CHN(numel(gmSEQ.CHN)).DT=[gmSEQ.halfpi+PulseGap+gmSEQ.pi2+FullDelay, gmSEQ.pi2+PulseGap+gmSEQ.pi+PulseGap+gmSEQ.pi2+FullDelay, gmSEQ.pi2+PulseGap+gmSEQ.halfpi+FullDelay, ... 
    gmSEQ.halfpi+PulseGap+gmSEQ.pi2+FullDelay, gmSEQ.pi2+PulseGap+gmSEQ.pi+PulseGap+gmSEQ.pi2+FullDelay, gmSEQ.pi2+PulseGap+gmSEQ.halfpi+FullDelay];
end

gmSEQ.CHN(numel(gmSEQ.CHN)+1).PBN=PBDictionary('MWSwitch2');
gmSEQ.CHN(numel(gmSEQ.CHN)).NRise=4;
if gmSEQ.m/2 < 200
    gmSEQ.CHN(numel(gmSEQ.CHN)).T=[Wait_p+gmSEQ.readout+AfterLaser-BeforeDelay, ...
        Wait_p+gmSEQ.readout+AfterLaser+gmSEQ.rotTime+AfterRot-BeforeDelay, ...
        Sig_D_start+gmSEQ.readout+AfterLaser-BeforeDelay, ... 
        Sig_D_start+gmSEQ.readout+AfterLaser+gmSEQ.rotTime+AfterRot-BeforeDelay];
    gmSEQ.CHN(numel(gmSEQ.CHN)).DT=[gmSEQ.rotTime+FullDelay, gmSEQ.halfpi+PulseGap+gmSEQ.pi2+gmSEQ.m/2+gmSEQ.pi2+PulseGap+gmSEQ.pi+PulseGap+gmSEQ.pi2+gmSEQ.m/2+gmSEQ.pi2+PulseGap+gmSEQ.halfpi+FullDelay, ... 
    gmSEQ.rotTime+FullDelay, gmSEQ.halfpi+PulseGap+gmSEQ.pi2+gmSEQ.m/2+gmSEQ.pi2+PulseGap+gmSEQ.pi+PulseGap+gmSEQ.pi2+gmSEQ.m/2+gmSEQ.pi2+PulseGap+gmSEQ.halfpi+FullDelay];
else
    gmSEQ.CHN(numel(gmSEQ.CHN)).T=[Wait_p+gmSEQ.readout+AfterLaser-BeforeDelay, ...
        Wait_p+gmSEQ.readout+AfterLaser+gmSEQ.rotTime+AfterRot+gmSEQ.halfpi+PulseGap+gmSEQ.pi2+gmSEQ.m/2-BeforeDelay, ...
        Sig_D_start+gmSEQ.readout+AfterLaser-BeforeDelay, ... 
        Sig_D_start+gmSEQ.readout+AfterLaser+gmSEQ.rotTime+AfterRot+gmSEQ.rotTime+AfterRot+gmSEQ.halfpi+PulseGap+gmSEQ.pi2+gmSEQ.m/2-BeforeDelay];
    gmSEQ.CHN(numel(gmSEQ.CHN)).DT=[gmSEQ.rotTime+FullDelay, gmSEQ.pi2+PulseGap+gmSEQ.pi+PulseGap+gmSEQ.pi2+FullDelay, ... 
    gmSEQ.rotTime+FullDelay, gmSEQ.pi2+PulseGap+gmSEQ.pi+PulseGap+gmSEQ.pi2+FullDelay];
end


gmSEQ.CHN(numel(gmSEQ.CHN)+1).PBN=PBDictionary('MWSwitch3');
if gmSEQ.m/2 < 200
    gmSEQ.CHN(numel(gmSEQ.CHN)).NRise=2;
    gmSEQ.CHN(numel(gmSEQ.CHN)).T=[Wait_p+gmSEQ.readout+AfterLaser+gmSEQ.rotTime+AfterRot-BeforeDelay, Sig_D_start+gmSEQ.readout+AfterLaser+gmSEQ.rotTime+AfterRot-BeforeDelay];
    gmSEQ.CHN(numel(gmSEQ.CHN)).DT=repelem(gmSEQ.halfpi+PulseGap+gmSEQ.pi2+gmSEQ.m/2+gmSEQ.pi2+PulseGap+gmSEQ.pi+PulseGap+gmSEQ.pi2+gmSEQ.m/2+gmSEQ.pi2+PulseGap+gmSEQ.halfpi+FullDelay,2);
else
    gmSEQ.CHN(numel(gmSEQ.CHN)).NRise=6;
    gmSEQ.CHN(numel(gmSEQ.CHN)).T=[Wait_p+gmSEQ.readout+AfterLaser+gmSEQ.rotTime+AfterRot-BeforeDelay, ...
        Wait_p+gmSEQ.readout+AfterLaser+gmSEQ.rotTime+AfterRot+gmSEQ.halfpi+PulseGap+gmSEQ.pi2+gmSEQ.m/2-BeforeDelay, ...
        Wait_p+gmSEQ.readout+AfterLaser+gmSEQ.rotTime+AfterRot+gmSEQ.halfpi+PulseGap+gmSEQ.pi2+gmSEQ.m/2+gmSEQ.pi2+PulseGap+gmSEQ.pi+PulseGap+gmSEQ.pi2+gmSEQ.m/2-BeforeDelay, ...
        Sig_D_start+gmSEQ.readout+AfterLaser+gmSEQ.rotTime+AfterRot-BeforeDelay, ... 
        Sig_D_start+gmSEQ.readout+AfterLaser+gmSEQ.rotTime+AfterRot+gmSEQ.halfpi+PulseGap+gmSEQ.pi2+gmSEQ.m/2-BeforeDelay, ...
        Sig_D_start+gmSEQ.readout+AfterLaser+gmSEQ.rotTime+AfterRot+gmSEQ.halfpi+PulseGap+gmSEQ.pi2+gmSEQ.m/2+gmSEQ.pi2+PulseGap+gmSEQ.pi+PulseGap+gmSEQ.pi2+gmSEQ.m/2-BeforeDelay];
    gmSEQ.CHN(numel(gmSEQ.CHN)).DT=[gmSEQ.halfpi+PulseGap+gmSEQ.pi2+FullDelay, gmSEQ.pi2+PulseGap+gmSEQ.pi+PulseGap+gmSEQ.pi2+FullDelay, gmSEQ.pi2+PulseGap+gmSEQ.halfpi+FullDelay, ... 
    gmSEQ.halfpi+PulseGap+gmSEQ.pi2+FullDelay, gmSEQ.pi2+PulseGap+gmSEQ.pi+PulseGap+gmSEQ.pi2+FullDelay, gmSEQ.pi2+PulseGap+gmSEQ.halfpi+FullDelay];
end

gmSEQ.CHN(numel(gmSEQ.CHN)+1).PBN=PBDictionary('dummy1');
gmSEQ.CHN(numel(gmSEQ.CHN)).NRise=2;
gmSEQ.CHN(numel(gmSEQ.CHN)).T=[0 2*(Sig_D_start-Wait_p)-50];
gmSEQ.CHN(numel(gmSEQ.CHN)).DT=[50 50];

%% AWG
% Initialization
chaseFunctionPool('stopChase',  gmSEQ.MWAWG)
chaseFunctionPool('stopChase',  gmSEQ.P1AWG)
chaseFunctionPool('stopChase',  gmSEQ.MWAWG2)

if ~gSG.ACmodAWG % in AC modulation mode
    gSG.AWGFreq = 0;
    gSG2.AWGFreq = 0;
    gSG3.AWGFreq = 0;
end

% Switch bright and dark signal 
% disp("Switching bright and bark.")

WaveForm_1I = [0 gmSEQ.halfpi gSG.AWGFreq 0 gSG.AWGAmp;...
    gmSEQ.halfpi+PulseGap+gmSEQ.pi2+gmSEQ.m/2+gmSEQ.pi2+PulseGap gmSEQ.halfpi+PulseGap+gmSEQ.pi2+gmSEQ.m/2+gmSEQ.pi2+PulseGap+gmSEQ.pi gSG.AWGFreq pi/2 gSG.AWGAmp; ...
    gmSEQ.halfpi+PulseGap+gmSEQ.pi2+gmSEQ.m/2+gmSEQ.pi2+PulseGap+gmSEQ.pi+PulseGap+gmSEQ.pi2+gmSEQ.m/2+gmSEQ.pi2+PulseGap gmSEQ.halfpi+PulseGap+gmSEQ.pi2+gmSEQ.m/2+gmSEQ.pi2+PulseGap+gmSEQ.pi+PulseGap+gmSEQ.pi2+gmSEQ.m/2+gmSEQ.pi2+PulseGap+gmSEQ.halfpi gSG.AWGFreq pi gSG.AWGAmp];
WaveForm_1Q = WaveForm_1I - repmat([0 0 0 pi/2 0], size(WaveForm_1I, 1), 1);
WaveForm_1Length = ceil((gmSEQ.halfpi+PulseGap+gmSEQ.pi2+gmSEQ.m/2+gmSEQ.pi2+PulseGap+gmSEQ.pi+PulseGap+gmSEQ.pi2+gmSEQ.m/2+gmSEQ.pi2+PulseGap+gmSEQ.halfpi+1000) / (16 / gSG.AWGClockRate)) ...
    *(16 / gSG.AWGClockRate);
WaveForm_1PointNum = WaveForm_1Length * gSG.AWGClockRate;

WaveForm_2I = [0 gmSEQ.halfpi gSG.AWGFreq 0 gSG.AWGAmp;...
    gmSEQ.halfpi+PulseGap+gmSEQ.pi2+gmSEQ.m/2+gmSEQ.pi2+PulseGap gmSEQ.halfpi+PulseGap+gmSEQ.pi2+gmSEQ.m/2+gmSEQ.pi2+PulseGap+gmSEQ.pi gSG.AWGFreq pi/2 gSG.AWGAmp; ...
    gmSEQ.halfpi+PulseGap+gmSEQ.pi2+gmSEQ.m/2+gmSEQ.pi2+PulseGap+gmSEQ.pi+PulseGap+gmSEQ.pi2+gmSEQ.m/2+gmSEQ.pi2+PulseGap gmSEQ.halfpi+PulseGap+gmSEQ.pi2+gmSEQ.m/2+gmSEQ.pi2+PulseGap+gmSEQ.pi+PulseGap+gmSEQ.pi2+gmSEQ.m/2+gmSEQ.pi2+PulseGap+gmSEQ.halfpi gSG.AWGFreq 0 gSG.AWGAmp];
WaveForm_2Q = WaveForm_2I - repmat([0 0 0 pi/2 0], size(WaveForm_2I, 1), 1);
WaveForm_2Length = WaveForm_1Length;
WaveForm_2PointNum = WaveForm_2Length * gSG.AWGClockRate;

WaveForm_3I = [0 gmSEQ.halfpi+PulseGap 0 0 0;...
    gmSEQ.halfpi+PulseGap gmSEQ.halfpi+PulseGap+gmSEQ.pi2 gSG3.AWGFreq 0 gSG3.AWGAmp;...
    gmSEQ.halfpi+PulseGap+gmSEQ.pi2+gmSEQ.m/2 gmSEQ.halfpi+PulseGap+gmSEQ.pi2+gmSEQ.m/2+gmSEQ.pi2 gSG3.AWGFreq pi gSG3.AWGAmp; ...
    gmSEQ.halfpi+PulseGap+gmSEQ.pi2+gmSEQ.m/2+gmSEQ.pi2+PulseGap+gmSEQ.pi+PulseGap gmSEQ.halfpi+PulseGap+gmSEQ.pi2+gmSEQ.m/2+gmSEQ.pi2+PulseGap+gmSEQ.pi+PulseGap+gmSEQ.pi2 gSG3.AWGFreq pi gSG3.AWGAmp; ...
    gmSEQ.halfpi+PulseGap+gmSEQ.pi2+gmSEQ.m/2+gmSEQ.pi2+PulseGap+gmSEQ.pi+PulseGap+gmSEQ.pi2+gmSEQ.m/2 gmSEQ.halfpi+PulseGap+gmSEQ.pi2+gmSEQ.m/2+gmSEQ.pi2+PulseGap+gmSEQ.pi+PulseGap+gmSEQ.pi2+gmSEQ.m/2+gmSEQ.pi2 gSG3.AWGFreq 0 gSG3.AWGAmp];
WaveForm_3Q = WaveForm_3I - repmat([0 0 0 pi/2 0], size(WaveForm_3I, 1), 1);
WaveForm_3Length = ceil((gmSEQ.halfpi+PulseGap+gmSEQ.pi2+gmSEQ.m/2+gmSEQ.pi2+PulseGap+gmSEQ.pi+PulseGap+gmSEQ.pi2+gmSEQ.m/2+gmSEQ.pi2+1000) / (16 / gSG.AWGClockRate)) ...
    *(16 / gSG.AWGClockRate);
WaveForm_3PointNum = WaveForm_3Length * gSG.AWGClockRate;

WaveForm_4I = [0 gmSEQ.rotTime gSG2.AWGFreq 0 gSG2.AWGAmp;...
    gmSEQ.rotTime+AfterRot+gmSEQ.halfpi+PulseGap+gmSEQ.pi2+gmSEQ.m/2+gmSEQ.pi2+PulseGap gmSEQ.rotTime+AfterRot+gmSEQ.halfpi+PulseGap+gmSEQ.pi2+gmSEQ.m/2+gmSEQ.pi2+PulseGap+gmSEQ.pi gSG3.AWGFreq 0 gSG2.AWGAmp];
WaveForm_4Q = WaveForm_4I - repmat([0 0 0 pi/2 0], size(WaveForm_4I, 1), 1);
WaveForm_4Length = ceil((gmSEQ.rotTime+AfterRot+gmSEQ.halfpi+PulseGap+gmSEQ.pi2+gmSEQ.m/2+gmSEQ.pi2+PulseGap+gmSEQ.pi+1000) / (16 / gSG2.P1AWGClockRate)) ...
    *(16 / gSG2.P1AWGClockRate);
WaveForm_4PointNum = WaveForm_4Length * gSG2.P1AWGClockRate;

chaseFunctionPool('createWaveform', WaveForm_1I, gSG.AWGClockRate, WaveForm_1Length, 'Echo_I_seg1.txt'); pause(0.5);
chaseFunctionPool('createWaveform', WaveForm_1Q, gSG.AWGClockRate, WaveForm_1Length, 'Echo_Q_seg1.txt'); pause(0.5);
chaseFunctionPool('createWaveform', WaveForm_2I, gSG.AWGClockRate, WaveForm_2Length, 'Echo_I_seg2.txt'); pause(0.5);
chaseFunctionPool('createWaveform', WaveForm_2Q, gSG.AWGClockRate, WaveForm_2Length, 'Echo_Q_seg2.txt'); pause(0.5);

chaseFunctionPool('createWaveform', WaveForm_3I, gSG3.AWGClockRate, WaveForm_3Length, 'Echo_I_seg3.txt'); pause(0.5);
chaseFunctionPool('createWaveform', WaveForm_3Q, gSG3.AWGClockRate, WaveForm_3Length, 'Echo_Q_seg3.txt'); pause(0.5);

chaseFunctionPool('createWaveform', WaveForm_4I, gSG2.P1AWGClockRate, WaveForm_4Length, 'Echo_I_seg4.txt'); pause(0.5);
chaseFunctionPool('createWaveform', WaveForm_4Q, gSG2.P1AWGClockRate, WaveForm_4Length, 'Echo_Q_seg4.txt'); pause(0.5);

chaseFunctionPool('createSegStruct', 'Echo_SegStruct_I.txt', ...
    'Echo_I_seg1.txt', WaveForm_1PointNum, 1, 1, ...
    'Echo_I_seg2.txt', WaveForm_2PointNum, 1, 1);
pause(0.5);
chaseFunctionPool('createSegStruct', 'Echo_SegStruct_Q.txt', ...
    'Echo_Q_seg1.txt', WaveForm_1PointNum, 1, 1, ...
    'Echo_Q_seg2.txt', WaveForm_2PointNum, 1, 1);
pause(0.5);

chaseFunctionPool('createSegStruct', 'Echo_SegStruct_H_I.txt', ...
    'Echo_I_seg3.txt', WaveForm_3PointNum, 1, 1, ...
    'Echo_I_seg3.txt', WaveForm_3PointNum, 1, 1);
pause(0.5);
chaseFunctionPool('createSegStruct', 'Echo_SegStruct_H_Q.txt', ...
    'Echo_Q_seg3.txt', WaveForm_3PointNum, 1, 1, ...
    'Echo_Q_seg3.txt', WaveForm_3PointNum, 1, 1);
pause(0.5);

chaseFunctionPool('createSegStruct', 'Echo_SegStruct_S_I.txt', ...
    'Echo_I_seg4.txt', WaveForm_4PointNum, 1, 1, ...
    'Echo_I_seg4.txt', WaveForm_4PointNum, 1, 1);
pause(0.5);
chaseFunctionPool('createSegStruct', 'Echo_SegStruct_S_Q.txt', ...
    'Echo_Q_seg4.txt', WaveForm_4PointNum, 1, 1, ...
    'Echo_Q_seg4.txt', WaveForm_4PointNum, 1, 1);
pause(0.5);

chaseFunctionPool('CreateSegments', gmSEQ.MWAWG, 1, ...
    2, ...
    2047, 2047, 'Echo_SegStruct_I.txt', 'false');
pause(1); % this pause seems to be important, otherwise the loading is not right occassionally
chaseFunctionPool('CreateSegments', gmSEQ.MWAWG, 2, ...
    2, ...
    2047, 2047, 'Echo_SegStruct_Q.txt', 'false');
pause(1); % this pause seems to be important, otherwise the loading is not right occassionally

chaseFunctionPool('CreateSegments', gmSEQ.MWAWG2, 1, ...
    2, ...
    2047, 2047, 'Echo_SegStruct_H_I.txt', 'false');
pause(1); % this pause seems to be important, otherwise the loading is not right occassionally
chaseFunctionPool('CreateSegments', gmSEQ.MWAWG2, 2, ...
    2, ...
    2047, 2047, 'Echo_SegStruct_H_Q.txt', 'false');
pause(1); % this pause seems to be important, otherwise the loading is not right occassionally

chaseFunctionPool('CreateSegments', gmSEQ.P1AWG, 1, ...
    2, ...
    2047, 2047, 'Echo_SegStruct_S_I.txt', 'false');
pause(1); % this pause seems to be important, otherwise the loading is not right occassionally
chaseFunctionPool('CreateSegments', gmSEQ.P1AWG, 2, ...
    2, ...
    2047, 2047, 'Echo_SegStruct_S_Q.txt', 'false');
pause(1); % this pause seems to be important, otherwise the loading is not right occassionally

chaseFunctionPool('runChase', gmSEQ.MWAWG, 'false');
pause(0.5)
chaseFunctionPool('runChase', gmSEQ.MWAWG2, 'false');
pause(0.5)
chaseFunctionPool('runChase', gmSEQ.P1AWG, 'false');

ApplyDelays();

function Sz_local_probe % haven't been tested yet
global gmSEQ gSG gSG2 gSG3
gSG.bfixedPow=1;
gSG.bfixedFreq=1;
gSG.bMod='IQ';
gSG.bModSrc='External';

gmSEQ.Ntomo = 2;
[gmSEQ.ScaleT, gmSEQ.ScaleStr] = GetScale(gmSEQ.To);

gSG2.bMod='IQ';
gSG2.bModSrc='External';
SignalGeneratorFunctionPool2('SetMod');
SignalGeneratorFunctionPool2('WritePow');
SignalGeneratorFunctionPool2('WriteFreq');
gSG2.bOn=1; SignalGeneratorFunctionPool2('RFOnOff');

gSG3.bMod='IQ';
gSG3.bModSrc='External';
SignalGeneratorFunctionPool3('SetMod');
SignalGeneratorFunctionPool3('WritePow');
SignalGeneratorFunctionPool3('WriteFreq');
gSG3.bOn=1; SignalGeneratorFunctionPool3('RFOnOff');

AfterPi = 2000;
AfterLaser = 0.05e6; % Should be changed to larger than 100 us later

Wait_p = 2000;
Detect_Window = 5000;
PulseGap = 2;
gmSEQ.pi2 = gmSEQ.pi;
gmSEQ.rotTime = gmSEQ.SLockT1;
AfterRot = 1000;

Sig_D_start = Wait_p+gmSEQ.readout+AfterLaser+gmSEQ.rotTime+AfterRot+gmSEQ.halfpi+PulseGap+gmSEQ.pi2+gmSEQ.m/2+gmSEQ.pi2+PulseGap+gmSEQ.pi+PulseGap+gmSEQ.pi2 ...
    +gmSEQ.m/2+gmSEQ.pi2+PulseGap+gmSEQ.halfpi+AfterPi+Detect_Window+Wait_p;

gmSEQ.CHN(1).PBN=PBDictionary('ctr0');
gmSEQ.CHN(1).NRise=4;
gmSEQ.CHN(1).T=[Wait_p+gmSEQ.readout-1000-gmSEQ.CtrGateDur, ...
    Wait_p+gmSEQ.readout+AfterLaser+gmSEQ.rotTime+AfterRot+gmSEQ.halfpi+PulseGap+gmSEQ.pi2+gmSEQ.m/2+gmSEQ.pi2+PulseGap+gmSEQ.pi+PulseGap+gmSEQ.pi2+gmSEQ.m/2+gmSEQ.pi2+PulseGap+gmSEQ.halfpi+AfterPi, ...
    Sig_D_start+gmSEQ.readout-1000-gmSEQ.CtrGateDur, ... 
    Sig_D_start+gmSEQ.readout+gmSEQ.rotTime+AfterRot+AfterLaser+gmSEQ.halfpi+PulseGap+gmSEQ.pi2+gmSEQ.m/2+gmSEQ.pi2+PulseGap+gmSEQ.pi+PulseGap+gmSEQ.pi2+gmSEQ.m/2+gmSEQ.pi2+PulseGap+gmSEQ.halfpi+AfterPi];
if strcmp(gmSEQ.meas,'SPCM')
    gmSEQ.CHN(1).DT=[gmSEQ.CtrGateDur gmSEQ.CtrGateDur gmSEQ.CtrGateDur gmSEQ.CtrGateDur];
elseif strcmp(gmSEQ.meas,'APD')
    gmSEQ.CHN(1).DT=[1000 1000 1000 1000];
end

gmSEQ.CHN(numel(gmSEQ.CHN)+1).PBN=PBDictionary('AOM');
gmSEQ.CHN(numel(gmSEQ.CHN)).NRise=4;
gmSEQ.CHN(numel(gmSEQ.CHN)).T = [Wait_p, Wait_p+gmSEQ.readout+AfterLaser+gmSEQ.rotTime+AfterRot+gmSEQ.halfpi+PulseGap+gmSEQ.pi2+gmSEQ.m/2+gmSEQ.pi2+PulseGap+gmSEQ.pi+PulseGap+gmSEQ.pi2+gmSEQ.m/2+gmSEQ.pi2+PulseGap+gmSEQ.halfpi+AfterPi, ...
    Sig_D_start, Sig_D_start+gmSEQ.readout+AfterLaser+gmSEQ.rotTime+AfterRot+gmSEQ.halfpi+PulseGap+gmSEQ.pi2+gmSEQ.m/2+gmSEQ.pi2+PulseGap+gmSEQ.pi+PulseGap+gmSEQ.pi2+gmSEQ.m/2+gmSEQ.pi2+PulseGap+gmSEQ.halfpi+AfterPi];
gmSEQ.CHN(numel(gmSEQ.CHN)).DT = [gmSEQ.readout Detect_Window gmSEQ.readout Detect_Window];

gmSEQ.CHN(numel(gmSEQ.CHN)+1).PBN=PBDictionary('AWGTrig');
gmSEQ.CHN(numel(gmSEQ.CHN)).NRise=2;
gmSEQ.CHN(numel(gmSEQ.CHN)).T=[Wait_p+gmSEQ.readout+AfterLaser+gmSEQ.rotTime+AfterRot, ...
    Sig_D_start+gmSEQ.readout+AfterLaser+gmSEQ.rotTime+AfterRot];
gmSEQ.CHN(numel(gmSEQ.CHN)).DT = repelem(gmSEQ.halfpi+PulseGap+gmSEQ.pi2+gmSEQ.m/2+gmSEQ.pi2+PulseGap+gmSEQ.pi+PulseGap+gmSEQ.pi2+gmSEQ.m/2+gmSEQ.pi2+PulseGap+gmSEQ.halfpi+300, 2);

gmSEQ.CHN(numel(gmSEQ.CHN)+1).PBN=PBDictionary('AWGTrig2');
gmSEQ.CHN(numel(gmSEQ.CHN)).NRise=2;
gmSEQ.CHN(numel(gmSEQ.CHN)).T=[Wait_p+gmSEQ.readout+AfterLaser, ...
    Sig_D_start+gmSEQ.readout+AfterLaser];
gmSEQ.CHN(numel(gmSEQ.CHN)).DT = repelem(gmSEQ.rotTime+500, 2);

gmSEQ.CHN(numel(gmSEQ.CHN)+1).PBN=PBDictionary('AWGTrig3');
gmSEQ.CHN(numel(gmSEQ.CHN)).NRise=2;
gmSEQ.CHN(numel(gmSEQ.CHN)).T=[Wait_p+gmSEQ.readout+AfterLaser+gmSEQ.rotTime+AfterRot, ...
    Sig_D_start+gmSEQ.readout+AfterLaser+gmSEQ.rotTime+AfterRot];
gmSEQ.CHN(numel(gmSEQ.CHN)).DT = repelem(gmSEQ.halfpi+PulseGap+gmSEQ.pi2+gmSEQ.m/2+gmSEQ.pi2+PulseGap+gmSEQ.pi+PulseGap+gmSEQ.pi2+gmSEQ.m/2+gmSEQ.pi2+PulseGap+gmSEQ.halfpi+300, 2);

BeforeDelay = 80;
AfterDelay = 20;
FullDelay = BeforeDelay+AfterDelay;
gmSEQ.CHN(numel(gmSEQ.CHN)+1).PBN=PBDictionary('MWSwitch');
if gmSEQ.m/2 < 200
    gmSEQ.CHN(numel(gmSEQ.CHN)).NRise=2;
    gmSEQ.CHN(numel(gmSEQ.CHN)).T=[Wait_p+gmSEQ.readout+AfterLaser+gmSEQ.rotTime+AfterRot-BeforeDelay, Sig_D_start+gmSEQ.readout+AfterLaser+gmSEQ.rotTime+AfterRot-BeforeDelay];
    gmSEQ.CHN(numel(gmSEQ.CHN)).DT=repelem(gmSEQ.halfpi+PulseGap+gmSEQ.pi2+gmSEQ.m/2+gmSEQ.pi2+PulseGap+gmSEQ.pi+PulseGap+gmSEQ.pi2+gmSEQ.m/2+gmSEQ.pi2+PulseGap+gmSEQ.halfpi+FullDelay,2);
else
    gmSEQ.CHN(numel(gmSEQ.CHN)).NRise=6;
    gmSEQ.CHN(numel(gmSEQ.CHN)).T=[Wait_p+gmSEQ.readout+AfterLaser+gmSEQ.rotTime+AfterRot-BeforeDelay, ...
        Wait_p+gmSEQ.readout+AfterLaser+gmSEQ.rotTime+AfterRot+gmSEQ.halfpi+PulseGap+gmSEQ.pi2+gmSEQ.m/2-BeforeDelay, ...
        Wait_p+gmSEQ.readout+AfterLaser+gmSEQ.rotTime+AfterRot+gmSEQ.halfpi+PulseGap+gmSEQ.pi2+gmSEQ.m/2+gmSEQ.pi2+PulseGap+gmSEQ.pi+PulseGap+gmSEQ.pi2+gmSEQ.m/2-BeforeDelay, ...
        Sig_D_start+gmSEQ.readout+AfterLaser+gmSEQ.rotTime+AfterRot-BeforeDelay, ... 
        Sig_D_start+gmSEQ.readout+AfterLaser+gmSEQ.rotTime+AfterRot+gmSEQ.halfpi+PulseGap+gmSEQ.pi2+gmSEQ.m/2-BeforeDelay, ...
        Sig_D_start+gmSEQ.readout+AfterLaser+gmSEQ.rotTime+AfterRot+gmSEQ.halfpi+PulseGap+gmSEQ.pi2+gmSEQ.m/2+gmSEQ.pi2+PulseGap+gmSEQ.pi+PulseGap+gmSEQ.pi2+gmSEQ.m/2-BeforeDelay];
    gmSEQ.CHN(numel(gmSEQ.CHN)).DT=[gmSEQ.halfpi+PulseGap+gmSEQ.pi2+FullDelay, gmSEQ.pi2+PulseGap+gmSEQ.pi+PulseGap+gmSEQ.pi2+FullDelay, gmSEQ.pi2+PulseGap+gmSEQ.halfpi+FullDelay, ... 
    gmSEQ.halfpi+PulseGap+gmSEQ.pi2+FullDelay, gmSEQ.pi2+PulseGap+gmSEQ.pi+PulseGap+gmSEQ.pi2+FullDelay, gmSEQ.pi2+PulseGap+gmSEQ.halfpi+FullDelay];
end

gmSEQ.CHN(numel(gmSEQ.CHN)+1).PBN=PBDictionary('MWSwitch2');
gmSEQ.CHN(numel(gmSEQ.CHN)).NRise=4;
if gmSEQ.m/2 < 200
    gmSEQ.CHN(numel(gmSEQ.CHN)).T=[Wait_p+gmSEQ.readout+AfterLaser-BeforeDelay, ...
        Wait_p+gmSEQ.readout+AfterLaser+gmSEQ.rotTime+AfterRot-BeforeDelay, ...
        Sig_D_start+gmSEQ.readout+AfterLaser-BeforeDelay, ... 
        Sig_D_start+gmSEQ.readout+AfterLaser+gmSEQ.rotTime+AfterRot-BeforeDelay];
    gmSEQ.CHN(numel(gmSEQ.CHN)).DT=[gmSEQ.rotTime+FullDelay, gmSEQ.halfpi+PulseGap+gmSEQ.pi2+gmSEQ.m/2+gmSEQ.pi2+PulseGap+gmSEQ.pi+PulseGap+gmSEQ.pi2+gmSEQ.m/2+gmSEQ.pi2+PulseGap+gmSEQ.halfpi+FullDelay, ... 
    gmSEQ.rotTime+FullDelay, gmSEQ.halfpi+PulseGap+gmSEQ.pi2+gmSEQ.m/2+gmSEQ.pi2+PulseGap+gmSEQ.pi+PulseGap+gmSEQ.pi2+gmSEQ.m/2+gmSEQ.pi2+PulseGap+gmSEQ.halfpi+FullDelay];
else
    gmSEQ.CHN(numel(gmSEQ.CHN)).T=[Wait_p+gmSEQ.readout+AfterLaser-BeforeDelay, ...
        Wait_p+gmSEQ.readout+AfterLaser+gmSEQ.rotTime+AfterRot+gmSEQ.halfpi+PulseGap+gmSEQ.pi2+gmSEQ.m/2-BeforeDelay, ...
        Sig_D_start+gmSEQ.readout+AfterLaser-BeforeDelay, ... 
        Sig_D_start+gmSEQ.readout+AfterLaser+gmSEQ.rotTime+AfterRot+gmSEQ.halfpi+PulseGap+gmSEQ.pi2+gmSEQ.m/2-BeforeDelay];
    gmSEQ.CHN(numel(gmSEQ.CHN)).DT=[gmSEQ.rotTime+FullDelay, gmSEQ.pi2+PulseGap+gmSEQ.pi+PulseGap+gmSEQ.pi2+FullDelay, ... 
    gmSEQ.rotTime+FullDelay, gmSEQ.pi2+PulseGap+gmSEQ.pi+PulseGap+gmSEQ.pi2+FullDelay];
end


gmSEQ.CHN(numel(gmSEQ.CHN)+1).PBN=PBDictionary('MWSwitch3');
if gmSEQ.m/2 < 200
    gmSEQ.CHN(numel(gmSEQ.CHN)).NRise=2;
    gmSEQ.CHN(numel(gmSEQ.CHN)).T=[Wait_p+gmSEQ.readout+AfterLaser+gmSEQ.rotTime+AfterRot-BeforeDelay, Sig_D_start+gmSEQ.readout+AfterLaser+gmSEQ.rotTime+AfterRot-BeforeDelay];
    gmSEQ.CHN(numel(gmSEQ.CHN)).DT=repelem(gmSEQ.halfpi+PulseGap+gmSEQ.pi2+gmSEQ.m/2+gmSEQ.pi2+PulseGap+gmSEQ.pi+PulseGap+gmSEQ.pi2+gmSEQ.m/2+gmSEQ.pi2+PulseGap+gmSEQ.halfpi+FullDelay,2);
else
    gmSEQ.CHN(numel(gmSEQ.CHN)).NRise=6;
    gmSEQ.CHN(numel(gmSEQ.CHN)).T=[Wait_p+gmSEQ.readout+AfterLaser+gmSEQ.rotTime+AfterRot-BeforeDelay, ...
        Wait_p+gmSEQ.readout+AfterLaser+gmSEQ.rotTime+AfterRot+gmSEQ.halfpi+PulseGap+gmSEQ.pi2+gmSEQ.m/2-BeforeDelay, ...
        Wait_p+gmSEQ.readout+AfterLaser+gmSEQ.rotTime+AfterRot+gmSEQ.halfpi+PulseGap+gmSEQ.pi2+gmSEQ.m/2+gmSEQ.pi2+PulseGap+gmSEQ.pi+PulseGap+gmSEQ.pi2+gmSEQ.m/2-BeforeDelay, ...
        Sig_D_start+gmSEQ.readout+AfterLaser+gmSEQ.rotTime+AfterRot-BeforeDelay, ... 
        Sig_D_start+gmSEQ.readout+AfterLaser+gmSEQ.rotTime+AfterRot+gmSEQ.halfpi+PulseGap+gmSEQ.pi2+gmSEQ.m/2-BeforeDelay, ...
        Sig_D_start+gmSEQ.readout+AfterLaser+gmSEQ.rotTime+AfterRot+gmSEQ.halfpi+PulseGap+gmSEQ.pi2+gmSEQ.m/2+gmSEQ.pi2+PulseGap+gmSEQ.pi+PulseGap+gmSEQ.pi2+gmSEQ.m/2-BeforeDelay];
    gmSEQ.CHN(numel(gmSEQ.CHN)).DT=[gmSEQ.halfpi+PulseGap+gmSEQ.pi2+FullDelay, gmSEQ.pi2+PulseGap+gmSEQ.pi+PulseGap+gmSEQ.pi2+FullDelay, gmSEQ.pi2+PulseGap+gmSEQ.halfpi+FullDelay, ... 
    gmSEQ.halfpi+PulseGap+gmSEQ.pi2+FullDelay, gmSEQ.pi2+PulseGap+gmSEQ.pi+PulseGap+gmSEQ.pi2+FullDelay, gmSEQ.pi2+PulseGap+gmSEQ.halfpi+FullDelay];
end

gmSEQ.CHN(numel(gmSEQ.CHN)+1).PBN=PBDictionary('dummy1');
gmSEQ.CHN(numel(gmSEQ.CHN)).NRise=2;
gmSEQ.CHN(numel(gmSEQ.CHN)).T=[0 2*(Sig_D_start-Wait_p)-50];
gmSEQ.CHN(numel(gmSEQ.CHN)).DT=[50 50];

%% AWG
% Initialization
chaseFunctionPool('stopChase',  gmSEQ.MWAWG)
chaseFunctionPool('stopChase',  gmSEQ.P1AWG)
chaseFunctionPool('stopChase',  gmSEQ.MWAWG2)

if ~gSG.ACmodAWG % in AC modulation mode
    gSG.AWGFreq = 0;
    gSG2.AWGFreq = 0;
    gSG3.AWGFreq = 0;
end

% Switch bright and dark signal 
% disp("Switching bright and bark.")

if gmSEQ.CoolSwitch == 0
    WaveForm_1I = [0 gmSEQ.halfpi gSG.AWGFreq 0 gSG.AWGAmp;...
        gmSEQ.halfpi+PulseGap+gmSEQ.pi2+gmSEQ.m/2+gmSEQ.pi2+PulseGap gmSEQ.halfpi+PulseGap+gmSEQ.pi2+gmSEQ.m/2+gmSEQ.pi2+PulseGap+gmSEQ.pi gSG.AWGFreq pi/2 gSG.AWGAmp; ...
        gmSEQ.halfpi+PulseGap+gmSEQ.pi2+gmSEQ.m/2+gmSEQ.pi2+PulseGap+gmSEQ.pi+PulseGap+gmSEQ.pi2+gmSEQ.m/2+gmSEQ.pi2+PulseGap gmSEQ.halfpi+PulseGap+gmSEQ.pi2+gmSEQ.m/2+gmSEQ.pi2+PulseGap+gmSEQ.pi+PulseGap+gmSEQ.pi2+gmSEQ.m/2+gmSEQ.pi2+PulseGap+gmSEQ.halfpi gSG.AWGFreq pi gSG.AWGAmp];
    WaveForm_2I = [0 gmSEQ.halfpi gSG.AWGFreq 0 gSG.AWGAmp;...
        gmSEQ.halfpi+PulseGap+gmSEQ.pi2+gmSEQ.m/2+gmSEQ.pi2+PulseGap gmSEQ.halfpi+PulseGap+gmSEQ.pi2+gmSEQ.m/2+gmSEQ.pi2+PulseGap+gmSEQ.pi gSG.AWGFreq pi/2 gSG.AWGAmp; ...
        gmSEQ.halfpi+PulseGap+gmSEQ.pi2+gmSEQ.m/2+gmSEQ.pi2+PulseGap+gmSEQ.pi+PulseGap+gmSEQ.pi2+gmSEQ.m/2+gmSEQ.pi2+PulseGap gmSEQ.halfpi+PulseGap+gmSEQ.pi2+gmSEQ.m/2+gmSEQ.pi2+PulseGap+gmSEQ.pi+PulseGap+gmSEQ.pi2+gmSEQ.m/2+gmSEQ.pi2+PulseGap+gmSEQ.halfpi gSG.AWGFreq 0 gSG.AWGAmp];
else
    WaveForm_1I = [0 gmSEQ.halfpi gSG.AWGFreq 0 gSG.AWGAmp;...
        gmSEQ.halfpi+PulseGap+gmSEQ.pi2+gmSEQ.m/2+gmSEQ.pi2+PulseGap gmSEQ.halfpi+PulseGap+gmSEQ.pi2+gmSEQ.m/2+gmSEQ.pi2+PulseGap+gmSEQ.pi gSG.AWGFreq pi/2 gSG.AWGAmp; ...
        gmSEQ.halfpi+PulseGap+gmSEQ.pi2+gmSEQ.m/2+gmSEQ.pi2+PulseGap+gmSEQ.pi+PulseGap+gmSEQ.pi2+gmSEQ.m/2+gmSEQ.pi2+PulseGap gmSEQ.halfpi+PulseGap+gmSEQ.pi2+gmSEQ.m/2+gmSEQ.pi2+PulseGap+gmSEQ.pi+PulseGap+gmSEQ.pi2+gmSEQ.m/2+gmSEQ.pi2+PulseGap+gmSEQ.halfpi gSG.AWGFreq pi/2 gSG.AWGAmp];
    WaveForm_2I = [0 gmSEQ.halfpi gSG.AWGFreq 0 gSG.AWGAmp;...
        gmSEQ.halfpi+PulseGap+gmSEQ.pi2+gmSEQ.m/2+gmSEQ.pi2+PulseGap gmSEQ.halfpi+PulseGap+gmSEQ.pi2+gmSEQ.m/2+gmSEQ.pi2+PulseGap+gmSEQ.pi gSG.AWGFreq pi/2 gSG.AWGAmp; ...
        gmSEQ.halfpi+PulseGap+gmSEQ.pi2+gmSEQ.m/2+gmSEQ.pi2+PulseGap+gmSEQ.pi+PulseGap+gmSEQ.pi2+gmSEQ.m/2+gmSEQ.pi2+PulseGap gmSEQ.halfpi+PulseGap+gmSEQ.pi2+gmSEQ.m/2+gmSEQ.pi2+PulseGap+gmSEQ.pi+PulseGap+gmSEQ.pi2+gmSEQ.m/2+gmSEQ.pi2+PulseGap+gmSEQ.halfpi gSG.AWGFreq 3*pi/2 gSG.AWGAmp];
end


WaveForm_1Q = WaveForm_1I - repmat([0 0 0 pi/2 0], size(WaveForm_1I, 1), 1);
WaveForm_1Length = ceil((gmSEQ.halfpi+PulseGap+gmSEQ.pi2+gmSEQ.m/2+gmSEQ.pi2+PulseGap+gmSEQ.pi+PulseGap+gmSEQ.pi2+gmSEQ.m/2+gmSEQ.pi2+PulseGap+gmSEQ.halfpi+1000) / (16 / gSG.AWGClockRate)) ...
    *(16 / gSG.AWGClockRate);
WaveForm_1PointNum = WaveForm_1Length * gSG.AWGClockRate;

WaveForm_2Q = WaveForm_2I - repmat([0 0 0 pi/2 0], size(WaveForm_2I, 1), 1);
WaveForm_2Length = WaveForm_1Length;
WaveForm_2PointNum = WaveForm_2Length * gSG.AWGClockRate;

WaveForm_3I = [0 gmSEQ.halfpi+PulseGap 0 0 0;...
    gmSEQ.halfpi+PulseGap gmSEQ.halfpi+PulseGap+gmSEQ.pi2 gSG3.AWGFreq 0 gSG3.AWGAmp;...
    gmSEQ.halfpi+PulseGap+gmSEQ.pi2+gmSEQ.m/2 gmSEQ.halfpi+PulseGap+gmSEQ.pi2+gmSEQ.m/2+gmSEQ.pi2 gSG3.AWGFreq pi gSG3.AWGAmp; ...
    gmSEQ.halfpi+PulseGap+gmSEQ.pi2+gmSEQ.m/2+gmSEQ.pi2+PulseGap+gmSEQ.pi+PulseGap gmSEQ.halfpi+PulseGap+gmSEQ.pi2+gmSEQ.m/2+gmSEQ.pi2+PulseGap+gmSEQ.pi+PulseGap+gmSEQ.pi2 gSG3.AWGFreq pi gSG3.AWGAmp; ...
    gmSEQ.halfpi+PulseGap+gmSEQ.pi2+gmSEQ.m/2+gmSEQ.pi2+PulseGap+gmSEQ.pi+PulseGap+gmSEQ.pi2+gmSEQ.m/2 gmSEQ.halfpi+PulseGap+gmSEQ.pi2+gmSEQ.m/2+gmSEQ.pi2+PulseGap+gmSEQ.pi+PulseGap+gmSEQ.pi2+gmSEQ.m/2+gmSEQ.pi2 gSG3.AWGFreq 0 gSG3.AWGAmp];
WaveForm_3Q = WaveForm_3I - repmat([0 0 0 pi/2 0], size(WaveForm_3I, 1), 1);
WaveForm_3Length = ceil((gmSEQ.halfpi+PulseGap+gmSEQ.pi2+gmSEQ.m/2+gmSEQ.pi2+PulseGap+gmSEQ.pi+PulseGap+gmSEQ.pi2+gmSEQ.m/2+gmSEQ.pi2+1000) / (16 / gSG3.AWGClockRate)) ...
    *(16 / gSG3.AWGClockRate);
WaveForm_3PointNum = WaveForm_3Length * gSG3.AWGClockRate;

WaveForm_4I = [0 gmSEQ.rotTime gSG2.AWGFreq 0 gSG2.AWGAmp;...
    gmSEQ.rotTime+AfterRot+gmSEQ.halfpi+PulseGap+gmSEQ.pi2+gmSEQ.m/2+gmSEQ.pi2+PulseGap gmSEQ.rotTime+AfterRot+gmSEQ.halfpi+PulseGap+gmSEQ.pi2+gmSEQ.m/2+gmSEQ.pi2+PulseGap+gmSEQ.pi gSG2.AWGFreq 0 gSG2.AWGAmp];
WaveForm_4Q = WaveForm_4I - repmat([0 0 0 pi/2 0], size(WaveForm_4I, 1), 1);
WaveForm_4Length = ceil((gmSEQ.rotTime+AfterRot+gmSEQ.halfpi+PulseGap+gmSEQ.pi2+gmSEQ.m/2+gmSEQ.pi2+PulseGap+gmSEQ.pi+1000) / (16 / gSG2.P1AWGClockRate)) ...
    *(16 / gSG2.P1AWGClockRate);
WaveForm_4PointNum = WaveForm_4Length * gSG2.P1AWGClockRate;

chaseFunctionPool('createWaveform', WaveForm_1I, gSG.AWGClockRate, WaveForm_1Length, 'Echo_I_seg1.txt'); pause(0.5);
chaseFunctionPool('createWaveform', WaveForm_1Q, gSG.AWGClockRate, WaveForm_1Length, 'Echo_Q_seg1.txt'); pause(0.5);
chaseFunctionPool('createWaveform', WaveForm_2I, gSG.AWGClockRate, WaveForm_2Length, 'Echo_I_seg2.txt'); pause(0.5);
chaseFunctionPool('createWaveform', WaveForm_2Q, gSG.AWGClockRate, WaveForm_2Length, 'Echo_Q_seg2.txt'); pause(0.5);

chaseFunctionPool('createWaveform', WaveForm_3I, gSG3.AWGClockRate, WaveForm_3Length, 'Echo_I_seg3.txt'); pause(0.5);
chaseFunctionPool('createWaveform', WaveForm_3Q, gSG3.AWGClockRate, WaveForm_3Length, 'Echo_Q_seg3.txt'); pause(0.5);

chaseFunctionPool('createWaveform', WaveForm_4I, gSG2.P1AWGClockRate, WaveForm_4Length, 'Echo_I_seg4.txt'); pause(0.5);
chaseFunctionPool('createWaveform', WaveForm_4Q, gSG2.P1AWGClockRate, WaveForm_4Length, 'Echo_Q_seg4.txt'); pause(0.5);

chaseFunctionPool('createSegStruct', 'Echo_SegStruct_I.txt', ...
    'Echo_I_seg1.txt', WaveForm_1PointNum, 1, 1, ...
    'Echo_I_seg2.txt', WaveForm_2PointNum, 1, 1);
pause(0.5);
chaseFunctionPool('createSegStruct', 'Echo_SegStruct_Q.txt', ...
    'Echo_Q_seg1.txt', WaveForm_1PointNum, 1, 1, ...
    'Echo_Q_seg2.txt', WaveForm_2PointNum, 1, 1);
pause(0.5);

chaseFunctionPool('createSegStruct', 'Echo_SegStruct_H_I.txt', ...
    'Echo_I_seg3.txt', WaveForm_3PointNum, 1, 1, ...
    'Echo_I_seg3.txt', WaveForm_3PointNum, 1, 1);
pause(0.5);
chaseFunctionPool('createSegStruct', 'Echo_SegStruct_H_Q.txt', ...
    'Echo_Q_seg3.txt', WaveForm_3PointNum, 1, 1, ...
    'Echo_Q_seg3.txt', WaveForm_3PointNum, 1, 1);
pause(0.5);

chaseFunctionPool('createSegStruct', 'Echo_SegStruct_S_I.txt', ...
    'Echo_I_seg4.txt', WaveForm_4PointNum, 1, 1, ...
    'Echo_I_seg4.txt', WaveForm_4PointNum, 1, 1);
pause(0.5);
chaseFunctionPool('createSegStruct', 'Echo_SegStruct_S_Q.txt', ...
    'Echo_Q_seg4.txt', WaveForm_4PointNum, 1, 1, ...
    'Echo_Q_seg4.txt', WaveForm_4PointNum, 1, 1);
pause(0.5);

chaseFunctionPool('CreateSegments', gmSEQ.MWAWG, 1, ...
    2, ...
    2047, 2047, 'Echo_SegStruct_I.txt', 'false');
pause(1); % this pause seems to be important, otherwise the loading is not right occassionally
chaseFunctionPool('CreateSegments', gmSEQ.MWAWG, 2, ...
    2, ...
    2047, 2047, 'Echo_SegStruct_Q.txt', 'false');
pause(1); % this pause seems to be important, otherwise the loading is not right occassionally

chaseFunctionPool('CreateSegments', gmSEQ.MWAWG2, 1, ...
    2, ...
    2047, 2047, 'Echo_SegStruct_H_I.txt', 'false');
pause(1); % this pause seems to be important, otherwise the loading is not right occassionally
chaseFunctionPool('CreateSegments', gmSEQ.MWAWG2, 2, ...
    2, ...
    2047, 2047, 'Echo_SegStruct_H_Q.txt', 'false');
pause(1); % this pause seems to be important, otherwise the loading is not right occassionally

chaseFunctionPool('CreateSegments', gmSEQ.P1AWG, 1, ...
    2, ...
    2047, 2047, 'Echo_SegStruct_S_I.txt', 'false');
pause(1); % this pause seems to be important, otherwise the loading is not right occassionally
chaseFunctionPool('CreateSegments', gmSEQ.P1AWG, 2, ...
    2, ...
    2047, 2047, 'Echo_SegStruct_S_Q.txt', 'false');
pause(1); % this pause seems to be important, otherwise the loading is not right occassionally

chaseFunctionPool('runChase', gmSEQ.MWAWG, 'false');
pause(0.5)
chaseFunctionPool('runChase', gmSEQ.MWAWG2, 'false');
pause(0.5)
chaseFunctionPool('runChase', gmSEQ.P1AWG, 'false');

ApplyDelays();

function Sz_local_probe_compare % haven't been tested yet
global gmSEQ gSG gSG2 gSG3
gSG.bfixedPow=1;
gSG.bfixedFreq=1;
gSG.bMod='IQ';
gSG.bModSrc='External';

gmSEQ.Ntomo = 2;
[gmSEQ.ScaleT, gmSEQ.ScaleStr] = GetScale(gmSEQ.To);

gSG2.bMod='IQ';
gSG2.bModSrc='External';
SignalGeneratorFunctionPool2('SetMod');
SignalGeneratorFunctionPool2('WritePow');
SignalGeneratorFunctionPool2('WriteFreq');
gSG2.bOn=1; SignalGeneratorFunctionPool2('RFOnOff');

gSG3.bMod='IQ';
gSG3.bModSrc='External';
SignalGeneratorFunctionPool3('SetMod');
SignalGeneratorFunctionPool3('WritePow');
SignalGeneratorFunctionPool3('WriteFreq');
gSG3.bOn=1; SignalGeneratorFunctionPool3('RFOnOff');

AfterPi = 2000;
AfterLaser = 0.1e6; 
% AfterLaser = 5000; % Should be changed to larger than 100 us later


Wait_p = 2000;
Detect_Window = 5000;
PulseGap = 2;
gmSEQ.pi2 = gmSEQ.pi;
gmSEQ.rotTime = gmSEQ.SLockT1;
AfterRot = 1000;

Sig_D_start = Wait_p+gmSEQ.readout+AfterLaser+gmSEQ.rotTime+AfterRot+gmSEQ.halfpi+PulseGap+gmSEQ.pi2+gmSEQ.m/2+gmSEQ.pi2+PulseGap+gmSEQ.pi+PulseGap+gmSEQ.pi2 ...
    +gmSEQ.m/2+gmSEQ.pi2+PulseGap+gmSEQ.halfpi+AfterPi+Detect_Window+Wait_p;

gmSEQ.CHN(1).PBN=PBDictionary('ctr0');
gmSEQ.CHN(1).NRise=4;
gmSEQ.CHN(1).T=[Wait_p+gmSEQ.readout-1000-gmSEQ.CtrGateDur, ...
    Wait_p+gmSEQ.readout+AfterLaser+gmSEQ.rotTime+AfterRot+gmSEQ.halfpi+PulseGap+gmSEQ.pi2+gmSEQ.m/2+gmSEQ.pi2+PulseGap+gmSEQ.pi+PulseGap+gmSEQ.pi2+gmSEQ.m/2+gmSEQ.pi2+PulseGap+gmSEQ.halfpi+AfterPi, ...
    Sig_D_start+gmSEQ.readout-1000-gmSEQ.CtrGateDur, ... 
    Sig_D_start+gmSEQ.readout+gmSEQ.rotTime+AfterRot+AfterLaser+gmSEQ.halfpi+PulseGap+gmSEQ.pi2+gmSEQ.m/2+gmSEQ.pi2+PulseGap+gmSEQ.pi+PulseGap+gmSEQ.pi2+gmSEQ.m/2+gmSEQ.pi2+PulseGap+gmSEQ.halfpi+AfterPi];
if strcmp(gmSEQ.meas,'SPCM')
    gmSEQ.CHN(1).DT=[gmSEQ.CtrGateDur gmSEQ.CtrGateDur gmSEQ.CtrGateDur gmSEQ.CtrGateDur];
elseif strcmp(gmSEQ.meas,'APD')
    gmSEQ.CHN(1).DT=[1000 1000 1000 1000];
end

gmSEQ.CHN(numel(gmSEQ.CHN)+1).PBN=PBDictionary('AOM');
gmSEQ.CHN(numel(gmSEQ.CHN)).NRise=4;
gmSEQ.CHN(numel(gmSEQ.CHN)).T = [Wait_p, Wait_p+gmSEQ.readout+AfterLaser+gmSEQ.rotTime+AfterRot+gmSEQ.halfpi+PulseGap+gmSEQ.pi2+gmSEQ.m/2+gmSEQ.pi2+PulseGap+gmSEQ.pi+PulseGap+gmSEQ.pi2+gmSEQ.m/2+gmSEQ.pi2+PulseGap+gmSEQ.halfpi+AfterPi, ...
    Sig_D_start, Sig_D_start+gmSEQ.readout+AfterLaser+gmSEQ.rotTime+AfterRot+gmSEQ.halfpi+PulseGap+gmSEQ.pi2+gmSEQ.m/2+gmSEQ.pi2+PulseGap+gmSEQ.pi+PulseGap+gmSEQ.pi2+gmSEQ.m/2+gmSEQ.pi2+PulseGap+gmSEQ.halfpi+AfterPi];
gmSEQ.CHN(numel(gmSEQ.CHN)).DT = [gmSEQ.readout Detect_Window gmSEQ.readout Detect_Window];

gmSEQ.CHN(numel(gmSEQ.CHN)+1).PBN=PBDictionary('AWGTrig');
gmSEQ.CHN(numel(gmSEQ.CHN)).NRise=2;
gmSEQ.CHN(numel(gmSEQ.CHN)).T=[Wait_p+gmSEQ.readout+AfterLaser+gmSEQ.rotTime+AfterRot, ...
    Sig_D_start+gmSEQ.readout+AfterLaser+gmSEQ.rotTime+AfterRot];
gmSEQ.CHN(numel(gmSEQ.CHN)).DT = repelem(gmSEQ.halfpi+PulseGap+gmSEQ.pi2+gmSEQ.m/2+gmSEQ.pi2+PulseGap+gmSEQ.pi+PulseGap+gmSEQ.pi2+gmSEQ.m/2+gmSEQ.pi2+PulseGap+gmSEQ.halfpi+300, 2);

gmSEQ.CHN(numel(gmSEQ.CHN)+1).PBN=PBDictionary('AWGTrig2');
gmSEQ.CHN(numel(gmSEQ.CHN)).NRise=2;
gmSEQ.CHN(numel(gmSEQ.CHN)).T=[Wait_p+gmSEQ.readout+AfterLaser, ...
    Sig_D_start+gmSEQ.readout+AfterLaser];
gmSEQ.CHN(numel(gmSEQ.CHN)).DT = repelem(gmSEQ.rotTime+500, 2);

gmSEQ.CHN(numel(gmSEQ.CHN)+1).PBN=PBDictionary('AWGTrig3');
gmSEQ.CHN(numel(gmSEQ.CHN)).NRise=2;
gmSEQ.CHN(numel(gmSEQ.CHN)).T=[Wait_p+gmSEQ.readout+AfterLaser+gmSEQ.rotTime+AfterRot, ...
    Sig_D_start+gmSEQ.readout+AfterLaser+gmSEQ.rotTime+AfterRot];
gmSEQ.CHN(numel(gmSEQ.CHN)).DT = repelem(gmSEQ.halfpi+PulseGap+gmSEQ.pi2+gmSEQ.m/2+gmSEQ.pi2+PulseGap+gmSEQ.pi+PulseGap+gmSEQ.pi2+gmSEQ.m/2+gmSEQ.pi2+PulseGap+gmSEQ.halfpi+300, 2);

BeforeDelay = 80;
AfterDelay = 20;
FullDelay = BeforeDelay+AfterDelay;
gmSEQ.CHN(numel(gmSEQ.CHN)+1).PBN=PBDictionary('MWSwitch');
if gmSEQ.m/2 < 200
    gmSEQ.CHN(numel(gmSEQ.CHN)).NRise=2;
    gmSEQ.CHN(numel(gmSEQ.CHN)).T=[Wait_p+gmSEQ.readout+AfterLaser+gmSEQ.rotTime+AfterRot-BeforeDelay, Sig_D_start+gmSEQ.readout+AfterLaser+gmSEQ.rotTime+AfterRot-BeforeDelay];
    gmSEQ.CHN(numel(gmSEQ.CHN)).DT=repelem(gmSEQ.halfpi+PulseGap+gmSEQ.pi2+gmSEQ.m/2+gmSEQ.pi2+PulseGap+gmSEQ.pi+PulseGap+gmSEQ.pi2+gmSEQ.m/2+gmSEQ.pi2+PulseGap+gmSEQ.halfpi+FullDelay,2);
else
    gmSEQ.CHN(numel(gmSEQ.CHN)).NRise=6;
    gmSEQ.CHN(numel(gmSEQ.CHN)).T=[Wait_p+gmSEQ.readout+AfterLaser+gmSEQ.rotTime+AfterRot-BeforeDelay, ...
        Wait_p+gmSEQ.readout+AfterLaser+gmSEQ.rotTime+AfterRot+gmSEQ.halfpi+PulseGap+gmSEQ.pi2+gmSEQ.m/2-BeforeDelay, ...
        Wait_p+gmSEQ.readout+AfterLaser+gmSEQ.rotTime+AfterRot+gmSEQ.halfpi+PulseGap+gmSEQ.pi2+gmSEQ.m/2+gmSEQ.pi2+PulseGap+gmSEQ.pi+PulseGap+gmSEQ.pi2+gmSEQ.m/2-BeforeDelay, ...
        Sig_D_start+gmSEQ.readout+AfterLaser+gmSEQ.rotTime+AfterRot-BeforeDelay, ... 
        Sig_D_start+gmSEQ.readout+AfterLaser+gmSEQ.rotTime+AfterRot+gmSEQ.halfpi+PulseGap+gmSEQ.pi2+gmSEQ.m/2-BeforeDelay, ...
        Sig_D_start+gmSEQ.readout+AfterLaser+gmSEQ.rotTime+AfterRot+gmSEQ.halfpi+PulseGap+gmSEQ.pi2+gmSEQ.m/2+gmSEQ.pi2+PulseGap+gmSEQ.pi+PulseGap+gmSEQ.pi2+gmSEQ.m/2-BeforeDelay];
    gmSEQ.CHN(numel(gmSEQ.CHN)).DT=[gmSEQ.halfpi+PulseGap+gmSEQ.pi2+FullDelay, gmSEQ.pi2+PulseGap+gmSEQ.pi+PulseGap+gmSEQ.pi2+FullDelay, gmSEQ.pi2+PulseGap+gmSEQ.halfpi+FullDelay, ... 
    gmSEQ.halfpi+PulseGap+gmSEQ.pi2+FullDelay, gmSEQ.pi2+PulseGap+gmSEQ.pi+PulseGap+gmSEQ.pi2+FullDelay, gmSEQ.pi2+PulseGap+gmSEQ.halfpi+FullDelay];
end

gmSEQ.CHN(numel(gmSEQ.CHN)+1).PBN=PBDictionary('MWSwitch2');
gmSEQ.CHN(numel(gmSEQ.CHN)).NRise=4;
if gmSEQ.m/2 < 200
    gmSEQ.CHN(numel(gmSEQ.CHN)).T=[Wait_p+gmSEQ.readout+AfterLaser-BeforeDelay, ...
        Wait_p+gmSEQ.readout+AfterLaser+gmSEQ.rotTime+AfterRot-BeforeDelay, ...
        Sig_D_start+gmSEQ.readout+AfterLaser-BeforeDelay, ... 
        Sig_D_start+gmSEQ.readout+AfterLaser+gmSEQ.rotTime+AfterRot-BeforeDelay];
    gmSEQ.CHN(numel(gmSEQ.CHN)).DT=[gmSEQ.rotTime+FullDelay, gmSEQ.halfpi+PulseGap+gmSEQ.pi2+gmSEQ.m/2+gmSEQ.pi2+PulseGap+gmSEQ.pi+PulseGap+gmSEQ.pi2+gmSEQ.m/2+gmSEQ.pi2+PulseGap+gmSEQ.halfpi+FullDelay, ... 
    gmSEQ.rotTime+FullDelay, gmSEQ.halfpi+PulseGap+gmSEQ.pi2+gmSEQ.m/2+gmSEQ.pi2+PulseGap+gmSEQ.pi+PulseGap+gmSEQ.pi2+gmSEQ.m/2+gmSEQ.pi2+PulseGap+gmSEQ.halfpi+FullDelay];
else
    gmSEQ.CHN(numel(gmSEQ.CHN)).T=[Wait_p+gmSEQ.readout+AfterLaser-BeforeDelay, ...
        Wait_p+gmSEQ.readout+AfterLaser+gmSEQ.rotTime+AfterRot+gmSEQ.halfpi+PulseGap+gmSEQ.pi2+gmSEQ.m/2-BeforeDelay, ...
        Sig_D_start+gmSEQ.readout+AfterLaser-BeforeDelay, ... 
        Sig_D_start+gmSEQ.readout+AfterLaser+gmSEQ.rotTime+AfterRot+gmSEQ.halfpi+PulseGap+gmSEQ.pi2+gmSEQ.m/2-BeforeDelay];
    gmSEQ.CHN(numel(gmSEQ.CHN)).DT=[gmSEQ.rotTime+FullDelay, gmSEQ.pi2+PulseGap+gmSEQ.pi+PulseGap+gmSEQ.pi2+FullDelay, ... 
    gmSEQ.rotTime+FullDelay, gmSEQ.pi2+PulseGap+gmSEQ.pi+PulseGap+gmSEQ.pi2+FullDelay];
end


gmSEQ.CHN(numel(gmSEQ.CHN)+1).PBN=PBDictionary('MWSwitch3');
if gmSEQ.m/2 < 200
    gmSEQ.CHN(numel(gmSEQ.CHN)).NRise=2;
    gmSEQ.CHN(numel(gmSEQ.CHN)).T=[Wait_p+gmSEQ.readout+AfterLaser+gmSEQ.rotTime+AfterRot-BeforeDelay, Sig_D_start+gmSEQ.readout+AfterLaser+gmSEQ.rotTime+AfterRot-BeforeDelay];
    gmSEQ.CHN(numel(gmSEQ.CHN)).DT=repelem(gmSEQ.halfpi+PulseGap+gmSEQ.pi2+gmSEQ.m/2+gmSEQ.pi2+PulseGap+gmSEQ.pi+PulseGap+gmSEQ.pi2+gmSEQ.m/2+gmSEQ.pi2+PulseGap+gmSEQ.halfpi+FullDelay,2);
else
    gmSEQ.CHN(numel(gmSEQ.CHN)).NRise=6;
    gmSEQ.CHN(numel(gmSEQ.CHN)).T=[Wait_p+gmSEQ.readout+AfterLaser+gmSEQ.rotTime+AfterRot-BeforeDelay, ...
        Wait_p+gmSEQ.readout+AfterLaser+gmSEQ.rotTime+AfterRot+gmSEQ.halfpi+PulseGap+gmSEQ.pi2+gmSEQ.m/2-BeforeDelay, ...
        Wait_p+gmSEQ.readout+AfterLaser+gmSEQ.rotTime+AfterRot+gmSEQ.halfpi+PulseGap+gmSEQ.pi2+gmSEQ.m/2+gmSEQ.pi2+PulseGap+gmSEQ.pi+PulseGap+gmSEQ.pi2+gmSEQ.m/2-BeforeDelay, ...
        Sig_D_start+gmSEQ.readout+AfterLaser+gmSEQ.rotTime+AfterRot-BeforeDelay, ... 
        Sig_D_start+gmSEQ.readout+AfterLaser+gmSEQ.rotTime+AfterRot+gmSEQ.halfpi+PulseGap+gmSEQ.pi2+gmSEQ.m/2-BeforeDelay, ...
        Sig_D_start+gmSEQ.readout+AfterLaser+gmSEQ.rotTime+AfterRot+gmSEQ.halfpi+PulseGap+gmSEQ.pi2+gmSEQ.m/2+gmSEQ.pi2+PulseGap+gmSEQ.pi+PulseGap+gmSEQ.pi2+gmSEQ.m/2-BeforeDelay];
    gmSEQ.CHN(numel(gmSEQ.CHN)).DT=[gmSEQ.halfpi+PulseGap+gmSEQ.pi2+FullDelay, gmSEQ.pi2+PulseGap+gmSEQ.pi+PulseGap+gmSEQ.pi2+FullDelay, gmSEQ.pi2+PulseGap+gmSEQ.halfpi+FullDelay, ... 
    gmSEQ.halfpi+PulseGap+gmSEQ.pi2+FullDelay, gmSEQ.pi2+PulseGap+gmSEQ.pi+PulseGap+gmSEQ.pi2+FullDelay, gmSEQ.pi2+PulseGap+gmSEQ.halfpi+FullDelay];
end

gmSEQ.CHN(numel(gmSEQ.CHN)+1).PBN=PBDictionary('dummy1');
gmSEQ.CHN(numel(gmSEQ.CHN)).NRise=2;
gmSEQ.CHN(numel(gmSEQ.CHN)).T=[0 2*(Sig_D_start-Wait_p)-50];
gmSEQ.CHN(numel(gmSEQ.CHN)).DT=[50 50];

%% AWG
% Initialization
chaseFunctionPool('stopChase',  gmSEQ.MWAWG)
chaseFunctionPool('stopChase',  gmSEQ.P1AWG)
chaseFunctionPool('stopChase',  gmSEQ.MWAWG2)

if ~gSG.ACmodAWG % in AC modulation mode
    gSG.AWGFreq = 0;
    gSG2.AWGFreq = 0;
    gSG3.AWGFreq = 0;
end

% Switch bright and dark signal 
% disp("Switching bright and bark.")
delay1 = 0.6; % accounting for the time difference between different RFs
WaveForm_1I = [0 delay1 0 0 0;...
    delay1+0 delay1+gmSEQ.halfpi gSG.AWGFreq 0 gSG.AWGAmp;...
    delay1+gmSEQ.halfpi+PulseGap+gmSEQ.pi2+gmSEQ.m/2+gmSEQ.pi2+PulseGap delay1+gmSEQ.halfpi+PulseGap+gmSEQ.pi2+gmSEQ.m/2+gmSEQ.pi2+PulseGap+gmSEQ.pi gSG.AWGFreq pi/2 gSG.AWGAmp; ...
    delay1+gmSEQ.halfpi+PulseGap+gmSEQ.pi2+gmSEQ.m/2+gmSEQ.pi2+PulseGap+gmSEQ.pi+PulseGap+gmSEQ.pi2+gmSEQ.m/2+gmSEQ.pi2+PulseGap delay1+gmSEQ.halfpi+PulseGap+gmSEQ.pi2+gmSEQ.m/2+gmSEQ.pi2+PulseGap+gmSEQ.pi+PulseGap+gmSEQ.pi2+gmSEQ.m/2+gmSEQ.pi2+PulseGap+gmSEQ.halfpi gSG.AWGFreq pi gSG.AWGAmp];
WaveForm_1Q = WaveForm_1I - repmat([0 0 0 pi/2 0], size(WaveForm_1I, 1), 1);
WaveForm_1Length = ceil((gmSEQ.halfpi+PulseGap+gmSEQ.pi2+gmSEQ.m/2+gmSEQ.pi2+PulseGap+gmSEQ.pi+PulseGap+gmSEQ.pi2+gmSEQ.m/2+gmSEQ.pi2+PulseGap+gmSEQ.halfpi+delay1+1000) / (16 / gSG.AWGClockRate)) ...
    *(16 / gSG.AWGClockRate);
WaveForm_1PointNum = WaveForm_1Length * gSG.AWGClockRate;

WaveForm_2I = [0 delay1 0 0 0;...
    delay1+0 delay1+gmSEQ.halfpi gSG.AWGFreq 0 gSG.AWGAmp;...
    delay1+gmSEQ.halfpi+PulseGap+gmSEQ.pi2+gmSEQ.m/2+gmSEQ.pi2+PulseGap delay1+gmSEQ.halfpi+PulseGap+gmSEQ.pi2+gmSEQ.m/2+gmSEQ.pi2+PulseGap+gmSEQ.pi gSG.AWGFreq pi/2 gSG.AWGAmp; ...
    delay1+gmSEQ.halfpi+PulseGap+gmSEQ.pi2+gmSEQ.m/2+gmSEQ.pi2+PulseGap+gmSEQ.pi+PulseGap+gmSEQ.pi2+gmSEQ.m/2+gmSEQ.pi2+PulseGap delay1+gmSEQ.halfpi+PulseGap+gmSEQ.pi2+gmSEQ.m/2+gmSEQ.pi2+PulseGap+gmSEQ.pi+PulseGap+gmSEQ.pi2+gmSEQ.m/2+gmSEQ.pi2+PulseGap+gmSEQ.halfpi gSG.AWGFreq 0 gSG.AWGAmp];
WaveForm_2Q = WaveForm_2I - repmat([0 0 0 pi/2 0], size(WaveForm_2I, 1), 1);
WaveForm_2Length = WaveForm_1Length;
WaveForm_2PointNum = WaveForm_2Length * gSG.AWGClockRate;

% WaveForm_1I = [0 gmSEQ.halfpi gSG.AWGFreq 0 gSG.AWGAmp;...
%     gmSEQ.halfpi+PulseGap+gmSEQ.pi2+gmSEQ.m/2+gmSEQ.pi2+PulseGap gmSEQ.halfpi+PulseGap+gmSEQ.pi2+gmSEQ.m/2+gmSEQ.pi2+PulseGap+gmSEQ.pi gSG.AWGFreq pi/2 gSG.AWGAmp; ...
%     gmSEQ.halfpi+PulseGap+gmSEQ.pi2+gmSEQ.m/2+gmSEQ.pi2+PulseGap+gmSEQ.pi+PulseGap+gmSEQ.pi2+gmSEQ.m/2+gmSEQ.pi2+PulseGap gmSEQ.halfpi+PulseGap+gmSEQ.pi2+gmSEQ.m/2+gmSEQ.pi2+PulseGap+gmSEQ.pi+PulseGap+gmSEQ.pi2+gmSEQ.m/2+gmSEQ.pi2+PulseGap+gmSEQ.halfpi gSG.AWGFreq pi gSG.AWGAmp];
% WaveForm_1Q = WaveForm_1I - repmat([0 0 0 pi/2 0], size(WaveForm_1I, 1), 1);
% WaveForm_1Length = ceil((gmSEQ.halfpi+PulseGap+gmSEQ.pi2+gmSEQ.m/2+gmSEQ.pi2+PulseGap+gmSEQ.pi+PulseGap+gmSEQ.pi2+gmSEQ.m/2+gmSEQ.pi2+PulseGap+gmSEQ.halfpi+delay1+1000) / (16 / gSG.AWGClockRate)) ...
%     *(16 / gSG.AWGClockRate);
% WaveForm_1PointNum = WaveForm_1Length * gSG.AWGClockRate;
% 
% WaveForm_2I = [0 gmSEQ.halfpi gSG.AWGFreq 0 gSG.AWGAmp;...
%         gmSEQ.halfpi+PulseGap+gmSEQ.pi2+gmSEQ.m/2+gmSEQ.pi2+PulseGap gmSEQ.halfpi+PulseGap+gmSEQ.pi2+gmSEQ.m/2+gmSEQ.pi2+PulseGap+gmSEQ.pi gSG.AWGFreq pi/2 gSG.AWGAmp; ...
%         gmSEQ.halfpi+PulseGap+gmSEQ.pi2+gmSEQ.m/2+gmSEQ.pi2+PulseGap+gmSEQ.pi+PulseGap+gmSEQ.pi2+gmSEQ.m/2+gmSEQ.pi2+PulseGap gmSEQ.halfpi+PulseGap+gmSEQ.pi2+gmSEQ.m/2+gmSEQ.pi2+PulseGap+gmSEQ.pi+PulseGap+gmSEQ.pi2+gmSEQ.m/2+gmSEQ.pi2+PulseGap+gmSEQ.halfpi gSG.AWGFreq 0 gSG.AWGAmp];
% WaveForm_2Q = WaveForm_2I - repmat([0 0 0 pi/2 0], size(WaveForm_2I, 1), 1);
% WaveForm_2Length = WaveForm_1Length;
% WaveForm_2PointNum = WaveForm_2Length * gSG.AWGClockRate;


WaveForm_3I = [0 gmSEQ.halfpi+PulseGap 0 0 0;...
    gmSEQ.halfpi+PulseGap gmSEQ.halfpi+PulseGap+gmSEQ.pi2 gSG3.AWGFreq 0 gSG3.AWGAmp;...
    gmSEQ.halfpi+PulseGap+gmSEQ.pi2+gmSEQ.m/2 gmSEQ.halfpi+PulseGap+gmSEQ.pi2+gmSEQ.m/2+gmSEQ.pi2 gSG3.AWGFreq pi gSG3.AWGAmp; ...
    gmSEQ.halfpi+PulseGap+gmSEQ.pi2+gmSEQ.m/2+gmSEQ.pi2+PulseGap+gmSEQ.pi+PulseGap gmSEQ.halfpi+PulseGap+gmSEQ.pi2+gmSEQ.m/2+gmSEQ.pi2+PulseGap+gmSEQ.pi+PulseGap+gmSEQ.pi2 gSG3.AWGFreq pi gSG3.AWGAmp; ...
    gmSEQ.halfpi+PulseGap+gmSEQ.pi2+gmSEQ.m/2+gmSEQ.pi2+PulseGap+gmSEQ.pi+PulseGap+gmSEQ.pi2+gmSEQ.m/2 gmSEQ.halfpi+PulseGap+gmSEQ.pi2+gmSEQ.m/2+gmSEQ.pi2+PulseGap+gmSEQ.pi+PulseGap+gmSEQ.pi2+gmSEQ.m/2+gmSEQ.pi2 gSG3.AWGFreq 0 gSG3.AWGAmp];
WaveForm_3Q = WaveForm_3I - repmat([0 0 0 pi/2 0], size(WaveForm_3I, 1), 1);
WaveForm_3Length = ceil((gmSEQ.halfpi+PulseGap+gmSEQ.pi2+gmSEQ.m/2+gmSEQ.pi2+PulseGap+gmSEQ.pi+PulseGap+gmSEQ.pi2+gmSEQ.m/2+gmSEQ.pi2+1000) / (16 / gSG3.AWGClockRate)) ...
    *(16 / gSG3.AWGClockRate);
WaveForm_3PointNum = WaveForm_3Length * gSG3.AWGClockRate;

delay2 = 2; % accounting for the time difference between different RFs
if gmSEQ.CoolSwitch == 0
    WaveForm_4I = [0 gmSEQ.rotTime gSG2.AWGFreq 0 gSG2.AWGAmp;...
        gmSEQ.rotTime+AfterRot+gmSEQ.halfpi+PulseGap+gmSEQ.pi2+gmSEQ.m/2+gmSEQ.pi2+PulseGap+delay2 gmSEQ.rotTime+AfterRot+gmSEQ.halfpi+PulseGap+gmSEQ.pi2+gmSEQ.m/2+gmSEQ.pi2+PulseGap+delay2+gmSEQ.pi gSG2.AWGFreq 0 gSG2.AWGAmp];
else
	WaveForm_4I = [0 gmSEQ.rotTime gSG2.AWGFreq 0 0;...
        gmSEQ.rotTime+AfterRot+gmSEQ.halfpi+PulseGap+gmSEQ.pi2+gmSEQ.m/2+gmSEQ.pi2+PulseGap+delay2 gmSEQ.rotTime+AfterRot+gmSEQ.halfpi+PulseGap+gmSEQ.pi2+gmSEQ.m/2+gmSEQ.pi2+PulseGap+delay2+gmSEQ.pi gSG2.AWGFreq 0 gSG2.AWGAmp];
end
WaveForm_4Q = WaveForm_4I - repmat([0 0 0 pi/2 0], size(WaveForm_4I, 1), 1);
WaveForm_4Length = ceil((gmSEQ.rotTime+AfterRot+gmSEQ.halfpi+PulseGap+gmSEQ.pi2+gmSEQ.m/2+gmSEQ.pi2+PulseGap+gmSEQ.pi+delay2+gmSEQ.pi+1000) / (16 / gSG2.P1AWGClockRate)) ...
    *(16 / gSG2.P1AWGClockRate);
WaveForm_4PointNum = WaveForm_4Length * gSG2.P1AWGClockRate;

chaseFunctionPool('createWaveform', WaveForm_1I, gSG.AWGClockRate, WaveForm_1Length, 'Echo_I_seg1.txt'); pause(0.5);
chaseFunctionPool('createWaveform', WaveForm_1Q, gSG.AWGClockRate, WaveForm_1Length, 'Echo_Q_seg1.txt'); pause(0.5);
chaseFunctionPool('createWaveform', WaveForm_2I, gSG.AWGClockRate, WaveForm_2Length, 'Echo_I_seg2.txt'); pause(0.5);
chaseFunctionPool('createWaveform', WaveForm_2Q, gSG.AWGClockRate, WaveForm_2Length, 'Echo_Q_seg2.txt'); pause(0.5);

chaseFunctionPool('createWaveform', WaveForm_3I, gSG3.AWGClockRate, WaveForm_3Length, 'Echo_I_seg3.txt'); pause(0.5);
chaseFunctionPool('createWaveform', WaveForm_3Q, gSG3.AWGClockRate, WaveForm_3Length, 'Echo_Q_seg3.txt'); pause(0.5);

chaseFunctionPool('createWaveform', WaveForm_4I, gSG2.P1AWGClockRate, WaveForm_4Length, 'Echo_I_seg4.txt'); pause(0.5);
chaseFunctionPool('createWaveform', WaveForm_4Q, gSG2.P1AWGClockRate, WaveForm_4Length, 'Echo_Q_seg4.txt'); pause(0.5);

chaseFunctionPool('createSegStruct', 'Echo_SegStruct_I.txt', ...
    'Echo_I_seg1.txt', WaveForm_1PointNum, 1, 1, ...
    'Echo_I_seg2.txt', WaveForm_2PointNum, 1, 1);
pause(0.5);
chaseFunctionPool('createSegStruct', 'Echo_SegStruct_Q.txt', ...
    'Echo_Q_seg1.txt', WaveForm_1PointNum, 1, 1, ...
    'Echo_Q_seg2.txt', WaveForm_2PointNum, 1, 1);
pause(0.5);

chaseFunctionPool('createSegStruct', 'Echo_SegStruct_H_I.txt', ...
    'Echo_I_seg3.txt', WaveForm_3PointNum, 1, 1, ...
    'Echo_I_seg3.txt', WaveForm_3PointNum, 1, 1);
pause(0.5);
chaseFunctionPool('createSegStruct', 'Echo_SegStruct_H_Q.txt', ...
    'Echo_Q_seg3.txt', WaveForm_3PointNum, 1, 1, ...
    'Echo_Q_seg3.txt', WaveForm_3PointNum, 1, 1);
pause(0.5);

chaseFunctionPool('createSegStruct', 'Echo_SegStruct_S_I.txt', ...
    'Echo_I_seg4.txt', WaveForm_4PointNum, 1, 1, ...
    'Echo_I_seg4.txt', WaveForm_4PointNum, 1, 1);
pause(0.5);
chaseFunctionPool('createSegStruct', 'Echo_SegStruct_S_Q.txt', ...
    'Echo_Q_seg4.txt', WaveForm_4PointNum, 1, 1, ...
    'Echo_Q_seg4.txt', WaveForm_4PointNum, 1, 1);
pause(0.5);

chaseFunctionPool('CreateSegments', gmSEQ.MWAWG, 1, ...
    2, ...
    2047, 2047, 'Echo_SegStruct_I.txt', 'false');
pause(1); % this pause seems to be important, otherwise the loading is not right occassionally
chaseFunctionPool('CreateSegments', gmSEQ.MWAWG, 2, ...
    2, ...
    2047, 2047, 'Echo_SegStruct_Q.txt', 'false');
pause(1); % this pause seems to be important, otherwise the loading is not right occassionally

chaseFunctionPool('CreateSegments', gmSEQ.MWAWG2, 1, ...
    2, ...
    2047, 2047, 'Echo_SegStruct_H_I.txt', 'false');
pause(1); % this pause seems to be important, otherwise the loading is not right occassionally
chaseFunctionPool('CreateSegments', gmSEQ.MWAWG2, 2, ...
    2, ...
    2047, 2047, 'Echo_SegStruct_H_Q.txt', 'false');
pause(1); % this pause seems to be important, otherwise the loading is not right occassionally

chaseFunctionPool('CreateSegments', gmSEQ.P1AWG, 1, ...
    2, ...
    2047, 2047, 'Echo_SegStruct_S_I.txt', 'false');
pause(1); % this pause seems to be important, otherwise the loading is not right occassionally
chaseFunctionPool('CreateSegments', gmSEQ.P1AWG, 2, ...
    2, ...
    2047, 2047, 'Echo_SegStruct_S_Q.txt', 'false');
pause(1); % this pause seems to be important, otherwise the loading is not right occassionally

chaseFunctionPool('runChase', gmSEQ.MWAWG, 'false');
pause(0.5)
chaseFunctionPool('runChase', gmSEQ.MWAWG2, 'false');
pause(0.5)
chaseFunctionPool('runChase', gmSEQ.P1AWG, 'false');

ApplyDelays();

function XY8
global gmSEQ gSG
gSG.bfixedPow=1;
gSG.bfixedFreq=1;
gSG.bMod='IQ';
gSG.bModSrc='External';

gmSEQ.halfpi = gmSEQ.pi/2;

AfterPi = 2000;
AfterLaser = 100000;
Wait_p = 0.1e6;
Detect_Window = 5000;

Sig_D_start = Wait_p+gmSEQ.readout+AfterLaser+gmSEQ.halfpi+(16*gmSEQ.m + 8*gmSEQ.pi)+gmSEQ.halfpi+AfterPi+Detect_Window+Wait_p;

gmSEQ.CHN(1).PBN=PBDictionary('ctr0');
gmSEQ.CHN(1).NRise=4;
gmSEQ.CHN(1).T=[Wait_p+gmSEQ.readout-1000-gmSEQ.CtrGateDur, ...
    Wait_p+gmSEQ.readout+AfterLaser+gmSEQ.halfpi+(16*gmSEQ.m + 8*gmSEQ.pi)+gmSEQ.halfpi+AfterPi, ...
    Sig_D_start+gmSEQ.readout-1000-gmSEQ.CtrGateDur, ... 
    Sig_D_start+gmSEQ.readout+AfterLaser+gmSEQ.halfpi+(16*gmSEQ.m + 8*gmSEQ.pi)+gmSEQ.halfpi+AfterPi];
if strcmp(gmSEQ.meas,'SPCM')
    gmSEQ.CHN(1).DT=[gmSEQ.CtrGateDur gmSEQ.CtrGateDur gmSEQ.CtrGateDur gmSEQ.CtrGateDur];
elseif strcmp(gmSEQ.meas,'APD')
    gmSEQ.CHN(1).DT=[1000 1000 1000 1000];
end

gmSEQ.CHN(numel(gmSEQ.CHN)+1).PBN=PBDictionary('AOM');
gmSEQ.CHN(numel(gmSEQ.CHN)).NRise=4;
gmSEQ.CHN(numel(gmSEQ.CHN)).T = [Wait_p, Wait_p+gmSEQ.readout+AfterLaser+gmSEQ.halfpi+(16*gmSEQ.m + 8*gmSEQ.pi)+gmSEQ.halfpi+AfterPi, ...
    Sig_D_start, Sig_D_start+gmSEQ.readout+AfterLaser+gmSEQ.halfpi+(16*gmSEQ.m + 8*gmSEQ.pi)+gmSEQ.halfpi+AfterPi];
gmSEQ.CHN(numel(gmSEQ.CHN)).DT = [gmSEQ.readout Detect_Window gmSEQ.readout Detect_Window];
%

gmSEQ.CHN(numel(gmSEQ.CHN)+1).PBN=PBDictionary('AWGTrig');
gmSEQ.CHN(numel(gmSEQ.CHN)).NRise=2;
gmSEQ.CHN(numel(gmSEQ.CHN)).T=[Wait_p+gmSEQ.readout+AfterLaser, ...
    Sig_D_start+gmSEQ.readout+AfterLaser];
gmSEQ.CHN(numel(gmSEQ.CHN)).DT=[2150 2150];


gmSEQ.CHN(numel(gmSEQ.CHN)+1).PBN=PBDictionary('MWSwitch');
if gmSEQ.m < 150
    gmSEQ.CHN(numel(gmSEQ.CHN)).NRise=2;
    gmSEQ.CHN(numel(gmSEQ.CHN)).T=[Wait_p+gmSEQ.readout+AfterLaser-20, Sig_D_start+gmSEQ.readout+AfterLaser-20];
    gmSEQ.CHN(numel(gmSEQ.CHN)).DT=[gmSEQ.halfpi+(16*gmSEQ.m + 8*gmSEQ.pi)+gmSEQ.halfpi+40, ... 
    gmSEQ.halfpi+(16*gmSEQ.m + 8*gmSEQ.pi)+gmSEQ.halfpi+40];
else
    gmSEQ.CHN(numel(gmSEQ.CHN)).NRise=20;
    gmSEQ.CHN(numel(gmSEQ.CHN)).T= [Wait_p+gmSEQ.readout+AfterLaser-20];
    for i = 0:7
        gmSEQ.CHN(numel(gmSEQ.CHN)).T = [gmSEQ.CHN(numel(gmSEQ.CHN)).T, ...
            Wait_p+gmSEQ.readout+AfterLaser+gmSEQ.halfpi+gmSEQ.m+i*(gmSEQ.pi+gmSEQ.m*2)-20];
    end
    gmSEQ.CHN(numel(gmSEQ.CHN)).T = [gmSEQ.CHN(numel(gmSEQ.CHN)).T, ...
        Wait_p+gmSEQ.readout+AfterLaser+gmSEQ.halfpi+(16*gmSEQ.m + 8*gmSEQ.pi)-20, ...
        Sig_D_start+gmSEQ.readout+AfterLaser-20]; 
    for i = 0:7
        gmSEQ.CHN(numel(gmSEQ.CHN)).T = [gmSEQ.CHN(numel(gmSEQ.CHN)).T, ...
            Sig_D_start+gmSEQ.readout+AfterLaser+gmSEQ.halfpi+gmSEQ.m+i*(gmSEQ.pi+gmSEQ.m*2)-20];
    end
    gmSEQ.CHN(numel(gmSEQ.CHN)).T = [gmSEQ.CHN(numel(gmSEQ.CHN)).T, ...
         Sig_D_start+gmSEQ.readout+AfterLaser+gmSEQ.halfpi+(16*gmSEQ.m + 8*gmSEQ.pi)-20];
    
    gmSEQ.CHN(numel(gmSEQ.CHN)).DT=[gmSEQ.halfpi+40, repelem(gmSEQ.pi+40, 8), gmSEQ.halfpi+40, ... 
        gmSEQ.halfpi+40, repelem(gmSEQ.pi+40, 8), gmSEQ.halfpi+40];
end

gmSEQ.CHN(numel(gmSEQ.CHN)+1).PBN=PBDictionary('dummy1');
gmSEQ.CHN(numel(gmSEQ.CHN)).NRise=2;
gmSEQ.CHN(numel(gmSEQ.CHN)).T=[0 Sig_D_start+gmSEQ.readout+AfterLaser+gmSEQ.halfpi+(16*gmSEQ.m + 8*gmSEQ.pi)+gmSEQ.halfpi+AfterPi+Detect_Window-50];
gmSEQ.CHN(numel(gmSEQ.CHN)).DT=[50 50];

%% AWG
% Initialization
chaseFunctionPool('stopChase',  gmSEQ.MWAWG)

% This part need to be modified to accomodate the DC modulation
if gSG.ACmodAWG % in AC modulation mode
    gSG.AWGFreq = gSG.AWGFreq;
else
    gSG.AWGFreq = 0;
end

WaveForm_1I = [0 gmSEQ.halfpi gSG.AWGFreq 0 gSG.AWGAmp;...
    gmSEQ.halfpi+gmSEQ.m gmSEQ.halfpi+gmSEQ.m+gmSEQ.pi gSG.AWGFreq 0 gSG.AWGAmp; ...
    gmSEQ.halfpi+gmSEQ.m+gmSEQ.pi+gmSEQ.m*2 gmSEQ.halfpi+gmSEQ.m+gmSEQ.pi+gmSEQ.m*2+gmSEQ.pi gSG.AWGFreq pi/2 gSG.AWGAmp; ...
    gmSEQ.halfpi+gmSEQ.m+(gmSEQ.pi+gmSEQ.m*2)*2 gmSEQ.halfpi+gmSEQ.m+(gmSEQ.pi+gmSEQ.m*2)*2+gmSEQ.pi gSG.AWGFreq 0 gSG.AWGAmp; ...
    gmSEQ.halfpi+gmSEQ.m+(gmSEQ.pi+gmSEQ.m*2)*3 gmSEQ.halfpi+gmSEQ.m+(gmSEQ.pi+gmSEQ.m*2)*3+gmSEQ.pi gSG.AWGFreq pi/2 gSG.AWGAmp; ...
    gmSEQ.halfpi+gmSEQ.m+(gmSEQ.pi+gmSEQ.m*2)*4 gmSEQ.halfpi+gmSEQ.m+(gmSEQ.pi+gmSEQ.m*2)*4+gmSEQ.pi gSG.AWGFreq pi/2 gSG.AWGAmp; ...
    gmSEQ.halfpi+gmSEQ.m+(gmSEQ.pi+gmSEQ.m*2)*5 gmSEQ.halfpi+gmSEQ.m+(gmSEQ.pi+gmSEQ.m*2)*5+gmSEQ.pi gSG.AWGFreq 0 gSG.AWGAmp; ...
    gmSEQ.halfpi+gmSEQ.m+(gmSEQ.pi+gmSEQ.m*2)*6 gmSEQ.halfpi+gmSEQ.m+(gmSEQ.pi+gmSEQ.m*2)*6+gmSEQ.pi gSG.AWGFreq pi/2 gSG.AWGAmp; ...
    gmSEQ.halfpi+gmSEQ.m+(gmSEQ.pi+gmSEQ.m*2)*7 gmSEQ.halfpi+gmSEQ.m+(gmSEQ.pi+gmSEQ.m*2)*7+gmSEQ.pi gSG.AWGFreq 0 gSG.AWGAmp; ...
    gmSEQ.halfpi+(8*gmSEQ.pi + gmSEQ.m) gmSEQ.halfpi+(8*gmSEQ.pi + gmSEQ.m)+gmSEQ.halfpi gSG.AWGFreq pi gSG.AWGAmp];
WaveForm_1Q = [0 gmSEQ.halfpi gSG.AWGFreq -pi/2 gSG.AWGAmp;...
    gmSEQ.halfpi+gmSEQ.m gmSEQ.halfpi+gmSEQ.m+gmSEQ.pi gSG.AWGFreq -pi/2 gSG.AWGAmp; ...
    gmSEQ.halfpi+gmSEQ.m+gmSEQ.pi+gmSEQ.m*2 gmSEQ.halfpi+gmSEQ.m+gmSEQ.pi+gmSEQ.m*2+gmSEQ.pi gSG.AWGFreq pi/2-pi/2 gSG.AWGAmp; ...
    gmSEQ.halfpi+gmSEQ.m+(gmSEQ.pi+gmSEQ.m*2)*2 gmSEQ.halfpi+gmSEQ.m+(gmSEQ.pi+gmSEQ.m*2)*2+gmSEQ.pi gSG.AWGFreq 0-pi/2 gSG.AWGAmp; ...
    gmSEQ.halfpi+gmSEQ.m+(gmSEQ.pi+gmSEQ.m*2)*3 gmSEQ.halfpi+gmSEQ.m+(gmSEQ.pi+gmSEQ.m*2)*3+gmSEQ.pi gSG.AWGFreq pi/2-pi/2 gSG.AWGAmp; ...
    gmSEQ.halfpi+gmSEQ.m+(gmSEQ.pi+gmSEQ.m*2)*4 gmSEQ.halfpi+gmSEQ.m+(gmSEQ.pi+gmSEQ.m*2)*4+gmSEQ.pi gSG.AWGFreq pi/2-pi/2 gSG.AWGAmp; ...
    gmSEQ.halfpi+gmSEQ.m+(gmSEQ.pi+gmSEQ.m*2)*5 gmSEQ.halfpi+gmSEQ.m+(gmSEQ.pi+gmSEQ.m*2)*5+gmSEQ.pi gSG.AWGFreq 0-pi/2 gSG.AWGAmp; ...
    gmSEQ.halfpi+gmSEQ.m+(gmSEQ.pi+gmSEQ.m*2)*6 gmSEQ.halfpi+gmSEQ.m+(gmSEQ.pi+gmSEQ.m*2)*6+gmSEQ.pi gSG.AWGFreq pi/2-pi/2 gSG.AWGAmp; ...
    gmSEQ.halfpi+gmSEQ.m+(gmSEQ.pi+gmSEQ.m*2)*7 gmSEQ.halfpi+gmSEQ.m+(gmSEQ.pi+gmSEQ.m*2)*7+gmSEQ.pi gSG.AWGFreq 0-pi/2 gSG.AWGAmp; ...
    gmSEQ.halfpi+(8*gmSEQ.pi + gmSEQ.m) gmSEQ.halfpi+(8*gmSEQ.pi + gmSEQ.m)+gmSEQ.halfpi gSG.AWGFreq pi-pi/2 gSG.AWGAmp];

WaveForm_1Length = ceil((gmSEQ.halfpi+(gmSEQ.pi*8 + gmSEQ.m)+gmSEQ.halfpi+1000) / (16 / gSG.AWGClockRate)) ...
    *(16 / gSG.AWGClockRate);
WaveForm_1PointNum = WaveForm_1Length * gSG.AWGClockRate;

WaveForm_2I = [0 gmSEQ.halfpi gSG.AWGFreq 0 gSG.AWGAmp;...
    gmSEQ.halfpi+gmSEQ.m gmSEQ.halfpi+gmSEQ.m+gmSEQ.pi gSG.AWGFreq 0 gSG.AWGAmp; ...
    gmSEQ.halfpi+gmSEQ.m+gmSEQ.pi+gmSEQ.m*2 gmSEQ.halfpi+gmSEQ.m+gmSEQ.pi+gmSEQ.m*2+gmSEQ.pi gSG.AWGFreq pi/2 gSG.AWGAmp; ...
    gmSEQ.halfpi+gmSEQ.m+(gmSEQ.pi+gmSEQ.m*2)*2 gmSEQ.halfpi+gmSEQ.m+(gmSEQ.pi+gmSEQ.m*2)*2+gmSEQ.pi gSG.AWGFreq 0 gSG.AWGAmp; ...
    gmSEQ.halfpi+gmSEQ.m+(gmSEQ.pi+gmSEQ.m*2)*3 gmSEQ.halfpi+gmSEQ.m+(gmSEQ.pi+gmSEQ.m*2)*3+gmSEQ.pi gSG.AWGFreq pi/2 gSG.AWGAmp; ...
    gmSEQ.halfpi+gmSEQ.m+(gmSEQ.pi+gmSEQ.m*2)*4 gmSEQ.halfpi+gmSEQ.m+(gmSEQ.pi+gmSEQ.m*2)*4+gmSEQ.pi gSG.AWGFreq pi/2 gSG.AWGAmp; ...
    gmSEQ.halfpi+gmSEQ.m+(gmSEQ.pi+gmSEQ.m*2)*5 gmSEQ.halfpi+gmSEQ.m+(gmSEQ.pi+gmSEQ.m*2)*5+gmSEQ.pi gSG.AWGFreq 0 gSG.AWGAmp; ...
    gmSEQ.halfpi+gmSEQ.m+(gmSEQ.pi+gmSEQ.m*2)*6 gmSEQ.halfpi+gmSEQ.m+(gmSEQ.pi+gmSEQ.m*2)*6+gmSEQ.pi gSG.AWGFreq pi/2 gSG.AWGAmp; ...
    gmSEQ.halfpi+gmSEQ.m+(gmSEQ.pi+gmSEQ.m*2)*7 gmSEQ.halfpi+gmSEQ.m+(gmSEQ.pi+gmSEQ.m*2)*7+gmSEQ.pi gSG.AWGFreq 0 gSG.AWGAmp; ...
    gmSEQ.halfpi+(8*gmSEQ.pi + gmSEQ.m) gmSEQ.halfpi+(8*gmSEQ.pi + gmSEQ.m)+gmSEQ.halfpi gSG.AWGFreq 0 gSG.AWGAmp];
WaveForm_2Q = [0 gmSEQ.halfpi gSG.AWGFreq -pi/2 gSG.AWGAmp;...
    gmSEQ.halfpi+gmSEQ.m gmSEQ.halfpi+gmSEQ.m+gmSEQ.pi gSG.AWGFreq -pi/2 gSG.AWGAmp; ...
    gmSEQ.halfpi+gmSEQ.m+gmSEQ.pi+gmSEQ.m*2 gmSEQ.halfpi+gmSEQ.m+gmSEQ.pi+gmSEQ.m*2+gmSEQ.pi gSG.AWGFreq pi/2-pi/2 gSG.AWGAmp; ...
    gmSEQ.halfpi+gmSEQ.m+(gmSEQ.pi+gmSEQ.m*2)*2 gmSEQ.halfpi+gmSEQ.m+(gmSEQ.pi+gmSEQ.m*2)*2+gmSEQ.pi gSG.AWGFreq 0-pi/2 gSG.AWGAmp; ...
    gmSEQ.halfpi+gmSEQ.m+(gmSEQ.pi+gmSEQ.m*2)*3 gmSEQ.halfpi+gmSEQ.m+(gmSEQ.pi+gmSEQ.m*2)*3+gmSEQ.pi gSG.AWGFreq pi/2-pi/2 gSG.AWGAmp; ...
    gmSEQ.halfpi+gmSEQ.m+(gmSEQ.pi+gmSEQ.m*2)*4 gmSEQ.halfpi+gmSEQ.m+(gmSEQ.pi+gmSEQ.m*2)*4+gmSEQ.pi gSG.AWGFreq pi/2-pi/2 gSG.AWGAmp; ...
    gmSEQ.halfpi+gmSEQ.m+(gmSEQ.pi+gmSEQ.m*2)*5 gmSEQ.halfpi+gmSEQ.m+(gmSEQ.pi+gmSEQ.m*2)*5+gmSEQ.pi gSG.AWGFreq 0-pi/2 gSG.AWGAmp; ...
    gmSEQ.halfpi+gmSEQ.m+(gmSEQ.pi+gmSEQ.m*2)*6 gmSEQ.halfpi+gmSEQ.m+(gmSEQ.pi+gmSEQ.m*2)*6+gmSEQ.pi gSG.AWGFreq pi/2-pi/2 gSG.AWGAmp; ...
    gmSEQ.halfpi+gmSEQ.m+(gmSEQ.pi+gmSEQ.m*2)*7 gmSEQ.halfpi+gmSEQ.m+(gmSEQ.pi+gmSEQ.m*2)*7+gmSEQ.pi gSG.AWGFreq 0-pi/2 gSG.AWGAmp; ...
    gmSEQ.halfpi+(8*gmSEQ.pi + gmSEQ.m) gmSEQ.halfpi+(8*gmSEQ.pi + gmSEQ.m)+gmSEQ.halfpi gSG.AWGFreq 0-pi/2 gSG.AWGAmp];

WaveForm_2Length = ceil((gmSEQ.halfpi+(gmSEQ.pi*8 + gmSEQ.m)+gmSEQ.halfpi+1000) / (16 / gSG.AWGClockRate)) ...
    *(16 / gSG.AWGClockRate);
WaveForm_2PointNum = WaveForm_2Length * gSG.AWGClockRate;


chaseFunctionPool('createWaveform', WaveForm_1I, gSG.AWGClockRate, WaveForm_1Length, 'XY8_I_seg1.txt'); pause(0.5);
chaseFunctionPool('createWaveform', WaveForm_1Q, gSG.AWGClockRate, WaveForm_1Length, 'XY8_Q_seg1.txt'); pause(0.5);
chaseFunctionPool('createWaveform', WaveForm_2I, gSG.AWGClockRate, WaveForm_2Length, 'XY8_I_seg2.txt'); pause(0.5);
chaseFunctionPool('createWaveform', WaveForm_2Q, gSG.AWGClockRate, WaveForm_2Length, 'XY8_Q_seg2.txt'); pause(0.5);


chaseFunctionPool('createSegStruct', 'XY8_SegStruct_I.txt', ...
    'XY8_I_seg1.txt', WaveForm_1PointNum, 1, 1, ...
    'XY8_I_seg2.txt', WaveForm_2PointNum, 1, 1);
pause(0.5);
chaseFunctionPool('createSegStruct', 'XY8_SegStruct_Q.txt', ...
    'XY8_Q_seg1.txt', WaveForm_1PointNum, 1, 1, ...
    'XY8_Q_seg2.txt', WaveForm_2PointNum, 1, 1);
pause(0.5);

%% Load waveform to AWG
chaseFunctionPool('CreateSegments', gmSEQ.MWAWG, 1, ...
    2, ...
    2047, 2047, 'XY8_SegStruct_I.txt', 'false');
pause(1); % this pause seems to be important, otherwise the loading is not right occassionally
chaseFunctionPool('CreateSegments', gmSEQ.MWAWG, 2, ...
    2, ...
    2047, 2047, 'XY8_SegStruct_Q.txt', 'false');
pause(1); % this pause seems to be important, otherwise the loading is not right occassionally
%% Run waveform
chaseFunctionPool('runChase', gmSEQ.MWAWG, 'false');
ApplyDelays();

function XY8N
global gmSEQ gSG
gSG.bfixedPow=1;
gSG.bfixedFreq=1;
gSG.bMod='IQ';
gSG.bModSrc='External';

[gmSEQ.ScaleT, gmSEQ.ScaleStr] = GetScale(8*(gmSEQ.pi+gmSEQ.interval)*gmSEQ.To);

% TODO: add the definition for the pi and halfpi pulse AWG amp
% gSG.piAWGAmp = gmSEQ.SAmp1; % Just for temporary use
% gSG.halfpiAWGAmp = gmSEQ.SAmp2; % Just for temporary use
gSG.piAWGAmp = gSG.AWGAmp; 
gSG.halfpiAWGAmp = gSG.AWGAmp;

% gmSEQ.m here is the repetition number of XY8 block
gmSEQ.m = round(gmSEQ.m);

AfterPi = 2000;
AfterLaser = 0.2e6;
Wait_p = 10e3;
Detect_Window = 5000;
MWbuffer = 10; 

Cycle = (gmSEQ.interval + gmSEQ.pi)*8;
Sig_D_start = Wait_p+gmSEQ.readout+AfterLaser+gmSEQ.halfpi+Cycle*gmSEQ.m+gmSEQ.halfpi+AfterPi+Detect_Window+Wait_p;

gmSEQ.CHN(1).PBN=PBDictionary('ctr0');
gmSEQ.CHN(1).NRise=4;
gmSEQ.CHN(1).T=[Wait_p+gmSEQ.readout-1000-gmSEQ.CtrGateDur, ...
    Wait_p+gmSEQ.readout+AfterLaser+gmSEQ.halfpi+Cycle*gmSEQ.m+gmSEQ.halfpi+AfterPi, ...
    Sig_D_start+gmSEQ.readout-1000-gmSEQ.CtrGateDur, ... 
    Sig_D_start+gmSEQ.readout+AfterLaser+gmSEQ.halfpi+Cycle*gmSEQ.m+gmSEQ.halfpi+AfterPi];
if strcmp(gmSEQ.meas,'SPCM')
    gmSEQ.CHN(1).DT=[gmSEQ.CtrGateDur gmSEQ.CtrGateDur gmSEQ.CtrGateDur gmSEQ.CtrGateDur];
elseif strcmp(gmSEQ.meas,'APD')
    gmSEQ.CHN(1).DT=[1000 1000 1000 1000];
end

gmSEQ.CHN(numel(gmSEQ.CHN)+1).PBN=PBDictionary('AOM');
gmSEQ.CHN(numel(gmSEQ.CHN)).NRise=4;
gmSEQ.CHN(numel(gmSEQ.CHN)).T = [Wait_p, Wait_p+gmSEQ.readout+AfterLaser+gmSEQ.halfpi+Cycle*gmSEQ.m+gmSEQ.halfpi+AfterPi, ...
    Sig_D_start, Sig_D_start+gmSEQ.readout+AfterLaser+gmSEQ.halfpi+Cycle*gmSEQ.m+gmSEQ.halfpi+AfterPi];
gmSEQ.CHN(numel(gmSEQ.CHN)).DT = [gmSEQ.readout Detect_Window gmSEQ.readout Detect_Window];


gmSEQ.CHN(numel(gmSEQ.CHN)+1).PBN=PBDictionary('AWGTrig');
gmSEQ.CHN(numel(gmSEQ.CHN)).NRise=2;
gmSEQ.CHN(numel(gmSEQ.CHN)).T=[Wait_p+gmSEQ.readout+AfterLaser, ...
    Sig_D_start+gmSEQ.readout+AfterLaser];
gmSEQ.CHN(numel(gmSEQ.CHN)).DT=repelem(gmSEQ.halfpi+Cycle*gmSEQ.m+gmSEQ.halfpi+200, 2);


gmSEQ.CHN(numel(gmSEQ.CHN)+1).PBN=PBDictionary('MWSwitch');
if gmSEQ.m == 0
        gmSEQ.CHN(numel(gmSEQ.CHN)).NRise=2;
        gmSEQ.CHN(numel(gmSEQ.CHN)).T=[Wait_p+gmSEQ.readout+AfterLaser-MWbuffer, Sig_D_start+gmSEQ.readout+AfterLaser-MWbuffer];
        gmSEQ.CHN(numel(gmSEQ.CHN)).DT=[gmSEQ.halfpi+gmSEQ.halfpi+2*MWbuffer, gmSEQ.halfpi+gmSEQ.halfpi+2*MWbuffer];
else
    if gmSEQ.interval < 100
        gmSEQ.CHN(numel(gmSEQ.CHN)).NRise=2;
        gmSEQ.CHN(numel(gmSEQ.CHN)).T=[Wait_p+gmSEQ.readout+AfterLaser-MWbuffer, Sig_D_start+gmSEQ.readout+AfterLaser-MWbuffer];
        gmSEQ.CHN(numel(gmSEQ.CHN)).DT=[gmSEQ.halfpi+Cycle*gmSEQ.m+gmSEQ.halfpi+2*MWbuffer, gmSEQ.halfpi+Cycle*gmSEQ.m+gmSEQ.halfpi+2*MWbuffer];
    else
        gmSEQ.CHN(numel(gmSEQ.CHN)).NRise=2*(8*gmSEQ.m + 2);
        gmSEQ.CHN(numel(gmSEQ.CHN)).T = zeros(1, 2*(8*gmSEQ.m + 2));
        gmSEQ.CHN(numel(gmSEQ.CHN)).T(1) = Wait_p+gmSEQ.readout+AfterLaser-MWbuffer;
        for i = 1:gmSEQ.m
            for j = 1:8
             gmSEQ.CHN(numel(gmSEQ.CHN)).T(1+(i-1)*8+j) = Wait_p+gmSEQ.readout+AfterLaser+gmSEQ.halfpi+gmSEQ.interval/2+(i-1+(j-1)/8)*Cycle-MWbuffer;
            end
        end
        gmSEQ.CHN(numel(gmSEQ.CHN)).T(1+8*gmSEQ.m+1) = Wait_p+gmSEQ.readout+AfterLaser+gmSEQ.halfpi+gmSEQ.m*Cycle-MWbuffer;
        gmSEQ.CHN(numel(gmSEQ.CHN)).T(1+8*gmSEQ.m+2) = Sig_D_start+gmSEQ.readout+AfterLaser-MWbuffer;
        for i = 1:gmSEQ.m
            for j = 1:8
             gmSEQ.CHN(numel(gmSEQ.CHN)).T(3+8*gmSEQ.m+(i-1)*8+j) = Sig_D_start+gmSEQ.readout+AfterLaser+gmSEQ.halfpi+gmSEQ.interval/2+(i-1+(j-1)/8)*Cycle-MWbuffer;
            end
        end
        gmSEQ.CHN(numel(gmSEQ.CHN)).T(3+16*gmSEQ.m+1) = Sig_D_start+gmSEQ.readout+AfterLaser+gmSEQ.halfpi+gmSEQ.m*Cycle-MWbuffer;
        gmSEQ.CHN(numel(gmSEQ.CHN)).DT=[gmSEQ.halfpi+2*MWbuffer, repelem(gmSEQ.pi+2*MWbuffer, 8*gmSEQ.m), gmSEQ.halfpi+2*MWbuffer, ... 
            gmSEQ.halfpi+2*MWbuffer, repelem(gmSEQ.pi+2*MWbuffer, 8*gmSEQ.m), gmSEQ.halfpi+2*MWbuffer];
    end
end

gmSEQ.CHN(numel(gmSEQ.CHN)+1).PBN=PBDictionary('dummy1');
gmSEQ.CHN(numel(gmSEQ.CHN)).NRise=2;
gmSEQ.CHN(numel(gmSEQ.CHN)).T=[0 2*(Sig_D_start-Wait_p)-50];
gmSEQ.CHN(numel(gmSEQ.CHN)).DT=[50 50];

%% AWG
% Initialization
chaseFunctionPool('stopChase',  gmSEQ.MWAWG)

% This part need to be modified to accomodate the DC modulation
if ~gSG.ACmodAWG % in AC modulation mode
    gSG.AWGFreq = 0;
end

if gmSEQ.m == 0
   WaveForm_1I = [0 gmSEQ.halfpi*2 gSG.AWGFreq 0 0];
%      WaveForm_1I = [0 gmSEQ.halfpi gSG.AWGFreq 0 gSG.halfpiAWGAmp; ...
%          gmSEQ.halfpi+0 2*gmSEQ.halfpi+0 gSG.AWGFreq pi gSG.halfpiAWGAmp];
else
    WaveForm_1I = zeros(2 + 8*gmSEQ.m, 5);
    WaveForm_1I(1, :) = [0 gmSEQ.halfpi gSG.AWGFreq 0 gSG.halfpiAWGAmp];
    for i = 1:gmSEQ.m
        WaveForm_1I(1 + (i-1)*8 + 1, :) = [gmSEQ.halfpi+gmSEQ.interval/2+(i-1+0/8)*Cycle gmSEQ.halfpi+gmSEQ.interval/2+(i-1+0/8)*Cycle+gmSEQ.pi gSG.AWGFreq 0 gSG.piAWGAmp]; % pi_x
        WaveForm_1I(1 + (i-1)*8 + 2, :) = [gmSEQ.halfpi+gmSEQ.interval/2+(i-1+1/8)*Cycle gmSEQ.halfpi+gmSEQ.interval/2+(i-1+1/8)*Cycle+gmSEQ.pi gSG.AWGFreq pi/2 gSG.piAWGAmp]; % pi_y
        WaveForm_1I(1 + (i-1)*8 + 3, :) = [gmSEQ.halfpi+gmSEQ.interval/2+(i-1+2/8)*Cycle gmSEQ.halfpi+gmSEQ.interval/2+(i-1+2/8)*Cycle+gmSEQ.pi gSG.AWGFreq 0 gSG.piAWGAmp]; % pi_x
        WaveForm_1I(1 + (i-1)*8 + 4, :) = [gmSEQ.halfpi+gmSEQ.interval/2+(i-1+3/8)*Cycle gmSEQ.halfpi+gmSEQ.interval/2+(i-1+3/8)*Cycle+gmSEQ.pi gSG.AWGFreq pi/2 gSG.piAWGAmp]; % pi_y
        WaveForm_1I(1 + (i-1)*8 + 5, :) = [gmSEQ.halfpi+gmSEQ.interval/2+(i-1+4/8)*Cycle gmSEQ.halfpi+gmSEQ.interval/2+(i-1+4/8)*Cycle+gmSEQ.pi gSG.AWGFreq pi/2 gSG.piAWGAmp]; % pi_y
        WaveForm_1I(1 + (i-1)*8 + 6, :) = [gmSEQ.halfpi+gmSEQ.interval/2+(i-1+5/8)*Cycle gmSEQ.halfpi+gmSEQ.interval/2+(i-1+5/8)*Cycle+gmSEQ.pi gSG.AWGFreq 0 gSG.piAWGAmp]; % pi_x
        WaveForm_1I(1 + (i-1)*8 + 7, :) = [gmSEQ.halfpi+gmSEQ.interval/2+(i-1+6/8)*Cycle gmSEQ.halfpi+gmSEQ.interval/2+(i-1+6/8)*Cycle+gmSEQ.pi gSG.AWGFreq pi/2 gSG.piAWGAmp]; % pi_y
        WaveForm_1I(1 + (i-1)*8 + 8, :) = [gmSEQ.halfpi+gmSEQ.interval/2+(i-1+7/8)*Cycle gmSEQ.halfpi+gmSEQ.interval/2+(i-1+7/8)*Cycle+gmSEQ.pi gSG.AWGFreq 0 gSG.piAWGAmp]; % pi_x
    end
    WaveForm_1I(2 + 8*gmSEQ.m, :) = [gmSEQ.halfpi+gmSEQ.m*Cycle gmSEQ.halfpi+gmSEQ.m*Cycle+gmSEQ.halfpi gSG.AWGFreq pi gSG.halfpiAWGAmp];
    % WaveForm_1I(2 + 8*gmSEQ.m, :) = [gmSEQ.halfpi+gmSEQ.m*Cycle gmSEQ.halfpi+gmSEQ.m*Cycle+gmSEQ.halfpi gSG.AWGFreq pi 0];
end
WaveForm_1Q = WaveForm_1I - repmat([0 0 0 pi/2 0], size(WaveForm_1I, 1), 1);
WaveForm_1Length = ceil((gmSEQ.halfpi+gmSEQ.m*Cycle+gmSEQ.halfpi+1000) / (16 / gSG.AWGClockRate)) ...
    *(16 / gSG.AWGClockRate);
WaveForm_1PointNum = WaveForm_1Length * gSG.AWGClockRate;

if gmSEQ.m == 0
    WaveForm_2I = [0 gmSEQ.halfpi*2 gSG.AWGFreq 0 gSG.halfpiAWGAmp];
    WaveForm_2Q = WaveForm_2I - repmat([0 0 0 pi/2 0], size(WaveForm_2I, 1), 1);
    WaveForm_2Length = ceil((gmSEQ.halfpi+gmSEQ.halfpi+1000) / (16 / gSG.AWGClockRate)) * (16 / gSG.AWGClockRate);
    WaveForm_2PointNum = WaveForm_2Length * gSG.AWGClockRate;
else
    WaveForm_2I = WaveForm_1I;
    WaveForm_2I(size(WaveForm_1I, 1), 4) = 0; % Differential measurement
    WaveForm_2Q = WaveForm_1Q;
    WaveForm_2Q(size(WaveForm_1I, 1), 4) = -pi/2; % Differential measurement
    WaveForm_2Length = WaveForm_1Length;
    WaveForm_2PointNum = WaveForm_2Length * gSG.AWGClockRate;
end


chaseFunctionPool('createWaveform', WaveForm_1I, gSG.AWGClockRate, WaveForm_1Length, 'XY8N_I_seg1.txt'); pause(0.5);
chaseFunctionPool('createWaveform', WaveForm_1Q, gSG.AWGClockRate, WaveForm_1Length, 'XY8N_Q_seg1.txt'); pause(0.5);
chaseFunctionPool('createWaveform', WaveForm_2I, gSG.AWGClockRate, WaveForm_2Length, 'XY8N_I_seg2.txt'); pause(0.5);
chaseFunctionPool('createWaveform', WaveForm_2Q, gSG.AWGClockRate, WaveForm_2Length, 'XY8N_Q_seg2.txt'); pause(0.5);

chaseFunctionPool('createSegStruct', 'XY8N_SegStruct_I.txt', ...
    'XY8N_I_seg1.txt', WaveForm_1PointNum, 1, 1, ...
    'XY8N_I_seg2.txt', WaveForm_2PointNum, 1, 1);
pause(0.5);
chaseFunctionPool('createSegStruct', 'XY8N_SegStruct_Q.txt', ...
    'XY8N_Q_seg1.txt', WaveForm_1PointNum, 1, 1, ...
    'XY8N_Q_seg2.txt', WaveForm_2PointNum, 1, 1);
pause(0.5);

%% Load waveform to AWG
chaseFunctionPool('CreateSegments', gmSEQ.MWAWG, 1, ...
    2, ...
    2047, 2047, 'XY8N_SegStruct_I.txt', 'false');
pause(1); % this pause seems to be important, otherwise the loading is not right occassionally
chaseFunctionPool('CreateSegments', gmSEQ.MWAWG, 2, ...
    2, ...
    2047, 2047, 'XY8N_SegStruct_Q.txt', 'false');
pause(1); % this pause seems to be important, otherwise the loading is not right occassionally
%% Run waveform
chaseFunctionPool('runChase', gmSEQ.MWAWG, 'false');
ApplyDelays();

function XY8N_debug
global gmSEQ gSG
gSG.bfixedPow=1;
gSG.bfixedFreq=1;
gSG.bMod='IQ';
gSG.bModSrc='External';

[gmSEQ.ScaleT, gmSEQ.ScaleStr] = GetScale(8*(gmSEQ.pi+gmSEQ.interval)*gmSEQ.To);

% TODO: add the definition for the pi and halfpi pulse AWG amp
% gSG.piAWGAmp = gmSEQ.SAmp1; % Just for temporary use
% gSG.halfpiAWGAmp = gmSEQ.SAmp2; % Just for temporary use
gSG.piAWGAmp = gSG.AWGAmp; 
gSG.halfpiAWGAmp = gSG.AWGAmp;

% gmSEQ.m here is the repetition number of XY8 block
gmSEQ.m = round(gmSEQ.m);

AfterPi = 2000;
AfterLaser = 0.2e6;
Wait_p = 10e3;
Detect_Window = 5000;

Cycle = (gmSEQ.interval + gmSEQ.pi)*8;
Sig_D_start = Wait_p+gmSEQ.readout+AfterLaser+gmSEQ.halfpi+Cycle*gmSEQ.m+gmSEQ.pi+AfterPi+Detect_Window+Wait_p;

gmSEQ.CHN(1).PBN=PBDictionary('ctr0');
gmSEQ.CHN(1).NRise=4;
gmSEQ.CHN(1).T=[Wait_p+gmSEQ.readout-1000-gmSEQ.CtrGateDur, ...
    Wait_p+gmSEQ.readout+AfterLaser+gmSEQ.halfpi+Cycle*gmSEQ.m+gmSEQ.pi+AfterPi, ...
    Sig_D_start+gmSEQ.readout-1000-gmSEQ.CtrGateDur, ... 
    Sig_D_start+gmSEQ.readout+AfterLaser+gmSEQ.halfpi+Cycle*gmSEQ.m+gmSEQ.pi+AfterPi];
if strcmp(gmSEQ.meas,'SPCM')
    gmSEQ.CHN(1).DT=[gmSEQ.CtrGateDur gmSEQ.CtrGateDur gmSEQ.CtrGateDur gmSEQ.CtrGateDur];
elseif strcmp(gmSEQ.meas,'APD')
    gmSEQ.CHN(1).DT=[1000 1000 1000 1000];
end

gmSEQ.CHN(numel(gmSEQ.CHN)+1).PBN=PBDictionary('AOM');
gmSEQ.CHN(numel(gmSEQ.CHN)).NRise=4;
gmSEQ.CHN(numel(gmSEQ.CHN)).T = [Wait_p, Wait_p+gmSEQ.readout+AfterLaser+gmSEQ.halfpi+Cycle*gmSEQ.m+gmSEQ.pi+AfterPi, ...
    Sig_D_start, Sig_D_start+gmSEQ.readout+AfterLaser+gmSEQ.halfpi+Cycle*gmSEQ.m+gmSEQ.pi+AfterPi];
gmSEQ.CHN(numel(gmSEQ.CHN)).DT = [gmSEQ.readout Detect_Window gmSEQ.readout Detect_Window];


gmSEQ.CHN(numel(gmSEQ.CHN)+1).PBN=PBDictionary('AWGTrig');
gmSEQ.CHN(numel(gmSEQ.CHN)).NRise=2;
gmSEQ.CHN(numel(gmSEQ.CHN)).T=[Wait_p+gmSEQ.readout+AfterLaser, ...
    Sig_D_start+gmSEQ.readout+AfterLaser];
gmSEQ.CHN(numel(gmSEQ.CHN)).DT=repelem(gmSEQ.halfpi+Cycle*gmSEQ.m+gmSEQ.pi+200, 2);


gmSEQ.CHN(numel(gmSEQ.CHN)+1).PBN=PBDictionary('MWSwitch');
if gmSEQ.m == 0
        gmSEQ.CHN(numel(gmSEQ.CHN)).NRise=2;
        gmSEQ.CHN(numel(gmSEQ.CHN)).T=[Wait_p+gmSEQ.readout+AfterLaser-20, Sig_D_start+gmSEQ.readout+AfterLaser-20];
        gmSEQ.CHN(numel(gmSEQ.CHN)).DT=[gmSEQ.halfpi+gmSEQ.pi+40, gmSEQ.halfpi+gmSEQ.pi+40];
else
    if gmSEQ.interval < 200
        gmSEQ.CHN(numel(gmSEQ.CHN)).NRise=2;
        gmSEQ.CHN(numel(gmSEQ.CHN)).T=[Wait_p+gmSEQ.readout+AfterLaser-20, Sig_D_start+gmSEQ.readout+AfterLaser-20];
        gmSEQ.CHN(numel(gmSEQ.CHN)).DT=[gmSEQ.halfpi+Cycle*gmSEQ.m+gmSEQ.pi+40, gmSEQ.halfpi+Cycle*gmSEQ.m+gmSEQ.pi+40];
    else
        gmSEQ.CHN(numel(gmSEQ.CHN)).NRise=2*(8*gmSEQ.m + 2);
        gmSEQ.CHN(numel(gmSEQ.CHN)).T = zeros(1, 2*(8*gmSEQ.m + 2));
        gmSEQ.CHN(numel(gmSEQ.CHN)).T(1) = Wait_p+gmSEQ.readout+AfterLaser-20;
        for i = 1:gmSEQ.m
            for j = 1:8
             gmSEQ.CHN(numel(gmSEQ.CHN)).T(1+(i-1)*8+j) = Wait_p+gmSEQ.readout+AfterLaser+gmSEQ.halfpi+gmSEQ.interval/2+(i-1+(j-1)/8)*Cycle-20;
            end
        end
        gmSEQ.CHN(numel(gmSEQ.CHN)).T(1+8*gmSEQ.m+1) = Wait_p+gmSEQ.readout+AfterLaser+gmSEQ.halfpi+gmSEQ.m*Cycle-20;
        gmSEQ.CHN(numel(gmSEQ.CHN)).T(1+8*gmSEQ.m+2) = Sig_D_start+gmSEQ.readout+AfterLaser-20;
        for i = 1:gmSEQ.m
            for j = 1:8
             gmSEQ.CHN(numel(gmSEQ.CHN)).T(3+8*gmSEQ.m+(i-1)*8+j) = Sig_D_start+gmSEQ.readout+AfterLaser+gmSEQ.halfpi+gmSEQ.interval/2+(i-1+(j-1)/8)*Cycle-20;
            end
        end
        gmSEQ.CHN(numel(gmSEQ.CHN)).T(3+16*gmSEQ.m+1) = Sig_D_start+gmSEQ.readout+AfterLaser+gmSEQ.halfpi+gmSEQ.m*Cycle-20;
        gmSEQ.CHN(numel(gmSEQ.CHN)).DT=[gmSEQ.halfpi+40, repelem(gmSEQ.pi+40, 8*gmSEQ.m), gmSEQ.pi+40, ... 
            gmSEQ.halfpi+40, repelem(gmSEQ.pi+40, 8*gmSEQ.m), gmSEQ.pi+40];
    end
end

gmSEQ.CHN(numel(gmSEQ.CHN)+1).PBN=PBDictionary('dummy1');
gmSEQ.CHN(numel(gmSEQ.CHN)).NRise=2;
gmSEQ.CHN(numel(gmSEQ.CHN)).T=[0 2*(Sig_D_start-Wait_p)-50];
gmSEQ.CHN(numel(gmSEQ.CHN)).DT=[50 50];

%% AWG
% Initialization
chaseFunctionPool('stopChase',  gmSEQ.MWAWG)

% This part need to be modified to accomodate the DC modulation
if ~gSG.ACmodAWG % in AC modulation mode
    gSG.AWGFreq = 0;
end

WaveForm_1I = zeros(2 + 8*gmSEQ.m, 5);
WaveForm_1I(1, :) = [0 gmSEQ.halfpi gSG.AWGFreq 0 0];
for i = 1:gmSEQ.m
    WaveForm_1I(1 + (i-1)*8 + 1, :) = [gmSEQ.halfpi+gmSEQ.interval/2+(i-1+0/8)*Cycle gmSEQ.halfpi+gmSEQ.interval/2+(i-1+0/8)*Cycle+gmSEQ.pi gSG.AWGFreq 0 gSG.piAWGAmp]; % pi_x
    WaveForm_1I(1 + (i-1)*8 + 2, :) = [gmSEQ.halfpi+gmSEQ.interval/2+(i-1+1/8)*Cycle gmSEQ.halfpi+gmSEQ.interval/2+(i-1+1/8)*Cycle+gmSEQ.pi gSG.AWGFreq pi/2 gSG.piAWGAmp]; % pi_y
    WaveForm_1I(1 + (i-1)*8 + 3, :) = [gmSEQ.halfpi+gmSEQ.interval/2+(i-1+2/8)*Cycle gmSEQ.halfpi+gmSEQ.interval/2+(i-1+2/8)*Cycle+gmSEQ.pi gSG.AWGFreq 0 gSG.piAWGAmp]; % pi_x
    WaveForm_1I(1 + (i-1)*8 + 4, :) = [gmSEQ.halfpi+gmSEQ.interval/2+(i-1+3/8)*Cycle gmSEQ.halfpi+gmSEQ.interval/2+(i-1+3/8)*Cycle+gmSEQ.pi gSG.AWGFreq pi/2 gSG.piAWGAmp]; % pi_y
    WaveForm_1I(1 + (i-1)*8 + 5, :) = [gmSEQ.halfpi+gmSEQ.interval/2+(i-1+4/8)*Cycle gmSEQ.halfpi+gmSEQ.interval/2+(i-1+4/8)*Cycle+gmSEQ.pi gSG.AWGFreq pi/2 gSG.piAWGAmp]; % pi_y
    WaveForm_1I(1 + (i-1)*8 + 6, :) = [gmSEQ.halfpi+gmSEQ.interval/2+(i-1+5/8)*Cycle gmSEQ.halfpi+gmSEQ.interval/2+(i-1+5/8)*Cycle+gmSEQ.pi gSG.AWGFreq 0 gSG.piAWGAmp]; % pi_x
    WaveForm_1I(1 + (i-1)*8 + 7, :) = [gmSEQ.halfpi+gmSEQ.interval/2+(i-1+6/8)*Cycle gmSEQ.halfpi+gmSEQ.interval/2+(i-1+6/8)*Cycle+gmSEQ.pi gSG.AWGFreq pi/2 gSG.piAWGAmp]; % pi_y
    WaveForm_1I(1 + (i-1)*8 + 8, :) = [gmSEQ.halfpi+gmSEQ.interval/2+(i-1+7/8)*Cycle gmSEQ.halfpi+gmSEQ.interval/2+(i-1+7/8)*Cycle+gmSEQ.pi gSG.AWGFreq 0 gSG.piAWGAmp]; % pi_x
end
WaveForm_1I(2 + 8*gmSEQ.m, :) = [gmSEQ.halfpi+gmSEQ.m*Cycle gmSEQ.halfpi+gmSEQ.m*Cycle+gmSEQ.pi gSG.AWGFreq 0 0];
% WaveForm_1I(2 + 8*gmSEQ.m, :) = [gmSEQ.halfpi+gmSEQ.m*Cycle gmSEQ.halfpi+gmSEQ.m*Cycle+gmSEQ.halfpi gSG.AWGFreq pi 0];

WaveForm_1Q = WaveForm_1I - repmat([0 0 0 pi/2 0], size(WaveForm_1I, 1), 1);
WaveForm_1Length = ceil((gmSEQ.halfpi+gmSEQ.m*Cycle+gmSEQ.pi+1000) / (16 / gSG.AWGClockRate)) ...
    *(16 / gSG.AWGClockRate);
WaveForm_1PointNum = WaveForm_1Length * gSG.AWGClockRate;

WaveForm_2I = WaveForm_1I;
WaveForm_2I(size(WaveForm_1I, 1), 5) = gSG.piAWGAmp; % Differential measurement
WaveForm_2Q = WaveForm_1Q;
WaveForm_2Q(size(WaveForm_1Q, 1), 5) = gSG.piAWGAmp; % Differential measurement
WaveForm_2Length = WaveForm_1Length;
WaveForm_2PointNum = WaveForm_2Length * gSG.AWGClockRate;

bGaussian = false;
if bGaussian
    sigma = 3;
    WaveForm_1I(:,6) = sigma;
    WaveForm_1Q(:,6) = sigma;
    WaveForm_2I(:,6) = sigma;
    WaveForm_2Q(:,6) = sigma;    
    disp("Generating Gaussian pulses")
end

chaseFunctionPool('createWaveform', WaveForm_1I, gSG.AWGClockRate, WaveForm_1Length, 'XY8N_I_seg1.txt'); pause(0.5);
chaseFunctionPool('createWaveform', WaveForm_1Q, gSG.AWGClockRate, WaveForm_1Length, 'XY8N_Q_seg1.txt'); pause(0.5);
chaseFunctionPool('createWaveform', WaveForm_2I, gSG.AWGClockRate, WaveForm_2Length, 'XY8N_I_seg2.txt'); pause(0.5);
chaseFunctionPool('createWaveform', WaveForm_2Q, gSG.AWGClockRate, WaveForm_2Length, 'XY8N_Q_seg2.txt'); pause(0.5);

chaseFunctionPool('createSegStruct', 'XY8N_SegStruct_I.txt', ...
    'XY8N_I_seg1.txt', WaveForm_1PointNum, 1, 1, ...
    'XY8N_I_seg2.txt', WaveForm_2PointNum, 1, 1);
pause(0.5);
chaseFunctionPool('createSegStruct', 'XY8N_SegStruct_Q.txt', ...
    'XY8N_Q_seg1.txt', WaveForm_1PointNum, 1, 1, ...
    'XY8N_Q_seg2.txt', WaveForm_2PointNum, 1, 1);
pause(0.5);

%% Load waveform to AWG
chaseFunctionPool('CreateSegments', gmSEQ.MWAWG, 1, ...
    2, ...
    2047, 2047, 'XY8N_SegStruct_I.txt', 'false');
pause(1); % this pause seems to be important, otherwise the loading is not right occassionally
chaseFunctionPool('CreateSegments', gmSEQ.MWAWG, 2, ...
    2, ...
    2047, 2047, 'XY8N_SegStruct_Q.txt', 'false');
pause(1); % this pause seems to be important, otherwise the loading is not right occassionally
%% Run waveform
chaseFunctionPool('runChase', gmSEQ.MWAWG, 'false');
ApplyDelays();

function XY8N_HR
global gmSEQ gSG
gSG.bfixedPow=1;
gSG.bfixedFreq=1;
gSG.bMod='IQ';
gSG.bModSrc='External';

[gmSEQ.ScaleT, gmSEQ.ScaleStr] = GetScale(8*(gmSEQ.pi+gmSEQ.interval)*gmSEQ.To);
gmSEQ.HRhalfpi = gmSEQ.SLockT1;
gSG.HRAWGAmp = gmSEQ.SAmp1;

gSG.piAWGAmp = gSG.AWGAmp; 
gSG.halfpiAWGAmp = gSG.AWGAmp;

% gmSEQ.m here is the repetition number of XY8 block
gmSEQ.m = round(gmSEQ.m);

AfterPi = 2000;
AfterLaser = 0.1e6;
Wait_p = 10e3;
Detect_Window = 5000;

Cycle = (gmSEQ.interval + gmSEQ.pi)*8;
Sig_D_start = Wait_p+gmSEQ.readout+AfterLaser+gmSEQ.halfpi+Cycle*gmSEQ.m+gmSEQ.HRhalfpi+AfterPi+Detect_Window+Wait_p;

gmSEQ.CHN(1).PBN=PBDictionary('ctr0');
gmSEQ.CHN(1).NRise=4;
gmSEQ.CHN(1).T=[Wait_p+gmSEQ.readout-1000-gmSEQ.CtrGateDur, ...
    Wait_p+gmSEQ.readout+AfterLaser+gmSEQ.halfpi+Cycle*gmSEQ.m+gmSEQ.HRhalfpi+AfterPi, ...
    Sig_D_start+gmSEQ.readout-1000-gmSEQ.CtrGateDur, ... 
    Sig_D_start+gmSEQ.readout+AfterLaser+gmSEQ.halfpi+Cycle*gmSEQ.m+gmSEQ.HRhalfpi+AfterPi];
if strcmp(gmSEQ.meas,'SPCM')
    gmSEQ.CHN(1).DT=[gmSEQ.CtrGateDur gmSEQ.CtrGateDur gmSEQ.CtrGateDur gmSEQ.CtrGateDur];
elseif strcmp(gmSEQ.meas,'APD')
    gmSEQ.CHN(1).DT=[1000 1000 1000 1000];
end

gmSEQ.CHN(numel(gmSEQ.CHN)+1).PBN=PBDictionary('AOM');
gmSEQ.CHN(numel(gmSEQ.CHN)).NRise=4;
gmSEQ.CHN(numel(gmSEQ.CHN)).T = [Wait_p, Wait_p+gmSEQ.readout+AfterLaser+gmSEQ.halfpi+Cycle*gmSEQ.m+gmSEQ.HRhalfpi+AfterPi, ...
    Sig_D_start, Sig_D_start+gmSEQ.readout+AfterLaser+gmSEQ.halfpi+Cycle*gmSEQ.m+gmSEQ.HRhalfpi+AfterPi];
gmSEQ.CHN(numel(gmSEQ.CHN)).DT = [gmSEQ.readout Detect_Window gmSEQ.readout Detect_Window];


gmSEQ.CHN(numel(gmSEQ.CHN)+1).PBN=PBDictionary('AWGTrig');
gmSEQ.CHN(numel(gmSEQ.CHN)).NRise=2;
gmSEQ.CHN(numel(gmSEQ.CHN)).T=[Wait_p+gmSEQ.readout+AfterLaser, ...
    Sig_D_start+gmSEQ.readout+AfterLaser];
gmSEQ.CHN(numel(gmSEQ.CHN)).DT=repelem(gmSEQ.halfpi+Cycle*gmSEQ.m+gmSEQ.HRhalfpi+200, 2);


gmSEQ.CHN(numel(gmSEQ.CHN)+1).PBN=PBDictionary('MWSwitch');
if gmSEQ.m == 0
        gmSEQ.CHN(numel(gmSEQ.CHN)).NRise=2;
        gmSEQ.CHN(numel(gmSEQ.CHN)).T=[Wait_p+gmSEQ.readout+AfterLaser-20, Sig_D_start+gmSEQ.readout+AfterLaser-20];
        gmSEQ.CHN(numel(gmSEQ.CHN)).DT=[gmSEQ.halfpi+gmSEQ.HRhalfpi+40, gmSEQ.halfpi+gmSEQ.HRhalfpi+40];
else
    if gmSEQ.interval < 400
        gmSEQ.CHN(numel(gmSEQ.CHN)).NRise=2;
        gmSEQ.CHN(numel(gmSEQ.CHN)).T=[Wait_p+gmSEQ.readout+AfterLaser-20, Sig_D_start+gmSEQ.readout+AfterLaser-20];
        gmSEQ.CHN(numel(gmSEQ.CHN)).DT=[gmSEQ.halfpi+Cycle*gmSEQ.m+gmSEQ.HRhalfpi+40, gmSEQ.halfpi+Cycle*gmSEQ.m+gmSEQ.HRhalfpi+40];
    else
        gmSEQ.CHN(numel(gmSEQ.CHN)).NRise=2*(8*gmSEQ.m + 2);
        gmSEQ.CHN(numel(gmSEQ.CHN)).T = zeros(1, 2*(8*gmSEQ.m + 2));
        gmSEQ.CHN(numel(gmSEQ.CHN)).T(1) = Wait_p+gmSEQ.readout+AfterLaser-20;
        for i = 1:gmSEQ.m
            for j = 1:8
             gmSEQ.CHN(numel(gmSEQ.CHN)).T(1+(i-1)*8+j) = Wait_p+gmSEQ.readout+AfterLaser+gmSEQ.halfpi+gmSEQ.interval/2+(i-1+(j-1)/8)*Cycle-20;
            end
        end
        gmSEQ.CHN(numel(gmSEQ.CHN)).T(1+8*gmSEQ.m+1) = Wait_p+gmSEQ.readout+AfterLaser+gmSEQ.halfpi+gmSEQ.m*Cycle-20;
        gmSEQ.CHN(numel(gmSEQ.CHN)).T(1+8*gmSEQ.m+2) = Sig_D_start+gmSEQ.readout+AfterLaser-20;
        for i = 1:gmSEQ.m
            for j = 1:8
             gmSEQ.CHN(numel(gmSEQ.CHN)).T(3+8*gmSEQ.m+(i-1)*8+j) = Sig_D_start+gmSEQ.readout+AfterLaser+gmSEQ.halfpi+gmSEQ.interval/2+(i-1+(j-1)/8)*Cycle-20;
            end
        end
        gmSEQ.CHN(numel(gmSEQ.CHN)).T(3+16*gmSEQ.m+1) = Sig_D_start+gmSEQ.readout+AfterLaser+gmSEQ.halfpi+gmSEQ.m*Cycle-20;
        gmSEQ.CHN(numel(gmSEQ.CHN)).DT=[gmSEQ.halfpi+40, repelem(gmSEQ.pi+40, 8*gmSEQ.m), gmSEQ.HRhalfpi+40, ... 
            gmSEQ.halfpi+40, repelem(gmSEQ.pi+40, 8*gmSEQ.m), gmSEQ.HRhalfpi+40];
    end
end

gmSEQ.CHN(numel(gmSEQ.CHN)+1).PBN=PBDictionary('dummy1');
gmSEQ.CHN(numel(gmSEQ.CHN)).NRise=2;
gmSEQ.CHN(numel(gmSEQ.CHN)).T=[0 Sig_D_start+gmSEQ.readout+AfterLaser+gmSEQ.halfpi+gmSEQ.m*Cycle+gmSEQ.HRhalfpi+AfterPi+Detect_Window-50];
gmSEQ.CHN(numel(gmSEQ.CHN)).DT=[50 50];

%% AWG
% Initialization
chaseFunctionPool('stopChase',  gmSEQ.MWAWG)

% This part need to be modified to accomodate the DC modulation
if gSG.ACmodAWG % in AC modulation mode
    gSG.AWGFreq = gSG.AWGFreq;
else
    gSG.AWGFreq = 0;
end

WaveForm_1I = zeros(2 + 8*gmSEQ.m, 5);
WaveForm_1I(1, :) = [0 gmSEQ.halfpi gSG.AWGFreq 0 gSG.halfpiAWGAmp];
for i = 1:gmSEQ.m
    WaveForm_1I(1 + (i-1)*8 + 1, :) = [gmSEQ.halfpi+gmSEQ.interval/2+(i-1+0/8)*Cycle gmSEQ.halfpi+gmSEQ.interval/2+(i-1+0/8)*Cycle+gmSEQ.pi gSG.AWGFreq 0 gSG.piAWGAmp]; % pi_x
    WaveForm_1I(1 + (i-1)*8 + 2, :) = [gmSEQ.halfpi+gmSEQ.interval/2+(i-1+1/8)*Cycle gmSEQ.halfpi+gmSEQ.interval/2+(i-1+1/8)*Cycle+gmSEQ.pi gSG.AWGFreq pi/2 gSG.piAWGAmp]; % pi_y
    WaveForm_1I(1 + (i-1)*8 + 3, :) = [gmSEQ.halfpi+gmSEQ.interval/2+(i-1+2/8)*Cycle gmSEQ.halfpi+gmSEQ.interval/2+(i-1+2/8)*Cycle+gmSEQ.pi gSG.AWGFreq 0 gSG.piAWGAmp]; % pi_x
    WaveForm_1I(1 + (i-1)*8 + 4, :) = [gmSEQ.halfpi+gmSEQ.interval/2+(i-1+3/8)*Cycle gmSEQ.halfpi+gmSEQ.interval/2+(i-1+3/8)*Cycle+gmSEQ.pi gSG.AWGFreq pi/2 gSG.piAWGAmp]; % pi_y
    WaveForm_1I(1 + (i-1)*8 + 5, :) = [gmSEQ.halfpi+gmSEQ.interval/2+(i-1+4/8)*Cycle gmSEQ.halfpi+gmSEQ.interval/2+(i-1+4/8)*Cycle+gmSEQ.pi gSG.AWGFreq pi/2 gSG.piAWGAmp]; % pi_y
    WaveForm_1I(1 + (i-1)*8 + 6, :) = [gmSEQ.halfpi+gmSEQ.interval/2+(i-1+5/8)*Cycle gmSEQ.halfpi+gmSEQ.interval/2+(i-1+5/8)*Cycle+gmSEQ.pi gSG.AWGFreq 0 gSG.piAWGAmp]; % pi_x
    WaveForm_1I(1 + (i-1)*8 + 7, :) = [gmSEQ.halfpi+gmSEQ.interval/2+(i-1+6/8)*Cycle gmSEQ.halfpi+gmSEQ.interval/2+(i-1+6/8)*Cycle+gmSEQ.pi gSG.AWGFreq pi/2 gSG.piAWGAmp]; % pi_y
    WaveForm_1I(1 + (i-1)*8 + 8, :) = [gmSEQ.halfpi+gmSEQ.interval/2+(i-1+7/8)*Cycle gmSEQ.halfpi+gmSEQ.interval/2+(i-1+7/8)*Cycle+gmSEQ.pi gSG.AWGFreq 0 gSG.piAWGAmp]; % pi_x
end
WaveForm_1I(2 + 8*gmSEQ.m, :) = [gmSEQ.halfpi+gmSEQ.m*Cycle gmSEQ.halfpi+gmSEQ.m*Cycle+gmSEQ.HRhalfpi gSG.AWGFreq pi gSG.HRAWGAmp];

WaveForm_1Q = WaveForm_1I - repmat([0 0 0 pi/2 0], size(WaveForm_1I, 1), 1);
WaveForm_1Length = ceil((gmSEQ.halfpi+gmSEQ.m*Cycle+gmSEQ.HRhalfpi+1000) / (16 / gSG.AWGClockRate)) ...
    *(16 / gSG.AWGClockRate);
WaveForm_1PointNum = WaveForm_1Length * gSG.AWGClockRate;

WaveForm_2I = WaveForm_1I;
WaveForm_2I(size(WaveForm_1I, 1), 4) = 0; % Differential measurement
WaveForm_2Q = WaveForm_1Q;
WaveForm_2Q(size(WaveForm_1I, 1), 4) = -pi/2; % Differential measurement
WaveForm_2Length = WaveForm_1Length;
WaveForm_2PointNum = WaveForm_2Length * gSG.AWGClockRate;

chaseFunctionPool('createWaveform', WaveForm_1I, gSG.AWGClockRate, WaveForm_1Length, 'XY8N_I_seg1.txt'); pause(0.5);
chaseFunctionPool('createWaveform', WaveForm_1Q, gSG.AWGClockRate, WaveForm_1Length, 'XY8N_Q_seg1.txt'); pause(0.5);
chaseFunctionPool('createWaveform', WaveForm_2I, gSG.AWGClockRate, WaveForm_2Length, 'XY8N_I_seg2.txt'); pause(0.5);
chaseFunctionPool('createWaveform', WaveForm_2Q, gSG.AWGClockRate, WaveForm_2Length, 'XY8N_Q_seg2.txt'); pause(0.5);

chaseFunctionPool('createSegStruct', 'XY8N_SegStruct_I.txt', ...
    'XY8N_I_seg1.txt', WaveForm_1PointNum, 1, 1, ...
    'XY8N_I_seg2.txt', WaveForm_2PointNum, 1, 1);
pause(0.5);
chaseFunctionPool('createSegStruct', 'XY8N_SegStruct_Q.txt', ...
    'XY8N_Q_seg1.txt', WaveForm_1PointNum, 1, 1, ...
    'XY8N_Q_seg2.txt', WaveForm_2PointNum, 1, 1);
pause(0.5);

%% Load waveform to AWG
chaseFunctionPool('CreateSegments', gmSEQ.MWAWG, 1, ...
    2, ...
    2047, 2047, 'XY8N_SegStruct_I.txt', 'false');
pause(1); % this pause seems to be important, otherwise the loading is not right occassionally
chaseFunctionPool('CreateSegments', gmSEQ.MWAWG, 2, ...
    2, ...
    2047, 2047, 'XY8N_SegStruct_Q.txt', 'false');
pause(1); % this pause seems to be important, otherwise the loading is not right occassionally
%% Run waveform
chaseFunctionPool('runChase', gmSEQ.MWAWG, 'false');
ApplyDelays();

function XY8N_TuneDensity
global gmSEQ gSG gSG3
gSG.bfixedPow=1;
gSG.bfixedFreq=1;
gSG.bMod='IQ';
gSG.bModSrc='External';

gSG3.bMod='IQ';
gSG3.bModSrc='External';
SignalGeneratorFunctionPool3('SetMod');
SignalGeneratorFunctionPool3('WritePow');
SignalGeneratorFunctionPool3('WriteFreq');
gSG3.bOn=1; SignalGeneratorFunctionPool3('RFOnOff');

[gmSEQ.ScaleT, gmSEQ.ScaleStr] = GetScale(8*(gmSEQ.pi+gmSEQ.interval)*gmSEQ.To);

% TODO: add the definition for the pi and halfpi pulse AWG amp
% gSG.piAWGAmp = gmSEQ.SAmp1; % Just for temporary use
% gSG.halfpiAWGAmp = gmSEQ.SAmp2; % Just for temporary use
gSG.piAWGAmp = gSG.AWGAmp; 
gSG.halfpiAWGAmp = gSG.AWGAmp;

% gmSEQ.m here is the repetition number of XY8 block
gmSEQ.m = round(gmSEQ.m);

AfterPi = 2000;
AfterLaser = 0.2e6;
T_Depol = 10e3;
Wait_p = 10e3;
Detect_Window = 5000;

Cycle = (gmSEQ.interval + gmSEQ.pi)*8;
Sig_D_start = Wait_p+gmSEQ.readout+AfterLaser+gmSEQ.DEERt+T_Depol+gmSEQ.halfpi+Cycle*gmSEQ.m+gmSEQ.halfpi+AfterPi+Detect_Window+Wait_p;

gmSEQ.CHN(1).PBN=PBDictionary('ctr0');
gmSEQ.CHN(1).NRise=4;
gmSEQ.CHN(1).T=[Wait_p+gmSEQ.readout-1000-gmSEQ.CtrGateDur, ...
    Wait_p+gmSEQ.readout+AfterLaser+gmSEQ.DEERt+T_Depol+gmSEQ.halfpi+Cycle*gmSEQ.m+gmSEQ.halfpi+AfterPi, ...
    Sig_D_start+gmSEQ.readout-1000-gmSEQ.CtrGateDur, ... 
    Sig_D_start+gmSEQ.readout+AfterLaser+gmSEQ.DEERt+T_Depol+gmSEQ.halfpi+Cycle*gmSEQ.m+gmSEQ.halfpi+AfterPi];
if strcmp(gmSEQ.meas,'SPCM')
    gmSEQ.CHN(1).DT=[gmSEQ.CtrGateDur gmSEQ.CtrGateDur gmSEQ.CtrGateDur gmSEQ.CtrGateDur];
elseif strcmp(gmSEQ.meas,'APD')
    gmSEQ.CHN(1).DT=[1000 1000 1000 1000];
end

gmSEQ.CHN(numel(gmSEQ.CHN)+1).PBN=PBDictionary('AOM');
gmSEQ.CHN(numel(gmSEQ.CHN)).NRise=4;
gmSEQ.CHN(numel(gmSEQ.CHN)).T = [Wait_p, Wait_p+gmSEQ.readout+AfterLaser+gmSEQ.DEERt+T_Depol+gmSEQ.halfpi+Cycle*gmSEQ.m+gmSEQ.halfpi+AfterPi, ...
    Sig_D_start, Sig_D_start+gmSEQ.readout+AfterLaser+gmSEQ.DEERt+T_Depol+gmSEQ.halfpi+Cycle*gmSEQ.m+gmSEQ.halfpi+AfterPi];
gmSEQ.CHN(numel(gmSEQ.CHN)).DT = [gmSEQ.readout Detect_Window gmSEQ.readout Detect_Window];

gmSEQ.CHN(numel(gmSEQ.CHN) + 1).PBN = PBDictionary('AWGTrig3');
gmSEQ.CHN(numel(gmSEQ.CHN)).NRise = 2;
gmSEQ.CHN(numel(gmSEQ.CHN)).T = [Wait_p+gmSEQ.readout + AfterLaser, Sig_D_start+gmSEQ.readout + AfterLaser];
gmSEQ.CHN(numel(gmSEQ.CHN)).DT = repelem(1000, 2);

gmSEQ.CHN(numel(gmSEQ.CHN) + 1).PBN = PBDictionary('MWSwitch3');
gmSEQ.CHN(numel(gmSEQ.CHN)).NRise = 2;
gmSEQ.CHN(numel(gmSEQ.CHN)).T = [Wait_p+gmSEQ.readout + AfterLaser - 20, Sig_D_start+gmSEQ.readout + AfterLaser- 20];
gmSEQ.CHN(numel(gmSEQ.CHN)).DT = repelem(gmSEQ.DEERt + 40, 2);

gmSEQ.CHN(numel(gmSEQ.CHN)+1).PBN=PBDictionary('AWGTrig');
gmSEQ.CHN(numel(gmSEQ.CHN)).NRise=2;
gmSEQ.CHN(numel(gmSEQ.CHN)).T=[Wait_p+gmSEQ.readout+AfterLaser+gmSEQ.DEERt+T_Depol, ...
    Sig_D_start+gmSEQ.readout+AfterLaser+gmSEQ.DEERt+T_Depol];
gmSEQ.CHN(numel(gmSEQ.CHN)).DT=repelem(gmSEQ.halfpi+Cycle*gmSEQ.m+gmSEQ.halfpi+200, 2);


gmSEQ.CHN(numel(gmSEQ.CHN)+1).PBN=PBDictionary('MWSwitch');
if gmSEQ.m == 0
        gmSEQ.CHN(numel(gmSEQ.CHN)).NRise=2;
        gmSEQ.CHN(numel(gmSEQ.CHN)).T=[Wait_p+gmSEQ.readout+AfterLaser+gmSEQ.DEERt+T_Depol-20, Sig_D_start+gmSEQ.readout+AfterLaser+gmSEQ.DEERt+T_Depol-20];
        gmSEQ.CHN(numel(gmSEQ.CHN)).DT=[gmSEQ.halfpi+gmSEQ.halfpi+100, gmSEQ.halfpi+gmSEQ.halfpi+100];
else
    if gmSEQ.interval < 400
        gmSEQ.CHN(numel(gmSEQ.CHN)).NRise=2;
        gmSEQ.CHN(numel(gmSEQ.CHN)).T=[Wait_p+gmSEQ.readout+AfterLaser+gmSEQ.DEERt+T_Depol-20, Sig_D_start+gmSEQ.readout+AfterLaser+gmSEQ.DEERt+T_Depol-20];
        gmSEQ.CHN(numel(gmSEQ.CHN)).DT=[gmSEQ.halfpi+Cycle*gmSEQ.m+gmSEQ.halfpi+40, gmSEQ.halfpi+Cycle*gmSEQ.m+gmSEQ.halfpi+40];
    else
        gmSEQ.CHN(numel(gmSEQ.CHN)).NRise=2*(8*gmSEQ.m + 2);
        gmSEQ.CHN(numel(gmSEQ.CHN)).T = zeros(1, 2*(8*gmSEQ.m + 2));
        gmSEQ.CHN(numel(gmSEQ.CHN)).T(1) = Wait_p+gmSEQ.readout+AfterLaser+gmSEQ.DEERt+T_Depol-20;
        for i = 1:gmSEQ.m
            for j = 1:8
             gmSEQ.CHN(numel(gmSEQ.CHN)).T(1+(i-1)*8+j) = Wait_p+gmSEQ.readout+AfterLaser+gmSEQ.DEERt+T_Depol+gmSEQ.halfpi+gmSEQ.interval/2+(i-1+(j-1)/8)*Cycle-20;
            end
        end
        gmSEQ.CHN(numel(gmSEQ.CHN)).T(1+8*gmSEQ.m+1) = Wait_p+gmSEQ.readout+AfterLaser+gmSEQ.DEERt+T_Depol+gmSEQ.halfpi+gmSEQ.m*Cycle-20;
        gmSEQ.CHN(numel(gmSEQ.CHN)).T(1+8*gmSEQ.m+2) = Sig_D_start+gmSEQ.readout+AfterLaser+gmSEQ.DEERt+T_Depol-20;
        for i = 1:gmSEQ.m
            for j = 1:8
             gmSEQ.CHN(numel(gmSEQ.CHN)).T(3+8*gmSEQ.m+(i-1)*8+j) = Sig_D_start+gmSEQ.readout+AfterLaser+gmSEQ.DEERt+T_Depol+gmSEQ.halfpi+gmSEQ.interval/2+(i-1+(j-1)/8)*Cycle-20;
            end
        end
        gmSEQ.CHN(numel(gmSEQ.CHN)).T(3+16*gmSEQ.m+1) = Sig_D_start+gmSEQ.readout+AfterLaser+gmSEQ.DEERt+T_Depol+gmSEQ.halfpi+gmSEQ.m*Cycle-20;
        gmSEQ.CHN(numel(gmSEQ.CHN)).DT=[gmSEQ.halfpi+40, repelem(gmSEQ.pi+40, 8*gmSEQ.m), gmSEQ.halfpi+40, ... 
            gmSEQ.halfpi+40, repelem(gmSEQ.pi+40, 8*gmSEQ.m), gmSEQ.halfpi+40];
    end
end

gmSEQ.CHN(numel(gmSEQ.CHN)+1).PBN=PBDictionary('dummy1');
gmSEQ.CHN(numel(gmSEQ.CHN)).NRise=2;
gmSEQ.CHN(numel(gmSEQ.CHN)).T=[0 2*(Sig_D_start-Wait_p)-50];
gmSEQ.CHN(numel(gmSEQ.CHN)).DT=[50 50];

%% AWG
% Initialization
chaseFunctionPool('stopChase',  gmSEQ.MWAWG)
chaseFunctionPool('stopChase',  gmSEQ.MWAWG2)

% This part need to be modified to accomodate the DC modulation
if ~gSG.ACmodAWG % in AC modulation mode
    gSG.AWGFreq = 0;
    gSG3.AWGFreq = 0;
end

if gmSEQ.m == 0
   % WaveForm_1I = [0 gmSEQ.halfpi*2 gSG.AWGFreq 0 0];
     WaveForm_1I = [0 gmSEQ.halfpi gSG.AWGFreq 0 gSG.halfpiAWGAmp; ...
         gmSEQ.halfpi+0 2*gmSEQ.halfpi+0 gSG.AWGFreq pi gSG.halfpiAWGAmp];
else
    WaveForm_1I = zeros(2 + 8*gmSEQ.m, 5);
    WaveForm_1I(1, :) = [0 gmSEQ.halfpi gSG.AWGFreq 0 gSG.halfpiAWGAmp];
    for i = 1:gmSEQ.m
        WaveForm_1I(1 + (i-1)*8 + 1, :) = [gmSEQ.halfpi+gmSEQ.interval/2+(i-1+0/8)*Cycle gmSEQ.halfpi+gmSEQ.interval/2+(i-1+0/8)*Cycle+gmSEQ.pi gSG.AWGFreq 0 gSG.piAWGAmp]; % pi_x
        WaveForm_1I(1 + (i-1)*8 + 2, :) = [gmSEQ.halfpi+gmSEQ.interval/2+(i-1+1/8)*Cycle gmSEQ.halfpi+gmSEQ.interval/2+(i-1+1/8)*Cycle+gmSEQ.pi gSG.AWGFreq pi/2 gSG.piAWGAmp]; % pi_y
        WaveForm_1I(1 + (i-1)*8 + 3, :) = [gmSEQ.halfpi+gmSEQ.interval/2+(i-1+2/8)*Cycle gmSEQ.halfpi+gmSEQ.interval/2+(i-1+2/8)*Cycle+gmSEQ.pi gSG.AWGFreq 0 gSG.piAWGAmp]; % pi_x
        WaveForm_1I(1 + (i-1)*8 + 4, :) = [gmSEQ.halfpi+gmSEQ.interval/2+(i-1+3/8)*Cycle gmSEQ.halfpi+gmSEQ.interval/2+(i-1+3/8)*Cycle+gmSEQ.pi gSG.AWGFreq pi/2 gSG.piAWGAmp]; % pi_y
        WaveForm_1I(1 + (i-1)*8 + 5, :) = [gmSEQ.halfpi+gmSEQ.interval/2+(i-1+4/8)*Cycle gmSEQ.halfpi+gmSEQ.interval/2+(i-1+4/8)*Cycle+gmSEQ.pi gSG.AWGFreq pi/2 gSG.piAWGAmp]; % pi_y
        WaveForm_1I(1 + (i-1)*8 + 6, :) = [gmSEQ.halfpi+gmSEQ.interval/2+(i-1+5/8)*Cycle gmSEQ.halfpi+gmSEQ.interval/2+(i-1+5/8)*Cycle+gmSEQ.pi gSG.AWGFreq 0 gSG.piAWGAmp]; % pi_x
        WaveForm_1I(1 + (i-1)*8 + 7, :) = [gmSEQ.halfpi+gmSEQ.interval/2+(i-1+6/8)*Cycle gmSEQ.halfpi+gmSEQ.interval/2+(i-1+6/8)*Cycle+gmSEQ.pi gSG.AWGFreq pi/2 gSG.piAWGAmp]; % pi_y
        WaveForm_1I(1 + (i-1)*8 + 8, :) = [gmSEQ.halfpi+gmSEQ.interval/2+(i-1+7/8)*Cycle gmSEQ.halfpi+gmSEQ.interval/2+(i-1+7/8)*Cycle+gmSEQ.pi gSG.AWGFreq 0 gSG.piAWGAmp]; % pi_x
    end
    WaveForm_1I(2 + 8*gmSEQ.m, :) = [gmSEQ.halfpi+gmSEQ.m*Cycle gmSEQ.halfpi+gmSEQ.m*Cycle+gmSEQ.halfpi gSG.AWGFreq pi gSG.halfpiAWGAmp];
    % WaveForm_1I(2 + 8*gmSEQ.m, :) = [gmSEQ.halfpi+gmSEQ.m*Cycle gmSEQ.halfpi+gmSEQ.m*Cycle+gmSEQ.halfpi gSG.AWGFreq pi 0];
end
WaveForm_1Q = WaveForm_1I - repmat([0 0 0 pi/2 0], size(WaveForm_1I, 1), 1);
WaveForm_1Length = ceil((gmSEQ.halfpi+gmSEQ.m*Cycle+gmSEQ.halfpi+1000) / (16 / gSG.AWGClockRate)) ...
    *(16 / gSG.AWGClockRate);
WaveForm_1PointNum = WaveForm_1Length * gSG.AWGClockRate;

if gmSEQ.m == 0
    WaveForm_2I = [0 gmSEQ.halfpi*2 gSG.AWGFreq 0 gSG.halfpiAWGAmp];
    WaveForm_2Q = WaveForm_2I - repmat([0 0 0 pi/2 0], size(WaveForm_2I, 1), 1);
    WaveForm_2Length = ceil((gmSEQ.halfpi+gmSEQ.halfpi+1000) / (16 / gSG.AWGClockRate)) * (16 / gSG.AWGClockRate);
    WaveForm_2PointNum = WaveForm_2Length * gSG.AWGClockRate;
else
    WaveForm_2I = WaveForm_1I;
    WaveForm_2I(size(WaveForm_1I, 1), 4) = 0; % Differential measurement
    WaveForm_2Q = WaveForm_1Q;
    WaveForm_2Q(size(WaveForm_1I, 1), 4) = -pi/2; % Differential measurement
    WaveForm_2Length = WaveForm_1Length;
    WaveForm_2PointNum = WaveForm_2Length * gSG.AWGClockRate;
end

WaveForm_3I = [0, gmSEQ.DEERt, gSG3.AWGFreq, 0*pi+0, gSG3.AWGAmp];
WaveForm_3Q = [0, gmSEQ.DEERt, gSG3.AWGFreq, 0*pi-pi/2, gSG3.AWGAmp];
WaveForm_3Length = ceil((gmSEQ.DEERt + 1000) / (16/gSG3.AWGClockRate)) * (16/gSG3.AWGClockRate);
WaveForm_3PointNum = WaveForm_3Length*gSG3.AWGClockRate;

chaseFunctionPool('createWaveform', WaveForm_1I, gSG.AWGClockRate, WaveForm_1Length, 'XY8N_I_seg1.txt'); pause(0.5);
chaseFunctionPool('createWaveform', WaveForm_1Q, gSG.AWGClockRate, WaveForm_1Length, 'XY8N_Q_seg1.txt'); pause(0.5);
chaseFunctionPool('createWaveform', WaveForm_2I, gSG.AWGClockRate, WaveForm_2Length, 'XY8N_I_seg2.txt'); pause(0.5);
chaseFunctionPool('createWaveform', WaveForm_2Q, gSG.AWGClockRate, WaveForm_2Length, 'XY8N_Q_seg2.txt'); pause(0.5);
chaseFunctionPool('createWaveform', WaveForm_3I, gSG3.AWGClockRate, WaveForm_3Length, 'XY8N_I_seg3.txt'); pause(0.5);
chaseFunctionPool('createWaveform', WaveForm_3Q, gSG3.AWGClockRate, WaveForm_3Length, 'XY8N_Q_seg3.txt'); pause(0.5);

chaseFunctionPool('createSegStruct', 'XY8N_SegStruct_I.txt', ...
    'XY8N_I_seg1.txt', WaveForm_1PointNum, 1, 1, ...
    'XY8N_I_seg2.txt', WaveForm_2PointNum, 1, 1);
pause(0.5);
chaseFunctionPool('createSegStruct', 'XY8N_SegStruct_Q.txt', ...
    'XY8N_Q_seg1.txt', WaveForm_1PointNum, 1, 1, ...
    'XY8N_Q_seg2.txt', WaveForm_2PointNum, 1, 1);
pause(0.5);

%% Load waveform to AWG
chaseFunctionPool('CreateSegments', gmSEQ.MWAWG, 1, ...
    2, ...
    2047, 2047, 'XY8N_SegStruct_I.txt', 'false');
pause(1); % this pause seems to be important, otherwise the loading is not right occassionally
chaseFunctionPool('CreateSegments', gmSEQ.MWAWG, 2, ...
    2, ...
    2047, 2047, 'XY8N_SegStruct_Q.txt', 'false');
pause(1); % this pause seems to be important, otherwise the loading is not right occassionally
chaseFunctionPool('CreateSingleSegment', gmSEQ.MWAWG2, 1, WaveForm_3PointNum, 1, 2047, 2047, 'XY8N_I_seg3.txt', 1); pause(1);
chaseFunctionPool('CreateSingleSegment', gmSEQ.MWAWG2, 2, WaveForm_3PointNum, 1, 2047, 2047, 'XY8N_Q_seg3.txt', 1); pause(1);

%% Run waveform
chaseFunctionPool('runChase', gmSEQ.MWAWG, 'false'); pause(0.5);
chaseFunctionPool('runChase', gmSEQ.MWAWG2, 'false');
ApplyDelays();

function WAHUHAN % TODO: totally remove the first halfpi pulse 
global gmSEQ gSG
gSG.bfixedPow=1;
gSG.bfixedFreq=1;
gSG.bMod='IQ';
gSG.bModSrc='External';

% TODO: add the definition for the pi and halfpi pulse AWG amp
gSG.piAWGAmp = gmSEQ.SAmp1; % Just for temporary use
gSG.halfpiAWGAmp = gmSEQ.SAmp2; % Just for temporary use

% gmSEQ.m here is the repetition number of XY8 block
gmSEQ.m = round(gmSEQ.m);

AfterPi = 2000;
AfterLaser = 0.1e6;
Wait_p = 10e3;
Detect_Window = 5000;

Cycle = 6*gmSEQ.interval + 4*gmSEQ.halfpi;
Sig_D_start = Wait_p+gmSEQ.readout+AfterLaser+Cycle*gmSEQ.m+gmSEQ.pi+AfterPi+Detect_Window+Wait_p;

gmSEQ.CHN(1).PBN=PBDictionary('ctr0');
gmSEQ.CHN(1).NRise=4;
gmSEQ.CHN(1).T=[Wait_p+gmSEQ.readout-1000-gmSEQ.CtrGateDur, ...
    Wait_p+gmSEQ.readout+AfterLaser+Cycle*gmSEQ.m+gmSEQ.pi+AfterPi, ...
    Sig_D_start+gmSEQ.readout-1000-gmSEQ.CtrGateDur, ... 
    Sig_D_start+gmSEQ.readout+AfterLaser+Cycle*gmSEQ.m+gmSEQ.pi+AfterPi];
if strcmp(gmSEQ.meas,'SPCM')
    gmSEQ.CHN(1).DT=[gmSEQ.CtrGateDur gmSEQ.CtrGateDur gmSEQ.CtrGateDur gmSEQ.CtrGateDur];
elseif strcmp(gmSEQ.meas,'APD')
    gmSEQ.CHN(1).DT=[1000 1000 1000 1000];
end

gmSEQ.CHN(numel(gmSEQ.CHN)+1).PBN=PBDictionary('AOM');
gmSEQ.CHN(numel(gmSEQ.CHN)).NRise=4;
gmSEQ.CHN(numel(gmSEQ.CHN)).T = [Wait_p, Wait_p+gmSEQ.readout+AfterLaser+Cycle*gmSEQ.m+gmSEQ.pi+AfterPi, ...
    Sig_D_start, Sig_D_start+gmSEQ.readout+AfterLaser+Cycle*gmSEQ.m+gmSEQ.pi+AfterPi];
gmSEQ.CHN(numel(gmSEQ.CHN)).DT = [gmSEQ.readout Detect_Window gmSEQ.readout Detect_Window];


gmSEQ.CHN(numel(gmSEQ.CHN)+1).PBN=PBDictionary('AWGTrig');
gmSEQ.CHN(numel(gmSEQ.CHN)).NRise=2;
gmSEQ.CHN(numel(gmSEQ.CHN)).T=[Wait_p+gmSEQ.readout+AfterLaser, Sig_D_start+gmSEQ.readout+AfterLaser];
gmSEQ.CHN(numel(gmSEQ.CHN)).DT=repelem(Cycle*gmSEQ.m+gmSEQ.pi+200, 2);


gmSEQ.CHN(numel(gmSEQ.CHN)+1).PBN=PBDictionary('MWSwitch');
if gmSEQ.m == 0
    gmSEQ.CHN(numel(gmSEQ.CHN)).NRise=1;
    gmSEQ.CHN(numel(gmSEQ.CHN)).T= Sig_D_start+gmSEQ.readout+AfterLaser-20;
    gmSEQ.CHN(numel(gmSEQ.CHN)).DT= gmSEQ.pi+40;
else
    if gmSEQ.interval < 150
        gmSEQ.CHN(numel(gmSEQ.CHN)).NRise=2;
        gmSEQ.CHN(numel(gmSEQ.CHN)).T=[Wait_p+gmSEQ.readout+AfterLaser-20, Sig_D_start+gmSEQ.readout+AfterLaser-20];
        gmSEQ.CHN(numel(gmSEQ.CHN)).DT=[Cycle*gmSEQ.m+gmSEQ.pi+40, Cycle*gmSEQ.m+gmSEQ.pi+40];
    else
        gmSEQ.CHN(numel(gmSEQ.CHN)).NRise= 8*gmSEQ.m + 1;
        gmSEQ.CHN(numel(gmSEQ.CHN)).T = zeros(1, gmSEQ.CHN(numel(gmSEQ.CHN)).NRise);
        for i = 1:gmSEQ.m
            for j = 1:4
                gmSEQ.CHN(numel(gmSEQ.CHN)).T((i-1)*4+1) = Wait_p+gmSEQ.readout+AfterLaser+(i-1)*Cycle+gmSEQ.interval-20;
                gmSEQ.CHN(numel(gmSEQ.CHN)).T((i-1)*4+2) = Wait_p+gmSEQ.readout+AfterLaser+(i-1)*Cycle+2*gmSEQ.interval+gmSEQ.halfpi-20;
                gmSEQ.CHN(numel(gmSEQ.CHN)).T((i-1)*4+3) = Wait_p+gmSEQ.readout+AfterLaser+(i-1)*Cycle+4*gmSEQ.interval+2*gmSEQ.halfpi-20;
                gmSEQ.CHN(numel(gmSEQ.CHN)).T((i-1)*4+4) = Wait_p+gmSEQ.readout+AfterLaser+(i-1)*Cycle+5*gmSEQ.interval+3*gmSEQ.halfpi-20;
            end
        end
        for i = 1:gmSEQ.m
            for j = 1:4
                gmSEQ.CHN(numel(gmSEQ.CHN)).T(4*gmSEQ.m+(i-1)*4+1) = Sig_D_start+gmSEQ.readout+AfterLaser+(i-1)*Cycle+gmSEQ.interval-20;
                gmSEQ.CHN(numel(gmSEQ.CHN)).T(4*gmSEQ.m+(i-1)*4+2) = Sig_D_start+gmSEQ.readout+AfterLaser+(i-1)*Cycle+2*gmSEQ.interval+gmSEQ.halfpi-20;
                gmSEQ.CHN(numel(gmSEQ.CHN)).T(4*gmSEQ.m+(i-1)*4+3) = Sig_D_start+gmSEQ.readout+AfterLaser+(i-1)*Cycle+4*gmSEQ.interval+2*gmSEQ.halfpi-20;
                gmSEQ.CHN(numel(gmSEQ.CHN)).T(4*gmSEQ.m+(i-1)*4+4) = Sig_D_start+gmSEQ.readout+AfterLaser+(i-1)*Cycle+5*gmSEQ.interval+3*gmSEQ.halfpi-20;
            end
        end
        gmSEQ.CHN(numel(gmSEQ.CHN)).T(8*gmSEQ.m+1) = Sig_D_start+gmSEQ.readout+AfterLaser+gmSEQ.m*Cycle-20;
        gmSEQ.CHN(numel(gmSEQ.CHN)).DT= [repelem(gmSEQ.halfpi+40, 8*gmSEQ.m), gmSEQ.pi+40];
    end
end

gmSEQ.CHN(numel(gmSEQ.CHN)+1).PBN=PBDictionary('dummy1');
gmSEQ.CHN(numel(gmSEQ.CHN)).NRise=2;
gmSEQ.CHN(numel(gmSEQ.CHN)).T=[0 Sig_D_start+gmSEQ.readout+AfterLaser+gmSEQ.m*Cycle+gmSEQ.pi+AfterPi+Detect_Window-50];
gmSEQ.CHN(numel(gmSEQ.CHN)).DT=[50 50];

%% AWG
% Initialization
chaseFunctionPool('stopChase',  gmSEQ.MWAWG)

% This part need to be modified to accomodate the DC modulation
if ~gSG.ACmodAWG % in AC modulation mode
    gSG.AWGFreq = 0;
end

WaveForm_1I = zeros(4*gmSEQ.m + 1, 5);
for i = 1:gmSEQ.m
    WaveForm_1I((i-1)*4 + 1, :) = [(i-1)*Cycle+gmSEQ.interval (i-1)*Cycle+gmSEQ.interval+gmSEQ.halfpi gSG.AWGFreq 0 gSG.halfpiAWGAmp]; % pi/2_x
    WaveForm_1I((i-1)*4 + 2, :) = [(i-1)*Cycle+2*gmSEQ.interval+gmSEQ.halfpi (i-1)*Cycle+2*gmSEQ.interval+2*gmSEQ.halfpi gSG.AWGFreq 3*pi/2 gSG.halfpiAWGAmp]; % -pi/2_y
    WaveForm_1I((i-1)*4 + 3, :) = [(i-1)*Cycle+4*gmSEQ.interval+2*gmSEQ.halfpi (i-1)*Cycle+4*gmSEQ.interval+3*gmSEQ.halfpi gSG.AWGFreq pi/2 gSG.halfpiAWGAmp]; % pi/2_y
    WaveForm_1I((i-1)*4 + 4, :) = [(i-1)*Cycle+5*gmSEQ.interval+3*gmSEQ.halfpi (i-1)*Cycle+5*gmSEQ.interval+4*gmSEQ.halfpi gSG.AWGFreq pi gSG.halfpiAWGAmp]; % pi/2_-x
end
WaveForm_1I(4*gmSEQ.m + 1, :) = [gmSEQ.m*Cycle gmSEQ.m*Cycle+gmSEQ.pi gSG.AWGFreq 0 0];

WaveForm_1Q = WaveForm_1I - repmat([0 0 0 pi/2 0], size(WaveForm_1I, 1), 1);
WaveForm_1Length = ceil((gmSEQ.m*Cycle+gmSEQ.pi+1000) / (16 / gSG.AWGClockRate)) ...
    *(16 / gSG.AWGClockRate);
WaveForm_1PointNum = WaveForm_1Length * gSG.AWGClockRate;

WaveForm_2I = WaveForm_1I;
WaveForm_2I(size(WaveForm_1I, 1),:) = [gmSEQ.m*Cycle gmSEQ.m*Cycle+gmSEQ.pi gSG.AWGFreq 0 gSG.piAWGAmp]; % Differential measurement
WaveForm_2Q = WaveForm_2I - repmat([0 0 0 pi/2 0], size(WaveForm_2I, 1), 1);
WaveForm_2Length = WaveForm_1Length;
WaveForm_2PointNum = WaveForm_2Length * gSG.AWGClockRate;

chaseFunctionPool('createWaveform', WaveForm_1I, gSG.AWGClockRate, WaveForm_1Length, 'WAHUHAN_I_seg1.txt'); pause(0.5);
chaseFunctionPool('createWaveform', WaveForm_1Q, gSG.AWGClockRate, WaveForm_1Length, 'WAHUHAN_Q_seg1.txt'); pause(0.5);
chaseFunctionPool('createWaveform', WaveForm_2I, gSG.AWGClockRate, WaveForm_2Length, 'WAHUHAN_I_seg2.txt'); pause(0.5);
chaseFunctionPool('createWaveform', WaveForm_2Q, gSG.AWGClockRate, WaveForm_2Length, 'WAHUHAN_Q_seg2.txt'); pause(0.5);

chaseFunctionPool('createSegStruct', 'WAHUHAN_SegStruct_I.txt', ...
    'WAHUHAN_I_seg1.txt', WaveForm_1PointNum, 1, 1, ...
    'WAHUHAN_I_seg2.txt', WaveForm_2PointNum, 1, 1);
pause(0.5);
chaseFunctionPool('createSegStruct', 'WAHUHAN_SegStruct_Q.txt', ...
    'WAHUHAN_Q_seg1.txt', WaveForm_1PointNum, 1, 1, ...
    'WAHUHAN_Q_seg2.txt', WaveForm_2PointNum, 1, 1);
pause(0.5);

%% Load waveform to AWG
chaseFunctionPool('CreateSegments', gmSEQ.MWAWG, 1, ...
    2, ...
    2047, 2047, 'WAHUHAN_SegStruct_I.txt', 'false');
pause(1); % this pause seems to be important, otherwise the loading is not right occassionally
chaseFunctionPool('CreateSegments', gmSEQ.MWAWG, 2, ...
    2, ...
    2047, 2047, 'WAHUHAN_SegStruct_Q.txt', 'false');
pause(1); % this pause seems to be important, otherwise the loading is not right occassionally
%% Run waveform
chaseFunctionPool('runChase', gmSEQ.MWAWG, 'false');
ApplyDelays();

function DROID60
global gmSEQ gSG
gSG.bfixedPow=1;
gSG.bfixedFreq=1;
gSG.bMod='IQ';
gSG.bModSrc='External';

gmSEQ.halfpi = gmSEQ.pi/2;

AfterPi = 2000;
AfterLaser = 100000;
Wait_p = 0.1e6;
Detect_Window = 5000;

Sig_D_start = Wait_p+gmSEQ.readout+AfterLaser+gmSEQ.halfpi+(96*gmSEQ.m + 48*gmSEQ.pi)+gmSEQ.halfpi+AfterPi+Detect_Window+Wait_p;

gmSEQ.CHN(1).PBN=PBDictionary('ctr0');
gmSEQ.CHN(1).NRise=4;
gmSEQ.CHN(1).T=[Wait_p+gmSEQ.readout-1000-gmSEQ.CtrGateDur, ...
    Wait_p+gmSEQ.readout+AfterLaser+gmSEQ.halfpi+(96*gmSEQ.m + 48*gmSEQ.pi)+gmSEQ.halfpi+AfterPi, ...
    Sig_D_start+gmSEQ.readout-1000-gmSEQ.CtrGateDur, ... 
    Sig_D_start+gmSEQ.readout+AfterLaser+gmSEQ.halfpi+(96*gmSEQ.m + 48*gmSEQ.pi)+gmSEQ.halfpi+AfterPi];
if strcmp(gmSEQ.meas,'SPCM')
    gmSEQ.CHN(1).DT=[gmSEQ.CtrGateDur gmSEQ.CtrGateDur gmSEQ.CtrGateDur gmSEQ.CtrGateDur];
elseif strcmp(gmSEQ.meas,'APD')
    gmSEQ.CHN(1).DT=[1000 1000 1000 1000];
end

gmSEQ.CHN(numel(gmSEQ.CHN)+1).PBN=PBDictionary('AOM');
gmSEQ.CHN(numel(gmSEQ.CHN)).NRise=4;
gmSEQ.CHN(numel(gmSEQ.CHN)).T = [Wait_p, Wait_p+gmSEQ.readout+AfterLaser+gmSEQ.halfpi+(96*gmSEQ.m + 48*gmSEQ.pi)+gmSEQ.halfpi+AfterPi, ...
    Sig_D_start, Sig_D_start+gmSEQ.readout+AfterLaser+gmSEQ.halfpi+(96*gmSEQ.m + 48*gmSEQ.pi)+gmSEQ.halfpi+AfterPi];
gmSEQ.CHN(numel(gmSEQ.CHN)).DT = [gmSEQ.readout Detect_Window gmSEQ.readout Detect_Window];

gmSEQ.CHN(numel(gmSEQ.CHN)+1).PBN=PBDictionary('AWGTrig');
gmSEQ.CHN(numel(gmSEQ.CHN)).NRise=2;
gmSEQ.CHN(numel(gmSEQ.CHN)).T=[Wait_p+gmSEQ.readout+AfterLaser, ...
    Sig_D_start+gmSEQ.readout+AfterLaser];
gmSEQ.CHN(numel(gmSEQ.CHN)).DT=[2150 2150];

gmSEQ.CHN(numel(gmSEQ.CHN)+1).PBN=PBDictionary('MWSwitch');
if gmSEQ.m < 150
    gmSEQ.CHN(numel(gmSEQ.CHN)).NRise=2;
    gmSEQ.CHN(numel(gmSEQ.CHN)).T=[Wait_p+gmSEQ.readout+AfterLaser-50, Sig_D_start+gmSEQ.readout+AfterLaser-50];
    gmSEQ.CHN(numel(gmSEQ.CHN)).DT=[gmSEQ.halfpi+(96*gmSEQ.m + 48*gmSEQ.pi)+gmSEQ.halfpi+100, ... 
    gmSEQ.halfpi+(96*gmSEQ.m + 48*gmSEQ.pi)+gmSEQ.halfpi+100];
else
    gmSEQ.CHN(numel(gmSEQ.CHN)).NRise=100;
    gmSEQ.CHN(numel(gmSEQ.CHN)).T= [Wait_p+gmSEQ.readout+AfterLaser-20];
    for i = 0:47
        gmSEQ.CHN(numel(gmSEQ.CHN)).T = [gmSEQ.CHN(numel(gmSEQ.CHN)).T, ...
            Wait_p+gmSEQ.readout+AfterLaser+gmSEQ.halfpi+gmSEQ.m+i*(gmSEQ.pi+2*gmSEQ.m)-20];
    end
    gmSEQ.CHN(numel(gmSEQ.CHN)).T = [gmSEQ.CHN(numel(gmSEQ.CHN)).T, ...
        Wait_p+gmSEQ.readout+AfterLaser+gmSEQ.halfpi+(96*gmSEQ.m + 48*gmSEQ.pi)-20, ...
        Sig_D_start+gmSEQ.readout+AfterLaser-20]; 
    for i = 0:47
        gmSEQ.CHN(numel(gmSEQ.CHN)).T = [gmSEQ.CHN(numel(gmSEQ.CHN)).T, ...
            Sig_D_start+gmSEQ.readout+AfterLaser+gmSEQ.halfpi+gmSEQ.m+i*(gmSEQ.pi+2*gmSEQ.m)-20];
    end
    gmSEQ.CHN(numel(gmSEQ.CHN)).T = [gmSEQ.CHN(numel(gmSEQ.CHN)).T, ...
         Sig_D_start+gmSEQ.readout+AfterLaser+gmSEQ.halfpi+(96*gmSEQ.m + 48*gmSEQ.pi)-20];
    
    gmSEQ.CHN(numel(gmSEQ.CHN)).DT=[gmSEQ.halfpi+40, repelem(gmSEQ.pi+40, 48), gmSEQ.halfpi+40, ... 
        gmSEQ.halfpi+40, repelem(gmSEQ.pi+40, 48), gmSEQ.halfpi+40];
end

gmSEQ.CHN(numel(gmSEQ.CHN)+1).PBN=PBDictionary('dummy1');
gmSEQ.CHN(numel(gmSEQ.CHN)).NRise=2;
gmSEQ.CHN(numel(gmSEQ.CHN)).T=[0 Sig_D_start+gmSEQ.readout+AfterLaser+gmSEQ.halfpi+(96*gmSEQ.m + 48*gmSEQ.pi)+gmSEQ.halfpi+AfterPi+Detect_Window-50];
gmSEQ.CHN(numel(gmSEQ.CHN)).DT=[50 50];

%% AWG
% Initialization
chaseFunctionPool('stopChase',  gmSEQ.MWAWG)

% This part need to be modified to accomodate the DC modulation
if gSG.ACmodAWG % in AC modulation mode
    gSG.AWGFreq = gSG.AWGFreq;
else
    gSG.AWGFreq = 0;
end

WaveForm_1I = [0 gmSEQ.halfpi gSG.AWGFreq 0 gSG.AWGAmp;...
    gmSEQ.halfpi+gmSEQ.m gmSEQ.halfpi+gmSEQ.m+gmSEQ.pi gSG.AWGFreq 0 gSG.AWGAmp; ... % pi_x
    gmSEQ.halfpi+gmSEQ.m+gmSEQ.pi+2*gmSEQ.m gmSEQ.halfpi+gmSEQ.m+gmSEQ.pi+2*gmSEQ.m+gmSEQ.pi/2 gSG.AWGFreq 0 gSG.AWGAmp; ... % pi/2_x
    gmSEQ.halfpi+gmSEQ.m+gmSEQ.pi+2*gmSEQ.m+gmSEQ.pi/2 gmSEQ.halfpi+gmSEQ.m+gmSEQ.pi+2*gmSEQ.m+gmSEQ.pi gSG.AWGFreq 3*pi/2 gSG.AWGAmp; ... % -pi/2_y
    gmSEQ.halfpi+gmSEQ.m+(gmSEQ.pi+2*gmSEQ.m)*2 gmSEQ.halfpi+gmSEQ.m+(gmSEQ.pi+2*gmSEQ.m)*2+gmSEQ.pi gSG.AWGFreq pi gSG.AWGAmp; ... % -pi_x
    gmSEQ.halfpi+gmSEQ.m+(gmSEQ.pi+2*gmSEQ.m)*3 gmSEQ.halfpi+gmSEQ.m+(gmSEQ.pi+2*gmSEQ.m)*3+gmSEQ.pi gSG.AWGFreq pi gSG.AWGAmp; ... % -pi_x
    gmSEQ.halfpi+gmSEQ.m+(gmSEQ.pi+2*gmSEQ.m)*4 gmSEQ.halfpi+gmSEQ.m+(gmSEQ.pi+2*gmSEQ.m)*4+gmSEQ.pi gSG.AWGFreq 0 gSG.AWGAmp; ... % pi_x
    gmSEQ.halfpi+gmSEQ.m+(gmSEQ.pi+2*gmSEQ.m)*5 gmSEQ.halfpi+gmSEQ.m+(gmSEQ.pi+2*gmSEQ.m)*5+gmSEQ.pi/2 gSG.AWGFreq 0 gSG.AWGAmp; ... % pi_x/2
    gmSEQ.halfpi+gmSEQ.m+(gmSEQ.pi+2*gmSEQ.m)*5+gmSEQ.pi/2 gmSEQ.halfpi+gmSEQ.m+(gmSEQ.pi+2*gmSEQ.m)*5+gmSEQ.pi gSG.AWGFreq 3*pi/2 gSG.AWGAmp; ... % -pi_y/2
    gmSEQ.halfpi+gmSEQ.m+(gmSEQ.pi+2*gmSEQ.m)*6 gmSEQ.halfpi+gmSEQ.m+(gmSEQ.pi+2*gmSEQ.m)*6+gmSEQ.pi gSG.AWGFreq pi gSG.AWGAmp; ... % -pi_x
    gmSEQ.halfpi+gmSEQ.m+(gmSEQ.pi+2*gmSEQ.m)*7 gmSEQ.halfpi+gmSEQ.m+(gmSEQ.pi+2*gmSEQ.m)*7+gmSEQ.pi gSG.AWGFreq pi gSG.AWGAmp; ... % -pi_x
    gmSEQ.halfpi+gmSEQ.m+(gmSEQ.pi+2*gmSEQ.m)*8 gmSEQ.halfpi+gmSEQ.m+(gmSEQ.pi+2*gmSEQ.m)*8+gmSEQ.pi gSG.AWGFreq 0 gSG.AWGAmp; ... % pi_x
    gmSEQ.halfpi+gmSEQ.m+(gmSEQ.pi+2*gmSEQ.m)*9 gmSEQ.halfpi+gmSEQ.m+(gmSEQ.pi+2*gmSEQ.m)*9+gmSEQ.pi/2 gSG.AWGFreq 0 gSG.AWGAmp; ... % pi/2_x
    gmSEQ.halfpi+gmSEQ.m+(gmSEQ.pi+2*gmSEQ.m)*9+gmSEQ.pi/2 gmSEQ.halfpi+gmSEQ.m+(gmSEQ.pi+2*gmSEQ.m)*9+gmSEQ.pi gSG.AWGFreq 3*pi/2 gSG.AWGAmp; ... % -pi_y/2
    gmSEQ.halfpi+gmSEQ.m+(gmSEQ.pi+2*gmSEQ.m)*10 gmSEQ.halfpi+gmSEQ.m+(gmSEQ.pi+2*gmSEQ.m)*10+gmSEQ.pi gSG.AWGFreq pi gSG.AWGAmp; ... % -pi_x
    gmSEQ.halfpi+gmSEQ.m+(gmSEQ.pi+2*gmSEQ.m)*11 gmSEQ.halfpi+gmSEQ.m+(gmSEQ.pi+2*gmSEQ.m)*11+gmSEQ.pi gSG.AWGFreq pi gSG.AWGAmp; ... % -pi_x
    gmSEQ.halfpi+gmSEQ.m+(gmSEQ.pi+2*gmSEQ.m)*12 gmSEQ.halfpi+gmSEQ.m+(gmSEQ.pi+2*gmSEQ.m)*12+gmSEQ.pi gSG.AWGFreq 3*pi/2 gSG.AWGAmp; ... % -pi_y
    gmSEQ.halfpi+gmSEQ.m+(gmSEQ.pi+2*gmSEQ.m)*13 gmSEQ.halfpi+gmSEQ.m+(gmSEQ.pi+2*gmSEQ.m)*13+gmSEQ.pi/2 gSG.AWGFreq 3*pi/2 gSG.AWGAmp; ... % -pi_y/2
    gmSEQ.halfpi+gmSEQ.m+(gmSEQ.pi+2*gmSEQ.m)*13+gmSEQ.pi/2 gmSEQ.halfpi+gmSEQ.m+(gmSEQ.pi+2*gmSEQ.m)*13+gmSEQ.pi gSG.AWGFreq 0 gSG.AWGAmp; ... % pi_x/2
    gmSEQ.halfpi+gmSEQ.m+(gmSEQ.pi+2*gmSEQ.m)*14 gmSEQ.halfpi+gmSEQ.m+(gmSEQ.pi+2*gmSEQ.m)*14+gmSEQ.pi gSG.AWGFreq pi/2 gSG.AWGAmp; ... % pi_y
    gmSEQ.halfpi+gmSEQ.m+(gmSEQ.pi+2*gmSEQ.m)*15 gmSEQ.halfpi+gmSEQ.m+(gmSEQ.pi+2*gmSEQ.m)*15+gmSEQ.pi gSG.AWGFreq pi/2 gSG.AWGAmp; ... % pi_y
    gmSEQ.halfpi+gmSEQ.m+(gmSEQ.pi+2*gmSEQ.m)*16 gmSEQ.halfpi+gmSEQ.m+(gmSEQ.pi+2*gmSEQ.m)*16+gmSEQ.pi gSG.AWGFreq 3*pi/2 gSG.AWGAmp; ... % -pi_y
    gmSEQ.halfpi+gmSEQ.m+(gmSEQ.pi+2*gmSEQ.m)*17 gmSEQ.halfpi+gmSEQ.m+(gmSEQ.pi+2*gmSEQ.m)*17+gmSEQ.pi/2 gSG.AWGFreq 3*pi/2 gSG.AWGAmp; ... % -pi_y/2
    gmSEQ.halfpi+gmSEQ.m+(gmSEQ.pi+2*gmSEQ.m)*17+gmSEQ.pi/2 gmSEQ.halfpi+gmSEQ.m+(gmSEQ.pi+2*gmSEQ.m)*17+gmSEQ.pi gSG.AWGFreq 0 gSG.AWGAmp; ... % pi_x/2
    gmSEQ.halfpi+gmSEQ.m+(gmSEQ.pi+2*gmSEQ.m)*18 gmSEQ.halfpi+gmSEQ.m+(gmSEQ.pi+2*gmSEQ.m)*18+gmSEQ.pi gSG.AWGFreq pi/2 gSG.AWGAmp; ... % pi_y
    gmSEQ.halfpi+gmSEQ.m+(gmSEQ.pi+2*gmSEQ.m)*19 gmSEQ.halfpi+gmSEQ.m+(gmSEQ.pi+2*gmSEQ.m)*19+gmSEQ.pi gSG.AWGFreq pi/2 gSG.AWGAmp; ... % pi_y
    gmSEQ.halfpi+gmSEQ.m+(gmSEQ.pi+2*gmSEQ.m)*20 gmSEQ.halfpi+gmSEQ.m+(gmSEQ.pi+2*gmSEQ.m)*20+gmSEQ.pi gSG.AWGFreq 3*pi/2 gSG.AWGAmp; ... % -pi_y
    gmSEQ.halfpi+gmSEQ.m+(gmSEQ.pi+2*gmSEQ.m)*21 gmSEQ.halfpi+gmSEQ.m+(gmSEQ.pi+2*gmSEQ.m)*21+gmSEQ.pi/2 gSG.AWGFreq 3*pi/2 gSG.AWGAmp; ... % -pi_y/2
    gmSEQ.halfpi+gmSEQ.m+(gmSEQ.pi+2*gmSEQ.m)*21+gmSEQ.pi/2 gmSEQ.halfpi+gmSEQ.m+(gmSEQ.pi+2*gmSEQ.m)*21+gmSEQ.pi gSG.AWGFreq 0 gSG.AWGAmp; ... % pi_x/2
    gmSEQ.halfpi+gmSEQ.m+(gmSEQ.pi+2*gmSEQ.m)*22 gmSEQ.halfpi+gmSEQ.m+(gmSEQ.pi+2*gmSEQ.m)*22+gmSEQ.pi gSG.AWGFreq pi/2 gSG.AWGAmp; ... % pi_y
    gmSEQ.halfpi+gmSEQ.m+(gmSEQ.pi+2*gmSEQ.m)*23 gmSEQ.halfpi+gmSEQ.m+(gmSEQ.pi+2*gmSEQ.m)*23+gmSEQ.pi gSG.AWGFreq pi/2 gSG.AWGAmp; ... % pi_y
    gmSEQ.halfpi+gmSEQ.m+(gmSEQ.pi+2*gmSEQ.m)*24 gmSEQ.halfpi+gmSEQ.m+(gmSEQ.pi+2*gmSEQ.m)*24+gmSEQ.pi gSG.AWGFreq 3*pi/2 gSG.AWGAmp; ... % -pi_y
    gmSEQ.halfpi+gmSEQ.m+(gmSEQ.pi+2*gmSEQ.m)*25 gmSEQ.halfpi+gmSEQ.m+(gmSEQ.pi+2*gmSEQ.m)*25+gmSEQ.pi/2 gSG.AWGFreq 0 gSG.AWGAmp; ... % pi_x/2
    gmSEQ.halfpi+gmSEQ.m+(gmSEQ.pi+2*gmSEQ.m)*25+gmSEQ.pi/2 gmSEQ.halfpi+gmSEQ.m+(gmSEQ.pi+2*gmSEQ.m)*25+gmSEQ.pi gSG.AWGFreq pi/2 gSG.AWGAmp; ... % pi_y/2
    gmSEQ.halfpi+gmSEQ.m+(gmSEQ.pi+2*gmSEQ.m)*26 gmSEQ.halfpi+gmSEQ.m+(gmSEQ.pi+2*gmSEQ.m)*26+gmSEQ.pi gSG.AWGFreq pi/2 gSG.AWGAmp; ... % pi_y
    gmSEQ.halfpi+gmSEQ.m+(gmSEQ.pi+2*gmSEQ.m)*27 gmSEQ.halfpi+gmSEQ.m+(gmSEQ.pi+2*gmSEQ.m)*27+gmSEQ.pi gSG.AWGFreq 3*pi/2 gSG.AWGAmp; ... % -pi_y
    gmSEQ.halfpi+gmSEQ.m+(gmSEQ.pi+2*gmSEQ.m)*28 gmSEQ.halfpi+gmSEQ.m+(gmSEQ.pi+2*gmSEQ.m)*28+gmSEQ.pi gSG.AWGFreq 3*pi/2 gSG.AWGAmp; ... % -pi_y
    gmSEQ.halfpi+gmSEQ.m+(gmSEQ.pi+2*gmSEQ.m)*29 gmSEQ.halfpi+gmSEQ.m+(gmSEQ.pi+2*gmSEQ.m)*29+gmSEQ.pi/2 gSG.AWGFreq 0 gSG.AWGAmp; ... % pi_x/2
    gmSEQ.halfpi+gmSEQ.m+(gmSEQ.pi+2*gmSEQ.m)*29+gmSEQ.pi/2 gmSEQ.halfpi+gmSEQ.m+(gmSEQ.pi+2*gmSEQ.m)*29+gmSEQ.pi gSG.AWGFreq pi/2 gSG.AWGAmp; ... % pi_y/2
    gmSEQ.halfpi+gmSEQ.m+(gmSEQ.pi+2*gmSEQ.m)*30 gmSEQ.halfpi+gmSEQ.m+(gmSEQ.pi+2*gmSEQ.m)*30+gmSEQ.pi gSG.AWGFreq pi/2 gSG.AWGAmp; ... % pi_y
    gmSEQ.halfpi+gmSEQ.m+(gmSEQ.pi+2*gmSEQ.m)*31 gmSEQ.halfpi+gmSEQ.m+(gmSEQ.pi+2*gmSEQ.m)*31+gmSEQ.pi gSG.AWGFreq 3*pi/2 gSG.AWGAmp; ... % -pi_y
    gmSEQ.halfpi+gmSEQ.m+(gmSEQ.pi+2*gmSEQ.m)*32 gmSEQ.halfpi+gmSEQ.m+(gmSEQ.pi+2*gmSEQ.m)*32+gmSEQ.pi gSG.AWGFreq 3*pi/2 gSG.AWGAmp; ... % -pi_y
    gmSEQ.halfpi+gmSEQ.m+(gmSEQ.pi+2*gmSEQ.m)*33 gmSEQ.halfpi+gmSEQ.m+(gmSEQ.pi+2*gmSEQ.m)*33+gmSEQ.pi/2 gSG.AWGFreq 0 gSG.AWGAmp; ... % pi_x/2
    gmSEQ.halfpi+gmSEQ.m+(gmSEQ.pi+2*gmSEQ.m)*33+gmSEQ.pi/2 gmSEQ.halfpi+gmSEQ.m+(gmSEQ.pi+2*gmSEQ.m)*33+gmSEQ.pi gSG.AWGFreq pi/2 gSG.AWGAmp; ... % pi_y/2
    gmSEQ.halfpi+gmSEQ.m+(gmSEQ.pi+2*gmSEQ.m)*34 gmSEQ.halfpi+gmSEQ.m+(gmSEQ.pi+2*gmSEQ.m)*34+gmSEQ.pi gSG.AWGFreq pi/2 gSG.AWGAmp; ... % pi_y
    gmSEQ.halfpi+gmSEQ.m+(gmSEQ.pi+2*gmSEQ.m)*35 gmSEQ.halfpi+gmSEQ.m+(gmSEQ.pi+2*gmSEQ.m)*35+gmSEQ.pi gSG.AWGFreq pi gSG.AWGAmp; ... % -pi_x
    gmSEQ.halfpi+gmSEQ.m+(gmSEQ.pi+2*gmSEQ.m)*36 gmSEQ.halfpi+gmSEQ.m+(gmSEQ.pi+2*gmSEQ.m)*36+gmSEQ.pi gSG.AWGFreq pi gSG.AWGAmp; ... % -pi_x
    gmSEQ.halfpi+gmSEQ.m+(gmSEQ.pi+2*gmSEQ.m)*37 gmSEQ.halfpi+gmSEQ.m+(gmSEQ.pi+2*gmSEQ.m)*37+gmSEQ.pi/2 gSG.AWGFreq pi/2 gSG.AWGAmp; ... % pi_y/2
    gmSEQ.halfpi+gmSEQ.m+(gmSEQ.pi+2*gmSEQ.m)*37+gmSEQ.pi/2 gmSEQ.halfpi+gmSEQ.m+(gmSEQ.pi+2*gmSEQ.m)*37+gmSEQ.pi gSG.AWGFreq 0 gSG.AWGAmp; ... % pi_x/2
    gmSEQ.halfpi+gmSEQ.m+(gmSEQ.pi+2*gmSEQ.m)*38 gmSEQ.halfpi+gmSEQ.m+(gmSEQ.pi+2*gmSEQ.m)*38+gmSEQ.pi gSG.AWGFreq 0 gSG.AWGAmp; ... % pi_x
    gmSEQ.halfpi+gmSEQ.m+(gmSEQ.pi+2*gmSEQ.m)*39 gmSEQ.halfpi+gmSEQ.m+(gmSEQ.pi+2*gmSEQ.m)*39+gmSEQ.pi gSG.AWGFreq pi gSG.AWGAmp; ... % -pi_x
    gmSEQ.halfpi+gmSEQ.m+(gmSEQ.pi+2*gmSEQ.m)*40 gmSEQ.halfpi+gmSEQ.m+(gmSEQ.pi+2*gmSEQ.m)*40+gmSEQ.pi gSG.AWGFreq pi gSG.AWGAmp; ... % -pi_x
    gmSEQ.halfpi+gmSEQ.m+(gmSEQ.pi+2*gmSEQ.m)*41 gmSEQ.halfpi+gmSEQ.m+(gmSEQ.pi+2*gmSEQ.m)*41+gmSEQ.pi/2 gSG.AWGFreq pi/2 gSG.AWGAmp; ... % pi_y/2
    gmSEQ.halfpi+gmSEQ.m+(gmSEQ.pi+2*gmSEQ.m)*41+gmSEQ.pi/2 gmSEQ.halfpi+gmSEQ.m+(gmSEQ.pi+2*gmSEQ.m)*41+gmSEQ.pi gSG.AWGFreq 0 gSG.AWGAmp; ... % pi_x/2
    gmSEQ.halfpi+gmSEQ.m+(gmSEQ.pi+2*gmSEQ.m)*42 gmSEQ.halfpi+gmSEQ.m+(gmSEQ.pi+2*gmSEQ.m)*42+gmSEQ.pi gSG.AWGFreq 0 gSG.AWGAmp; ... % pi_x
    gmSEQ.halfpi+gmSEQ.m+(gmSEQ.pi+2*gmSEQ.m)*43 gmSEQ.halfpi+gmSEQ.m+(gmSEQ.pi+2*gmSEQ.m)*43+gmSEQ.pi gSG.AWGFreq pi gSG.AWGAmp; ... % -pi_x
    gmSEQ.halfpi+gmSEQ.m+(gmSEQ.pi+2*gmSEQ.m)*44 gmSEQ.halfpi+gmSEQ.m+(gmSEQ.pi+2*gmSEQ.m)*44+gmSEQ.pi gSG.AWGFreq pi gSG.AWGAmp; ... % -pi_x
   	gmSEQ.halfpi+gmSEQ.m+(gmSEQ.pi+2*gmSEQ.m)*45 gmSEQ.halfpi+gmSEQ.m+(gmSEQ.pi+2*gmSEQ.m)*45+gmSEQ.pi/2 gSG.AWGFreq pi/2 gSG.AWGAmp; ... % pi_y/2
    gmSEQ.halfpi+gmSEQ.m+(gmSEQ.pi+2*gmSEQ.m)*45+gmSEQ.pi/2 gmSEQ.halfpi+gmSEQ.m+(gmSEQ.pi+2*gmSEQ.m)*45+gmSEQ.pi gSG.AWGFreq 0 gSG.AWGAmp; ... % pi_x/2
    gmSEQ.halfpi+gmSEQ.m+(gmSEQ.pi+2*gmSEQ.m)*46 gmSEQ.halfpi+gmSEQ.m+(gmSEQ.pi+2*gmSEQ.m)*46+gmSEQ.pi gSG.AWGFreq 0 gSG.AWGAmp; ... % pi_x
    gmSEQ.halfpi+gmSEQ.m+(gmSEQ.pi+2*gmSEQ.m)*47 gmSEQ.halfpi+gmSEQ.m+(gmSEQ.pi+2*gmSEQ.m)*47+gmSEQ.pi gSG.AWGFreq 3*pi/2 gSG.AWGAmp; ... % -pi_y
    gmSEQ.halfpi+(48*gmSEQ.pi + 96*gmSEQ.m) gmSEQ.halfpi+(48*gmSEQ.pi + 96*gmSEQ.m)+gmSEQ.halfpi gSG.AWGFreq pi gSG.AWGAmp]; 

WaveForm_1Q = WaveForm_1I - repmat([0 0 0 pi/2 0], size(WaveForm_1I, 1), 1);
WaveForm_1Length = ceil((gmSEQ.halfpi+(gmSEQ.pi*48 + 96*gmSEQ.m)+gmSEQ.halfpi+1000) / (16 / gSG.AWGClockRate)) ...
    *(16 / gSG.AWGClockRate);
WaveForm_1PointNum = WaveForm_1Length * gSG.AWGClockRate;

WaveForm_2I = WaveForm_1I;
WaveForm_2I(size(WaveForm_1I, 1), 4) = 0; % Differential measurement
WaveForm_2Q = WaveForm_1Q;
WaveForm_2Q(size(WaveForm_1I, 1), 4) = -pi/2; % Differential measurement
WaveForm_2Length = WaveForm_1Length;
WaveForm_2PointNum = WaveForm_2Length * gSG.AWGClockRate;

chaseFunctionPool('createWaveform', WaveForm_1I, gSG.AWGClockRate, WaveForm_1Length, 'DROID_I_seg1.txt'); pause(0.5);
chaseFunctionPool('createWaveform', WaveForm_1Q, gSG.AWGClockRate, WaveForm_1Length, 'DROID_Q_seg1.txt'); pause(0.5);
chaseFunctionPool('createWaveform', WaveForm_2I, gSG.AWGClockRate, WaveForm_2Length, 'DROID_I_seg2.txt'); pause(0.5);
chaseFunctionPool('createWaveform', WaveForm_2Q, gSG.AWGClockRate, WaveForm_2Length, 'DROID_Q_seg2.txt'); pause(0.5);

chaseFunctionPool('createSegStruct', 'DROID_SegStruct_I.txt', ...
    'DROID_I_seg1.txt', WaveForm_1PointNum, 1, 1, ...
    'DROID_I_seg2.txt', WaveForm_2PointNum, 1, 1);
pause(0.5);
chaseFunctionPool('createSegStruct', 'DROID_SegStruct_Q.txt', ...
    'DROID_Q_seg1.txt', WaveForm_1PointNum, 1, 1, ...
    'DROID_Q_seg2.txt', WaveForm_2PointNum, 1, 1);
pause(0.5);

%% Load waveform to AWG
chaseFunctionPool('CreateSegments', gmSEQ.MWAWG, 1, ...
    2, ...
    2047, 2047, 'DROID_SegStruct_I.txt', 'false');
pause(1); % this pause seems to be important, otherwise the loading is not right occassionally
chaseFunctionPool('CreateSegments', gmSEQ.MWAWG, 2, ...
    2, ...
    2047, 2047, 'DROID_SegStruct_Q.txt', 'false');
pause(1); % this pause seems to be important, otherwise the loading is not right occassionally
%% Run waveform
chaseFunctionPool('runChase', gmSEQ.MWAWG, 'false');
ApplyDelays();

function DROID60N_x % Put in the equator
global gmSEQ gSG
gSG.bfixedPow=1;
gSG.bfixedFreq=1;
gSG.bMod='IQ';
gSG.bModSrc='External';

% TODO: add the definition for the pi and halfpi pulse AWG amp
gSG.piAWGAmp = gmSEQ.SAmp1; % Just for temporary use
gSG.halfpiAWGAmp = gmSEQ.SAmp2; % Just for temporary use

% gmSEQ.m here is the repetition number of XY8 block
gmSEQ.m = round(gmSEQ.m);

AfterPi = 1000;
AfterLaser = 100e3;
Wait_p = 10e3;
Detect_Window = 5000;
PulseGap = 0;

Cycle = (gmSEQ.interval + gmSEQ.pi)*48;
Sig_D_start = Wait_p+gmSEQ.readout+AfterLaser+gmSEQ.halfpi+Cycle*gmSEQ.m+gmSEQ.halfpi+AfterPi+Detect_Window+Wait_p;

gmSEQ.CHN(1).PBN=PBDictionary('ctr0');
gmSEQ.CHN(1).NRise=4;
gmSEQ.CHN(1).T=[Wait_p+gmSEQ.readout-1000-gmSEQ.CtrGateDur, ...
    Wait_p+gmSEQ.readout+AfterLaser+gmSEQ.halfpi+Cycle*gmSEQ.m+gmSEQ.halfpi+AfterPi, ...
    Sig_D_start+gmSEQ.readout-1000-gmSEQ.CtrGateDur, ... 
    Sig_D_start+gmSEQ.readout+AfterLaser+gmSEQ.halfpi+Cycle*gmSEQ.m+gmSEQ.halfpi+AfterPi];
if strcmp(gmSEQ.meas,'SPCM')
    gmSEQ.CHN(1).DT=[gmSEQ.CtrGateDur gmSEQ.CtrGateDur gmSEQ.CtrGateDur gmSEQ.CtrGateDur];
elseif strcmp(gmSEQ.meas,'APD')
    gmSEQ.CHN(1).DT=[1000 1000 1000 1000];
end

gmSEQ.CHN(numel(gmSEQ.CHN)+1).PBN=PBDictionary('AOM');
gmSEQ.CHN(numel(gmSEQ.CHN)).NRise=4;
gmSEQ.CHN(numel(gmSEQ.CHN)).T = [Wait_p, Wait_p+gmSEQ.readout+AfterLaser+gmSEQ.halfpi+Cycle*gmSEQ.m+gmSEQ.halfpi+AfterPi, ...
    Sig_D_start, Sig_D_start+gmSEQ.readout+AfterLaser+gmSEQ.halfpi+Cycle*gmSEQ.m+gmSEQ.halfpi+AfterPi];
gmSEQ.CHN(numel(gmSEQ.CHN)).DT = [gmSEQ.readout Detect_Window gmSEQ.readout Detect_Window];


gmSEQ.CHN(numel(gmSEQ.CHN)+1).PBN=PBDictionary('AWGTrig');
gmSEQ.CHN(numel(gmSEQ.CHN)).NRise=2;
gmSEQ.CHN(numel(gmSEQ.CHN)).T=[Wait_p+gmSEQ.readout+AfterLaser, ...
    Sig_D_start+gmSEQ.readout+AfterLaser];
gmSEQ.CHN(numel(gmSEQ.CHN)).DT=repelem(gmSEQ.halfpi+Cycle*gmSEQ.m+gmSEQ.halfpi+200, 2);

gmSEQ.CHN(numel(gmSEQ.CHN)+1).PBN=PBDictionary('MWSwitch');
if gmSEQ.m == 0
        gmSEQ.CHN(numel(gmSEQ.CHN)).NRise=2;
        gmSEQ.CHN(numel(gmSEQ.CHN)).T=[Wait_p+gmSEQ.readout+AfterLaser-20, Sig_D_start+gmSEQ.readout+AfterLaser-20];
        gmSEQ.CHN(numel(gmSEQ.CHN)).DT=[gmSEQ.halfpi+gmSEQ.halfpi+40, gmSEQ.halfpi+gmSEQ.halfpi+40];
else
    if gmSEQ.interval < 120
        gmSEQ.CHN(numel(gmSEQ.CHN)).NRise=2;
        gmSEQ.CHN(numel(gmSEQ.CHN)).T=[Wait_p+gmSEQ.readout+AfterLaser-20, Sig_D_start+gmSEQ.readout+AfterLaser-20];
        gmSEQ.CHN(numel(gmSEQ.CHN)).DT=[gmSEQ.halfpi+Cycle*gmSEQ.m+gmSEQ.halfpi+100, gmSEQ.halfpi+Cycle*gmSEQ.m+gmSEQ.halfpi+100];
    else
        gmSEQ.CHN(numel(gmSEQ.CHN)).NRise=2*(48*gmSEQ.m + 2);
        gmSEQ.CHN(numel(gmSEQ.CHN)).T = zeros(1, 2*(48*gmSEQ.m + 2));
        gmSEQ.CHN(numel(gmSEQ.CHN)).T(1) = Wait_p+gmSEQ.readout+AfterLaser-20;
        for i = 1:gmSEQ.m
            for j = 1:48
             gmSEQ.CHN(numel(gmSEQ.CHN)).T(1+(i-1)*48+j) = Wait_p+gmSEQ.readout+AfterLaser+gmSEQ.halfpi+gmSEQ.interval/2+(i-1+(j-1)/48)*Cycle-20;
            end
        end
        gmSEQ.CHN(numel(gmSEQ.CHN)).T(1+48*gmSEQ.m+1) = Wait_p+gmSEQ.readout+AfterLaser+gmSEQ.halfpi+gmSEQ.m*Cycle-20;
        gmSEQ.CHN(numel(gmSEQ.CHN)).T(1+48*gmSEQ.m+2) = Sig_D_start+gmSEQ.readout+AfterLaser-20;
        for i = 1:gmSEQ.m
            for j = 1:48
             gmSEQ.CHN(numel(gmSEQ.CHN)).T(3+48*gmSEQ.m+(i-1)*48+j) = Sig_D_start+gmSEQ.readout+AfterLaser+gmSEQ.halfpi+gmSEQ.interval/2+(i-1+(j-1)/48)*Cycle-20;
            end
        end
        gmSEQ.CHN(numel(gmSEQ.CHN)).T(3+96*gmSEQ.m+1) = Sig_D_start+gmSEQ.readout+AfterLaser+gmSEQ.halfpi+gmSEQ.m*Cycle-20;
        gmSEQ.CHN(numel(gmSEQ.CHN)).DT=[gmSEQ.halfpi+40, repelem(gmSEQ.pi+40, 48*gmSEQ.m), gmSEQ.halfpi+40, ... 
            gmSEQ.halfpi+40, repelem(gmSEQ.pi+40, 48*gmSEQ.m), gmSEQ.halfpi+40];
    end
end

gmSEQ.CHN(numel(gmSEQ.CHN)+1).PBN=PBDictionary('dummy1');
gmSEQ.CHN(numel(gmSEQ.CHN)).NRise=2;
gmSEQ.CHN(numel(gmSEQ.CHN)).T=[0 Sig_D_start+gmSEQ.readout+AfterLaser+gmSEQ.halfpi+gmSEQ.m*Cycle+gmSEQ.halfpi+AfterPi+Detect_Window-50];
gmSEQ.CHN(numel(gmSEQ.CHN)).DT=[50 50];

%% AWG
% Initialization
chaseFunctionPool('stopChase',  gmSEQ.MWAWG)

% This part need to be modified to accomodate the DC modulation
if gSG.ACmodAWG % in AC modulation mode
    gSG.AWGFreq = gSG.AWGFreq;
else
    gSG.AWGFreq = 0;
end

WaveForm_1I = zeros(2 + 60*gmSEQ.m, 5);
WaveForm_1I(1, :) = [0 gmSEQ.halfpi gSG.AWGFreq 0 gSG.halfpiAWGAmp]; 
for i = 1:gmSEQ.m
    WaveForm_1I(1 + (i-1)*60 + 1, :) = [gmSEQ.halfpi+gmSEQ.interval/2+(i-1+0/48)*Cycle gmSEQ.halfpi+gmSEQ.interval/2+(i-1+0/48)*Cycle+gmSEQ.pi gSG.AWGFreq 0 gSG.piAWGAmp]; % pi_x
    WaveForm_1I(1 + (i-1)*60 + 2, :) = [gmSEQ.halfpi+gmSEQ.interval/2+(i-1+1/48)*Cycle gmSEQ.halfpi+gmSEQ.interval/2+(i-1+1/48)*Cycle+gmSEQ.pi/2 gSG.AWGFreq 0 gSG.piAWGAmp]; % pi/2_x
    WaveForm_1I(1 + (i-1)*60 + 3, :) = [gmSEQ.halfpi+gmSEQ.interval/2+(i-1+1/48)*Cycle+gmSEQ.pi/2+PulseGap gmSEQ.halfpi+gmSEQ.interval/2+(i-1+1/48)*Cycle+PulseGap+gmSEQ.pi gSG.AWGFreq 3*pi/2 gSG.piAWGAmp]; % -pi/2_y
    WaveForm_1I(1 + (i-1)*60 + 4, :) = [gmSEQ.halfpi+gmSEQ.interval/2+(i-1+2/48)*Cycle gmSEQ.halfpi+gmSEQ.interval/2+(i-1+2/48)*Cycle+gmSEQ.pi gSG.AWGFreq pi gSG.piAWGAmp]; % -pi_x
    WaveForm_1I(1 + (i-1)*60 + 5, :) = [gmSEQ.halfpi+gmSEQ.interval/2+(i-1+3/48)*Cycle gmSEQ.halfpi+gmSEQ.interval/2+(i-1+3/48)*Cycle+gmSEQ.pi gSG.AWGFreq pi gSG.piAWGAmp]; % -pi_x
    WaveForm_1I(1 + (i-1)*60 + 6, :) = [gmSEQ.halfpi+gmSEQ.interval/2+(i-1+4/48)*Cycle gmSEQ.halfpi+gmSEQ.interval/2+(i-1+4/48)*Cycle+gmSEQ.pi gSG.AWGFreq 0 gSG.piAWGAmp]; % pi_x
    WaveForm_1I(1 + (i-1)*60 + 7, :) = [gmSEQ.halfpi+gmSEQ.interval/2+(i-1+5/48)*Cycle gmSEQ.halfpi+gmSEQ.interval/2+(i-1+5/48)*Cycle+gmSEQ.pi/2 gSG.AWGFreq 0 gSG.piAWGAmp]; % pi/2_x
    WaveForm_1I(1 + (i-1)*60 + 8, :) = [gmSEQ.halfpi+gmSEQ.interval/2+(i-1+5/48)*Cycle+gmSEQ.pi/2+PulseGap gmSEQ.halfpi+gmSEQ.interval/2+(i-1+5/48)*Cycle+PulseGap+gmSEQ.pi gSG.AWGFreq 3*pi/2 gSG.piAWGAmp]; % -pi/2_y
    WaveForm_1I(1 + (i-1)*60 + 9, :) = [gmSEQ.halfpi+gmSEQ.interval/2+(i-1+6/48)*Cycle gmSEQ.halfpi+gmSEQ.interval/2+(i-1+6/48)*Cycle+gmSEQ.pi gSG.AWGFreq pi gSG.piAWGAmp]; % -pi_x
    WaveForm_1I(1 + (i-1)*60 + 10, :) = [gmSEQ.halfpi+gmSEQ.interval/2+(i-1+7/48)*Cycle gmSEQ.halfpi+gmSEQ.interval/2+(i-1+7/48)*Cycle+gmSEQ.pi gSG.AWGFreq pi gSG.piAWGAmp]; % -pi_x
    WaveForm_1I(1 + (i-1)*60 + 11, :) = [gmSEQ.halfpi+gmSEQ.interval/2+(i-1+8/48)*Cycle gmSEQ.halfpi+gmSEQ.interval/2+(i-1+8/48)*Cycle+gmSEQ.pi gSG.AWGFreq 0 gSG.piAWGAmp]; % pi_x
    WaveForm_1I(1 + (i-1)*60 + 12, :) = [gmSEQ.halfpi+gmSEQ.interval/2+(i-1+9/48)*Cycle gmSEQ.halfpi+gmSEQ.interval/2+(i-1+9/48)*Cycle+gmSEQ.pi/2 gSG.AWGFreq 0 gSG.piAWGAmp]; % pi/2_x
    WaveForm_1I(1 + (i-1)*60 + 13, :) = [gmSEQ.halfpi+gmSEQ.interval/2+(i-1+9/48)*Cycle+gmSEQ.pi/2+PulseGap gmSEQ.halfpi+gmSEQ.interval/2+(i-1+9/48)*Cycle+PulseGap+gmSEQ.pi gSG.AWGFreq 3*pi/2 gSG.piAWGAmp]; % -pi/2_y
    WaveForm_1I(1 + (i-1)*60 + 14, :) = [gmSEQ.halfpi+gmSEQ.interval/2+(i-1+10/48)*Cycle gmSEQ.halfpi+gmSEQ.interval/2+(i-1+10/48)*Cycle+gmSEQ.pi gSG.AWGFreq pi gSG.piAWGAmp]; % -pi_x
    WaveForm_1I(1 + (i-1)*60 + 15, :) = [gmSEQ.halfpi+gmSEQ.interval/2+(i-1+11/48)*Cycle gmSEQ.halfpi+gmSEQ.interval/2+(i-1+11/48)*Cycle+gmSEQ.pi gSG.AWGFreq pi gSG.piAWGAmp]; % -pi_x
    WaveForm_1I(1 + (i-1)*60 + 16, :) = [gmSEQ.halfpi+gmSEQ.interval/2+(i-1+12/48)*Cycle gmSEQ.halfpi+gmSEQ.interval/2+(i-1+12/48)*Cycle+gmSEQ.pi gSG.AWGFreq 3*pi/2 gSG.piAWGAmp]; % -pi_y
    WaveForm_1I(1 + (i-1)*60 + 17, :) = [gmSEQ.halfpi+gmSEQ.interval/2+(i-1+13/48)*Cycle gmSEQ.halfpi+gmSEQ.interval/2+(i-1+13/48)*Cycle+gmSEQ.pi/2 gSG.AWGFreq 3*pi/2 gSG.piAWGAmp]; % -pi/2_y
    WaveForm_1I(1 + (i-1)*60 + 18, :) = [gmSEQ.halfpi+gmSEQ.interval/2+(i-1+13/48)*Cycle+gmSEQ.pi/2+PulseGap gmSEQ.halfpi+gmSEQ.interval/2+(i-1+13/48)*Cycle+PulseGap+gmSEQ.pi gSG.AWGFreq 0 gSG.piAWGAmp]; % pi/2_x
    WaveForm_1I(1 + (i-1)*60 + 19, :) = [gmSEQ.halfpi+gmSEQ.interval/2+(i-1+14/48)*Cycle gmSEQ.halfpi+gmSEQ.interval/2+(i-1+14/48)*Cycle+gmSEQ.pi gSG.AWGFreq pi/2 gSG.piAWGAmp]; % pi_y
    WaveForm_1I(1 + (i-1)*60 + 20, :) = [gmSEQ.halfpi+gmSEQ.interval/2+(i-1+15/48)*Cycle gmSEQ.halfpi+gmSEQ.interval/2+(i-1+15/48)*Cycle+gmSEQ.pi gSG.AWGFreq pi/2 gSG.piAWGAmp]; % pi_y
    WaveForm_1I(1 + (i-1)*60 + 21, :) = [gmSEQ.halfpi+gmSEQ.interval/2+(i-1+16/48)*Cycle gmSEQ.halfpi+gmSEQ.interval/2+(i-1+16/48)*Cycle+gmSEQ.pi gSG.AWGFreq 3*pi/2 gSG.piAWGAmp]; % -pi_y
    WaveForm_1I(1 + (i-1)*60 + 22, :) = [gmSEQ.halfpi+gmSEQ.interval/2+(i-1+17/48)*Cycle gmSEQ.halfpi+gmSEQ.interval/2+(i-1+17/48)*Cycle+gmSEQ.pi/2 gSG.AWGFreq 3*pi/2 gSG.piAWGAmp]; % -pi/2_y
    WaveForm_1I(1 + (i-1)*60 + 23, :) = [gmSEQ.halfpi+gmSEQ.interval/2+(i-1+17/48)*Cycle+gmSEQ.pi/2+PulseGap gmSEQ.halfpi+gmSEQ.interval/2+(i-1+17/48)*Cycle+PulseGap+gmSEQ.pi gSG.AWGFreq 0 gSG.piAWGAmp]; % pi/2_x
    WaveForm_1I(1 + (i-1)*60 + 24, :) = [gmSEQ.halfpi+gmSEQ.interval/2+(i-1+18/48)*Cycle gmSEQ.halfpi+gmSEQ.interval/2+(i-1+18/48)*Cycle+gmSEQ.pi gSG.AWGFreq pi/2 gSG.piAWGAmp]; % pi_y
    WaveForm_1I(1 + (i-1)*60 + 25, :) = [gmSEQ.halfpi+gmSEQ.interval/2+(i-1+19/48)*Cycle gmSEQ.halfpi+gmSEQ.interval/2+(i-1+19/48)*Cycle+gmSEQ.pi gSG.AWGFreq pi/2 gSG.piAWGAmp]; % pi_y
    WaveForm_1I(1 + (i-1)*60 + 26, :) = [gmSEQ.halfpi+gmSEQ.interval/2+(i-1+20/48)*Cycle gmSEQ.halfpi+gmSEQ.interval/2+(i-1+20/48)*Cycle+gmSEQ.pi gSG.AWGFreq 3*pi/2 gSG.piAWGAmp]; % -pi_y
    WaveForm_1I(1 + (i-1)*60 + 27, :) = [gmSEQ.halfpi+gmSEQ.interval/2+(i-1+21/48)*Cycle gmSEQ.halfpi+gmSEQ.interval/2+(i-1+21/48)*Cycle+gmSEQ.pi/2 gSG.AWGFreq 3*pi/2 gSG.piAWGAmp]; % -pi/2_y
    WaveForm_1I(1 + (i-1)*60 + 28, :) = [gmSEQ.halfpi+gmSEQ.interval/2+(i-1+21/48)*Cycle+gmSEQ.pi/2+PulseGap gmSEQ.halfpi+gmSEQ.interval/2+(i-1+21/48)*Cycle+PulseGap+gmSEQ.pi gSG.AWGFreq 0 gSG.piAWGAmp]; % pi/2_x
    WaveForm_1I(1 + (i-1)*60 + 29, :) = [gmSEQ.halfpi+gmSEQ.interval/2+(i-1+22/48)*Cycle gmSEQ.halfpi+gmSEQ.interval/2+(i-1+22/48)*Cycle+gmSEQ.pi gSG.AWGFreq pi/2 gSG.piAWGAmp]; % pi_y
    WaveForm_1I(1 + (i-1)*60 + 30, :) = [gmSEQ.halfpi+gmSEQ.interval/2+(i-1+23/48)*Cycle gmSEQ.halfpi+gmSEQ.interval/2+(i-1+23/48)*Cycle+gmSEQ.pi gSG.AWGFreq pi/2 gSG.piAWGAmp]; % pi_y
    WaveForm_1I(1 + (i-1)*60 + 31, :) = [gmSEQ.halfpi+gmSEQ.interval/2+(i-1+24/48)*Cycle gmSEQ.halfpi+gmSEQ.interval/2+(i-1+24/48)*Cycle+gmSEQ.pi gSG.AWGFreq 3*pi/2 gSG.piAWGAmp]; % -pi_y
    WaveForm_1I(1 + (i-1)*60 + 32, :) = [gmSEQ.halfpi+gmSEQ.interval/2+(i-1+25/48)*Cycle gmSEQ.halfpi+gmSEQ.interval/2+(i-1+25/48)*Cycle+gmSEQ.pi/2 gSG.AWGFreq 0 gSG.piAWGAmp]; % pi/2_x
    WaveForm_1I(1 + (i-1)*60 + 33, :) = [gmSEQ.halfpi+gmSEQ.interval/2+(i-1+25/48)*Cycle+gmSEQ.pi/2+PulseGap gmSEQ.halfpi+gmSEQ.interval/2+(i-1+25/48)*Cycle+PulseGap+gmSEQ.pi gSG.AWGFreq pi/2 gSG.piAWGAmp]; % pi/2_y
    WaveForm_1I(1 + (i-1)*60 + 34, :) = [gmSEQ.halfpi+gmSEQ.interval/2+(i-1+26/48)*Cycle gmSEQ.halfpi+gmSEQ.interval/2+(i-1+26/48)*Cycle+gmSEQ.pi gSG.AWGFreq pi/2 gSG.piAWGAmp]; % pi_y
    WaveForm_1I(1 + (i-1)*60 + 35, :) = [gmSEQ.halfpi+gmSEQ.interval/2+(i-1+27/48)*Cycle gmSEQ.halfpi+gmSEQ.interval/2+(i-1+27/48)*Cycle+gmSEQ.pi gSG.AWGFreq 3*pi/2 gSG.piAWGAmp]; % -pi_y
    WaveForm_1I(1 + (i-1)*60 + 36, :) = [gmSEQ.halfpi+gmSEQ.interval/2+(i-1+28/48)*Cycle gmSEQ.halfpi+gmSEQ.interval/2+(i-1+28/48)*Cycle+gmSEQ.pi gSG.AWGFreq 3*pi/2 gSG.piAWGAmp]; % -pi_y
    WaveForm_1I(1 + (i-1)*60 + 37, :) = [gmSEQ.halfpi+gmSEQ.interval/2+(i-1+29/48)*Cycle gmSEQ.halfpi+gmSEQ.interval/2+(i-1+29/48)*Cycle+gmSEQ.pi/2 gSG.AWGFreq 0 gSG.piAWGAmp]; % pi/2_x
    WaveForm_1I(1 + (i-1)*60 + 38, :) = [gmSEQ.halfpi+gmSEQ.interval/2+(i-1+29/48)*Cycle+gmSEQ.pi/2+PulseGap gmSEQ.halfpi+gmSEQ.interval/2+(i-1+29/48)*Cycle+PulseGap+gmSEQ.pi gSG.AWGFreq pi/2 gSG.piAWGAmp]; % pi/2_y
    WaveForm_1I(1 + (i-1)*60 + 39, :) = [gmSEQ.halfpi+gmSEQ.interval/2+(i-1+30/48)*Cycle gmSEQ.halfpi+gmSEQ.interval/2+(i-1+30/48)*Cycle+gmSEQ.pi gSG.AWGFreq pi/2 gSG.piAWGAmp]; % pi_y
    WaveForm_1I(1 + (i-1)*60 + 40, :) = [gmSEQ.halfpi+gmSEQ.interval/2+(i-1+31/48)*Cycle gmSEQ.halfpi+gmSEQ.interval/2+(i-1+31/48)*Cycle+gmSEQ.pi gSG.AWGFreq 3*pi/2 gSG.piAWGAmp]; % -pi_y
    WaveForm_1I(1 + (i-1)*60 + 41, :) = [gmSEQ.halfpi+gmSEQ.interval/2+(i-1+32/48)*Cycle gmSEQ.halfpi+gmSEQ.interval/2+(i-1+32/48)*Cycle+gmSEQ.pi gSG.AWGFreq 3*pi/2 gSG.piAWGAmp]; % -pi_y
    WaveForm_1I(1 + (i-1)*60 + 42, :) = [gmSEQ.halfpi+gmSEQ.interval/2+(i-1+33/48)*Cycle gmSEQ.halfpi+gmSEQ.interval/2+(i-1+33/48)*Cycle+gmSEQ.pi/2 gSG.AWGFreq 0 gSG.piAWGAmp]; % pi/2_x
    WaveForm_1I(1 + (i-1)*60 + 43, :) = [gmSEQ.halfpi+gmSEQ.interval/2+(i-1+33/48)*Cycle+gmSEQ.pi/2+PulseGap gmSEQ.halfpi+gmSEQ.interval/2+(i-1+33/48)*Cycle+PulseGap+gmSEQ.pi gSG.AWGFreq pi/2 gSG.piAWGAmp]; % pi/2_y
    WaveForm_1I(1 + (i-1)*60 + 44, :) = [gmSEQ.halfpi+gmSEQ.interval/2+(i-1+34/48)*Cycle gmSEQ.halfpi+gmSEQ.interval/2+(i-1+34/48)*Cycle+gmSEQ.pi gSG.AWGFreq pi/2 gSG.piAWGAmp]; % pi_y
    WaveForm_1I(1 + (i-1)*60 + 45, :) = [gmSEQ.halfpi+gmSEQ.interval/2+(i-1+35/48)*Cycle gmSEQ.halfpi+gmSEQ.interval/2+(i-1+35/48)*Cycle+gmSEQ.pi gSG.AWGFreq pi gSG.piAWGAmp]; % -pi_x
    WaveForm_1I(1 + (i-1)*60 + 46, :) = [gmSEQ.halfpi+gmSEQ.interval/2+(i-1+36/48)*Cycle gmSEQ.halfpi+gmSEQ.interval/2+(i-1+36/48)*Cycle+gmSEQ.pi gSG.AWGFreq pi gSG.piAWGAmp]; % -pi_x
    WaveForm_1I(1 + (i-1)*60 + 47, :) = [gmSEQ.halfpi+gmSEQ.interval/2+(i-1+37/48)*Cycle gmSEQ.halfpi+gmSEQ.interval/2+(i-1+37/48)*Cycle+gmSEQ.pi/2 gSG.AWGFreq pi/2 gSG.piAWGAmp]; % pi/2_y
    WaveForm_1I(1 + (i-1)*60 + 48, :) = [gmSEQ.halfpi+gmSEQ.interval/2+(i-1+37/48)*Cycle+gmSEQ.pi/2+PulseGap gmSEQ.halfpi+gmSEQ.interval/2+(i-1+37/48)*Cycle+PulseGap+gmSEQ.pi gSG.AWGFreq 0 gSG.piAWGAmp]; % pi/2_x
    WaveForm_1I(1 + (i-1)*60 + 49, :) = [gmSEQ.halfpi+gmSEQ.interval/2+(i-1+38/48)*Cycle gmSEQ.halfpi+gmSEQ.interval/2+(i-1+38/48)*Cycle+gmSEQ.pi gSG.AWGFreq 0 gSG.piAWGAmp]; % pi_x
    WaveForm_1I(1 + (i-1)*60 + 50, :) = [gmSEQ.halfpi+gmSEQ.interval/2+(i-1+39/48)*Cycle gmSEQ.halfpi+gmSEQ.interval/2+(i-1+39/48)*Cycle+gmSEQ.pi gSG.AWGFreq pi gSG.piAWGAmp]; % -pi_x
    WaveForm_1I(1 + (i-1)*60 + 51, :) = [gmSEQ.halfpi+gmSEQ.interval/2+(i-1+40/48)*Cycle gmSEQ.halfpi+gmSEQ.interval/2+(i-1+40/48)*Cycle+gmSEQ.pi gSG.AWGFreq pi gSG.piAWGAmp]; % -pi_x
    WaveForm_1I(1 + (i-1)*60 + 52, :) = [gmSEQ.halfpi+gmSEQ.interval/2+(i-1+41/48)*Cycle gmSEQ.halfpi+gmSEQ.interval/2+(i-1+41/48)*Cycle+gmSEQ.pi/2 gSG.AWGFreq pi/2 gSG.piAWGAmp]; % pi/2_y
    WaveForm_1I(1 + (i-1)*60 + 53, :) = [gmSEQ.halfpi+gmSEQ.interval/2+(i-1+41/48)*Cycle+gmSEQ.pi/2+PulseGap gmSEQ.halfpi+gmSEQ.interval/2+(i-1+41/48)*Cycle+PulseGap+gmSEQ.pi gSG.AWGFreq 0 gSG.piAWGAmp]; % pi/2_x
    WaveForm_1I(1 + (i-1)*60 + 54, :) = [gmSEQ.halfpi+gmSEQ.interval/2+(i-1+42/48)*Cycle gmSEQ.halfpi+gmSEQ.interval/2+(i-1+42/48)*Cycle+gmSEQ.pi gSG.AWGFreq 0 gSG.piAWGAmp]; % pi_x
    WaveForm_1I(1 + (i-1)*60 + 55, :) = [gmSEQ.halfpi+gmSEQ.interval/2+(i-1+43/48)*Cycle gmSEQ.halfpi+gmSEQ.interval/2+(i-1+43/48)*Cycle+gmSEQ.pi gSG.AWGFreq pi gSG.piAWGAmp]; % -pi_x
    WaveForm_1I(1 + (i-1)*60 + 56, :) = [gmSEQ.halfpi+gmSEQ.interval/2+(i-1+44/48)*Cycle gmSEQ.halfpi+gmSEQ.interval/2+(i-1+44/48)*Cycle+gmSEQ.pi gSG.AWGFreq pi gSG.piAWGAmp]; % -pi_x
    WaveForm_1I(1 + (i-1)*60 + 57, :) = [gmSEQ.halfpi+gmSEQ.interval/2+(i-1+45/48)*Cycle gmSEQ.halfpi+gmSEQ.interval/2+(i-1+45/48)*Cycle+gmSEQ.pi/2 gSG.AWGFreq pi/2 gSG.piAWGAmp]; % pi/2_y
    WaveForm_1I(1 + (i-1)*60 + 58, :) = [gmSEQ.halfpi+gmSEQ.interval/2+(i-1+45/48)*Cycle+gmSEQ.pi/2+PulseGap gmSEQ.halfpi+gmSEQ.interval/2+(i-1+45/48)*Cycle+PulseGap+gmSEQ.pi gSG.AWGFreq 0 gSG.piAWGAmp]; % pi/2_x
    WaveForm_1I(1 + (i-1)*60 + 59, :) = [gmSEQ.halfpi+gmSEQ.interval/2+(i-1+46/48)*Cycle gmSEQ.halfpi+gmSEQ.interval/2+(i-1+46/48)*Cycle+gmSEQ.pi gSG.AWGFreq 0 gSG.piAWGAmp]; % pi_x
    WaveForm_1I(1 + (i-1)*60 + 60, :) = [gmSEQ.halfpi+gmSEQ.interval/2+(i-1+47/48)*Cycle gmSEQ.halfpi+gmSEQ.interval/2+(i-1+47/48)*Cycle+gmSEQ.pi gSG.AWGFreq 3*pi/2 gSG.piAWGAmp]; % -pi_y
end
WaveForm_1I(2 + 60*gmSEQ.m, :) = [gmSEQ.halfpi+gmSEQ.m*Cycle gmSEQ.halfpi+gmSEQ.m*Cycle+gmSEQ.halfpi  gSG.AWGFreq pi gSG.halfpiAWGAmp]; 

WaveForm_1Q = WaveForm_1I - repmat([0 0 0 pi/2 0], size(WaveForm_1I, 1), 1);
WaveForm_1Length = ceil((gmSEQ.halfpi+gmSEQ.m*Cycle+gmSEQ.halfpi+1000) / (16 / gSG.AWGClockRate)) ...
    *(16 / gSG.AWGClockRate);
WaveForm_1PointNum = WaveForm_1Length * gSG.AWGClockRate;

WaveForm_2I = WaveForm_1I;
WaveForm_2I(size(WaveForm_2I, 1), :) = [gmSEQ.halfpi+gmSEQ.m*Cycle gmSEQ.halfpi+gmSEQ.m*Cycle+gmSEQ.halfpi gSG.AWGFreq 0 gSG.halfpiAWGAmp]; % Differential measurement
WaveForm_2Q = WaveForm_2I - repmat([0 0 0 pi/2 0], size(WaveForm_2I, 1), 1);
WaveForm_2Length = WaveForm_1Length;
WaveForm_2PointNum = WaveForm_2Length * gSG.AWGClockRate;

chaseFunctionPool('createWaveform', WaveForm_1I, gSG.AWGClockRate, WaveForm_1Length, 'DROID60N_I_seg1.txt'); pause(0.5);
chaseFunctionPool('createWaveform', WaveForm_1Q, gSG.AWGClockRate, WaveForm_1Length, 'DROID60N_Q_seg1.txt'); pause(0.5);
chaseFunctionPool('createWaveform', WaveForm_2I, gSG.AWGClockRate, WaveForm_2Length, 'DROID60N_I_seg2.txt'); pause(0.5);
chaseFunctionPool('createWaveform', WaveForm_2Q, gSG.AWGClockRate, WaveForm_2Length, 'DROID60N_Q_seg2.txt'); pause(0.5);

chaseFunctionPool('createSegStruct', 'DROID60N_SegStruct_I.txt', ...
    'DROID60N_I_seg1.txt', WaveForm_1PointNum, 1, 1, ...
    'DROID60N_I_seg2.txt', WaveForm_2PointNum, 1, 1);
pause(0.5);
chaseFunctionPool('createSegStruct', 'DROID60N_SegStruct_Q.txt', ...
    'DROID60N_Q_seg1.txt', WaveForm_1PointNum, 1, 1, ...
    'DROID60N_Q_seg2.txt', WaveForm_2PointNum, 1, 1);
pause(0.5);

%% Load waveform to AWG
chaseFunctionPool('CreateSegments', gmSEQ.MWAWG, 1, ...
    2, ...
    2047, 2047, 'DROID60N_SegStruct_I.txt', 'false');
pause(1); % this pause seems to be important, otherwise the loading is not right occassionally
chaseFunctionPool('CreateSegments', gmSEQ.MWAWG, 2, ...
    2, ...
    2047, 2047, 'DROID60N_SegStruct_Q.txt', 'false');
pause(1); % this pause seems to be important, otherwise the loading is not right occassionally
%% Run waveform
chaseFunctionPool('runChase', gmSEQ.MWAWG, 'false');
ApplyDelays();

function DROID60N % Put in the north/south pole
global gmSEQ gSG
gSG.bfixedPow=1;
gSG.bfixedFreq=1;
gSG.bMod='IQ';
gSG.bModSrc='External';

[gmSEQ.ScaleT, gmSEQ.ScaleStr] = GetScale(48*(gmSEQ.pi+gmSEQ.interval)*gmSEQ.To);

% TODO: add the definition for the pi and halfpi pulse AWG amp
gSG.piAWGAmp = gmSEQ.SAmp1; % Just for temporary use
gSG.halfpiAWGAmp = gmSEQ.SAmp2; % Just for temporary use

% gmSEQ.m here is the repetition number of XY8 block
gmSEQ.m = round(gmSEQ.m);

AfterPi = 1000;
AfterLaser = 100e3;
Wait_p = 10e3;
Detect_Window = 5000;
PulseGap = 0;

Cycle = (gmSEQ.interval + gmSEQ.pi)*48;
Sig_D_start = Wait_p+gmSEQ.readout+AfterLaser+Cycle*gmSEQ.m+gmSEQ.pi+AfterPi+Detect_Window+Wait_p;

gmSEQ.CHN(1).PBN=PBDictionary('ctr0');
gmSEQ.CHN(1).NRise=4;
gmSEQ.CHN(1).T=[Wait_p+gmSEQ.readout-1000-gmSEQ.CtrGateDur, ...
    Wait_p+gmSEQ.readout+AfterLaser+Cycle*gmSEQ.m+gmSEQ.pi+AfterPi, ...
    Sig_D_start+gmSEQ.readout-1000-gmSEQ.CtrGateDur, ... 
    Sig_D_start+gmSEQ.readout+AfterLaser+Cycle*gmSEQ.m+gmSEQ.pi+AfterPi];
if strcmp(gmSEQ.meas,'SPCM')
    gmSEQ.CHN(1).DT=[gmSEQ.CtrGateDur gmSEQ.CtrGateDur gmSEQ.CtrGateDur gmSEQ.CtrGateDur];
elseif strcmp(gmSEQ.meas,'APD')
    gmSEQ.CHN(1).DT=[1000 1000 1000 1000];
end

gmSEQ.CHN(numel(gmSEQ.CHN)+1).PBN=PBDictionary('AOM');
gmSEQ.CHN(numel(gmSEQ.CHN)).NRise=4;
gmSEQ.CHN(numel(gmSEQ.CHN)).T = [Wait_p, Wait_p+gmSEQ.readout+AfterLaser+Cycle*gmSEQ.m+gmSEQ.pi+AfterPi, ...
    Sig_D_start, Sig_D_start+gmSEQ.readout+AfterLaser+Cycle*gmSEQ.m+gmSEQ.pi+AfterPi];
gmSEQ.CHN(numel(gmSEQ.CHN)).DT = [gmSEQ.readout Detect_Window gmSEQ.readout Detect_Window];


gmSEQ.CHN(numel(gmSEQ.CHN)+1).PBN=PBDictionary('AWGTrig');
gmSEQ.CHN(numel(gmSEQ.CHN)).NRise=2;
gmSEQ.CHN(numel(gmSEQ.CHN)).T=[Wait_p+gmSEQ.readout+AfterLaser, ...
    Sig_D_start+gmSEQ.readout+AfterLaser];
gmSEQ.CHN(numel(gmSEQ.CHN)).DT=repelem(Cycle*gmSEQ.m+gmSEQ.pi+200, 2);

gmSEQ.CHN(numel(gmSEQ.CHN)+1).PBN=PBDictionary('MWSwitch');
if gmSEQ.m == 0
        gmSEQ.CHN(numel(gmSEQ.CHN)).NRise=1;
        gmSEQ.CHN(numel(gmSEQ.CHN)).T= Sig_D_start+gmSEQ.readout+AfterLaser-20 ;
        gmSEQ.CHN(numel(gmSEQ.CHN)).DT= gmSEQ.pi+40;
else
    if gmSEQ.interval < 1200
        gmSEQ.CHN(numel(gmSEQ.CHN)).NRise=2;
        gmSEQ.CHN(numel(gmSEQ.CHN)).T=[Wait_p+gmSEQ.readout+AfterLaser-20, Sig_D_start+gmSEQ.readout+AfterLaser-20];
        gmSEQ.CHN(numel(gmSEQ.CHN)).DT=[Cycle*gmSEQ.m+gmSEQ.pi+40, Cycle*gmSEQ.m+gmSEQ.pi+40];
    else
        gmSEQ.CHN(numel(gmSEQ.CHN)).NRise=96*gmSEQ.m + 1;
        gmSEQ.CHN(numel(gmSEQ.CHN)).T = zeros(1, gmSEQ.CHN(numel(gmSEQ.CHN)).NRise);
        for i = 1:gmSEQ.m
            for j = 1:48
             gmSEQ.CHN(numel(gmSEQ.CHN)).T((i-1)*48+j) = Wait_p+gmSEQ.readout+AfterLaser+gmSEQ.interval/2+(i-1+(j-1)/48)*Cycle-20;
             gmSEQ.CHN(numel(gmSEQ.CHN)).T(48*gmSEQ.m+(i-1)*48+j) = Sig_D_start+gmSEQ.readout+AfterLaser+gmSEQ.interval/2+(i-1+(j-1)/48)*Cycle-20;
            end
        end
        gmSEQ.CHN(numel(gmSEQ.CHN)).T(96*gmSEQ.m+1) = Sig_D_start+gmSEQ.readout+AfterLaser+gmSEQ.m*Cycle-20;
        gmSEQ.CHN(numel(gmSEQ.CHN)).DT=[repelem(gmSEQ.pi+40, 96*gmSEQ.m), gmSEQ.pi+40];
    end
end

gmSEQ.CHN(numel(gmSEQ.CHN)+1).PBN=PBDictionary('dummy1');
gmSEQ.CHN(numel(gmSEQ.CHN)).NRise=2;
gmSEQ.CHN(numel(gmSEQ.CHN)).T=[0 Sig_D_start+gmSEQ.readout+AfterLaser+gmSEQ.m*Cycle+gmSEQ.pi+AfterPi+Detect_Window-50];
gmSEQ.CHN(numel(gmSEQ.CHN)).DT=[50 50];

%% AWG
% Initialization
chaseFunctionPool('stopChase',  gmSEQ.MWAWG)

% This part need to be modified to accomodate the DC modulation
if ~gSG.ACmodAWG % in AC modulation mode
    gSG.AWGFreq = 0;
end

WaveForm_1I = zeros(2 + 60*gmSEQ.m, 5);
WaveForm_1I(1, :) = [0 gmSEQ.interval/2 gSG.AWGFreq 0 0];
for i = 1:gmSEQ.m
    WaveForm_1I(1 + (i-1)*60 + 1, :) = [gmSEQ.interval/2+(i-1+0/48)*Cycle gmSEQ.interval/2+(i-1+0/48)*Cycle+gmSEQ.pi gSG.AWGFreq 0 gSG.piAWGAmp]; % pi_x
    WaveForm_1I(1 + (i-1)*60 + 2, :) = [gmSEQ.interval/2+(i-1+1/48)*Cycle gmSEQ.interval/2+(i-1+1/48)*Cycle+gmSEQ.pi/2 gSG.AWGFreq 0 gSG.piAWGAmp]; % pi/2_x
    WaveForm_1I(1 + (i-1)*60 + 3, :) = [gmSEQ.interval/2+(i-1+1/48)*Cycle+gmSEQ.pi/2+PulseGap gmSEQ.interval/2+(i-1+1/48)*Cycle+PulseGap+gmSEQ.pi gSG.AWGFreq 3*pi/2 gSG.piAWGAmp]; % -pi/2_y
    WaveForm_1I(1 + (i-1)*60 + 4, :) = [gmSEQ.interval/2+(i-1+2/48)*Cycle gmSEQ.interval/2+(i-1+2/48)*Cycle+gmSEQ.pi gSG.AWGFreq pi gSG.piAWGAmp]; % -pi_x
    WaveForm_1I(1 + (i-1)*60 + 5, :) = [gmSEQ.interval/2+(i-1+3/48)*Cycle gmSEQ.interval/2+(i-1+3/48)*Cycle+gmSEQ.pi gSG.AWGFreq pi gSG.piAWGAmp]; % -pi_x
    WaveForm_1I(1 + (i-1)*60 + 6, :) = [gmSEQ.interval/2+(i-1+4/48)*Cycle gmSEQ.interval/2+(i-1+4/48)*Cycle+gmSEQ.pi gSG.AWGFreq 0 gSG.piAWGAmp]; % pi_x
    WaveForm_1I(1 + (i-1)*60 + 7, :) = [gmSEQ.interval/2+(i-1+5/48)*Cycle gmSEQ.interval/2+(i-1+5/48)*Cycle+gmSEQ.pi/2 gSG.AWGFreq 0 gSG.piAWGAmp]; % pi/2_x
    WaveForm_1I(1 + (i-1)*60 + 8, :) = [gmSEQ.interval/2+(i-1+5/48)*Cycle+gmSEQ.pi/2+PulseGap gmSEQ.interval/2+(i-1+5/48)*Cycle+PulseGap+gmSEQ.pi gSG.AWGFreq 3*pi/2 gSG.piAWGAmp]; % -pi/2_y
    WaveForm_1I(1 + (i-1)*60 + 9, :) = [gmSEQ.interval/2+(i-1+6/48)*Cycle gmSEQ.interval/2+(i-1+6/48)*Cycle+gmSEQ.pi gSG.AWGFreq pi gSG.piAWGAmp]; % -pi_x
    WaveForm_1I(1 + (i-1)*60 + 10, :) = [gmSEQ.interval/2+(i-1+7/48)*Cycle gmSEQ.interval/2+(i-1+7/48)*Cycle+gmSEQ.pi gSG.AWGFreq pi gSG.piAWGAmp]; % -pi_x
    WaveForm_1I(1 + (i-1)*60 + 11, :) = [gmSEQ.interval/2+(i-1+8/48)*Cycle gmSEQ.interval/2+(i-1+8/48)*Cycle+gmSEQ.pi gSG.AWGFreq 0 gSG.piAWGAmp]; % pi_x
    WaveForm_1I(1 + (i-1)*60 + 12, :) = [gmSEQ.interval/2+(i-1+9/48)*Cycle gmSEQ.interval/2+(i-1+9/48)*Cycle+gmSEQ.pi/2 gSG.AWGFreq 0 gSG.piAWGAmp]; % pi/2_x
    WaveForm_1I(1 + (i-1)*60 + 13, :) = [gmSEQ.interval/2+(i-1+9/48)*Cycle+gmSEQ.pi/2+PulseGap gmSEQ.interval/2+(i-1+9/48)*Cycle+PulseGap+gmSEQ.pi gSG.AWGFreq 3*pi/2 gSG.piAWGAmp]; % -pi/2_y
    WaveForm_1I(1 + (i-1)*60 + 14, :) = [gmSEQ.interval/2+(i-1+10/48)*Cycle gmSEQ.interval/2+(i-1+10/48)*Cycle+gmSEQ.pi gSG.AWGFreq pi gSG.piAWGAmp]; % -pi_x
    WaveForm_1I(1 + (i-1)*60 + 15, :) = [gmSEQ.interval/2+(i-1+11/48)*Cycle gmSEQ.interval/2+(i-1+11/48)*Cycle+gmSEQ.pi gSG.AWGFreq pi gSG.piAWGAmp]; % -pi_x
    WaveForm_1I(1 + (i-1)*60 + 16, :) = [gmSEQ.interval/2+(i-1+12/48)*Cycle gmSEQ.interval/2+(i-1+12/48)*Cycle+gmSEQ.pi gSG.AWGFreq 3*pi/2 gSG.piAWGAmp]; % -pi_y
    WaveForm_1I(1 + (i-1)*60 + 17, :) = [gmSEQ.interval/2+(i-1+13/48)*Cycle gmSEQ.interval/2+(i-1+13/48)*Cycle+gmSEQ.pi/2 gSG.AWGFreq 3*pi/2 gSG.piAWGAmp]; % -pi/2_y
    WaveForm_1I(1 + (i-1)*60 + 18, :) = [gmSEQ.interval/2+(i-1+13/48)*Cycle+gmSEQ.pi/2+PulseGap gmSEQ.interval/2+(i-1+13/48)*Cycle+PulseGap+gmSEQ.pi gSG.AWGFreq 0 gSG.piAWGAmp]; % pi/2_x
    WaveForm_1I(1 + (i-1)*60 + 19, :) = [gmSEQ.interval/2+(i-1+14/48)*Cycle gmSEQ.interval/2+(i-1+14/48)*Cycle+gmSEQ.pi gSG.AWGFreq pi/2 gSG.piAWGAmp]; % pi_y
    WaveForm_1I(1 + (i-1)*60 + 20, :) = [gmSEQ.interval/2+(i-1+15/48)*Cycle gmSEQ.interval/2+(i-1+15/48)*Cycle+gmSEQ.pi gSG.AWGFreq pi/2 gSG.piAWGAmp]; % pi_y
    WaveForm_1I(1 + (i-1)*60 + 21, :) = [gmSEQ.interval/2+(i-1+16/48)*Cycle gmSEQ.interval/2+(i-1+16/48)*Cycle+gmSEQ.pi gSG.AWGFreq 3*pi/2 gSG.piAWGAmp]; % -pi_y
    WaveForm_1I(1 + (i-1)*60 + 22, :) = [gmSEQ.interval/2+(i-1+17/48)*Cycle gmSEQ.interval/2+(i-1+17/48)*Cycle+gmSEQ.pi/2 gSG.AWGFreq 3*pi/2 gSG.piAWGAmp]; % -pi/2_y
    WaveForm_1I(1 + (i-1)*60 + 23, :) = [gmSEQ.interval/2+(i-1+17/48)*Cycle+gmSEQ.pi/2+PulseGap gmSEQ.interval/2+(i-1+17/48)*Cycle+PulseGap+gmSEQ.pi gSG.AWGFreq 0 gSG.piAWGAmp]; % pi/2_x
    WaveForm_1I(1 + (i-1)*60 + 24, :) = [gmSEQ.interval/2+(i-1+18/48)*Cycle gmSEQ.interval/2+(i-1+18/48)*Cycle+gmSEQ.pi gSG.AWGFreq pi/2 gSG.piAWGAmp]; % pi_y
    WaveForm_1I(1 + (i-1)*60 + 25, :) = [gmSEQ.interval/2+(i-1+19/48)*Cycle gmSEQ.interval/2+(i-1+19/48)*Cycle+gmSEQ.pi gSG.AWGFreq pi/2 gSG.piAWGAmp]; % pi_y
    WaveForm_1I(1 + (i-1)*60 + 26, :) = [gmSEQ.interval/2+(i-1+20/48)*Cycle gmSEQ.interval/2+(i-1+20/48)*Cycle+gmSEQ.pi gSG.AWGFreq 3*pi/2 gSG.piAWGAmp]; % -pi_y
    WaveForm_1I(1 + (i-1)*60 + 27, :) = [gmSEQ.interval/2+(i-1+21/48)*Cycle gmSEQ.interval/2+(i-1+21/48)*Cycle+gmSEQ.pi/2 gSG.AWGFreq 3*pi/2 gSG.piAWGAmp]; % -pi/2_y
    WaveForm_1I(1 + (i-1)*60 + 28, :) = [gmSEQ.interval/2+(i-1+21/48)*Cycle+gmSEQ.pi/2+PulseGap gmSEQ.interval/2+(i-1+21/48)*Cycle+PulseGap+gmSEQ.pi gSG.AWGFreq 0 gSG.piAWGAmp]; % pi/2_x
    WaveForm_1I(1 + (i-1)*60 + 29, :) = [gmSEQ.interval/2+(i-1+22/48)*Cycle gmSEQ.interval/2+(i-1+22/48)*Cycle+gmSEQ.pi gSG.AWGFreq pi/2 gSG.piAWGAmp]; % pi_y
    WaveForm_1I(1 + (i-1)*60 + 30, :) = [gmSEQ.interval/2+(i-1+23/48)*Cycle gmSEQ.interval/2+(i-1+23/48)*Cycle+gmSEQ.pi gSG.AWGFreq pi/2 gSG.piAWGAmp]; % pi_y
    WaveForm_1I(1 + (i-1)*60 + 31, :) = [gmSEQ.interval/2+(i-1+24/48)*Cycle gmSEQ.interval/2+(i-1+24/48)*Cycle+gmSEQ.pi gSG.AWGFreq 3*pi/2 gSG.piAWGAmp]; % -pi_y
    WaveForm_1I(1 + (i-1)*60 + 32, :) = [gmSEQ.interval/2+(i-1+25/48)*Cycle gmSEQ.interval/2+(i-1+25/48)*Cycle+gmSEQ.pi/2 gSG.AWGFreq 0 gSG.piAWGAmp]; % pi/2_x
    WaveForm_1I(1 + (i-1)*60 + 33, :) = [gmSEQ.interval/2+(i-1+25/48)*Cycle+gmSEQ.pi/2+PulseGap gmSEQ.interval/2+(i-1+25/48)*Cycle+PulseGap+gmSEQ.pi gSG.AWGFreq pi/2 gSG.piAWGAmp]; % pi/2_y
    WaveForm_1I(1 + (i-1)*60 + 34, :) = [gmSEQ.interval/2+(i-1+26/48)*Cycle gmSEQ.interval/2+(i-1+26/48)*Cycle+gmSEQ.pi gSG.AWGFreq pi/2 gSG.piAWGAmp]; % pi_y
    WaveForm_1I(1 + (i-1)*60 + 35, :) = [gmSEQ.interval/2+(i-1+27/48)*Cycle gmSEQ.interval/2+(i-1+27/48)*Cycle+gmSEQ.pi gSG.AWGFreq 3*pi/2 gSG.piAWGAmp]; % -pi_y
    WaveForm_1I(1 + (i-1)*60 + 36, :) = [gmSEQ.interval/2+(i-1+28/48)*Cycle gmSEQ.interval/2+(i-1+28/48)*Cycle+gmSEQ.pi gSG.AWGFreq 3*pi/2 gSG.piAWGAmp]; % -pi_y
    WaveForm_1I(1 + (i-1)*60 + 37, :) = [gmSEQ.interval/2+(i-1+29/48)*Cycle gmSEQ.interval/2+(i-1+29/48)*Cycle+gmSEQ.pi/2 gSG.AWGFreq 0 gSG.piAWGAmp]; % pi/2_x
    WaveForm_1I(1 + (i-1)*60 + 38, :) = [gmSEQ.interval/2+(i-1+29/48)*Cycle+gmSEQ.pi/2+PulseGap gmSEQ.interval/2+(i-1+29/48)*Cycle+PulseGap+gmSEQ.pi gSG.AWGFreq pi/2 gSG.piAWGAmp]; % pi/2_y
    WaveForm_1I(1 + (i-1)*60 + 39, :) = [gmSEQ.interval/2+(i-1+30/48)*Cycle gmSEQ.interval/2+(i-1+30/48)*Cycle+gmSEQ.pi gSG.AWGFreq pi/2 gSG.piAWGAmp]; % pi_y
    WaveForm_1I(1 + (i-1)*60 + 40, :) = [gmSEQ.interval/2+(i-1+31/48)*Cycle gmSEQ.interval/2+(i-1+31/48)*Cycle+gmSEQ.pi gSG.AWGFreq 3*pi/2 gSG.piAWGAmp]; % -pi_y
    WaveForm_1I(1 + (i-1)*60 + 41, :) = [gmSEQ.interval/2+(i-1+32/48)*Cycle gmSEQ.interval/2+(i-1+32/48)*Cycle+gmSEQ.pi gSG.AWGFreq 3*pi/2 gSG.piAWGAmp]; % -pi_y
    WaveForm_1I(1 + (i-1)*60 + 42, :) = [gmSEQ.interval/2+(i-1+33/48)*Cycle gmSEQ.interval/2+(i-1+33/48)*Cycle+gmSEQ.pi/2 gSG.AWGFreq 0 gSG.piAWGAmp]; % pi/2_x
    WaveForm_1I(1 + (i-1)*60 + 43, :) = [gmSEQ.interval/2+(i-1+33/48)*Cycle+gmSEQ.pi/2+PulseGap gmSEQ.interval/2+(i-1+33/48)*Cycle+PulseGap+gmSEQ.pi gSG.AWGFreq pi/2 gSG.piAWGAmp]; % pi/2_y
    WaveForm_1I(1 + (i-1)*60 + 44, :) = [gmSEQ.interval/2+(i-1+34/48)*Cycle gmSEQ.interval/2+(i-1+34/48)*Cycle+gmSEQ.pi gSG.AWGFreq pi/2 gSG.piAWGAmp]; % pi_y
    WaveForm_1I(1 + (i-1)*60 + 45, :) = [gmSEQ.interval/2+(i-1+35/48)*Cycle gmSEQ.interval/2+(i-1+35/48)*Cycle+gmSEQ.pi gSG.AWGFreq pi gSG.piAWGAmp]; % -pi_x
    WaveForm_1I(1 + (i-1)*60 + 46, :) = [gmSEQ.interval/2+(i-1+36/48)*Cycle gmSEQ.interval/2+(i-1+36/48)*Cycle+gmSEQ.pi gSG.AWGFreq pi gSG.piAWGAmp]; % -pi_x
    WaveForm_1I(1 + (i-1)*60 + 47, :) = [gmSEQ.interval/2+(i-1+37/48)*Cycle gmSEQ.interval/2+(i-1+37/48)*Cycle+gmSEQ.pi/2 gSG.AWGFreq pi/2 gSG.piAWGAmp]; % pi/2_y
    WaveForm_1I(1 + (i-1)*60 + 48, :) = [gmSEQ.interval/2+(i-1+37/48)*Cycle+gmSEQ.pi/2+PulseGap gmSEQ.interval/2+(i-1+37/48)*Cycle+PulseGap+gmSEQ.pi gSG.AWGFreq 0 gSG.piAWGAmp]; % pi/2_x
    WaveForm_1I(1 + (i-1)*60 + 49, :) = [gmSEQ.interval/2+(i-1+38/48)*Cycle gmSEQ.interval/2+(i-1+38/48)*Cycle+gmSEQ.pi gSG.AWGFreq 0 gSG.piAWGAmp]; % pi_x
    WaveForm_1I(1 + (i-1)*60 + 50, :) = [gmSEQ.interval/2+(i-1+39/48)*Cycle gmSEQ.interval/2+(i-1+39/48)*Cycle+gmSEQ.pi gSG.AWGFreq pi gSG.piAWGAmp]; % -pi_x
    WaveForm_1I(1 + (i-1)*60 + 51, :) = [gmSEQ.interval/2+(i-1+40/48)*Cycle gmSEQ.interval/2+(i-1+40/48)*Cycle+gmSEQ.pi gSG.AWGFreq pi gSG.piAWGAmp]; % -pi_x
    WaveForm_1I(1 + (i-1)*60 + 52, :) = [gmSEQ.interval/2+(i-1+41/48)*Cycle gmSEQ.interval/2+(i-1+41/48)*Cycle+gmSEQ.pi/2 gSG.AWGFreq pi/2 gSG.piAWGAmp]; % pi/2_y
    WaveForm_1I(1 + (i-1)*60 + 53, :) = [gmSEQ.interval/2+(i-1+41/48)*Cycle+gmSEQ.pi/2+PulseGap gmSEQ.interval/2+(i-1+41/48)*Cycle+PulseGap+gmSEQ.pi gSG.AWGFreq 0 gSG.piAWGAmp]; % pi/2_x
    WaveForm_1I(1 + (i-1)*60 + 54, :) = [gmSEQ.interval/2+(i-1+42/48)*Cycle gmSEQ.interval/2+(i-1+42/48)*Cycle+gmSEQ.pi gSG.AWGFreq 0 gSG.piAWGAmp]; % pi_x
    WaveForm_1I(1 + (i-1)*60 + 55, :) = [gmSEQ.interval/2+(i-1+43/48)*Cycle gmSEQ.interval/2+(i-1+43/48)*Cycle+gmSEQ.pi gSG.AWGFreq pi gSG.piAWGAmp]; % -pi_x
    WaveForm_1I(1 + (i-1)*60 + 56, :) = [gmSEQ.interval/2+(i-1+44/48)*Cycle gmSEQ.interval/2+(i-1+44/48)*Cycle+gmSEQ.pi gSG.AWGFreq pi gSG.piAWGAmp]; % -pi_x
    WaveForm_1I(1 + (i-1)*60 + 57, :) = [gmSEQ.interval/2+(i-1+45/48)*Cycle gmSEQ.interval/2+(i-1+45/48)*Cycle+gmSEQ.pi/2 gSG.AWGFreq pi/2 gSG.piAWGAmp]; % pi/2_y
    WaveForm_1I(1 + (i-1)*60 + 58, :) = [gmSEQ.interval/2+(i-1+45/48)*Cycle+gmSEQ.pi/2+PulseGap gmSEQ.interval/2+(i-1+45/48)*Cycle+PulseGap+gmSEQ.pi gSG.AWGFreq 0 gSG.piAWGAmp]; % pi/2_x
    WaveForm_1I(1 + (i-1)*60 + 59, :) = [gmSEQ.interval/2+(i-1+46/48)*Cycle gmSEQ.interval/2+(i-1+46/48)*Cycle+gmSEQ.pi gSG.AWGFreq 0 gSG.piAWGAmp]; % pi_x
    WaveForm_1I(1 + (i-1)*60 + 60, :) = [gmSEQ.interval/2+(i-1+47/48)*Cycle gmSEQ.interval/2+(i-1+47/48)*Cycle+gmSEQ.pi gSG.AWGFreq 3*pi/2 gSG.piAWGAmp]; % -pi_y
end
WaveForm_1I(2 + 60*gmSEQ.m, :) = [gmSEQ.m*Cycle gmSEQ.m*Cycle+gmSEQ.pi  gSG.AWGFreq pi 0]; 

WaveForm_1Q = WaveForm_1I - repmat([0 0 0 pi/2 0], size(WaveForm_1I, 1), 1);
WaveForm_1Length = ceil((gmSEQ.m*Cycle+gmSEQ.pi+1000) / (16 / gSG.AWGClockRate)) ...
    *(16 / gSG.AWGClockRate);
WaveForm_1PointNum = WaveForm_1Length * gSG.AWGClockRate;

WaveForm_2I = WaveForm_1I;
WaveForm_2I(size(WaveForm_2I, 1), :) = [gmSEQ.m*Cycle gmSEQ.m*Cycle+gmSEQ.pi gSG.AWGFreq 0 gSG.piAWGAmp]; % Differential measurement
WaveForm_2Q = WaveForm_2I - repmat([0 0 0 pi/2 0], size(WaveForm_2I, 1), 1);
WaveForm_2Length = WaveForm_1Length;
WaveForm_2PointNum = WaveForm_2Length * gSG.AWGClockRate;

chaseFunctionPool('createWaveform', WaveForm_1I, gSG.AWGClockRate, WaveForm_1Length, 'DROID60N_I_seg1.txt'); pause(0.5);
chaseFunctionPool('createWaveform', WaveForm_1Q, gSG.AWGClockRate, WaveForm_1Length, 'DROID60N_Q_seg1.txt'); pause(0.5);
chaseFunctionPool('createWaveform', WaveForm_2I, gSG.AWGClockRate, WaveForm_2Length, 'DROID60N_I_seg2.txt'); pause(0.5);
chaseFunctionPool('createWaveform', WaveForm_2Q, gSG.AWGClockRate, WaveForm_2Length, 'DROID60N_Q_seg2.txt'); pause(0.5);

chaseFunctionPool('createSegStruct', 'DROID60N_SegStruct_I.txt', ...
    'DROID60N_I_seg1.txt', WaveForm_1PointNum, 1, 1, ...
    'DROID60N_I_seg2.txt', WaveForm_2PointNum, 1, 1);
pause(0.5);
chaseFunctionPool('createSegStruct', 'DROID60N_SegStruct_Q.txt', ...
    'DROID60N_Q_seg1.txt', WaveForm_1PointNum, 1, 1, ...
    'DROID60N_Q_seg2.txt', WaveForm_2PointNum, 1, 1);
pause(0.5);

%% Load waveform to AWG
chaseFunctionPool('CreateSegments', gmSEQ.MWAWG, 1, ...
    2, ...
    2047, 2047, 'DROID60N_SegStruct_I.txt', 'false');
pause(1); % this pause seems to be important, otherwise the loading is not right occassionally
chaseFunctionPool('CreateSegments', gmSEQ.MWAWG, 2, ...
    2, ...
    2047, 2047, 'DROID60N_SegStruct_Q.txt', 'false');
pause(1); % this pause seems to be important, otherwise the loading is not right occassionally
%% Run waveform
chaseFunctionPool('runChase', gmSEQ.MWAWG, 'false');
ApplyDelays();

function DROID60N_tomo % Put in the north/south pole
global gmSEQ gSG
gSG.bfixedPow=1;
gSG.bfixedFreq=1;
gSG.bMod='IQ';
gSG.bModSrc='External';

[gmSEQ.ScaleT, gmSEQ.ScaleStr] = GetScale(48*(gmSEQ.pi+gmSEQ.interval)*gmSEQ.To);

gmSEQ.Ntomo = 3;
% TODO: add the definition for the pi and halfpi pulse AWG amp
gSG.piAWGAmp = gmSEQ.SAmp1; % Just for temporary use
gSG.halfpiAWGAmp = gmSEQ.SAmp2; % Just for temporary use
gSG.compAWGAmp = gmSEQ.SAmp1_M; % Just for temporary use

% gmSEQ.m here is the repetition number of XY8 block
gmSEQ.m = round(gmSEQ.m);

AfterPi = 1000;
AfterLaser = 100e3;
Wait_p = 10e3;
Detect_Window = 5000;
PulseGap = 4;

Cycle = (gmSEQ.interval + gmSEQ.pi)*48;
Sig_D_start = Wait_p+gmSEQ.readout+AfterLaser+Cycle*gmSEQ.m+gmSEQ.pi+AfterPi+Detect_Window+Wait_p;

gmSEQ.CHN(1).PBN=PBDictionary('ctr0');
gmSEQ.CHN(1).NRise=4;
gmSEQ.CHN(1).T=[Wait_p+gmSEQ.readout-1000-gmSEQ.CtrGateDur, ...
    Wait_p+gmSEQ.readout+AfterLaser+Cycle*gmSEQ.m+gmSEQ.pi+AfterPi, ...
    Sig_D_start+gmSEQ.readout-1000-gmSEQ.CtrGateDur, ... 
    Sig_D_start+gmSEQ.readout+AfterLaser+Cycle*gmSEQ.m+gmSEQ.pi+AfterPi];
if strcmp(gmSEQ.meas,'SPCM')
    gmSEQ.CHN(1).DT=[gmSEQ.CtrGateDur gmSEQ.CtrGateDur gmSEQ.CtrGateDur gmSEQ.CtrGateDur];
elseif strcmp(gmSEQ.meas,'APD')
    gmSEQ.CHN(1).DT=[1000 1000 1000 1000];
end

gmSEQ.CHN(numel(gmSEQ.CHN)+1).PBN=PBDictionary('AOM');
gmSEQ.CHN(numel(gmSEQ.CHN)).NRise=4;
gmSEQ.CHN(numel(gmSEQ.CHN)).T = [Wait_p, Wait_p+gmSEQ.readout+AfterLaser+Cycle*gmSEQ.m+gmSEQ.pi+AfterPi, ...
    Sig_D_start, Sig_D_start+gmSEQ.readout+AfterLaser+Cycle*gmSEQ.m+gmSEQ.pi+AfterPi];
gmSEQ.CHN(numel(gmSEQ.CHN)).DT = [gmSEQ.readout Detect_Window gmSEQ.readout Detect_Window];


gmSEQ.CHN(numel(gmSEQ.CHN)+1).PBN=PBDictionary('AWGTrig');
gmSEQ.CHN(numel(gmSEQ.CHN)).NRise=2;
gmSEQ.CHN(numel(gmSEQ.CHN)).T=[Wait_p+gmSEQ.readout+AfterLaser, ...
    Sig_D_start+gmSEQ.readout+AfterLaser];
gmSEQ.CHN(numel(gmSEQ.CHN)).DT=repelem(Cycle*gmSEQ.m+gmSEQ.pi+200, 2);

buffer = 20;
gmSEQ.CHN(numel(gmSEQ.CHN)+1).PBN=PBDictionary('MWSwitch');
if gmSEQ.m == 0 || gmSEQ.interval < 1000
    gmSEQ.CHN(numel(gmSEQ.CHN)).NRise=2;
    gmSEQ.CHN(numel(gmSEQ.CHN)).T=[Wait_p+gmSEQ.readout+AfterLaser-200, Sig_D_start+gmSEQ.readout+AfterLaser-200];
    gmSEQ.CHN(numel(gmSEQ.CHN)).DT=[Cycle*gmSEQ.m+gmSEQ.pi+buffer+400, Cycle*gmSEQ.m+gmSEQ.pi+buffer+400];
else
    gmSEQ.CHN(numel(gmSEQ.CHN)).NRise=96*gmSEQ.m + 1;
    gmSEQ.CHN(numel(gmSEQ.CHN)).T = zeros(1, gmSEQ.CHN(numel(gmSEQ.CHN)).NRise);
    for i = 1:gmSEQ.m
        for j = 1:48
         gmSEQ.CHN(numel(gmSEQ.CHN)).T((i-1)*48+j) = Wait_p+gmSEQ.readout+AfterLaser+gmSEQ.interval+(i-1+(j-1)/48)*Cycle-20;
         gmSEQ.CHN(numel(gmSEQ.CHN)).T(48*gmSEQ.m+(i-1)*48+j) = Sig_D_start+gmSEQ.readout+AfterLaser+gmSEQ.interval+(i-1+(j-1)/48)*Cycle-20;
        end
    end
    gmSEQ.CHN(numel(gmSEQ.CHN)).T(96*gmSEQ.m+1) = Sig_D_start+gmSEQ.readout+AfterLaser+gmSEQ.m*Cycle-20;
    gmSEQ.CHN(numel(gmSEQ.CHN)).DT=[repelem(gmSEQ.pi+40, 96*gmSEQ.m), gmSEQ.pi+40];
end


gmSEQ.CHN(numel(gmSEQ.CHN)+1).PBN=PBDictionary('dummy1');
gmSEQ.CHN(numel(gmSEQ.CHN)).NRise=2;
gmSEQ.CHN(numel(gmSEQ.CHN)).T=[0 Sig_D_start+gmSEQ.readout+AfterLaser+gmSEQ.m*Cycle+gmSEQ.pi+AfterPi+Detect_Window-50];
gmSEQ.CHN(numel(gmSEQ.CHN)).DT=[50 50];

%% AWG
% Initialization
chaseFunctionPool('stopChase',  gmSEQ.MWAWG)

% This part need to be modified to accomodate the DC modulation
if ~gSG.ACmodAWG % in AC modulation mode
    gSG.AWGFreq = 0;
end

WaveForm_1I = zeros(2 + 60*gmSEQ.m, 5);
if gmSEQ.m == 0
    WaveForm_1I(1, :) = [0 buffer gSG.AWGFreq 0 0];
else
    WaveForm_1I(1, :) = [0 gmSEQ.interval gSG.AWGFreq 0 0];
end
for i = 1:gmSEQ.m
    WaveForm_1I(1 + (i-1)*60 + 1, :) = [gmSEQ.interval+(i-1+0/48)*Cycle gmSEQ.interval+(i-1+0/48)*Cycle+gmSEQ.pi gSG.AWGFreq 0 gSG.piAWGAmp]; % pi_x
    WaveForm_1I(1 + (i-1)*60 + 2, :) = [gmSEQ.interval+(i-1+1/48)*Cycle-PulseGap/2 gmSEQ.interval+(i-1+1/48)*Cycle-PulseGap/2+gmSEQ.pi/2 gSG.AWGFreq 0 gSG.compAWGAmp]; % pi/2_x
    WaveForm_1I(1 + (i-1)*60 + 3, :) = [gmSEQ.interval+(i-1+1/48)*Cycle+gmSEQ.pi/2+PulseGap/2 gmSEQ.interval+(i-1+1/48)*Cycle+PulseGap/2+gmSEQ.pi gSG.AWGFreq 3*pi/2 gSG.compAWGAmp]; % -pi/2_y
    WaveForm_1I(1 + (i-1)*60 + 4, :) = [gmSEQ.interval+(i-1+2/48)*Cycle gmSEQ.interval+(i-1+2/48)*Cycle+gmSEQ.pi gSG.AWGFreq pi gSG.piAWGAmp]; % -pi_x
    WaveForm_1I(1 + (i-1)*60 + 5, :) = [gmSEQ.interval+(i-1+3/48)*Cycle gmSEQ.interval+(i-1+3/48)*Cycle+gmSEQ.pi gSG.AWGFreq pi gSG.piAWGAmp]; % -pi_x
    WaveForm_1I(1 + (i-1)*60 + 6, :) = [gmSEQ.interval+(i-1+4/48)*Cycle gmSEQ.interval+(i-1+4/48)*Cycle+gmSEQ.pi gSG.AWGFreq 0 gSG.piAWGAmp]; % pi_x
    WaveForm_1I(1 + (i-1)*60 + 7, :) = [gmSEQ.interval+(i-1+5/48)*Cycle-PulseGap/2 gmSEQ.interval+(i-1+5/48)*Cycle-PulseGap/2+gmSEQ.pi/2 gSG.AWGFreq 0 gSG.compAWGAmp]; % pi/2_x
    WaveForm_1I(1 + (i-1)*60 + 8, :) = [gmSEQ.interval+(i-1+5/48)*Cycle+gmSEQ.pi/2+PulseGap/2 gmSEQ.interval+(i-1+5/48)*Cycle+PulseGap/2+gmSEQ.pi gSG.AWGFreq 3*pi/2 gSG.compAWGAmp]; % -pi/2_y
    WaveForm_1I(1 + (i-1)*60 + 9, :) = [gmSEQ.interval+(i-1+6/48)*Cycle gmSEQ.interval+(i-1+6/48)*Cycle+gmSEQ.pi gSG.AWGFreq pi gSG.piAWGAmp]; % -pi_x
    WaveForm_1I(1 + (i-1)*60 + 10, :) = [gmSEQ.interval+(i-1+7/48)*Cycle gmSEQ.interval+(i-1+7/48)*Cycle+gmSEQ.pi gSG.AWGFreq pi gSG.piAWGAmp]; % -pi_x
    WaveForm_1I(1 + (i-1)*60 + 11, :) = [gmSEQ.interval+(i-1+8/48)*Cycle gmSEQ.interval+(i-1+8/48)*Cycle+gmSEQ.pi gSG.AWGFreq 0 gSG.piAWGAmp]; % pi_x
    WaveForm_1I(1 + (i-1)*60 + 12, :) = [gmSEQ.interval+(i-1+9/48)*Cycle-PulseGap/2 gmSEQ.interval+(i-1+9/48)*Cycle-PulseGap/2+gmSEQ.pi/2 gSG.AWGFreq 0 gSG.compAWGAmp]; % pi/2_x
    WaveForm_1I(1 + (i-1)*60 + 13, :) = [gmSEQ.interval+(i-1+9/48)*Cycle+gmSEQ.pi/2+PulseGap/2 gmSEQ.interval+(i-1+9/48)*Cycle+PulseGap/2+gmSEQ.pi gSG.AWGFreq 3*pi/2 gSG.compAWGAmp]; % -pi/2_y
    WaveForm_1I(1 + (i-1)*60 + 14, :) = [gmSEQ.interval+(i-1+10/48)*Cycle gmSEQ.interval+(i-1+10/48)*Cycle+gmSEQ.pi gSG.AWGFreq pi gSG.piAWGAmp]; % -pi_x
    WaveForm_1I(1 + (i-1)*60 + 15, :) = [gmSEQ.interval+(i-1+11/48)*Cycle gmSEQ.interval+(i-1+11/48)*Cycle+gmSEQ.pi gSG.AWGFreq pi gSG.piAWGAmp]; % -pi_x
    WaveForm_1I(1 + (i-1)*60 + 16, :) = [gmSEQ.interval+(i-1+12/48)*Cycle gmSEQ.interval+(i-1+12/48)*Cycle+gmSEQ.pi gSG.AWGFreq 3*pi/2 gSG.piAWGAmp]; % -pi_y
    WaveForm_1I(1 + (i-1)*60 + 17, :) = [gmSEQ.interval+(i-1+13/48)*Cycle-PulseGap/2 gmSEQ.interval+(i-1+13/48)*Cycle-PulseGap/2+gmSEQ.pi/2 gSG.AWGFreq 3*pi/2 gSG.compAWGAmp]; % -pi/2_y
    WaveForm_1I(1 + (i-1)*60 + 18, :) = [gmSEQ.interval+(i-1+13/48)*Cycle+gmSEQ.pi/2+PulseGap/2 gmSEQ.interval+(i-1+13/48)*Cycle+PulseGap/2+gmSEQ.pi gSG.AWGFreq 0 gSG.compAWGAmp]; % pi/2_x
    WaveForm_1I(1 + (i-1)*60 + 19, :) = [gmSEQ.interval+(i-1+14/48)*Cycle gmSEQ.interval+(i-1+14/48)*Cycle+gmSEQ.pi gSG.AWGFreq pi/2 gSG.piAWGAmp]; % pi_y
    WaveForm_1I(1 + (i-1)*60 + 20, :) = [gmSEQ.interval+(i-1+15/48)*Cycle gmSEQ.interval+(i-1+15/48)*Cycle+gmSEQ.pi gSG.AWGFreq pi/2 gSG.piAWGAmp]; % pi_y
    WaveForm_1I(1 + (i-1)*60 + 21, :) = [gmSEQ.interval+(i-1+16/48)*Cycle gmSEQ.interval+(i-1+16/48)*Cycle+gmSEQ.pi gSG.AWGFreq 3*pi/2 gSG.piAWGAmp]; % -pi_y
    WaveForm_1I(1 + (i-1)*60 + 22, :) = [gmSEQ.interval+(i-1+17/48)*Cycle-PulseGap/2 gmSEQ.interval+(i-1+17/48)*Cycle-PulseGap/2+gmSEQ.pi/2 gSG.AWGFreq 3*pi/2 gSG.compAWGAmp]; % -pi/2_y
    WaveForm_1I(1 + (i-1)*60 + 23, :) = [gmSEQ.interval+(i-1+17/48)*Cycle+gmSEQ.pi/2+PulseGap/2 gmSEQ.interval+(i-1+17/48)*Cycle+PulseGap/2+gmSEQ.pi gSG.AWGFreq 0 gSG.compAWGAmp]; % pi/2_x
    WaveForm_1I(1 + (i-1)*60 + 24, :) = [gmSEQ.interval+(i-1+18/48)*Cycle gmSEQ.interval+(i-1+18/48)*Cycle+gmSEQ.pi gSG.AWGFreq pi/2 gSG.piAWGAmp]; % pi_y
    WaveForm_1I(1 + (i-1)*60 + 25, :) = [gmSEQ.interval+(i-1+19/48)*Cycle gmSEQ.interval+(i-1+19/48)*Cycle+gmSEQ.pi gSG.AWGFreq pi/2 gSG.piAWGAmp]; % pi_y
    WaveForm_1I(1 + (i-1)*60 + 26, :) = [gmSEQ.interval+(i-1+20/48)*Cycle gmSEQ.interval+(i-1+20/48)*Cycle+gmSEQ.pi gSG.AWGFreq 3*pi/2 gSG.piAWGAmp]; % -pi_y
    WaveForm_1I(1 + (i-1)*60 + 27, :) = [gmSEQ.interval+(i-1+21/48)*Cycle-PulseGap/2 gmSEQ.interval+(i-1+21/48)*Cycle-PulseGap/2+gmSEQ.pi/2 gSG.AWGFreq 3*pi/2 gSG.compAWGAmp]; % -pi/2_y
    WaveForm_1I(1 + (i-1)*60 + 28, :) = [gmSEQ.interval+(i-1+21/48)*Cycle+gmSEQ.pi/2+PulseGap/2 gmSEQ.interval+(i-1+21/48)*Cycle+PulseGap/2+gmSEQ.pi gSG.AWGFreq 0 gSG.compAWGAmp]; % pi/2_x
    WaveForm_1I(1 + (i-1)*60 + 29, :) = [gmSEQ.interval+(i-1+22/48)*Cycle gmSEQ.interval+(i-1+22/48)*Cycle+gmSEQ.pi gSG.AWGFreq pi/2 gSG.piAWGAmp]; % pi_y
    WaveForm_1I(1 + (i-1)*60 + 30, :) = [gmSEQ.interval+(i-1+23/48)*Cycle gmSEQ.interval+(i-1+23/48)*Cycle+gmSEQ.pi gSG.AWGFreq pi/2 gSG.piAWGAmp]; % pi_y
    WaveForm_1I(1 + (i-1)*60 + 31, :) = [gmSEQ.interval+(i-1+24/48)*Cycle gmSEQ.interval+(i-1+24/48)*Cycle+gmSEQ.pi gSG.AWGFreq 3*pi/2 gSG.piAWGAmp]; % -pi_y
    WaveForm_1I(1 + (i-1)*60 + 32, :) = [gmSEQ.interval+(i-1+25/48)*Cycle-PulseGap/2 gmSEQ.interval+(i-1+25/48)*Cycle-PulseGap/2+gmSEQ.pi/2 gSG.AWGFreq 0 gSG.compAWGAmp]; % pi/2_x
    WaveForm_1I(1 + (i-1)*60 + 33, :) = [gmSEQ.interval+(i-1+25/48)*Cycle+gmSEQ.pi/2+PulseGap/2 gmSEQ.interval+(i-1+25/48)*Cycle+PulseGap/2+gmSEQ.pi gSG.AWGFreq pi/2 gSG.compAWGAmp]; % pi/2_y
    WaveForm_1I(1 + (i-1)*60 + 34, :) = [gmSEQ.interval+(i-1+26/48)*Cycle gmSEQ.interval+(i-1+26/48)*Cycle+gmSEQ.pi gSG.AWGFreq pi/2 gSG.piAWGAmp]; % pi_y
    WaveForm_1I(1 + (i-1)*60 + 35, :) = [gmSEQ.interval+(i-1+27/48)*Cycle gmSEQ.interval+(i-1+27/48)*Cycle+gmSEQ.pi gSG.AWGFreq 3*pi/2 gSG.piAWGAmp]; % -pi_y
    WaveForm_1I(1 + (i-1)*60 + 36, :) = [gmSEQ.interval+(i-1+28/48)*Cycle gmSEQ.interval+(i-1+28/48)*Cycle+gmSEQ.pi gSG.AWGFreq 3*pi/2 gSG.piAWGAmp]; % -pi_y
    WaveForm_1I(1 + (i-1)*60 + 37, :) = [gmSEQ.interval+(i-1+29/48)*Cycle-PulseGap/2 gmSEQ.interval+(i-1+29/48)*Cycle-PulseGap/2+gmSEQ.pi/2 gSG.AWGFreq 0 gSG.compAWGAmp]; % pi/2_x
    WaveForm_1I(1 + (i-1)*60 + 38, :) = [gmSEQ.interval+(i-1+29/48)*Cycle+gmSEQ.pi/2+PulseGap/2 gmSEQ.interval+(i-1+29/48)*Cycle+PulseGap/2+gmSEQ.pi gSG.AWGFreq pi/2 gSG.compAWGAmp]; % pi/2_y
    WaveForm_1I(1 + (i-1)*60 + 39, :) = [gmSEQ.interval+(i-1+30/48)*Cycle gmSEQ.interval+(i-1+30/48)*Cycle+gmSEQ.pi gSG.AWGFreq pi/2 gSG.piAWGAmp]; % pi_y
    WaveForm_1I(1 + (i-1)*60 + 40, :) = [gmSEQ.interval+(i-1+31/48)*Cycle gmSEQ.interval+(i-1+31/48)*Cycle+gmSEQ.pi gSG.AWGFreq 3*pi/2 gSG.piAWGAmp]; % -pi_y
    WaveForm_1I(1 + (i-1)*60 + 41, :) = [gmSEQ.interval+(i-1+32/48)*Cycle gmSEQ.interval+(i-1+32/48)*Cycle+gmSEQ.pi gSG.AWGFreq 3*pi/2 gSG.piAWGAmp]; % -pi_y
    WaveForm_1I(1 + (i-1)*60 + 42, :) = [gmSEQ.interval+(i-1+33/48)*Cycle-PulseGap/2 gmSEQ.interval+(i-1+33/48)*Cycle-PulseGap/2+gmSEQ.pi/2 gSG.AWGFreq 0 gSG.compAWGAmp]; % pi/2_x
    WaveForm_1I(1 + (i-1)*60 + 43, :) = [gmSEQ.interval+(i-1+33/48)*Cycle+gmSEQ.pi/2+PulseGap/2 gmSEQ.interval+(i-1+33/48)*Cycle+PulseGap/2+gmSEQ.pi gSG.AWGFreq pi/2 gSG.compAWGAmp]; % pi/2_y
    WaveForm_1I(1 + (i-1)*60 + 44, :) = [gmSEQ.interval+(i-1+34/48)*Cycle gmSEQ.interval+(i-1+34/48)*Cycle+gmSEQ.pi gSG.AWGFreq pi/2 gSG.piAWGAmp]; % pi_y
    WaveForm_1I(1 + (i-1)*60 + 45, :) = [gmSEQ.interval+(i-1+35/48)*Cycle gmSEQ.interval+(i-1+35/48)*Cycle+gmSEQ.pi gSG.AWGFreq pi gSG.piAWGAmp]; % -pi_x
    WaveForm_1I(1 + (i-1)*60 + 46, :) = [gmSEQ.interval+(i-1+36/48)*Cycle gmSEQ.interval+(i-1+36/48)*Cycle+gmSEQ.pi gSG.AWGFreq pi gSG.piAWGAmp]; % -pi_x
    WaveForm_1I(1 + (i-1)*60 + 47, :) = [gmSEQ.interval+(i-1+37/48)*Cycle-PulseGap/2 gmSEQ.interval+(i-1+37/48)*Cycle-PulseGap/2+gmSEQ.pi/2 gSG.AWGFreq pi/2 gSG.compAWGAmp]; % pi/2_y
    WaveForm_1I(1 + (i-1)*60 + 48, :) = [gmSEQ.interval+(i-1+37/48)*Cycle+gmSEQ.pi/2+PulseGap/2 gmSEQ.interval+(i-1+37/48)*Cycle+PulseGap/2+gmSEQ.pi gSG.AWGFreq 0 gSG.compAWGAmp]; % pi/2_x
    WaveForm_1I(1 + (i-1)*60 + 49, :) = [gmSEQ.interval+(i-1+38/48)*Cycle gmSEQ.interval+(i-1+38/48)*Cycle+gmSEQ.pi gSG.AWGFreq 0 gSG.piAWGAmp]; % pi_x
    WaveForm_1I(1 + (i-1)*60 + 50, :) = [gmSEQ.interval+(i-1+39/48)*Cycle gmSEQ.interval+(i-1+39/48)*Cycle+gmSEQ.pi gSG.AWGFreq pi gSG.piAWGAmp]; % -pi_x
    WaveForm_1I(1 + (i-1)*60 + 51, :) = [gmSEQ.interval+(i-1+40/48)*Cycle gmSEQ.interval+(i-1+40/48)*Cycle+gmSEQ.pi gSG.AWGFreq pi gSG.piAWGAmp]; % -pi_x
    WaveForm_1I(1 + (i-1)*60 + 52, :) = [gmSEQ.interval+(i-1+41/48)*Cycle-PulseGap/2 gmSEQ.interval+(i-1+41/48)*Cycle-PulseGap/2+gmSEQ.pi/2 gSG.AWGFreq pi/2 gSG.compAWGAmp]; % pi/2_y
    WaveForm_1I(1 + (i-1)*60 + 53, :) = [gmSEQ.interval+(i-1+41/48)*Cycle+gmSEQ.pi/2+PulseGap/2 gmSEQ.interval+(i-1+41/48)*Cycle+PulseGap/2+gmSEQ.pi gSG.AWGFreq 0 gSG.compAWGAmp]; % pi/2_x
    WaveForm_1I(1 + (i-1)*60 + 54, :) = [gmSEQ.interval+(i-1+42/48)*Cycle gmSEQ.interval+(i-1+42/48)*Cycle+gmSEQ.pi gSG.AWGFreq 0 gSG.piAWGAmp]; % pi_x
    WaveForm_1I(1 + (i-1)*60 + 55, :) = [gmSEQ.interval+(i-1+43/48)*Cycle gmSEQ.interval+(i-1+43/48)*Cycle+gmSEQ.pi gSG.AWGFreq pi gSG.piAWGAmp]; % -pi_x
    WaveForm_1I(1 + (i-1)*60 + 56, :) = [gmSEQ.interval+(i-1+44/48)*Cycle gmSEQ.interval+(i-1+44/48)*Cycle+gmSEQ.pi gSG.AWGFreq pi gSG.piAWGAmp]; % -pi_x
    WaveForm_1I(1 + (i-1)*60 + 57, :) = [gmSEQ.interval+(i-1+45/48)*Cycle-PulseGap/2 gmSEQ.interval+(i-1+45/48)*Cycle-PulseGap/2+gmSEQ.pi/2 gSG.AWGFreq pi/2 gSG.compAWGAmp]; % pi/2_y
    WaveForm_1I(1 + (i-1)*60 + 58, :) = [gmSEQ.interval+(i-1+45/48)*Cycle+gmSEQ.pi/2+PulseGap/2 gmSEQ.interval+(i-1+45/48)*Cycle+PulseGap/2+gmSEQ.pi gSG.AWGFreq 0 gSG.compAWGAmp]; % pi/2_x
    WaveForm_1I(1 + (i-1)*60 + 59, :) = [gmSEQ.interval+(i-1+46/48)*Cycle gmSEQ.interval+(i-1+46/48)*Cycle+gmSEQ.pi gSG.AWGFreq 0 gSG.piAWGAmp]; % pi_x
    WaveForm_1I(1 + (i-1)*60 + 60, :) = [gmSEQ.interval+(i-1+47/48)*Cycle gmSEQ.interval+(i-1+47/48)*Cycle+gmSEQ.pi gSG.AWGFreq 3*pi/2 gSG.piAWGAmp]; % -pi_y
end
if gmSEQ.CoolSwitch == 0
    WaveForm_1I(2 + 60*gmSEQ.m, :) = [gmSEQ.m*Cycle+buffer gmSEQ.m*Cycle+gmSEQ.pi+buffer  gSG.AWGFreq 0 0]; % z-basis measurement 
elseif gmSEQ.CoolSwitch == 1 
    WaveForm_1I(2 + 60*gmSEQ.m, :) = [gmSEQ.m*Cycle+buffer gmSEQ.m*Cycle+gmSEQ.halfpi+buffer  gSG.AWGFreq 0 gSG.halfpiAWGAmp]; % x-basis measurement 
else
    WaveForm_1I(2 + 60*gmSEQ.m, :) = [gmSEQ.m*Cycle+buffer gmSEQ.m*Cycle+gmSEQ.halfpi+buffer  gSG.AWGFreq pi/2 gSG.halfpiAWGAmp]; % y-basis measurement
end

WaveForm_1Q = WaveForm_1I - repmat([0 0 0 pi/2 0], size(WaveForm_1I, 1), 1);
WaveForm_1Length = ceil((gmSEQ.m*Cycle+gmSEQ.pi+buffer+1000) / (16 / gSG.AWGClockRate)) ...
    *(16 / gSG.AWGClockRate);
WaveForm_1PointNum = WaveForm_1Length * gSG.AWGClockRate;

% Considering using another way to do the differential measurement
WaveForm_2I = WaveForm_1I;
if gmSEQ.CoolSwitch == 0
    WaveForm_2I(size(WaveForm_2I, 1), :) = [gmSEQ.m*Cycle+buffer gmSEQ.m*Cycle+gmSEQ.pi+buffer gSG.AWGFreq 0 gSG.piAWGAmp]; % Differential measurement
elseif gmSEQ.CoolSwitch == 1 
    WaveForm_2I(size(WaveForm_2I, 1), :) = [gmSEQ.m*Cycle+buffer gmSEQ.m*Cycle+gmSEQ.halfpi+buffer gSG.AWGFreq pi gSG.halfpiAWGAmp]; % x-basis measurement 
else
    WaveForm_2I(size(WaveForm_2I, 1), :) = [gmSEQ.m*Cycle+buffer gmSEQ.m*Cycle+gmSEQ.halfpi+buffer  gSG.AWGFreq 3*pi/2 gSG.halfpiAWGAmp]; % y-basis measurement
end
WaveForm_2Q = WaveForm_2I - repmat([0 0 0 pi/2 0], size(WaveForm_2I, 1), 1);
WaveForm_2Length = WaveForm_1Length;
WaveForm_2PointNum = WaveForm_2Length * gSG.AWGClockRate;


chaseFunctionPool('createWaveform', WaveForm_1I, gSG.AWGClockRate, WaveForm_1Length, 'DROID60N_I_seg1.txt'); pause(0.5);
chaseFunctionPool('createWaveform', WaveForm_1Q, gSG.AWGClockRate, WaveForm_1Length, 'DROID60N_Q_seg1.txt'); pause(0.5);
chaseFunctionPool('createWaveform', WaveForm_2I, gSG.AWGClockRate, WaveForm_2Length, 'DROID60N_I_seg2.txt'); pause(0.5);
chaseFunctionPool('createWaveform', WaveForm_2Q, gSG.AWGClockRate, WaveForm_2Length, 'DROID60N_Q_seg2.txt'); pause(0.5);

chaseFunctionPool('createSegStruct', 'DROID60N_SegStruct_I.txt', ...
    'DROID60N_I_seg1.txt', WaveForm_1PointNum, 1, 1, ...
    'DROID60N_I_seg2.txt', WaveForm_2PointNum, 1, 1);
pause(0.5);
chaseFunctionPool('createSegStruct', 'DROID60N_SegStruct_Q.txt', ...
    'DROID60N_Q_seg1.txt', WaveForm_1PointNum, 1, 1, ...
    'DROID60N_Q_seg2.txt', WaveForm_2PointNum, 1, 1);
pause(0.5);

%% Load waveform to AWG
chaseFunctionPool('CreateSegments', gmSEQ.MWAWG, 1, ...
    2, ...
    2047, 2047, 'DROID60N_SegStruct_I.txt', 'false');
pause(1); % this pause seems to be important, otherwise the loading is not right occassionally
chaseFunctionPool('CreateSegments', gmSEQ.MWAWG, 2, ...
    2, ...
    2047, 2047, 'DROID60N_SegStruct_Q.txt', 'false');
pause(1); % this pause seems to be important, otherwise the loading is not right occassionally
%% Run waveform
chaseFunctionPool('runChase', gmSEQ.MWAWG, 'false');
ApplyDelays();

function Cory48N_tomo % Put in the north/south pole
global gmSEQ gSG
gSG.bfixedPow=1;
gSG.bfixedFreq=1;
gSG.bMod='IQ';
gSG.bModSrc='External';

[gmSEQ.ScaleT, gmSEQ.ScaleStr] = GetScale((48*gmSEQ.pi+72*gmSEQ.interval)*gmSEQ.To);

gmSEQ.Ntomo = 3;
% TODO: add the definition for the pi and halfpi pulse AWG amp
gSG.piAWGAmp = gmSEQ.SAmp1; % Just for temporary use
gSG.halfpiAWGAmp = gmSEQ.SAmp2; % Just for temporary use

% gmSEQ.m here is the repetition number of XY8 block
gmSEQ.m = round(gmSEQ.m);

AfterPi = 1000;
AfterLaser = 100e3;
Wait_p = 10e3;
Detect_Window = 5000;
PulseGap = 0;

Cycle = gmSEQ.interval*72 + gmSEQ.halfpi*48;
Sig_D_start = Wait_p+gmSEQ.readout+AfterLaser+Cycle*gmSEQ.m+gmSEQ.pi+AfterPi+Detect_Window+Wait_p;

gmSEQ.CHN(1).PBN=PBDictionary('ctr0');
gmSEQ.CHN(1).NRise=4;
gmSEQ.CHN(1).T=[Wait_p+gmSEQ.readout-1000-gmSEQ.CtrGateDur, ...
    Wait_p+gmSEQ.readout+AfterLaser+Cycle*gmSEQ.m+gmSEQ.pi+AfterPi, ...
    Sig_D_start+gmSEQ.readout-1000-gmSEQ.CtrGateDur, ... 
    Sig_D_start+gmSEQ.readout+AfterLaser+Cycle*gmSEQ.m+gmSEQ.pi+AfterPi];
if strcmp(gmSEQ.meas,'SPCM')
    gmSEQ.CHN(1).DT=[gmSEQ.CtrGateDur gmSEQ.CtrGateDur gmSEQ.CtrGateDur gmSEQ.CtrGateDur];
elseif strcmp(gmSEQ.meas,'APD')
    gmSEQ.CHN(1).DT=[1000 1000 1000 1000];
end

gmSEQ.CHN(numel(gmSEQ.CHN)+1).PBN=PBDictionary('AOM');
gmSEQ.CHN(numel(gmSEQ.CHN)).NRise=4;
gmSEQ.CHN(numel(gmSEQ.CHN)).T = [Wait_p, Wait_p+gmSEQ.readout+AfterLaser+Cycle*gmSEQ.m+gmSEQ.pi+AfterPi, ...
    Sig_D_start, Sig_D_start+gmSEQ.readout+AfterLaser+Cycle*gmSEQ.m+gmSEQ.pi+AfterPi];
gmSEQ.CHN(numel(gmSEQ.CHN)).DT = [gmSEQ.readout Detect_Window gmSEQ.readout Detect_Window];


gmSEQ.CHN(numel(gmSEQ.CHN)+1).PBN=PBDictionary('AWGTrig');
gmSEQ.CHN(numel(gmSEQ.CHN)).NRise=2;
gmSEQ.CHN(numel(gmSEQ.CHN)).T=[Wait_p+gmSEQ.readout+AfterLaser, ...
    Sig_D_start+gmSEQ.readout+AfterLaser];
gmSEQ.CHN(numel(gmSEQ.CHN)).DT=repelem(Cycle*gmSEQ.m+gmSEQ.pi+200, 2);

buffer = 20;
gmSEQ.CHN(numel(gmSEQ.CHN)+1).PBN=PBDictionary('MWSwitch');
if gmSEQ.m == 0 || gmSEQ.interval < 1000
    gmSEQ.CHN(numel(gmSEQ.CHN)).NRise=2;
    gmSEQ.CHN(numel(gmSEQ.CHN)).T=[Wait_p+gmSEQ.readout+AfterLaser-200, Sig_D_start+gmSEQ.readout+AfterLaser-200];
    gmSEQ.CHN(numel(gmSEQ.CHN)).DT=[Cycle*gmSEQ.m+gmSEQ.pi+buffer+400, Cycle*gmSEQ.m+gmSEQ.pi+buffer+400];
else % Need update later Weijie 04/25/2022
    gmSEQ.CHN(numel(gmSEQ.CHN)).NRise=96*gmSEQ.m + 1;
    gmSEQ.CHN(numel(gmSEQ.CHN)).T = zeros(1, gmSEQ.CHN(numel(gmSEQ.CHN)).NRise);
    for i = 1:gmSEQ.m
        for j = 1:6
            gmSEQ.CHN(numel(gmSEQ.CHN)).T((i-1)*48+(j-1)*6+1) = Wait_p+gmSEQ.readout+AfterLaser+(i-1+(j-1)/6)*Cycle+gmSEQ.interval-20;
            gmSEQ.CHN(numel(gmSEQ.CHN)).T((i-1)*48+(j-1)*6+2) = Wait_p+gmSEQ.readout+AfterLaser+(i-1+(j-1)/6)*Cycle+2*gmSEQ.interval+gmSEQ.halfpi-20;
            gmSEQ.CHN(numel(gmSEQ.CHN)).T((i-1)*48+(j-1)*6+3) = Wait_p+gmSEQ.readout+AfterLaser+(i-1+(j-1)/6)*Cycle+4*gmSEQ.interval+2*gmSEQ.halfpi-20;
            gmSEQ.CHN(numel(gmSEQ.CHN)).T((i-1)*48+(j-1)*6+4) = Wait_p+gmSEQ.readout+AfterLaser+(i-1+(j-1)/6)*Cycle+5*gmSEQ.interval+3*gmSEQ.halfpi-20;
            gmSEQ.CHN(numel(gmSEQ.CHN)).T((i-1)*48+(j-1)*6+5) = Wait_p+gmSEQ.readout+AfterLaser+(i-1+(j-1)/6)*Cycle+7*gmSEQ.interval+4*gmSEQ.halfpi-20;
            gmSEQ.CHN(numel(gmSEQ.CHN)).T((i-1)*48+(j-1)*6+6) = Wait_p+gmSEQ.readout+AfterLaser+(i-1+(j-1)/6)*Cycle+8*gmSEQ.interval+5*gmSEQ.halfpi-20;
            gmSEQ.CHN(numel(gmSEQ.CHN)).T((i-1)*48+(j-1)*6+7) = Wait_p+gmSEQ.readout+AfterLaser+(i-1+(j-1)/6)*Cycle+10*gmSEQ.interval+6*gmSEQ.halfpi-20;
            gmSEQ.CHN(numel(gmSEQ.CHN)).T((i-1)*48+(j-1)*6+8) = Wait_p+gmSEQ.readout+AfterLaser+(i-1+(j-1)/6)*Cycle+11*gmSEQ.interval+7*gmSEQ.halfpi-20;

            gmSEQ.CHN(numel(gmSEQ.CHN)).T(48*gmSEQ.m+(i-1)*48+(j-1)*6+1) = Sig_D_start+gmSEQ.readout+AfterLaser+(i-1+(j-1)/6)*Cycle+gmSEQ.interval-20;
            gmSEQ.CHN(numel(gmSEQ.CHN)).T(48*gmSEQ.m+(i-1)*48+(j-1)*6+2) = Sig_D_start+gmSEQ.readout+AfterLaser+(i-1+(j-1)/6)*Cycle+2*gmSEQ.interval+gmSEQ.halfpi-20;
            gmSEQ.CHN(numel(gmSEQ.CHN)).T(48*gmSEQ.m+(i-1)*48+(j-1)*6+3) = Sig_D_start+gmSEQ.readout+AfterLaser+(i-1+(j-1)/6)*Cycle+4*gmSEQ.interval+2*gmSEQ.halfpi-20;
            gmSEQ.CHN(numel(gmSEQ.CHN)).T(48*gmSEQ.m+(i-1)*48+(j-1)*6+4) = Sig_D_start+gmSEQ.readout+AfterLaser+(i-1+(j-1)/6)*Cycle+5*gmSEQ.interval+3*gmSEQ.halfpi-20;
            gmSEQ.CHN(numel(gmSEQ.CHN)).T(48*gmSEQ.m+(i-1)*48+(j-1)*6+5) = Sig_D_start+gmSEQ.readout+AfterLaser+(i-1+(j-1)/6)*Cycle+7*gmSEQ.interval+4*gmSEQ.halfpi-20;
            gmSEQ.CHN(numel(gmSEQ.CHN)).T(48*gmSEQ.m+(i-1)*48+(j-1)*6+6) = Sig_D_start+gmSEQ.readout+AfterLaser+(i-1+(j-1)/6)*Cycle+8*gmSEQ.interval+5*gmSEQ.halfpi-20;
            gmSEQ.CHN(numel(gmSEQ.CHN)).T(48*gmSEQ.m+(i-1)*48+(j-1)*6+7) = Sig_D_start+gmSEQ.readout+AfterLaser+(i-1+(j-1)/6)*Cycle+10*gmSEQ.interval+6*gmSEQ.halfpi-20;
            gmSEQ.CHN(numel(gmSEQ.CHN)).T(48*gmSEQ.m+(i-1)*48+(j-1)*6+8) = Sig_D_start+gmSEQ.readout+AfterLaser+(i-1+(j-1)/6)*Cycle+11*gmSEQ.interval+7*gmSEQ.halfpi-20;
        end
    end
    gmSEQ.CHN(numel(gmSEQ.CHN)).T(96*gmSEQ.m+1) = Sig_D_start+gmSEQ.readout+AfterLaser+gmSEQ.m*Cycle-20;
    gmSEQ.CHN(numel(gmSEQ.CHN)).DT=[repelem(gmSEQ.halfpi+40, 96*gmSEQ.m), gmSEQ.pi+40];
end


gmSEQ.CHN(numel(gmSEQ.CHN)+1).PBN=PBDictionary('dummy1');
gmSEQ.CHN(numel(gmSEQ.CHN)).NRise=2;
gmSEQ.CHN(numel(gmSEQ.CHN)).T=[0 Sig_D_start+gmSEQ.readout+AfterLaser+gmSEQ.m*Cycle+gmSEQ.pi+AfterPi+Detect_Window-50];
gmSEQ.CHN(numel(gmSEQ.CHN)).DT=[50 50];

%% AWG
% Initialization
chaseFunctionPool('stopChase',  gmSEQ.MWAWG)

% This part need to be modified to accomodate the DC modulation
if ~gSG.ACmodAWG % in AC modulation mode
    gSG.AWGFreq = 0;
end

WaveForm_1I = zeros(2 + 48*gmSEQ.m, 5);
if gmSEQ.m == 0
    WaveForm_1I(1, :) = [0 buffer gSG.AWGFreq 0 0];
else
    WaveForm_1I(1, :) = [0 gmSEQ.interval gSG.AWGFreq 0 0];
end
for i = 1:gmSEQ.m
    WaveForm_1I(1 + (i-1)*48 + 1, :) = [(i-1)*Cycle+gmSEQ.interval (i-1)*Cycle+gmSEQ.interval+gmSEQ.halfpi gSG.AWGFreq 0 gSG.halfpiAWGAmp]; % pi/2_x
    WaveForm_1I(1 + (i-1)*48 + 2, :) = [(i-1)*Cycle+2*gmSEQ.interval+gmSEQ.halfpi (i-1)*Cycle+2*gmSEQ.interval+2*gmSEQ.halfpi gSG.AWGFreq pi/2 gSG.halfpiAWGAmp]; % pi/2_y
    WaveForm_1I(1 + (i-1)*48 + 3, :) = [(i-1)*Cycle+4*gmSEQ.interval+2*gmSEQ.halfpi (i-1)*Cycle+4*gmSEQ.interval+3*gmSEQ.halfpi gSG.AWGFreq pi gSG.halfpiAWGAmp]; % pi/2_-x
    WaveForm_1I(1 + (i-1)*48 + 4, :) = [(i-1)*Cycle+5*gmSEQ.interval+3*gmSEQ.halfpi (i-1)*Cycle+5*gmSEQ.interval+4*gmSEQ.halfpi gSG.AWGFreq pi/2 gSG.halfpiAWGAmp]; % pi/2_y
    WaveForm_1I(1 + (i-1)*48 + 5, :) = [(i-1)*Cycle+7*gmSEQ.interval+4*gmSEQ.halfpi (i-1)*Cycle+7*gmSEQ.interval+5*gmSEQ.halfpi gSG.AWGFreq 0 gSG.halfpiAWGAmp]; % pi/2_x
    WaveForm_1I(1 + (i-1)*48 + 6, :) = [(i-1)*Cycle+8*gmSEQ.interval+5*gmSEQ.halfpi (i-1)*Cycle+8*gmSEQ.interval+6*gmSEQ.halfpi gSG.AWGFreq pi/2 gSG.halfpiAWGAmp]; % pi/2_y
    WaveForm_1I(1 + (i-1)*48 + 7, :) = [(i-1)*Cycle+10*gmSEQ.interval+6*gmSEQ.halfpi (i-1)*Cycle+10*gmSEQ.interval+7*gmSEQ.halfpi gSG.AWGFreq 0 gSG.halfpiAWGAmp]; % pi/2_x
    WaveForm_1I(1 + (i-1)*48 + 8, :) = [(i-1)*Cycle+11*gmSEQ.interval+7*gmSEQ.halfpi (i-1)*Cycle+11*gmSEQ.interval+8*gmSEQ.halfpi gSG.AWGFreq pi/2 gSG.halfpiAWGAmp]; % pi/2_y
    WaveForm_1I(1 + (i-1)*48 + 9, :) = [(i-1)*Cycle+13*gmSEQ.interval+8*gmSEQ.halfpi (i-1)*Cycle+13*gmSEQ.interval+9*gmSEQ.halfpi gSG.AWGFreq 0 gSG.halfpiAWGAmp]; % pi/2_x
    WaveForm_1I(1 + (i-1)*48 + 10, :) = [(i-1)*Cycle+14*gmSEQ.interval+9*gmSEQ.halfpi (i-1)*Cycle+14*gmSEQ.interval+10*gmSEQ.halfpi gSG.AWGFreq 3*pi/2 gSG.halfpiAWGAmp]; % pi/2_-y
    WaveForm_1I(1 + (i-1)*48 + 11, :) = [(i-1)*Cycle+16*gmSEQ.interval+10*gmSEQ.halfpi (i-1)*Cycle+16*gmSEQ.interval+11*gmSEQ.halfpi gSG.AWGFreq 0 gSG.halfpiAWGAmp]; % pi/2_x
    WaveForm_1I(1 + (i-1)*48 + 12, :) = [(i-1)*Cycle+17*gmSEQ.interval+11*gmSEQ.halfpi (i-1)*Cycle+17*gmSEQ.interval+12*gmSEQ.halfpi gSG.AWGFreq pi/2 gSG.halfpiAWGAmp]; % pi/2_y
    WaveForm_1I(1 + (i-1)*48 + 13, :) = [(i-1)*Cycle+19*gmSEQ.interval+12*gmSEQ.halfpi (i-1)*Cycle+19*gmSEQ.interval+13*gmSEQ.halfpi gSG.AWGFreq 3*pi/2 gSG.halfpiAWGAmp]; % pi/2_-y
    WaveForm_1I(1 + (i-1)*48 + 14, :) = [(i-1)*Cycle+20*gmSEQ.interval+13*gmSEQ.halfpi (i-1)*Cycle+20*gmSEQ.interval+14*gmSEQ.halfpi gSG.AWGFreq pi gSG.halfpiAWGAmp]; % pi/2_-x
    WaveForm_1I(1 + (i-1)*48 + 15, :) = [(i-1)*Cycle+22*gmSEQ.interval+14*gmSEQ.halfpi (i-1)*Cycle+22*gmSEQ.interval+15*gmSEQ.halfpi gSG.AWGFreq pi/2 gSG.halfpiAWGAmp]; % pi/2_y
    WaveForm_1I(1 + (i-1)*48 + 16, :) = [(i-1)*Cycle+23*gmSEQ.interval+15*gmSEQ.halfpi (i-1)*Cycle+23*gmSEQ.interval+16*gmSEQ.halfpi gSG.AWGFreq pi gSG.halfpiAWGAmp]; % pi/2_-x
    WaveForm_1I(1 + (i-1)*48 + 17, :) = [(i-1)*Cycle+25*gmSEQ.interval+16*gmSEQ.halfpi (i-1)*Cycle+25*gmSEQ.interval+17*gmSEQ.halfpi gSG.AWGFreq 3*pi/2 gSG.halfpiAWGAmp]; % pi/2_-y
    WaveForm_1I(1 + (i-1)*48 + 18, :) = [(i-1)*Cycle+26*gmSEQ.interval+17*gmSEQ.halfpi (i-1)*Cycle+26*gmSEQ.interval+18*gmSEQ.halfpi gSG.AWGFreq pi gSG.halfpiAWGAmp]; % pi/2_-x
    WaveForm_1I(1 + (i-1)*48 + 19, :) = [(i-1)*Cycle+28*gmSEQ.interval+18*gmSEQ.halfpi (i-1)*Cycle+28*gmSEQ.interval+19*gmSEQ.halfpi gSG.AWGFreq 3*pi/2 gSG.halfpiAWGAmp]; % pi/2_-y
    WaveForm_1I(1 + (i-1)*48 + 20, :) = [(i-1)*Cycle+29*gmSEQ.interval+19*gmSEQ.halfpi (i-1)*Cycle+29*gmSEQ.interval+20*gmSEQ.halfpi gSG.AWGFreq pi gSG.halfpiAWGAmp]; % pi/2_-x
    WaveForm_1I(1 + (i-1)*48 + 21, :) = [(i-1)*Cycle+31*gmSEQ.interval+20*gmSEQ.halfpi (i-1)*Cycle+31*gmSEQ.interval+21*gmSEQ.halfpi gSG.AWGFreq 3*pi/2 gSG.halfpiAWGAmp]; % pi/2_-y
    WaveForm_1I(1 + (i-1)*48 + 22, :) = [(i-1)*Cycle+32*gmSEQ.interval+21*gmSEQ.halfpi (i-1)*Cycle+32*gmSEQ.interval+22*gmSEQ.halfpi gSG.AWGFreq 0 gSG.halfpiAWGAmp]; % pi/2_x
    WaveForm_1I(1 + (i-1)*48 + 23, :) = [(i-1)*Cycle+34*gmSEQ.interval+22*gmSEQ.halfpi (i-1)*Cycle+34*gmSEQ.interval+23*gmSEQ.halfpi gSG.AWGFreq 3*pi/2 gSG.halfpiAWGAmp]; % pi/2_-y
    WaveForm_1I(1 + (i-1)*48 + 24, :) = [(i-1)*Cycle+35*gmSEQ.interval+23*gmSEQ.halfpi (i-1)*Cycle+35*gmSEQ.interval+24*gmSEQ.halfpi gSG.AWGFreq pi gSG.halfpiAWGAmp]; % pi/2_-x
    WaveForm_1I(1 + (i-1)*48 + 25, :) = [(i-1)*Cycle+37*gmSEQ.interval+24*gmSEQ.halfpi (i-1)*Cycle+37*gmSEQ.interval+25*gmSEQ.halfpi gSG.AWGFreq pi gSG.halfpiAWGAmp]; % pi/2_-x
    WaveForm_1I(1 + (i-1)*48 + 26, :) = [(i-1)*Cycle+38*gmSEQ.interval+25*gmSEQ.halfpi (i-1)*Cycle+38*gmSEQ.interval+26*gmSEQ.halfpi gSG.AWGFreq pi/2 gSG.halfpiAWGAmp]; % pi/2_y
    WaveForm_1I(1 + (i-1)*48 + 27, :) = [(i-1)*Cycle+40*gmSEQ.interval+26*gmSEQ.halfpi (i-1)*Cycle+40*gmSEQ.interval+27*gmSEQ.halfpi gSG.AWGFreq pi gSG.halfpiAWGAmp]; % pi/2_-x
    WaveForm_1I(1 + (i-1)*48 + 28, :) = [(i-1)*Cycle+41*gmSEQ.interval+27*gmSEQ.halfpi (i-1)*Cycle+41*gmSEQ.interval+28*gmSEQ.halfpi gSG.AWGFreq 3*pi/2 gSG.halfpiAWGAmp]; % pi/2_-y
    WaveForm_1I(1 + (i-1)*48 + 29, :) = [(i-1)*Cycle+43*gmSEQ.interval+28*gmSEQ.halfpi (i-1)*Cycle+43*gmSEQ.interval+29*gmSEQ.halfpi gSG.AWGFreq pi gSG.halfpiAWGAmp]; % pi/2_-x
    WaveForm_1I(1 + (i-1)*48 + 30, :) = [(i-1)*Cycle+44*gmSEQ.interval+29*gmSEQ.halfpi (i-1)*Cycle+44*gmSEQ.interval+30*gmSEQ.halfpi gSG.AWGFreq pi/2 gSG.halfpiAWGAmp]; % pi/2_y
    WaveForm_1I(1 + (i-1)*48 + 31, :) = [(i-1)*Cycle+46*gmSEQ.interval+30*gmSEQ.halfpi (i-1)*Cycle+46*gmSEQ.interval+31*gmSEQ.halfpi gSG.AWGFreq 0 gSG.halfpiAWGAmp]; % pi/2_x
    WaveForm_1I(1 + (i-1)*48 + 32, :) = [(i-1)*Cycle+47*gmSEQ.interval+31*gmSEQ.halfpi (i-1)*Cycle+47*gmSEQ.interval+32*gmSEQ.halfpi gSG.AWGFreq 3*pi/2 gSG.halfpiAWGAmp]; % pi/2_-y
    WaveForm_1I(1 + (i-1)*48 + 33, :) = [(i-1)*Cycle+49*gmSEQ.interval+32*gmSEQ.halfpi (i-1)*Cycle+49*gmSEQ.interval+33*gmSEQ.halfpi gSG.AWGFreq pi gSG.halfpiAWGAmp]; % pi/2_-x
    WaveForm_1I(1 + (i-1)*48 + 34, :) = [(i-1)*Cycle+50*gmSEQ.interval+33*gmSEQ.halfpi (i-1)*Cycle+50*gmSEQ.interval+34*gmSEQ.halfpi gSG.AWGFreq 3*pi/2 gSG.halfpiAWGAmp]; % pi/2_-y
    WaveForm_1I(1 + (i-1)*48 + 35, :) = [(i-1)*Cycle+52*gmSEQ.interval+34*gmSEQ.halfpi (i-1)*Cycle+52*gmSEQ.interval+35*gmSEQ.halfpi gSG.AWGFreq 0 gSG.halfpiAWGAmp]; % pi/2_x
    WaveForm_1I(1 + (i-1)*48 + 36, :) = [(i-1)*Cycle+53*gmSEQ.interval+35*gmSEQ.halfpi (i-1)*Cycle+53*gmSEQ.interval+36*gmSEQ.halfpi gSG.AWGFreq 3*pi/2 gSG.halfpiAWGAmp]; % pi/2_-y
    WaveForm_1I(1 + (i-1)*48 + 37, :) = [(i-1)*Cycle+55*gmSEQ.interval+36*gmSEQ.halfpi (i-1)*Cycle+55*gmSEQ.interval+37*gmSEQ.halfpi gSG.AWGFreq pi/2 gSG.halfpiAWGAmp]; % pi/2_y
    WaveForm_1I(1 + (i-1)*48 + 38, :) = [(i-1)*Cycle+56*gmSEQ.interval+37*gmSEQ.halfpi (i-1)*Cycle+56*gmSEQ.interval+38*gmSEQ.halfpi gSG.AWGFreq pi gSG.halfpiAWGAmp]; % pi/2_-x
    WaveForm_1I(1 + (i-1)*48 + 39, :) = [(i-1)*Cycle+58*gmSEQ.interval+38*gmSEQ.halfpi (i-1)*Cycle+58*gmSEQ.interval+39*gmSEQ.halfpi gSG.AWGFreq pi/2 gSG.halfpiAWGAmp]; % pi/2_y
    WaveForm_1I(1 + (i-1)*48 + 40, :) = [(i-1)*Cycle+59*gmSEQ.interval+39*gmSEQ.halfpi (i-1)*Cycle+59*gmSEQ.interval+40*gmSEQ.halfpi gSG.AWGFreq 0 gSG.halfpiAWGAmp]; % pi/2_x
    WaveForm_1I(1 + (i-1)*48 + 41, :) = [(i-1)*Cycle+61*gmSEQ.interval+40*gmSEQ.halfpi (i-1)*Cycle+61*gmSEQ.interval+41*gmSEQ.halfpi gSG.AWGFreq pi/2 gSG.halfpiAWGAmp]; % pi/2_y
    WaveForm_1I(1 + (i-1)*48 + 42, :) = [(i-1)*Cycle+62*gmSEQ.interval+41*gmSEQ.halfpi (i-1)*Cycle+62*gmSEQ.interval+42*gmSEQ.halfpi gSG.AWGFreq pi gSG.halfpiAWGAmp]; % pi/2_-x
    WaveForm_1I(1 + (i-1)*48 + 43, :) = [(i-1)*Cycle+64*gmSEQ.interval+42*gmSEQ.halfpi (i-1)*Cycle+64*gmSEQ.interval+43*gmSEQ.halfpi gSG.AWGFreq 3*pi/2 gSG.halfpiAWGAmp]; % pi/2_-y
    WaveForm_1I(1 + (i-1)*48 + 44, :) = [(i-1)*Cycle+65*gmSEQ.interval+43*gmSEQ.halfpi (i-1)*Cycle+65*gmSEQ.interval+44*gmSEQ.halfpi gSG.AWGFreq 0 gSG.halfpiAWGAmp]; % pi/2_x
    WaveForm_1I(1 + (i-1)*48 + 45, :) = [(i-1)*Cycle+67*gmSEQ.interval+44*gmSEQ.halfpi (i-1)*Cycle+67*gmSEQ.interval+45*gmSEQ.halfpi gSG.AWGFreq pi/2 gSG.halfpiAWGAmp]; % pi/2_y
    WaveForm_1I(1 + (i-1)*48 + 46, :) = [(i-1)*Cycle+68*gmSEQ.interval+45*gmSEQ.halfpi (i-1)*Cycle+68*gmSEQ.interval+46*gmSEQ.halfpi gSG.AWGFreq 0 gSG.halfpiAWGAmp]; % pi/2_x
    WaveForm_1I(1 + (i-1)*48 + 47, :) = [(i-1)*Cycle+70*gmSEQ.interval+46*gmSEQ.halfpi (i-1)*Cycle+70*gmSEQ.interval+47*gmSEQ.halfpi gSG.AWGFreq 3*pi/2 gSG.halfpiAWGAmp]; % pi/2_-y
    WaveForm_1I(1 + (i-1)*48 + 48, :) = [(i-1)*Cycle+71*gmSEQ.interval+47*gmSEQ.halfpi (i-1)*Cycle+71*gmSEQ.interval+48*gmSEQ.halfpi gSG.AWGFreq 0 gSG.halfpiAWGAmp]; % pi/2_x
end
if gmSEQ.CoolSwitch == 0
    WaveForm_1I(2 + 48*gmSEQ.m, :) = [gmSEQ.m*Cycle+buffer gmSEQ.m*Cycle+gmSEQ.pi+buffer  gSG.AWGFreq 0 0]; % z-basis measurement 
elseif gmSEQ.CoolSwitch == 1 
    WaveForm_1I(2 + 48*gmSEQ.m, :) = [gmSEQ.m*Cycle+buffer gmSEQ.m*Cycle+gmSEQ.halfpi+buffer  gSG.AWGFreq 0 gSG.halfpiAWGAmp]; % x-basis measurement 
else
    WaveForm_1I(2 + 48*gmSEQ.m, :) = [gmSEQ.m*Cycle+buffer gmSEQ.m*Cycle+gmSEQ.halfpi+buffer  gSG.AWGFreq pi/2 gSG.halfpiAWGAmp]; % y-basis measurement
end
WaveForm_1Q = WaveForm_1I - repmat([0 0 0 pi/2 0], size(WaveForm_1I, 1), 1);
WaveForm_1Length = ceil((gmSEQ.m*Cycle+gmSEQ.pi+buffer+1000) / (16 / gSG.AWGClockRate)) ...
    *(16 / gSG.AWGClockRate);
WaveForm_1PointNum = WaveForm_1Length * gSG.AWGClockRate;

WaveForm_2I = WaveForm_1I;
if gmSEQ.CoolSwitch == 0
    WaveForm_2I(size(WaveForm_2I, 1), :) = [gmSEQ.m*Cycle+buffer gmSEQ.m*Cycle+gmSEQ.pi+buffer gSG.AWGFreq 0 gSG.piAWGAmp]; % Differential measurement
elseif gmSEQ.CoolSwitch == 1 
    WaveForm_2I(size(WaveForm_2I, 1), :) = [gmSEQ.m*Cycle+buffer gmSEQ.m*Cycle+gmSEQ.halfpi+buffer gSG.AWGFreq pi gSG.halfpiAWGAmp]; % x-basis measurement 
else
    WaveForm_2I(size(WaveForm_2I, 1), :) = [gmSEQ.m*Cycle+buffer gmSEQ.m*Cycle+gmSEQ.halfpi+buffer  gSG.AWGFreq 3*pi/2 gSG.halfpiAWGAmp]; % y-basis measurement
end
WaveForm_2Q = WaveForm_2I - repmat([0 0 0 pi/2 0], size(WaveForm_2I, 1), 1);
WaveForm_2Length = WaveForm_1Length;
WaveForm_2PointNum = WaveForm_2Length * gSG.AWGClockRate;

chaseFunctionPool('createWaveform', WaveForm_1I, gSG.AWGClockRate, WaveForm_1Length, 'Cory48N_I_seg1.txt'); pause(0.5);
chaseFunctionPool('createWaveform', WaveForm_1Q, gSG.AWGClockRate, WaveForm_1Length, 'Cory48N_Q_seg1.txt'); pause(0.5);
chaseFunctionPool('createWaveform', WaveForm_2I, gSG.AWGClockRate, WaveForm_2Length, 'Cory48N_I_seg2.txt'); pause(0.5);
chaseFunctionPool('createWaveform', WaveForm_2Q, gSG.AWGClockRate, WaveForm_2Length, 'Cory48N_Q_seg2.txt'); pause(0.5);

chaseFunctionPool('createSegStruct', 'Cory48N_SegStruct_I.txt', ...
    'Cory48N_I_seg1.txt', WaveForm_1PointNum, 1, 1, ...
    'Cory48N_I_seg2.txt', WaveForm_2PointNum, 1, 1);
pause(0.5);
chaseFunctionPool('createSegStruct', 'Cory48N_SegStruct_Q.txt', ...
    'Cory48N_Q_seg1.txt', WaveForm_1PointNum, 1, 1, ...
    'Cory48N_Q_seg2.txt', WaveForm_2PointNum, 1, 1);
pause(0.5);

%% Load waveform to AWG
chaseFunctionPool('CreateSegments', gmSEQ.MWAWG, 1, ...
    2, ...
    2047, 2047, 'Cory48N_SegStruct_I.txt', 'false');
pause(1); % this pause seems to be important, otherwise the loading is not right occassionally
chaseFunctionPool('CreateSegments', gmSEQ.MWAWG, 2, ...
    2, ...
    2047, 2047, 'Cory48N_SegStruct_Q.txt', 'false');
pause(1); % this pause seems to be important, otherwise the loading is not right occassionally
%% Run waveform
chaseFunctionPool('runChase', gmSEQ.MWAWG, 'false');
ApplyDelays();

function SeqHN_tomo % Put in the north/south pole
global gmSEQ gSG
gSG.bfixedPow=1;
gSG.bfixedFreq=1;
gSG.bMod='IQ';
gSG.bModSrc='External';

[gmSEQ.ScaleT, gmSEQ.ScaleStr] = GetScale((12*gmSEQ.pi+12*gmSEQ.halfpi+24*gmSEQ.interval)*gmSEQ.To);

gmSEQ.Ntomo = 3;
% TODO: add the definition for the pi and halfpi pulse AWG amp
% gSG.piAWGAmp = gmSEQ.SAmp1; % Just for temporary use
% gSG.halfpiAWGAmp = gmSEQ.SAmp2; % Just for temporary use
gSG.piAWGAmp = gSG.AWGAmp; % Just for temporary use
gSG.halfpiAWGAmp = gSG.AWGAmp; % Just for temporary use

% gmSEQ.m here is the repetition number of XY8 block
gmSEQ.m = round(gmSEQ.m);

AfterPi = 1000;
AfterLaser = 100e3;
Wait_p = 10e3;
Detect_Window = 5000;

Cycle = gmSEQ.interval*24 + gmSEQ.halfpi*12 + gmSEQ.pi*12;
Sig_D_start = Wait_p+gmSEQ.readout+AfterLaser+Cycle*gmSEQ.m+gmSEQ.pi+AfterPi+Detect_Window+Wait_p;

gmSEQ.CHN(1).PBN=PBDictionary('ctr0');
gmSEQ.CHN(1).NRise=4;
gmSEQ.CHN(1).T=[Wait_p+gmSEQ.readout-1000-gmSEQ.CtrGateDur, ...
    Wait_p+gmSEQ.readout+AfterLaser+Cycle*gmSEQ.m+gmSEQ.pi+AfterPi, ...
    Sig_D_start+gmSEQ.readout-1000-gmSEQ.CtrGateDur, ... 
    Sig_D_start+gmSEQ.readout+AfterLaser+Cycle*gmSEQ.m+gmSEQ.pi+AfterPi];
if strcmp(gmSEQ.meas,'SPCM')
    gmSEQ.CHN(1).DT=[gmSEQ.CtrGateDur gmSEQ.CtrGateDur gmSEQ.CtrGateDur gmSEQ.CtrGateDur];
elseif strcmp(gmSEQ.meas,'APD')
    gmSEQ.CHN(1).DT=[1000 1000 1000 1000];
end

gmSEQ.CHN(numel(gmSEQ.CHN)+1).PBN=PBDictionary('AOM');
gmSEQ.CHN(numel(gmSEQ.CHN)).NRise=4;
gmSEQ.CHN(numel(gmSEQ.CHN)).T = [Wait_p, Wait_p+gmSEQ.readout+AfterLaser+Cycle*gmSEQ.m+gmSEQ.pi+AfterPi, ...
    Sig_D_start, Sig_D_start+gmSEQ.readout+AfterLaser+Cycle*gmSEQ.m+gmSEQ.pi+AfterPi];
gmSEQ.CHN(numel(gmSEQ.CHN)).DT = [gmSEQ.readout Detect_Window gmSEQ.readout Detect_Window];


gmSEQ.CHN(numel(gmSEQ.CHN)+1).PBN=PBDictionary('AWGTrig');
gmSEQ.CHN(numel(gmSEQ.CHN)).NRise=2;
gmSEQ.CHN(numel(gmSEQ.CHN)).T=[Wait_p+gmSEQ.readout+AfterLaser, ...
    Sig_D_start+gmSEQ.readout+AfterLaser];
gmSEQ.CHN(numel(gmSEQ.CHN)).DT=repelem(Cycle*gmSEQ.m+gmSEQ.pi+200, 2);

gmSEQ.CHN(numel(gmSEQ.CHN)+1).PBN=PBDictionary('MWSwitch');

buffer = 20; 
if gmSEQ.m == 0 || gmSEQ.interval < 2000
    gmSEQ.CHN(numel(gmSEQ.CHN)).NRise=2;
    gmSEQ.CHN(numel(gmSEQ.CHN)).T=[Wait_p+gmSEQ.readout+AfterLaser-200, Sig_D_start+gmSEQ.readout+AfterLaser-200];
    gmSEQ.CHN(numel(gmSEQ.CHN)).DT=[Cycle*gmSEQ.m+gmSEQ.pi+buffer+400, Cycle*gmSEQ.m+gmSEQ.pi+buffer+400];
else % Need update later Weijie 04/29/2022
    gmSEQ.CHN(numel(gmSEQ.CHN)).NRise=48*gmSEQ.m + 1;
    gmSEQ.CHN(numel(gmSEQ.CHN)).T = zeros(1, gmSEQ.CHN(numel(gmSEQ.CHN)).NRise);
    for i = 1:gmSEQ.m
        for j = 1:12
            gmSEQ.CHN(numel(gmSEQ.CHN)).T((i-1)*24+(j-1)*2+1) = Wait_p+gmSEQ.readout+AfterLaser+(i-1)*Cycle+(j-1)*(2*gmSEQ.interval+gmSEQ.halfpi+gmSEQ.pi)+gmSEQ.interval-20;
            gmSEQ.CHN(numel(gmSEQ.CHN)).T((i-1)*24+(j-1)*2+2) = Wait_p+gmSEQ.readout+AfterLaser+(i-1)*Cycle+(j-1)*(2*gmSEQ.interval+gmSEQ.halfpi+gmSEQ.pi)+2*gmSEQ.interval+gmSEQ.pi-20;
            gmSEQ.CHN(numel(gmSEQ.CHN)).T(24*gmSEQ.m+(i-1)*24+(j-1)*2+1) = Sig_D_start+gmSEQ.readout+AfterLaser+(i-1)*Cycle+(j-1)*(2*gmSEQ.interval+gmSEQ.halfpi+gmSEQ.pi)+gmSEQ.interval-20;
            gmSEQ.CHN(numel(gmSEQ.CHN)).T(24*gmSEQ.m+(i-1)*24+(j-1)*2+2) = Sig_D_start+gmSEQ.readout+AfterLaser+(i-1)*Cycle+(j-1)*(2*gmSEQ.interval+gmSEQ.halfpi+gmSEQ.pi)+2*gmSEQ.interval+gmSEQ.pi-20;
        end
    end
    gmSEQ.CHN(numel(gmSEQ.CHN)).T(48*gmSEQ.m+1) = Sig_D_start+gmSEQ.readout+AfterLaser+gmSEQ.m*Cycle-20;
    gmSEQ.CHN(numel(gmSEQ.CHN)).DT=[repelem([gmSEQ.pi+40 gmSEQ.halfpi+40], 24*gmSEQ.m), gmSEQ.pi+40];
end


gmSEQ.CHN(numel(gmSEQ.CHN)+1).PBN=PBDictionary('dummy1');
gmSEQ.CHN(numel(gmSEQ.CHN)).NRise=2;
gmSEQ.CHN(numel(gmSEQ.CHN)).T=[0 Sig_D_start+gmSEQ.readout+AfterLaser+gmSEQ.m*Cycle+gmSEQ.pi+AfterPi+Detect_Window-50];
gmSEQ.CHN(numel(gmSEQ.CHN)).DT=[50 50];

%% AWG
% Initialization
chaseFunctionPool('stopChase',  gmSEQ.MWAWG)

% This part need to be modified to accomodate the DC modulation
if ~gSG.ACmodAWG % in AC modulation mode
    gSG.AWGFreq = 0;
end

WaveForm_1I = zeros(2 + 24*gmSEQ.m, 5);
if gmSEQ.m == 0
    WaveForm_1I(1, :) = [0 buffer gSG.AWGFreq 0 0];
else
    WaveForm_1I(1, :) = [0 gmSEQ.interval gSG.AWGFreq 0 0];
end
for i = 1:gmSEQ.m
    WaveForm_1I(1 + (i-1)*24 + 1, :) = [(i-1)*Cycle+gmSEQ.interval (i-1)*Cycle+gmSEQ.interval+gmSEQ.pi gSG.AWGFreq 3*pi/2 gSG.piAWGAmp]; % pi_-y
    WaveForm_1I(1 + (i-1)*24 + 2, :) = [(i-1)*Cycle+2*gmSEQ.interval+gmSEQ.pi (i-1)*Cycle+2*gmSEQ.interval+gmSEQ.pi+gmSEQ.halfpi gSG.AWGFreq pi/2 gSG.halfpiAWGAmp]; % pi/2_y
    WaveForm_1I(1 + (i-1)*24 + 3, :) = [(i-1)*Cycle+3*gmSEQ.interval+gmSEQ.pi+gmSEQ.halfpi (i-1)*Cycle+3*gmSEQ.interval+2*gmSEQ.pi+gmSEQ.halfpi gSG.AWGFreq 0 gSG.piAWGAmp]; % pi_x
    WaveForm_1I(1 + (i-1)*24 + 4, :) = [(i-1)*Cycle+4*gmSEQ.interval+2*gmSEQ.pi+gmSEQ.halfpi (i-1)*Cycle+4*gmSEQ.interval+2*gmSEQ.pi+2*gmSEQ.halfpi gSG.AWGFreq pi gSG.halfpiAWGAmp]; % pi/2_-x
    WaveForm_1I(1 + (i-1)*24 + 5, :) = [(i-1)*Cycle+5*gmSEQ.interval+2*gmSEQ.pi+2*gmSEQ.halfpi (i-1)*Cycle+5*gmSEQ.interval+3*gmSEQ.pi+2*gmSEQ.halfpi gSG.AWGFreq pi/2 gSG.piAWGAmp]; % pi_y
    WaveForm_1I(1 + (i-1)*24 + 6, :) = [(i-1)*Cycle+6*gmSEQ.interval+3*gmSEQ.pi+2*gmSEQ.halfpi (i-1)*Cycle+6*gmSEQ.interval+3*gmSEQ.pi+3*gmSEQ.halfpi gSG.AWGFreq 3*pi/2 gSG.halfpiAWGAmp]; % pi/2_-y
    WaveForm_1I(1 + (i-1)*24 + 7, :) = [(i-1)*Cycle+7*gmSEQ.interval+3*gmSEQ.pi+3*gmSEQ.halfpi (i-1)*Cycle+7*gmSEQ.interval+4*gmSEQ.pi+3*gmSEQ.halfpi gSG.AWGFreq 0 gSG.piAWGAmp]; % pi_x
    WaveForm_1I(1 + (i-1)*24 + 8, :) = [(i-1)*Cycle+8*gmSEQ.interval+4*gmSEQ.pi+3*gmSEQ.halfpi (i-1)*Cycle+8*gmSEQ.interval+4*gmSEQ.pi+4*gmSEQ.halfpi gSG.AWGFreq pi gSG.halfpiAWGAmp]; % pi/2_-x
    WaveForm_1I(1 + (i-1)*24 + 9, :) = [(i-1)*Cycle+9*gmSEQ.interval+4*gmSEQ.pi+4*gmSEQ.halfpi (i-1)*Cycle+9*gmSEQ.interval+5*gmSEQ.pi+4*gmSEQ.halfpi gSG.AWGFreq pi/2 gSG.piAWGAmp]; % pi_y
    WaveForm_1I(1 + (i-1)*24 + 10, :) = [(i-1)*Cycle+10*gmSEQ.interval+5*gmSEQ.pi+4*gmSEQ.halfpi (i-1)*Cycle+10*gmSEQ.interval+5*gmSEQ.pi+5*gmSEQ.halfpi gSG.AWGFreq pi/2 gSG.halfpiAWGAmp]; % pi/2_y
    WaveForm_1I(1 + (i-1)*24 + 11, :) = [(i-1)*Cycle+11*gmSEQ.interval+5*gmSEQ.pi+5*gmSEQ.halfpi (i-1)*Cycle+11*gmSEQ.interval+6*gmSEQ.pi+5*gmSEQ.halfpi gSG.AWGFreq 0 gSG.piAWGAmp]; % pi_x
    WaveForm_1I(1 + (i-1)*24 + 12, :) = [(i-1)*Cycle+12*gmSEQ.interval+6*gmSEQ.pi+5*gmSEQ.halfpi (i-1)*Cycle+12*gmSEQ.interval+6*gmSEQ.pi+6*gmSEQ.halfpi gSG.AWGFreq 0 gSG.halfpiAWGAmp]; % pi/2_x
    WaveForm_1I(1 + (i-1)*24 + 13, :) = [(i-1)*Cycle+13*gmSEQ.interval+6*gmSEQ.pi+6*gmSEQ.halfpi (i-1)*Cycle+13*gmSEQ.interval+7*gmSEQ.pi+6*gmSEQ.halfpi gSG.AWGFreq pi/2 gSG.piAWGAmp]; % pi_y
    WaveForm_1I(1 + (i-1)*24 + 14, :) = [(i-1)*Cycle+14*gmSEQ.interval+7*gmSEQ.pi+6*gmSEQ.halfpi (i-1)*Cycle+14*gmSEQ.interval+7*gmSEQ.pi+7*gmSEQ.halfpi gSG.AWGFreq pi/2 gSG.halfpiAWGAmp]; % pi/2_y
    WaveForm_1I(1 + (i-1)*24 + 15, :) = [(i-1)*Cycle+15*gmSEQ.interval+7*gmSEQ.pi+7*gmSEQ.halfpi (i-1)*Cycle+15*gmSEQ.interval+8*gmSEQ.pi+7*gmSEQ.halfpi gSG.AWGFreq pi gSG.piAWGAmp]; % pi_-x
    WaveForm_1I(1 + (i-1)*24 + 16, :) = [(i-1)*Cycle+16*gmSEQ.interval+8*gmSEQ.pi+7*gmSEQ.halfpi (i-1)*Cycle+16*gmSEQ.interval+8*gmSEQ.pi+8*gmSEQ.halfpi gSG.AWGFreq 0 gSG.halfpiAWGAmp]; % pi/2_x
    WaveForm_1I(1 + (i-1)*24 + 17, :) = [(i-1)*Cycle+17*gmSEQ.interval+8*gmSEQ.pi+8*gmSEQ.halfpi (i-1)*Cycle+17*gmSEQ.interval+9*gmSEQ.pi+8*gmSEQ.halfpi gSG.AWGFreq 3*pi/2 gSG.piAWGAmp]; % pi_-y
    WaveForm_1I(1 + (i-1)*24 + 18, :) = [(i-1)*Cycle+18*gmSEQ.interval+9*gmSEQ.pi+8*gmSEQ.halfpi (i-1)*Cycle+18*gmSEQ.interval+9*gmSEQ.pi+9*gmSEQ.halfpi gSG.AWGFreq 3*pi/2 gSG.halfpiAWGAmp]; % pi/2_-y
    WaveForm_1I(1 + (i-1)*24 + 19, :) = [(i-1)*Cycle+19*gmSEQ.interval+9*gmSEQ.pi+9*gmSEQ.halfpi (i-1)*Cycle+19*gmSEQ.interval+10*gmSEQ.pi+9*gmSEQ.halfpi gSG.AWGFreq 0 gSG.piAWGAmp]; % pi_x
    WaveForm_1I(1 + (i-1)*24 + 20, :) = [(i-1)*Cycle+20*gmSEQ.interval+10*gmSEQ.pi+9*gmSEQ.halfpi (i-1)*Cycle+20*gmSEQ.interval+10*gmSEQ.pi+10*gmSEQ.halfpi gSG.AWGFreq 0 gSG.halfpiAWGAmp]; % pi/2_x
    WaveForm_1I(1 + (i-1)*24 + 21, :) = [(i-1)*Cycle+21*gmSEQ.interval+10*gmSEQ.pi+10*gmSEQ.halfpi (i-1)*Cycle+21*gmSEQ.interval+11*gmSEQ.pi+10*gmSEQ.halfpi gSG.AWGFreq pi/2 gSG.piAWGAmp]; % pi_y
    WaveForm_1I(1 + (i-1)*24 + 22, :) = [(i-1)*Cycle+22*gmSEQ.interval+11*gmSEQ.pi+10*gmSEQ.halfpi (i-1)*Cycle+22*gmSEQ.interval+11*gmSEQ.pi+11*gmSEQ.halfpi gSG.AWGFreq pi/2 gSG.halfpiAWGAmp]; % pi/2_y
    WaveForm_1I(1 + (i-1)*24 + 23, :) = [(i-1)*Cycle+23*gmSEQ.interval+11*gmSEQ.pi+11*gmSEQ.halfpi (i-1)*Cycle+23*gmSEQ.interval+12*gmSEQ.pi+11*gmSEQ.halfpi gSG.AWGFreq 0 gSG.piAWGAmp]; % pi_x
    WaveForm_1I(1 + (i-1)*24 + 24, :) = [(i-1)*Cycle+24*gmSEQ.interval+12*gmSEQ.pi+11*gmSEQ.halfpi (i-1)*Cycle+24*gmSEQ.interval+12*gmSEQ.pi+12*gmSEQ.halfpi gSG.AWGFreq pi gSG.halfpiAWGAmp]; % pi/2_-x
end
if gmSEQ.CoolSwitch == 0
    WaveForm_1I(2 + 24*gmSEQ.m, :) = [gmSEQ.m*Cycle+buffer gmSEQ.m*Cycle+gmSEQ.pi+buffer  gSG.AWGFreq 0 0]; % z-basis measurement 
elseif gmSEQ.CoolSwitch == 1 
    WaveForm_1I(2 + 24*gmSEQ.m, :) = [gmSEQ.m*Cycle+buffer gmSEQ.m*Cycle+gmSEQ.halfpi+buffer  gSG.AWGFreq 0 gSG.halfpiAWGAmp]; % x-basis measurement 
else
    WaveForm_1I(2 + 24*gmSEQ.m, :) = [gmSEQ.m*Cycle+buffer gmSEQ.m*Cycle+gmSEQ.halfpi+buffer  gSG.AWGFreq pi/2 gSG.halfpiAWGAmp]; % y-basis measurement
end

WaveForm_1Q = WaveForm_1I - repmat([0 0 0 pi/2 0], size(WaveForm_1I, 1), 1);
WaveForm_1Length = ceil((gmSEQ.m*Cycle+gmSEQ.pi+buffer+1000) / (16 / gSG.AWGClockRate)) ...
    *(16 / gSG.AWGClockRate);
WaveForm_1PointNum = WaveForm_1Length * gSG.AWGClockRate;

WaveForm_2I = WaveForm_1I;
if gmSEQ.CoolSwitch == 0
    WaveForm_2I(size(WaveForm_2I, 1), :) = [gmSEQ.m*Cycle+buffer gmSEQ.m*Cycle+gmSEQ.pi+buffer gSG.AWGFreq 0 gSG.piAWGAmp]; % Differential measurement
elseif gmSEQ.CoolSwitch == 1 
    WaveForm_2I(size(WaveForm_2I, 1), :) = [gmSEQ.m*Cycle+buffer gmSEQ.m*Cycle+gmSEQ.halfpi+buffer gSG.AWGFreq pi gSG.halfpiAWGAmp]; % x-basis measurement 
else
    WaveForm_2I(size(WaveForm_2I, 1), :) = [gmSEQ.m*Cycle+buffer gmSEQ.m*Cycle+gmSEQ.halfpi+buffer  gSG.AWGFreq 3*pi/2 gSG.halfpiAWGAmp]; % y-basis measurement
end
WaveForm_2Q = WaveForm_2I - repmat([0 0 0 pi/2 0], size(WaveForm_2I, 1), 1);
WaveForm_2Length = WaveForm_1Length;
WaveForm_2PointNum = WaveForm_2Length * gSG.AWGClockRate;


chaseFunctionPool('createWaveform', WaveForm_1I, gSG.AWGClockRate, WaveForm_1Length, 'SeqHN_I_seg1.txt'); pause(0.5);
chaseFunctionPool('createWaveform', WaveForm_1Q, gSG.AWGClockRate, WaveForm_1Length, 'SeqHN_Q_seg1.txt'); pause(0.5);
chaseFunctionPool('createWaveform', WaveForm_2I, gSG.AWGClockRate, WaveForm_2Length, 'SeqHN_I_seg2.txt'); pause(0.5);
chaseFunctionPool('createWaveform', WaveForm_2Q, gSG.AWGClockRate, WaveForm_2Length, 'SeqHN_Q_seg2.txt'); pause(0.5);

chaseFunctionPool('createSegStruct', 'SeqHN_SegStruct_I.txt', ...
    'SeqHN_I_seg1.txt', WaveForm_1PointNum, 1, 1, ...
    'SeqHN_I_seg2.txt', WaveForm_2PointNum, 1, 1);
pause(0.5);
chaseFunctionPool('createSegStruct', 'SeqHN_SegStruct_Q.txt', ...
    'SeqHN_Q_seg1.txt', WaveForm_1PointNum, 1, 1, ...
    'SeqHN_Q_seg2.txt', WaveForm_2PointNum, 1, 1);
pause(0.5);

%% Load waveform to AWG
chaseFunctionPool('CreateSegments', gmSEQ.MWAWG, 1, ...
    2, ...
    2047, 2047, 'SeqHN_SegStruct_I.txt', 'false');
pause(1); % this pause seems to be important, otherwise the loading is not right occassionally
chaseFunctionPool('CreateSegments', gmSEQ.MWAWG, 2, ...
    2, ...
    2047, 2047, 'SeqHN_SegStruct_Q.txt', 'false');
pause(1); % this pause seems to be important, otherwise the loading is not right occassionally
%% Run waveform
chaseFunctionPool('runChase', gmSEQ.MWAWG, 'false');
ApplyDelays();

function SeqGN_tomo % Put in the north/south pole
global gmSEQ gSG
gSG.bfixedPow=1;
gSG.bfixedFreq=1;
gSG.bMod='IQ';
gSG.bModSrc='External';

gmSEQ.Ntomo = 3;
% TODO: add the definition for the pi and halfpi pulse AWG amp
gSG.piAWGAmp = gmSEQ.SAmp1; % Just for temporary use
gSG.halfpiAWGAmp = gmSEQ.SAmp2; % Just for temporary use

% gmSEQ.m here is the repetition number of XY8 block
gmSEQ.m = round(gmSEQ.m);

AfterPi = 1000;
AfterLaser = 100e3;
Wait_p = 10e3;
Detect_Window = 5000;

Cycle = gmSEQ.interval*12 + gmSEQ.halfpi*12;
Sig_D_start = Wait_p+gmSEQ.readout+AfterLaser+Cycle*gmSEQ.m+gmSEQ.pi+AfterPi+Detect_Window+Wait_p;

gmSEQ.CHN(1).PBN=PBDictionary('ctr0');
gmSEQ.CHN(1).NRise=4;
gmSEQ.CHN(1).T=[Wait_p+gmSEQ.readout-1000-gmSEQ.CtrGateDur, ...
    Wait_p+gmSEQ.readout+AfterLaser+Cycle*gmSEQ.m+gmSEQ.pi+AfterPi, ...
    Sig_D_start+gmSEQ.readout-1000-gmSEQ.CtrGateDur, ... 
    Sig_D_start+gmSEQ.readout+AfterLaser+Cycle*gmSEQ.m+gmSEQ.pi+AfterPi];
if strcmp(gmSEQ.meas,'SPCM')
    gmSEQ.CHN(1).DT=[gmSEQ.CtrGateDur gmSEQ.CtrGateDur gmSEQ.CtrGateDur gmSEQ.CtrGateDur];
elseif strcmp(gmSEQ.meas,'APD')
    gmSEQ.CHN(1).DT=[1000 1000 1000 1000];
end

gmSEQ.CHN(numel(gmSEQ.CHN)+1).PBN=PBDictionary('AOM');
gmSEQ.CHN(numel(gmSEQ.CHN)).NRise=4;
gmSEQ.CHN(numel(gmSEQ.CHN)).T = [Wait_p, Wait_p+gmSEQ.readout+AfterLaser+Cycle*gmSEQ.m+gmSEQ.pi+AfterPi, ...
    Sig_D_start, Sig_D_start+gmSEQ.readout+AfterLaser+Cycle*gmSEQ.m+gmSEQ.pi+AfterPi];
gmSEQ.CHN(numel(gmSEQ.CHN)).DT = [gmSEQ.readout Detect_Window gmSEQ.readout Detect_Window];


gmSEQ.CHN(numel(gmSEQ.CHN)+1).PBN=PBDictionary('AWGTrig');
gmSEQ.CHN(numel(gmSEQ.CHN)).NRise=2;
gmSEQ.CHN(numel(gmSEQ.CHN)).T=[Wait_p+gmSEQ.readout+AfterLaser, ...
    Sig_D_start+gmSEQ.readout+AfterLaser];
gmSEQ.CHN(numel(gmSEQ.CHN)).DT=repelem(Cycle*gmSEQ.m+gmSEQ.pi+200, 2);

buffer = 20;  % to avoid composite pulse 
gmSEQ.CHN(numel(gmSEQ.CHN)+1).PBN=PBDictionary('MWSwitch');
if gmSEQ.m == 0 || gmSEQ.interval < 1000
    gmSEQ.CHN(numel(gmSEQ.CHN)).NRise=2;
    gmSEQ.CHN(numel(gmSEQ.CHN)).T=[Wait_p+gmSEQ.readout+AfterLaser-200, Sig_D_start+gmSEQ.readout+AfterLaser-200];
    gmSEQ.CHN(numel(gmSEQ.CHN)).DT=[Cycle*gmSEQ.m+gmSEQ.pi+buffer+400, Cycle*gmSEQ.m+gmSEQ.pi+buffer+400];
else % Need update later Weijie 04/29/2022
    gmSEQ.CHN(numel(gmSEQ.CHN)).NRise=96*gmSEQ.m + 1;
    gmSEQ.CHN(numel(gmSEQ.CHN)).T = zeros(1, gmSEQ.CHN(numel(gmSEQ.CHN)).NRise);
    for i = 1:gmSEQ.m
        for j = 1:6
            gmSEQ.CHN(numel(gmSEQ.CHN)).T((i-1)*48+(j-1)*6+1) = Wait_p+gmSEQ.readout+AfterLaser+(i-1+(j-1)/6)*Cycle+gmSEQ.interval-20;
            gmSEQ.CHN(numel(gmSEQ.CHN)).T((i-1)*48+(j-1)*6+2) = Wait_p+gmSEQ.readout+AfterLaser+(i-1+(j-1)/6)*Cycle+2*gmSEQ.interval+gmSEQ.halfpi-20;
            gmSEQ.CHN(numel(gmSEQ.CHN)).T((i-1)*48+(j-1)*6+3) = Wait_p+gmSEQ.readout+AfterLaser+(i-1+(j-1)/6)*Cycle+4*gmSEQ.interval+2*gmSEQ.halfpi-20;
            gmSEQ.CHN(numel(gmSEQ.CHN)).T((i-1)*48+(j-1)*6+4) = Wait_p+gmSEQ.readout+AfterLaser+(i-1+(j-1)/6)*Cycle+5*gmSEQ.interval+3*gmSEQ.halfpi-20;
            gmSEQ.CHN(numel(gmSEQ.CHN)).T((i-1)*48+(j-1)*6+5) = Wait_p+gmSEQ.readout+AfterLaser+(i-1+(j-1)/6)*Cycle+7*gmSEQ.interval+4*gmSEQ.halfpi-20;
            gmSEQ.CHN(numel(gmSEQ.CHN)).T((i-1)*48+(j-1)*6+6) = Wait_p+gmSEQ.readout+AfterLaser+(i-1+(j-1)/6)*Cycle+8*gmSEQ.interval+5*gmSEQ.halfpi-20;
            gmSEQ.CHN(numel(gmSEQ.CHN)).T((i-1)*48+(j-1)*6+7) = Wait_p+gmSEQ.readout+AfterLaser+(i-1+(j-1)/6)*Cycle+10*gmSEQ.interval+6*gmSEQ.halfpi-20;
            gmSEQ.CHN(numel(gmSEQ.CHN)).T((i-1)*48+(j-1)*6+8) = Wait_p+gmSEQ.readout+AfterLaser+(i-1+(j-1)/6)*Cycle+11*gmSEQ.interval+7*gmSEQ.halfpi-20;

            gmSEQ.CHN(numel(gmSEQ.CHN)).T(48*gmSEQ.m+(i-1)*48+(j-1)*6+1) = Sig_D_start+gmSEQ.readout+AfterLaser+(i-1+(j-1)/6)*Cycle+gmSEQ.interval-20;
            gmSEQ.CHN(numel(gmSEQ.CHN)).T(48*gmSEQ.m+(i-1)*48+(j-1)*6+2) = Sig_D_start+gmSEQ.readout+AfterLaser+(i-1+(j-1)/6)*Cycle+2*gmSEQ.interval+gmSEQ.halfpi-20;
            gmSEQ.CHN(numel(gmSEQ.CHN)).T(48*gmSEQ.m+(i-1)*48+(j-1)*6+3) = Sig_D_start+gmSEQ.readout+AfterLaser+(i-1+(j-1)/6)*Cycle+4*gmSEQ.interval+2*gmSEQ.halfpi-20;
            gmSEQ.CHN(numel(gmSEQ.CHN)).T(48*gmSEQ.m+(i-1)*48+(j-1)*6+4) = Sig_D_start+gmSEQ.readout+AfterLaser+(i-1+(j-1)/6)*Cycle+5*gmSEQ.interval+3*gmSEQ.halfpi-20;
            gmSEQ.CHN(numel(gmSEQ.CHN)).T(48*gmSEQ.m+(i-1)*48+(j-1)*6+5) = Sig_D_start+gmSEQ.readout+AfterLaser+(i-1+(j-1)/6)*Cycle+7*gmSEQ.interval+4*gmSEQ.halfpi-20;
            gmSEQ.CHN(numel(gmSEQ.CHN)).T(48*gmSEQ.m+(i-1)*48+(j-1)*6+6) = Sig_D_start+gmSEQ.readout+AfterLaser+(i-1+(j-1)/6)*Cycle+8*gmSEQ.interval+5*gmSEQ.halfpi-20;
            gmSEQ.CHN(numel(gmSEQ.CHN)).T(48*gmSEQ.m+(i-1)*48+(j-1)*6+7) = Sig_D_start+gmSEQ.readout+AfterLaser+(i-1+(j-1)/6)*Cycle+10*gmSEQ.interval+6*gmSEQ.halfpi-20;
            gmSEQ.CHN(numel(gmSEQ.CHN)).T(48*gmSEQ.m+(i-1)*48+(j-1)*6+8) = Sig_D_start+gmSEQ.readout+AfterLaser+(i-1+(j-1)/6)*Cycle+11*gmSEQ.interval+7*gmSEQ.halfpi-20;
        end
    end
    gmSEQ.CHN(numel(gmSEQ.CHN)).T(96*gmSEQ.m+1) = Sig_D_start+gmSEQ.readout+AfterLaser+gmSEQ.m*Cycle-20;
    gmSEQ.CHN(numel(gmSEQ.CHN)).DT=[repelem(gmSEQ.halfpi+40, 96*gmSEQ.m), gmSEQ.pi+40];
end

gmSEQ.CHN(numel(gmSEQ.CHN)+1).PBN=PBDictionary('dummy1');
gmSEQ.CHN(numel(gmSEQ.CHN)).NRise=2;
gmSEQ.CHN(numel(gmSEQ.CHN)).T=[0 Sig_D_start+gmSEQ.readout+AfterLaser+gmSEQ.m*Cycle+gmSEQ.pi+AfterPi+Detect_Window-50];
gmSEQ.CHN(numel(gmSEQ.CHN)).DT=[50 50];

%% AWG
% Initialization
chaseFunctionPool('stopChase',  gmSEQ.MWAWG)

% This part need to be modified to accomodate the DC modulation
if ~gSG.ACmodAWG % in AC modulation mode
    gSG.AWGFreq = 0;
end

WaveForm_1I = zeros(2 + 12*gmSEQ.m, 5);
if gmSEQ.m == 0
    WaveForm_1I(1, :) = [0 buffer gSG.AWGFreq 0 0];
else
    WaveForm_1I(1, :) = [0 gmSEQ.interval gSG.AWGFreq 0 0];
end
for i = 1:gmSEQ.m
    WaveForm_1I(1 + (i-1)*12 + 1, :) = [(i-1)*Cycle+gmSEQ.interval (i-1)*Cycle+gmSEQ.interval+gmSEQ.halfpi gSG.AWGFreq 0 gSG.halfpiAWGAmp]; % pi/2_x
    WaveForm_1I(1 + (i-1)*12 + 2, :) = [(i-1)*Cycle+2*gmSEQ.interval+gmSEQ.halfpi (i-1)*Cycle+2*gmSEQ.interval+2*gmSEQ.halfpi gSG.AWGFreq 3*pi/2 gSG.halfpiAWGAmp]; % pi/2_-y
    WaveForm_1I(1 + (i-1)*12 + 3, :) = [(i-1)*Cycle+3*gmSEQ.interval+2*gmSEQ.halfpi (i-1)*Cycle+3*gmSEQ.interval+3*gmSEQ.halfpi gSG.AWGFreq 0 gSG.halfpiAWGAmp]; % pi/2_x
    WaveForm_1I(1 + (i-1)*12 + 4, :) = [(i-1)*Cycle+4*gmSEQ.interval+3*gmSEQ.halfpi (i-1)*Cycle+4*gmSEQ.interval+4*gmSEQ.halfpi gSG.AWGFreq 3*pi/2 gSG.halfpiAWGAmp]; % pi/2_-y
    WaveForm_1I(1 + (i-1)*12 + 5, :) = [(i-1)*Cycle+5*gmSEQ.interval+4*gmSEQ.halfpi (i-1)*Cycle+5*gmSEQ.interval+5*gmSEQ.halfpi gSG.AWGFreq 0 gSG.halfpiAWGAmp]; % pi/2_x
    WaveForm_1I(1 + (i-1)*12 + 6, :) = [(i-1)*Cycle+6*gmSEQ.interval+5*gmSEQ.halfpi (i-1)*Cycle+6*gmSEQ.interval+6*gmSEQ.halfpi gSG.AWGFreq pi/2 gSG.halfpiAWGAmp]; % pi/2_y
    WaveForm_1I(1 + (i-1)*12 + 7, :) = [(i-1)*Cycle+7*gmSEQ.interval+6*gmSEQ.halfpi (i-1)*Cycle+7*gmSEQ.interval+7*gmSEQ.halfpi gSG.AWGFreq 0 gSG.halfpiAWGAmp]; % pi/2_x
    WaveForm_1I(1 + (i-1)*12 + 8, :) = [(i-1)*Cycle+8*gmSEQ.interval+7*gmSEQ.halfpi (i-1)*Cycle+8*gmSEQ.interval+8*gmSEQ.halfpi gSG.AWGFreq 3*pi/2 gSG.halfpiAWGAmp]; % pi/2_-y
    WaveForm_1I(1 + (i-1)*12 + 9, :) = [(i-1)*Cycle+9*gmSEQ.interval+8*gmSEQ.halfpi (i-1)*Cycle+9*gmSEQ.interval+9*gmSEQ.halfpi gSG.AWGFreq 0 gSG.halfpiAWGAmp]; % pi/2_x
    WaveForm_1I(1 + (i-1)*12 + 10, :) = [(i-1)*Cycle+10*gmSEQ.interval+9*gmSEQ.halfpi (i-1)*Cycle+10*gmSEQ.interval+10*gmSEQ.halfpi gSG.AWGFreq 3*pi/2 gSG.halfpiAWGAmp]; % pi/2_-y
    WaveForm_1I(1 + (i-1)*12 + 11, :) = [(i-1)*Cycle+11*gmSEQ.interval+10*gmSEQ.halfpi (i-1)*Cycle+11*gmSEQ.interval+11*gmSEQ.halfpi gSG.AWGFreq 0 gSG.halfpiAWGAmp]; % pi/2_x
    WaveForm_1I(1 + (i-1)*12 + 12, :) = [(i-1)*Cycle+12*gmSEQ.interval+11*gmSEQ.halfpi (i-1)*Cycle+12*gmSEQ.interval+12*gmSEQ.halfpi gSG.AWGFreq pi/2 gSG.halfpiAWGAmp]; % pi/2_y
end
if gmSEQ.CoolSwitch == 0
    WaveForm_1I(2 + 12*gmSEQ.m, :) = [gmSEQ.m*Cycle+buffer gmSEQ.m*Cycle+gmSEQ.pi+buffer  gSG.AWGFreq 0 0]; % z-basis measurement 
elseif gmSEQ.CoolSwitch == 1 
    WaveForm_1I(2 + 12*gmSEQ.m, :) = [gmSEQ.m*Cycle+buffer gmSEQ.m*Cycle+gmSEQ.halfpi+buffer  gSG.AWGFreq 0 gSG.halfpiAWGAmp]; % x-basis measurement 
else
    WaveForm_1I(2 + 12*gmSEQ.m, :) = [gmSEQ.m*Cycle+buffer gmSEQ.m*Cycle+gmSEQ.halfpi+buffer  gSG.AWGFreq pi/2 gSG.halfpiAWGAmp]; % y-basis measurement
end

WaveForm_1Q = WaveForm_1I - repmat([0 0 0 pi/2 0], size(WaveForm_1I, 1), 1);
WaveForm_1Length = ceil((gmSEQ.m*Cycle+gmSEQ.pi+buffer+1000) / (16 / gSG.AWGClockRate)) ...
    *(16 / gSG.AWGClockRate);
WaveForm_1PointNum = WaveForm_1Length * gSG.AWGClockRate;

WaveForm_2I = WaveForm_1I;
if gmSEQ.CoolSwitch == 0
    WaveForm_2I(size(WaveForm_2I, 1), :) = [gmSEQ.m*Cycle+buffer gmSEQ.m*Cycle+gmSEQ.pi+buffer gSG.AWGFreq 0 gSG.piAWGAmp]; % Differential measurement
elseif gmSEQ.CoolSwitch == 1 
    WaveForm_2I(size(WaveForm_2I, 1), :) = [gmSEQ.m*Cycle+buffer gmSEQ.m*Cycle+gmSEQ.halfpi+buffer gSG.AWGFreq pi gSG.halfpiAWGAmp]; % x-basis measurement 
else
    WaveForm_2I(size(WaveForm_2I, 1), :) = [gmSEQ.m*Cycle+buffer gmSEQ.m*Cycle+gmSEQ.halfpi+buffer  gSG.AWGFreq 3*pi/2 gSG.halfpiAWGAmp]; % y-basis measurement
end
WaveForm_2Q = WaveForm_2I - repmat([0 0 0 pi/2 0], size(WaveForm_2I, 1), 1);
WaveForm_2Length = WaveForm_1Length;
WaveForm_2PointNum = WaveForm_2Length * gSG.AWGClockRate;


chaseFunctionPool('createWaveform', WaveForm_1I, gSG.AWGClockRate, WaveForm_1Length, 'SeqGN_I_seg1.txt'); pause(0.5);
chaseFunctionPool('createWaveform', WaveForm_1Q, gSG.AWGClockRate, WaveForm_1Length, 'SeqGN_Q_seg1.txt'); pause(0.5);
chaseFunctionPool('createWaveform', WaveForm_2I, gSG.AWGClockRate, WaveForm_2Length, 'SeqGN_I_seg2.txt'); pause(0.5);
chaseFunctionPool('createWaveform', WaveForm_2Q, gSG.AWGClockRate, WaveForm_2Length, 'SeqGN_Q_seg2.txt'); pause(0.5);

chaseFunctionPool('createSegStruct', 'SeqGN_SegStruct_I.txt', ...
    'SeqGN_I_seg1.txt', WaveForm_1PointNum, 1, 1, ...
    'SeqGN_I_seg2.txt', WaveForm_2PointNum, 1, 1);
pause(0.5);
chaseFunctionPool('createSegStruct', 'SeqGN_SegStruct_Q.txt', ...
    'SeqGN_Q_seg1.txt', WaveForm_1PointNum, 1, 1, ...
    'SeqGN_Q_seg2.txt', WaveForm_2PointNum, 1, 1);
pause(0.5);

%% Load waveform to AWG
chaseFunctionPool('CreateSegments', gmSEQ.MWAWG, 1, ...
    2, ...
    2047, 2047, 'SeqGN_SegStruct_I.txt', 'false');
pause(1); % this pause seems to be important, otherwise the loading is not right occassionally
chaseFunctionPool('CreateSegments', gmSEQ.MWAWG, 2, ...
    2, ...
    2047, 2047, 'SeqGN_SegStruct_Q.txt', 'false');
pause(1); % this pause seems to be important, otherwise the loading is not right occassionally
%% Run waveform
chaseFunctionPool('runChase', gmSEQ.MWAWG, 'false');
ApplyDelays();

function DROID60N_Cali % Put in the north/south pole
global gmSEQ gSG
gSG.bfixedPow=1;
gSG.bfixedFreq=1;
gSG.bMod='IQ';
gSG.bModSrc='External';

% TODO: add the definition for the pi and halfpi pulse AWG amp
gSG.piAWGAmp = gmSEQ.m;
gSG.halfpiAWGAmp = gmSEQ.m; 

% gmSEQ.m here is the repetition number of XY8 block
gmSEQ.m = round(gmSEQ.CoolCycle);

AfterPi = 1000;
AfterLaser = 100e3;
Wait_p = 10e3;
Detect_Window = 5000;
PulseGap = 0;

Cycle = (gmSEQ.interval + gmSEQ.pi)*48;
Sig_D_start = Wait_p+gmSEQ.readout+AfterLaser+Cycle*gmSEQ.m+gmSEQ.pi+AfterPi+Detect_Window+Wait_p;

gmSEQ.CHN(1).PBN=PBDictionary('ctr0');
gmSEQ.CHN(1).NRise=4;
gmSEQ.CHN(1).T=[Wait_p+gmSEQ.readout-1000-gmSEQ.CtrGateDur, ...
    Wait_p+gmSEQ.readout+AfterLaser+Cycle*gmSEQ.m+gmSEQ.pi+AfterPi, ...
    Sig_D_start+gmSEQ.readout-1000-gmSEQ.CtrGateDur, ... 
    Sig_D_start+gmSEQ.readout+AfterLaser+Cycle*gmSEQ.m+gmSEQ.pi+AfterPi];
if strcmp(gmSEQ.meas,'SPCM')
    gmSEQ.CHN(1).DT=[gmSEQ.CtrGateDur gmSEQ.CtrGateDur gmSEQ.CtrGateDur gmSEQ.CtrGateDur];
elseif strcmp(gmSEQ.meas,'APD')
    gmSEQ.CHN(1).DT=[1000 1000 1000 1000];
end

gmSEQ.CHN(numel(gmSEQ.CHN)+1).PBN=PBDictionary('AOM');
gmSEQ.CHN(numel(gmSEQ.CHN)).NRise=4;
gmSEQ.CHN(numel(gmSEQ.CHN)).T = [Wait_p, Wait_p+gmSEQ.readout+AfterLaser+Cycle*gmSEQ.m+gmSEQ.pi+AfterPi, ...
    Sig_D_start, Sig_D_start+gmSEQ.readout+AfterLaser+Cycle*gmSEQ.m+gmSEQ.pi+AfterPi];
gmSEQ.CHN(numel(gmSEQ.CHN)).DT = [gmSEQ.readout Detect_Window gmSEQ.readout Detect_Window];


gmSEQ.CHN(numel(gmSEQ.CHN)+1).PBN=PBDictionary('AWGTrig');
gmSEQ.CHN(numel(gmSEQ.CHN)).NRise=2;
gmSEQ.CHN(numel(gmSEQ.CHN)).T=[Wait_p+gmSEQ.readout+AfterLaser, ...
    Sig_D_start+gmSEQ.readout+AfterLaser];
gmSEQ.CHN(numel(gmSEQ.CHN)).DT=repelem(Cycle*gmSEQ.m+gmSEQ.pi+200, 2);

gmSEQ.CHN(numel(gmSEQ.CHN)+1).PBN=PBDictionary('MWSwitch');
if gmSEQ.m == 0
        gmSEQ.CHN(numel(gmSEQ.CHN)).NRise=1;
        gmSEQ.CHN(numel(gmSEQ.CHN)).T= Sig_D_start+gmSEQ.readout+AfterLaser-20 ;
        gmSEQ.CHN(numel(gmSEQ.CHN)).DT= gmSEQ.pi+40;
else
    if gmSEQ.interval < 1200
        gmSEQ.CHN(numel(gmSEQ.CHN)).NRise=2;
        gmSEQ.CHN(numel(gmSEQ.CHN)).T=[Wait_p+gmSEQ.readout+AfterLaser-20, Sig_D_start+gmSEQ.readout+AfterLaser-20];
        gmSEQ.CHN(numel(gmSEQ.CHN)).DT=[Cycle*gmSEQ.m+gmSEQ.pi+40, Cycle*gmSEQ.m+gmSEQ.pi+40];
    else
        gmSEQ.CHN(numel(gmSEQ.CHN)).NRise=96*gmSEQ.m + 1;
        gmSEQ.CHN(numel(gmSEQ.CHN)).T = zeros(1, gmSEQ.CHN(numel(gmSEQ.CHN)).NRise);
        for i = 1:gmSEQ.m
            for j = 1:48
             gmSEQ.CHN(numel(gmSEQ.CHN)).T((i-1)*48+j) = Wait_p+gmSEQ.readout+AfterLaser+gmSEQ.interval/2+(i-1+(j-1)/48)*Cycle-20;
             gmSEQ.CHN(numel(gmSEQ.CHN)).T(48*gmSEQ.m+(i-1)*48+j) = Sig_D_start+gmSEQ.readout+AfterLaser+gmSEQ.interval/2+(i-1+(j-1)/48)*Cycle-20;
            end
        end
        gmSEQ.CHN(numel(gmSEQ.CHN)).T(96*gmSEQ.m+1) = Sig_D_start+gmSEQ.readout+AfterLaser+gmSEQ.m*Cycle-20;
        gmSEQ.CHN(numel(gmSEQ.CHN)).DT=[repelem(gmSEQ.pi+40, 96*gmSEQ.m), gmSEQ.pi+40];
    end
end

gmSEQ.CHN(numel(gmSEQ.CHN)+1).PBN=PBDictionary('dummy1');
gmSEQ.CHN(numel(gmSEQ.CHN)).NRise=2;
gmSEQ.CHN(numel(gmSEQ.CHN)).T=[0 Sig_D_start+gmSEQ.readout+AfterLaser+gmSEQ.m*Cycle+gmSEQ.pi+AfterPi+Detect_Window-50];
gmSEQ.CHN(numel(gmSEQ.CHN)).DT=[50 50];

%% AWG
% Initialization
chaseFunctionPool('stopChase',  gmSEQ.MWAWG)

% This part need to be modified to accomodate the DC modulation
if ~gSG.ACmodAWG % in AC modulation mode
    gSG.AWGFreq = 0;
end

WaveForm_1I = zeros(1 + 60*gmSEQ.m, 5);
for i = 1:gmSEQ.m
    WaveForm_1I((i-1)*60 + 1, :) = [gmSEQ.interval/2+(i-1+0/48)*Cycle gmSEQ.interval/2+(i-1+0/48)*Cycle+gmSEQ.pi gSG.AWGFreq 0 gSG.piAWGAmp]; % pi_x
    WaveForm_1I((i-1)*60 + 2, :) = [gmSEQ.interval/2+(i-1+1/48)*Cycle gmSEQ.interval/2+(i-1+1/48)*Cycle+gmSEQ.pi/2 gSG.AWGFreq 0 gSG.piAWGAmp]; % pi/2_x
    WaveForm_1I((i-1)*60 + 3, :) = [gmSEQ.interval/2+(i-1+1/48)*Cycle+gmSEQ.pi/2+PulseGap gmSEQ.interval/2+(i-1+1/48)*Cycle+PulseGap+gmSEQ.pi gSG.AWGFreq 3*pi/2 gSG.piAWGAmp]; % -pi/2_y
    WaveForm_1I((i-1)*60 + 4, :) = [gmSEQ.interval/2+(i-1+2/48)*Cycle gmSEQ.interval/2+(i-1+2/48)*Cycle+gmSEQ.pi gSG.AWGFreq pi gSG.piAWGAmp]; % -pi_x
    WaveForm_1I((i-1)*60 + 5, :) = [gmSEQ.interval/2+(i-1+3/48)*Cycle gmSEQ.interval/2+(i-1+3/48)*Cycle+gmSEQ.pi gSG.AWGFreq pi gSG.piAWGAmp]; % -pi_x
    WaveForm_1I((i-1)*60 + 6, :) = [gmSEQ.interval/2+(i-1+4/48)*Cycle gmSEQ.interval/2+(i-1+4/48)*Cycle+gmSEQ.pi gSG.AWGFreq 0 gSG.piAWGAmp]; % pi_x
    WaveForm_1I((i-1)*60 + 7, :) = [gmSEQ.interval/2+(i-1+5/48)*Cycle gmSEQ.interval/2+(i-1+5/48)*Cycle+gmSEQ.pi/2 gSG.AWGFreq 0 gSG.piAWGAmp]; % pi/2_x
    WaveForm_1I((i-1)*60 + 8, :) = [gmSEQ.interval/2+(i-1+5/48)*Cycle+gmSEQ.pi/2+PulseGap gmSEQ.interval/2+(i-1+5/48)*Cycle+PulseGap+gmSEQ.pi gSG.AWGFreq 3*pi/2 gSG.piAWGAmp]; % -pi/2_y
    WaveForm_1I((i-1)*60 + 9, :) = [gmSEQ.interval/2+(i-1+6/48)*Cycle gmSEQ.interval/2+(i-1+6/48)*Cycle+gmSEQ.pi gSG.AWGFreq pi gSG.piAWGAmp]; % -pi_x
    WaveForm_1I((i-1)*60 + 10, :) = [gmSEQ.interval/2+(i-1+7/48)*Cycle gmSEQ.interval/2+(i-1+7/48)*Cycle+gmSEQ.pi gSG.AWGFreq pi gSG.piAWGAmp]; % -pi_x
    WaveForm_1I((i-1)*60 + 11, :) = [gmSEQ.interval/2+(i-1+8/48)*Cycle gmSEQ.interval/2+(i-1+8/48)*Cycle+gmSEQ.pi gSG.AWGFreq 0 gSG.piAWGAmp]; % pi_x
    WaveForm_1I((i-1)*60 + 12, :) = [gmSEQ.interval/2+(i-1+9/48)*Cycle gmSEQ.interval/2+(i-1+9/48)*Cycle+gmSEQ.pi/2 gSG.AWGFreq 0 gSG.piAWGAmp]; % pi/2_x
    WaveForm_1I((i-1)*60 + 13, :) = [gmSEQ.interval/2+(i-1+9/48)*Cycle+gmSEQ.pi/2+PulseGap gmSEQ.interval/2+(i-1+9/48)*Cycle+PulseGap+gmSEQ.pi gSG.AWGFreq 3*pi/2 gSG.piAWGAmp]; % -pi/2_y
    WaveForm_1I((i-1)*60 + 14, :) = [gmSEQ.interval/2+(i-1+10/48)*Cycle gmSEQ.interval/2+(i-1+10/48)*Cycle+gmSEQ.pi gSG.AWGFreq pi gSG.piAWGAmp]; % -pi_x
    WaveForm_1I((i-1)*60 + 15, :) = [gmSEQ.interval/2+(i-1+11/48)*Cycle gmSEQ.interval/2+(i-1+11/48)*Cycle+gmSEQ.pi gSG.AWGFreq pi gSG.piAWGAmp]; % -pi_x
    WaveForm_1I((i-1)*60 + 16, :) = [gmSEQ.interval/2+(i-1+12/48)*Cycle gmSEQ.interval/2+(i-1+12/48)*Cycle+gmSEQ.pi gSG.AWGFreq 3*pi/2 gSG.piAWGAmp]; % -pi_y
    WaveForm_1I((i-1)*60 + 17, :) = [gmSEQ.interval/2+(i-1+13/48)*Cycle gmSEQ.interval/2+(i-1+13/48)*Cycle+gmSEQ.pi/2 gSG.AWGFreq 3*pi/2 gSG.piAWGAmp]; % -pi/2_y
    WaveForm_1I((i-1)*60 + 18, :) = [gmSEQ.interval/2+(i-1+13/48)*Cycle+gmSEQ.pi/2+PulseGap gmSEQ.interval/2+(i-1+13/48)*Cycle+PulseGap+gmSEQ.pi gSG.AWGFreq 0 gSG.piAWGAmp]; % pi/2_x
    WaveForm_1I((i-1)*60 + 19, :) = [gmSEQ.interval/2+(i-1+14/48)*Cycle gmSEQ.interval/2+(i-1+14/48)*Cycle+gmSEQ.pi gSG.AWGFreq pi/2 gSG.piAWGAmp]; % pi_y
    WaveForm_1I((i-1)*60 + 20, :) = [gmSEQ.interval/2+(i-1+15/48)*Cycle gmSEQ.interval/2+(i-1+15/48)*Cycle+gmSEQ.pi gSG.AWGFreq pi/2 gSG.piAWGAmp]; % pi_y
    WaveForm_1I((i-1)*60 + 21, :) = [gmSEQ.interval/2+(i-1+16/48)*Cycle gmSEQ.interval/2+(i-1+16/48)*Cycle+gmSEQ.pi gSG.AWGFreq 3*pi/2 gSG.piAWGAmp]; % -pi_y
    WaveForm_1I((i-1)*60 + 22, :) = [gmSEQ.interval/2+(i-1+17/48)*Cycle gmSEQ.interval/2+(i-1+17/48)*Cycle+gmSEQ.pi/2 gSG.AWGFreq 3*pi/2 gSG.piAWGAmp]; % -pi/2_y
    WaveForm_1I((i-1)*60 + 23, :) = [gmSEQ.interval/2+(i-1+17/48)*Cycle+gmSEQ.pi/2+PulseGap gmSEQ.interval/2+(i-1+17/48)*Cycle+PulseGap+gmSEQ.pi gSG.AWGFreq 0 gSG.piAWGAmp]; % pi/2_x
    WaveForm_1I((i-1)*60 + 24, :) = [gmSEQ.interval/2+(i-1+18/48)*Cycle gmSEQ.interval/2+(i-1+18/48)*Cycle+gmSEQ.pi gSG.AWGFreq pi/2 gSG.piAWGAmp]; % pi_y
    WaveForm_1I((i-1)*60 + 25, :) = [gmSEQ.interval/2+(i-1+19/48)*Cycle gmSEQ.interval/2+(i-1+19/48)*Cycle+gmSEQ.pi gSG.AWGFreq pi/2 gSG.piAWGAmp]; % pi_y
    WaveForm_1I((i-1)*60 + 26, :) = [gmSEQ.interval/2+(i-1+20/48)*Cycle gmSEQ.interval/2+(i-1+20/48)*Cycle+gmSEQ.pi gSG.AWGFreq 3*pi/2 gSG.piAWGAmp]; % -pi_y
    WaveForm_1I((i-1)*60 + 27, :) = [gmSEQ.interval/2+(i-1+21/48)*Cycle gmSEQ.interval/2+(i-1+21/48)*Cycle+gmSEQ.pi/2 gSG.AWGFreq 3*pi/2 gSG.piAWGAmp]; % -pi/2_y
    WaveForm_1I((i-1)*60 + 28, :) = [gmSEQ.interval/2+(i-1+21/48)*Cycle+gmSEQ.pi/2+PulseGap gmSEQ.interval/2+(i-1+21/48)*Cycle+PulseGap+gmSEQ.pi gSG.AWGFreq 0 gSG.piAWGAmp]; % pi/2_x
    WaveForm_1I((i-1)*60 + 29, :) = [gmSEQ.interval/2+(i-1+22/48)*Cycle gmSEQ.interval/2+(i-1+22/48)*Cycle+gmSEQ.pi gSG.AWGFreq pi/2 gSG.piAWGAmp]; % pi_y
    WaveForm_1I((i-1)*60 + 30, :) = [gmSEQ.interval/2+(i-1+23/48)*Cycle gmSEQ.interval/2+(i-1+23/48)*Cycle+gmSEQ.pi gSG.AWGFreq pi/2 gSG.piAWGAmp]; % pi_y
    WaveForm_1I((i-1)*60 + 31, :) = [gmSEQ.interval/2+(i-1+24/48)*Cycle gmSEQ.interval/2+(i-1+24/48)*Cycle+gmSEQ.pi gSG.AWGFreq 3*pi/2 gSG.piAWGAmp]; % -pi_y
    WaveForm_1I((i-1)*60 + 32, :) = [gmSEQ.interval/2+(i-1+25/48)*Cycle gmSEQ.interval/2+(i-1+25/48)*Cycle+gmSEQ.pi/2 gSG.AWGFreq 0 gSG.piAWGAmp]; % pi/2_x
    WaveForm_1I((i-1)*60 + 33, :) = [gmSEQ.interval/2+(i-1+25/48)*Cycle+gmSEQ.pi/2+PulseGap gmSEQ.interval/2+(i-1+25/48)*Cycle+PulseGap+gmSEQ.pi gSG.AWGFreq pi/2 gSG.piAWGAmp]; % pi/2_y
    WaveForm_1I((i-1)*60 + 34, :) = [gmSEQ.interval/2+(i-1+26/48)*Cycle gmSEQ.interval/2+(i-1+26/48)*Cycle+gmSEQ.pi gSG.AWGFreq pi/2 gSG.piAWGAmp]; % pi_y
    WaveForm_1I((i-1)*60 + 35, :) = [gmSEQ.interval/2+(i-1+27/48)*Cycle gmSEQ.interval/2+(i-1+27/48)*Cycle+gmSEQ.pi gSG.AWGFreq 3*pi/2 gSG.piAWGAmp]; % -pi_y
    WaveForm_1I((i-1)*60 + 36, :) = [gmSEQ.interval/2+(i-1+28/48)*Cycle gmSEQ.interval/2+(i-1+28/48)*Cycle+gmSEQ.pi gSG.AWGFreq 3*pi/2 gSG.piAWGAmp]; % -pi_y
    WaveForm_1I((i-1)*60 + 37, :) = [gmSEQ.interval/2+(i-1+29/48)*Cycle gmSEQ.interval/2+(i-1+29/48)*Cycle+gmSEQ.pi/2 gSG.AWGFreq 0 gSG.piAWGAmp]; % pi/2_x
    WaveForm_1I((i-1)*60 + 38, :) = [gmSEQ.interval/2+(i-1+29/48)*Cycle+gmSEQ.pi/2+PulseGap gmSEQ.interval/2+(i-1+29/48)*Cycle+PulseGap+gmSEQ.pi gSG.AWGFreq pi/2 gSG.piAWGAmp]; % pi/2_y
    WaveForm_1I((i-1)*60 + 39, :) = [gmSEQ.interval/2+(i-1+30/48)*Cycle gmSEQ.interval/2+(i-1+30/48)*Cycle+gmSEQ.pi gSG.AWGFreq pi/2 gSG.piAWGAmp]; % pi_y
    WaveForm_1I((i-1)*60 + 40, :) = [gmSEQ.interval/2+(i-1+31/48)*Cycle gmSEQ.interval/2+(i-1+31/48)*Cycle+gmSEQ.pi gSG.AWGFreq 3*pi/2 gSG.piAWGAmp]; % -pi_y
    WaveForm_1I((i-1)*60 + 41, :) = [gmSEQ.interval/2+(i-1+32/48)*Cycle gmSEQ.interval/2+(i-1+32/48)*Cycle+gmSEQ.pi gSG.AWGFreq 3*pi/2 gSG.piAWGAmp]; % -pi_y
    WaveForm_1I((i-1)*60 + 42, :) = [gmSEQ.interval/2+(i-1+33/48)*Cycle gmSEQ.interval/2+(i-1+33/48)*Cycle+gmSEQ.pi/2 gSG.AWGFreq 0 gSG.piAWGAmp]; % pi/2_x
    WaveForm_1I((i-1)*60 + 43, :) = [gmSEQ.interval/2+(i-1+33/48)*Cycle+gmSEQ.pi/2+PulseGap gmSEQ.interval/2+(i-1+33/48)*Cycle+PulseGap+gmSEQ.pi gSG.AWGFreq pi/2 gSG.piAWGAmp]; % pi/2_y
    WaveForm_1I((i-1)*60 + 44, :) = [gmSEQ.interval/2+(i-1+34/48)*Cycle gmSEQ.interval/2+(i-1+34/48)*Cycle+gmSEQ.pi gSG.AWGFreq pi/2 gSG.piAWGAmp]; % pi_y
    WaveForm_1I((i-1)*60 + 45, :) = [gmSEQ.interval/2+(i-1+35/48)*Cycle gmSEQ.interval/2+(i-1+35/48)*Cycle+gmSEQ.pi gSG.AWGFreq pi gSG.piAWGAmp]; % -pi_x
    WaveForm_1I((i-1)*60 + 46, :) = [gmSEQ.interval/2+(i-1+36/48)*Cycle gmSEQ.interval/2+(i-1+36/48)*Cycle+gmSEQ.pi gSG.AWGFreq pi gSG.piAWGAmp]; % -pi_x
    WaveForm_1I((i-1)*60 + 47, :) = [gmSEQ.interval/2+(i-1+37/48)*Cycle gmSEQ.interval/2+(i-1+37/48)*Cycle+gmSEQ.pi/2 gSG.AWGFreq pi/2 gSG.piAWGAmp]; % pi/2_y
    WaveForm_1I((i-1)*60 + 48, :) = [gmSEQ.interval/2+(i-1+37/48)*Cycle+gmSEQ.pi/2+PulseGap gmSEQ.interval/2+(i-1+37/48)*Cycle+PulseGap+gmSEQ.pi gSG.AWGFreq 0 gSG.piAWGAmp]; % pi/2_x
    WaveForm_1I((i-1)*60 + 49, :) = [gmSEQ.interval/2+(i-1+38/48)*Cycle gmSEQ.interval/2+(i-1+38/48)*Cycle+gmSEQ.pi gSG.AWGFreq 0 gSG.piAWGAmp]; % pi_x
    WaveForm_1I((i-1)*60 + 50, :) = [gmSEQ.interval/2+(i-1+39/48)*Cycle gmSEQ.interval/2+(i-1+39/48)*Cycle+gmSEQ.pi gSG.AWGFreq pi gSG.piAWGAmp]; % -pi_x
    WaveForm_1I((i-1)*60 + 51, :) = [gmSEQ.interval/2+(i-1+40/48)*Cycle gmSEQ.interval/2+(i-1+40/48)*Cycle+gmSEQ.pi gSG.AWGFreq pi gSG.piAWGAmp]; % -pi_x
    WaveForm_1I((i-1)*60 + 52, :) = [gmSEQ.interval/2+(i-1+41/48)*Cycle gmSEQ.interval/2+(i-1+41/48)*Cycle+gmSEQ.pi/2 gSG.AWGFreq pi/2 gSG.piAWGAmp]; % pi/2_y
    WaveForm_1I((i-1)*60 + 53, :) = [gmSEQ.interval/2+(i-1+41/48)*Cycle+gmSEQ.pi/2+PulseGap gmSEQ.interval/2+(i-1+41/48)*Cycle+PulseGap+gmSEQ.pi gSG.AWGFreq 0 gSG.piAWGAmp]; % pi/2_x
    WaveForm_1I((i-1)*60 + 54, :) = [gmSEQ.interval/2+(i-1+42/48)*Cycle gmSEQ.interval/2+(i-1+42/48)*Cycle+gmSEQ.pi gSG.AWGFreq 0 gSG.piAWGAmp]; % pi_x
    WaveForm_1I((i-1)*60 + 55, :) = [gmSEQ.interval/2+(i-1+43/48)*Cycle gmSEQ.interval/2+(i-1+43/48)*Cycle+gmSEQ.pi gSG.AWGFreq pi gSG.piAWGAmp]; % -pi_x
    WaveForm_1I((i-1)*60 + 56, :) = [gmSEQ.interval/2+(i-1+44/48)*Cycle gmSEQ.interval/2+(i-1+44/48)*Cycle+gmSEQ.pi gSG.AWGFreq pi gSG.piAWGAmp]; % -pi_x
    WaveForm_1I((i-1)*60 + 57, :) = [gmSEQ.interval/2+(i-1+45/48)*Cycle gmSEQ.interval/2+(i-1+45/48)*Cycle+gmSEQ.pi/2 gSG.AWGFreq pi/2 gSG.piAWGAmp]; % pi/2_y
    WaveForm_1I((i-1)*60 + 58, :) = [gmSEQ.interval/2+(i-1+45/48)*Cycle+gmSEQ.pi/2+PulseGap gmSEQ.interval/2+(i-1+45/48)*Cycle+PulseGap+gmSEQ.pi gSG.AWGFreq 0 gSG.piAWGAmp]; % pi/2_x
    WaveForm_1I((i-1)*60 + 59, :) = [gmSEQ.interval/2+(i-1+46/48)*Cycle gmSEQ.interval/2+(i-1+46/48)*Cycle+gmSEQ.pi gSG.AWGFreq 0 gSG.piAWGAmp]; % pi_x
    WaveForm_1I((i-1)*60 + 60, :) = [gmSEQ.interval/2+(i-1+47/48)*Cycle gmSEQ.interval/2+(i-1+47/48)*Cycle+gmSEQ.pi gSG.AWGFreq 3*pi/2 gSG.piAWGAmp]; % -pi_y
end
WaveForm_1I(1 + 60*gmSEQ.m, :) = [gmSEQ.m*Cycle gmSEQ.m*Cycle+gmSEQ.pi  gSG.AWGFreq pi 0]; 

WaveForm_1Q = WaveForm_1I - repmat([0 0 0 pi/2 0], size(WaveForm_1I, 1), 1);
WaveForm_1Length = ceil((gmSEQ.m*Cycle+gmSEQ.pi+1000) / (16 / gSG.AWGClockRate)) ...
    *(16 / gSG.AWGClockRate);
WaveForm_1PointNum = WaveForm_1Length * gSG.AWGClockRate;

WaveForm_2I = WaveForm_1I;
WaveForm_2I(size(WaveForm_2I, 1), :) = [gmSEQ.m*Cycle gmSEQ.m*Cycle+gmSEQ.pi gSG.AWGFreq 0 gSG.piAWGAmp]; % Differential measurement
WaveForm_2Q = WaveForm_2I - repmat([0 0 0 pi/2 0], size(WaveForm_2I, 1), 1);
WaveForm_2Length = WaveForm_1Length;
WaveForm_2PointNum = WaveForm_2Length * gSG.AWGClockRate;

chaseFunctionPool('createWaveform', WaveForm_1I, gSG.AWGClockRate, WaveForm_1Length, 'DROID60N_I_seg1.txt'); pause(0.5);
chaseFunctionPool('createWaveform', WaveForm_1Q, gSG.AWGClockRate, WaveForm_1Length, 'DROID60N_Q_seg1.txt'); pause(0.5);
chaseFunctionPool('createWaveform', WaveForm_2I, gSG.AWGClockRate, WaveForm_2Length, 'DROID60N_I_seg2.txt'); pause(0.5);
chaseFunctionPool('createWaveform', WaveForm_2Q, gSG.AWGClockRate, WaveForm_2Length, 'DROID60N_Q_seg2.txt'); pause(0.5);

chaseFunctionPool('createSegStruct', 'DROID60N_SegStruct_I.txt', ...
    'DROID60N_I_seg1.txt', WaveForm_1PointNum, 1, 1, ...
    'DROID60N_I_seg2.txt', WaveForm_2PointNum, 1, 1);
pause(0.5);
chaseFunctionPool('createSegStruct', 'DROID60N_SegStruct_Q.txt', ...
    'DROID60N_Q_seg1.txt', WaveForm_1PointNum, 1, 1, ...
    'DROID60N_Q_seg2.txt', WaveForm_2PointNum, 1, 1);
pause(0.5);

%% Load waveform to AWG
chaseFunctionPool('CreateSegments', gmSEQ.MWAWG, 1, ...
    2, ...
    2047, 2047, 'DROID60N_SegStruct_I.txt', 'false');
pause(1); % this pause seems to be important, otherwise the loading is not right occassionally
chaseFunctionPool('CreateSegments', gmSEQ.MWAWG, 2, ...
    2, ...
    2047, 2047, 'DROID60N_SegStruct_Q.txt', 'false');
pause(1); % this pause seems to be important, otherwise the loading is not right occassionally
%% Run waveform
chaseFunctionPool('runChase', gmSEQ.MWAWG, 'false');
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
        pbn=6;
    case 'AWGTrig2'
        pbn=1;
    case 'AWGTrig' 
        pbn=0;
    case 'dummy1'
        pbn=8;
    case 'AOM'
        pbn=5;
    case 'AWGTrig3' 
        pbn=4;
    case 'MWSwitch'
        pbn=2;
    case 'MWSwitch2'
        pbn=3;
    case 'MWSwitch3'
        pbn=7;
end

function T1
global gmSEQ gSG
gSG.bfixedPow=1;
gSG.bfixedFreq=1;
gSG.bMod='IQ';
gSG.bModSrc='External';

if strcmp(gmSEQ.meas,'APD')
    gmSEQ.CtrGateDur = 1000;
end

WaitTime = 0.1e6; % charge equilibrium
AfterLaser = 1000;
AfterPi = 2000;
Laser_Readout = 5000;

SigD_start = WaitTime+gmSEQ.readout+AfterLaser+gmSEQ.m+gmSEQ.pi+AfterPi+Laser_Readout;
Total_Length = 2*(WaitTime+gmSEQ.readout+AfterLaser+gmSEQ.m+gmSEQ.pi+AfterPi+Laser_Readout);
%%%%% Variable sequence length%%%%%%

gmSEQ.CHN(1).PBN=PBDictionary('ctr0');
gmSEQ.CHN(1).NRise=4;
gmSEQ.CHN(1).T=[WaitTime+gmSEQ.readout-gmSEQ.CtrGateDur-1000 WaitTime+gmSEQ.readout+AfterLaser+gmSEQ.m+gmSEQ.pi+AfterPi...
    SigD_start+WaitTime+gmSEQ.readout-gmSEQ.CtrGateDur-1000 SigD_start+WaitTime+gmSEQ.readout+AfterLaser+gmSEQ.m+gmSEQ.pi+AfterPi];
gmSEQ.CHN(1).DT=[gmSEQ.CtrGateDur gmSEQ.CtrGateDur gmSEQ.CtrGateDur gmSEQ.CtrGateDur];

gmSEQ.CHN(numel(gmSEQ.CHN)+1).PBN=PBDictionary('AOM');
gmSEQ.CHN(numel(gmSEQ.CHN)).NRise=4;
gmSEQ.CHN(numel(gmSEQ.CHN)).T=[WaitTime WaitTime+gmSEQ.readout+AfterLaser+gmSEQ.m+gmSEQ.pi+AfterPi ...
    SigD_start+WaitTime SigD_start+WaitTime+gmSEQ.readout+AfterLaser+gmSEQ.m+gmSEQ.pi+AfterPi];
gmSEQ.CHN(numel(gmSEQ.CHN)).DT=[gmSEQ.readout Laser_Readout gmSEQ.readout Laser_Readout];

gmSEQ.CHN(numel(gmSEQ.CHN)+1).PBN=PBDictionary('MWSwitch');
gmSEQ.CHN(numel(gmSEQ.CHN)).NRise=1;
gmSEQ.CHN(numel(gmSEQ.CHN)).T=[SigD_start+WaitTime+gmSEQ.readout+AfterLaser+gmSEQ.m-20];
gmSEQ.CHN(numel(gmSEQ.CHN)).DT=[gmSEQ.pi+40];

gmSEQ.CHN(numel(gmSEQ.CHN)+1).PBN=PBDictionary('dummy1');
gmSEQ.CHN(numel(gmSEQ.CHN)).NRise=2;
gmSEQ.CHN(numel(gmSEQ.CHN)).T=[0 Total_Length-20];
gmSEQ.CHN(numel(gmSEQ.CHN)).DT=[20 20];

gmSEQ.CHN(numel(gmSEQ.CHN) + 1).PBN = PBDictionary('AWGTrig');
gmSEQ.CHN(numel(gmSEQ.CHN)).NRise = 1;
gmSEQ.CHN(numel(gmSEQ.CHN)).T = SigD_start+WaitTime+gmSEQ.readout+AfterLaser+gmSEQ.m;
gmSEQ.CHN(numel(gmSEQ.CHN)).DT = 200;

% AWG
chaseFunctionPool('stopChase', gmSEQ.MWAWG)

WaveForm_1 = [0, gmSEQ.pi, gSG.AWGFreq, 0, gSG.AWGAmp];
WaveForm_2 = [0, gmSEQ.pi, gSG.AWGFreq, -pi/2, gSG.AWGAmp];
WaveForm_Length = ceil((gmSEQ.pi + 1000) / (16/gSG.AWGClockRate)) * (16/gSG.AWGClockRate);
WaveForm_PointNum = WaveForm_Length*gSG.AWGClockRate;

chaseFunctionPool('createWaveform', WaveForm_1, gSG.AWGClockRate, WaveForm_Length, 'T1_Ch1.txt')
chaseFunctionPool('createWaveform', WaveForm_2, gSG.AWGClockRate, WaveForm_Length, 'T1_Ch2.txt')
chaseFunctionPool('CreateSingleSegment', gmSEQ.MWAWG, 1, ...
WaveForm_PointNum, 1, 2047, 2047, 'T1_Ch1.txt', 1);
pause(1.0);
chaseFunctionPool('CreateSingleSegment', gmSEQ.MWAWG, 2, ...
WaveForm_PointNum, 1, 2047, 2047, 'T1_Ch2.txt', 1);
pause(1.0);
chaseFunctionPool('runChase',  gmSEQ.MWAWG, 'false');

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
gmSEQ.CHN(numel(gmSEQ.CHN)).T=[gmSEQ.readout-1000-gmSEQ.CtrGateDur gmSEQ.readout+delay+gmSEQ.pi+afterPulse];
gmSEQ.CHN(numel(gmSEQ.CHN)).DT=[gmSEQ.CtrGateDur gmSEQ.CtrGateDur];

gmSEQ.CHN(numel(gmSEQ.CHN)+1).PBN=PBDictionary('MWSwitch');
gmSEQ.CHN(numel(gmSEQ.CHN)).NRise=1;
gmSEQ.CHN(numel(gmSEQ.CHN)).T=[gmSEQ.readout+delay-20];
gmSEQ.CHN(numel(gmSEQ.CHN)).DT=[gmSEQ.pi+40];

gmSEQ.CHN(numel(gmSEQ.CHN)+1).PBN=PBDictionary('dummy1');
gmSEQ.CHN(numel(gmSEQ.CHN)).NRise=1;
gmSEQ.CHN(numel(gmSEQ.CHN)).T=0;
gmSEQ.CHN(numel(gmSEQ.CHN)).DT=100;

gmSEQ.CHN(numel(gmSEQ.CHN) + 1).PBN = PBDictionary('AWGTrig');
gmSEQ.CHN(numel(gmSEQ.CHN)).NRise = 1;
gmSEQ.CHN(numel(gmSEQ.CHN)).T = gmSEQ.readout + delay;
gmSEQ.CHN(numel(gmSEQ.CHN)).DT = 200;

% AWG.
% WaveForm_Length = ceil((gmSEQ.m + 1000) * gSG.AWGClockRate / 16) * 16;
WaveForm_Length = ceil((gmSEQ.pi + 1000) / (16/gSG.AWGClockRate)) * (16/gSG.AWGClockRate);
WaveForm_PointNum = WaveForm_Length*gSG.AWGClockRate;

chaseFunctionPool('stopChase', gmSEQ.MWAWG)
if gSG.ACmodAWG % if we use AWG in AC modulation mode.
    WaveForm_1 = [0, gmSEQ.pi, gSG.AWGFreq, 0, gSG.AWGAmp];
    WaveForm_2 = [0, gmSEQ.pi, gSG.AWGFreq, -pi/2, gSG.AWGAmp];
else
    WaveForm_1 = [0, gmSEQ.pi, gSG.AWGAmp];
    WaveForm_2 = [0, gmSEQ.pi, 0];
end

chaseFunctionPool('createWaveform', WaveForm_1, ...
    gSG.AWGClockRate, WaveForm_Length, 'ODMR_Ch1.txt')
chaseFunctionPool('createWaveform', ...
    WaveForm_2, gSG.AWGClockRate, WaveForm_Length, 'ODMR_Ch2.txt')
chaseFunctionPool('CreateSingleSegment', gmSEQ.MWAWG, 1, ...
    WaveForm_PointNum, 1, 2047, 2047, 'ODMR_Ch1.txt', 1); 
pause(1.0);
chaseFunctionPool('CreateSingleSegment', gmSEQ.MWAWG, 2, ...
    WaveForm_PointNum, 1, 2047, 2047, 'ODMR_Ch2.txt', 1);
pause(1.0);
chaseFunctionPool('runChase',  gmSEQ.MWAWG, 'false');

ApplyDelays();

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

function CPMGN % not really CPMGN, just testing
global gmSEQ gSG
gSG.bfixedPow=1;
gSG.bfixedFreq=1;
gSG.bMod='IQ';
gSG.bModSrc='External';

gmSEQ.CHN(1).PBN=PBDictionary('ctr0');
gmSEQ.CHN(1).NRise=3;
gmSEQ.CHN(1).T=[10000 13000 16000];
gmSEQ.CHN(1).DT=[gmSEQ.CtrGateDur gmSEQ.CtrGateDur gmSEQ.CtrGateDur];
gmSEQ.CHN(2).PBN=PBDictionary('AOM');
gmSEQ.CHN(2).NRise=1;
gmSEQ.CHN(2).T=[0];
gmSEQ.CHN(2).DT=[(gmSEQ.readout)*2];
ApplyDelays();

function ApplyAPDGate()
global gmSEQ
if strcmp(gmSEQ.readout,'APD')
    NCHN=numel(gmSEQ.CHN)+1;
    gmSEQ.CHN(NCHN).PBN=PBDictionary('APDGate');
    CHNctr0=0;
    for i=1:numel(gmSEQ.CHN) %find which CHN is ctr0
        if gmSEQ.CHN(i).PBN==PBDictionary('ctr0')
            CHNctr0=i;
            break
        end
    end
    gmSEQ.CHN(NCHN).T=gmSEQ.CHN(CHNctr0).T;
    gmSEQ.CHN(NCHN).DT=gmSEQ.CHN(CHNctr0).DT;
end

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
    buffer = 10;
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

function HalfPi_Cali
global gmSEQ gSG
gSG.bfixedPow = 1;
gSG.bfixedFreq = 1;
gSG.bMod = 'IQ'; 
gSG.bModSrc = 'External';

if strcmp(gmSEQ.meas,'APD') % If PL signal is collected via APD.
    gmSEQ.CtrGateDur = 1000;
end

T_AfterLaser = 2000;
T_AfterPulse = 1000; % 1000 before
N = gmSEQ.CoolCycle; % The number of calibration pulses
T_Cycle = gmSEQ.halfpi + gmSEQ.interval; % Time for a single pulse
Detect_Window = 5000; 
Wait = 1000;
Sig_D_start = gmSEQ.readout + T_AfterLaser + N * T_Cycle + gmSEQ.pi + T_AfterPulse + Detect_Window + Wait;

% TODO: add the definition for the pi and halfpi pulse AWG amp
gSG.piAWGAmp = gmSEQ.SAmp1; % Just for temporary use

% Pulse Blaster
gmSEQ.CHN(1).PBN = PBDictionary('ctr0');
gmSEQ.CHN(1).NRise = 4;
gmSEQ.CHN(1).T = [gmSEQ.readout - gmSEQ.CtrGateDur - 1000, ...
    gmSEQ.readout + T_AfterLaser + N*T_Cycle + gmSEQ.pi + T_AfterPulse, ...
    Sig_D_start + gmSEQ.readout - gmSEQ.CtrGateDur - 1000, ...
    Sig_D_start + gmSEQ.readout + T_AfterLaser + N*T_Cycle + gmSEQ.pi + T_AfterPulse];
gmSEQ.CHN(1).DT = repelem(gmSEQ.CtrGateDur, 4);


bSwitch = false;
gmSEQ.CHN(numel(gmSEQ.CHN) + 1).PBN = PBDictionary('MWSwitch');
if bSwitch
    gmSEQ.CHN(numel(gmSEQ.CHN)).NRise = 2*N+1;
    gmSEQ.CHN(numel(gmSEQ.CHN)).T = zeros(1, 2*N+1);
    for i = 1:N
       gmSEQ.CHN(numel(gmSEQ.CHN)).T(i) = gmSEQ.readout + T_AfterLaser + (i-1) * T_Cycle - 20; 
       gmSEQ.CHN(numel(gmSEQ.CHN)).T(N + i) = Sig_D_start + gmSEQ.readout + T_AfterLaser + (i-1) * T_Cycle - 20; 
    end
    gmSEQ.CHN(numel(gmSEQ.CHN)).T(2*N+1) = Sig_D_start + gmSEQ.readout + T_AfterLaser + N * T_Cycle;
    gmSEQ.CHN(numel(gmSEQ.CHN)).DT = [repelem(gmSEQ.halfpi + 40, 2*N), gmSEQ.pi + 40];
else
    buffer = 200;
    gmSEQ.CHN(numel(gmSEQ.CHN)).NRise = 2;
    gmSEQ.CHN(numel(gmSEQ.CHN)).T = [gmSEQ.readout + T_AfterLaser - buffer, ... 
        Sig_D_start + gmSEQ.readout + T_AfterLaser - buffer; ];
    gmSEQ.CHN(numel(gmSEQ.CHN)).DT = [N * T_Cycle + gmSEQ.pi + 2*buffer, N * T_Cycle + gmSEQ.pi + 2*buffer];
end


gmSEQ.CHN(numel(gmSEQ.CHN) + 1).PBN = PBDictionary('AOM');
gmSEQ.CHN(numel(gmSEQ.CHN)).NRise = 4;
gmSEQ.CHN(numel(gmSEQ.CHN)).T = [0, gmSEQ.readout + T_AfterLaser + N*T_Cycle + gmSEQ.pi + T_AfterPulse, ... 
    Sig_D_start, Sig_D_start + gmSEQ.readout + T_AfterLaser + N*T_Cycle + gmSEQ.pi + T_AfterPulse];
gmSEQ.CHN(numel(gmSEQ.CHN)).DT = [gmSEQ.readout, Detect_Window, gmSEQ.readout, Detect_Window];

gmSEQ.CHN(numel(gmSEQ.CHN) + 1).PBN = PBDictionary('dummy1');
gmSEQ.CHN(numel(gmSEQ.CHN)).NRise = 2;
gmSEQ.CHN(numel(gmSEQ.CHN)).T = [0,  2 * Sig_D_start  - 1000];
gmSEQ.CHN(numel(gmSEQ.CHN)).DT = [1000, 1000];

gmSEQ.CHN(numel(gmSEQ.CHN) + 1).PBN = PBDictionary('AWGTrig');
gmSEQ.CHN(numel(gmSEQ.CHN)).NRise = 2;
gmSEQ.CHN(numel(gmSEQ.CHN)).T = [gmSEQ.readout + T_AfterLaser, Sig_D_start + gmSEQ.readout + T_AfterLaser];
gmSEQ.CHN(numel(gmSEQ.CHN)).DT = [N*T_Cycle + gmSEQ.pi + 200, N*T_Cycle + gmSEQ.pi + 200];

% AWG.
chaseFunctionPool('stopChase', gmSEQ.MWAWG)
if ~gSG.ACmodAWG % if we use AWG in AC modulation mode
    gSG.AWGFreq = 0;
end

WaveForm_1I = zeros(N, 5);
WaveForm_1Q = zeros(N, 5);
for i = 1:N
    WaveForm_1I(i,:) = [(i-1)*T_Cycle, (i-1)*T_Cycle + gmSEQ.halfpi, gSG.AWGFreq, 0, gmSEQ.m];
    WaveForm_1Q(i,:) = [(i-1)*T_Cycle, (i-1)*T_Cycle + gmSEQ.halfpi, gSG.AWGFreq, -pi/2, gmSEQ.m];
end
WaveForm_1Length = ceil((N*T_Cycle + gmSEQ.pi + 1000) / (16/gSG.AWGClockRate)) * (16/gSG.AWGClockRate);
WaveForm_1PointNum = WaveForm_1Length*gSG.AWGClockRate;

WaveForm_2I = [WaveForm_1I; ... 
    N*T_Cycle, N*T_Cycle + gmSEQ.pi, gSG.AWGFreq, 0, gSG.piAWGAmp];
WaveForm_2Q = [WaveForm_1Q; ... 
    N*T_Cycle, N*T_Cycle + gmSEQ.pi, gSG.AWGFreq, -pi/2, gSG.piAWGAmp];
WaveForm_2Length = ceil((N*T_Cycle + gmSEQ.pi + 1000) / (16/gSG.AWGClockRate)) * (16/gSG.AWGClockRate);
WaveForm_2PointNum = WaveForm_2Length*gSG.AWGClockRate;

chaseFunctionPool('createWaveform', WaveForm_1I, gSG.AWGClockRate, WaveForm_1Length, 'HalfPi_Cal_I_seg1.txt'); pause(0.5);
chaseFunctionPool('createWaveform', WaveForm_1Q, gSG.AWGClockRate, WaveForm_1Length, 'HalfPi_Cal_Q_seg1.txt'); pause(0.5);
chaseFunctionPool('createWaveform', WaveForm_2I, gSG.AWGClockRate, WaveForm_2Length, 'HalfPi_Cal_I_seg2.txt'); pause(0.5);
chaseFunctionPool('createWaveform', WaveForm_2Q, gSG.AWGClockRate, WaveForm_2Length, 'HalfPi_Cal_Q_seg2.txt'); pause(0.5);

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

function Composite_Cali % for DROID composite pulse 
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
T_AfterComp = 100;
PulseGap = 4; % Let's play with the pulse gap and see whether it helps or not.

Detect_Window = 5000;
Wait = 1000;
Sig_D_start = gmSEQ.readout + T_AfterLaser + gmSEQ.halfpi + gmSEQ.interval + gmSEQ.pi + PulseGap + T_AfterComp + gmSEQ.pi + T_AfterPulse + Detect_Window + Wait;

% TODO: add the definition for the pi and halfpi pulse AWG amp
gSG.piAWGAmp = gmSEQ.SAmp1; % Just for temporary use
gSG.halfpiAWGAmp = gmSEQ.SAmp2; % Just for temporary use

% Pulse Blaster
gmSEQ.CHN(1).PBN = PBDictionary('ctr0');
gmSEQ.CHN(1).NRise = 4;
gmSEQ.CHN(1).T = [gmSEQ.readout - gmSEQ.CtrGateDur - 1000, ...
    gmSEQ.readout + T_AfterLaser + gmSEQ.halfpi + gmSEQ.interval + gmSEQ.pi + PulseGap + T_AfterComp + gmSEQ.pi + T_AfterPulse, ...
    Sig_D_start + gmSEQ.readout - gmSEQ.CtrGateDur - 1000, ...
    Sig_D_start + gmSEQ.readout + T_AfterLaser + gmSEQ.halfpi + gmSEQ.interval + gmSEQ.pi + PulseGap + T_AfterComp + gmSEQ.pi + T_AfterPulse];
gmSEQ.CHN(1).DT = repelem(gmSEQ.CtrGateDur, 4);


bSwitch = false;
gmSEQ.CHN(numel(gmSEQ.CHN) + 1).PBN = PBDictionary('MWSwitch');
if bSwitch
    error("Composite Cali with switch has not been implemented.");
else
    gmSEQ.CHN(numel(gmSEQ.CHN)).NRise = 2;
    gmSEQ.CHN(numel(gmSEQ.CHN)).T = [gmSEQ.readout + T_AfterLaser - 200, ... 
        Sig_D_start + gmSEQ.readout + T_AfterLaser - 200; ];
    gmSEQ.CHN(numel(gmSEQ.CHN)).DT = [gmSEQ.halfpi + gmSEQ.interval + gmSEQ.pi + PulseGap + T_AfterComp + gmSEQ.pi + 400, ...
        gmSEQ.halfpi + gmSEQ.interval + gmSEQ.pi + PulseGap + T_AfterComp + gmSEQ.pi + 400];
end


gmSEQ.CHN(numel(gmSEQ.CHN) + 1).PBN = PBDictionary('AOM');
gmSEQ.CHN(numel(gmSEQ.CHN)).NRise = 4;
gmSEQ.CHN(numel(gmSEQ.CHN)).T = [0, gmSEQ.readout + T_AfterLaser + gmSEQ.halfpi + gmSEQ.interval + gmSEQ.pi+PulseGap + T_AfterComp + gmSEQ.pi + T_AfterPulse, ... 
    Sig_D_start, Sig_D_start + gmSEQ.readout + T_AfterLaser + gmSEQ.halfpi + gmSEQ.interval + gmSEQ.pi+PulseGap + T_AfterComp + gmSEQ.pi + T_AfterPulse];
gmSEQ.CHN(numel(gmSEQ.CHN)).DT = [gmSEQ.readout, Detect_Window, gmSEQ.readout, Detect_Window];

gmSEQ.CHN(numel(gmSEQ.CHN) + 1).PBN = PBDictionary('dummy1');
gmSEQ.CHN(numel(gmSEQ.CHN)).NRise = 2;
gmSEQ.CHN(numel(gmSEQ.CHN)).T = [0,  2 * Sig_D_start  - 1000];
gmSEQ.CHN(numel(gmSEQ.CHN)).DT = [1000, 1000];

gmSEQ.CHN(numel(gmSEQ.CHN) + 1).PBN = PBDictionary('AWGTrig');
gmSEQ.CHN(numel(gmSEQ.CHN)).NRise = 2;
gmSEQ.CHN(numel(gmSEQ.CHN)).T = [gmSEQ.readout + T_AfterLaser, Sig_D_start + gmSEQ.readout + T_AfterLaser];
gmSEQ.CHN(numel(gmSEQ.CHN)).DT = [gmSEQ.halfpi + gmSEQ.interval + gmSEQ.pi + PulseGap + T_AfterComp + gmSEQ.pi + 200,...
    gmSEQ.halfpi + gmSEQ.interval + gmSEQ.pi+PulseGap + T_AfterComp + gmSEQ.pi + 200];

% AWG.
chaseFunctionPool('stopChase', gmSEQ.MWAWG)
if ~gSG.ACmodAWG % if we use AWG in AC modulation mode
    gSG.AWGFreq = 0;
end

% sensitivity is too low
WaveForm_1I = [0, gmSEQ.halfpi, gSG.AWGFreq, pi, gSG.halfpiAWGAmp; ...
    gmSEQ.halfpi + gmSEQ.interval, gmSEQ.halfpi + gmSEQ.interval + gmSEQ.pi/2, gSG.AWGFreq, 0, gmSEQ.m; ...
    gmSEQ.halfpi + gmSEQ.interval + gmSEQ.pi/2 + PulseGap, gmSEQ.halfpi + gmSEQ.interval + gmSEQ.pi + PulseGap, gSG.AWGFreq, pi/2, gmSEQ.m; ...
    gmSEQ.halfpi+gmSEQ.interval+gmSEQ.pi+PulseGap+T_AfterComp, gmSEQ.halfpi+gmSEQ.interval+gmSEQ.pi+PulseGap+T_AfterComp+gmSEQ.halfpi, gSG.AWGFreq, 0, gSG.halfpiAWGAmp];
WaveForm_1Q = WaveForm_1I - repmat([0 0 0 pi/2 0], size(WaveForm_1I, 1), 1);
WaveForm_1Length = ceil((gmSEQ.halfpi+gmSEQ.interval+gmSEQ.pi+PulseGap+T_AfterComp+gmSEQ.halfpi+1000) / (16/gSG.AWGClockRate)) * (16/gSG.AWGClockRate);
WaveForm_1PointNum = WaveForm_1Length*gSG.AWGClockRate;

WaveForm_2I = WaveForm_1I;
WaveForm_2I(size(WaveForm_1I, 1), 4) = pi; % Differential measurement
WaveForm_2Q = WaveForm_1Q;
WaveForm_2Q(size(WaveForm_1I, 1), 4) = pi/2; % Differential measurement
WaveForm_2Length = WaveForm_1Length;
WaveForm_2PointNum = WaveForm_2Length * gSG.AWGClockRate;

chaseFunctionPool('createWaveform', WaveForm_1I, gSG.AWGClockRate, WaveForm_1Length, 'Composite_Cal_I_seg1.txt'); pause(0.5);
chaseFunctionPool('createWaveform', WaveForm_1Q, gSG.AWGClockRate, WaveForm_1Length, 'Composite_Cal_Q_seg1.txt'); pause(0.5);
chaseFunctionPool('createWaveform', WaveForm_2I, gSG.AWGClockRate, WaveForm_2Length, 'Composite_Cal_I_seg2.txt'); pause(0.5);
chaseFunctionPool('createWaveform', WaveForm_2Q, gSG.AWGClockRate, WaveForm_2Length, 'Composite_Cal_Q_seg2.txt'); pause(0.5);

chaseFunctionPool('createSegStruct', 'Composite_Cal_SegStruct_I.txt', ...
    'Composite_Cal_I_seg1.txt', WaveForm_1PointNum, 1, 1, ...
    'Composite_Cal_I_seg2.txt', WaveForm_2PointNum, 1, 1);
pause(0.5);
chaseFunctionPool('createSegStruct', 'Composite_Cal_SegStruct_Q.txt', ...
    'Composite_Cal_Q_seg1.txt', WaveForm_1PointNum, 1, 1, ...
    'Composite_Cal_Q_seg2.txt', WaveForm_2PointNum, 1, 1);
pause(0.5);

%% Load waveform to AWG
chaseFunctionPool('CreateSegments', gmSEQ.MWAWG, 1, ...
    2, ...
    2047, 2047, 'Composite_Cal_SegStruct_I.txt', 'false');
pause(1); % this pause seems to be important, otherwise the loading is not right occassionally
chaseFunctionPool('CreateSegments', gmSEQ.MWAWG, 2, ...
    2, ...
    2047, 2047, 'Composite_Cal_SegStruct_Q.txt', 'false');
pause(1); % this pause seems to be important, otherwise the loading is not right occassionally
%% Run waveform
chaseFunctionPool('runChase', gmSEQ.MWAWG, 'false');
ApplyDelays();

function Rabi_diff
global gmSEQ gSG
gSG.bfixedPow = 1;
gSG.bfixedFreq = 1;
gSG.bMod = 'IQ'; 
gSG.bModSrc = 'External';

if strcmp(gmSEQ.meas,'APD') % If PL signal is collected via APD.
    gmSEQ.CtrGateDur = 1000;
end

T_AfterLaser = 2000;
T_AfterPulse = 1000; % 1000 before
Detect_Window = 5000; 
Wait = 1000;
Sig_D_start = gmSEQ.readout + T_AfterLaser + gmSEQ.m +gmSEQ.interval + gmSEQ.pi + T_AfterPulse + Detect_Window + Wait;

% TODO: add the definition for the pi and halfpi pulse AWG amp
gSG.piAWGAmp = gmSEQ.SAmp1; % Just for temporary use

% Pulse Blaster
gmSEQ.CHN(1).PBN = PBDictionary('ctr0');
gmSEQ.CHN(1).NRise = 4;
gmSEQ.CHN(1).T = [gmSEQ.readout - gmSEQ.CtrGateDur - 1000, ...
    gmSEQ.readout + T_AfterLaser + gmSEQ.m + gmSEQ.interval + gmSEQ.pi + T_AfterPulse, ...
    Sig_D_start + gmSEQ.readout - gmSEQ.CtrGateDur - 1000, ...
    Sig_D_start + gmSEQ.readout + T_AfterLaser + gmSEQ.m + gmSEQ.interval + gmSEQ.pi + T_AfterPulse];
gmSEQ.CHN(1).DT = repelem(gmSEQ.CtrGateDur, 4);


gmSEQ.CHN(numel(gmSEQ.CHN) + 1).PBN = PBDictionary('MWSwitch');
buffer = 200;
gmSEQ.CHN(numel(gmSEQ.CHN)).NRise = 2;
gmSEQ.CHN(numel(gmSEQ.CHN)).T = [gmSEQ.readout + T_AfterLaser - buffer, ... 
    Sig_D_start + gmSEQ.readout + T_AfterLaser - buffer ];
gmSEQ.CHN(numel(gmSEQ.CHN)).DT = [gmSEQ.m + gmSEQ.interval + gmSEQ.pi + 2*buffer, gmSEQ.m + gmSEQ.interval + gmSEQ.pi + 2*buffer];



gmSEQ.CHN(numel(gmSEQ.CHN) + 1).PBN = PBDictionary('AOM');
gmSEQ.CHN(numel(gmSEQ.CHN)).NRise = 4;
gmSEQ.CHN(numel(gmSEQ.CHN)).T = [0, gmSEQ.readout + T_AfterLaser + gmSEQ.m + gmSEQ.interval + gmSEQ.pi + T_AfterPulse, ... 
    Sig_D_start, Sig_D_start + gmSEQ.readout + T_AfterLaser + gmSEQ.m + gmSEQ.interval + gmSEQ.pi + T_AfterPulse];
gmSEQ.CHN(numel(gmSEQ.CHN)).DT = [gmSEQ.readout, Detect_Window, gmSEQ.readout, Detect_Window];

gmSEQ.CHN(numel(gmSEQ.CHN) + 1).PBN = PBDictionary('dummy1');
gmSEQ.CHN(numel(gmSEQ.CHN)).NRise = 2;
gmSEQ.CHN(numel(gmSEQ.CHN)).T = [0,  2 * Sig_D_start  - 1000];
gmSEQ.CHN(numel(gmSEQ.CHN)).DT = [1000, 1000];

gmSEQ.CHN(numel(gmSEQ.CHN) + 1).PBN = PBDictionary('AWGTrig');
gmSEQ.CHN(numel(gmSEQ.CHN)).NRise = 2;
gmSEQ.CHN(numel(gmSEQ.CHN)).T = [gmSEQ.readout + T_AfterLaser, Sig_D_start + gmSEQ.readout + T_AfterLaser];
gmSEQ.CHN(numel(gmSEQ.CHN)).DT = [gmSEQ.m + gmSEQ.interval + gmSEQ.pi + 200, gmSEQ.m + gmSEQ.interval + gmSEQ.pi + 200];

% AWG.
chaseFunctionPool('stopChase', gmSEQ.MWAWG)
if ~gSG.ACmodAWG % if we use AWG in AC modulation mode
    gSG.AWGFreq = 0;
end

WaveForm_1I = [0, gmSEQ.m, gSG.AWGFreq, 0, gSG.AWGAmp];
WaveForm_1Q = [0, gmSEQ.m, gSG.AWGFreq, -pi/2, gSG.AWGAmp];
WaveForm_1Length = ceil((gmSEQ.m + gmSEQ.interval + gmSEQ.pi + 1000) / (16/gSG.AWGClockRate)) * (16/gSG.AWGClockRate);
WaveForm_1PointNum = WaveForm_1Length*gSG.AWGClockRate;

WaveForm_2I = [WaveForm_1I; ... 
    gmSEQ.m + gmSEQ.interval, gmSEQ.m + gmSEQ.interval + gmSEQ.pi, gSG.AWGFreq, 0, gSG.piAWGAmp];
WaveForm_2Q = [WaveForm_1Q; ... 
    gmSEQ.m + gmSEQ.interval, gmSEQ.m + gmSEQ.interval + gmSEQ.pi, gSG.AWGFreq, -pi/2, gSG.piAWGAmp];
WaveForm_2Length = ceil((gmSEQ.m + gmSEQ.interval + gmSEQ.pi + 1000) / (16/gSG.AWGClockRate)) * (16/gSG.AWGClockRate);
WaveForm_2PointNum = WaveForm_2Length*gSG.AWGClockRate;

chaseFunctionPool('createWaveform', WaveForm_1I, gSG.AWGClockRate, WaveForm_1Length, 'HalfPi_Cal_I_seg1.txt'); pause(0.5);
chaseFunctionPool('createWaveform', WaveForm_1Q, gSG.AWGClockRate, WaveForm_1Length, 'HalfPi_Cal_Q_seg1.txt'); pause(0.5);
chaseFunctionPool('createWaveform', WaveForm_2I, gSG.AWGClockRate, WaveForm_2Length, 'HalfPi_Cal_I_seg2.txt'); pause(0.5);
chaseFunctionPool('createWaveform', WaveForm_2Q, gSG.AWGClockRate, WaveForm_2Length, 'HalfPi_Cal_Q_seg2.txt'); pause(0.5);

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

function Pi_Cali_SG2
global gmSEQ gSG gSG2
gSG.bfixedPow = 1;
gSG.bfixedFreq = 1;
gSG.bMod = 'IQ'; 
gSG.bModSrc = 'External';

gSG2.bMod='IQ';
gSG2.bModSrc='External';
SignalGeneratorFunctionPool2('SetMod');
SignalGeneratorFunctionPool2('WritePow');
SignalGeneratorFunctionPool2('WriteFreq');
gSG2.bOn=1; SignalGeneratorFunctionPool2('RFOnOff');

if strcmp(gmSEQ.meas,'APD') % If PL signal is collected via APD.
    gmSEQ.CtrGateDur = 1000;
end

T_AfterLaser = 2000;
T_AfterPulse = 1000;
N = gmSEQ.CoolCycle; % The number of calibration pulses
T_Cycle = gmSEQ.DEERpi + gmSEQ.interval; % Time for a single pulse

% Pulse Blaster
gmSEQ.CHN(1).PBN = PBDictionary('ctr0');
gmSEQ.CHN(1).NRise = 2;
gmSEQ.CHN(1).T = [gmSEQ.readout - gmSEQ.CtrGateDur - 1000, ...
    gmSEQ.readout + T_AfterLaser + N * T_Cycle + T_AfterPulse];
gmSEQ.CHN(1).DT = [gmSEQ.CtrGateDur, gmSEQ.CtrGateDur];

bSwitch = true;
gmSEQ.CHN(numel(gmSEQ.CHN) + 1).PBN = PBDictionary('MWSwitch2');
if bSwitch
    buffer = 10;
    gmSEQ.CHN(numel(gmSEQ.CHN)).NRise = N;
    gmSEQ.CHN(numel(gmSEQ.CHN)).T = [];
    for i = 0:N-1
       gmSEQ.CHN(numel(gmSEQ.CHN)).T = [gmSEQ.CHN(numel(gmSEQ.CHN)).T, ...
           gmSEQ.readout + T_AfterLaser + i * T_Cycle - buffer]; 
    end
    gmSEQ.CHN(numel(gmSEQ.CHN)).DT = repelem(gmSEQ.DEERpi + 2*buffer, N);
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

gmSEQ.CHN(numel(gmSEQ.CHN) + 1).PBN = PBDictionary('AWGTrig2');
gmSEQ.CHN(numel(gmSEQ.CHN)).NRise = 1;
gmSEQ.CHN(numel(gmSEQ.CHN)).T = gmSEQ.readout + T_AfterLaser;
gmSEQ.CHN(numel(gmSEQ.CHN)).DT =  N * T_Cycle + 200;

% AWG.
chaseFunctionPool('stopChase', gmSEQ.P1AWG)
if ~gSG.ACmodAWG % if we use AWG in AC modulation mode
    gSG2.AWGFreq = 0;
end

WaveForm_I = zeros(N, 5);
WaveForm_Q = zeros(N, 5);
for i = 1:N
    WaveForm_I(i,:) = [(i-1)*T_Cycle, (i-1)*T_Cycle + gmSEQ.DEERpi, gSG2.AWGFreq, 0, gmSEQ.m];
    WaveForm_Q(i,:) = [(i-1)*T_Cycle, (i-1)*T_Cycle + gmSEQ.DEERpi, gSG2.AWGFreq, -pi/2, gmSEQ.m];
end
WaveForm_Length = ceil((N*T_Cycle + 1000) / (16/gSG2.P1AWGClockRate)) * (16/gSG2.P1AWGClockRate);
WaveForm_PointNum = WaveForm_Length*gSG2.P1AWGClockRate;

chaseFunctionPool('createWaveform', WaveForm_I, ...
    gSG2.P1AWGClockRate, WaveForm_Length, 'Pi_Cal_I.txt')
chaseFunctionPool('createWaveform', WaveForm_Q,  ...
    gSG2.P1AWGClockRate, WaveForm_Length, 'Pi_Cal_Q.txt')

chaseFunctionPool('createSegStruct', 'Pi_Cal_SegStruct_I.txt', ...
    'Pi_Cal_I.txt', WaveForm_PointNum, 1, 1);
pause(0.5);
chaseFunctionPool('createSegStruct', 'Pi_Cal_SegStruct_Q.txt', ...
    'Pi_Cal_Q.txt', WaveForm_PointNum, 1, 1);
pause(0.5);
chaseFunctionPool('CreateSegments', gmSEQ.P1AWG, 1, ...
    1, ...
    2047, 2047, 'Pi_Cal_SegStruct_I.txt', 'false');
pause(1); % this pause seems to be important, otherwise the loading is not right occassionally
chaseFunctionPool('CreateSegments', gmSEQ.P1AWG, 2, ...
    1, ...
    2047, 2047, 'Pi_Cal_SegStruct_Q.txt', 'false');
pause(1); % this pause seems to be important, otherwise the loading is not right occassionally

% chaseFunctionPool('CreateSingleSegment', gmSEQ.P1AWG, 1, ...
%     WaveForm_PointNum, 1, 2047, 2047, 'Pi_Cal_I.txt', 1); 
% pause(1.0);
% chaseFunctionPool('CreateSingleSegment', gmSEQ.P1AWG, 2, ...
%     WaveForm_PointNum, 1, 2047, 2047, 'Pi_Cal_Q.txt', 1);
% pause(1.0);

chaseFunctionPool('runChase', gmSEQ.P1AWG, 'false');
ApplyDelays();

function Pi_Cali_SG3
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
gmSEQ.CHN(numel(gmSEQ.CHN) + 1).PBN = PBDictionary('MWSwitch3');
if bSwitch
    buffer = 10;
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

gmSEQ.CHN(numel(gmSEQ.CHN) + 1).PBN = PBDictionary('AWGTrig3');
gmSEQ.CHN(numel(gmSEQ.CHN)).NRise = 1;
gmSEQ.CHN(numel(gmSEQ.CHN)).T = gmSEQ.readout + T_AfterLaser;
gmSEQ.CHN(numel(gmSEQ.CHN)).DT =  N * T_Cycle + 200;

% AWG.
chaseFunctionPool('stopChase', gmSEQ.MWAWG2)
if ~gSG.ACmodAWG % if we use AWG in AC modulation mode
    gSG3.AWGFreq = 0;
end

WaveForm_I = zeros(N, 5);
WaveForm_Q = zeros(N, 5);
for i = 1:N
    WaveForm_I(i,:) = [(i-1)*T_Cycle, (i-1)*T_Cycle + gmSEQ.pi, gSG3.AWGFreq, 0, gmSEQ.m];
    WaveForm_Q(i,:) = [(i-1)*T_Cycle, (i-1)*T_Cycle + gmSEQ.pi, gSG3.AWGFreq, -pi/2, gmSEQ.m];
end
WaveForm_Length = ceil((N*T_Cycle + 1000) / (16/gSG3.AWGClockRate)) * (16/gSG3.AWGClockRate);
WaveForm_PointNum = WaveForm_Length*gSG3.AWGClockRate;

chaseFunctionPool('createWaveform', WaveForm_I, ...
    gSG3.AWGClockRate, WaveForm_Length, 'Pi_Cal_I.txt')
chaseFunctionPool('createWaveform', WaveForm_Q,  ...
    gSG3.AWGClockRate, WaveForm_Length, 'Pi_Cal_Q.txt')

chaseFunctionPool('createSegStruct', 'Pi_Cal_SegStruct_I.txt', ...
    'Pi_Cal_I.txt', WaveForm_PointNum, 1, 1);
pause(0.5);
chaseFunctionPool('createSegStruct', 'Pi_Cal_SegStruct_Q.txt', ...
    'Pi_Cal_Q.txt', WaveForm_PointNum, 1, 1);
pause(0.5);
chaseFunctionPool('CreateSegments', gmSEQ.MWAWG2, 1, ...
    1, ...
    2047, 2047, 'Pi_Cal_SegStruct_I.txt', 'false');
pause(1); % this pause seems to be important, otherwise the loading is not right occassionally
chaseFunctionPool('CreateSegments', gmSEQ.MWAWG2, 2, ...
    1, ...
    2047, 2047, 'Pi_Cal_SegStruct_Q.txt', 'false');
pause(1); % this pause seems to be important, otherwise the loading is not right occassionally

% chaseFunctionPool('CreateSingleSegment', gmSEQ.MWAWG2, 1, ...
%     WaveForm_PointNum, 1, 2047, 2047, 'Pi_Cal_I.txt', 1); 
% pause(1.0);
% chaseFunctionPool('CreateSingleSegment', gmSEQ.MWAWG2, 2, ...
%     WaveForm_PointNum, 1, 2047, 2047, 'Pi_Cal_Q.txt', 1);
% pause(1.0);

chaseFunctionPool('runChase', gmSEQ.MWAWG2, 'false');
ApplyDelays();

function HalfPi_Cali_SG2
global gmSEQ gSG gSG2
gSG.bfixedPow = 1;
gSG.bfixedFreq = 1;
gSG.bMod = 'IQ'; 
gSG.bModSrc = 'External';

SignalGeneratorFunctionPool2('WritePow');
SignalGeneratorFunctionPool2('WriteFreq');
gSG2.bOn=1; SignalGeneratorFunctionPool2('RFOnOff');
if strcmp(gmSEQ.meas,'APD') % If PL signal is collected via APD.
    gmSEQ.CtrGateDur = 1000;
end
gmSEQ.DEERhalfpi = gmSEQ.DEERpi/2;

T_AfterLaser = 2000;
T_AfterPulse = 250;
N = 11; % The number of calibration pulses
T_Cycle = gmSEQ.DEERhalfpi + T_AfterPulse; % Time for a single pulse
Detect_Window = 5000;
Wait = 1000;
Sig_D_start = gmSEQ.readout + T_AfterLaser + N * T_Cycle + gmSEQ.DEERpi + T_AfterPulse + Detect_Window + Wait;

% TODO: add the definition for the pi and halfpi pulse AWG amp
gSG.piAWGAmp = gmSEQ.SAmp1; % Just for temporary use

% Pulse Blaster
gmSEQ.CHN(1).PBN = PBDictionary('ctr0');
gmSEQ.CHN(1).NRise = 4;
gmSEQ.CHN(1).T = [gmSEQ.readout - gmSEQ.CtrGateDur - 1000, ...
    gmSEQ.readout + T_AfterLaser + N*T_Cycle + gmSEQ.DEERpi + T_AfterPulse, ...
    Sig_D_start + gmSEQ.readout - gmSEQ.CtrGateDur - 1000, ...
    Sig_D_start + gmSEQ.readout + T_AfterLaser + N*T_Cycle + gmSEQ.DEERpi + T_AfterPulse];
gmSEQ.CHN(1).DT = repelem(gmSEQ.CtrGateDur, 4);

gmSEQ.CHN(numel(gmSEQ.CHN) + 1).PBN = PBDictionary('MWSwitch2');
gmSEQ.CHN(numel(gmSEQ.CHN)).NRise = 2*N+1;
gmSEQ.CHN(numel(gmSEQ.CHN)).T = zeros(1, 2*N+1);
for i = 1:N
   gmSEQ.CHN(numel(gmSEQ.CHN)).T(i) = gmSEQ.readout + T_AfterLaser + (i-1) * T_Cycle - 20; 
   gmSEQ.CHN(numel(gmSEQ.CHN)).T(N + i) = Sig_D_start + gmSEQ.readout + T_AfterLaser + (i-1) * T_Cycle - 20; 
end
gmSEQ.CHN(numel(gmSEQ.CHN)).T(2*N+1) = Sig_D_start + gmSEQ.readout + T_AfterLaser + N * T_Cycle;
gmSEQ.CHN(numel(gmSEQ.CHN)).DT = [repelem(gmSEQ.DEERhalfpi + 40, 2*N), gmSEQ.DEERpi + 40];


gmSEQ.CHN(numel(gmSEQ.CHN) + 1).PBN = PBDictionary('AOM');
gmSEQ.CHN(numel(gmSEQ.CHN)).NRise = 4;
gmSEQ.CHN(numel(gmSEQ.CHN)).T = [0, gmSEQ.readout + T_AfterLaser + N*T_Cycle + gmSEQ.DEERpi + T_AfterPulse, ... 
    Sig_D_start, Sig_D_start + gmSEQ.readout + T_AfterLaser + N*T_Cycle + gmSEQ.DEERpi + T_AfterPulse];
gmSEQ.CHN(numel(gmSEQ.CHN)).DT = [gmSEQ.readout, Detect_Window, gmSEQ.readout, Detect_Window];

gmSEQ.CHN(numel(gmSEQ.CHN) + 1).PBN = PBDictionary('dummy1');
gmSEQ.CHN(numel(gmSEQ.CHN)).NRise = 2;
gmSEQ.CHN(numel(gmSEQ.CHN)).T = [0, ...
    2 * Sig_D_start  - 1000];
gmSEQ.CHN(numel(gmSEQ.CHN)).DT = [1000, 1000];

gmSEQ.CHN(numel(gmSEQ.CHN) + 1).PBN = PBDictionary('AWGTrig2');
gmSEQ.CHN(numel(gmSEQ.CHN)).NRise = 2;
gmSEQ.CHN(numel(gmSEQ.CHN)).T = [gmSEQ.readout + T_AfterLaser, Sig_D_start + gmSEQ.readout + T_AfterLaser];
gmSEQ.CHN(numel(gmSEQ.CHN)).DT = [1000, 1000];

% AWG.
chaseFunctionPool('stopChase', gmSEQ.MWAWG)
if gSG.ACmodAWG % if we use AWG in AC modulation mode
    gSG2.AWGFreq = gSG2.AWGFreq;
else
    gSG2.AWGFreq = 0;
end

WaveForm_1I = zeros(N, 5);
WaveForm_1Q = zeros(N, 5);
for i = 1:N
    WaveForm_1I(i,:) = [(i-1)*T_Cycle, (i-1)*T_Cycle + gmSEQ.DEERhalfpi, gSG2.AWGFreq, 0, gmSEQ.m];
    WaveForm_1Q(i,:) = [(i-1)*T_Cycle, (i-1)*T_Cycle + gmSEQ.DEERhalfpi, gSG2.AWGFreq, -pi/2, gmSEQ.m];
end
WaveForm_1Length = ceil((N*T_Cycle + 1000) / (16/gSG2.P1AWGClockRate)) * (16/gSG2.P1AWGClockRate);
WaveForm_1PointNum = WaveForm_1Length*gSG2.P1AWGClockRate;

WaveForm_2I = [WaveForm_1I; ... 
    N*T_Cycle, N*T_Cycle + gmSEQ.DEERpi, gSG2.AWGFreq, 0, gSG2.piAWGAmp];
WaveForm_2Q = [WaveForm_1Q; ... 
    N*T_Cycle, N*T_Cycle + gmSEQ.DEERpi, gSG2.AWGFreq, -pi/2, gSG2.piAWGAmp];
WaveForm_2Length = ceil((N*T_Cycle + gmSEQ.DEERpi + 1000) / (16/gSG2.P1AWGClockRate)) * (16/gSG2.P1AWGClockRate);
WaveForm_2PointNum = WaveForm_2Length*gS2G.AWGClockRate;

chaseFunctionPool('createWaveform', WaveForm_1I, gSG2.P1AWGClockRate, WaveForm_1Length, 'HalfPi_Cal_I_seg1.txt'); pause(0.5);
chaseFunctionPool('createWaveform', WaveForm_1Q, gSG2.P1AWGClockRate, WaveForm_1Length, 'HalfPi_Cal_Q_seg1.txt'); pause(0.5);
chaseFunctionPool('createWaveform', WaveForm_2I, gSG2.P1AWGClockRate, WaveForm_2Length, 'HalfPi_Cal_I_seg2.txt'); pause(0.5);
chaseFunctionPool('createWaveform', WaveForm_2Q, gSG2.P1AWGClockRate, WaveForm_2Length, 'HalfPi_Cal_Q_seg2.txt'); pause(0.5);

chaseFunctionPool('createSegStruct', 'HalfPi_Cal_SegStruct_I.txt', ...
    'HalfPi_Cal_I_seg1.txt', WaveForm_1PointNum, 1, 1, ...
    'HalfPi_Cal_I_seg2.txt', WaveForm_2PointNum, 1, 1);
pause(0.5);
chaseFunctionPool('createSegStruct', 'HalfPi_Cal_SegStruct_Q.txt', ...
    'HalfPi_Cal_Q_seg1.txt', WaveForm_1PointNum, 1, 1, ...
    'HalfPi_Cal_Q_seg2.txt', WaveForm_2PointNum, 1, 1);
pause(0.5);

%% Load waveform to AWG
chaseFunctionPool('CreateSegments', gmSEQ.P1AWG, 1, ...
    2, ...
    2047, 2047, 'HalfPi_Cal_SegStruct_I.txt', 'false');
pause(1); % this pause seems to be important, otherwise the loading is not right occassionally
chaseFunctionPool('CreateSegments', gmSEQ.P1AWG, 2, ...
    2, ...
    2047, 2047, 'HalfPi_Cal_SegStruct_Q.txt', 'false');
pause(1); % this pause seems to be important, otherwise the loading is not right occassionally
%% Run waveform
chaseFunctionPool('runChase', gmSEQ.P1AWG, 'false');
ApplyDelays();

function ApplyDelays
global gmSEQ gSG gSG2
% aom_delay = 610; % changed to 610 03/24/2022 RT4 Weijie.
aom_delay = 900; % changed to 820 10/19/2022 RT4 Weijie.

if strcmp(gmSEQ.meas,'APD')
    detector_delay=-1100+610;
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
    elseif gmSEQ.CHN(i).PBN == PBDictionary('AWGTrig') % Yuanqi Lyu, for AWG.
        gmSEQ.CHN(i).Delays = ones(1, 2) * AWG_Delay;
    elseif gmSEQ.CHN(i).PBN == PBDictionary('AWGTrig2') 
        gmSEQ.CHN(i).Delays = ones(1, 2) * AWG_Delay;
    elseif gmSEQ.CHN(i).PBN == PBDictionary('AWGTrig3') 
        gmSEQ.CHN(i).Delays = ones(1, 2) * (AWG_Delay+MW2_Delay);
    elseif gmSEQ.CHN(i).PBN == PBDictionary('MWSwitch3') 
        gmSEQ.CHN(i).Delays = ones(1, 2) * MW2_Delay;
    else
        gmSEQ.CHN(i).Delays=zeros(1,2);
    end
end

function ApplyNoDelays
global gmSEQ
for i=1:numel(gmSEQ.CHN)
    gmSEQ.CHN(i).Delays=zeros(1,max(2,gmSEQ.CHN(i).NRise));
end

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