function SignalGeneratorFunctionPool3(varargin)

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
% This function initializes the SRS SG384 to the serial object gSG3 (a
% global serial). You specify PORT with a string such as 'com4'. It sets
% the baud rate and fcloses the device to prevent the possibility of
% fopening twice.
global gSG3;  

% Find a serial port object.
gSG3.serial = instrfind('Type', 'serial', 'Port', port, 'Tag', '');

% Create the serial port object if it does not exist
% otherwise use the object that was found.
if isempty(gSG3.serial)
    gSG3.serial = serial(port);
else
    fclose(gSG3.serial);
    gSG3.serial = gSG3.serial(1);
end
set(gSG3.serial,'BaudRate',115200);
gSG3.qErr=zeros(1,2);
IDN();

function IDN()
global gSG3
fopen(gSG3.serial);
fprintf(gSG3.serial,'*IDN?');
A=fscanf(gSG3.serial);
if isempty(A)
    warning('SRS384 was not properly initialized.');
else
    disp(A);
end
fclose(gSG3.serial);

function Query()
global gSG3
fopen(gSG3.serial);
try 
	fprintf(gSG3.serial,'AMPR?'); gSG3.qPow = str2double(fscanf(gSG3.serial));
	fprintf(gSG3.serial,'FREQ?'); gSG3.qFreq = str2double(fscanf(gSG3.serial));
	fprintf(gSG3.serial,'ENBR?'); gSG3.qbOn = str2double(fscanf(gSG3.serial));
    fprintf(gSG3.serial,'MODL?');
    if str2double(fscanf(gSG3.serial))
        fprintf(gSG3.serial,'TYPE?');
        switch str2double(fscanf(gSG3.serial))
            case 0
                gSG3.qbMod='AM';
            case 1
                gSG3.qbMod='FM';
            case 2
                gSG3.qbMod='Phase';
            case 3
                gSG3.qbMod='Sweep';
                fprintf(gSG3.serial,'SRAT?'); gSG3.qSweepRate = str2double(fscanf(gSG3.serial));
                fprintf(gSG3.serial,'SDEV?'); gSG3.qSweepDev = str2double(fscanf(gSG3.serial));
                fprintf(gSG3.serial,'SFNC?'); 
                switch str2double(fscanf(gSG3.serial))
                    case 0
                        gSG3.qModSrc = 'Sine';
                    case 1
                        gSG3.qModSrc = 'Ramp';
                    case 2
                        gSG3.qModSrc = 'Triangle';
                    case 5
                        gSG3.qModSrc = 'External';
                end
            case 4
                gSG3.qbMod='Pulse';
            case 5
                gSG3.qbMod='Blank';
            case 6
                gSG3.qbMod='IQ';
                fprintf(gSG3.serial,'QFNC?'); 
                switch str2double(fscanf(gSG3.serial))
                    case 4
                        gSG3.qModSrc = 'Noise';
                    case 5
                        gSG3.qModSrc = 'External';
                end
        end
    else
        gSG3.qbMod='None';
    end
	fprintf(gSG3.serial,'*ESR?'); gSG3.qErr(1) = str2double(fscanf(gSG3.serial));
	fprintf(gSG3.serial,'INSR?'); gSG3.qErr(2) = str2double(fscanf(gSG3.serial));
	fprintf(gSG3.serial,'*CLS');
catch ME
	fclose(gSG3.serial);
	rethrow(ME);
end
fclose(gSG3.serial);

function WritePow()
global gSG3
% disp("Writing power!")
fopen(gSG3.serial);
if gSG3.Pow>10
    fclose(gSG3.serial);
    error('Microwave amplitude is probably too large')
end    
try
	fprintf(gSG3.serial,strcat('AMPR ', num2str(gSG3.Pow))); 
catch ME
	fclose(gSG3.serial);
	rethrow(ME);
end
fclose(gSG3.serial);

function WriteFreq()
global gSG3
fopen(gSG3.serial);

if or(gSG3.Freq<950000,gSG3.Freq>4050000000) % hardware limit of the N-type output
    fclose(gSG3.serial);
    disp(gSG3.Freq)
    error('Microwave frequency is out of bounds');
end
try
    fprintf(gSG3.serial,strcat('FREQ ',num2str(gSG3.Freq))); 
catch ME
	fclose(gSG3.serial);
	rethrow(ME);
end

fclose(gSG3.serial);

function SetMod()
global gSG3
fopen(gSG3.serial);
try
    switch gSG3.bMod
        case 'IQ'
            fprintf(gSG3.serial,'MODL 1');
            fprintf(gSG3.serial,'TYPE 6');
            switch gSG3.bModSrc
                case 'External'
                    fprintf(gSG3.serial,'QFNC 5');
                    fprintf(gSG3.serial,'COUP 1');
                case 'Noise'
                    fprintf(gSG3.serial,'QFNC 4');
                otherwise
                    error('Modulation source is not supported by IQ.')
            end
        case 'Sweep'
            fprintf(gSG3.serial,'TYPE 3');
            fprintf(gSG3.serial,'MODL 1');
            
            switch gSG3.bModSrc
                case 'External'
                    fprintf(gSG3.serial,'SFNC 5');
                    fprintf(gSG3.serial,'COUP 1');
                case 'Sine'
                    fprintf(gSG3.serial,'SFNC 0');
                case 'Ramp'
                    fprintf(gSG3.serial,'SFNC 1');
                case 'Triangle'
                    fprintf(gSG3.serial,'SFNC 2');
                otherwise
                    error('Modulation source is not supported by Sweep.')
            end
            fprintf(gSG3.serial,strcat('SDEV ',num2str(gSG3.sweepDev)));
            fprintf(gSG3.serial,strcat('SRAT ',num2str(gSG3.sweepRate)));
        otherwise
            fprintf(gSG3.serial,'MODL 0');
    end
catch ME
	fclose(gSG3.serial);
	rethrow(ME);
end
fclose(gSG3.serial);


function RFOnOff()
global gSG3
fopen(gSG3.serial);
if (gSG3.Pow>0 && ~strcmp(gSG3.bMod,'IQ')) || (strcmp(gSG3.bMod,'IQ') && strcmp(gSG3.bModSrc,'Noise'))
    fclose(gSG3.serial);
    error('NO ONE MAN SHOULD HAVE ALL THAT POWER')
end
try
	fprintf(gSG3.serial,strcat('ENBR ',num2str(gSG3.bOn)));
catch ME
	fclose(gSG3.serial);
	rethrow(ME);
end
fclose(gSG3.serial);
