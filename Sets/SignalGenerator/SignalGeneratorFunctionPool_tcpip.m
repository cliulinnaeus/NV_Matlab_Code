function SignalGeneratorFunctionPool_tcpip(varargin)

switch varargin{1}
    case 'Init'                            
        Init(varargin{2}); 
    case 'InitGUI'
        InitGUI(varargin{2},varargin{3});
    case 'IDN'
        IDN();
    case 'Query'                            
        Query(); 
    case 'WritePow'                            
        WritePow();
    case 'WriteFreq'
        WriteFreq();
    case 'SetMod'
        SetMod();
    case 'RFOnOff'
        RFOnOff();
end

function InitGUI(port, handles)
    Init(port);
    StrL{1}='External';
    StrL{numel(StrL)+1}='Triangle';
    StrL{numel(StrL)+1}='Ramp';
    StrL{numel(StrL)+1}='Sine';
    StrL{numel(StrL)+1}='Noise';
    set(handles.puModSrc,'String',StrL);
    clear StrL
    StrL{1}='None';
    StrL{numel(StrL)+1}='IQ';
    StrL{numel(StrL)+1}='Sweep';
    set(handles.puMod,'String',StrL);
    clear StrL

function Init(port)
% This function initializes the SRS SG384 to the serial object gSG (a
% global serial). You specify PORT with a string such as 'com4'. It sets
% the baud rate and fcloses the device to prevent the possibility of
% fopening twice.
global gSG;  

% Find a serial port object.
gSG.serial = instrfind('Type', 'serial', 'Port', port, 'Tag', '');

% Create the serial port object if it does not exist
% otherwise use the object that was found.
if isempty(gSG.serial)
    gSG.serial = serial(port);
else
    fclose(gSG.serial);
    gSG.serial = gSG.serial(1);
end
set(gSG.serial,'BaudRate',115200);
gSG.qErr=zeros(1,2);
IDN();

function IDN()
global gSG
fopen(gSG.serial);
fprintf(gSG.serial,'*IDN?');
A=fscanf(gSG.serial);
if isempty(A)
    warning('SRS384 was not properly initialized.');
else
    disp(A);
end
fclose(gSG.serial);

function Query()
global gSG
fopen(gSG.serial);
try 
	fprintf(gSG.serial,'AMPR?'); gSG.qPow = str2double(fscanf(gSG.serial));
	fprintf(gSG.serial,'FREQ?'); gSG.qFreq = str2double(fscanf(gSG.serial));
	fprintf(gSG.serial,'ENBR?'); gSG.qbOn = str2double(fscanf(gSG.serial));
    fprintf(gSG.serial,'MODL?');
    if str2double(fscanf(gSG.serial))
        fprintf(gSG.serial,'TYPE?');
        switch str2double(fscanf(gSG.serial))
            case 0
                gSG.qbMod='AM';
            case 1
                gSG.qbMod='FM';
            case 2
                gSG.qbMod='Phase';
            case 3
                gSG.qbMod='Sweep';
                fprintf(gSG.serial,'SRAT?'); gSG.qSweepRate = str2double(fscanf(gSG.serial));
                fprintf(gSG.serial,'SDEV?'); gSG.qSweepDev = str2double(fscanf(gSG.serial));
                fprintf(gSG.serial,'SFNC?'); 
                switch str2double(fscanf(gSG.serial))
                    case 0
                        gSG.qModSrc = 'Sine';
                    case 1
                        gSG.qModSrc = 'Ramp';
                    case 2
                        gSG.qModSrc = 'Triangle';
                    case 5
                        gSG.qModSrc = 'External';
                end
            case 4
                gSG.qbMod='Pulse';
            case 5
                gSG.qbMod='Blank';
            case 6
                gSG.qbMod='IQ';
                fprintf(gSG.serial,'QFNC?'); 
                switch str2double(fscanf(gSG.serial))
                    case 4
                        gSG.qModSrc = 'Noise';
                    case 5
                        gSG.qModSrc = 'External';
                end
        end
    else
        gSG.qbMod='None';
    end
	fprintf(gSG.serial,'*ESR?'); gSG.qErr(1) = str2double(fscanf(gSG.serial));
	fprintf(gSG.serial,'INSR?'); gSG.qErr(2) = str2double(fscanf(gSG.serial));
	fprintf(gSG.serial,'*CLS');
catch ME
	fclose(gSG.serial);
	rethrow(ME);
end
fclose(gSG.serial);

function WritePow()
global gSG
fopen(gSG.serial);
if gSG.Pow>10
    fclose(gSG.serial);
    error('Microwave amplitude is probably too large')
end    
try
	fprintf(gSG.serial,strcat('AMPR ', num2str(gSG.Pow))); 
catch ME
	fclose(gSG.serial);
	rethrow(ME);
end
fclose(gSG.serial);

function WriteFreq()
global gSG
fopen(gSG.serial);

if or(gSG.Freq<950000,gSG.Freq>4050000000) % hardware limit of the N-type output
    fclose(gSG.serial);
    error('Microwave frequency is out of bounds');
end
try
    fprintf(gSG.serial,strcat('FREQ ',num2str(gSG.Freq)));
    % disp(gSG.Freq)
catch ME
	fclose(gSG.serial);
	rethrow(ME);
end

fclose(gSG.serial);

function SetMod()
global gSG
fopen(gSG.serial);
try
    switch gSG.bMod
        case 'IQ'
            fprintf(gSG.serial,'MODL 1');
            fprintf(gSG.serial,'TYPE 6');
            switch gSG.bModSrc
                case 'External'
                    fprintf(gSG.serial,'QFNC 5');
                    fprintf(gSG.serial,'COUP 1');
                case 'Noise'
                    fprintf(gSG.serial,'QFNC 4');
                otherwise
                    error('Modulation source is not supported by IQ.')
            end
        case 'Sweep'
            if ~SweepCheck()
                error('The frequency range is not correct!');
            end
            fprintf(gSG.serial,'TYPE 3');
            fprintf(gSG.serial,'MODL 1');
            
            switch gSG.bModSrc
                case 'External'
                    fprintf(gSG.serial,'SFNC 5');
                    fprintf(gSG.serial,'COUP 1');
                case 'Sine'
                    fprintf(gSG.serial,'SFNC 0');
                case 'Ramp'
                    fprintf(gSG.serial,'SFNC 1');
                case 'Triangle'
                    fprintf(gSG.serial,'SFNC 2');
                otherwise
                    error('Modulation source is not supported by Sweep.')
            end
            fprintf(gSG.serial,strcat('SDEV ',num2str(gSG.sweepDev)));
            fprintf(gSG.serial,strcat('SRAT ',num2str(gSG.sweepRate)));
        otherwise
            fprintf(gSG.serial,'MODL 0');
    end
catch ME
	fclose(gSG.serial);
	rethrow(ME);
end
fclose(gSG.serial);

function bValid = SweepCheck() % Check whether the sweeping range is legal
% The following criteria is only for SRS386. The scaling range of SRS384 is
% different!
global gSG
from = gSG.Freq - gSG.sweepDev;
to = gSG.Freq + gSG.sweepDev; 
bValid = false;
if from >= 1.425e9 && to <= 3.075e9
    bValid = true;
elseif from >= 2.85e9 && to <= 6.15e9
    bValid = true;
end



function RFOnOff()
global gSG
fopen(gSG.serial);
if (gSG.Pow>0 && ~strcmp(gSG.bMod,'IQ')) || (strcmp(gSG.bMod,'IQ') && strcmp(gSG.bModSrc,'Noise'))
    fclose(gSG.serial);
    error('NO ONE MAN SHOULD HAVE ALL THAT POWER')
end
try
	fprintf(gSG.serial,strcat('ENBR ',num2str(gSG.bOn)));
catch ME
	fclose(gSG.serial);
	rethrow(ME);
end
fclose(gSG.serial);
