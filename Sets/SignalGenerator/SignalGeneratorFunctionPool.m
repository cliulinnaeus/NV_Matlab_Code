function SignalGeneratorFunctionPool(varargin)

switch varargin{1}
    case 'Init'                            
        Init(); 
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

function Init()
% This function initializes the SRS SG384 to the serial object gSG (a
% global serial). You specify PORT with a string such as 'com4'. It sets
% the baud rate and fcloses the device to prevent the possibility of
% fopening twice.
global gSG;  
% Find a serial port object.
gSG.device = tcpclient(PortMap('SG ip'), 5025);

% Check the connection
IDN();

function IDN()
global gSG
writeline(gSG.device, '*IDN?')
disp(readline(gSG.device)) % Successful connection to the AWG

function Query() % To be upgraded
global gSG
% To be upgraded
% 	writeline(gSG.device,'AMPR?'); gSG.qPow = str2double(fscanf(gSG.device));
% 	writeline(gSG.device,'FREQ?'); gSG.qFreq = str2double(fscanf(gSG.device));
% 	writeline(gSG.device,'ENBR?'); gSG.qbOn = str2double(fscanf(gSG.device));
%     writeline(gSG.device,'MODL?');
%     if str2double(fscanf(gSG.device))
%         writeline(gSG.device,'TYPE?');
%         switch str2double(fscanf(gSG.device))
%             case 0
%                 gSG.qbMod='AM';
%             case 1
%                 gSG.qbMod='FM';
%             case 2
%                 gSG.qbMod='Phase';
%             case 3
%                 gSG.qbMod='Sweep';
%                 writeline(gSG.device,'SRAT?'); gSG.qSweepRate = str2double(fscanf(gSG.device));
%                 writeline(gSG.device,'SDEV?'); gSG.qSweepDev = str2double(fscanf(gSG.device));
%                 writeline(gSG.device,'SFNC?'); 
%                 switch str2double(fscanf(gSG.device))
%                     case 0
%                         gSG.qModSrc = 'Sine';
%                     case 1
%                         gSG.qModSrc = 'Ramp';
%                     case 2
%                         gSG.qModSrc = 'Triangle';
%                     case 5
%                         gSG.qModSrc = 'External';
%                 end
%             case 4
%                 gSG.qbMod='Pulse';
%             case 5
%                 gSG.qbMod='Blank';
%             case 6
%                 gSG.qbMod='IQ';
%                 writeline(gSG.device,'QFNC?'); 
%                 switch str2double(fscanf(gSG.device))
%                     case 4
%                         gSG.qModSrc = 'Noise';
%                     case 5
%                         gSG.qModSrc = 'External';
%                 end
%         end
%     else
%         gSG.qbMod='None';
%     end
% 	writeline(gSG.device,'*ESR?'); gSG.qErr(1) = str2double(fscanf(gSG.device));
% 	writeline(gSG.device,'INSR?'); gSG.qErr(2) = str2double(fscanf(gSG.device));
% 	writeline(gSG.device,'*CLS');


function WritePow()
global gSG
if gSG.Pow>0
    error('Microwave amplitude is probably too large')
end  
writeline(gSG.device, strcat('AMPR ', num2str(gSG.Pow)));


function WriteFreq()
global gSG

if or(gSG.Freq<950000,gSG.Freq>6050000000) % hardware limit of the N-type output
    error('Microwave frequency is out of bounds');
end
writeline(gSG.device, strcat('FREQ ',num2str(gSG.Freq)));


function SetMod()
global gSG
try
    switch gSG.bMod
        case 'IQ'
            writeline(gSG.device,'MODL 1');
            writeline(gSG.device,'TYPE 6');
            switch gSG.bModSrc
                case 'External'
                    writeline(gSG.device,'QFNC 5');
                    writeline(gSG.device,'COUP 1');
                case 'Noise'
                    writeline(gSG.device,'QFNC 4');
                otherwise
                    error('Modulation source is not supported by IQ.')
            end
        case 'Sweep'
            if ~SweepCheck()
                error('The frequency range is not correct!');
            end
            writeline(gSG.device,'TYPE 3');
            writeline(gSG.device,'MODL 1');
            
            switch gSG.bModSrc
                case 'External'
                    writeline(gSG.device,'SFNC 5');
                    writeline(gSG.device,'COUP 1');
                case 'Sine'
                    writeline(gSG.device,'SFNC 0');
                case 'Ramp'
                    writeline(gSG.device,'SFNC 1');
                case 'Triangle'
                    writeline(gSG.device,'SFNC 2');
                otherwise
                    error('Modulation source is not supported by Sweep.')
            end
            writeline(gSG.device,strcat('SDEV ',num2str(gSG.sweepDev)));
            writeline(gSG.device,strcat('SRAT ',num2str(gSG.sweepRate)));
        otherwise
            writeline(gSG.device,'MODL 0');
    end
catch ME
	rethrow(ME);
end

function bValid = SweepCheck() % Check whether the sweeping range is legal
% The following criteria is only for SRS386. The scaling range of SRS384 is
% different!
global gSG
from = gSG.Freq - gSG.sweepDev;
to = gSG.Freq + gSG.sweepDev; 
bValid = false;
% if from >= 1.425e9 && to <= 3.075e9
%     bValid = true;
% elseif from >= 2.85e9 && to <= 6.15e9
%     bValid = true;
% end
if from >= 0.704e9 && to <= 5.9e9
% if from >= 0.020e9 && to <= 2e9
    bValid = true;
end


function RFOnOff()
global gSG

if (gSG.Pow>0 && ~strcmp(gSG.bMod,'IQ')) % || (strcmp(gSG.bMod,'IQ') && strcmp(gSG.bModSrc,'Noise'))
    fclose(gSG.device);
    error('NO ONE MAN SHOULD HAVE ALL THAT POWER')
end
try
	writeline(gSG.device,strcat('ENBR ',num2str(gSG.bOn)));
catch ME
	rethrow(ME);
end
