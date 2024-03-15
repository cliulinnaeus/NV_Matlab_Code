function varargout = ScopeFunctionPool(varargin)
switch varargin{1}
    case 'Init'                            
        [varargout{1}, varargout{2}] = Init(); 
    case 'IDN'
        IDN();
    case 'Start'
        Start();
    case 'Reset'
        Reset();
    case 'Autoscale'
        Autoscale();
    case 'Stop'
        Stop();
    case 'Run'
        Run();
    case 'Single'
        Single();
    case 'SetTimeRange'
        SetTimeRange();
    case 'SetTimePosition'
        SetTimePosition();
    case 'SetVoltageRange'
        SetVoltageRange();
    case 'SetTriggerSource'
        SetTriggerSource();
    case 'SetTriggerCoupling'
        SetTriggerCoupling();
    case 'SetTriggerMode'
        SetTriggerMode();
    case 'SetTriggerLevel'
        SetTriggerLevel();
    case 'ReadWaveform'
        [varargout{1}, varargout{2}] = ReadWaveform();
    case 'GetImage'
        GetImage(varargin{2});
    case 'Check'
        Check();
end

function [status, task] = Init()
% This function initializes the Agilent 54621A to the serial object gSc (a
% global serial). You specify PORT with a string such as 'com3'. It sets
% the baud rate and fcloses the device to prevent the possibility of
% fopening twice.

global gSc;
% Find a serial port object.
gSc.serial = instrfind('Type', 'visa-usb', 'RsrcName', PortMap('Scope_TekDPO2024'), 'Tag', '');

% Create the serial port object if it does not exist
% otherwise use the object that was found.
if isempty(gSc.serial)
    gSc.serial = visa('KEYSIGHT', PortMap('Scope_TekDPO2024'));
else
    fclose(gSc.serial);
    gSc.serial = gSc.serial(1);
end
% Set the timeout value
gSc.serial.Timeout = 5;
% Set the Byte order
gSc.serial.ByteOrder = 'littleEndian';
% gSc.serial.Timeout = 20;
gSc.serial.InputBufferSize = 250000;
gSc.qErr=zeros(1,2);
IDN();

ScopeFunctionPool('Reset');
pause(3) % wait for reset
% ScopeFunctionPool('Check');
% Parameter setting
gSc.TimeRange = 4e-6; % time range should match the length of the sequence
gSc.TimePosition = 0;
gSc.VoltageRange = 0.5;
gSc.TriggerSource = 'CH2';
gSc.TriggerMode = 'Normal';
gSc.TriggerCoupling = 'DC';
gSc.TriggerLevel = 0.02;
fopen(gSc.serial);
fprintf(gSc.serial,'SELect:CH1 OFF'); 
fprintf(gSc.serial,'SELect:CH2 ON'); 
fprintf(gSc.serial,'SELect:CH3 OFF'); 
fprintf(gSc.serial,'SELect:CH4 OFF'); 
% fprintf(gSc.serial,'CH2:PRObe:GAIN 1');
fprintf(gSc.serial,'HORizontal:DELay:MODe OFF');
fprintf(gSc.serial,'ACQ:MOD AVE'); % average mode
% fprintf(gSc.serial,'HORizontal:RECOrdlength 1000000'); 
fclose(gSc.serial);
status = err(gSc.serial);
task = gSc.serial;
ScopeFunctionPool('SetTimeRange');
ScopeFunctionPool('SetTimePosition');
ScopeFunctionPool('SetVoltageRange');
ScopeFunctionPool('SetTriggerSource');
ScopeFunctionPool('SetTriggerMode');
ScopeFunctionPool('SetTriggerCoupling');
ScopeFunctionPool('SetTriggerLevel');
ScopeFunctionPool('Stop');

function IDN()
global gSc
fopen(gSc.serial);
fprintf(gSc.serial,'*IDN?');
A=fscanf(gSc.serial);
if isempty(A)
    warning('Tektronix DPO 2024 is not properly initialized.');
else
    disp(A);
end
fclose(gSc.serial);

function Reset()
global gSc
fopen(gSc.serial);
fprintf(gSc.serial, '*RST');
fclose(gSc.serial);

function Autoscale()
global gSc
fopen(gSc.serial);
fprintf(gSc.serial, 'FPA:PRESS AUTO');
fclose(gSc.serial);

function Stop()
global gSc
fopen(gSc.serial);
fprintf(gSc.serial, 'ACQ:STATE OFF');
fclose(gSc.serial);

function Run()
global gSc
fopen(gSc.serial);
fprintf(gSc.serial, 'ACQ:STATE ON');
fclose(gSc.serial);

function Single()
global gSc
fopen(gSc.serial);
fprintf(gSc.serial, 'FPA:PRESS SING');
fclose(gSc.serial);

function SetTimeRange()
global gSc
fopen(gSc.serial);
fprintf(gSc.serial, char(strcat('HORizontal:SCAle ', {32}, num2str(gSc.TimeRange))));
fclose(gSc.serial);


function SetTimePosition()
global gSc
fopen(gSc.serial);
fprintf(gSc.serial, char(strcat('HORizontal:POSition ', {32}, num2str(gSc.TimePosition))));
fclose(gSc.serial);

function SetVoltageRange()
global gSc
fopen(gSc.serial);
fprintf(gSc.serial, char(strcat('CH2:SCAle ', {32}, num2str(gSc.VoltageRange))));
fclose(gSc.serial);

function SetTriggerSource()
global gSc
fopen(gSc.serial);
switch gSc.TriggerSource
    case 'CH4'
        fprintf(gSc.serial,'TRIGger:A:EDGE:SOUrce CH4');
    case 'CH2'
        fprintf(gSc.serial,'TRIGger:A:EDGE:SOUrce CH2');
end
fclose(gSc.serial);

function SetTriggerMode()
global gSc
fopen(gSc.serial);
switch gSc.TriggerMode
    case 'Normal'
        fprintf(gSc.serial,'TRIGger:A:MODe NORM');
    case 'Auto'
        fprintf(gSc.serial,'TRIGger:A:MODe AUTO');
end
fclose(gSc.serial);

function SetTriggerCoupling()
global gSc
fopen(gSc.serial);
switch gSc.TriggerCoupling
    case 'DC'
        fprintf(gSc.serial,'TRIGger:A:EDGE:COUPling DC');
    case 'HFR'
        fprintf(gSc.serial,'TRIGger:A:EDGE:COUPling HFR');
    case 'LFR'
        fprintf(gSc.serial,'TRIGger:A:EDGE:COUPling LFR');
    case 'NOISE'
        fprintf(gSc.serial,'TRIGger:A:EDGE:COUPling NOISE');
end
fclose(gSc.serial);

function SetTriggerLevel()
global gSc
fopen(gSc.serial);
fprintf(gSc.serial, char(strcat('TRIGger:A:LEVel ', {32}, num2str(gSc.TriggerLevel))));
fclose(gSc.serial);


function [status, waveform] = ReadWaveform()
global gSc
ScopeFunctionPool('Stop');
fopen(gSc.serial);
%% read waveform for main signal from CH2
fprintf(gSc.serial,'DATa:SOUrce CH2'); 
fprintf(gSc.serial,'DATa:ENCdg SRP');
fprintf(gSc.serial,'DATa:COMPosition SINGULAR_YT'); % comment this line if you need average off
fprintf(gSc.serial,'WFMOutpre:BYT_Nr 2');
operationComplete = str2double(query(gSc.serial,'*OPC?'));
while ~operationComplete
    operationComplete = str2double(query(gSc.serial,'*OPC?'));
end

waveform(1).preambleBlock = query(gSc.serial,'WFMOutpre:WFId?');
fprintf(gSc.serial,'CURVe?');
% read back the BINBLOCK with the data in specified format and store it in
% the waveform structure. FREAD removes the extra terminator in the buffer
tic 
waveform(1).RawData = binblockread(gSc.serial,'uint16'); 
toc
fread(gSc.serial,1);

waveform(1).xmult = str2double(query(gSc.serial,'WFMO:XINCR?'));
waveform(1).xzero = str2double(query(gSc.serial,'WFMO:XZERO?'));
waveform(1).yoff = str2double(query(gSc.serial,'WFMO:YOFF?'));
waveform(1).ymult = str2double(query(gSc.serial,'WFMO:YMULT?'));
waveform(1).yzero = str2double(query(gSc.serial,'WFMO:YZERO?'));

waveform(1).xunit = query(gSc.serial,'WFMO:XUNIT?');
waveform(1).yunit = query(gSc.serial,'WFMO:YUNIT?');
% waveform.xunit = replace(waveform.xunit(1:end-1),"""","");
% waveform.yunit = replace(waveform.yunit(1:end-1),"""","");

waveform(1).YData = waveform(1).ymult*(waveform(1).RawData - waveform(1).yoff)+waveform(1).yzero;
waveform(1).XData = waveform(1).xmult*((0:length(waveform(1).RawData)-1))+waveform(1).xzero;

%% read waveform for trigger signal from CH4
% fprintf(gSc.serial,'DATa:SOUrce CH4'); 
% fprintf(gSc.serial,'DATa:ENCdg SRP');
% fprintf(gSc.serial,'WFMOutpre:BYT_Nr 2');
% operationComplete = str2double(query(gSc.serial,'*OPC?'));
% while ~operationComplete
%     operationComplete = str2double(query(gSc.serial,'*OPC?'));
% end
% 
% waveform(2).preambleBlock = query(gSc.serial,'WFMOutpre:WFId?');
% fprintf(gSc.serial,'CURVe?');
% % read back the BINBLOCK with the data in specified format and store it in
% % the waveform structure. FREAD removes the extra terminator in the buffer
% tic 
% waveform(2).RawData = binblockread(gSc.serial,'uint16'); 
% toc
% fread(gSc.serial,1); 
% 
% waveform(2).xmult = str2double(query(gSc.serial,'WFMO:XINCR?'));
% waveform(2).xzero = str2double(query(gSc.serial,'WFMO:XZERO?'));
% waveform(2).yoff = str2double(query(gSc.serial,'WFMO:YOFF?'));
% waveform(2).ymult = str2double(query(gSc.serial,'WFMO:YMULT?'));
% waveform(2).yzero = str2double(query(gSc.serial,'WFMO:YZERO?'));
% 
% waveform(2).xunit = query(gSc.serial,'WFMO:XUNIT?');
% waveform(2).yunit = query(gSc.serial,'WFMO:YUNIT?');
% % waveform.xunit = replace(waveform.xunit(1:end-1),"""","");
% % waveform.yunit = replace(waveform.yunit(1:end-1),"""","");
% 
% waveform(2).YData = waveform(2).ymult*(waveform(2).RawData - waveform(2).yoff)+waveform(2).yzero;
% waveform(2).XData = waveform(2).xmult*((0:length(waveform(2).RawData)-1))+waveform(2).xzero;

fclose(gSc.serial);
status = err(gSc.serial);
% Read back the error queue on the instrument




function GetImage(waveform) % this function should be further modified
%Plot the scaled data.
plot(waveform(1).XData,waveform(1).YData);
hold on;
% plot(waveform(2).XData,waveform(2).YData);
title('Oscilloscope Data');
% set(gca,'XTick',(min(waveform.XData):waveform.SecPerDiv:max(waveform.XData)))
xlabel(['Time (' waveform(1).xunit ')']);
ylabel(['Volts (' waveform(1).yunit ')']);
grid on;
hold off;
% xlabel('Time (s)');
% ylabel('Volts (V)');


function Check()
global gSc
fopen(gSc.serial);
operationComplete = str2double(query(gSc.serial,'*OPC?'));
tic
while ~operationComplete
    operationComplete = str2double(query(gSc.serial,'*OPC?'));
end
toc
fclose(gSc.serial);

%% Helper functions
function instrumentError = err(serial)
fopen(serial);
instrumentError = query(serial, 'EVENT?', '%s\n' ,'%s');
while  ~(isequal(instrumentError, '0') || isequal(instrumentError, '1'))
    disp(['Instrument Error: ' instrumentError]);
end
fclose(serial);


