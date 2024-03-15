function SignalGeneratorFunctionPool2(varargin)

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
% This function initializes the SRS SG384 to the serial object gSG2 (a
% global serial). You specify PORT with a string such as 'com4'. It sets
% the baud rate and fcloses the device to prevent the possibility of
% fopening twice.
global gSG2;  

% Find a serial port object.
gSG2.serial = instrfind('Type', 'serial', 'Port', port, 'Tag', '');

% Create the serial port object if it does not exist
% otherwise use the object that was found.
if isempty(gSG2.serial)
    gSG2.serial = serial(port);
else
    fclose(gSG2.serial);
    gSG2.serial = gSG2.serial(1);
end
set(gSG2.serial,'BaudRate',115200);
gSG2.qErr=zeros(1,2);
IDN();

function IDN()
global gSG2
fopen(gSG2.serial);
fprintf(gSG2.serial,'*IDN?');
A=fscanf(gSG2.serial);
if isempty(A)
    warning('SRS384 was not properly initialized.');
else
    disp(A);
end
fclose(gSG2.serial);

function Query()
global gSG2
fopen(gSG2.serial);
try 
	fprintf(gSG2.serial,'AMPR?'); gSG2.qPow = str2double(fscanf(gSG2.serial));
	fprintf(gSG2.serial,'FREQ?'); gSG2.qFreq = str2double(fscanf(gSG2.serial));
	fprintf(gSG2.serial,'ENBR?'); gSG2.qbOn = str2double(fscanf(gSG2.serial));
    fprintf(gSG2.serial,'MODL?');
    if str2double(fscanf(gSG2.serial))
        fprintf(gSG2.serial,'TYPE?');
        switch str2double(fscanf(gSG2.serial))
            case 0
                gSG2.qbMod='AM';
            case 1
                gSG2.qbMod='FM';
            case 2
                gSG2.qbMod='Phase';
            case 3
                gSG2.qbMod='Sweep';
                fprintf(gSG2.serial,'SRAT?'); gSG2.qSweepRate = str2double(fscanf(gSG2.serial));
                fprintf(gSG2.serial,'SDEV?'); gSG2.qSweepDev = str2double(fscanf(gSG2.serial));
                fprintf(gSG2.serial,'SFNC?'); 
                switch str2double(fscanf(gSG2.serial))
                    case 0
                        gSG2.qModSrc = 'Sine';
                    case 1
                        gSG2.qModSrc = 'Ramp';
                    case 2
                        gSG2.qModSrc = 'Triangle';
                    case 5
                        gSG2.qModSrc = 'External';
                end
            case 4
                gSG2.qbMod='Pulse';
            case 5
                gSG2.qbMod='Blank';
            case 6
                gSG2.qbMod='IQ';
                fprintf(gSG2.serial,'QFNC?'); 
                switch str2double(fscanf(gSG2.serial))
                    case 4
                        gSG2.qModSrc = 'Noise';
                    case 5
                        gSG2.qModSrc = 'External';
                end
        end
    else
        gSG2.qbMod='None';
    end
	fprintf(gSG2.serial,'*ESR?'); gSG2.qErr(1) = str2double(fscanf(gSG2.serial));
	fprintf(gSG2.serial,'INSR?'); gSG2.qErr(2) = str2double(fscanf(gSG2.serial));
	fprintf(gSG2.serial,'*CLS');
catch ME
	fclose(gSG2.serial);
	rethrow(ME);
end
fclose(gSG2.serial);

function WritePow()
global gSG2
% disp("Writing power!")
fopen(gSG2.serial);
if gSG2.Pow>10
    fclose(gSG2.serial);
    error('Microwave amplitude is probably too large')
end    
try
	fprintf(gSG2.serial,strcat('AMPR ', num2str(gSG2.Pow))); 
catch ME
	fclose(gSG2.serial);
	rethrow(ME);
end
fclose(gSG2.serial);

function WriteFreq()
global gSG2
fopen(gSG2.serial);

if or(gSG2.Freq<950000,gSG2.Freq>4050000000) % hardware limit of the N-type output
    fclose(gSG2.serial);
    disp(gSG2.Freq)
    error('Microwave frequency is out of bounds');
end
try
    fprintf(gSG2.serial,strcat('FREQ ',num2str(gSG2.Freq))); 
catch ME
	fclose(gSG2.serial);
	rethrow(ME);
end

fclose(gSG2.serial);

function SetMod()
global gSG2
fopen(gSG2.serial);
try
    switch gSG2.bMod
        case 'IQ'
            fprintf(gSG2.serial,'MODL 1');
            fprintf(gSG2.serial,'TYPE 6');
            switch gSG2.bModSrc
                case 'External'
                    fprintf(gSG2.serial,'QFNC 5');
                    fprintf(gSG2.serial,'COUP 1');
                case 'Noise'
                    fprintf(gSG2.serial,'QFNC 4');
                otherwise
                    error('Modulation source is not supported by IQ.')
            end
        case 'Sweep'
            fprintf(gSG2.serial,'TYPE 3');
            fprintf(gSG2.serial,'MODL 1');
            
            switch gSG2.bModSrc
                case 'External'
                    fprintf(gSG2.serial,'SFNC 5');
                    fprintf(gSG2.serial,'COUP 1');
                case 'Sine'
                    fprintf(gSG2.serial,'SFNC 0');
                case 'Ramp'
                    fprintf(gSG2.serial,'SFNC 1');
                case 'Triangle'
                    fprintf(gSG2.serial,'SFNC 2');
                otherwise
                    error('Modulation source is not supported by Sweep.')
            end
            fprintf(gSG2.serial,strcat('SDEV ',num2str(gSG2.sweepDev)));
            fprintf(gSG2.serial,strcat('SRAT ',num2str(gSG2.sweepRate)));
        otherwise
            fprintf(gSG2.serial,'MODL 0');
    end
catch ME
	fclose(gSG2.serial);
	rethrow(ME);
end
fclose(gSG2.serial);


function RFOnOff()
global gSG2
fopen(gSG2.serial);
if (gSG2.Pow>0 && ~strcmp(gSG2.bMod,'IQ')) || (strcmp(gSG2.bMod,'IQ') && strcmp(gSG2.bModSrc,'Noise'))
    fclose(gSG2.serial);
    error('NO ONE MAN SHOULD HAVE ALL THAT POWER')
end
try
	fprintf(gSG2.serial,strcat('ENBR ',num2str(gSG2.bOn)));
catch ME
	fclose(gSG2.serial);
	rethrow(ME);
end
fclose(gSG2.serial);
