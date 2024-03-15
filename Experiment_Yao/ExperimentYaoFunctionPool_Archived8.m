function ExperimentYaoFunctionPool(what,hObject, eventdata, handles)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%% Written by Thomas Mittiga, May 2016 %%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%% UC Berkeley, Berkeley , USA  %%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

switch what
    case 'Start'
        StartUp(hObject, eventdata, handles) 
    case 'Rabi' 
        Rabi(hObject, eventdata, handles) 
    case 'RunSeq'
        RunSeq(hObject, eventdata, handles)
        AWG_Measure_User(hObject, eventdata, handles)
    case 'DC_Offsets'
        DC_Offsets(hObject, eventdata, handles)
    case 'Ready_AWG'
        Ready_AWG(hObject, eventdata, handles)
    case 'AOM_Delay'
        AOM_Delay(hObject, eventdata, handles) 
    case 'Update String'
        Update_String(hObject, eventdata, handles) 
    case 'ESR'
        ESR(hObject, eventdata, handles) 
    otherwise
end
end

function StartUp(hObject, eventdata, handles) 

global SentRabi SentDeer SentUser Seq samples len Readout DC_off gSaveData data

% Define Sent to track what has been sent to AWG and assume nothing was 
%sent to the AWG today
SentRabi = 0 ;
SentDeer = 0 ; 
SentUser = 0 ;

% Define Seq to track which sequence is loaded and assume the AWG's current 
%sequence is empty
Seq.Rabi = 0 ;
Seq.Deer = 0 ;
Seq.User = 0 ;

samples = 1000 ;% 1000MHz sample rate of AWG

Readout = 'SPCM';

DC_off.I=-0.002 ;%V
DC_off.Q=0.004 ;%V


%gSaveImg.path = 'Data/Images/'; %Original code commented out
%Begin Edit -Thomas Mittiga 5/23/2016
now = clock;
date = [num2str(now(1)),'-',num2str(now(2)),'-',num2str(round(now(3)))];
fullPath=fullfile('C:\Data\',date,'\');
if ~exist(fullPath,'dir')
    mkdir(fullPath);
end
gSaveData.path = fullPath;
%End edit

gSaveData.file = ['Data_' date '.txt'];
% set(handles.strFileName,'String',gSaveImg.file);

end

function Rabi(hObject, eventdata, handles)

global SentRabi Seq samples len DC_off Rabi data dataParameters

DC=[DC_off.I, DC_off.Q ,0,2.25]; %Offsets of Ch1 2 3 4
Amp=[0.5,0.5,0.05,2,2.2]; %Amp of Ch1 2 3 4, and Markers in V
%Smallest permitted amplitude is 50mV
% 

%Define Rabi Parameters
dataParameters.Rabi.string='MW Length';
dataParameters.Rabi.min=0;
dataParameters.Rabi.max=1000;
dataParameters.Rabi.step=5;
dataParameters.Rabi.vector=(0:5:1000);%%%Make sure MWLength does not force waveforms to be longer than the
%%%input length to Wave_generator
len.Rabi = 10 ; %length of waveform in us

% On the first run, we have to send and load all channels of the Rabi
% sequence

% %%%Begin Infinite Sequence
% MWLength=1000; %ns
% AWG_Measure_Rabi(MWLength);
% Rabi=GenAWGWF(Rabi,samples,len.Rabi);
% Plot_AWG_Sequence(Rabi,handles)
% 
% SentRabi=SendWF2AWG(samples, len.Rabi, Rabi, struct,'Rabi');
% CreateInfiniteSeq('Rabi',DC,Amp)
% OutputAWG(1,1,1,1,0); %Run Sequence (FPGA collects)
% running=2;
% while running==2
%     visa_vendor = 'ni';
%     visa_address = 'TCPIP::136.152.250.165::INSTR';
%     buffer = 2 * 1024;
%     awg = visa(visa_vendor,visa_address);
%     fopen(awg);
%     fprintf(awg, '%s\n','AWGCONTROL:RSTATE?');
%     running=str2num(fscanf(awg,'%s'));
%     fclose(awg);
%     delete(awg);
%     clear awg;
% end
% pause(1) %Make sure output is off
% OutputAWG(0,1,1,1,0); %Turn off all outputs
% %%%End Infinite Sequence


%Initialize Detector
Detector = serial('com10');
Detector.Terminator = 'CR';
Detector.BaudRate = 2000000;
Detector.InputBufferSize = 60000;
Detector.OutputBufferSize = 60000;
fopen(Detector);

ancillaSig=zeros(1,length(dataParameters.Rabi.vector));
ancillaRef=zeros(1,length(dataParameters.Rabi.vector));
data.Rabi.signal=ancillaSig;
data.Rabi.reference=ancillaRef;
i=1;
for MWLength = dataParameters.Rabi.vector
    disp(' ')
    disp('--- Sending Rabi to AWG')
    AWG_Measure_Rabi(MWLength);
    %Rabi=GenAWGWF(Rabi,samples,len.rabi); %Convert to a form AWG accepts
    Rabi=GenAWGWF(Rabi,samples,len.Rabi);
    Plot_AWG_Sequence(Rabi,handles)
    
    SentRabi=SendWF2AWG(samples, len.Rabi, Rabi, struct,'Rabi');
    
    
    disp(' ')
    disp('--- Setting AWG sequence to Rabi')
    CreateSeq(20,50000,1,'Rabi',DC,Amp); %20*50000=10^6 measurements
    %CreateInfiniteSeq('Rabi_Delay',DC,Amp)
    % CreateSUBSeq(subLen,1,1,'Rabi');
    % CreateSeq_from_SUB(20,5000,1,'Rabi',DC,Amp);
    %Mark that Rabi is currently loaded on AWG
    Seq.Rabi = 1 % Redundant with the following function
    Loop_Remaining_Structure({'Rabi'}, Seq,0);
    

    fwrite(Detector, [0;1]); %FPGA in sequence mode
    OutputAWG(1,1,1,1,0); %Run Sequence (FPGA collects)
    running=2; 
    while running==2
        visa_vendor = 'ni';
        visa_address = 'TCPIP::136.152.250.165::INSTR';
        buffer = 2 * 1024;
        awg = visa(visa_vendor,visa_address);
        fopen(awg);
        fprintf(awg, '%s\n','AWGCONTROL:RSTATE?');
        running=str2num(fscanf(awg,'%s'));
        fclose(awg);
        delete(awg);
        clear awg;
    end
    pause(1) %Make sure output is off
    fwrite(Detector, [0;0]); %End sequence mode
    dataTemp = fread(Detector,6) %Read data from FPGA. 
    OutputAWG(0,1,1,1,0); %Turn off all outputs
    if isempty(dataTemp)
        fclose(Detector);
        delete Detector
        clear Detector
        error('No data collected')
    end
    %initialize data vectors
    ancillaSig(i) = dataTemp(1)*65536 + dataTemp(2)*256+dataTemp(3); %Convert Signal data
    ancillaRef(i) = dataTemp(4)*65536 + dataTemp(5)*256+dataTemp(6); %Convert Reference data
    data.Rabi.signal(i)=ancillaSig(i);
    data.Rabi.reference(i)=ancillaRef(i);
    

    i=i+1;
    
end

%Gracefully Disconnect
fclose(Detector);
delete Detector
clear Detector

SaveData('Rabi',hObject, eventdata, handles);
Plot_Data('Rabi',handles)


end

function ESR(hObject, eventdata, handles)

global SentESR Seq samples len DC_off ESR data dataParameters Rabi


% 

%Define Rabi Parameters
dataParameters.ESR.string='MW Frequency';
dataParameters.ESR.min=str2double(handles.ESR_Start.String) ;
dataParameters.ESR.max=str2double(handles.ESR_End.String) ;
dataParameters.ESR.step=str2double(handles.ESR_Step.String) ;
dataParameters.ESR.vector=(dataParameters.ESR.min:dataParameters.ESR.step:dataParameters.ESR.max);
dataParameters.ESR.power=str2double(handles.ESR_Power.String) ;
len.ESR = 10 ; %length of waveform in us

DC=[DC_off.I, DC_off.Q ,0,2.25]; %Offsets of Ch1 2 3 4
Amp=[dataParameters.ESR.power,dataParameters.ESR.power,0.05,2,2.2]; %Amp of Ch1 2 3 4, and Markers in V
%Smallest permitted amplitude is 50mV

% %%%Begin Infinite Sequence
% MWFrequency=1000; %ns
% AWG_Measure_ESR(MWFrequency);
% Rabi=GenAWGWF(ESR,samples,len.ESR);
% Plot_AWG_Sequence(ESR,handles)
% 
% SentRabi=SendWF2AWG(samples, len.ESR, ESR, struct,'ESR');
% CreateInfiniteSeq('ESR',DC,Amp)
% OutputAWG(1,1,1,1,0); %Run Sequence (FPGA collects)
% running=2;
% while running==2
%     visa_vendor = 'ni';
%     visa_address = 'TCPIP::136.152.250.165::INSTR';
%     buffer = 2 * 1024;
%     awg = visa(visa_vendor,visa_address);
%     fopen(awg);
%     fprintf(awg, '%s\n','AWGCONTROL:RSTATE?');
%     running=str2num(fscanf(awg,'%s'));
%     fclose(awg);
%     delete(awg);
%     clear awg;
% end
% pause(1) %Make sure output is off
% OutputAWG(0,1,1,1,0); %Turn off all outputs
% %%%End Infinite Sequence

%Initialize SG and Detector
writeSweepSG('10000EDA', dataParameters.ESR.min, dataParameters.ESR.max, dataParameters.ESR.step, dataParameters.ESR.power, 10)
% Detector = serial('com10');
% Detector.Terminator = 'CR';
% Detector.BaudRate = 2000000;
% Detector.InputBufferSize = 60000;
% Detector.OutputBufferSize = 60000;
% fopen(Detector);

lenSweep=length(dataParameters.ESR.vector);
ancillaSig=zeros(1,lenSweep);
ancillaRef=zeros(1,lenSweep);
data.ESR.signal=ancillaSig;
data.ESR.reference=ancillaRef;

%%%AWG Event PArameters %%%
%Event:JTIMing ASYN %Want SC to trigger event after sequence finished its
%run




disp(' ')
disp('--- Sending ESR to AWG')
%ESR Sequence is simply Rabi sequence with a fixed MW Length
AWG_Measure_ESR(500); %MWLength Set to Pi Pulse
ESR_Handshake;
%ESR=GenAWGWF(ESR,samples,len.ESR); %Convert to a form AWG accepts
ESR=GenAWGWF(ESR,samples,len.ESR);
Plot_AWG_Sequence(ESR,handles)

SentESR=SendWF2AWG(samples, len.ESR, ESR_Handshake, struct,'ESR_Handshake');
SentESR=SendWF2AWG(samples, len.ESR, ESR, struct,'ESR');


disp(' ')
disp('--- Setting AWG sequence to ESR')
CreateSeq(20,50000,1,'ESR_Handshake',DC,Amp); %Add handshake sequence before ESR sequence
CreateSeq(20,50000,3,'ESR',DC,Amp); %20*50000=10^6 measurements
%We want to repeat the Rabi sequence using GoTo
visa_vendor = 'ni';
visa_address = 'TCPIP::136.152.250.165::INSTR';
buffer = 2 * 1024;
awg = visa(visa_vendor,visa_address);
fopen(awg);
fwrite(awg,['SEQ:ELEM' num2str(20) ':GOTO:STAT 1']); %% Turns off the ability of the GoTo:Index to take effect for this element
fwrite(awg,['SEQ:ELEM' num2str(20) ':GOTO:IND 1']);
fwrite(awg,['SEQ:ELEM1:TWAIT 1']);
fclose(awg);
delete(awg);
clear awg;
%CreateInfiniteSeq('ESR_Delay',DC,Amp)
% CreateSUBSeq(subLen,1,1,'ESR');
% CreateSeq_from_SUB(20,5000,1,'ESR',DC,Amp);
%Mark that ESR is currently loaded on AWG
% Seq.ESR = 1 % Redundant with the following function
% Loop_Remaining_Structure({'ESR'}, Seq,0);


fwrite(Detector, [0;1]); %FPGA in sequence mode
OutputAWG(1,1,1,1,0); %Run Sequence (FPGA collects)
running=2;
posCount=0;
visa_vendor = 'ni';
visa_address = 'TCPIP::136.152.250.165::INSTR';
buffer = 2 * 1024;
awg = visa(visa_vendor,visa_address);
fopen(awg);
fwrite(awg,['*TRG']);
 %% Turns off the ability of the GoTo:Index to take effect for this element
%Probably not the most elegant method. To ensure hand-shaking between AWG,
%FPGA, and SignalCore, AWG uses GoTo on the last element to return to the
%first, then waits for the SignalCore to trigger stepping to element 2.
%The FPGA triggers subsequent steps. However, this means that when the
%measurement is finished, the AWG is left at element 1 waiting for the
%SignalCore to trigger it.
while posCount<=lenSweep 
    fprintf(awg, '%s\n','AWGCONTROL:RSTATE?');
    running=str2num(fscanf(awg,'%s'));
    fprintf(awg, '%s\n','AWGC:SEQ:POS?');
    pos=str2num(fscanf(awg,'%s'));
    if running==1&&pos==1
        posCount=posCount+1;
    end
    if running==0
        'Possible Error? Sequence terminated'
        break
    end
end
fclose(awg);
delete(awg);
clear awg;
pause(1) %Make sure output is off
fwrite(Detector, [0;0]); %End sequence mode
dataTemp = fread(Detector,6) %Read data from FPGA.
OutputAWG(0,1,1,1,0); %Turn off all outputs
if isempty(dataTemp)
    fclose(Detector);
    delete Detector
    clear Detector
    error('No data collected')
end
% %initialize data vectors
% ancillaSig(i) = dataTemp(1)*65536 + dataTemp(2)*256+dataTemp(3); %Convert Signal data
% ancillaRef(i) = dataTemp(4)*65536 + dataTemp(5)*256+dataTemp(6); %Convert Reference data
% data.ESR.signal(i)=ancillaSig(i);
% data.ESR.reference(i)=ancillaRef(i);


%Gracefully Disconnect
fclose(Detector);
delete Detector
clear Detector

SaveData('ESR',hObject, eventdata, handles);
Plot_Data('ESR',handles)


end

function RunSeq(hObject, eventdata, handles)

global SentRabi Seq samples len DC_off Rabi data dataParameters

pulses={'P1' 'P2'}; %Currently only offering 2 pulses

DC=[DC_off.I, DC_off.Q ,0,2.25]; %Offsets of Ch1 2 3 4
Amp=[0.8,0.4,0.05,2,2.2]; %Amp of Ch1 2 3 4, and Markers in V
%Smallest permitted amplitude is 50mV

%Get parameters from user inputs
for str = pulses
    if ~handles.(char(strcat(str,'_On'))).Value 
        continue %Skip if radio button is off
    end
    
    dataParameters.Pulses.(char(str)).Initial_Width=str2double(handles.(char(strcat(str,'_Initial_Width'))).String);
    dataParameters.Pulses.(char(str)).Initial_Amp=str2double(handles.(char(strcat(str,'_Initial_Amp'))).String);
    dataParameters.Pulses.(char(str)).Initial_Time=str2double(handles.(char(strcat(str,'_Initial_Time'))).String);
    dataParameters.Pulses.(char(str)).Offset=str2double(handles.(char(strcat(str,'_Offset'))).String);
    dataParameters.Pulses.(char(str)).channel=handles.(char(strcat(str,'_Channel'))).String{handles.(char(strcat(str,'_Channel'))).Value};
    dataParameters.Pulses.(char(str)).string=handles.(char(strcat(str,'_Sweep'))).String{handles.(char(strcat(str,'_Sweep'))).Value};
    dataParameters.Pulses.(char(str)).Modmin=str2double(handles.(char(dataParameters.Pulses.(char(str)).string)).String);
    dataParameters.Pulses.(char(str)).Modmax=str2double(handles.(char(strcat(str,'_Final_Mod_Value'))).String);
    dataParameters.Pulses.(char(str)).Modstep=str2double(handles.(char(strcat(str,'_Modulation_Step'))).String);
    dataParameters.Pulses.(char(str)).vector=(dataParameters.Pulses.(char(str)).Modmin:dataParameters.Pulses.(char(str)).Modstep:dataParameters.Pulses.(char(str)).Modmax);%%%Make sure MWLength does not force waveforms to be longer than the
    dataParameters.Pulses.(char(str)).offset=str2num(handles.(char(strcat(str,'_Offset'))).String);
    %%%input length to Wave_generator
    

end

len.Pulses = str2double(handles.Pulse_Length.String) ; %length of waveform in us

% On the first run, we have to send and load all channels of the Rabi
% sequence

%Initialize Detector
detect=handles.Detect.Value
if detect
    Detector = serial('com10');
    Detector.Terminator = 'CR';
    Detector.BaudRate = 2000000;
    Detector.InputBufferSize = 60000;
    Detector.OutputBufferSize = 60000;
    fopen(Detector);
    ancillaSig=zeros(1,length(dataParameters.Rabi.vector));
    ancillaRef=zeros(1,length(dataParameters.Rabi.vector));
    data.Rabi.signal=ancillaSig;
    data.Rabi.reference=ancillaRef;
end


i=1;
for j = 1:length(dataParameters.Pulses.P1.vector)
    disp(' ')
    disp('--- Sending Pulses to AWG')
    AWG_Measure_User(j);
    %Rabi=GenAWGWF(Rabi,samples,len.rabi); %Convert to a form AWG accepts
    Rabi=GenUserWF(Rabi,samples,len.Rabi);
    Plot_AWG_Sequence(Rabi,handles)
    
    SentRabi=SendWF2AWG(samples, len.Rabi, Rabi, struct,'Rabi');
    
    
    disp(' ')
    disp('--- Setting AWG sequence to Rabi')
    CreateSeq(20,50000,1,'Rabi',DC,Amp); %20*50000=10^6 measurements
    %CreateInfiniteSeq('Rabi_Delay',DC,Amp)
    % CreateSUBSeq(subLen,1,1,'Rabi');
    % CreateSeq_from_SUB(20,5000,1,'Rabi',DC,Amp);
    %Mark that Rabi is currently loaded on AWG
    Seq.Rabi = 1 % Redundant with the following function
    Loop_Remaining_Structure({'Rabi'}, Seq,0);
    

    fwrite(Detector, [0;1]); %FPGA in sequence mode
    OutputAWG(1,1,1,1,0); %Run Sequence (FPGA collects)
    running=2; 
    while running==2
        visa_vendor = 'ni';
        visa_address = 'TCPIP::136.152.250.165::INSTR';
        buffer = 2 * 1024;
        awg = visa(visa_vendor,visa_address);
        fopen(awg);
        fprintf(awg, '%s\n','AWGCONTROL:RSTATE?');
        running=str2num(fscanf(awg,'%s'));
        fclose(awg);
        delete(awg);
        clear awg;
    end
    pause(1) %Make sure output is off
    fwrite(Detector, [0;0]); %End sequence mode
    dataTemp = fread(Detector,6) %Read data from FPGA. 
    OutputAWG(0,1,1,1,0); %Turn off all outputs
    if isempty(dataTemp)
        fclose(Detector);
        delete Detector
        clear Detector
        error('No data collected')
    end
    %initialize data vectors
    ancillaSig(i) = dataTemp(1)*65536 + dataTemp(2)*256+dataTemp(3); %Convert Signal data
    ancillaRef(i) = dataTemp(4)*65536 + dataTemp(5)*256+dataTemp(6); %Convert Reference data
    data.Rabi.signal(i)=ancillaSig(i);
    data.Rabi.reference(i)=ancillaRef(i);
    

    i=i+1;
    
end

%Gracefully Disconnect
fclose(Detector);
delete Detector
clear Detector

SaveData('Rabi',hObject, eventdata, handles);
Plot_Data('Rabi',handles)

end

function AOM_Delay(hObject, eventdata, handles)

global SentAOM Seq samples len DC_off AOM_Delay data dataParameters

DC=[DC_off.I DC_off.Q,0,0]; %Offsets of Ch1 2 3 4
Amp=[0.5,0.5,2.2,0.05,2.2]; %Amp of Ch1 2 3 4 in V
%Smallest permitted Amplitude is 50mW

%Define AOM Delay Parameters
dataParameters.AOM_Delay.string='SPCM Signal TTL Timing';
dataParameters.AOM_Delay.min=0;
dataParameters.AOM_Delay.max=5000;
dataParameters.AOM_Delay.step=10;
dataParameters.AOM_Delay.vector= (0:10:4090);
len.AOM_Delay = 5 ; %length of waveform in us

%%%Inifinite Sequence Begin
% MWLength=1000;
% AWG_Measure_AOM_Delay(MWLength);
% AOM_Delay=GenAWGWF(AOM_Delay,samples,len.AOM_Delay);
% Plot_AWG_Sequence(AOM_Delay,handles)
% 
% SentAOM=SendWF2AWG(samples, len.AOM_Delay, AOM_Delay, struct,'AOM_Delay');
% CreateInfiniteSeq('AOM_Delay',DC,Amp)
% OutputAWG(1,1,1,1,0); %Run Sequence (FPGA collects)
% running=2;
% while running==2
%     visa_vendor = 'ni';
%     visa_address = 'TCPIP::136.152.250.165::INSTR';
%     buffer = 2 * 1024;
%     awg = visa(visa_vendor,visa_address);
%     fopen(awg);
%     fprintf(awg, '%s\n','AWGCONTROL:RSTATE?');
%     running=str2num(fscanf(awg,'%s'));
%     fclose(awg);
%     delete(awg);
%     clear awg;
% end
% pause(1) %Make sure output is off
% OutputAWG(0,1,1,1,0); %Turn off all outputs
%%%Infinite Sequence End

% Initialize Detector
% Detector = serial('com10');
% Detector.Terminator = 'CR';
% Detector.BaudRate = 2000000;
% Detector.InputBufferSize = 60000;
% Detector.OutputBufferSize = 60000;
% fclose(Detector); % I put this in so I stop breaking Matlab --Satcher
% fopen(Detector);

ancillaSig=zeros(1,length(dataParameters.AOM_Delay.vector));
ancillaRef=zeros(1,length(dataParameters.AOM_Delay.vector));
data.AOM_Delay.signal=ancillaSig;
data.AOM_Delay.reference=ancillaRef;
i=1;
for SigTTL = dataParameters.AOM_Delay.vector
    disp(' ')
    disp('--- Sending AOM_Delay to AWG')
    AWG_Measure_AOM_Delay(SigTTL);
    %Rabi=GenAWGWF(Rabi,samples,len.rabi); %Convert to a form AWG accepts
    AOM_Delay=GenAWGWF(AOM_Delay,samples,len.AOM_Delay);
    Plot_AWG_Sequence(AOM_Delay,handles)
    
    SentAOM=SendWF2AWG(samples, len.AOM_Delay, AOM_Delay, struct,'AOM_Delay');
    
    
    disp(' ')
    disp('--- Setting AWG sequence to AOM_Delay')
    CreateSeq(20,50000,1,'AOM_Delay',DC,Amp); %I changed the first number to 1000 from 200 but idk what I'm doing --Satcher
    %CreateInfiniteSeq('AOM_Delay',DC,Amp)
    % CreateSUBSeq(subLen,1,1,'Rabi');
    % CreateSeq_from_SUB(20,5000,1,'Rabi',DC,Amp);
    %Mark that Rabi is currently loaded on AWG
    Seq.AOM_Delay = 1 % Redundant with the following function
    Loop_Remaining_Structure({'AOM_Delay'}, Seq,0);
    

    fwrite(Detector, [0;1]); %FPGA in sequence mode
    OutputAWG(1,1,1,1,0); %Run Sequence (FPGA collects)
    running=2; 
    while running==2
        visa_vendor = 'ni';
        visa_address = 'TCPIP::136.152.250.165::INSTR';
        buffer = 2 * 1024;
        awg = visa(visa_vendor,visa_address);
        fopen(awg);
        fprintf(awg, '%s\n','AWGCONTROL:RSTATE?');
        running=str2num(fscanf(awg,'%s'));
        fclose(awg);
        delete(awg);
        clear awg;
    end
    pause(1) %Make sure output is off
    fwrite(Detector, [0;0]); %End sequence mode
    dataTemp = fread(Detector,6) %Read data from FPGA. 
    OutputAWG(0,1,1,1,0); %Turn off all outputs
    if isempty(dataTemp)
        fclose(Detector);
        delete Detector
        clear Detector
        error('No data collected')
    end
    %initialize data vectors
    ancillaSig(i) = dataTemp(1)*65536 + dataTemp(2)*256+dataTemp(3); %Convert Signal data
    ancillaRef(i) = dataTemp(4)*65536 + dataTemp(5)*256+dataTemp(6); %Convert Reference data
    data.AOM_Delay.signal(i)=ancillaSig(i);
    data.AOM_Delay.reference(i)=ancillaRef(i);
    

    i=i+1;
    
end

%Gracefully Disconnect
fclose(Detector);
delete Detector
clear Detector

SaveData('AOM_Delay',hObject, eventdata, handles);
Plot_Data('AOM_Delay',handles)


end

function NewStruct=Loop_Remaining_Structure(unchanged_fieldnames, structure, val)
%Takes a cell of structure elements as an input, and sets all other 
%elements of that structure to val

%Rather than learn matlab, I'm just gonna store the original value in a
%temporary variable

if ~isempty(unchanged_fieldnames)
    i=0;
    for str=unchanged_fieldnames
        i=i+1;
        temp(i) = structure.(char(str));
    end
end

fn = fieldnames(structure);

%Set all elements of structure to specified value
for str = fn'
    structure.(char(str)) = val;
end

%Set unchanged elements of structure back to original value
if ~isempty(unchanged_fieldnames)
    i=0;
    for str=unchanged_fieldnames
        i=i+1;
        structure.(char(str)) = temp(i);
    end
end
NewStruct=structure;


end

% Stored Rabi Sequence before Wave_Generator processing
function AWG_Measure_Rabi(MWLength) 

global Readout Rabi
clear global Rabi
global Rabi
% t2pi=24;
% tpi2=12;
   %Inputs to Wave_generator must be written in the form
   % For Analog
   %[t1,t2,freq1,phase1,amp1;...
   % t3,t4,freq2,phase2,amp2;...
   %...]
   %
   % For Digital
   %[t1,t2,value1;...
   %t3,t4,value2;...
   %...]

   %%% README: These are inputs for waveFORMS. Waveforms are normalized and
   %%% have no offset. If you want to add an offset or amplitude, you must do it with
   %%% CreateSeq
   
   %%% 10% duty cycle for a 10us sequence is 1us
   
   %%% Delays are not applied in this sequence
% Rabi.Ch1=[0,500,10,0,1] ;
% Rabi.Mk1=[0,500,1];
% Rabi.Mk2=[0,500,1];
%%%%%% Mixer control: I %%%%%% 
Rabi.Ch1 = [3050,3050+MWLength,0,pi/2,1]; 
%%%Make sure MWLength does not force this waveform to be longer than the
%%%input length to Wave_generator
        % Wait for Laser to polarize and 50ns
         %Apply MW
%Wave_generator creates sine, so need pi/2 when DC
%Switch is ~3ns before I and Q
%I and Q turn off 3ns before switch


%%%%%% Mixer control: Q %%%%%% 
Rabi.Ch2 = [0,0,0];%[3050,3050+MWLength,0,pi/2,1]; 
%%%Make sure MWLength does not force this waveform to be longer than the
%%%input length to Wave_generator
        % Wait for Laser to polarize and 50ns
         %Apply MW
         
%%%%%% Switch %%%%%% 
Rabi.Mk1 = [3050,3055+MWLength,1]; 
%%%Make sure MWLength does not force this waveform to be longer than the
%%%input length to Wave_generator
     % Wait for Laser to polarize and turn off
     %turn on and off
%Switch TTL pulse is 5ns longer

%%%%%% Laser %%%%%% 
Rabi.Mk2 = [0,3000,1;... %Polarize for 3us
    3001,4101,0;... %wait for: 50ns, max MW duration, 50ns
    4102,7102,1];  %detection for 3us

%%%%%% FPGA Signal %%%%%% 
Rabi.Mk3 = [3050,3350,1]; 
% Rabi.Mk3 = [4102,4402,1]; 
%300ns detection window when laser turns on

%%%%%% FPGA Reference %%%%%% 
Rabi.Mk4 = [3050,3350,1];
% Rabi.Mk4 = [6802,7102,1];
%300ns detection window for last 300ns of laser detection pulse

%%%%%% Trigger %%%%%% 
Rabi.Mk5 = [0,500,1];  %Trigger for observation on Oscope 
Rabi.Mk6 = [0,10000,0];  %Markers must come in pairs
% Must specify Analog channel is 0 for purely digital outputs
Rabi.Ch3 = [0,0,0,0,0]; 

%%%%%% Unused %%%%%
% Rabi.Ch4 = [0,10000,0,pi/2,1]; 
% Rabi.Mk7 = [0,0,0];  
% Rabi.Mk8 = [0,0,0];  
  
%adjust for readout and MW delay

Rabi = delays(Readout, Rabi)
% Rabi = delays('None', Rabi);
disp('Rabi defined and delayed')

end 

function AWG_Measure_ESR(MWLength) 

global Readout ESR
clear global ESR
global ESR
% t2pi=24;
% tpi2=12;
   %Inputs to Wave_generator must be written in the form
   % For Analog
   %[t1,t2,freq1,phase1,amp1;...
   % t3,t4,freq2,phase2,amp2;...
   %...]
   %
   % For Digital
   %[t1,t2,value1;...
   %t3,t4,value2;...
   %...]

   %%% README: These are inputs for waveFORMS. Waveforms are normalized and
   %%% have no offset. If you want to add an offset or amplitude, you must do it with
   %%% CreateSeq
   
   %%% 10% duty cycle for a 10us sequence is 1us
   
   %%% Delays are not applied in this sequence
% Rabi.Ch1=[0,500,10,0,1] ;
% Rabi.Mk1=[0,500,1];
% Rabi.Mk2=[0,500,1];
%%%%%% Mixer control: I %%%%%% 
ESR.Ch1 = [3050,3050+MWLength,0,pi/2,1]; 
%%%Make sure MWLength does not force this waveform to be longer than the
%%%input length to Wave_generator
        % Wait for Laser to polarize and 50ns
         %Apply MW
%Wave_generator creates sine, so need pi/2 when DC
%Switch is ~3ns before I and Q
%I and Q turn off 3ns before switch


%%%%%% Mixer control: Q %%%%%% 
ESR.Ch2 = [0,0,0];%[3050,3050+MWLength,0,pi/2,1]; 
%%%Make sure MWLength does not force this waveform to be longer than the
%%%input length to Wave_generator
        % Wait for Laser to polarize and 50ns
         %Apply MW
         
%%%%%% Switch %%%%%% 
ESR.Mk1 = [3050,3055+MWLength,1]; 
%%%Make sure MWLength does not force this waveform to be longer than the
%%%input length to Wave_generator
     % Wait for Laser to polarize and turn off
     %turn on and off
%Switch TTL pulse is 5ns longer

%%%%%% Laser %%%%%% 
ESR.Mk2 = [0,3000,1;... %Polarize for 3us
    3001,4101,0;... %wait for: 50ns, max MW duration, 50ns
    4102,7102,1];  %detection for 3us

%%%%%% FPGA Signal %%%%%% 
ESR.Mk3 = [3050,3350,1]; 
% Rabi.Mk3 = [4102,4402,1]; 
%300ns detection window when laser turns on

%%%%%% FPGA Reference %%%%%% 
ESR.Mk4 = [3050,3350,1];
% Rabi.Mk4 = [6802,7102,1];
%300ns detection window for last 300ns of laser detection pulse

%%%%%% Trigger %%%%%% 
ESR.Mk5 = [0,500,1];  %Trigger for observation on Oscope 
ESR.Mk6 = [0,10000,0];  %Markers must come in pairs
% Must specify Analog channel is 0 for purely digital outputs
ESR.Ch3 = [0,0,0,0,0]; 

%%%%%% Unused %%%%%
% Rabi.Ch4 = [0,10000,0,pi/2,1]; 
% Rabi.Mk7 = [0,0,0];  
% Rabi.Mk8 = [0,0,0];  
  
%adjust for readout and MW delay

ESR = delays(Readout, ESR)
% Rabi = delays('None', Rabi);
disp('ESR defined and delayed')

end 

function ESR_Handshake(MWLength) 

global Readout ESR_Handshake
clear global ESR_Handshake
global ESR_Handshake
% t2pi=24;
% tpi2=12;
   %Inputs to Wave_generator must be written in the form
   % For Analog
   %[t1,t2,freq1,phase1,amp1;...
   % t3,t4,freq2,phase2,amp2;...
   %...]
   %
   % For Digital
   %[t1,t2,value1;...
   %t3,t4,value2;...
   %...]

   %%% README: These are inputs for waveFORMS. Waveforms are normalized and
   %%% have no offset. If you want to add an offset or amplitude, you must do it with
   %%% CreateSeq
   
   %%% 10% duty cycle for a 10us sequence is 1us
   
   %%% Delays are not applied in this sequence
% Rabi.Ch1=[0,500,10,0,1] ;
% Rabi.Mk1=[0,500,1];
% Rabi.Mk2=[0,500,1];
%%%%%% Mixer control: I %%%%%% 
ESR_Handshake.Ch1 = [0,0,0]; 
%%%Make sure MWLength does not force this waveform to be longer than the
%%%input length to Wave_generator
        % Wait for Laser to polarize and 50ns
         %Apply MW
%Wave_generator creates sine, so need pi/2 when DC
%Switch is ~3ns before I and Q
%I and Q turn off 3ns before switch


%%%%%% Mixer control: Q %%%%%% 
ESR_Handshake.Ch2 = [0,0,0];%[3050,3050+MWLength,0,pi/2,1]; 
%%%Make sure MWLength does not force this waveform to be longer than the
%%%input length to Wave_generator
        % Wait for Laser to polarize and 50ns
         %Apply MW
         
%%%%%% Switch %%%%%% 
ESR_Handshake.Mk1 = [0,0,0]; 
%%%Make sure MWLength does not force this waveform to be longer than the
%%%input length to Wave_generator
     % Wait for Laser to polarize and turn off
     %turn on and off
%Switch TTL pulse is 5ns longer

%%%%%% Laser %%%%%% 
ESR_Handshake.Mk2 = [0,0,0]

%%%%%% FPGA Signal %%%%%% 
ESR_Handshake.Mk3 = [3050,3350,1]; 
% Rabi.Mk3 = [4102,4402,1]; 
%300ns detection window when laser turns on

%%%%%% FPGA Reference %%%%%% 
ESR_Handshake.Mk4 = [3050,3350,1];
% Rabi.Mk4 = [6802,7102,1];
%300ns detection window for last 300ns of laser detection pulse

%%%%%% Trigger %%%%%% 
ESR_Handshake.Mk5 = [0,500,1];  %Trigger for observation on Oscope 
ESR_Handshake.Mk6 = [0,10000,0];  %Markers must come in pairs
% Must specify Analog channel is 0 for purely digital outputs
ESR_Handshake.Ch3 = [0,0,0,0,0]; 

%%%%%% Unused %%%%%
% Rabi.Ch4 = [0,10000,0,pi/2,1]; 
% Rabi.Mk7 = [0,0,0];  
% Rabi.Mk8 = [0,0,0];  
  
%adjust for readout and MW delay

ESR_Handshake = delays(Readout, ESR_Handshake)
% Rabi = delays('None', Rabi);
disp('ESR defined and delayed')

end 

function AWG_Measure_User(p1,p1ch,p2,p2ch) 

global Readout dataparameters User
clear global User
global User
% t2pi=24;
% tpi2=12;
   %Inputs to Wave_generator must be written in the form
   % For Analog
   %[t1,t2,freq1,phase1,amp1;...
   % t3,t4,freq2,phase2,amp2;...
   %...]
   %
   % For Digital
   %[t1,t2,value1;...
   %t3,t4,value2;...
   %...]

   %%% README: These are inputs for waveFORMS. Waveforms are normalized and
   %%% have no offset. If you want to add an offset or amplitude, you must do it with
   %%% CreateSeq
   
   %%% 10% duty cycle for a 10us sequence is 1us
   
   %%% Delays are not applied in this sequence

pulses={'P1' 'P2'};

for str = pulses
    if ~handles.(char(strcat(str,'_On'))).Value 
        continue %Skip if radio button is off
    end
    
     if  strcmp(dataParameters.Pulses.(char(str)).string,'Width')
     User.(char(dataParameters.Pulses.(char(str)).channel))=[dataParameters.Pulses.(char(str)).channel];
     end
    

end
  
%adjust for readout and MW delay

User = delays(Readout, User)
% Rabi = delays('None', Rabi);
disp('User Sequence defined and delayed')

end 

function AWG_Measure_AOM_Delay(SigTTL) 

global Readout AOM_Delay
clear global AOM_Delay
global AOM_Delay
% t2pi=24;
% tpi2=12;
   %Inputs to Wave_generator must be written in the form
   % For Analog
   %[t1,t2,freq1,phase1,amp1;...
   % t3,t4,freq2,phase2,amp2;...
   %...]
   %
   % For Digital
   %[t1,t2,value1;...
   %t3,t4,value2;...
   %...]

   %%% README: These are inputs for waveFORMS. Waveforms are normalized and
   %%% have no offset. If you want to add an offset or amplitude, you must do it with
   %%% CreateSeq
   
   %%% 10% duty cycle for a 10us sequence is 1us
   
   %%% Delays are not applied in this sequence

%%%%%% Unused %%%%%% 
AOM_Delay.Ch1 = [0,0,0,0,0]; 
AOM_Delay.Ch2 = [0,0,0,0,0];
AOM_Delay.Mk1 = [0,0,0];
     % Wait for Laser to polarize and turn off
     %turn on and off
%Switch is on 3ns before I and Q and off 3ns after

%%%%%% Laser %%%%%% 
AOM_Delay.Mk2 = [0,3000,1];   %Pulse Laser for 3us 
%AOM_Delay.Ch3 = [0,5000,1]; %Pulse Laser 100% duty cycle for 5us sequence

%%%%%% FPGA Signal %%%%%% 
AOM_Delay.Mk3 = [SigTTL,SigTTL+10,1] ;
%7ns detection window

%%%%%% FPGA Reference %%%%%% 
AOM_Delay.Mk4 = [0,10,1];
%7ns detection window while laser is off, assuming ~1us AOM delay
%ie. if laser is delayed 1us, ref at beginning works

%%%%%% Trigger %%%%%% 
AOM_Delay.Mk5 = [0,500,1];  %Trigger for observation on Oscope 
AOM_Delay.Mk6 = [0,0,0];  %Markers must come in pairs
% Must specify Analog channel is 0 for purely digital outputs


%%%%%% Unused %%%%%
AOM_Delay.Ch3 = [0,0,0]; %Must specify a channel completely
% Rabi.Mk7 = [0,0,0];  
% Rabi.Mk8 = [0,0,0];  
  
%adjust for readout and MW delay

AOM_Delay = delays(Readout, AOM_Delay);
% Rabi = delays('None', Rabi);
disp('AOM_Delay defined and delayed')

end 

function newStruct=GenUserWF(struct,samp,len)

%%% Preprocessing

fn = fieldnames(struct) ; %get fieldnames
fn=fn';


%%%%%% Generate Waves %%%%%%

for n=1:length(fn)

    if  strcmp(fn{n}(1:2),'Ch') %Analog 
        newStruct.(fn{n}) = Wave_generator(struct.(fn{n}),samp,len);
       
    else %Digital
        if mod(str2num(fn{n}(3)),2) %If Marker is odd
            if length(struct.(fn{n+1})(1,:))~=3
                error('Markers must come in pairs')
            end
            
            struct.(fn{n}) = Wave_generator(struct.(fn{n}),samp,len);
            struct.(fn{n+1}) = Wave_generator(struct.(fn{n+1}),samp,len);
            
            % encode marker 1 bits to bit 6
            newStruct.(fn{n}) = bitshift(uint8(logical(struct.(fn{n}))),6);
            % encode marker 2 bits to bit 7
            newStruct.(fn{n+1}) =bitshift(uint8(logical(struct.(fn{n+1}))),7);
            
        end
    end
end
end

function Plot_AWG_Sequence(struct,handles)

sn =fieldnames(struct);%get fieldnames
if ~isempty(sn) %Is PreSent is a structure with no fieldnames
    for n=1:length(sn)
        
        %Since Channels must be totally defined, it is sufficient to look just for
        %'Ch#' and assume the Markers are there.
        if strcmp(sn{n},'Ch1') %If it's Channel 1
            plot(handles.axes1, single(struct.Ch1)/max(single((struct.Ch1))),'-r')
            hold on
            plot(handles.axes1,single(struct.Mk1)/max(single(struct.Mk1))+1.1, '-r','LineStyle','--')
            plot(handles.axes1,single(struct.Mk2)/max(single(struct.Mk2))+2.2, '-r','LineStyle',':')
        elseif strcmp(sn{n},'Ch2') %If it's Channel 2
            plot(handles.axes1,single(struct.Ch2)/max(single(struct.Ch2))+3.3,'-b')
            hold on
            plot(handles.axes1,single(struct.Mk3)/max(single(struct.Mk3))+4.4, '-b','LineStyle','--')
            plot(handles.axes1,single(struct.Mk4)/max(single(struct.Mk4))+5.5, '-b','LineStyle',':')
        elseif strcmp(sn{n},'Ch3') %If it's Channel 3
            plot(handles.axes1,single(struct.Ch3)/max(single(struct.Ch3))+6.6,'-g')
            hold on
            plot(handles.axes1,single(struct.Mk5)/max(single(struct.Mk5))+7.7, '-g','LineStyle','--')
            plot(handles.axes1,single(struct.Mk6)/max(single(struct.Mk6))+8.8, '-g','LineStyle',':')
        elseif strcmp(sn{n},'Ch3') %If it's Channel 4
            plot(handles.axes1,single(struct.Ch4)/max(single(struct.Ch4))+9.9,'-k')
            hold on
            plot(handles.axes1,single(struct.Mk7)/max(single(struct.Mk7))+11, '-k','LineStyle','--')
            plot(handles.axes1,single(struct.Mk8)/max(single(struct.Mk8))+12.1, '-k','LineStyle',':')
        end
        
    end
end
hold off
end

function Plot_Data(name,handles)

global data dataParameters

Sig= data.(char(name)).signal;
Ref= data.(char(name)).reference;
Indep=dataParameters.(char(name)).vector;

plot(handles.axes3, single(Indep),single(Sig),'-r')
hold on
plot(handles.axes3, single(Indep),single(Ref),'-b','LineStyle','--')
hold off

end

function NewStruct = delays(Readout, struct)

Readout

% 66ns from AWG to MW Stripline
AWG2I = 66; %in waveform points. for 1GHz sampling 1point=1ns
AWG2Q = 66;
AWG2Switch = 12; %12ns after to I and Q, includes cable and switch response time
AWG2AOM = 1086;
AWG2Sig = 0; %Sig is 2ns ahead Ref and 22ns ahead I/Q output
AWG2Ref = 0;
Delays.Ch1 = AWG2I;
Delays.Ch2 = AWG2Q;
Delays.Mk1 = AWG2Switch;
Delays.Mk2 = AWG2AOM;
Delays.Mk3 = AWG2Sig;
Delays.Mk4 = AWG2Ref;


if strcmp(Readout,'SPCM')
    %adjust time stamps that need it
    fn = fieldnames(Delays);
    for str = fn'
        struct.(char(str))(:,1:2) = struct.(char(str))(:,1:2)+Delays.(char(str));
    end
    
    %Wave_generator interprets prepended 0 as 0s until the first explicitly specified time
    %Also, it indicates to Wave_generator to fill 0s from the last
    %specified time to the specified length of the waveform.
    fn = fieldnames(struct);
        for str = fn'
            if length(struct.(char(str)))==5 %If it's analog
                struct.(char(str)) = cat(1,[0,0,0,0,0],struct.(char(str)));
            else %If it's digital
                struct.(char(str)) = cat(1,[0,0,0],struct.(char(str)));
            end
    end
    
elseif strcmp(Readout,'None')
   
    %Wave_generator interprets prepended 0 as 0s until the first explicitly specified time
    %Also, it indicates to Wave_generator to fill 0s from the last
    %specified time to the specified length of the waveform.
    fn = fieldnames(struct);
        for str = fn'
            if length(struct.(char(str)))==5 %If it's analog
                struct.(char(str)) = cat(1,[0,0,0,0,0],struct.(char(str)));
            else %If it's digital
                struct.(char(str)) = cat(1,[0,0,0],struct.(char(str)));
            end
    end
%     Ch1(:,1:2)=Ch1(:,1:2)+AWG2I; %adjust all time stamps
%     Ch1=cat(1,[0,0,0,0,0],Ch1); %Wave_generator interprets prepended 0 as 0 until the first explicitly specified time
%     Ch2(:,1:2)=Ch2(:,1:2)+AWG2Q;
%     Ch2=cat(1,[0,0,0,0,0],Ch2);
%     Ch3(:,1:2)=Ch3(:,1:2)+0;
%     Ch3=cat(1,[0,0,0,0,0],Ch3);
%     Ch4(:,1:2)=Ch4(:,1:2)+850;
%     Ch4=cat(1,[0,0,0,0,0],Ch4);
%     Mk1(:,1:2)=Mk1(:,1:2)+AWG2Switch;
%     Mk1=cat(1,[0,0,0,0,0],Mk1);
%     Mk2(:,1:2)=Mk2(:,1:2)+AWG2AOM;
%     Mk2=cat(1,[0,0,0,0,0],Mk2);
%     Mk3(:,1:2)=Mk3(:,1:2)+AWG2Count;
%     Mk3=cat(1,[0,0,0,0,0],Mk3);
%     Mk4(:,1:2)=Mk4(:,1:2)+AWG2FPGA;
%     Mk4=cat(1,[0,0,0,0,0],Mk4);
%     Mk5(:,1:2)=Mk5(:,1:2)+0;
%     Mk5=cat(1,[0,0,0,0,0],Mk5);
%     Mk6(:,1:2)=Mk6(:,1:2)+0;
%     Mk6=cat(1,[0,0,0,0,0],Mk6);
%     Mk7(:,1:2)=Mk7(:,1:2)+0;
%     Mk7=cat(1,[0,0,0,0,0],Mk7);
%     Mk8(:,1:2)=Mk8(:,1:2)+0;
%     Mk8=cat(1,[0,0,0,0,0],Mk8);
else
    disp('error: delay is ill-defined')
end

NewStruct=struct;

end

%Note, this function outputs single form numbers to be compatible with AWG
function A = Wave_generator (Waveform, Sample_rate, Length)
   %Inputs to Wave_generator must be written in the form
   % For Analog
   %[t1,t2,freq1,phase1,amp1;...
   % t3,t4,freq2,phase2,amp2;...
   %...]
   %
   % For Digital
   %[t1,t2,value1;...
   %t3,t4,value2;...
   %...]

   %%% README: This function produces waveFORMS. Waveforms are normalized and
   %%% have no offset. If you want to add an offset or amplitude, you must do it with
   %%% CreateSeq
   %%% Wave_generator interprets prepended 0 as 0 until the first explicitly specified time
   %%% Also, it indicates to Wave_generator to fill 0s from the last
   %%% specified time to the specified length of the waveform.
   %%% If times are specified beyond the input length, Wave_generator will
   %%% create a waveform longer than the specified length. This causes
   %%% errors when merging waveforms to send to the AWG!!!
   %%% IMPORTANT: If a channel has an analog output defined, it must also
   %%% have a digital output defined (0 if need be) and vice versa
   
% tic
% Sample_rate = 1000; %MHz
% Length = 1; %us
i = 0;
Total = Length*Sample_rate;
% result = 0;
A = [];
[dimx,dimy] = size(Waveform);  % dimy == 3 Digital waveform, dimy == 5 Analog wave
if ( (dimy == 5) || (dimy == 6))
    while (i < dimx)
        i = i+1;
        B = round( Waveform(i,1)):round((Waveform(i,2)-1));
        C = Waveform(i,5)*sin(2 * pi * Waveform(i,3) / Sample_rate * B + Waveform(i,4));
        if (dimy == 6)
            Delay = zeros(1,Waveform(i,6));
        elseif (dimy == 5)
            if (i < dimx)
                Delay = zeros(1,Waveform(i+1,1)-Waveform(i,2));
            elseif (i == dimx)
                Delay = zeros(1,Total-Waveform(i,2));
            end
        end
        A = [A, C, Delay];
    end
    
elseif ((dimy == 9) || (dimy == 8)) % Adding of 2 frequencies
    while (i < dimx)
        i = i+1;
        B = round(Waveform(i,1)):round((Waveform(i,2)-1));
        C = Waveform(i,5)*sin(2 * pi * Waveform(i,3) / Sample_rate * B + Waveform(i,4)) +  Waveform(i,8)*sin(2 * pi * Waveform(i,6) / Sample_rate * B + Waveform(i,7));
        if (dimy == 9)
            Delay = zeros(1,Waveform(i,9));
        elseif (dimy == 8)
            if (i < dimx)
                Delay = zeros(1,Waveform(i+1,1)-Waveform(i,2));
            elseif (i == dimx)
                Delay = zeros(1,Total-Waveform(i,2));
            end
        end
        A = [A, C, Delay];
    end
    
elseif (dimy == 3) % dimy == 3 Digital waveform, dimy == 5,6,8,9 Analog wave

    while (i <dimx)
        i = i+1;
            C = Waveform(i,3) * ones(1,round(Waveform(i,2)) - round(Waveform(i,1)));
            if (i < dimx)
                Delay = zeros(1,Waveform(i+1,1)-Waveform(i,2));
            elseif (i == dimx)
                Delay = zeros(1,Total-Waveform(i,2));
            end

            A = [A, C, Delay];
    end
elseif (dimy == 2) % Digital with only amp=1 element    
   while (i <dimx)
        i = i+1;
        C = ones(1,round(Waveform(i,2)) - round(Waveform(i,1)));
        if (i < dimx)
            Delay = zeros(1,Waveform(i+1,1)-Waveform(i,2));
        elseif (i == dimx)
            Delay = zeros(1,Total-Waveform(i,2));
        end
        A = [A, C, Delay];
   end
end

A = single(A);

end

function newStruct=GenAWGWF(struct,samp,len)

%%% Preprocessing

fn = fieldnames(struct) ; %get fieldnames
fn=fn';


%%%%%% Generate Waves %%%%%%

for n=1:length(fn)

    if  strcmp(fn{n}(1:2),'Ch') %Analog 
        newStruct.(fn{n}) = Wave_generator(struct.(fn{n}),samp,len);
       
    else %Digital
        if mod(str2num(fn{n}(3)),2) %If Marker is odd
            if length(struct.(fn{n+1})(1,:))~=3
                error('Markers must come in pairs')
            end
            
            struct.(fn{n}) = Wave_generator(struct.(fn{n}),samp,len);
            struct.(fn{n+1}) = Wave_generator(struct.(fn{n+1}),samp,len);
            
            % encode marker 1 bits to bit 6
            newStruct.(fn{n}) = bitshift(uint8(logical(struct.(fn{n}))),6);
            % encode marker 2 bits to bit 7
            newStruct.(fn{n+1}) =bitshift(uint8(logical(struct.(fn{n+1}))),7);
            
        end
    end
end
end

function Sent=SendWF2AWG(samples,len,structure,PreSent,name) 
% !!!!README!!!! AWG MATLAB ICT Send Waveform 3
% Date 10-9-2009
% by Carl https://forum.tek.com/viewtopic.php?f=580&t=133570
% ==================
% Send a waveform to the AWG using the Real format
% %%% IMPORTANT: If a channel has an analog output defined, it must also
% %%% have a digital output defined (0 if need be) and vice versa
%
% ==================

%% Code

clear global ChnlCount
global ChnlCount

%%% Filter for waves that need to be sent

if isstruct(PreSent)
    
    sn =fieldnames(PreSent);%get fieldnames
    if isempty(sn) %Is PreSent is a structure with no fieldnames
        struct=structure;
    else
        for n=1:length(sn)
            if PreSent.(sn{n}) == 0 %If is wasn't sent...
                %...assign to the structure to be used in this function
                % PreSent only encodes channels, so have to assign Mk too
                if strcmp(sn{n}(3),'1') %If it's Channel 1
                    struct.Ch1 = structure.Ch1
                    struct.Mk1 = structure.Mk1
                    struct.Mk2 = structure.Mk2
                elseif strcmp(sn{n}(3),'2') %If it's Channel 2
                    struct.Ch2 = structure.Ch2;
                    struct.Mk3 = structure.Mk3;
                    struct.Mk4 = structure.Mk4;
                elseif strcmp(sn{n}(3),'3') %If it's Channel 3
                    struct.Ch3 = structure.Ch3;
                    struct.Mk5 = structure.Mk5;
                    struct.Mk6 = structure.Mk6;
                else %Must be Channel 4
                    struct.Ch4 = structure.Ch4;
                    struct.Mk7 = structure.Mk7;
                    struct.Mk8 = structure.Mk8;
                end
            else
                Sent=PreSent;
                return
            end
        end
    end
else
    struct=structure;
end

%%% Preprocessing

fn = fieldnames(struct) ; %get fieldnames
fn=fn';


%%%%%% Processing Waves %%%%%%
ChnlCount={};

for n=1:length(fn)

    if  strcmp(fn{n}(1:2),'Ch') %Analog 
        ChnlCount{end+1}=fn{n}; % Since all digital outputs must also have 
        %an analog output, counting analog outputs is equivalent to
        %counting the number of channels used.
    else %Digital
        if mod(str2num(fn{n}(3)),2) %If Marker is odd
            
            %%%% merge markers %%%%
            if strcmp(fn{n}(3),'1') %If it's Marker 1
                merged.Ch1=struct.Mk1+struct.Mk2; %check dec2bin(m(2),8)
            elseif strcmp(fn{n}(3),'3') %If it's Marker 3
                merged.Ch2=struct.Mk3+struct.Mk4; %check dec2bin(m(2),8)
            elseif strcmp(fn{n}(3),'5') %If it's Marker 5
                merged.Ch3=struct.Mk5+struct.Mk6; %check dec2bin(m(2),8)
            else %Must be Marker 7
                merged.Ch4=struct.Mk7+struct.Mk8; %check dec2bin(m(2),8)
            end
        end
    end
end


%Stitch wave data with marker datar as per programmer manual
%Create structure to hold binblock arrays

for str = ChnlCount
    binblock.(char(str)) = zeros(1,len*samples*5,'uint8'); % real uses 5 bytes per sample
    
    for k=1:len*samples
        binblock.(char(str))((k-1)*5+1:(k-1)*5+5) = [typecast(struct.(char(str))(k),'uint8') merged.(char(str))(k)];
    %   binblock1((k-1)*5+1:(k-1)*5+5) = [typecast(y(k),'uint8') m12(k)];
    end
end



%%%%%% build binblock header %%%%%% 
bytes = num2str(length(binblock.(fn{1}))); %All binblocks are the same length
header = ['#' num2str(length(bytes)) bytes]; %This is IEEE standard

%% Transfer to Instrument

%%%%%% Initialize Instrument %%%%%%
visa_vendor = 'ni'; %No idea why ni works. Should be Tek
visa_address = 'TCPIP::136.152.250.165::INSTR';
buffer = 2 * 1024;
awg = visa(visa_vendor,visa_address,'InputBufferSize',buffer, ...
    'OutputBufferSize',buffer); %Default buffer size is 512. AWG can do more
fopen(awg);
fwrite(awg, '*CLS');
pause(0.05)
fprintf(awg,'%s\n','*ESR?'); %Query to ensure Matlab wait sufficiently
fscanf(awg,'%s');
%AWG_Debug()

%%%%%% clear and write waveform %%%%%% 

fnB = fieldnames(binblock); %get fieldnames (ie. 'Ch#')

cmd=cell(1,length(fnB)); %Create cell to hold commands

for n = 1:length(fnB)
    %Create space for an empty waveform with name and datasize
    fwrite(awg,['WLIST:WAV:DEL "' name (fnB{n}) '";:WLIST:WAV:NEW "' name (fnB{n}) '",' num2str(len*samples) ',real;'])
    fprintf(awg,'%s\n','*ESR?;SYST:ERR?'); %Query to ensure Matlab wait sufficiently
    fscanf(awg,'%s');
    %The Command for transfering data from an external controller to awg. The
    %syntax used here is WLIST:WAVEFORM:DATA <wfm_name>,<block_data>
    cmd{n} = [':wlist:waveform:data "' name (fnB{n}) '",' header binblock.(fnB{n}) ';'];
    %fwrite(awg,'sour1:wav "isoya_sm_ch1_s1"')
end
%fwrite(awg, 'WLIST:SIZE? '); 
%check=fscanf(awg,'%s'); % Check size of waveform list
%If all deleted, should return 25

%AWG_Debug()

bytes = length(cmd{1}); % EOIMode applies only to visa objects
if buffer >= bytes  % If buffer can handle it, proceed
    for n=1:length(cmd)
        fwrite(awg,cmd{n});
        fprintf(awg,'%s\n','*ESR?'); %Query to ensure Matlab wait sufficiently
        fscanf(awg,'%s');
    end
else %Send waveform in buffer-sized chunks if too big
    'Sending waveform in chunks'
    for n=1:length(cmd) %This loop must be out here when EOI off
        %Otherwise AWG conflates waveforms
        awg.EOIMode = 'off';
        for i = 1:buffer:bytes-buffer
            %length(cmd(i:i+buffer-1))
            fwrite(awg,cmd{n}(i:i+buffer-1))
        end
        awg.EOIMode = 'on';
        i=i+buffer;
        %length(cmd(i:end))
        fwrite(awg,cmd{n}(i:end));
        fprintf(awg,'%s\n','*ESR?'); %Query to ensure Matlab wait sufficiently
        fscanf(awg,'%s');
    end
end

%AWG_Debug()

%%%Carl Murdock, Tektronix engineer recommends using this only for
%%%debugging
% Check whether loaded successfully
% err=0;
% for n = 1:length(fnB)
%     fprintf(awg,'%s\n',[':wlist:waveform:data? "' name (fnB{n}) '"']); 
%     ch=fscanf(awg,'%s');
%     
%     if isempty(ch)
%         [(fnB{n}) ' Did not load successfully']
%         Sent.(fnB{n})=0; %Return that it failed
%         err=1;
%     else
%         [(fnB{n}) ' Likely Loaded Successfully']
%         Sent.(fnB{n})=1; %Return that it succeeded
%     end
% end
   
Sent.(fnB{n})=1; %Return that it succeeded
% Gracefully disconnect
fclose(awg);
delete(awg);    %delete instrument object
clear awg; 

% if err==1
%     error('Unsuccessful Transfer to AWG')
% end

end

%% Notes
%{
% The real waveform type is not a voltage, but a scaling factor.  Maximum
% value is 1 while minimum value is -1. The resulting output voltage can be
% calculated by the following formula: my_real_wfm(sample) *
% (amplitude_setting/2) + offset_setting = output_voltage
%
% The real waveform type uses 5 bytes per sample while the integer type
% uses 2 bytes.
%
% The integer type allows for the most efficient and precise control of an
% AWG
%
% The real type allows for dynamic scaling of waveform data at run-time.
% This allows for math operations or changing bits of precision (i.e. AWG5k
% (14-bit) to/from AWG7k (8-bit), AWG7k 8-bit mode to/from AWG7k 10-bit
% mode) minimal degradation of sample data.
%}


function CreateSUBSeq(subLen,loop_count,elem_ind,name)
%% REVISE as CreateSeq before use
%%

global samples buffer


%%%%%% Initialize Instrument %%%%%%
visa_vendor = 'ni';
visa_address = 'TCPIP::136.152.250.165::INSTR';
buffer = 2 * 1024;
awg = visa(visa_vendor,visa_address,'InputBufferSize',buffer, ...
    'OutputBufferSize',buffer); %Default buffer size is 512. AWG can do more
fopen(awg);

%go to sequence mode
fprintf(awg, '%s\n', 'AWGC:RMOD SEQ');

%Initialize Subsequence
fprintf(awg, '%s\n',['SLIST:SIZE?'] ); check=fscanf(awg,'%s')
fprintf(awg, '%s\n',['SLIST:SUBS:DELETE "' name '"'] ); %Clear subsequence first
fprintf(awg, '%s\n',['SLIST:SUBS:NEW "' name '",' num2str(subLen)] ); %creates new subsequence with name and length subLen
fprintf(awg, '%s\n',['SLIST:SIZE?'] ); check=fscanf(awg,'%s') 
%write waveforms into subsequence
for kk=floor(elem_ind):subLen
    %Assign waveform to specific channels for nLoop counts in the sequence
    % If no waveform of the specified name exists, the AWG simply moves on
    fprintf(awg, '%s\n',['SLIST:SUBS:ELEM' num2str(kk) ':WAV1 "' name '_' num2str(kk) '_Ch1"']); %Test with a predefined waveform
    fprintf(awg, '%s\n',['SLIST:SUBS:ELEM' num2str(kk) ':WAV2 "' name '_' num2str(kk) '_Ch2"']); 
    fprintf(awg, '%s\n',['SLIST:SUBS:ELEM' num2str(kk) ':WAV3 "' name '_' num2str(kk) '_Ch3"']); 
    fprintf(awg, '%s\n',['SLIST:SUBS:ELEM' num2str(kk) ':WAV4 "' name '_' num2str(kk) '_Ch4"']); 
    fprintf(awg, '%s\n',['SLIST:SUBS:ELEM' num2str(kk) ':LOOP:COUN ' num2str(loop_count)]);
    %Number of times to loop element is max 65536 if you don't hit the
    %waveform memory limit first
    %fwrite(awg,['SEQ:ELEM' num2str(kk) ':GOTO:STAT 0']) %% Turns off the ability of the GoTo:Index to take effect for this element
end

% Gracefully disconnect
fclose(awg);
delete(awg);    %delete instrument object
clear awg; 

%% Notes
%{
% The real waveform type is not a voltage, but a scaling factor.  Maximum
% value is 1 while minimum value is -1. The resulting output voltage can be
% calculated by the following formula: my_real_wfm(sample) *
% (amplitude_setting/2) + offset_setting = output_voltage
%
% The real waveform type uses 5 bytes per sample while the integer type
% uses 2 bytes.
%
% The integer type allows for the most efficient and precise control of an
% AWG
%
% The real type allows for dynamic scaling of waveform data at run-time.
% This allows for math operations or changing bits of precision (i.e. AWG5k
% (14-bit) to/from AWG7k (8-bit), AWG7k 8-bit mode to/from AWG7k 10-bit
% mode) minimal degradation of sample data.
%}
end

function CreateSeq_from_SUB(loop_standard,loop_count,elem_ind,name,DC,AMP)
%% REVISE as CreateSeq before use
%%
global samples buffer

DC_Ch1 = DC(1);
DC_Ch2 = DC(2);
DC_Ch3 = DC(3);
DC_Ch4 = DC(4);
AMPL_Ch1= AMP(1);
AMPL_Ch2= AMP(2);
AMPL_Ch3= AMP(3);
AMPL_Ch4= AMP(4);
    
%%%%%% Initialize Instrument %%%%%%
visa_vendor = 'ni';
visa_address = 'TCPIP::136.152.250.165::INSTR';
buffer = 2 * 1024;
awg = visa(visa_vendor,visa_address,'InputBufferSize',buffer, ...
    'OutputBufferSize',buffer); %Default buffer size is 512. AWG can do more
fopen(awg);

%go to sequence mode
fprintf(awg, '%s\n', 'AWGC:RMOD SEQ');

%write waveforms into sequence
fprintf(awg, '%s\n',['SEQ:LENG ' num2str(0)]); %Clear sequence first.
%If loading a shorter sequence than the previous, AWG doesn't run
fprintf(awg, '%s\n',['SEQ:LENG ' num2str(loop_standard)]);
for kk=floor(elem_ind):loop_standard
    %Assign waveform to specific channels for nLoop counts in the sequence
    % If no waveform of the specified name exists, the AWG simply moves on
    fprintf(awg, '%s\n',['SEQ:ELEM' num2str(kk) ':SUBS "' name '"']); %Test with a predefined waveform
    fprintf(awg, '%s\n',['SEQ:ELEM' num2str(kk) ':LOOP:COUN ' num2str(loop_count)]);
    %Number of times to loop element is max 65536 if you don't hit the
    %waveform memory limit first
    %fwrite(awg,['SEQ:ELEM' num2str(kk) ':GOTO:STAT 0']) %% Turns off the ability of the GoTo:Index to take effect for this element
end

%fwrite(awg,['SEQ:ELEM' num2str(loop_standard) ':GOTO:STAT 1']) %%Turns on the GoTo:Index ability for the last element in the sequence
%fwrite(awg,['SEQ:ELEM' num2str(loop_standard) ':GOTO:IND 1']) %%Goes to the first index (index 1) in the last element of the sequence

%%%%%% DC offset %%%%%% 
fwrite(awg,['sour1:volt:offs ' num2str(DC_Ch1)])
fwrite(awg,['sour2:volt:offs ' num2str(DC_Ch2)])
fwrite(awg,['sour3:volt:offs ' num2str(DC_Ch3)])
fwrite(awg,['sour4:volt:offs ' num2str(DC_Ch4)])

%%%%%% amp %%%%%% 
fwrite(awg,['sour1:volt:ampl ' num2str(AMPL_Ch1)])
fwrite(awg,['sour2:volt:ampl ' num2str(AMPL_Ch2)])
fwrite(awg,['sour3:volt:ampl ' num2str(AMPL_Ch3)])
fwrite(awg,['sour4:volt:ampl ' num2str(AMPL_Ch4)])

s = ['SOURCE1:FREQUENCY' , num2str(samples),'MHz'];
fprintf(awg, '%s\n', s);

% Gracefully disconnect
fclose(awg);
delete(awg);    %delete instrument object
clear awg; 

%% Notes
%{
% The real waveform type is not a voltage, but a scaling factor.  Maximum
% value is 1 while minimum value is -1. The resulting output voltage can be
% calculated by the following formula: my_real_wfm(sample) *
% (amplitude_setting/2) + offset_setting = output_voltage
%
% The real waveform type uses 5 bytes per sample while the integer type
% uses 2 bytes.
%
% The integer type allows for the most efficient and precise control of an
% AWG
%
% The real type allows for dynamic scaling of waveform data at run-time.
% This allows for math operations or changing bits of precision (i.e. AWG5k
% (14-bit) to/from AWG7k (8-bit), AWG7k 8-bit mode to/from AWG7k 10-bit
% mode) minimal degradation of sample data.
%}
end

function CreateSeq(loop_standard,loop_count,elem_ind,name,DC,AMP)
%%README: Idea behind CreateSeq
% loop_standard is the number elements in the AWG Sequence.
% loop_count is the number of times an element is repeated before the AWG
% moves on to the next element in the sequence.
% elem_ind is the current index of the element in the sequence
%%%About the AWG Sequence: The AWG loads waveforms into it's memory. For
%%%the AWG, a pulse sequence is composed of a number of elements, each
%%%containing a single waveform. First, tell the AWG how many elements
%%%there will be in the sequence (loop_standard). For each element in
%%%the sequence, assign a single waveform to each channel. Then specify how
%%%many times to repeat that set of waveforms in the element (loop_count).
%%%Repeat for each element in the sequence
%%

global samples buffer ChnlCount

DC_Ch1 = DC(1);
DC_Ch2 = DC(2);
DC_Ch3 = DC(3);
DC_Ch4 = DC(4);
AMPL_Ch1= AMP(1);
AMPL_Ch2= AMP(2);
AMPL_Ch3= AMP(3);
AMPL_Ch4= AMP(4);
High_Mk= AMP(5);
    
%%%%%% Initialize Instrument %%%%%%
visa_vendor = 'ni';
visa_address = 'TCPIP::136.152.250.165::INSTR';
buffer = 2 * 1024;
awg = visa(visa_vendor,visa_address,'InputBufferSize',buffer, ...
    'OutputBufferSize',buffer); %Default buffer size is 512. AWG can do more
fopen(awg); 
fprintf(awg,'%s\n','*ESR?'); %Query to ensure Matlab wait sufficiently
fscanf(awg,'%s');

%go to sequence mode
fprintf(awg, '%s\n', 'AWGC:RMOD SEQ');
fprintf(awg,'%s\n','*ESR?'); %Query to ensure Matlab wait sufficiently
fscanf(awg,'%s');

%write waveforms into sequence
fprintf(awg, '%s\n',['SEQ:LENG ' num2str(0) ';:SEQ:LENG ' num2str(loop_standard)]); 

fprintf(awg,'%s\n','*ESR?;SYST:ERR?'); %Query to ensure Matlab wait sufficiently
fscanf(awg,'%s');
%Clear sequence first. Then allocate sequence size
%If loading a shorter sequence than the previous, AWG doesn't run


for kk=floor(elem_ind):loop_standard
    %Test with a predefined waveform
    %Assign waveform to specific channels for nLoop counts in the sequence
    % If no waveform of the specified name exists, the AWG produces an
    % error, but continues. However, backlogs of unread errors will
    % eventually overfill the queue and lead to a FATAL crash
    seqCmd = ['SEQ:ELEM' num2str(kk) ':'];
    ch=0;
    for str = ChnlCount
        if strcmp(str,'Ch1')
            ch=ch+1;
            seqCmd = strcat(seqCmd,['WAV1 "' name 'Ch1";']);
        end
        if strcmp(str,'Ch2')
            ch=ch+1;
            seqCmd = strcat(seqCmd,['WAV2 "' name 'Ch2";']);
        end
        if strcmp(str,'Ch3')
            ch=ch+1;
            seqCmd = strcat(seqCmd,['WAV3 "' name 'Ch3";']);
        end
        if strcmp(str,'Ch4')
            ch=ch+1;
            seqCmd = strcat(seqCmd,['WAV4 "' name 'Ch4";']);
        end
        if ch==0
            fclose(awg);
            delete(awg);    %delete instrument object
            clear awg;
            error('No channels defined')
        end
    end
    fprintf(awg,'%s\n',strcat(seqCmd,['LOOP:COUN ' num2str(loop_count) ';*ESR?;:SYST:ERR?']));
    fscanf(awg,'%s');
    %Number of times to loop element is max 65536 if you don't hit the
    %waveform memory limit first
end

%fwrite(awg,['SEQ:ELEM' num2str(loop_standard) ':GOTO:STAT 1']) %%Turns on the GoTo:Index ability for the last element in the sequence
%fwrite(awg,['SEQ:ELEM' num2str(loop_standard) ':GOTO:IND 1']) %%Goes to the first index (index 1) in the last element of the sequence

%%%%%% DC offset %%%%%% 
fwrite(awg,['sour1:volt:offs ' num2str(DC_Ch1)])
fwrite(awg,['sour2:volt:offs ' num2str(DC_Ch2)])
fwrite(awg,['sour3:volt:offs ' num2str(DC_Ch3)])
fwrite(awg,['sour4:volt:offs ' num2str(DC_Ch4)])
fprintf(awg,'%s\n','*ESR?;SYST:ERR?'); %Query to ensure Matlab wait sufficiently
fscanf(awg,'%s');

%%%%%% amp %%%%%% 
fwrite(awg,['sour1:volt:ampl ' num2str(AMPL_Ch1)])
fwrite(awg,['sour2:volt:ampl ' num2str(AMPL_Ch2)])
fwrite(awg,['sour3:volt:ampl ' num2str(AMPL_Ch3)])
fwrite(awg,['sour4:volt:ampl ' num2str(AMPL_Ch4)])
fprintf(awg,'%s\n','*ESR?;SYST:ERR?'); %Query to ensure Matlab wait sufficiently
fscanf(awg,'%s');
fwrite(awg,['sour1:mark1:volt:high ' num2str(High_Mk)])
fwrite(awg,['sour1:mark2:volt:high ' num2str(High_Mk)])
fwrite(awg,['sour2:mark1:volt:high ' num2str(High_Mk)])
fwrite(awg,['sour2:mark2:volt:high ' num2str(High_Mk)])
fwrite(awg,['sour3:mark1:volt:high ' num2str(High_Mk)])
fwrite(awg,['sour3:mark2:volt:high ' num2str(High_Mk)])
fwrite(awg,['sour4:mark1:volt:high ' num2str(High_Mk)])
fwrite(awg,['sour4:mark2:volt:high ' num2str(High_Mk)])
fprintf(awg,'%s\n','*ESR?;SYST:ERR?'); %Query to ensure Matlab wait sufficiently
fscanf(awg,'%s');

%This function is unrecognized for some reason
s = ['SOURCE1:FREQUENCY' , num2str(samples),'MHz'];
fprintf(awg, '%s\n', s);

% Gracefully disconnect
fclose(awg);
delete(awg);    %delete instrument object
clear awg; 

%% Notes
%{
% The real waveform type is not a voltage, but a scaling factor.  Maximum
% value is 1 while minimum value is -1. The resulting output voltage can be
% calculated by the following formula: my_real_wfm(sample) *
% (amplitude_setting/2) + offset_setting = output_voltage
%
% The real waveform type uses 5 bytes per sample while the integer type
% uses 2 bytes.
%
% The integer type allows for the most efficient and precise control of an
% AWG
%
% The real type allows for dynamic scaling of waveform data at run-time.
% This allows for math operations or changing bits of precision (i.e. AWG5k
% (14-bit) to/from AWG7k (8-bit), AWG7k 8-bit mode to/from AWG7k 10-bit
% mode) minimal degradation of sample data.
%}
end

function OutputAWG(runstate,ch1, ch2, ch3, ch4)

global samples

%%%%%% instrument communication %%%%%%
%%%%%% initialize the instrument %%%%%% 
visa_vendor = 'ni';
visa_address = 'TCPIP::136.152.250.165::INSTR';
buffer = 2 * 1024;
awg = visa(visa_vendor,visa_address);
fopen(awg);
% fwrite(awg, '*CLS');
% 'AWG Errors Cleared'
% AWG_Debug()

if runstate==1
    pause(1)
    %%%%%% switch output on %%%%%% 
    fprintf(awg,['OUTP1 ' num2str(ch1)])
    fprintf(awg,['OUTP2 ' num2str(ch2)])
    fprintf(awg,['OUTP3 ' num2str(ch3)])
    fprintf(awg,['OUTP4 ' num2str(ch4)]) 
    fprintf(awg, 'AWGC:RUN')
    fprintf(awg, '%s\n','AWGCONTROL:RSTATE?');
    run=str2num(fscanf(awg,'%s'));

else
    %%%%%% switch output off %%%%%% 
    fwrite(awg, 'AWGC:STOP')
    fwrite(awg,'OUTP1 0')
    fwrite(awg,'OUTP2 0')
    fwrite(awg,'OUTP3 0')
    fwrite(awg,'OUTP4 0') 
    fprintf(awg, '%s\n','AWGCONTROL:RSTATE?');
    run=str2num(fscanf(awg,'%s'));
end

if run==2
    'Running'
elseif run==1
    'Waiting for Trigger'
else
    'Stopped'
end

%Gracefully disconnect
fclose(awg);
delete(awg);
clear awg;
end

function DC_Offsets(hObject, eventdata, handles)
global DC_off

DCI = 0.02;
DCQ = 0.02;
DC_off.I=DCI;
DC_off.Q=DCQ;
    disp(' ')
    disp(['--- I DC Offset =' num2str(DCI)])
    disp(['--- Q DC Offset =' num2str(DCQ)])
end

function Run_ADC_for_DataAcquisition(hObject, eventdata, handles)

    global Inputs 
    
    curr_it=1;
    while get(handles.stop,'Value') == 0
        
        ADC_init(Inputs.nSamples,Inputs.NPulse);
        if curr_it==1
            disp(['Data acquisition takes ' num2str(2*Inputs.seq_timeout*1e-9) ' seconds'])
        end
        pause(2*Inputs.seq_timeout*1e-9)
                
        [data read_time] = ADC_read(Inputs.nSamples,Inputs.NPulse,Inputs.num_samp);
        
        if curr_it==1
            disp(['ADC readout takes '  num2str(read_time) ' seconds'])
        end
        
        data(find(data>1))=0;
        data(find(data<0.02))=0;
        volts=zeros(1,Inputs.NPulse);
        for m=1:Inputs.NPulse
            i_l=(m-1)*Inputs.num_samp+1;
            i_u=m*Inputs.num_samp;
            rel_data=data(i_l:i_u);
            ind = find(rel_data, 1);
            rel_data_pts=rel_data(ind+Inputs.ign_pts:ind+Inputs.ign_pts+Inputs.read_pts-1);
            volts(m)=mean(rel_data_pts);
        end
        
        PlotResults(curr_it, volts, data);
        
        curr_it = curr_it + 1;
    end
end

function ADC_init(NRep,NPuls)

s = serial('COM5');
set(s,'BaudRate',57600);
set(s,'Parity','none');
set(s,'DataBits',8);
set(s,'StopBits',1);
set(s,'FlowControl','none');
fopen(s);

fprintf(s,'%s',['C ' num2str(NPuls) ';']);
fprintf(s,'%s',['G ' num2str(NRep) ';']);

fclose(s)
delete(s)
clear s

end

function [result read_time]=ADC_read(NRep,NPulse,num_samp)

tic

s = serial('COM5');
set(s,'BaudRate',57600);
set(s,'Parity','none');
set(s,'DataBits',8);
set(s,'StopBits',1);
set(s,'FlowControl','none');
fopen(s);

 
fprintf(s,'A118;&p;');
out = fscanf(s);
 
num_it_ac=str2num(out(end-9:end-2));
if num_it_ac~=NRep
    disp(['CAUTION, only ' num2str(num_it_ac) '/' num2str(NRep) ' samples were acquired!'])
end

result=zeros(1,num_samp*NPulse);
for k=1:NPulse
fprintf(s,['r ' num2str(k) ';']);
out = fscanf(s);
result_str=out(4:end-2);
volt_cell=strsplit(result_str,',');
volt_vec=str2double(volt_cell);
result((k-1)*num_samp+1:(k-1)*num_samp+num_samp)=volt_vec;

end
result=result/2^14;

fclose(s)
delete(s)
clear s

read_time=toc;

end

function Ready_AWG(hObject, eventdata, handles)
global SentRabi SentDeer SentUser Seq


SentRabi=0
SentDeer=0
SentUser=0
Seq=Loop_Remaining_Structure({}, Seq, 0)


end

function CreateInfiniteSeq(name,DC,AMP)
global samples buffer

DC_Ch1 = DC(1);
DC_Ch2 = DC(2);
DC_Ch3 = DC(3);
DC_Ch4 = DC(4);
AMPL_Ch1= AMP(1);
AMPL_Ch2= AMP(2);
AMPL_Ch3= AMP(3);
AMPL_Ch4= AMP(4);
High_Mk= AMP(5);
    
%%%%%% Initialize Instrument %%%%%%
visa_vendor = 'ni';
visa_address = 'TCPIP::136.152.250.165::INSTR';
buffer = 2 * 1024;
awg = visa(visa_vendor,visa_address,'InputBufferSize',buffer, ...
    'OutputBufferSize',buffer); %Default buffer size is 512. AWG can do more
fopen(awg);
fwrite(awg, '*CLS');
'AWG Errors Cleared'
%go to sequence mode
fprintf(awg, '%s\n', 'AWGC:RMOD SEQ');

%write waveforms into sequence
fprintf(awg, '%s\n',['SEQ:LENG ' num2str(0)]); %Clear sequence first.
%If loading a shorter sequence than the previous, AWG doesn't run
fprintf(awg, '%s\n',['SEQ:LENG ' num2str(1)]);
kk=1
%Assign waveform to specific channels for nLoop counts in the sequence
% If no waveform of the specified name exists, the AWG simply moves on
fprintf(awg, '%s\n',['SEQ:ELEM' num2str(kk) ':WAV1 "' name 'Ch1"']); %Test with a predefined waveform
fprintf(awg, '%s\n',['SEQ:ELEM' num2str(kk) ':WAV2 "' name 'Ch2"']);
fprintf(awg, '%s\n',['SEQ:ELEM' num2str(kk) ':WAV3 "' name 'Ch3"']);
fprintf(awg, '%s\n',['SEQ:ELEM' num2str(kk) ':WAV4 "' name 'Ch4"']);
fprintf(awg, '%s\n',['SEQ:ELEM' num2str(kk) ':LOOP:INFINITE ' num2str(1)]);
%Number of times to loop element is max 65536 if you don't hit the
%waveform memory limit first
%fwrite(awg,['SEQ:ELEM' num2str(kk) ':GOTO:STAT 0']) %% Turns off the ability of the GoTo:Index to take effect for this element

%Debugging
'ESR and error upon assigning waveforms'
fprintf(awg,'%s\n','*ESR?'); 
fscanf(awg,'%s')
fprintf(awg,'%s\n','SYST:ERR?'); 
fscanf(awg,'%s')
%End Debugging

%fwrite(awg,['SEQ:ELEM' num2str(loop_standard) ':GOTO:STAT 1']) %%Turns on the GoTo:Index ability for the last element in the sequence
%fwrite(awg,['SEQ:ELEM' num2str(loop_standard) ':GOTO:IND 1']) %%Goes to the first index (index 1) in the last element of the sequence

%%%%%% DC offset %%%%%% 
fwrite(awg,['sour1:volt:offs ' num2str(DC_Ch1)])
fwrite(awg,['sour2:volt:offs ' num2str(DC_Ch2)])
fwrite(awg,['sour3:volt:offs ' num2str(DC_Ch3)])
fwrite(awg,['sour4:volt:offs ' num2str(DC_Ch4)])

%%%%%% amp %%%%%% 
fwrite(awg,['sour1:volt:ampl ' num2str(AMPL_Ch1)])
fwrite(awg,['sour2:volt:ampl ' num2str(AMPL_Ch2)])
fwrite(awg,['sour3:volt:ampl ' num2str(AMPL_Ch3)])
fwrite(awg,['sour4:volt:ampl ' num2str(AMPL_Ch4)])
fwrite(awg,['sour1:mark1:volt:high ' num2str(High_Mk)])
fwrite(awg,['sour1:mark2:volt:high ' num2str(High_Mk)])
fwrite(awg,['sour2:mark1:volt:high ' num2str(High_Mk)])
fwrite(awg,['sour2:mark2:volt:high ' num2str(High_Mk)])
fwrite(awg,['sour3:mark1:volt:high ' num2str(High_Mk)])
fwrite(awg,['sour3:mark2:volt:high ' num2str(High_Mk)])
fwrite(awg,['sour4:mark1:volt:high ' num2str(High_Mk)])
fwrite(awg,['sour4:mark2:volt:high ' num2str(High_Mk)])


for i = (1:10)
%Debugging
'ESR and error upon assigning amplitudes'
fprintf(awg,'%s\n','*ESR?'); 
fscanf(awg,'%s')
fprintf(awg,'%s\n','SYST:ERR?'); 
fscanf(awg,'%s')
%End Debugging
end


s = ['SOURCE1:FREQUENCY' , num2str(samples),'MHz'];
fprintf(awg, '%s\n', s);

% Gracefully disconnect
fclose(awg);
delete(awg);    %delete instrument object
clear awg; 

%% Notes
%{
% The real waveform type is not a voltage, but a scaling factor.  Maximum
% value is 1 while minimum value is -1. The resulting output voltage can be
% calculated by the following formula: my_real_wfm(sample) *
% (amplitude_setting/2) + offset_setting = output_voltage
%
% The real waveform type uses 5 bytes per sample while the integer type
% uses 2 bytes.
%
% The integer type allows for the most efficient and precise control of an
% AWG
%
% The real type allows for dynamic scaling of waveform data at run-time.
% This allows for math operations or changing bits of precision (i.e. AWG5k
% (14-bit) to/from AWG7k (8-bit), AWG7k 8-bit mode to/from AWG7k 10-bit
% mode) minimal degradation of sample data.
%}
end

function SaveData(name,hObject, eventdata, handles)
%name should be a string

global gSaveData data dataParameters

%File name and prompt
file = [gSaveData.path strcat(name, gSaveData.file)];

%Prevent overwriting
mfile = strrep(file,'.txt','*');
mfilename = strrep(gSaveData.file,'.txt','');

A = ls(mfile);
ImgN = 0;
for f = 1:size(A,1)
    sImgN = sscanf(A(f,:),[name mfilename '_Data%d.txt']);
    if ~isempty(sImgN)
        if sImgN > ImgN
            ImgN = sImgN;
        end
    end
end
ImgN = ImgN + 1;
file = strrep(file,'.txt',sprintf('_Data%03d.txt',ImgN));
%Save File as Data
Sig= data.(char(name)).signal;
Ref= data.(char(name)).reference;
%CurrentVz = DAQmxFunctionPool('ReadVoltage',);
fid = fopen(file,'wt');



%Original ImageNVC code for reference
% fprintf(fid,'VxRange in distance [um]: [%f %f] NVx:%d bFixVx:%d FixVx:%f\n',...
%     gScan.minVx/0.0076,gScan.maxVx/0.0076,gScan.NVx,gScan.bFixVx,gScan.FixVx);
% fprintf(fid,'VyRange in distance [um]: [%f %f] NVy:%d bFixVy:%d FixVy:%f\n',...
%     gScan.minVy/0.0076,gScan.maxVy/0.0076,gScan.NVy,gScan.bFixVy,gScan.FixVy);
% fprintf(fid,'VzRange: [%f %f] NVz:%d bFixVz:%d FixVz:%f\n',...
%     gScan.minVz,gScan.maxVz,gScan.NVz,gScan.bFixVz,gScan.FixVz);
% fprintf(fid,'DTRange: [%f %f] NDT:%d bFixVDT:%d FixVDT:%f\n',...
%     gScan.minDT,gScan.maxDT,gScan.NDT,gScan.bFixDT,gScan.FixDT);
fprintf(fid,[name 'Data\n']);
fprintf(fid,['Varying over' dataParameters.(char(name)).string ' with range [%d %d] and step size %d \n' dataParameters.(char(name)).string 'Vector\n'],...
    dataParameters.(char(name)).min, dataParameters.(char(name)).max, dataParameters.(char(name)).step);
fprintf(fid,'%d\t',dataParameters.(char(name)).vector);
fprintf(fid,'\nData Size: [%.0f %.0f]\n',size([Sig;Ref]));
fprintf(fid,'Signal Vector\n');
fprintf(fid,'%d\t',Sig);
fprintf(fid,'\n Reference \n');
fprintf(fid,'%d\t',Ref);
nts=get(handles.Notes,'String');
fprintf(fid,'\nNotes: %s',nts{1});
fprintf(fid,'\nTime: %s',datestr(datenum(now), 'yyyy-mm-dd_HH-MM-SS'));
fclose(fid);

end

function AWG_Debug()
%Call this function whenever you want to ask the AWG for ESR and errors
% NOTE!!!! It only works if the AWG is already fopened
%Debugging
'ESR and error upon assigning waveforms'
fprintf(awg,'%s\n','*ESR?;SYST:ERR?');
fscanf(awg,'%s')
%End Debugging

end

function Update_String(hObject, eventdata, handles)
P1Off=handles.P1_Offset.String
handles.Notes.String = P1Off;
end

function writeSweepSG(serial, startFreq, stopFreq, steps, dBm, cycles)
%This function prepares a hardware-triggered sweep on the SignalCore
%SC5511A. serial is the char-type identifier of your device ('10000EDA' is
%the one that the Yao lab owns as of 06/2016). startFreq and stopFreq are
%the beginning and end frequencies in Hz. steps is the number of steps. dBm
%is the power in dBm. cycles is the number of cycles you wish to request
%before the generator exits the sweep mode. Setting cycles=0 keeps the
%generator in the sweep mode until you reset the device to the single tone
%mode. After your sweep has completed, I suggest you call the writeSG
%function with output set to 0 to ensure that the device has exited the
%sweep mode (and thus will not be accidentally triggered thereafter).

%Note that the generator can be set to output a "handshake" trigger, either
%after each frequency change or after each sweep cycle. This can be
%modified within this function by changing
%list_mode_config.TriggerOutputEnable and
%list_mode_config.TriggerOutOnCycle.

if ~libisloaded('sg')
    loadlibrary('sc5511a_lv.dll','sc5511a_lv.h','alias','sg');
end

stepFreq=(stopFreq-startFreq)/steps;
list_mode_config.SweepList=1;
list_mode_config.Direction=0; % 0: forwards (start from startFreq, stop at stopFreq)
list_mode_config.Shape=0; % 0: frequency returns to beginning frequency upon reaching end of sweep
list_mode_config.TriggerSource=1; % 1: triggers on hardware HIGH TO LOW
list_mode_config.HWTriggerMode=1;
list_mode_config.ReturnToStart=0;
list_mode_config.TriggerOutputEnable=1;
list_mode_config.TriggerOutOnCycle=0; % 0: output after each frequency change


p=libpointer('uint32Ptr',0);
calllib('sg','Sc5511a_open_device',serial,p);
calllib('sg','Sc5511a_set_rf_mode',1,p.Value,libpointer); % triggered step mode

calllib('sg','Sc5511a_list_start_freq',floor(startFreq),p.Value,libpointer);
calllib('sg','Sc5511a_list_stop_freq',floor(stopFreq),p.Value,libpointer);
calllib('sg','Sc5511a_list_step_freq',floor(stepFreq),p.Value,libpointer);
%calllib('sg','Sc5511a_list_dwell_time',200,p.Value,libpointer);
calllib('sg','Sc5511a_list_cycle_count',cycles,p.Value,libpointer);
calllib('sg','Sc5511a_list_mode_config',list_mode_config,p.Value,libpointer);
%calllib('sg','Sc5511a_list_soft_trigger',p.Value,libpointer);

calllib('sg','Sc5511a_set_level',dBm,p.Value,libpointer);
calllib('sg','Sc5511a_set_output',1,p.Value,libpointer);

calllib('sg','Sc5511a_close_device',p.Value);
end