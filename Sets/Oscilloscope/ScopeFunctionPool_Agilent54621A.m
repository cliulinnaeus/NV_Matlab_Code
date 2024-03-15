function varargout = ScopeFunctionPool(varargin)

switch varargin{1}
    case 'Init'                            
        [varargout{1}, varargout{2}] = Init(); 
    case 'IDN'
        IDN();
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
end

function [status, task] = Init()
% This function initializes the Agilent 54621A to the serial object gSc (a
% global serial). You specify PORT with a string such as 'com3'. It sets
% the baud rate and fcloses the device to prevent the possibility of
% fopening twice.

global gSc;
% Find a serial port object.
gSc.serial = instrfind('Type', 'serial', 'Port', PortMap('Scope_Agilent54621A'), 'Tag', '');

% Create the serial port object if it does not exist
% otherwise use the object that was found.
if isempty(gSc.serial)
    gSc.serial = serial(PortMap('Scope_Agilent54621A'));
else
    fclose(gSc.serial);
    gSc.serial = gSc.serial(1);
end
set(gSc.serial,'BaudRate',57600);
% Set the buffer size
gSc.serial.InputBufferSize = 400000;
% Set the timeout value
gSc.serial.Timeout = 30;
% Set the Byte order
gSc.serial.ByteOrder = 'littleEndian';
% gSc.serial.Timeout = 20;
gSc.qErr=zeros(1,2);
IDN();

ScopeFunctionPool('Reset');
% Parameter setting
gSc.TimeRange = 3e-4;
gSc.TimePosition = 120e-6;
gSc.VoltageRange = 0.6;
gSc.TriggerSource = 'channel1';
gSc.TriggerMode = 'Normal';
gSc.TriggerCoupling = 'AC';
gSc.TriggerLevel = .05;
ScopeFunctionPool('SetTimeRange');
ScopeFunctionPool('SetTimePosition');
ScopeFunctionPool('SetVoltageRange');
ScopeFunctionPool('SetTriggerSource');
ScopeFunctionPool('SetTriggerMode');
ScopeFunctionPool('SetTriggerCoupling');
ScopeFunctionPool('SetTriggerLevel');
status = err(gSc.serial);
task = gSc.serial;

% ScopeFunctionPool('Autoscale');

function IDN()
global gSc
fopen(gSc.serial);
fprintf(gSc.serial,'*IDN?');
A=fscanf(gSc.serial);
if isempty(A)
    warning('Agilent 54621A was not properly initialized.');
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
fprintf(gSc.serial, ':AUToscale');
fclose(gSc.serial);

function Stop()
global gSc
fopen(gSc.serial);
fprintf(gSc.serial, ':STOP');
fclose(gSc.serial);

function Run()
global gSc
fopen(gSc.serial);
fprintf(gSc.serial, ':RUN');
fclose(gSc.serial);

function Single()
global gSc
fopen(gSc.serial);
fprintf(gSc.serial, ':SINGLE');
fclose(gSc.serial);

function SetTimeRange()
global gSc
fopen(gSc.serial);
fprintf(gSc.serial, "TIMEBASE:RANGE  "+num2str(gSc.TimeRange));
fclose(gSc.serial);


function SetTimePosition()
global gSc
fopen(gSc.serial);
fprintf(gSc.serial, "TIMEBASE:POS "+num2str(gSc.TimePosition));
fclose(gSc.serial);

function SetVoltageRange()
global gSc
fopen(gSc.serial);
fprintf(gSc.serial, "CHANNEL1:RANGE  "+num2str(gSc.VoltageRange));
fclose(gSc.serial);

function SetTriggerSource()
global gSc
fopen(gSc.serial);
switch gSc.TriggerSource
    case 'external'
        fprintf(gSc.serial,'TRIGger:EDGE:SOURce EXTernal');
    case 'channel1'
        fprintf(gSc.serial,'TRIGger:EDGE:SOURce CHANnel1');
    case 'channel2'
        fprintf(gSc.serial,'TRIGger:EDGE:SOURce CHANnel2');
end
fclose(gSc.serial);

function SetTriggerMode()
global gSc
fopen(gSc.serial);
switch gSc.TriggerMode
    case 'Normal'
        fprintf(gSc.serial,':TRIGger:SWEep NORM');
    case 'Auto'
        fprintf(gSc.serial,':TRIGger:SWEep AUTO');
    case 'AutoLevel'
        fprintf(gSc.serial,':TRIGger:SWEep AUTL');
end
fclose(gSc.serial);

function SetTriggerCoupling()
global gSc
fopen(gSc.serial);
switch gSc.TriggerCoupling
    case 'AC'
        fprintf(gSc.serial,'TRIGger:EDGE:COUPling AC');
    case 'DC'
        fprintf(gSc.serial,'TRIGger:EDGE:COUPling DC');
    case 'LF'
        fprintf(gSc.serial,'TRIGger:EDGE:COUPling LF');
end
fclose(gSc.serial);

function SetTriggerLevel()
global gSc
fopen(gSc.serial);
fprintf(gSc.serial, "TRIGger:EDGE:LEVel "+num2str(gSc.TriggerLevel));
fclose(gSc.serial);


function [status, waveform] = ReadWaveform()
global gSc
fopen(gSc.serial);
% Specify data from Channel 1
fprintf(gSc.serial,':WAVEFORM:SOURCE CHAN1'); 
% Set timebase to main
fprintf(gSc.serial,':TIMEBASE:MODE MAIN');
% Set up acquisition type and count. 
fprintf(gSc.serial,':ACQUIRE:TYPE NORMAL');
% Specify 10000 points at a time by :WAV:DATA?
% fprintf(gSc.serial,':ACQUIRE:COUNT 1000'); 

fprintf(gSc.serial,':WAV:POINTS MAX');
% Now tell the instrument to digitize channel1
fprintf(gSc.serial,':DIGITIZE CHAN1');
% Wait till complete
operationComplete = str2double(query(gSc.serial,'*OPC?'));
while ~operationComplete
    operationComplete = str2double(query(gSc.serial,'*OPC?'));
end

% Get the data back as a WORD (i.e., INT16), other options are ASCII and BYTE
fprintf(gSc.serial,':WAVEFORM:FORMAT WORD');
% Set the byte order on the instrument as well
fprintf(gSc.serial,':WAVEFORM:BYTEORDER LSBFirst');
% Get the preamble block
waveform.preambleBlock = query(gSc.serial,':WAVEFORM:PREAMBLE?');
% The preamble block contains all of the current WAVEFORM settings.  
% It is returned in the form <preamble_block><NL> where <preamble_block> is:
%    FORMAT        : int16 - 0 = BYTE, 1 = WORD, 2 = ASCII.
%    TYPE          : int16 - 0 = NORMAL, 1 = PEAK DETECT, 2 = AVERAGE
%    POINTS        : int32 - number of data points transferred.
%    COUNT         : int32 - 1 and is always 1.
%    XINCREMENT    : float64 - time difference between data points.
%    XORIGIN       : float64 - always the first data point in memory.
%    XREFERENCE    : int32 - specifies the data point associated with
%                            x-origin.
%    YINCREMENT    : float32 - voltage diff between data points.
%    YORIGIN       : float32 - value is the voltage at center screen.
%    YREFERENCE    : int32 - specifies the data point where y-origin
%                            occurs.
% Now send commmand to read data
fprintf(gSc.serial,':WAV:DATA?');
% read back the BINBLOCK with the data in specified format and store it in
% the waveform structure. FREAD removes the extra terminator in the buffer
tic
waveform.RawData = binblockread(gSc.serial,'uint16'); 
toc
fread(gSc.serial,1);
% Read back the error queue on the instrument
fclose(gSc.serial);
status = err(gSc.serial);

%% Data processing: Post process the data retreived from the scope
% Extract the X, Y data and plot it 

% Maximum value storable in a INT16
maxVal = 2^16; 

%  split the preambleBlock into individual pieces of info
waveform.preambleBlock = regexp(waveform.preambleBlock,',','split');

% store all this information into a waveform structure for later use
waveform.Format = str2double(waveform.preambleBlock{1});     % This should be 1, since we're specifying INT16 output
waveform.Type = str2double(waveform.preambleBlock{2});
waveform.Points = str2double(waveform.preambleBlock{3});
waveform.Count = str2double(waveform.preambleBlock{4});      % This is always 1
waveform.XIncrement = str2double(waveform.preambleBlock{5}); % in seconds
waveform.XOrigin = str2double(waveform.preambleBlock{6});    % in seconds
waveform.XReference = str2double(waveform.preambleBlock{7});
waveform.YIncrement = str2double(waveform.preambleBlock{8}); % V
waveform.YOrigin = str2double(waveform.preambleBlock{9});
waveform.YReference = str2double(waveform.preambleBlock{10});
waveform.VoltsPerDiv = (maxVal * waveform.YIncrement / 8);      % V
waveform.Offset = ((maxVal/2 - waveform.YReference) * waveform.YIncrement + waveform.YOrigin);         % V
waveform.SecPerDiv = waveform.Points * waveform.XIncrement/10 ; % seconds
waveform.Delay = ((waveform.Points/2 - waveform.XReference) * waveform.XIncrement + waveform.XOrigin); % seconds

% Generate X & Y Data
waveform.XData = (waveform.XIncrement.*(1:length(waveform.RawData))) - waveform.XIncrement;
waveform.YData = (waveform.YIncrement.*(waveform.RawData - waveform.YReference)) + waveform.YOrigin; 


function GetImage(waveform) % this function should be further modified
plot(waveform.XData,waveform.YData);
set(gca,'XTick',(min(waveform.XData):waveform.SecPerDiv:max(waveform.XData)))
xlabel('Time (s)');
ylabel('Volts (V)');
title('Oscilloscope Data');
grid on;

%% Helper functions
function instrumentError = err(serial)
fopen(serial);
instrumentError = query(serial,':SYSTEM:ERR?');
while ~isequal(instrumentError,['+0,"No error"' newline])
    disp(['Instrument Error: ' instrumentError]);
    instrumentError = query(serial,':SYSTEM:ERR?');
end
fclose(serial);


