function varargout = ScopeFunctionPool(varargin)

switch varargin{1}
    case 'Init'                            
        task = Init(); 
    case 'IDN'
        IDN();
    case 'Auto'
        Auto();
    case 'Reset'
        Reset();
    case 'Stop'
        Stop();
    case 'Run'
        Run();
    case 'Single'
        Single();
    case 'SetTimeScale'
        SetTimeScale();
    case 'SetVoltageScale'
        SetVoltageScale();
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
end

function task = Init()
% This function initializes the Agilent 54621A to the serial object gSc (a
% global serial). You specify PORT with a string such as 'com3'. It sets
% the baud rate and fcloses the device to prevent the possibility of
% fopening twice.

global gSc;
% Find a serial port object.
gSc.serial = instrfind('Type', 'visa-usb', 'RsrcName', PortMap('Scope'), 'Tag', '');

% Create the serial port object if it does not exist
% otherwise use the object that was found.
if isempty(gSc.serial)
    gSc.serial = visa('Keysight', PortMap('Scope'));
else
    fclose(gSc.serial);
    gSc.serial = gSc.serial(1);
end
% Set the timeout value
% gSc.serial.Timeout = 15;
% Set the Byte order
% gSc.serial.ByteOrder = 'littleEndian';
% gSc.serial.Timeout = 20;
gSc.serial.InputBufferSize = 2500000;
% gSc.qErr=zeros(1,2);
IDN();

ScopeFunctionPool('Reset');
% Parameter setting
gSc.TimeRange = 1e-7;
gSc.VoltageRange = 0.05;
gSc.TriggerSource = 'CH1';
gSc.TriggerMode = 'Single';
gSc.TriggerCoupling = 'DC';
gSc.TriggerLevel = .01;

ScopeFunctionPool('SetTimeScale');
ScopeFunctionPool('SetVoltageScale');
ScopeFunctionPool('SetTriggerSource');
ScopeFunctionPool('SetTriggerMode');
% ScopeFunctionPool('SetTriggerCoupling');
ScopeFunctionPool('SetTriggerLevel');

fopen(gSc.serial);
% fprintf(gSc.serial,':CHAN1:DISP ON'); 
% fprintf(gSc.serial,':CHAN2:DISP OFF'); 
% fprintf(gSc.serial,':CHAN3:DISP OFF'); 
% fprintf(gSc.serial,':CHAN4:DISP OFF'); 
instrumentError = query(gSc.serial, ':SYSTem:ERRor?', '%s\n' ,'%s');
while  ~(isequal(instrumentError, '0'))
    disp(['Instrument Error: ' instrumentError]);
    instrumentError = query(gSc.serial, ':SYSTem:ERRor?', '%s\n' ,'%s');
end
fclose(gSc.serial);
task = gSc.serial;

function IDN()
global gSc
fopen(gSc.serial);
fprintf(gSc.serial,'*IDN?');
A=fscanf(gSc.serial);
if isempty(A)
    warning('The scope is not properly initialized.');
else
    disp(A);
end
fclose(gSc.serial);

function Auto()
global gSc
fopen(gSc.serial);
fprintf(gSc.serial, ':AUT');
fclose(gSc.serial);

function Reset()
global gSc
fopen(gSc.serial);
fprintf(gSc.serial, '*RST');
fclose(gSc.serial);

function Stop()
global gSc
fopen(gSc.serial);
fprintf(gSc.serial, ':STOP');
fclose(gSc.serial);

function Run()
global gSc
fopen(gSc.serial);
fprintf(gSc.serial, ':START');
fclose(gSc.serial);

function Single()
global gSc
fopen(gSc.serial);
fprintf(gSc.serial, ':SINGle');
fclose(gSc.serial);


function SetTimeScale()
global gSc
fopen(gSc.serial);
fprintf(gSc.serial, ":TIM:SCAL "+num2str(gSc.TimeRange));
fclose(gSc.serial);

function SetVoltageScale()
global gSc
fopen(gSc.serial);
fprintf(gSc.serial, "CHAN1:SCAL  "+num2str(gSc.VoltageRange));
fclose(gSc.serial);

function SetTriggerSource()
global gSc
fopen(gSc.serial);
switch gSc.TriggerSource
    case 'CH1'
        fprintf(gSc.serial,':TRIG:EDGE1:SOUR CHAN1');
    case 'CH2'
        fprintf(gSc.serial,':TRIG:EDGE1:SOUR CHAN2');
end
fclose(gSc.serial);

function SetTriggerMode()
global gSc
fopen(gSc.serial);
switch gSc.TriggerMode
    case 'EDGE'
        fprintf(gSc.serial,':TRIG:MODE EDGE');
end
fclose(gSc.serial);

function SetTriggerCoupling()
global gSc
fopen(gSc.serial);
switch gSc.TriggerCoupling
    case 'DC'
        fprintf(gSc.serial,':TRIG:EDGE:COUP DC');
    case 'AC'
        fprintf(gSc.serial,':TRIG:EDGE:COUP AC');
end
fclose(gSc.serial);

function SetTriggerLevel()
global gSc
fopen(gSc.serial);
fprintf(gSc.serial, ":TRIG:LEV CHAN1, "+num2str(gSc.TriggerLevel));
fclose(gSc.serial);


function [status, waveform] = ReadWaveform()
global gSc
fopen(gSc.serial);
fprintf(gSc.serial,':WAV:BYT LSBF'); % or LSBF 

fprintf(gSc.serial,'WAV:SOUR CHAN1'); 
fprintf(gSc.serial,'WAV:FORM BIN');
fprintf(gSc.serial,'WAV:STR 0');
% fprintf(gSc.serial,'DATa:STARt');
% fprintf(gSc.serial,'DATa:STOP');


waveform.preambleBlock = query(gSc.serial,'WAV:PRE?');

% read back the BINBLOCK with the data in specified format and store it in
% the waveform structure. FREAD removes the extra terminator in the buffer
fprintf(gSc.serial,'WAV:DATA?');
waveform.RawData = binblockread(gSc.serial,'int16'); 
% operationComplete = str2double(query(gSc.serial,'*OPC?'));
% while operationComplete ~= 1
%     disp(operationComplete)
%     operationComplete = str2double(query(gSc.serial,'*OPC?'));
% end

fread(gSc.serial,1);

waveform.xoff = str2double(query(gSc.serial,'WAV:XREF?'));
waveform.xmult = str2double(query(gSc.serial,'WAV:XINC?'));
waveform.xzero = str2double(query(gSc.serial,'WAV:XOR?'));
waveform.yoff = str2double(query(gSc.serial,'WAV:YREF?'));
waveform.ymult = str2double(query(gSc.serial,'WAV:YINC?'));
waveform.yzero = str2double(query(gSc.serial,'WAV:YOR?'));

waveform.xunit = query(gSc.serial,'WAV:XUN?');
waveform.yunit = query(gSc.serial,'WAV:YUN?');
waveform.xunit = replace(waveform.xunit(1:end-1),"""","");
waveform.yunit = replace(waveform.yunit(1:end-1),"""","");

waveform.YData = waveform.ymult*(waveform.RawData - waveform.yoff)+waveform.yzero;
waveform.XData = waveform.xmult*((0:length(waveform.RawData)-1))+waveform.xzero;
fclose(gSc.serial);
% Read back the error queue on the instrument
status = err(gSc.serial);


function GetImage(waveform) % this function should be further modified
%Plot the scaled data.
plot(waveform.XData,waveform.YData);
title('Oscilloscope Data');
% set(gca,'XTick',(min(waveform.XData):waveform.SecPerDiv:max(waveform.XData)))
xlabel(['Time (' waveform.xunit ')']);
ylabel(['Voltage (' waveform.yunit ')']);
grid on;



%% Helper functions
function instrumentError = err(serial)
fopen(serial);
instrumentError = query(serial, ':SYSTem:ERRor?', '%s\n' ,'%s');
while  ~(isequal(instrumentError, '0'))
    disp(['Instrument Error: ' instrumentError]);
    instrumentError = query(serial, ':SYSTem:ERRor?', '%s\n' ,'%s');
end
fclose(serial);


