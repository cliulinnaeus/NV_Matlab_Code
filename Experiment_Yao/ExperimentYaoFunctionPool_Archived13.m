function ExperimentYaoFunctionPool(what,hObject, eventdata, handles)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%% Written by Thomas Mittiga, May 2016 %%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%% UC Berkeley, Berkeley , USA  %%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

global bGo 
bGo=true;

switch what
    case 'Start'
        StartUp(hObject, eventdata, handles) 
    case 'Close'
        Close(hObject, eventdata, handles)
    case 'Pi Pulse Calibrate'
        Pi_Pulse_Calibrate(hObject, eventdata, handles) 
    case 'Rabi' 
        Rabi(hObject, eventdata, handles) 
    case 'User'
        RunUser(hObject, eventdata, handles)
    case 'DC_Offsets'
        DC_Offsets(hObject, eventdata, handles)
    case 'Ready_AWG'
        Ready_AWG(hObject, eventdata, handles)
    case 'AOM_Delay'
        AOM_Delay(hObject, eventdata, handles) 
    case 'AnalyzeNV'
        AnalyzeNV(hObject, eventdata, handles)
    case 'Update String'
        Update_String(hObject, eventdata, handles) 
    case 'ESR'
        ESR(hObject, eventdata, handles) 
    case 'ODMR'
        ODMR(hObject, eventdata, handles)
    case 'Ramsey'
        Ramsey(hObject, eventdata, handles)
    case 'SpinEcho'
        SpinEcho(hObject, eventdata, handles)
    case 'CPMGN'
        CPMGN(hObject, eventdata, handles)
    case 'CPMGT'
        CPMGT(hObject, eventdata, handles)
    case 'T1'
        T1(hObject, eventdata, handles)
    case 'Sweep Parameters'
        Sweep_Parameters(hObject, eventdata, handles)
    case 'Stop'
        Stop(handles)
    otherwise
end
end

function StartUp(hObject, eventdata, handles) 

global Sent Seq samples len Readout DC_off DC Amp gSaveData gSavePlots data awg buffer dLoop_Standard dLoop_Count defH

if isempty(defH)
    'Defining Hardware'
    defHardware
end

visa_vendor = 'ni';
visa_address = 'TCPIP::136.152.250.165::INSTR';
buffer = 10^8;%2 * 1024;
awg = visa(visa_vendor,visa_address,'InputBufferSize',buffer, ...
    'OutputBufferSize',buffer);
% echotcpip('on',4000)
% awg = tcpip('136.152.250.165',4000,'InputBufferSize',buffer, ...
%      'OutputBufferSize',buffer);
fclose(awg);
fopen(awg);
fwrite(awg, '*CLS');
fprintf(awg,'%s\n','*ESR?'); %Query to ensure Matlab wait sufficiently
fscanf(awg,'%s');
fwrite(awg, 'SOUR1:ROSC:SOUR EXTERNAL;FREQ 100MHZ;*ESR?');
fscanf(awg,'%s');

OutputAWG(1,1,1,1,1)

% Define Sent to track what has been sent to AWG and assume nothing was 
%sent to the AWG today
Sent.Rabi = 0 ;
Sent.Deer = 0 ; 
Sent.User = 0 ;
Sent.ESR = 0 ;
Sent.ODMR = 0;
Sent.Ramsey = 0;
Sent.SpinEcho = 0;
Sent.CPMGN = 0;
Sent.CPMGT = 0;
Sent.Pi_Pulse_Calibrate = 0;
Sent.T1 = 0;

% Define Seq to track which sequence is loaded and assume the AWG's current 
%sequence is empty
Seq.Rabi = 0 ;
Seq.Deer = 0 ;
Seq.User = 0 ;
Seq.ESR = 0;
Seq.ODMR = 0;
Seq.Ramsey = 0;
Seq.SpinEcho = 0;
Seq.CPMGN = 0;
Seq.CPMGT = 0;
Seq.Pi_Pulse_Calibrate = 0;
Seq.T1 = 0;

samples = 1000 ;% 1000MHz sample rate of AWG

Readout = 'SPCM';

%DC offsets and low levels
DC_off.I=-0.006 ;%V
DC_off.Q=0.002 ;%V
DC.Ch1 = DC_off.I;
DC.Ch2 = DC_off.Q;
DC.Ch3 = 0; 
DC.Ch4 = 0;
DC.Mk1 = 0; %DC for markers is low level
DC.Mk2 = 0; 
DC.Mk3 = 0;
DC.Mk4 = 0;
DC.Mk5 = 0;
DC.Mk6 = 0;
DC.Mk7 = 0;
DC.Mk8 = 0;

%Amplitudes and high levels. 20mV is smallest Amplitude.
Amp.Ch1 = 1 ;%str2double(handles.Amp_I.String);
Amp.Ch2 = 1;
Amp.Ch3 = 0.05;
Amp.Ch4 = 2;
Amp.Mk1 = 2.7; %Amp for markers is high level
Amp.Mk2 = 2.7;
Amp.Mk3 = 2.7;
Amp.Mk4 = 2.7;
Amp.Mk5 = 2.7;
Amp.Mk6 = 2.7;
Amp.Mk7 = 2.7;
Amp.Mk8 = 2.7;

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

gSavePlots.path = fullPath;
%End edit

gSavePlots.file = ['Plot_' date '.fig'];
% set(handles.strFileName,'String',gSaveImg.file);

dLoop_Standard = 0; %assume no sequence is loaded on AWG
dLoop_Count = 0;

end

function Close(hObject, eventdata, handles)
global awg

OutputAWG(0,1,1,1,1)
fclose(awg);
delete(awg);
clear global awg;
        
'Devices Closed'
end

function Sweep_Parameters(hObject, eventdata, handles)

global Sent Seq samples len DC_off data dataParameters DC Amp Detector awg buffer countsExport

%Obtain AWG or MW parameter to sweep
dataParameters.Sweep_Parameters.seq=handles.Sweep_Parameters_Seq.String{handles.Sweep_Parameters_Seq.Value};
dataParameters.Sweep_Parameters.string=handles.Sweep_Parameters_String.String{handles.Sweep_Parameters_String.Value};
sweepP = dataParameters.Sweep_Parameters.string
dataParameters.Sweep_Parameters.min=str2double(handles.Sweep_Parameters_Start.String); 
dataParameters.Sweep_Parameters.max=str2double(handles.Sweep_Parameters_End.String);
dataParameters.Sweep_Parameters.step=str2double(handles.Sweep_Parameters_Step.String) ;
dataParameters.Sweep_Parameters.vector = (dataParameters.Sweep_Parameters.min:dataParameters.Sweep_Parameters.step:dataParameters.Sweep_Parameters.max);

%Which sequence to sweep
 mod = dataParameters.Sweep_Parameters.seq;
 dataParameters.(char(mod)).swept_over = dataParameters.Sweep_Parameters.string ;
 dataParameters.(char(mod)).sweep_vector = dataParameters.Sweep_Parameters.vector;
 
 for val=dataParameters.Sweep_Parameters.vector
 
     if strfind(sweepP,'DC')
         DC.(char(sweepP(4:end)))=val;
     elseif strfind(sweepP,'Amp') 
         Amp.(char(sweepP(5:end)))=val;
     elseif strfind(sweepP,'MW')
         handles.(char(sweepP)).String = val;
     elseif strfind(sweepP,'len')
         handles.(char(sweepP)).String = val;
     elseif strfind(sweepP,'Voltage_I')
         handles.(char(sweepP)).String = val;
     else
         error('No valid parameter selected')      
     end
     switch mod
         case 'Rabi'
             Rabi(hObject, eventdata, handles)
         case 'ESR'
             ESR(hObject, eventdata, handles)
         case 'ODMR'
             ODMR(hObject, eventdata, handles)
         case 'Ramsey'
             Ramsey(hObject, eventdata, handles)
         case 'Spin Echo'
             Spin_Echo(hObject, eventdata, handles)
         case 'CPMGN'
             CPMGN(hObject, eventdata, handles)
         case 'CPMGT'
             CPMGT(hObject, eventdata, handles)
         case 'User'
             RunUser(hObject, eventdata, handles)
     end
 end

end

function Pi_Pulse_Calibrate(hObject, eventdata, handles) 
global Sent Seq samples len DC_off Pi_Pulse_Calibrate data dataParameters DC Amp Detector awg buffer countsExport bGo

% Clear detector
clearFPGA()

%Define Pi_Pulse_Calibrate Parameters
if handles.Pi_Pulse_I.Value
    dataParameters.Pi_Pulse_Calibrate.string='I-port Amplitude (V)';
elseif handles.Pi_Pulse_Q.Value
    dataParameters.Pi_Pulse_Calibrate.string='Q-port Amplitude (V)';
else
    error('Pi Pulse Port Radio Buttons Broken')
end
dataParameters.Pi_Pulse_Calibrate.min=str2double(handles.Pi_Pulse_Amplitude_Start.String); 
dataParameters.Pi_Pulse_Calibrate.max=str2double(handles.Pi_Pulse_Amplitude_End.String);
dataParameters.Pi_Pulse_Calibrate.step=str2double(handles.Pi_Pulse_Amplitude_Step.String) ;
dataParameters.Pi_Pulse_Calibrate.freq = floor(str2double(handles.MW_Freq.String)*10^9);
dataParameters.Pi_Pulse_Calibrate.length = str2double(handles.MW_Pi_Pulse.String);
dataParameters.Pi_Pulse_Calibrate.number = floor(str2double(handles.Pi_Pulse_Number.String));
dataParameters.Pi_Pulse_Calibrate.vector=(dataParameters.Pi_Pulse_Calibrate.min:dataParameters.Pi_Pulse_Calibrate.step:(dataParameters.Pi_Pulse_Calibrate.max));%%%Make sure MWLength does not force waveforms to be longer than the

loop_Standard = str2double(handles.Loop_Standard.String) ;
loop_Count = str2double(handles.Loop_Count.String) ;
if loop_Count>65000
   loop_Count=65000;
   disp('Loop Counts too high. Set to 65000')
end

TrackNV(hObject, eventdata)
Count = countsExport; %Counts per second Update from ImageNVC
TheoreticalThreshold = 0.9*(3*100^-9)*loop_Standard*loop_Count*Count; %A reference data point should be around 30k counts for 10^6 measurements

number=dataParameters.Pi_Pulse_Calibrate.number;
MWLength = dataParameters.Pi_Pulse_Calibrate.length ; % MW length set to Pi pulse
len.Pi_Pulse_Calibrate = ceil((4050+number*(MWLength+20)+1101+2000+300+500+1000)*10^-3); %length of waveform in us
lenSweep=length(dataParameters.Pi_Pulse_Calibrate.vector);
ancillaSig=zeros(1,lenSweep);
ancillaRef=zeros(1,lenSweep);
data.Pi_Pulse_Calibrate.signal=ancillaSig;
data.Pi_Pulse_Calibrate.reference=ancillaRef;

writeSG('10000EDA', dataParameters.Pi_Pulse_Calibrate.freq, str2double(handles.MW_Power.String), 1)

i=1;
warning = 0;
warningVISA= 0;
%Initialize SG and Detector


while i <= length(dataParameters.Pi_Pulse_Calibrate.vector) && bGo
    
    portAmp = dataParameters.Pi_Pulse_Calibrate.vector(i);
    
    disp(' ')
    disp('--- Sending Pi_Pulse_Calibrate to AWG')
    %Pi_Pulse_Calibrate Sequence is simply Rabi sequence with a fixed MW Length
    AWG_Measure_Pi_Pulse_Calibrate(MWLength,number,portAmp,handles); %MWLength Set to Pi Pulse
    Pi_Pulse_Calibrate=GenAWGWF(Pi_Pulse_Calibrate,samples,len.Pi_Pulse_Calibrate);
    Plot_AWG_Sequence(Pi_Pulse_Calibrate,handles)
    Sent.Pi_Pulse_Calibrate=SendWF2AWG(samples, len.Pi_Pulse_Calibrate, Pi_Pulse_Calibrate, struct,'Pi_Pulse_Calibrate');
    
    
    disp(' ')
    disp('--- Setting AWG sequence to Pi_Pulse_Calibrate')
    CreateSeq(loop_Standard,loop_Count,1,'Pi_Pulse_Calibrate'); %20*50000=10^6 measurements
    Seq.Pi_Pulse_Calibrate=1;
    Seq=Loop_Remaining_Structure({'Pi_Pulse_Calibrate'}, Seq,0);

    disp(['Iteration ' num2str(i) ' of ' num2str(length(dataParameters.Pi_Pulse_Calibrate.vector))])
    
    fwrite(Detector, [0;1]); %FPGA in sequence mode
    RunAWG(1); %Run Sequence (FPGA collects)
    running=2; 
    runCount = 0;
    tic
    try
        pause((3+loop_Standard*loop_Count*len.Pi_Pulse_Calibrate)*10^-6)
        while running==2 && bGo
            fprintf(awg, '%s\n','AWGCONTROL:RSTATE?');
            running=str2num(fscanf(awg,'%s'));
            if isempty(running)
                warningVISA=warningVISA+1
                running = 2;
                if warningVISA >=3
                    error('Communication with AWG lost')
                end
            end
            runCount=runCount+1;
        end
    catch
        disp('VISA PROBLEM CAUGHT')
        running=2;
        while running==2 && bGo
            fprintf(awg, '%s\n','AWGCONTROL:RSTATE?');
            running=str2num(fscanf(awg,'%s'));
            if isempty(running)
                warningVISA=warningVISA+1
                running = 2;
                if warningVISA >=3
                    error('Communication with AWG lost')
                end
            end
            runCount=runCount+1;
        end
    end
    toc
    disp(['Run Count: ' num2str(runCount)])
    pause(1) %Make sure output is off
    fwrite(Detector, [0;0]); %End sequence mode
    dataTemp = fread(Detector,6); %Read data from FPGA. 
    RunAWG(0); %Turn off all outputs
    if dataTemp==0
        error('No data collected')
    end
    %initialize data vectors
    ancillaSig(i) = dataTemp(1)*65536 + dataTemp(2)*256+dataTemp(3); %Convert Signal data
    ancillaRef(i) = dataTemp(4)*65536 + dataTemp(5)*256+dataTemp(6); %Convert Reference data
    
    data.Pi_Pulse_Calibrate.signal(i)=ancillaSig(i);
    data.Pi_Pulse_Calibrate.reference(i)=ancillaRef(i);
    
    if data.Pi_Pulse_Calibrate.reference(i)>TheoreticalThreshold
        i=i+1;
        warning=0;
    else
        TrackNV(hObject,eventdata);
        while countsExport<0.9*Count %Not TheoreticalThreshold
            TrackNV(hObject,eventdata);
        end
        warning=warning+1;
        'Reference counts too low. Try again.'
        if warning>3
            error('Reference Counts Fatally Low. Experiment Halted.')
        end
    end
    
end
RunAWG(0); %Turn off all outputs
writeSG('10000EDA', dataParameters.Pi_Pulse_Calibrate.freq, str2double(handles.MW_Power.String), 0)
% %initialize data vectors
% ancillaSig(i) = dataTemp(1)*65536 + dataTemp(2)*256+dataTemp(3); %Convert Signal data
% ancillaRef(i) = dataTemp(4)*65536 + dataTemp(5)*256+dataTemp(6); %Convert Reference data
% data.Pi_Pulse_Calibrate.signal(i)=ancillaSig(i);
% data.Pi_Pulse_Calibrate.reference(i)=ancillaRef(i);

Plot_Data('Pi_Pulse_Calibrate',handles)
Pi_Pulse_Calibratefit(handles)
SaveData('Pi_Pulse_Calibrate',hObject, eventdata, handles);
saveFig('Pi_Pulse_Calibrate',handles);

end

function Rabi(hObject, eventdata, handles)

global Sent Seq samples len DC_off Rabi data dataParameters DC Amp Detector awg buffer countsExport bGo

% Clear detector
clearFPGA()

%Define Rabi Parameters
if handles.Rabi_I.Value
    dataParameters.Rabi.string='I-port MW Length (V)';
elseif handles.Rabi_Q.Value
    dataParameters.Rabi.string='Q-port MW Length (V)';
else
    error('Rabi Port Radio Buttons Broken')
end

dataParameters.Rabi.min=str2double(handles.Rabi_Start.String); 
dataParameters.Rabi.max=str2double(handles.Rabi_End.String);
dataParameters.Rabi.step=str2double(handles.Rabi_Step.String) ;
dataParameters.Rabi.freq = floor(str2double(handles.MW_Freq.String)*10^9);
writeSG('10000EDA', dataParameters.Rabi.freq, str2double(handles.MW_Power.String), 1)

% Chong/Satcher changed this, 08/10/2016
dataParameters.Rabi.vector=(dataParameters.Rabi.min:dataParameters.Rabi.step:(dataParameters.Rabi.max));%%%Make sure MWLength does not force waveforms to be longer than the
%%%input length to Wave_generator
len.Rabi = 12; %length of waveform in us

loop_Standard = str2double(handles.Loop_Standard.String) ;
loop_Count = str2double(handles.Loop_Count.String) ;
if loop_Count>65000
   loop_Count=65000;
   disp('Loop Counts too high. Set to 65000')
end
TrackNV(hObject, eventdata)
Count = countsExport; %1.08*10^5; %Counts per second Update from ImageNVC
TheoreticalThreshold = 0.9*(300*10^-9)*loop_Standard*loop_Count*Count; %A reference data point should be around 30k counts for 10^6 measurements

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
%     fprintf(awg, '%s\n','AWGCONTROL:RSTATE?');
%     running=str2num(fscanf(awg,'%s'));
% end
% pause(1) %Make sure output is off
% OutputAWG(0,1,1,1,0); %Turn off all outputs
% %%%End Infinite Sequence


ancillaSig=zeros(1,length(dataParameters.Rabi.vector));
ancillaRef=zeros(1,length(dataParameters.Rabi.vector));
data.Rabi.signal=ancillaSig;
data.Rabi.reference=ancillaRef;

i=1;
warning=0;
warningVISA = 0;
while i<=length(dataParameters.Rabi.vector) && bGo
    
    MWLength = dataParameters.Rabi.vector(i);
    disp(' ')
    disp('--- Sending Rabi to AWG')
    AWG_Measure_Rabi(MWLength,dataParameters.Rabi.max,handles);
    %Rabi=GenAWGWF(Rabi,samples,len.rabi); %Convert to a form AWG accepts
    Rabi=GenAWGWF(Rabi,samples,len.Rabi);
    Plot_AWG_Sequence(Rabi,handles)
    
    Sent.Rabi=SendWF2AWG(samples, len.Rabi, Rabi, struct,'Rabi');
    
    
    disp(' ')
    disp('--- Setting AWG sequence to Rabi')
    CreateSeq(loop_Standard,loop_Count,1,'Rabi'); %20*50000=10^6 measurements
    %CreateInfiniteSeq('Rabi_Delay',DC,Amp)
    % CreateSUBSeq(subLen,1,1,'Rabi');
    % CreateSeq_from_SUB(20,5000,1,'Rabi',DC,Amp);
    %Mark that Rabi is currently loaded on AWG
    
    
    strcat('Iteration', num2str(i), 'of', num2str(length(dataParameters.Rabi.vector)))
    fwrite(Detector, [0;1]); %FPGA in sequence mode
    RunAWG(1); %Run Sequence (FPGA collects)
    running=2; 
    runCount = 0;
    tic
    try
        pause((3+loop_Standard*loop_Count*len.Rabi)*10^-6)
        while running==2 && bGo
            fprintf(awg, '%s\n','AWGCONTROL:RSTATE?');
            running=str2num(fscanf(awg,'%s'));
            if isempty(running)
                warningVISA=warningVISA+1
                running = 2;
                if warningVISA >=3
                    error('Communication with AWG lost')
                end
            end
            runCount=runCount+1;
        end
    catch
        disp('VISA PROBLEM CAUGHT')
        running=2;
        while running==2 && bGo
            fprintf(awg, '%s\n','AWGCONTROL:RSTATE?');
            running=str2num(fscanf(awg,'%s'));
            if isempty(running)
                warningVISA=warningVISA+1
                running = 2;
                if warningVISA >=3
                    error('Communication with AWG lost')
                end
            end
            runCount=runCount+1;
        end
    end
    toc
    disp(['Run Count: ' num2str(runCount)])
    pause(1) %Make sure output is off
    fwrite(Detector, [0;0]); %End sequence mode
    dataTemp = fread(Detector,6); %Read data from FPGA. 
    RunAWG(0); %Turn off all outputs
    if dataTemp==0
        error('No data collected')
    end
    %initialize data vectors
    ancillaSig(i) = dataTemp(1)*65536 + dataTemp(2)*256+dataTemp(3); %Convert Signal data
    ancillaRef(i) = dataTemp(4)*65536 + dataTemp(5)*256+dataTemp(6); %Convert Reference data
    
    data.Rabi.signal(i)=ancillaSig(i);
    data.Rabi.reference(i)=ancillaRef(i);
    
    if data.Rabi.reference(i)>TheoreticalThreshold
        i=i+1;
        warning=0;
    else
        TrackNV(hObject,eventdata);
        while countsExport<0.9*Count %Not TheoreticalThreshold
            TrackNV(hObject,eventdata);
        end
        warning=warning+1;
        'Reference counts too low. Try again.'
        if warning>3
            error('Reference Counts Fatally Low. Experiment Halted.')
        end
    end
    
end
writeSG('10000EDA', 2.87*10^9, 0, 0)
Plot_Data('Rabi',handles)
Rabifit(handles)
SaveData('Rabi',hObject, eventdata, handles);
saveFig('Rabi',handles);

end

function ESR(hObject, eventdata, handles)

global Sent Seq samples len DC_off ESR data dataParameters DC Amp Detector awg buffer countsExport bGo

% Clear detector
clearFPGA()

%Define Rabi Parameters
dataParameters.ESR.string='MW Frequency';
dataParameters.ESR.min=str2double(handles.ESR_Start.String)*10^9 ;
dataParameters.ESR.max=str2double(handles.ESR_End.String)*10^9 ;
dataParameters.ESR.step=str2double(handles.ESR_Step.String)*10^9 ;
dataParameters.ESR.vector=(dataParameters.ESR.min:dataParameters.ESR.step:dataParameters.ESR.max);
dataParameters.ESR.power=str2double(handles.ESR_MWPower.String) ;
if dataParameters.ESR.power>-10
    'Warning: ESR power too high. Set to -10dBm'
    dataParameters.ESR.power=-10;
end
len.ESR = 4 ; %length of waveform in us
MWLength = str2double(handles.MW_Pi_Pulse.String) ; % MW length set to Pi pulse

loop_Standard = 20;
loop_Count = 50000;
if loop_Count>65000
   loop_Count=65000;
   disp('Loop Counts too high. Set to 65000')
end
TrackNV(hObject, eventdata)
Count = countsExport; %Counts per second Update from ImageNVC
TheoreticalThreshold = 0.9*(3*100^-9)*loop_Standard*loop_Count*Count; %A reference data point should be around 30k counts for 10^6 measurements


lenSweep=length(dataParameters.ESR.vector);
ancillaSig=zeros(1,lenSweep);
ancillaRef=zeros(1,lenSweep);
data.ESR.signal=ancillaSig;
data.ESR.reference=ancillaRef;


disp(' ')
disp('--- Sending ESR to AWG')
%ESR Sequence is simply Rabi sequence with a fixed MW Length
AWG_Measure_ESR(MWLength,handles); %MWLength Set to Pi Pulse
ESR=GenAWGWF(ESR,samples,len.ESR);
Plot_AWG_Sequence(ESR,handles)
Sent.ESR=SendWF2AWG(samples, len.ESR, ESR, struct,'ESR');


disp(' ')
disp('--- Setting AWG sequence to ESR')
CreateInfiniteSeq('ESR')
Seq.ESR=1;
Seq=Loop_Remaining_Structure({'ESR'}, Seq,0);
RunAWG(1);
i=1;
warning = 0;

%Initialize SG and Detector


while i <= length(dataParameters.ESR.vector) && bGo
    ['Iteration ' num2str(i) ' of ' num2str(length(dataParameters.ESR.vector))]
    freq = floor(dataParameters.ESR.vector(i));
    writeSG('10000EDA', freq, dataParameters.ESR.power, 1)
    
    read=0;
    for j=1:10
        writeCounter(Detector, 'count',0.08);
        readTemp= readCounter(Detector,0.08,1, 'count');
        read=read+readTemp;
    end
    data.ESR.signal(i) = read ;  %Read data from FPGA.
    
    if read==0
        writeSG('10000EDA', freq, dataParameters.ESR.power, 0)
        error('No data collected')
    end
    i=i+1;
    
end
RunAWG(0); %Turn off all outputs
writeSG('10000EDA', freq, dataParameters.ESR.power, 0)

Plot_Data('ESR',handles)
ESRfit(handles)
SaveData('ESR',hObject, eventdata, handles);
saveFig('ESR',handles);


end

function ODMR(hObject, eventdata, handles)

global Sent Seq samples len DC_off ODMR data dataParameters DC Amp Detector awg buffer countsExport bGo

% Clear detector
clearFPGA()

%Define Rabi Parameters
dataParameters.ODMR.string='MW Frequency';
dataParameters.ODMR.min=floor(str2double(handles.ODMR_Start.String)*10^9) ; %frequency in GHz
dataParameters.ODMR.max=floor(str2double(handles.ODMR_End.String)*10^9) ;
dataParameters.ODMR.step=floor(str2double(handles.ODMR_Step.String)*10^9) ;
dataParameters.ODMR.vector=(dataParameters.ODMR.min:dataParameters.ODMR.step:(dataParameters.ODMR.max));%%%Make sure MWLength does not force waveforms to be longer than the
dataParameters.ODMR.piPulse = str2double(handles.MW_Pi_Pulse.String) ; % in ns
dataParameters.ODMR.MWPower = str2double(handles.MW_Power.String); % SG power in dBm

writeSG('10000EDA', dataParameters.ODMR.min, dataParameters.ODMR.MWPower, 1);
%%%input length to Wave_generator
len.ODMR = 12; %length of waveform in us

loop_Standard = str2double(handles.Loop_Standard.String) ;
loop_Count = str2double(handles.Loop_Count.String) ;
if loop_Count>65000
   loop_Count=65000;
   disp('Loop Counts too high. Set to 65000')
end
TrackNV(hObject, eventdata)
Count = countsExport; %1.08*10^5; %Counts per second Update from ImageNVC
TheoreticalThreshold = 0.9*(300*10^-9)*loop_Standard*loop_Count*Count; %A reference data point should be around 30k counts for 10^6 measurements

ancillaSig=zeros(1,length(dataParameters.ODMR.vector));
ancillaRef=zeros(1,length(dataParameters.ODMR.vector));
data.ODMR.signal=ancillaSig;
data.ODMR.reference=ancillaRef;

disp(' ')
disp('--- Sending ODMR to AWG')
AWG_Measure_ODMR(dataParameters.ODMR.piPulse,handles);
%ODMR=GenAWGWF(ODMR,samples,len.rabi); %Convert to a form AWG accepts
ODMR=GenAWGWF(ODMR,samples,len.ODMR);
Plot_AWG_Sequence(ODMR,handles)

Sent.ODMR=SendWF2AWG(samples, len.ODMR, ODMR, struct,'ODMR');
    
disp(' ')
disp('--- Setting AWG sequence to ODMR')
CreateSeq(loop_Standard,loop_Count,1,'ODMR'); %20*50000=10^6 measurements
%CreateInfiniteSeq('ODMR_Delay',DC,Amp)
% CreateSUBSeq(subLen,1,1,'ODMR');
% CreateSeq_from_SUB(20,5000,1,'ODMR',DC,Amp);
%Mark that ODMR is currently loaded on AWG

i=1;
warning=0;
warningVISA = 0;
while i<=length(dataParameters.ODMR.vector) && bGo
    
    freq = dataParameters.ODMR.vector(i);
    writeSG('10000EDA', freq, dataParameters.ODMR.MWPower, 1);   
    
    strcat('Iteration', num2str(i), 'of', num2str(length(dataParameters.ODMR.vector)))
    fwrite(Detector, [0;1]); %FPGA in sequence mode
    RunAWG(1); %Run Sequence (FPGA collects)
    running=2; 
    runCount = 0;
    tic
    try
        pause(loop_Standard*loop_Count*len.ODMR*10^-6)
        while running==2 && bGo
            fprintf(awg, '%s\n','AWGCONTROL:RSTATE?');
            running=str2num(fscanf(awg,'%s'));
            if isempty(running)
                warningVISA=warningVISA+1
                running = 2;
                if warningVISA >=3
                    error('Communication with AWG lost')
                end
            end
            runCount=runCount+1;
        end
    catch
        disp('VISA PROBLEM CAUGHT')
        running=2;
        while running==2 && bGo
            fprintf(awg, '%s\n','AWGCONTROL:RSTATE?');
            running=str2num(fscanf(awg,'%s'));
            if isempty(running)
                warningVISA=warningVISA+1
                running = 2;
                if warningVISA >=3
                    error('Communication with AWG lost')
                end
            end
            runCount=runCount+1;
        end
    end
    toc
    disp(['Run Count: ' num2str(runCount)])
    pause(1) %Make sure output is off
    fwrite(Detector, [0;0]); %End sequence mode
    dataTemp = fread(Detector,6); %Read data from FPGA. 
    RunAWG(0); %Turn off all outputs
    if dataTemp==0
        error('No data collected')
    end
    %initialize data vectors
    ancillaSig(i) = dataTemp(1)*65536 + dataTemp(2)*256+dataTemp(3); %Convert Signal data
    ancillaRef(i) = dataTemp(4)*65536 + dataTemp(5)*256+dataTemp(6); %Convert Reference data
    
    data.ODMR.signal(i)=ancillaSig(i);
    data.ODMR.reference(i)=ancillaRef(i);
    
    if data.ODMR.reference(i)>TheoreticalThreshold
        i=i+1;
        warning=0;
    else
        TrackNV(hObject,eventdata);
        while countsExport<0.9*Count
            TrackNV(hObject,eventdata);
        end
        warning=warning+1;
        'Reference counts too low. Try again.'
        if warning>3
            error('Reference Counts Fatally Low. Experiment Halted.')
        end
    end
    
end
writeSG('10000EDA', freq, 0, 0)
SaveData('ODMR',hObject, eventdata, handles);
Plot_Data('ODMR',handles)
saveFig('ODMR',handles);

end

function Ramsey(hObject, eventdata, handles)

global Sent Seq samples len DC_off Ramsey data dataParameters DC Amp Detector awg buffer countsExport bGo yn

% Clear detector
clearFPGA()
% 
%Define Ramsey Parameters
dataParameters.Ramsey.string='tau';
dataParameters.Ramsey.min=str2double(handles.Ramsey_Start.String) ; %tau in ns
dataParameters.Ramsey.max=str2double(handles.Ramsey_End.String) ;
dataParameters.Ramsey.step=str2double(handles.Ramsey_Step.String) ;
dataParameters.Ramsey.vector=(dataParameters.Ramsey.min:dataParameters.Ramsey.step:(dataParameters.Ramsey.max));%%%Make sure MWLength does not force waveforms to be longer than the
dataParameters.Ramsey.rounds = str2double(handles.Rounds.String) ;
dataParameters.Ramsey.freq = floor(str2double(handles.MW_Freq.String)*10^9);
%%%input length to Wave_generator
len.Ramsey = 15; %length of waveform in us
piPulse = str2double(handles.MW_Pi_Pulse.String) ; % in ns

writeSG('10000EDA', dataParameters.Ramsey.freq, str2double(handles.MW_Power.String), 1)

loop_Standard = floor(str2double(handles.Loop_Standard.String)/dataParameters.Ramsey.rounds) ;
loop_Count = floor(str2double(handles.Loop_Count.String)) ;
if loop_Count>65000
   loop_Count=65000;
   disp('Loop Counts too high. Set to 65000')
end

%If loop_Standard and loop_Count are higher than usual, check with the
%user.
if loop_Standard*loop_Count*dataParameters.Ramsey.rounds>10^5
   tooManyIterations
   waitfor(1010)
   if ~yn
       'Abort measurement'
       return
   end
elseif loop_Standard*loop_Count == 0
    error('No iterations: Remember Loop Standard is divided by 10 and then floor-rounded')
end

TrackNV(hObject, eventdata)
Count = countsExport; %1.08*10^5; %Counts per second Update from ImageNVC
TheoreticalThreshold = 0.9*(300*10^-9)*loop_Standard*loop_Count*Count; %A reference data point should be around 30k counts for 10^6 measurements

ancillaSig=zeros(1,length(dataParameters.Ramsey.vector));
ancillaRef=zeros(1,length(dataParameters.Ramsey.vector));
data.Ramsey.signal=ancillaSig;
data.Ramsey.reference=ancillaRef;

for j = 1:dataParameters.Ramsey.rounds
    i=1;
    warning=0;
    warningVISA = 0;
    if ~bGo
        writeSG('10000EDA', 2.87*10^9, 0, 0)
        SaveData('Ramsey',hObject, eventdata, handles);
        return
    end
    while i<=length(dataParameters.Ramsey.vector) && bGo
        
        tau = dataParameters.Ramsey.vector(i);
        disp(' ')
        disp('--- Sending Ramsey to AWG')
        AWG_Measure_Ramsey(tau,dataParameters.Ramsey.max,piPulse,handles);
        %Ramsey=GenAWGWF(Ramsey,samples,len.rabi); %Convert to a form AWG accepts
        Ramsey=GenAWGWF(Ramsey,samples,len.Ramsey);
        Plot_AWG_Sequence(Ramsey,handles)
        
        Sent.Ramsey=SendWF2AWG(samples, len.Ramsey, Ramsey, struct,'Ramsey');
        
        
        disp(' ')
        disp('--- Setting AWG sequence to Ramsey')
        CreateSeq(loop_Standard,loop_Count,1,'Ramsey'); %20*50000=10^6 measurements
        %CreateInfiniteSeq('Ramsey_Delay',DC,Amp)
        % CreateSUBSeq(subLen,1,1,'Ramsey');
        % CreateSeq_from_SUB(20,5000,1,'Ramsey',DC,Amp);
        %Mark that Ramsey is currently loaded on AWG
        
        
        disp(strcat('Iteration', num2str(i), 'of', num2str(length(dataParameters.Ramsey.vector))))
        disp(strcat('For round', num2str(j), 'of', num2str(dataParameters.Ramsey.rounds)))
        fwrite(Detector, [0;1]); %FPGA in sequence mode
        RunAWG(1); %Run Sequence (FPGA collects)
        running=2;
        runCount = 0;
        tic
        try
            pause(loop_Standard*loop_Count*len.Ramsey*10^-6)
            while running==2 && bGo
                fprintf(awg, '%s\n','AWGCONTROL:RSTATE?');
                running=str2num(fscanf(awg,'%s'));
                if isempty(running)
                    warningVISA=warningVISA+1
                    running = 2;
                    if warningVISA >=3
                        error('Communication with AWG lost')
                    end
                end
                runCount=runCount+1;
            end
        catch
            disp('VISA PROBLEM CAUGHT')
            running=2;
            while running==2 && bGo
                fprintf(awg, '%s\n','AWGCONTROL:RSTATE?');
                running=str2num(fscanf(awg,'%s'));
                if isempty(running)
                    warningVISA=warningVISA+1
                    running = 2;
                    if warningVISA >=3
                        error('Communication with AWG lost')
                    end
                end
                runCount=runCount+1;
            end
        end
        toc
        disp(['Run Count: ' num2str(runCount)])
        pause(1) %Make sure output is off
        fwrite(Detector, [0;0]); %End sequence mode
        dataTemp = fread(Detector,6); %Read data from FPGA.
        RunAWG(0); %Turn off all outputs
        if dataTemp==0
            error('No data collected')
        end
        %initialize data vectors
        ancillaSig(i) = dataTemp(1)*65536 + dataTemp(2)*256+dataTemp(3); %Convert Signal data
        ancillaRef(i) = dataTemp(4)*65536 + dataTemp(5)*256+dataTemp(6); %Convert Reference data
        
        data.Ramsey.signal(i)=data.Ramsey.signal(i)+ancillaSig(i);
        data.Ramsey.reference(i)=data.Ramsey.reference(i)+ancillaRef(i);
        
        if data.Ramsey.reference(i)>TheoreticalThreshold
            i=i+1;
            warning=0;
        else
            TrackNV(hObject,eventdata);
            while countsExport<0.9*Count
                TrackNV(hObject,eventdata);
            end
            warning=warning+1;
            'Reference counts too low. Try again.'
            if warning>3
                error('Reference Counts Fatally Low. Experiment Halted.')
            end
        end
        
    end
end
writeSG('10000EDA', 2.87*10^9, 0, 0)
SaveData('Ramsey',hObject, eventdata, handles);
Plot_Data('Ramsey',handles)
saveFig('Ramsey',handles);

end

function SpinEcho(hObject, eventdata, handles)

global Sent Seq samples len DC_off SpinEcho data dataParameters DC Amp Detector awg buffer countsExport bGo yn

% Clear detector
clearFPGA()

% 
%Define SpinEcho Parameters
dataParameters.SpinEcho.string='tau';
dataParameters.SpinEcho.min=str2double(handles.Spin_Echo_Start.String) ; %tau in ns. tau is wait between first Ramsey pulse and Pi pulse
dataParameters.SpinEcho.max=str2double(handles.Spin_Echo_End.String) ;
dataParameters.SpinEcho.step=str2double(handles.Spin_Echo_Step.String) ;
dataParameters.SpinEcho.vector=(dataParameters.SpinEcho.min:dataParameters.SpinEcho.step:(dataParameters.SpinEcho.max));%%%Make sure MWLength does not force waveforms to be longer than the
dataParameters.SpinEcho.rounds = str2double(handles.Rounds.String) ;
dataParameters.SpinEcho.freq = floor(str2double(handles.MW_Freq.String)*10^9);
%%%input length to Wave_generator

tauMax = dataParameters.SpinEcho.max;
piPulse = str2double(handles.MW_Pi_Pulse.String) ; %in ns
rounds=dataParameters.SpinEcho.rounds;

writeSG('10000EDA', dataParameters.SpinEcho.freq, str2double(handles.MW_Power.String), 1)

loop_Standard = floor(str2double(handles.Loop_Standard.String)/rounds) ; % Measure each tau 0.1Million times. Then repeat 9 more times
loop_Count = str2double(handles.Loop_Count.String) ;
if loop_Count>65000
   loop_Count=65000;
   disp('Loop Counts too high. Set to 65000')
end

%If loop_Standard and loop_Count are higher than usual, check with the
%user.
if rounds*loop_Standard*loop_Count>10^6
   tooManyIterations
   waitfor(1010)
   if ~yn
       'Abort measurement'
       return
   end
elseif loop_Standard*loop_Count == 0
    error('No iterations: Remember Loop Standard is divided by 10 and then floor-rounded')
end

TrackNV(hObject, eventdata)
Count = countsExport; %1.08*10^5; %Counts per second Update from ImageNVC
TheoreticalThreshold = 0.8*(300*10^-9)*loop_Standard*loop_Count*Count %A reference data point should be around 30k counts for 10^6 measurements

% On the first run, we have to send and load all channels of the SpinEcho
% sequence

ancillaSig=zeros(1,length(dataParameters.SpinEcho.vector));
ancillaRef=zeros(1,length(dataParameters.SpinEcho.vector));
data.SpinEcho.signal=ancillaSig;
data.SpinEcho.reference=ancillaRef;

for j = 1:rounds
    i=1;
    warning=0;
    warningVISA = 0;
    if ~bGo
        writeSG('10000EDA', 2.87*10^9, 0, 0)
        SaveData('SpinEcho',hObject, eventdata, handles);
        return
    end
    while i<=length(dataParameters.SpinEcho.vector) && bGo
        warningVISA = 0;
        runCount=0;
        tau = dataParameters.SpinEcho.vector(i);
        len.SpinEcho = ceil((4154+piPulse+2*tau+piPulse+2000+300+3000)/1000); %length of waveform in us. Added 3us after reference trigger ends
        disp(' ')
        disp('--- Sending SpinEcho to AWG')
        AWG_Measure_SpinEcho(tau,dataParameters.SpinEcho.max,piPulse,handles);
        %SpinEcho=GenAWGWF(SpinEcho,samples,len.rabi); %Convert to a form AWG accepts
        SpinEcho=GenAWGWF(SpinEcho,samples,len.SpinEcho);
        Plot_AWG_Sequence(SpinEcho,handles)
        Sent.SpinEcho=SendWF2AWG(samples, len.SpinEcho, SpinEcho, struct,'SpinEcho');
        
        
        disp(' ')
        disp('--- Setting AWG sequence to SpinEcho')
        CreateSeq(loop_Standard,loop_Count,1,'SpinEcho'); %20*50000=10^6 measurements
        %CreateInfiniteSeq('SpinEcho_Delay',DC,Amp)
        % CreateSUBSeq(subLen,1,1,'SpinEcho');
        % CreateSeq_from_SUB(20,5000,1,'SpinEcho',DC,Amp);
        %Mark that SpinEcho is currently loaded on AWG
        
        disp(strcat('Iteration', num2str(i), 'of', num2str(length(dataParameters.SpinEcho.vector))))
        disp(strcat('For round', num2str(j), 'of', num2str(rounds)))
        fwrite(Detector, [0;1]); %FPGA in sequence mode
        RunAWG(1); %Run Sequence (FPGA collects)
        running=2;
        tic
        try
            pause(loop_Standard*loop_Count*len.SpinEcho*10^-6)
            while running==2 && bGo
                fprintf(awg, '%s\n','AWGCONTROL:RSTATE?');
                running=str2num(fscanf(awg,'%s'));
                if isempty(running)
                    warningVISA=warningVISA+1
                    running = 2;
                    if warningVISA >=3
                        error('Communication with AWG lost')
                    end
                end
                runCount=runCount+1;
            end
        catch
            disp('VISA PROBLEM CAUGHT')
            running=2;
            while running==2 && bGo
                fprintf(awg, '%s\n','AWGCONTROL:RSTATE?');
                running=str2num(fscanf(awg,'%s'));
                if isempty(running)
                    warningVISA=warningVISA+1
                    running = 2;
                    if warningVISA >=3
                        error('Communication with AWG lost')
                    end
                end
                runCount=runCount+1;
            end
        end
        toc
        disp(['Run Count: ' num2str(runCount)])
        pause(1) %Make sure output is off
        fwrite(Detector, [0;0]); %End sequence mode
        dataTemp = fread(Detector,6); %Read data from FPGA.
        RunAWG(0); %Turn off all outputs
        if dataTemp==0
            error('No data collected')
        end
        %initialize data vectors
        ancillaSig(i) = dataTemp(1)*65536 + dataTemp(2)*256+dataTemp(3); %Convert Signal data
        ancillaRef(i) = dataTemp(4)*65536 + dataTemp(5)*256+dataTemp(6) %Convert Reference data
        
              
        if ancillaRef(i)>TheoreticalThreshold
            i=i+1;
            warning=0;
            data.SpinEcho.signal(i)=data.SpinEcho.signal(i)+ancillaSig(i);
            data.SpinEcho.reference(i)=data.SpinEcho.reference(i)+ancillaRef(i);
        else
            TrackNV(hObject,eventdata);
            while countsExport<0.9*Count
                TrackNV(hObject,eventdata);
            end
            warning=warning+1;
            'Reference counts too low. Try again.'
            if warning>3
                error('Reference Counts Fatally Low. Experiment Halted.')
            end
        end
    
    end

end
writeSG('10000EDA', 2.87*10^9, 0, 0)
SaveData('SpinEcho',hObject, eventdata, handles);
Plot_Data('SpinEcho',handles)
saveFig('SpinEcho',handles);

end

function CPMGN(hObject, eventdata, handles)

global Sent Seq samples len DC_off CPMGN CPMG data dataParameters DC Amp Detector awg buffer countsExport bGo yn

% Clear detector
clearFPGA()

% 
%Define CPMGN Parameters
dataParameters.CPMGN.string='Number of pulses';
dataParameters.CPMGN.min=str2double(handles.CPMGN_Start.String) ; %number of pulses 
dataParameters.CPMGN.max=str2double(handles.CPMGN_End.String) ;
dataParameters.CPMGN.step=str2double(handles.CPMGN_Step.String) ;
dataParameters.CPMGN.vector=(dataParameters.CPMGN.min:dataParameters.CPMGN.step:(dataParameters.CPMGN.max));%%%Make sure MWLength does not force waveforms to be longer than the
dataParameters.CPMGN.rounds=str2double(handles.Rounds.String) ;
dataParameters.CPMGN.freq = floor(str2double(handles.MW_Freq.String)*10^9);
dataParameters.CPMGN.length = str2double(handles.CPMG_len.String) ;
rounds=dataParameters.CPMGN.rounds;
tauMax = str2double(handles.CPMGN_tau.String) ; %tau is wait between first Ramsey pulse and Pi pulse
tau = tauMax ;
piPulse = str2double(handles.MW_Pi_Pulse.String) ; %in ns

writeSG('10000EDA', dataParameters.CPMGN.freq, str2double(handles.MW_Power.String), 1)

loop_Standard = floor(str2double(handles.Loop_Standard.String)/rounds) ; % Measure each tau 0.1Million times. Then repeat 9 more times
loop_Count = str2double(handles.Loop_Count.String) ;
if loop_Count>65000
   loop_Count=65000;
   disp('Loop Counts too high. Set to 65000')
end

%If loop_Standard and loop_Count are higher than usual, check with the
%user.
if rounds*loop_Standard*loop_Count>10^6
   tooManyIterations
   waitfor(1010)
   if ~yn
       'Abort measurement'
       return
   end
elseif loop_Standard*loop_Count == 0
    error('No iterations: Remember Loop Standard is divided by 10 and then floor-rounded')
end

TrackNV(hObject, eventdata)
Count = countsExport; %1.08*10^5; %Counts per second Update from ImageNVC
TheoreticalThreshold = 0.8*(300*10^-9)*loop_Standard*loop_Count*Count; %A reference data point should be around 30k counts for 10^6 measurements

ancillaSig=zeros(1,length(dataParameters.CPMGN.vector));
ancillaRef=zeros(1,length(dataParameters.CPMGN.vector));
data.CPMGN.signal=ancillaSig;
data.CPMGN.reference=ancillaRef;

for j = 1:rounds
    i=1;
    warning=0;
    warningVISA = 0;
    if ~bGo
        writeSG('10000EDA', 2.87*10^9, 0, 0)
        SaveData('CPMGN',hObject, eventdata, handles);
        return
    end
    while i<=length(dataParameters.CPMGN.vector) && bGo
        warningVISA = 0;
        n = dataParameters.CPMGN.vector(i);
        %%%input length to Wave_generator defined in AWG_Measure_CPMG
        disp(' ')
        disp('--- Sending CPMGN to AWG')
        AWG_Measure_CPMG(n, tau,tauMax,piPulse,handles);
        %CPMGN=GenAWGWF(CPMGN,samples,len.rabi); %Convert to a form AWG accepts
        CPMGN=GenAWGWF(CPMG,samples,len.CPMG);
        Plot_AWG_Sequence(CPMGN,handles)
        Sent.CPMGN=SendWF2AWG(samples, len.CPMG, CPMGN, struct,'CPMGN');
        
        
        disp(' ')
        disp('--- Setting AWG sequence to CPMGN')
        CreateSeq(loop_Standard,loop_Count,1,'CPMGN'); %20*50000=10^6 measurements
        %CreateInfiniteSeq('CPMGN_Delay',DC,Amp)
        % CreateSUBSeq(subLen,1,1,'CPMGN');
        % CreateSeq_from_SUB(20,5000,1,'CPMGN',DC,Amp);
        %Mark that CPMGN is currently loaded on AWG
        
        
        disp(strcat('Iteration', num2str(i), 'of', num2str(length(dataParameters.CPMGN.vector))))
        disp(strcat('For round', num2str(j), 'of', num2str(rounds)))
        fwrite(Detector, [0;1]); %FPGA in sequence mode
        RunAWG(1); %Run Sequence (FPGA collects)
        running=2;
        tic
        try
            pause(loop_Standard*loop_Count*len.CPMG*10^-6)
            while running==2 && bGo
                fprintf(awg, '%s\n','AWGCONTROL:RSTATE?');
                running=str2num(fscanf(awg,'%s'));
                if isempty(running)
                    warningVISA=warningVISA+1
                    running = 2;
                    if warningVISA >=3
                        error('Communication with AWG lost')
                    end
                end
                runCount=runCount+1;
            end
        catch
            disp('VISA PROBLEM CAUGHT')
            running=2;
            while running==2 && bGo
                fprintf(awg, '%s\n','AWGCONTROL:RSTATE?');
                running=str2num(fscanf(awg,'%s'));
                if isempty(running)
                    warningVISA=warningVISA+1
                    running = 2;
                    if warningVISA >=3
                        error('Communication with AWG lost')
                    end
                end
                runCount=runCount+1;
            end
        end
        toc
        disp(['Run Count: ' num2str(runCount)])
        pause(1) %Make sure output is off
        fwrite(Detector, [0;0]); %End sequence mode
        dataTemp = fread(Detector,6); %Read data from FPGA.
        RunAWG(0); %Turn off all outputs
        if dataTemp==0
            error('No data collected')
        end
        %initialize data vectors
        ancillaSig(i) = dataTemp(1)*65536 + dataTemp(2)*256+dataTemp(3); %Convert Signal data
        ancillaRef(i) = dataTemp(4)*65536 + dataTemp(5)*256+dataTemp(6); %Convert Reference data
        
        data.CPMGN.signal(i)=data.CPMGN.signal(i)+ancillaSig(i);
        data.CPMGN.reference(i)=data.CPMGN.reference(i)+ancillaRef(i);
        
        if data.CPMGN.reference(i)>TheoreticalThreshold
            i=i+1;
            warning=0;
        else
            TrackNV(hObject,eventdata);
            while countsExport<0.9*Count
                TrackNV(hObject,eventdata);
            end
            warning=warning+1;
            'Reference counts too low. Try again.'
            if warning>3
                error('Reference Counts Fatally Low. Experiment Halted.')
            end
        end
    
end

end
writeSG('10000EDA', 2.87*10^9, 0, 0)
SaveData('CPMGN',hObject, eventdata, handles);
Plot_Data('CPMGN',handles)
saveFig('CPMGN',handles);

end

function CPMGT(hObject, eventdata, handles)

global Sent Seq samples len DC_off CPMGT CPMG data dataParameters DC Amp Detector awg buffer countsExport bGo yn

% Clear detector
clearFPGA()

% 
%Define CPMGT Parameters
dataParameters.CPMGT.string='tau';
dataParameters.CPMGT.min=str2double(handles.CPMGT_Start.String) ; % tau in ns. tau is wait between first Ramsey pulse and Pi pulse
dataParameters.CPMGT.max=str2double(handles.CPMGT_End.String) ;
dataParameters.CPMGT.step=str2double(handles.CPMGT_Step.String) ;
dataParameters.CPMGT.vector=(dataParameters.CPMGT.min:dataParameters.CPMGT.step:(dataParameters.CPMGT.max));%%%Make sure MWLength does not force waveforms to be longer than the
dataParameters.CPMGT.rounds=str2double(handles.Rounds.String) ;
dataParameters.CPMGT.freq = floor(str2double(handles.MW_Freq.String)*10^9);
dataParameters.CPMGT.length = str2double(handles.CPMG_len.String) ;

tauMax = dataParameters.CPMGT.max ;
n = str2double(handles.CPMGT_n.String) ;
piPulse = str2double(handles.MW_Pi_Pulse.String) ; %in ns
rounds=dataParameters.CPMGT.rounds;
writeSG('10000EDA', dataParameters.CPMGT.freq, str2double(handles.MW_Power.String), 1)

loop_Standard = floor(str2double(handles.Loop_Standard.String)/rounds) ; % Measure each tau 0.1Million times. Then repeat 9 more times
loop_Count = str2double(handles.Loop_Count.String) ;
if loop_Count>65000
   loop_Count=65000;
   disp('Loop Counts too high. Set to 65000')
end

%If loop_Standard and loop_Count are higher than usual, check with the
%user.
if rounds*loop_Standard*loop_Count>10^6
   tooManyIterations
   waitfor(1010)
   if ~yn
       'Abort measurement'
       return
   end
elseif loop_Standard*loop_Count == 0
    error('No iterations: Remember Loop Standard is divided by 10 and then floor-rounded')
end

TrackNV(hObject, eventdata)
Count = countsExport; %1.08*10^5; %Counts per second Update from ImageNVC
TheoreticalThreshold = 0.9*(300*10^-9)*loop_Standard*loop_Count*Count; %A reference data point should be around 30k counts for 10^6 measurements

ancillaSig=zeros(1,length(dataParameters.CPMGT.vector));
ancillaRef=zeros(1,length(dataParameters.CPMGT.vector));
data.CPMGT.signal=ancillaSig;
data.CPMGT.reference=ancillaRef;

for j = 1:rounds
    i=1;
    warning=0;
    warningVISA = 0;
    if ~bGo
        writeSG('10000EDA', 2.87*10^9, 0, 0)
        SaveData('CPMGT',hObject, eventdata, handles);
        return
    end
    while i<=length(dataParameters.CPMGT.vector) && bGo
        
        warningVISA = 0;
        tau = dataParameters.CPMGT.vector(i);
        disp(' ')
        disp('--- Sending CPMGT to AWG')
        AWG_Measure_CPMG(n, tau,tauMax,piPulse,handles);
        %CPMGT=GenAWGWF(CPMGT,samples,len.rabi); %Convert to a form AWG accepts
        CPMGT=GenAWGWF(CPMG,samples,len.CPMG);
        Plot_AWG_Sequence(CPMGT,handles)

        Sent.CPMGT=SendWF2AWG(samples, len.CPMG, CPMGT, struct,'CPMGT');
        
        
        disp(' ')
        disp('--- Setting AWG sequence to CPMGT')
        CreateSeq(loop_Standard,loop_Count,1,'CPMGT'); %20*50000=10^6 measurements
        %CreateInfiniteSeq('CPMGT_Delay',DC,Amp)
        % CreateSUBSeq(subLen,1,1,'CPMGT');
        % CreateSeq_from_SUB(20,5000,1,'CPMGT',DC,Amp);
        %Mark that CPMGT is currently loaded on AWG
        
        
        disp(strcat('Iteration', num2str(i), 'of', num2str(length(dataParameters.CPMGT.vector))))
        disp(strcat('For round', num2str(j), 'of', num2str(rounds)))
        fwrite(Detector, [0;1]); %FPGA in sequence mode
        RunAWG(1); %Run Sequence (FPGA collects)
        running=2;
        tic
        try
            pause(loop_Standard*loop_Count*len.CPMG*10^-6)
            while running==2 && bGo
                fprintf(awg, '%s\n','AWGCONTROL:RSTATE?');
                running=str2num(fscanf(awg,'%s'));
                if isempty(running)
                    warningVISA=warningVISA+1
                    running = 2;
                    if warningVISA >=3
                        error('Communication with AWG lost')
                    end
                end
                runCount=runCount+1;
            end
        catch
            disp('VISA PROBLEM CAUGHT')
            running=2;
            while running==2 && bGo
                fprintf(awg, '%s\n','AWGCONTROL:RSTATE?');
                running=str2num(fscanf(awg,'%s'));
                if isempty(running)
                    warningVISA=warningVISA+1
                    running = 2;
                    if warningVISA >=3
                        error('Communication with AWG lost')
                    end
                end
                runCount=runCount+1;
            end
        end
        toc
        disp(['Run Count: ' num2str(runCount)])
        pause(1) %Make sure output is off
        fwrite(Detector, [0;0]); %End sequence mode
        dataTemp = fread(Detector,6); %Read data from FPGA.
        RunAWG(0); %Turn off all outputs
        if dataTemp==0
            error('No data collected')
        end
        %initialize data vectors
        ancillaSig(i) = dataTemp(1)*65536 + dataTemp(2)*256+dataTemp(3); %Convert Signal data
        ancillaRef(i) = dataTemp(4)*65536 + dataTemp(5)*256+dataTemp(6); %Convert Reference data
        
        data.CPMGT.signal(i)=data.CPMGT.signal(i)+ancillaSig(i);
        data.CPMGT.reference(i)=data.CPMGT.reference(i)+ancillaRef(i);
        
        if data.CPMGT.reference(i)>TheoreticalThreshold
            i=i+1;
            warning=0;
        else
            TrackNV(hObject,eventdata);
            while countsExport<0.9*Count
                TrackNV(hObject,eventdata);
            end
            warning=warning+1;
            'Reference counts too low. Try again.'
            if warning>3
                error('Reference Counts Fatally Low. Experiment Halted.')
            end
        end
    
end

end
writeSG('10000EDA', 2.87*10^9, 0, 0)
SaveData('CPMGT',hObject, eventdata, handles);
Plot_Data('CPMGT',handles)
saveFig('CPMGT',handles);

end

function T1(hObject, eventdata, handles)

global Sent Seq samples len DC_off T1 data dataParameters DC Amp Detector awg buffer countsExport bGo

% Clear detector
clearFPGA()

%Define T1 Parameters
if handles.T1_m1.Value
    dataParameters.T1.state = '|-1>' ;
elseif handles.T1_0.Value
    dataParameters.T1.state = '|0>' ;
else
    error('T1 Radio Buttons Broken')
end
dataParameters.T1.string='Wait';
dataParameters.T1.min=str2double(handles.T1_Start.String); 
dataParameters.T1.max=str2double(handles.T1_End.String);
dataParameters.T1.step=str2double(handles.T1_Step.String) ;
dataParameters.T1.freq = floor(str2double(handles.MW_Freq.String)*10^9);
writeSG('10000EDA', dataParameters.T1.freq, str2double(handles.MW_Power.String), 1)
dataParameters.T1.vector=(dataParameters.T1.min:dataParameters.T1.step:(dataParameters.T1.max));%%%Make sure MWLength does not force waveforms to be longer than the
len.T1 = 12; %length of waveform in us
piPulse = str2double(handles.MW_Pi_Pulse.String) ; %in ns

loop_Standard = str2double(handles.Loop_Standard.String) ;
loop_Count = str2double(handles.Loop_Count.String) ;
if loop_Count>65000
   loop_Count=65000;
   disp('Loop Counts too high. Set to 65000')
end
TrackNV(hObject, eventdata)
Count = countsExport; %1.08*10^5; %Counts per second Update from ImageNVC
TheoreticalThreshold = 0.9*(300*10^-9)*loop_Standard*loop_Count*Count; %A reference data point should be around 30k counts for 10^6 measurements

ancillaSig=zeros(1,length(dataParameters.T1.vector));
ancillaRef=zeros(1,length(dataParameters.T1.vector));
data.T1.signal=ancillaSig;
data.T1.reference=ancillaRef;

i=1;
warning=0;
warningVISA = 0;
while i<=length(dataParameters.T1.vector) && bGo
    
    waiting = dataParameters.T1.vector(i);
    disp(' ')
    disp('--- Sending T1 to AWG')
    AWG_Measure_T1(waiting,dataParameters.T1.max,piPulse,handles);
    %T1=GenAWGWF(T1,samples,len.rabi); %Convert to a form AWG accepts
    T1=GenAWGWF(T1,samples,len.T1);
    Plot_AWG_Sequence(T1,handles)
    
    Sent.T1=SendWF2AWG(samples, len.T1, T1, struct,'T1');
    
    
    disp(' ')
    disp('--- Setting AWG sequence to T1')
    CreateSeq(loop_Standard,loop_Count,1,'T1'); %20*50000=10^6 measurements
    %CreateInfiniteSeq('T1_Delay',DC,Amp)
    % CreateSUBSeq(subLen,1,1,'T1');
    % CreateSeq_from_SUB(20,5000,1,'T1',DC,Amp);
    %Mark that T1 is currently loaded on AWG
    
    
    strcat('Iteration', num2str(i), 'of', num2str(length(dataParameters.T1.vector)))
    fwrite(Detector, [0;1]); %FPGA in sequence mode
    RunAWG(1); %Run Sequence (FPGA collects)
    running=2; 
    while running==2 && bGo
        fprintf(awg, '%s\n','AWGCONTROL:RSTATE?');
        running=str2num(fscanf(awg,'%s'));
        if isempty(running)
            warningVISA=warningVISA+1;
            running = 2;
            if warningVISA >=3
                error('Communication with AWG lost')
            end
        end
    end
    pause(1) %Make sure output is off
    fwrite(Detector, [0;0]); %End sequence mode
    dataTemp = fread(Detector,6); %Read data from FPGA. 
    RunAWG(0); %Turn off all outputs
    if dataTemp==0
        error('No data collected')
    end
    %initialize data vectors
    ancillaSig(i) = dataTemp(1)*65536 + dataTemp(2)*256+dataTemp(3); %Convert Signal data
    ancillaRef(i) = dataTemp(4)*65536 + dataTemp(5)*256+dataTemp(6); %Convert Reference data
    
    data.T1.signal(i)=ancillaSig(i);
    data.T1.reference(i)=ancillaRef(i);
    
    if data.T1.reference(i)>TheoreticalThreshold
        i=i+1;
        warning=0;
    else
        TrackNV(hObject,eventdata);
        while countsExport<0.9*Count %Not TheoreticalThreshold
            TrackNV(hObject,eventdata);
        end
        warning=warning+1;
        'Reference counts too low. Try again.'
        if warning>3
            error('Reference Counts Fatally Low. Experiment Halted.')
        end
    end
    
end
writeSG('10000EDA', 2.87*10^9, 0, 0)
Plot_Data('T1',handles)
T1fit(handles)
SaveData('T1',hObject, eventdata, handles);
saveFig('T1',handles);

end

function RunUser(hObject, eventdata, handles)

global User Seq samples len DC_off data dataParameters DC Amp Detector awg buffer bGo

% Clear detector
clearFPGA()

pulses={'P1' 'P2'}; %Currently only offering 2 pulses


writeSG('10000EDA', floor(str2double(handles.MW_Freq.String)*10^9), str2double(handles.MW_Power.String), handles.(char('User_MW')).Value)

%Get parameters from user inputs
for str = pulses
    if ~handles.(char(strcat(str,'_On'))).Value 
        continue %Skip if radio button is off
    end
    
    dataParameters.User.(char(str)).Initial_Width=str2double(handles.(char(strcat(str,'_Initial_Width'))).String);
    dataParameters.User.(char(str)).Initial_Amp=str2double(handles.(char(strcat(str,'_Initial_Amp'))).String);
    dataParameters.User.(char(str)).Initial_Time=str2double(handles.(char(strcat(str,'_Initial_Time'))).String);
    dataParameters.User.(char(str)).Offset=str2double(handles.(char(strcat(str,'_Offset'))).String);
    dataParameters.User.(char(str)).channel=handles.(char(strcat(str,'_Channel'))).String{handles.(char(strcat(str,'_Channel'))).Value};
    dataParameters.User.(char(str)).string=handles.(char(strcat(str,'_Sweep'))).String{handles.(char(strcat(str,'_Sweep'))).Value};
    mod = dataParameters.User.(char(str)).string;
    switch mod
        case 'Width'
            dataParameters.User.(char(str)).Modmin=dataParameters.User.(char(str)).Initial_Width;
        case 'Amp'
            dataParameters.User.(char(str)).Modmin=dataParameters.User.(char(str)).Initial_Amp;
        case 'Time'
            dataParameters.User.(char(str)).Modmin=dataParameters.User.(char(str)).Initial_Time;
    end
    dataParameters.User.(char(str)).Modmax=str2double(handles.(char(strcat(str,'_Final_Mod_Value'))).String);
    dataParameters.User.(char(str)).Modstep=str2double(handles.(char(strcat(str,'_Modulation_Step'))).String);
    dataParameters.User.(char(str)).vector=(dataParameters.User.(char(str)).Modmin:dataParameters.User.(char(str)).Modstep:dataParameters.User.(char(str)).Modmax);
    %%%Make sure vector does not force waveforms to be longer than the
    %%%input length to Wave_generator
    User_DC_AMP(dataParameters.User.(char(str)).Offset, dataParameters.User.(char(str)).Initial_Amp,str)
end


len.User = str2double(handles.Pulse_Length.String) ; %length of waveform in us

% On the first run, we have to send and load all channels of the Rabi
% sequence

%Initialize Detector
detect=handles.User_Detect.Value;
if detect
    ancillaSig=zeros(1,length(dataParameters.User.P1.vector));
    ancillaRef=zeros(1,length(dataParameters.User.P1.vector));
    data.User.signal=ancillaSig;
    data.User.reference=ancillaRef;
end

vecLen=length(dataParameters.User.P1.vector);

if handles.(char('Infinite_Sequence')).Value
    disp(' ')
    disp('--- Sending User to AWG')
    disp(' ')
    disp('--- No Modulation Stepping in Infinite Sequences')
    AWG_Measure_User(handles, 1); %No modulation for infinite sequences
    %Rabi=GenAWGWF(Rabi,samples,len.rabi); %Convert to a form AWG accepts
    User=GenUserWF(User,samples,len.User);
    Plot_AWG_Sequence(User,handles)
    
    Sent.User=SendWF2AWG(samples, len.User, User, struct,'User');
    
    
    disp(' ')
    disp('--- Setting AWG sequence to User')
    %Modulate Amplitude if needed
    for str=pulses
        if ~handles.(char(strcat(str,'_On'))).Value
            continue %Skip if radio button is off
        end
        mod = dataParameters.User.(char(str)).string;
        if strcmp(mod,'Amp')
            User_DC_AMP(dataParameters.User.(char(str)).Offset, dataParameters.User.(char(str)).vector(1),str);
        end
    end
    CreateInfiniteSeq('User');
    RunAWG(1); %Run Sequence (FPGA collects)
    disp(' ')
    disp('--- AWG Set to Run Indefinitely. Matlab Execution Terminating')
else

    for ii = 1:vecLen
        if ~bGo
            return
        end
        disp(' ')
        disp('--- Sending User to AWG')
        AWG_Measure_User(handles, ii);
        %Rabi=GenAWGWF(Rabi,samples,len.rabi); %Convert to a form AWG accepts
        User=GenUserWF(User,samples,len.User);
        Plot_AWG_Sequence(User,handles)
        
        SentUser=SendWF2AWG(samples, len.User, User, struct,'User');
        
        
        disp(' ')
        disp('--- Setting AWG sequence to User')
        %Modulate Amplitude if needed
        for str=pulses
            if ~handles.(char(strcat(str,'_On'))).Value
                continue %Skip if radio button is off
            end
            mod = dataParameters.User.(char(str)).string;
            if strcmp(mod,'Amp')
                User_DC_AMP(dataParameters.User.(char(str)).Offset, dataParameters.User.(char(str)).vector(ii),str);
            end
        end
        
        
        CreateSeq(20,50000,1,'User'); %20*50000=10^6 measurements
        
        
        if detect
            fwrite(Detector, [0;1]); %FPGA in sequence mode
        end
        RunAWG(1); %Run Sequence (FPGA collects)
        running=2;
        while running==2 && bGo
            fprintf(awg, '%s\n','AWGCONTROL:RSTATE?');
            running=str2num(fscanf(awg,'%s'));
            if isempty(running)
                warningVISA=warningVISA+1;
                running = 2;
                if warningVISA >=3
                    error('Communication with AWG lost')
                end
            end
        end
        pause(1) %Make sure output is off
        if detect
            fwrite(Detector, [0;0]); %End sequence mode
            dataTemp = fread(Detector,6) %Read data from FPGA.
        end
        RunAWG(0); %Turn off all outputs
        if detect
            if dataTemp==0
                error('No data collected')
            end
            %initialize data vectors
            ancillaSig(ii) = dataTemp(1)*65536 + dataTemp(2)*256+dataTemp(3); %Convert Signal data
            ancillaRef(ii) = dataTemp(4)*65536 + dataTemp(5)*256+dataTemp(6); %Convert Reference data
            data.User.signal(ii)=ancillaSig(ii);
            data.User.reference(ii)=ancillaRef(ii);
        end
        
    end
end

%writeSG('10000EDA', str2double(handles.MW_Freq.String)*10^9, str2double(handles.MW_Power.String), 0)

SaveData('User',hObject, eventdata, handles);
Plot_Data('User',handles)
saveFig('User',handles);

end

function AOM_Delay(hObject, eventdata, handles)

global SentAOM Seq samples len DC_off AOM_Delay data dataParameters Detector awg buffer bGo

% Clear detector
clearFPGA()

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

ancillaSig=zeros(1,length(dataParameters.AOM_Delay.vector));
ancillaRef=zeros(1,length(dataParameters.AOM_Delay.vector));
data.AOM_Delay.signal=ancillaSig;
data.AOM_Delay.reference=ancillaRef;
i=1;
for SigTTL = dataParameters.AOM_Delay.vector
    if ~bGo
        return
    end
    disp(' ')
    disp('--- Sending AOM_Delay to AWG')
    AWG_Measure_AOM_Delay(SigTTL);
    %Rabi=GenAWGWF(Rabi,samples,len.rabi); %Convert to a form AWG accepts
    AOM_Delay=GenAWGWF(AOM_Delay,samples,len.AOM_Delay);
    Plot_AWG_Sequence(AOM_Delay,handles)
    
    SentAOM=SendWF2AWG(samples, len.AOM_Delay, AOM_Delay, struct,'AOM_Delay');
    
    
    disp(' ')
    disp('--- Setting AWG sequence to AOM_Delay')
    CreateSeq(20,50000,1,'AOM_Delay'); %I changed the first number to 1000 from 200 but idk what I'm doing --Satcher
    %CreateInfiniteSeq('AOM_Delay',DC,Amp)
    % CreateSUBSeq(subLen,1,1,'Rabi');
    % CreateSeq_from_SUB(20,5000,1,'Rabi',DC,Amp);
    %Mark that Rabi is currently loaded on AWG
    Seq.AOM_Delay = 1 % Redundant with the following function
    Seq=Loop_Remaining_Structure({'AOM_Delay'}, Seq,0);
    
%     writeCounter(Detector)
    fwrite(Detector, uint8(hex2dec(['00';'01']))); %FPGA in sequence mode
    RunAWG(1); %Run Sequence (FPGA collects)
    running=2; 
    while running==2 && bGo
        %         visa_vendor = 'ni';
        %         visa_address = 'TCPIP::136.152.250.165::INSTR';
        %         buffer = 2 * 1024;
        %         awg = visa(visa_vendor,visa_address);
        %         fopen(awg);
        fprintf(awg, '%s\n','AWGCONTROL:RSTATE?');
        running=str2num(fscanf(awg,'%s'));
        %         fclose(awg);
        %         delete(awg);
        %         clear awg;
        if isempty(running)
            warningVISA=warningVISA+1;
            running = 2;
            if warningVISA >=3
                error('Communication with AWG lost')
            end
        end
    end
    pause(1) %Make sure output is off
%     dataTemp = readCounter(Detector,10*10^-9,1, 'seq')
    fwrite(Detector, uint8(hex2dec(['00';'00']))); %End sequence mode
    dataTemp = fread(Detector,6);%Read data from FPGA. 
    RunAWG(0); %Turn off all outputs
    if isempty(dataTemp)
        error('No data collected')
    end
    %initialize data vectors
    ancillaSig(i) = dataTemp(1)*65536 + dataTemp(2)*256+dataTemp(3); %Convert Signal data
    ancillaRef(i) = dataTemp(4)*65536 + dataTemp(5)*256+dataTemp(6); %Convert Reference data
    data.AOM_Delay.signal(i)=ancillaSig(i);
    data.AOM_Delay.reference(i)=ancillaRef(i);
    

    i=i+1;
    
end

SaveData('AOM_Delay',hObject, eventdata, handles);
Plot_Data('AOM_Delay',handles)
saveFig('AOM_Delay',handles);

end

function AnalyzeNV(hObject, eventdata, handles)

global dataParameters

dataParameters.AnalyzeNV.RabiFreq=str2double(handles.AnalyzeNV_RabiFreq.String);
dataParameters.AnalyzeNV.PiPulseDetuning=str2double(handles.AnalyzeNV_PiPulseDetuning.String);

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

function AWG_Measure_Pi_Pulse_Calibrate(MWLength,number,amp, handles)

global Readout Pi_Pulse_Calibrate len
clear global Pi_Pulse_Calibrate
global Pi_Pulse_Calibrate
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
% Pi_Pulse_Calibrate.Ch1=[0,500,10,0,1] ;
% Pi_Pulse_Calibrate.Mk1=[0,500,1];
% Pi_Pulse_Calibrate.Mk2=[0,500,1];

%%%%%% Mixer control: I and Q %%%%%% 

%%%Make sure MWLength does not force this waveform to be longer than the
%%%input length to Wave_generator
        % Wait for Laser to polarize and 50ns
         %Apply MW
%Wave_generator creates sine, so need pi/2 when DC
%Switch is ~3ns before I and Q
%I and Q turn off 3ns before switch


portTemp=Pi_Pulse_Calibrate_Analog([0,4049,0,0,0],number,20,MWLength,amp);
if handles.Pi_Pulse_I.Value
    Pi_Pulse_Calibrate.Ch1 = portTemp;
    Pi_Pulse_Calibrate.Ch2 = [0,0,0];
elseif handles.Pi_Pulse_Q.Value
    Pi_Pulse_Calibrate.Ch1 = [0,0,0];
    Pi_Pulse_Calibrate.Ch2 = portTemp;
else
    error('Pi Pulse Port Radio Buttons Broken')
end

pulseTrainEnd=portTemp(end,2);

%%%%%% Switch %%%%%% 
Pi_Pulse_Calibrate.Mk1 = [4030,pulseTrainEnd+20,1]; 
%%%Make sure MWLength does not force this waveform to be longer than the
%%%input length to Wave_generator
     % Wait for Laser to polarize and turn off
     %turn on and off
%Switch TTL pulse is 5ns longer

%%%%%% Laser %%%%%% 
Pi_Pulse_Calibrate.Mk2 = [0,3000,1;... %Polarize for 3us
    3001,pulseTrainEnd+1100,0;... %wait for: 50ns, 1us, max MW duration, 50ns
    pulseTrainEnd+1101,1000*len.Pi_Pulse_Calibrate,1];  %Detection and keep AOM warm 

%%%%%% FPGA Signal %%%%%% 
Pi_Pulse_Calibrate.Mk3 = [pulseTrainEnd+1101,pulseTrainEnd+1101+300,1]; 
% Pi_Pulse_Calibrate.Mk3 = [4102,4402,1]; 
%300ns detection window when laser turns on

%%%%%% FPGA Reference %%%%%% 
Pi_Pulse_Calibrate.Mk4 = [pulseTrainEnd+1101+2000,pulseTrainEnd+1101+2000+300,1];
% Pi_Pulse_Calibrate.Mk4 = [6802,7102,1];
%300ns detection window for last 300ns of laser detection pulse

%%%%%% Trigger %%%%%% 
Pi_Pulse_Calibrate.Mk5 = [0,500,1];  %Trigger for observation on Oscope 
Pi_Pulse_Calibrate.Mk6 = [0,1000,0];  %Markers must come in pairs
% Must specify Analog channel is 0 for purely digital outputs
Pi_Pulse_Calibrate.Ch3 = [0,0,0,0,0]; 

%%%%%% Unused %%%%%
% Pi_Pulse_Calibrate.Ch4 = [0,10000,0,pi/2,1]; 
% Pi_Pulse_Calibrate.Mk7 = [0,0,0];  
% Pi_Pulse_Calibrate.Mk8 = [0,0,0];  
  
%adjust for readout and MW delay

Pi_Pulse_Calibrate = delays(Readout, Pi_Pulse_Calibrate);
% Pi_Pulse_Calibrate = delays('None', Pi_Pulse_Calibrate);
disp('Pi_Pulse_Calibrate defined and delayed')

end

% Stored Rabi Sequence before Wave_Generator processing
function AWG_Measure_Rabi(MWLength,MaxLength,handles) 

global Readout Rabi len
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
%%%%%% Mixer control: I & Q %%%%%% 
if handles.Rabi_I.Value
    Rabi.Ch1 = [4050,4050+MWLength,0,pi/2,str2double(handles.Voltage_I.String)];
    Rabi.Ch2=[0,0,0];
elseif handles.Rabi_Q.Value
    Rabi.Ch1=[0,0,0];
    Rabi.Ch2 = [4050,4050+MWLength,0,pi/2,str2double(handles.Voltage_Q.String)];
else
    error('Rabi Port Radio Buttons Broken')
end

%%%Make sure MWLength does not force this waveform to be longer than the
%%%input length to Wave_generator
        % Wait for Laser to polarize and 50ns
         %Apply MW
%Wave_generator creates sine, so need pi/2 when DC
%Switch is ~3ns before I and Q
%I and Q turn off 3ns before switch

         
%%%%%% Switch %%%%%% 
Rabi.Mk1 = [4030,4070+MWLength,1]; 
%%%Make sure MWLength does not force this waveform to be longer than the
%%%input length to Wave_generator
     % Wait for Laser to polarize and turn off
     %turn on and off
%Switch TTL pulse is 5ns longer

%%%%%% Laser %%%%%% 
Rabi.Mk2 = [0,3000,1;... %Polarize for 3us
    3001,3001+MaxLength+1100,0;... %wait for: 50ns, 1us, max MW duration, 50ns
    3001+MaxLength+1101,1000*len.Rabi,1];  %Detection and keep AOM warm 

%%%%%% FPGA Signal %%%%%% 
Rabi.Mk3 = [3001+MaxLength+1101,3001+MaxLength+1101+300,1]; 
% Rabi.Mk3 = [4102,4402,1]; 
%300ns detection window when laser turns on

%%%%%% FPGA Reference %%%%%% 
Rabi.Mk4 = [3001+MaxLength+1101+2000,3001+MaxLength+1101+2000+300,1];
% Rabi.Mk4 = [6802,7102,1];
%300ns detection window for last 300ns of laser detection pulse

%%%%%% Trigger %%%%%% 
Rabi.Mk5 = [0,500,1];  %Trigger for observation on Oscope 
Rabi.Mk6 = [0,1000,0];  %Markers must come in pairs
% Must specify Analog channel is 0 for purely digital outputs
Rabi.Ch3 = [0,0,0,0,0]; 

%%%%%% Unused %%%%%
% Rabi.Ch4 = [0,10000,0,pi/2,1]; 
% Rabi.Mk7 = [0,0,0];  
% Rabi.Mk8 = [0,0,0];  
  
%adjust for readout and MW delay

Rabi = delays(Readout, Rabi);
% Rabi = delays('None', Rabi);
disp('Rabi defined and delayed')

end 

function AWG_Measure_ESR(MWLength,handles) 

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
ESR.Ch1 = [0,0,0;0,4000,str2double(handles.Voltage_I.String)]; 
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
ESR.Mk1 = [0,0,0;0,4000,1]; 
%%%Make sure MWLength does not force this waveform to be longer than the
%%%input length to Wave_generator
     % Wait for Laser to polarize and turn off
     %turn on and off
%Switch TTL pulse is 5ns longer

%%%%%% Laser %%%%%% 
ESR.Mk2 = [0,0,0;0,4000,1];  %detection for 3us

%%%%%% FPGA Signal %%%%%% 
ESR.Mk3 = [0,0,0;2000,3000,1]; 
% Rabi.Mk3 = [4102,4402,1]; 
%300ns detection window when laser turns on

%%%%%% FPGA Reference %%%%%% 
ESR.Mk4 = [0,0,0];
% Rabi.Mk4 = [6802,7102,1];
%300ns detection window for last 300ns of laser detection pulse

%%%%%% Trigger %%%%%% 
ESR.Mk5 = [0,0,0;0,500,1];  %Trigger for observation on Oscope 
ESR.Mk6 = [0,0,0;0,1000,0];  %Markers must come in pairs
% Must specify Analog channel is 0 for purely digital outputs
ESR.Ch3 = [0,0,0;3500,4000,1]; 

%%%%%% Unused %%%%%
% Rabi.Ch4 = [0,10000,0,pi/2,1]; 
% Rabi.Mk7 = [0,0,0];  
% Rabi.Mk8 = [0,0,0];  
  
%adjust for readout and MW delay

%ESR = delays(Readout, ESR)
% Rabi = delays('None', Rabi);
disp('ESR defined and delayed')

end 

function AWG_Measure_ODMR(MWLength,handles)
global Readout ODMR len
clear global ODMR
global ODMR
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
% ODMR.Ch1=[0,500,10,0,1] ;
% ODMR.Mk1=[0,500,1];
% ODMR.Mk2=[0,500,1];
%%%%%% Mixer control: I %%%%%% 
ODMR.Ch1 = [4050,4050+MWLength,0,pi/2,str2double(handles.Voltage_I.String)]; 
%%%Make sure MWLength does not force this waveform to be longer than the
%%%input length to Wave_generator
        % Wait for Laser to polarize and 50ns
         %Apply MW
%Wave_generator creates sine, so need pi/2 when DC
%Switch is ~3ns before I and Q
%I and Q turn off 3ns before switch


%%%%%% Mixer control: Q %%%%%% 
ODMR.Ch2 = [0,0,0];%[3050,3050+MWLength,0,pi/2,1]; 
%%%Make sure MWLength does not force this waveform to be longer than the
%%%input length to Wave_generator
        % Wait for Laser to polarize and 50ns
         %Apply MW
         
%%%%%% Switch %%%%%% 
ODMR.Mk1 = [4030,4070+MWLength,1]; 
%%%Make sure MWLength does not force this waveform to be longer than the
%%%input length to Wave_generator
     % Wait for Laser to polarize and turn off
     %turn on and off
%Switch TTL pulse is 5ns longer

%%%%%% Laser %%%%%% 
ODMR.Mk2 = [0,3000,1;... %Polarize for 3us
    3001,3001+MWLength+1100,0;... %wait for: 50ns, 1us, max MW duration, 50ns
    3001+MWLength+1101,1000*len.ODMR,1];  %Detection and keep AOM warm 

%%%%%% FPGA Signal %%%%%% 
ODMR.Mk3 = [3001+MWLength+1101,3001+MWLength+1101+300,1]; 
% ODMR.Mk3 = [4102,4402,1]; 
%300ns detection window when laser turns on

%%%%%% FPGA Reference %%%%%% 
ODMR.Mk4 = [3001+MWLength+1101+2000,3001+MWLength+1101+2000+300,1];
% ODMR.Mk4 = [6802,7102,1];
%300ns detection window for last 300ns of laser detection pulse

%%%%%% Trigger %%%%%% 
ODMR.Mk5 = [0,500,1];  %Trigger for observation on Oscope 
ODMR.Mk6 = [0,1000,0];  %Markers must come in pairs
% Must specify Analog channel is 0 for purely digital outputs
ODMR.Ch3 = [0,0,0,0,0]; 

%%%%%% Unused %%%%%
% ODMR.Ch4 = [0,10000,0,pi/2,1]; 
% ODMR.Mk7 = [0,0,0];  
% ODMR.Mk8 = [0,0,0];  
  
%adjust for readout and MW delay

ODMR = delays(Readout, ODMR);
% ODMR = delays('None', ODMR);
disp('ODMR defined and delayed')
end

function AWG_Measure_ODMR_Handshake(MWLength,handles) 

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
ESR_Handshake.Ch1 = [0,0,0,0,str2double(handles.Voltage_I.String)]; 
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

function AWG_Measure_Ramsey(tau,tauMax,piPulse,handles)

global Readout Ramsey len
clear global Ramsey
global Ramsey
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
% Ramsey.Ch1=[0,500,10,0,1] ;
% Ramsey.Mk1=[0,500,1];
% Ramsey.Mk2=[0,500,1];
%%%%%% Mixer control: I %%%%%% 
Ramsey.Ch1 = [4050,4050+piPulse/2,0,3.14159/2,str2double(handles.Voltage_I.String);...
    4051+piPulse/2,4051+piPulse/2+tau,0,0,0;...
    4052+piPulse/2+tau,4052+piPulse+tau,0,-3.14159/2,str2double(handles.Voltage_I.String)]; 
%%%Make sure MWLength does not force this waveform to be longer than the
%%%input length to Wave_generator
        % Wait for Laser to polarize and 50ns
         %Apply MW
%Wave_generator creates sine, so need pi/2 when DC
%Switch is ~3ns before I and Q
%I and Q turn off 3ns before switch


%%%%%% Mixer control: Q %%%%%% 
Ramsey.Ch2 = [0,0,0];%[3050,3050+MWLength,0,pi/2,1]; 
%%%Make sure MWLength does not force this waveform to be longer than the
%%%input length to Wave_generator
        % Wait for Laser to polarize and 50ns
         %Apply MW
         
%%%%%% Switch %%%%%% 
if tau <=40
    Ramsey.Mk1 = [4030,4072+piPulse+tau,1];
else
    Ramsey.Mk1 = [4030,4070+piPulse/2,1;...
        4071+piPulse/2,4031+piPulse/2+tau,0;...
        4032+piPulse/2+tau,4072+piPulse+tau,1];
end
%%%Make sure MWLength does not force this waveform to be longer than the
%%%input length to Wave_generator
     % Wait for Laser to polarize and turn off
     %turn on and off
%Switch TTL pulse is 5ns longer

%%%%%% Laser %%%%%% 
Ramsey.Mk2 = [0,3000,1;... %Polarize for 3us
    3001,4152+piPulse+tauMax,0;... %wait for: 50ns, 1us, max MW duration, 50ns
    4153+piPulse+tauMax,1000*len.Ramsey,1];  %Detection and keep AOM warm 

%%%%%% FPGA Signal %%%%%% 
Ramsey.Mk3 = [4153+piPulse+tauMax,4153+piPulse+tauMax+300,1]; 
% Ramsey.Mk3 = [4102,4402,1]; 
%300ns detection window when laser turns on

%%%%%% FPGA Reference %%%%%% 
Ramsey.Mk4 = [4153+piPulse+tauMax+2000,4153+piPulse+tauMax+2000+300,1];
% Ramsey.Mk4 = [6802,7102,1];
%300ns detection window for last 300ns of laser detection pulse

%%%%%% Trigger %%%%%% 
Ramsey.Mk5 = [0,500,1];  %Trigger for observation on Oscope 
Ramsey.Mk6 = [0,1000,0];  %Markers must come in pairs
% Must specify Analog channel is 0 for purely digital outputs
Ramsey.Ch3 = [0,0,0,0,0]; 

%%%%%% Unused %%%%%
% Ramsey.Ch4 = [0,10000,0,pi/2,1]; 
% Ramsey.Mk7 = [0,0,0];  
% Ramsey.Mk8 = [0,0,0];  
  
%adjust for readout and MW delay

Ramsey = delays(Readout, Ramsey);
% Ramsey = delays('None', Ramsey);
disp('Ramsey defined and delayed')

end 

function AWG_Measure_SpinEcho(tau,tauMax,piPulse,handles)

global Readout SpinEcho len
clear global SpinEcho
global SpinEcho
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
% SpinEcho.Ch1=[0,500,10,0,1] ;
% SpinEcho.Mk1=[0,500,1];
% SpinEcho.Mk2=[0,500,1];
%%%%%% Mixer control: I %%%%%% 
v_I = str2double(handles.Voltage_I.String);
SpinEcho.Ch1 = [4050,4050+piPulse/2,0,pi/2,v_I;...
    4051+piPulse/2,4051+piPulse/2+tau,0,pi/2,0;...
    4052+piPulse/2+tau,4052+piPulse/2+tau+piPulse,0,pi/2,0;...
    4053+piPulse/2+tau+piPulse,4053+piPulse/2+2*tau+piPulse,0,pi/2,0;...
    4054+piPulse/2+2*tau+piPulse,4054+piPulse+2*tau+piPulse,0,-pi/2,v_I]; 
%%%Make sure MWLength does not force this waveform to be longer than the
%%%input length to Wave_generator
        % Wait for Laser to polarize and 50ns
         %Apply MW
%Wave_generator creates sine, so need pi/2 when DC
%Switch is ~3ns before I and Q
%I and Q turn off 3ns before switch


%%%%%% Mixer control: Q %%%%%% 
v_Q = str2double(handles.Voltage_Q.String);
SpinEcho.Ch2 = [4050,4050+piPulse/2,0;...
    4051+piPulse/2,4051+piPulse/2+tau,0;...
    4052+piPulse/2+tau,4052+piPulse/2+tau+piPulse,v_Q;...
    4053+piPulse/2+tau+piPulse,4053+piPulse/2+2*tau+piPulse,0;...
    4054+piPulse/2+2*tau+piPulse,4054+piPulse+2*tau+piPulse,0]; 
%%%Make sure MWLength does not force this waveform to be longer than the
%%%input length to Wave_generator
        % Wait for Laser to polarize and 50ns
         %Apply MW
         
%%%%%% Switch %%%%%% 
if tau <=40
    SpinEcho.Mk1 = [4030,4454+2*piPulse,1];
else
    SpinEcho.Mk1 = [4030,4070+piPulse/2,1;...
        4071+piPulse/2,4031+piPulse/2+tau,0;...
        4032+piPulse/2+tau,4072+piPulse/2+tau+piPulse,1;...
        4073+piPulse/2+tau+piPulse,4033+piPulse/2+2*tau+piPulse,0;...
        4034+piPulse/2+2*tau+piPulse,4074+piPulse+2*tau+piPulse,1];
end
%%%Make sure MWLength does not force this waveform to be longer than the
%%%input length to Wave_generator
     % Wait for Laser to polarize and turn off
     %turn on and off
%Switch TTL pulse is 5ns longer

%%%%%% Laser %%%%%% 
SpinEcho.Mk2 = [0,3000,1;... %Polarize for 3us
    3001,4154+piPulse+2*tau+piPulse,0;... %wait for: 50ns, 1us, max MW duration, 50ns
    4155+piPulse+2*tau+piPulse,1000*len.SpinEcho,1];  %Detection and keep AOM warm 

%%%%%% FPGA Signal %%%%%% 
SpinEcho.Mk3 = [4154+piPulse+2*tau+piPulse,4154+piPulse+2*tau+piPulse+300,1]; 
% SpinEcho.Mk3 = [4102,4402,1]; 
%300ns detection window when laser turns on

%%%%%% FPGA Reference %%%%%% 
SpinEcho.Mk4 = [4154+piPulse+2*tau+piPulse+2000,4154+piPulse+2*tau+piPulse+2000+300,1];
% SpinEcho.Mk4 = [6802,7102,1];
%300ns detection window for last 300ns of laser detection pulse

%%%%%% Trigger %%%%%% 
SpinEcho.Mk5 = [0,500,1];  %Trigger for observation on Oscope 
SpinEcho.Mk6 = [0,1000,0];  %Markers must come in pairs
% Must specify Analog channel is 0 for purely digital outputs
SpinEcho.Ch3 = [0,0,0,0,0]; 

%%%%%% Unused %%%%%
% SpinEcho.Ch4 = [0,10000,0,pi/2,1]; 
% SpinEcho.Mk7 = [0,0,0];  
% SpinEcho.Mk8 = [0,0,0];  
  
%adjust for readout and MW delay

SpinEcho = delays(Readout, SpinEcho);
% SpinEcho = delays('None', SpinEcho);
disp('SpinEcho defined and delayed')

end 

function AWG_Measure_CPMG(n,tau,tauMax,piPulse,handles)

global Readout CPMG len
clear global CPMG
global CPMG
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
% CPMG.Ch1=[0,500,10,0,1] ;
% CPMG.Mk1=[0,500,1];
% CPMG.Mk2=[0,500,1];

n=2*floor(n/2); %In case given an odd number, round to next lowest even number

%%%%%% Mixer control: I %%%%%% 
v_I=str2double(handles.Voltage_I.String);
%Start with +Pi/2 pulse
iTemp = [4050,4050+piPulse/2,0,pi/2,v_I];
% Add half of Pi Pulses
iTemp = ItXY_Analog(iTemp, n/2, tau, piPulse,v_I,1,0); 
iTemp(end,2) = iTemp(end,2)-piPulse ; %ItXY automatically adds undesired wait for PiPulse at end
%Add remaining (reflected) Pi Pulses
iTemp(end+1:end+2,:)=[iTemp(end,2)+1,iTemp(end,2)+1+piPulse, 0,pi/2,0; iTemp(end,2)+2+piPulse,iTemp(end,2)+2+2*piPulse+2*tau, 0,0,0];
iTemp = ItXY_Analog(iTemp, n/2, tau, piPulse,v_I,0,1) ; 
%Add -Pi/2 Pulse
iTemp(end,2) = iTemp(end,2);
iTemp(end+1,:)=[iTemp(end,2)+1,iTemp(end,2)+1+piPulse/2,0,3*pi/2,v_I];

CPMG.Ch1 = iTemp; 
%%%Make sure MWLength does not force this waveform to be longer than the
%%%input length to Wave_generator
        % Wait for Laser to polarize and 50ns
         %Apply MW
%Wave_generator creates sine, so need pi/2 when DC
%Switch is ~3ns before I and Q
%I and Q turn off 3ns before switch
len.CPMG=ceil((CPMG.Ch1(end,2)+51+2000+300+3000)/1000); %Add 3us after reference trigger

%%%%%% Mixer control: Q %%%%%% 
v_Q=str2double(handles.Voltage_Q.String);
iTemp = [4050,4050+piPulse/2+tau+piPulse, 0];
iTemp = ItXY_Analog(iTemp, n/2, tau, piPulse,v_Q,0,0); %Originally ItXY(iTemp, n/2, tau, piPulse);
iTemp(end,2) = iTemp(end,2)-piPulse ; %ItXY automatically adds undesired wait for PiPulse at end
iTemp(end+1:end+2,:)=[iTemp(end,2)+1,iTemp(end,2)+1+piPulse, v_Q; iTemp(end,2)+2+piPulse,iTemp(end,2)+2+2*piPulse+2*tau, 0];
iTemp = ItXY_Analog(iTemp, n/2-1, tau, piPulse,v_Q,0,0); %Originally ItXY(iTemp, n/2-1, tau, piPulse);

CPMG.Ch2 = iTemp;%[3050,3050+MWLength,0,pi/2,1]; 
%%%Make sure MWLength does not force this waveform to be longer than the
%%%input length to Wave_generator
        % Wait for Laser to polarize and 50ns
         %Apply MW
         
%%%%%% Switch %%%%%% 
%Start with +Pi/2 pulse
if tau <=20
    CPMG.Mk1 = [4030,CPMG.Ch1(end,2)+20,1];
else
    iTemp = [4030,4070+piPulse/2,1];
    %Add Pi Pulses
    iTemp = ItXY_Switch(iTemp, 2*n, tau, piPulse, 1);
    %Add tau-100 wait
    iTemp(end+1,:)=[iTemp(end,2)+1,iTemp(end,2)+1+tau-40,0];
    %Add -Pi/2 Pulse
    iTemp(end+1,:)=[iTemp(end,2)+1,iTemp(end,2)+1+piPulse/2+40,1];
    
    CPMG.Mk1 = iTemp ;
end
%%%Make sure MWLength does not force this waveform to be longer than the
%%%input length to Wave_generator
     % Wait for Laser to polarize and turn off
     %turn on and off
%Switch TTL pulse is 5ns longer

%%%%%% Laser %%%%%% 
CPMG.Mk2 = [0,3000,1;... %Polarize for 3us
    3001,CPMG.Ch1(end,2)+50,0;... %wait for: 50ns, 1us, MW duration, 50ns
    CPMG.Ch1(end,2)+51,1000*len.CPMGN,1];  %Detection and keep AOM warm
%factor of 2*n because we want to preserve the duty cycle? Signal and
%reference will see the same duty cycle so it shouldn't matter, data-wise.
%But we speed up our measurement process when we scan tau and n.

%%%%%% FPGA Signal %%%%%% 
CPMG.Mk3 = [CPMG.Ch1(end,2)+51,CPMG.Ch1(end,2)+51+300,1]; 
% CPMG.Mk3 = [4102,4402,1]; 
%300ns detection window when laser turns on

%%%%%% FPGA Reference %%%%%% 
CPMG.Mk4 = [CPMG.Ch1(end,2)+51+2000,CPMG.Ch1(end,2)+51+2000+300,1];
% CPMG.Mk4 = [6802,7102,1];
%300ns detection window for last 300ns of laser detection pulse

%%%%%% Trigger %%%%%% 
CPMG.Mk5 = [0,500,1];  %Trigger for observation on Oscope 
CPMG.Mk6 = [0,1000,0];  %Markers must come in pairs
% Must specify Analog channel is 0 for purely digital outputs
CPMG.Ch3 = [0,0,0,0,0]; 

%%%%%% Unused %%%%%
% CPMG.Ch4 = [0,10000,0,pi/2,1]; 
% CPMG.Mk7 = [0,0,0];  
% CPMG.Mk8 = [0,0,0];  
  
%adjust for readout and MW delay

CPMG = delays(Readout, CPMG);
% CPMG = delays('None', CPMG);
disp('CPMG defined and delayed')

end 

function AWG_Measure_T1(tau,piPulse,handles) 

global Readout T1 len
clear global T1
global T1
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
% T1.Ch1=[0,500,10,0,1] ;
% T1.Mk1=[0,500,1];
% T1.Mk2=[0,500,1];

%%%%%% Mixer control: I %%%%%% 
%%%%%% & Switch %%%%%% 
if handles.T1_m1.Value
    T1.Ch1 = [4050,4050+piPulse,0,pi/2,str2double(handles.Voltage_I.String);...
        4051+piPulse,4051+piPulse+tau,0,0,0;...
        4052+piPulse+tau,4052+2*piPulse+tau,0,pi/2,str2double(handles.Voltage_I.String);];
    T1.Mk1 = [4030,4072+2*piPulse+tau,1]; 
elseif handles.T1_0.Value
    T1.Ch1 = [0,0,0];
    T1.Mk1 = [0,0,0]; 
else
    error('T1 Radio Buttons Broken')
end

%%%Make sure MWLength does not force this waveform to be longer than the
%%%input length to Wave_generator
        % Wait for Laser to polarize and 50ns
         %Apply MW
%Wave_generator creates sine, so need pi/2 when DC
%Switch is ~3ns before I and Q
%I and Q turn off 3ns before switch


%%%%%% Mixer control: Q %%%%%% 
T1.Ch2 = [0,0,0];%[3050,3050+MWLength,0,pi/2,1]; 
%%%Make sure MWLength does not force this waveform to be longer than the
%%%input length to Wave_generator
        % Wait for Laser to polarize and 50ns
         %Apply MW


%%%%%% Laser %%%%%% 
T1.Mk2 = [0,3000,1;... %Polarize for 3us
    3001,4072+2*piPulse+tau+200,0;... %wait for: 50ns, 1us, tau and pi pulses, 200ns after last pi pulse
    4072+2*piPulse+tau+201,1000*len.T1,1];  %Detection and keep AOM warm 

%%%%%% FPGA Signal %%%%%% 
T1.Mk3 = [4072+2*piPulse+tau+201,4072+2*piPulse+tau+201+300,1]; 
% T1.Mk3 = [4102,4402,1]; 
%300ns detection window when laser turns on

%%%%%% FPGA Reference %%%%%% 
T1.Mk4 = [4072+2*piPulse+tau+201+2000,4072+2*piPulse+tau+201+2000+300,1];
% T1.Mk4 = [6802,7102,1];
%300ns detection window for last 300ns of laser detection pulse

%%%%%% Trigger %%%%%% 
T1.Mk5 = [0,500,1];  %Trigger for observation on Oscope 
T1.Mk6 = [0,1000,0];  %Markers must come in pairs
% Must specify Analog channel is 0 for purely digital outputs
T1.Ch3 = [0,0,0,0,0]; 

%%%%%% Unused %%%%%
% T1.Ch4 = [0,10000,0,pi/2,1]; 
% T1.Mk7 = [0,0,0];  
% T1.Mk8 = [0,0,0];  
  
%adjust for readout and MW delay

T1 = delays(Readout, T1);
% T1 = delays('None', T1);
disp('T1 defined and delayed')

end 

function AWG_Measure_User(handles, elem) 

global Readout dataParameters User
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

pulses={'P1' 'P2'}; %Currently only offering 2 pulses

   %Initialize channels
for str = pulses
    if ~handles.(char(strcat(str,'_On'))).Value 
        continue %Skip if radio button is off
    end

    pulses={'P1' 'P2'};
    if strcmp(dataParameters.User.(char(str)).channel(1),'C')
        if strcmp(dataParameters.User.(char(str)).channel(3),'1')
            User.Ch1=[0,0,0];
            User.Mk1=[0,0,0];
            User.Mk2=[0,0,0];
        end
        
        if strcmp(dataParameters.User.(char(str)).channel(3),'2')
            User.Ch2=[0,0,0];
            User.Mk3=[0,0,0];
            User.Mk4=[0,0,0];
        end
        
        if strcmp(dataParameters.User.(char(str)).channel(3),'3')
            User.Ch3=[0,0,0];
            User.Mk5=[0,0,0];
            User.Mk6=[0,0,0];
        end
        
        if strcmp(dataParameters.User.(char(str)).channel(3),'4')
            User.Ch4=[0,0,0];
            User.Mk7=[0,0,0];
            User.Mk8=[0,0,0];
        end
        
    elseif strcmp(dataParameters.User.(char(str)).channel(1),'M')
        if strcmp(dataParameters.User.(char(str)).channel(3),'1')||strcmp(dataParameters.User.(char(str)).channel(3),'2')
            User.Ch1=[0,0,0];
            User.Mk1=[0,0,0];
            User.Mk2=[0,0,0];
        end
        
        if strcmp(dataParameters.User.(char(str)).channel(3),'3')||strcmp(dataParameters.User.(char(str)).channel(3),'4')
            User.Ch2=[0,0,0];
            User.Mk3=[0,0,0];
            User.Mk4=[0,0,0];
        end
        
        if strcmp(dataParameters.User.(char(str)).channel(3),'5')||strcmp(dataParameters.User.(char(str)).channel(3),'6')
            User.Ch3=[0,0,0];
            User.Mk5=[0,0,0];
            User.Mk6=[0,0,0];
        end
        
        if strcmp(dataParameters.User.(char(str)).channel(3),'7')||strcmp(dataParameters.User.(char(str)).channel(3),'8')
            User.Ch4=[0,0,0];
            User.Mk7=[0,0,0];
            User.Mk8=[0,0,0];
        end
    else
        error('Undefined pulse channel')
    end
end
    
% Above loop must run separately for proper channel initialization
for str = pulses
    wid=dataParameters.User.(char(str)).Initial_Width;
    time=dataParameters.User.(char(str)).Initial_Time;
    vec.(char(str))=dataParameters.User.(char(str)).vector;
    if ~handles.(char(strcat(str,'_On'))).Value 
        continue %Skip if radio button is off
    end
          
    if  strcmp(dataParameters.User.(char(str)).string,'Width')
        User.(char(dataParameters.User.(char(str)).channel))=[time,time+vec.(char(str))(elem),1];
    end
    
    if  strcmp(dataParameters.User.(char(str)).string,'Time')
        User.(char(dataParameters.User.(char(str)).channel))=[vec.(char(str))(elem),vec.(char(str))(elem)+wid,1];
    end
    
    if  strcmp(dataParameters.User.(char(str)).string,'Amp')
        User.(char(dataParameters.User.(char(str)).channel))=[time,time+wid,1];
    end
    
end

%adjust for readout and MW delay
if handles.User_Delays.Value 
    User = delays(Readout, User);
else %If not delaying, still need prepended 0s
    fn = fieldnames(User);
    for str = fn'
        User.(char(str)) = cat(1,[0,0,0],User.(char(str)));
    end
end
% Rabi = delays('None', Rabi);
disp('User Sequence defined and delayed')

end 

function AWG_Measure_AOM_Delay(SigTTL,handles) 

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
AOM_Delay.Mk2 = [0,2000,1];   %Pulse Laser for 3us 
%AOM_Delay.Ch3 = [0,5000,1]; %Pulse Laser 100% duty cycle for 5us sequence

%%%%%% FPGA Signal %%%%%% 
AOM_Delay.Mk3 = [0,0,0;SigTTL,SigTTL+10,1] ;
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

%AOM_Delay = delays(Readout, AOM_Delay);
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
            plot(handles.Plot_Seq, single(struct.Ch1)/max(single((struct.Ch1))),'-r')
            hold(handles.Plot_Seq, 'on')
            plot(handles.Plot_Seq,single(struct.Mk1)/max(single(struct.Mk1))+1.1, '-r','LineStyle','--')
            plot(handles.Plot_Seq,single(struct.Mk2)/max(single(struct.Mk2))+2.2, '-r','LineStyle',':')
        elseif strcmp(sn{n},'Ch2') %If it's Channel 2
            plot(handles.Plot_Seq,single(struct.Ch2)/max(single(struct.Ch2))+3.3,'-b')
            hold(handles.Plot_Seq, 'on')
            plot(handles.Plot_Seq,single(struct.Mk3)/max(single(struct.Mk3))+4.4, '-b','LineStyle','--')
            plot(handles.Plot_Seq,single(struct.Mk4)/max(single(struct.Mk4))+5.5, '-b','LineStyle',':')
        elseif strcmp(sn{n},'Ch3') %If it's Channel 3
            plot(handles.Plot_Seq,single(struct.Ch3)/max(single(struct.Ch3))+6.6,'-g')
            hold(handles.Plot_Seq, 'on')
            plot(handles.Plot_Seq,single(struct.Mk5)/max(single(struct.Mk5))+7.7, '-g','LineStyle','--')
            plot(handles.Plot_Seq,single(struct.Mk6)/max(single(struct.Mk6))+8.8, '-g','LineStyle',':')
        elseif strcmp(sn{n},'Ch3') %If it's Channel 4
            plot(handles.Plot_Seq,single(struct.Ch4)/max(single(struct.Ch4))+9.9,'-k')
            hold(handles.Plot_Seq, 'on')
            plot(handles.Plot_Seq,single(struct.Mk7)/max(single(struct.Mk7))+11, '-k','LineStyle','--')
            plot(handles.Plot_Seq,single(struct.Mk8)/max(single(struct.Mk8))+12.1, '-k','LineStyle',':')
        end
        
    end
end
hold(handles.Plot_Seq, 'off')
end

function Plot_Data(name,handles)

global data dataParameters

Sig= data.(char(name)).signal;
Ref= data.(char(name)).reference;
Indep=dataParameters.(char(name)).vector;

plot(handles.Plot_Sig_Ref, single(Indep),single(Ref),'-b','LineStyle','--')
hold(handles.Plot_Sig_Ref, 'on')
plot(handles.Plot_Sig_Ref, single(Indep),single(Sig),'-r') 
hold(handles.Plot_Sig_Ref, 'off')

plot(handles.Plot_Sig_Over_Ref, single(Indep),single(Sig./Ref),'-g')
end

function NewStruct = delays(Readout, struct)

Readout;

% 66ns from AWG to MW Stripline
AWG2I = 0;%66; %in waveform points. for 1GHz sampling 1point=1ns
AWG2Q = 0;%66;
AWG2Switch = 0;%12; %12ns after to I and Q, includes cable and switch response time
AWG2AOM = 830; % Measured 1030 on SPCM. -200ns for other factos
AWG2Sig = -200; %Sig is 2ns ahead Ref and 22ns ahead I/Q output. -200 to line up with AOM
AWG2Ref = 0;
Delays.Ch1 = AWG2I;
Delays.Ch2 = AWG2Q;
Delays.Ch3 = 0;
Delays.Ch4 = 0;
Delays.Mk1 = AWG2Switch;
Delays.Mk2 = AWG2AOM;
Delays.Mk3 = AWG2Sig;
Delays.Mk4 = AWG2Ref;
Delays.Mk5 = 0;
Delays.Mk6 = 0;
Delays.Mk7 = 0;
Delays.Mk8 = 0;


if strcmp(Readout,'SPCM')
    %adjust time stamps that need it
    fn = fieldnames(struct);
    for str = fn'
        struct.(char(str))(:,1:2) = struct.(char(str))(:,1:2)-Delays.(char(str))+AWG2AOM;
        %Add AOM delay to everything, and subtract the individual delays
    end
    
    %Wave_generator interprets prepended 0 as 0s until the first explicitly specified time
    %Also, it indicates to Wave_generator to fill 0s from the last
    %specified time to the specified length of the waveform.
    fn = fieldnames(struct);
        for str = fn'
            if length(struct.(char(str))(1,:))==5 %If it's analog
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

function Sentt=SendWF2AWG(samples,len,structure,PreSent,name) 
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
global ChnlCount awg buffer Seq Sent

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
                %Sent=PreSent;
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


%Stitch wave data with marker data as per programmer manual
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
fwrite(awg, '*CLS');
pause(0.05)
fprintf(awg,'%s\n','*ESR?'); %Query to ensure Matlab wait sufficiently
fscanf(awg,'%s');
%AWG_Debug()

%%%%%% clear and write waveform %%%%%% 

fnB = fieldnames(binblock); %get fieldnames (ie. 'Ch#')

cmd=cell(1,length(fnB)); %Create cell to hold commands

fprintf(awg,'%s\n','*ESR?;SYST:ERR?'); %Query to ensure Matlab wait sufficiently
fscanf(awg,'%s');
seqNo=0;
fprintf(awg,'%s\n',['WLIST:WAVEFORM:LENGTH? "' name (fnB{1}) '"']); %find length of waveform on AWG if it's there
lenPre=str2num(fscanf(awg,'%s')); %Will be empty if the waveform isn't there
for n = 1:length(fnB)
    if Sent.(char(name))==0 || isempty(lenPre) || lenPre ~=double(len*samples)
        %Create space for an empty waveform with name and datasize
        fwrite(awg,['WLIST:WAV:DEL "' name (fnB{n}) '";:WLIST:WAV:NEW "' name (fnB{n}) '",' num2str(len*samples) ',real;'])
        seqNo=1; %If have to delete waveforms and reload them, then sequence is automatically cleared
    end
 
    %The Command for transfering data from an external controller to awg. The
    %syntax used here is WLIST:WAVEFORM:DATA <wfm_name>,<block_data>
    cmd{n} = [':wlist:waveform:data "' name (fnB{n}) '",' header binblock.(fnB{n}) ';'];
    %fwrite(awg,'sour1:wav "isoya_sm_ch1_s1"')
end

if seqNo == 1
    Seq.(char(name)) = 0; %Sequence was automatically cleared so have to load a sequence
end
%fwrite(awg, 'WLIST:SIZE? '); 
%check=fscanf(awg,'%s'); % Check size of waveform list
%If all deleted, should return 25

%AWG_Debug()

bytes = length(cmd{1}); % EOIMode applies only to visa objects
if buffer >= bytes  % If buffer can handle it, proceed
    for n=1:length(cmd)
        fwrite(awg,cmd{n}); %Since we are writing to a binary file, we need fwrite
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
   
Sentt=1 ;%The AWG has memory allocated for waveforms of these names
%Sent.(fnB{n})=1; %Return that it succeeded
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


function CreateSeq(loop_standard,loop_count,elem_ind,name)
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

global samples buffer ChnlCount awg Seq dLoop_Standard dLoop_Count DC Amp


%%%%%% DC offset %%%%%% 
fwrite(awg,['sour1:volt:offs ' num2str(DC.Ch1)])
fwrite(awg,['sour2:volt:offs ' num2str(DC.Ch2)])
fwrite(awg,['sour3:volt:offs ' num2str(DC.Ch3)])
fwrite(awg,['sour4:volt:offs ' num2str(DC.Ch4)])
fprintf(awg,'%s\n','*ESR?;SYST:ERR?'); %Query to ensure Matlab wait sufficiently
fscanf(awg,'%s');

%%%%%% amp %%%%%% 
fwrite(awg,['sour1:volt:ampl ' num2str(Amp.Ch1)])
fwrite(awg,['sour2:volt:ampl ' num2str(Amp.Ch2)])
fwrite(awg,['sour3:volt:ampl ' num2str(Amp.Ch3)])
fwrite(awg,['sour4:volt:ampl ' num2str(Amp.Ch4)])
fprintf(awg,'%s\n','*ESR?;SYST:ERR?'); %Query to ensure Matlab wait sufficiently
fscanf(awg,'%s');
fwrite(awg,['sour1:mark1:volt:low ' num2str(DC.Mk1)])
fwrite(awg,['sour1:mark2:volt:low ' num2str(DC.Mk2)])
fwrite(awg,['sour2:mark1:volt:low ' num2str(DC.Mk3)])
fwrite(awg,['sour2:mark2:volt:low ' num2str(DC.Mk4)])
fwrite(awg,['sour3:mark1:volt:low ' num2str(DC.Mk5)])
fwrite(awg,['sour3:mark2:volt:low ' num2str(DC.Mk6)])
fwrite(awg,['sour4:mark1:volt:low ' num2str(DC.Mk7)])
fwrite(awg,['sour4:mark2:volt:low ' num2str(DC.Mk8)])
fprintf(awg,'%s\n','*ESR?;SYST:ERR?'); %Query to ensure Matlab wait sufficiently
fscanf(awg,'%s');
fwrite(awg,['sour1:mark1:volt:high ' num2str(Amp.Mk1)])
fwrite(awg,['sour1:mark2:volt:high ' num2str(Amp.Mk2)])
fwrite(awg,['sour2:mark1:volt:high ' num2str(Amp.Mk3)])
fwrite(awg,['sour2:mark2:volt:high ' num2str(Amp.Mk4)])
fwrite(awg,['sour3:mark1:volt:high ' num2str(Amp.Mk5)])
fwrite(awg,['sour3:mark2:volt:high ' num2str(Amp.Mk6)])
fwrite(awg,['sour4:mark1:volt:high ' num2str(Amp.Mk7)])
fwrite(awg,['sour4:mark2:volt:high ' num2str(Amp.Mk8)])
fprintf(awg,'%s\n','*ESR?;SYST:ERR?'); %Query to ensure Matlab wait sufficiently
fscanf(awg,'%s');
    

if Seq.(char(name)) == 1 && dLoop_Standard == loop_standard && dLoop_Count == loop_count % If sequence is already loaded, don't reload
    %This is especially important for keeping the AOMs warmed up
    return
end

%%%%%% Initialize Instrument %%%%%%
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

%This function is unrecognized for some reason
s = ['SOURCE1:FREQUENCY ' , num2str(samples),'MHz'];
fprintf(awg, '%s\n', s);
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

OutputAWG(1,1,1,1,1) %When loading a new sequence, AWG turns outputs off automatically
% 'AOM Warming Up'
% pause(10); % Permit AOM to warm up

dLoop_Standard = loop_standard ;
dLoop_Count = loop_count ;
Seq=Loop_Remaining_Structure({name}, Seq,0);
Seq.(char(name)) = 1 

end

function CreateInfiniteSeq(name)
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

global samples buffer ChnlCount awg Seq DC Amp

%%%%%% DC offset %%%%%% 
fwrite(awg,['sour1:volt:offs ' num2str(DC.Ch1)])
fwrite(awg,['sour2:volt:offs ' num2str(DC.Ch2)])
fwrite(awg,['sour3:volt:offs ' num2str(DC.Ch3)])
fwrite(awg,['sour4:volt:offs ' num2str(DC.Ch4)])
fprintf(awg,'%s\n','*ESR?;SYST:ERR?'); %Query to ensure Matlab wait sufficiently
fscanf(awg,'%s');

%%%%%% amp %%%%%% 
fwrite(awg,['sour1:volt:ampl ' num2str(Amp.Ch1)])
fwrite(awg,['sour2:volt:ampl ' num2str(Amp.Ch2)])
fwrite(awg,['sour3:volt:ampl ' num2str(Amp.Ch3)])
fwrite(awg,['sour4:volt:ampl ' num2str(Amp.Ch4)])
fprintf(awg,'%s\n','*ESR?;SYST:ERR?'); %Query to ensure Matlab wait sufficiently
fscanf(awg,'%s');
fwrite(awg,['sour1:mark1:volt:low ' num2str(DC.Mk1)])
fwrite(awg,['sour1:mark2:volt:low ' num2str(DC.Mk2)])
fwrite(awg,['sour2:mark1:volt:low ' num2str(DC.Mk3)])
fwrite(awg,['sour2:mark2:volt:low ' num2str(DC.Mk4)])
fwrite(awg,['sour3:mark1:volt:low ' num2str(DC.Mk5)])
fwrite(awg,['sour3:mark2:volt:low ' num2str(DC.Mk6)])
fwrite(awg,['sour4:mark1:volt:low ' num2str(DC.Mk7)])
fwrite(awg,['sour4:mark2:volt:low ' num2str(DC.Mk8)])
fprintf(awg,'%s\n','*ESR?;SYST:ERR?'); %Query to ensure Matlab wait sufficiently
fscanf(awg,'%s');
fwrite(awg,['sour1:mark1:volt:high ' num2str(Amp.Mk1)])
fwrite(awg,['sour1:mark2:volt:high ' num2str(Amp.Mk2)])
fwrite(awg,['sour2:mark1:volt:high ' num2str(Amp.Mk3)])
fwrite(awg,['sour2:mark2:volt:high ' num2str(Amp.Mk4)])
fwrite(awg,['sour3:mark1:volt:high ' num2str(Amp.Mk5)])
fwrite(awg,['sour3:mark2:volt:high ' num2str(Amp.Mk6)])
fwrite(awg,['sour4:mark1:volt:high ' num2str(Amp.Mk7)])
fwrite(awg,['sour4:mark2:volt:high ' num2str(Amp.Mk8)])
fprintf(awg,'%s\n','*ESR?;SYST:ERR?'); %Query to ensure Matlab wait sufficiently
fscanf(awg,'%s');

%%%%%% Initialize Instrument %%%%%%
fprintf(awg,'%s\n','*ESR?'); %Query to ensure Matlab wait sufficiently
fscanf(awg,'%s');

%go to sequence mode
fprintf(awg, '%s\n', 'AWGC:RMOD SEQ');
fprintf(awg,'%s\n','*ESR?'); %Query to ensure Matlab wait sufficiently
fscanf(awg,'%s');

%write waveforms into sequence
fprintf(awg, '%s\n',['SEQ:LENG ' num2str(0) ';:SEQ:LENG ' num2str(1)]); 

fprintf(awg,'%s\n','*ESR?;SYST:ERR?'); %Query to ensure Matlab wait sufficiently
fscanf(awg,'%s');
%Clear sequence first. Then allocate sequence size
%If loading a shorter sequence than the previous, AWG doesn't run

kk=1;
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
fprintf(awg, '%s\n',strcat(seqCmd,';*ESR?;:SYST:ERR?'));
fscanf(awg,'%s');

fprintf(awg, '%s\n',['SEQ:ELEM' num2str(kk) ':LOOP:INFINITE ' num2str(1) ';*ESR?;:SYST:ERR?']);
fscanf(awg,'%s');
%Number of times to loop element is max 65536 if you don't hit the
%waveform memory limit first

%fwrite(awg,['SEQ:ELEM' num2str(loop_standard) ':GOTO:STAT 1']) %%Turns on the GoTo:Index ability for the last element in the sequence
%fwrite(awg,['SEQ:ELEM' num2str(loop_standard) ':GOTO:IND 1']) %%Goes to the first index (index 1) in the last element of the sequence

%This function is unrecognized for some reason
s = ['SOURCE1:FREQUENCY ' , num2str(samples),'MHz'];
fprintf(awg, '%s\n', s);

OutputAWG(1,1,1,1,1)

Seq=Loop_Remaining_Structure({name}, Seq,0);
Seq.(char(name)) = 1 
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

function OutputAWG(outState,ch1, ch2, ch3, ch4)

global samples awg

%%%%%% instrument communication %%%%%%
%%%%%% initialize the instrument %%%%%% 
% fwrite(awg, '*CLS');
% 'AWG Errors Cleared'
% AWG_Debug()

if outState==1
    pause(1)
    %%%%%% switch output on %%%%%% 
    fprintf(awg,['OUTP1 ' num2str(ch1)])
    fprintf(awg,['OUTP2 ' num2str(ch2)])
    fprintf(awg,['OUTP3 ' num2str(ch3)])
    fprintf(awg,['OUTP4 ' num2str(ch4)]) 
%     fprintf(awg, 'AWGC:RUN')
    fprintf(awg, '%s\n','AWGCONTROL:RSTATE?');
    run=str2num(fscanf(awg,'%s'));

else
    %%%%%% switch output off %%%%%% 
%     fwrite(awg, 'AWGC:STOP')
    fwrite(awg,'OUTP1 0')
    fwrite(awg,'OUTP2 0')
    fwrite(awg,'OUTP3 0')
    fwrite(awg,'OUTP4 0') 
    fprintf(awg, '%s\n','AWGCONTROL:RSTATE?');
    run=str2num(fscanf(awg,'%s'));
end

% if run==2
%     'Running'
% elseif run==1
%     'Waiting for Trigger'
% else
%     'Stopped'
% end

end

function RunAWG(runState)

global samples awg

%%%%%% instrument communication %%%%%%
%%%%%% initialize the instrument %%%%%% 
% fwrite(awg, '*CLS');
% 'AWG Errors Cleared'
% AWG_Debug()

if runState==1
    pause(1)
    %%%%%% Run %%%%%% 
    fprintf(awg, 'AWGC:RUN')
    fprintf(awg, '%s\n','AWGCONTROL:RSTATE?');
    run=str2num(fscanf(awg,'%s'));

else
    %%%%%% Stop %%%%%% 
    fwrite(awg, 'AWGC:STOP')
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

function [result, read_time]=ADC_read(NRep,NPulse,num_samp)

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
global Sent Seq

Sent=Loop_Remaining_Structure({}, Sent, 0)
Seq=Loop_Remaining_Structure({}, Seq, 0)

end

function SaveData(name,hObject, eventdata, handles)
%name should be a string

global gSaveData data dataParameters DC Amp

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

fn = fieldnames(dataParameters.(char(name)));

fprintf(fid,[name 'Data\n']);
%Set all elements of structure to specified value

for str = fn'
    if ischar(dataParameters.(char(name)).(char(str)))
        fprintf(fid,['Varying over ' dataParameters.(char(name)).(char(str)) '\n']);
    elseif strcmp(str{1},'vector')
        fprintf(fid,'vector\n');
        fprintf(fid,'%d\t',dataParameters.(char(name)).vector);
        fprintf(fid, '\n');
    elseif strcmp(str{1},'fit')
        fprintf(fid,'fit parameters: amplitude, position, width, background, lsq resnorm\n');
        fprintf(fid,'%d\t',dataParameters.(char(name)).fit);
        fprintf(fid, '\n');
    elseif strcmp(str{1},'sweep_vector')
        fprintf(fid,'sweep vector\n');
        fprintf(fid,'%d\t',dataParameters.(char(name)).vector);
        fprintf(fid, '\n');
    else
        fprintf(fid,[str{1} ' %d \n'], dataParameters.(char(name)).(char(str)));
    end
end
fprintf(fid,'\nData Size: [%.0f %.0f]\n',size([Sig;Ref]));
fprintf(fid,'Signal Vector\n');
fprintf(fid,'%d\t',Sig);
fprintf(fid,'\n Reference Vector \n');
fprintf(fid,'%d\t',Ref);
nts=get(handles.Notes,'String');
fprintf(fid,'\nNotes: %s',nts);
fprintf(fid,'\nTime: %s',datestr(datenum(now), 'yyyy-mm-dd_HH-MM-SS'));

fn = fieldnames(DC);
fprintf(fid,'\n DC or Low Level (V) \n');
for str = fn'
    fprintf(fid,[str{1} ' %d\n'], DC.(char(str)));
end

fn = fieldnames(Amp);
fprintf(fid,'\n Amplitude or High Level (V) \n');
for str = fn'
    fprintf(fid,[str{1} ' %d\n'], Amp.(char(str)));
end

fprintf(fid,'\n Amplitude of I (V) \n');
fprintf(fid, [ handles.Voltage_I.String ' \n']);
fprintf(fid,'\n Amplitude of Q (V) \n');
fprintf(fid, [ handles.Voltage_Q.String ' \n']);
fprintf(fid,'\n MW Power (dBm) \n');
fprintf(fid, [ handles.MW_Power.String ' \n']);
fprintf(fid,'\n MW Frequency (GHz) \n');
fprintf(fid, [ handles.MW_Freq.String ' \n']);
fprintf(fid,'\n MW Pi Pulse (ns) \n');
fprintf(fid, [ handles.MW_Pi_Pulse.String ' \n']);


fclose(fid);

end

function saveFig(name,handles)

global gSaveData data dataParameters fx fxrange fitFnx fit

%Method for saving plots. Create a figure, plot onto that figure, save that
%figure.

Sig= data.(char(name)).signal;
Ref= data.(char(name)).reference;
Indep=dataParameters.(char(name)).vector;

figure(1111) %Make this the current figure

%Save first plot
file = [gSaveData.path strcat(name, ['_Sig_Ref_Plot_' date '.fig'])];
mfile = strrep(file,'.fig','*');
mfilename = strrep(['_Sig_Ref_Plot_' date '.fig'],'.fig','');

A = ls(mfile);
ImgN = 0;
for f = 1:size(A,1)
    sImgN = sscanf(A(f,:),[name mfilename '_Plot%d.fig']);
    if ~isempty(sImgN)
        if sImgN > ImgN
            ImgN = sImgN;
        end
    end
end
ImgN = ImgN + 1;
file = strrep(file,'.fig',sprintf('_Plot%03d.fig',ImgN));
plot(single(Indep),single(Ref),'-b','LineStyle','--')
hold on
plot(single(Indep),single(Sig),'-r') 
hold off
savefig(1111,file)

close(gcf)  %close and reopen in case hold doesn't work
figure(1111) 

%Save second plot
file = [gSaveData.path strcat(name, ['_Sig_Over_Ref_Plot_' date '.fig'])];
mfile = strrep(file,'.fig','*');
mfilename = strrep(['_Sig_Over_Ref_Plot_' date '.fig'],'.fig','');

A = ls(mfile);
ImgN = 0;
for f = 1:size(A,1)
    sImgN = sscanf(A(f,:),[name mfilename '_Plot%d.fig']);
    if ~isempty(sImgN)
        if sImgN > ImgN
            ImgN = sImgN;
        end
    end
end
ImgN = ImgN + 1;
file = strrep(file,'.fig',sprintf('_Plot%03d.fig',ImgN));
plot(single(Indep),single(Sig./Ref),'-bo') 

if fit
    hold on
    plot(single(fxrange),single(fitFnx(fx,fxrange)),'-r')
    hold off
    fit = 0;
end

savefig(1111,file)

close(gcf) %Close figure when done
end

function AWG_Debug()
%Call this function whenever you want to ask the AWG for ESR and errors
% NOTE!!!! It only works if the AWG is already fopened
%Debugging
global awg
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

function User_DC_AMP(DCVal,AmpVal,str)

global dataParameters DC Amp

if strcmp(dataParameters.User.(char(str)).channel(1),'C')
    if strcmp(dataParameters.User.(char(str)).channel(3),'1')
        DC(1)=DCVal; %Offsets of Ch1 2 3 4
        Amp(1)=AmpVal; %Amp of Ch1 2 3 4, and Markers in V
    end
    
    if strcmp(dataParameters.User.(char(str)).channel(3),'2')
        DC(2)=DCVal; %Offsets of Ch1 2 3 4
        Amp(2)=AmpVal; %Amp of Ch1 2 3 4, and Markers in V
    end
    
    if strcmp(dataParameters.User.(char(str)).channel(3),'3')
        DC(3)=DCVal; %Offsets of Ch1 2 3 4
        Amp(3)=AmpVal; %Amp of Ch1 2 3 4, and Markers in V
    end
    
    if strcmp(dataParameters.User.(char(str)).channel(3),'4')
        DC(4)=DCVal; %Offsets of Ch1 2 3 4
        Amp(4)=AmpVal; %Amp of Ch1 2 3 4, and Markers in V
    end
    
elseif strcmp(dataParameters.User.(char(str)).channel(1),'M')
    if strcmp(dataParameters.User.(char(str)).channel(3),'1')||strcmp(dataParameters.User.(char(str)).channel(3),'2')
        'Setting one Marker amplitude and offset sets it for all Markers'
        DC(5)=DCVal; %Offsets of Ch1 2 3 4
        Amp(5)=AmpVal; %Amp of Ch1 2 3 4, and Markers in V
    end
else
    error('Undefined pulse channel')
end

end

function TrackNV(hObject,eventdata)

global Enhanced_Factor

Enhanced_Factor = 0;
warning = 0;
%Extract handles for ImageNVC
ImageNVC_Handles=guidata(findobj(allchild(0), 'Tag', 'maxVx'));

while Enhanced_Factor<0.94 %We don't want to do worse
    ImageFunctionPool('NewTrackFast',hObject,eventdata, ImageNVC_Handles);
    if Enhanced_Factor<0.94
        'Warning: Tracking optimized at 94% of the initial condition'
        warning = warning+1;
        if warning >=6
            error('Lost NV')
        end
        %Halt Experiment?
    end
end

end

function a=Pi_Pulse_Calibrate_Analog(b,n,tau,PiPulse,amp)

a=b; %leave original array unchanged
sz=size(a);
sz=sz(1);
aTemp=a(end,:); %Extract last row of a
a=[a;zeros(2*n,5)]; %preallocate waveform commands

iStart = 1;
iEnd = n;

for i=iStart:iEnd
    
    %Wait for tau before next pulse
    %Create next command in waveform
    aTemp(1)=aTemp(2)+1; %Next time is 1ns after last time
    aTemp(2)=aTemp(1)+tau; %wait tau
    aTemp(3)=0; %wait tau
    aTemp(4)=0; %wait tau
    aTemp(5)=0; %wait tau
    %Add command to waveform
    a(sz+2*i-1,:)=aTemp;
    
    % Create Pi pulse
    aTemp(1)=aTemp(2)+1; %Next time is 1ns after last time
    aTemp(2)=aTemp(1)+PiPulse; %Pi pulse
    aTemp(3) = 0 ;
    aTemp(4)=pi/2; 
    aTemp(5)=amp; 
    a(sz+2*i,:) = aTemp ;
    
end

end

function a=ItXY(b,n,tau,PiPulse)

a=b; %leave original array unchanged
sz=size(a);
sz=sz(1);
aTemp=a(end,:); %Extract last row of a
a=[a;zeros(3*n,3)]; %preallocate waveform commands

for i=1:n
    
    %Wait for tau before next pulse
    %Create next command in waveform
    aTemp(1)=aTemp(2)+1; %Next time is 1ns after last time
    aTemp(2)=aTemp(1)+2*tau; %wait 2tau
    aTemp(3)=0; %wait tau
    %Add command to waveform
    a(sz+3*i-2,:)=aTemp;
    
    % Create Pi pulse
    aTemp(1)=aTemp(2)+1; %Next time is 1ns after last time
    aTemp(2)=aTemp(1)+PiPulse; %Pi pulse
    aTemp(3) = 1 ;
    a(sz+3*i-1,:) = aTemp ;
    
    %Waiit tau and Pi pulse for other phase
    aTemp(1)=aTemp(2)+1; %Next time is 1ns after last time
    aTemp(2)=aTemp(1)+2*tau+PiPulse; %wait tau and pi pulse
    aTemp(3)=0; %wait tau
    %Add command to waveform
    a(sz+3*i,:)=aTemp ;
    
end

end

function a=ItXY_Switch(b,n,tau,PiPulse, firstQ)

a=b; %leave original array unchanged
sz=size(a);
sz=sz(1);
aTemp=a(end,:); %Extract last row of a
a=[a;zeros(2*n,3)]; %preallocate waveform commands

iStart = 1;
iEnd = n;

if firstQ
    i=1;
    iStart = 2;
    %Wait for tau before next pulse
    %Create next command in waveform
    aTemp(1)=aTemp(2)+1; %Next time is 1ns after last time
    aTemp(2)=aTemp(1)+tau-20; %wait tau-100ns
    aTemp(3)=0; %wait tau
    %Add command to waveform
    a(sz+2*i-1,:)=aTemp;
    
    % Create Pi pulse
    if mod(i,2)==0 %Since this function is called twice as much as the iterative
        %functions for I and Q, the +1ns necessary for calling the "Next
        %Time" accumulates into a significant desync error. Combat it here
        %by subtracting 1ns from pulse length every other pulse
        aTemp(1)=aTemp(2)+1; %Next time is 1ns after last time
        aTemp(2)=aTemp(1)+PiPulse+40; %Pi pulse+100ns
        aTemp(3) = 1 ;
        a(sz+2*i,:) = aTemp ;
    else
        aTemp(1)=aTemp(2)+1; %Next time is 1ns after last time
        aTemp(2)=aTemp(1)+PiPulse+19; %Pi pulse+100ns
        aTemp(3) = 1 ;
        a(sz+2*i,:) = aTemp ;
    end
end

for i=iStart:iEnd
    
    %Wait for tau before next pulse
    %Create next command in waveform
    aTemp(1)=aTemp(2)+1; %Next time is 1ns after last time
    aTemp(2)=aTemp(1)+2*tau-40; %wait tau-100ns
    aTemp(3)=0; %wait tau
    %Add command to waveform
    a(sz+2*i-1,:)=aTemp;
    
    % Create Pi pulse
    if mod(i,2)==0 %Since this function is called twice as much as the iterative
        %functions for I and Q, the +1ns necessary for calling the "Next
        %Time" accumulates into a significant desync error. Combat it here
        %by subtracting 1ns from pulse length every other pulse
        aTemp(1)=aTemp(2)+1; %Next time is 1ns after last time
        aTemp(2)=aTemp(1)+PiPulse+40; %Pi pulse+100ns
        aTemp(3) = 1 ;
        a(sz+2*i,:) = aTemp ;
    else
        aTemp(1)=aTemp(2)+1; %Next time is 1ns after last time
        aTemp(2)=aTemp(1)+PiPulse+39; %Pi pulse+100ns
        aTemp(3) = 1 ;
        a(sz+2*i,:) = aTemp ;
    end
    
end

end

function a=ItXY_Analog(b,n,tau,PiPulse,amp,firstQ,lastQ)

a=b; %leave original array unchanged
sz=size(a);
sz=sz(1);
aTemp=a(end,:); %Extract last row of a
a=[a;zeros(3*n,5)]; %preallocate waveform commands

iStart = 1;
iEnd = n;

if firstQ
    i=1;
    iStart = 2;
    %Wait for tau before next pulse
    %Create next command in waveform
    aTemp(1)=aTemp(2)+1; %Next time is 1ns after last time
    aTemp(2)=aTemp(1)+tau; %wait tau
    aTemp(3)=0; %wait tau
    aTemp(4)=0; %wait tau
    aTemp(5)=0; %wait tau
    %Add command to waveform
    a(sz+3*i-2,:)=aTemp;
    
    % Create Pi pulse
    aTemp(1)=aTemp(2)+1; %Next time is 1ns after last time
    aTemp(2)=aTemp(1)+PiPulse; %Pi pulse
    aTemp(3) = 0 ;
    aTemp(4)=pi/2; 
    aTemp(5)=amp; 
    a(sz+3*i-1,:) = aTemp ;
    
    %Waiit tau and Pi pulse for other phase
    aTemp(1)=aTemp(2)+1; %Next time is 1ns after last time
    aTemp(2)=aTemp(1)+2*tau+PiPulse; %wait 2tau and pi pulse
    aTemp(3)=0; %wait tau
    aTemp(4)=0;
    aTemp(5)=0;
    %Add command to waveform
    a(sz+3*i,:)=aTemp ;
end

if lastQ
    iEnd=iEnd-1;
end

for i=iStart:iEnd
    
    %Wait for tau before next pulse
    %Create next command in waveform
    aTemp(1)=aTemp(2)+1; %Next time is 1ns after last time
    aTemp(2)=aTemp(1)+2*tau; %wait 2tau
    aTemp(3)=0; %wait tau
    aTemp(4)=0; %wait tau
    aTemp(5)=0; %wait tau
    %Add command to waveform
    a(sz+3*i-2,:)=aTemp;
    
    % Create Pi pulse
    aTemp(1)=aTemp(2)+1; %Next time is 1ns after last time
    aTemp(2)=aTemp(1)+PiPulse; %Pi pulse
    aTemp(3) = 0 ;
    aTemp(4)=pi/2; 
    aTemp(5)=amp; 
    a(sz+3*i-1,:) = aTemp ;
    
    %Waiit tau and Pi pulse for other phase
    aTemp(1)=aTemp(2)+1; %Next time is 1ns after last time
    aTemp(2)=aTemp(1)+2*tau+PiPulse; %wait 2tau and pi pulse
    aTemp(3)=0; %wait tau
    aTemp(4)=0;
    aTemp(5)=0;
    %Add command to waveform
    a(sz+3*i,:)=aTemp ; 
end

if lastQ
    i = n;
    %Wait for tau before next pulse
    %Create next command in waveform
    aTemp(1)=aTemp(2)+1; %Next time is 1ns after last time
    aTemp(2)=aTemp(1)+2*tau; %wait tau
    aTemp(3)=0; %wait tau
    aTemp(4)=0; %wait tau
    aTemp(5)=0; %wait tau
    %Add command to waveform
    a(sz+3*i-2,:)=aTemp;
    
    % Create Pi pulse
    aTemp(1)=aTemp(2)+1; %Next time is 1ns after last time
    aTemp(2)=aTemp(1)+PiPulse; %Pi pulse
    aTemp(3) = 0 ;
    aTemp(4)=pi/2; 
    aTemp(5)=amp; 
    a(sz+3*i-1,:) = aTemp ;
    
    %Waiit tau before -Pi/2 pulse
    aTemp(1)=aTemp(2)+1; %Next time is 1ns after last time
    aTemp(2)=aTemp(1)+tau; %wait tau
    aTemp(3)=0; %wait tau
    aTemp(4)=0;
    aTemp(5)=0;
    %Add command to waveform
    a(sz+3*i,:)=aTemp ; 
end

end

function ESRfit(handles)
global data dataParameters fx fxrange fitFnx fit

sig=data.ESR.signal/10^6;

lorB=@(x,xdata) x(1)*(((xdata-x(2))/x(3)).^2+1).^-1+x(4);
fitFnx=lorB;

xrange=dataParameters.ESR.vector/10^9;

fx = lsqcurvefit(lorB,[-1,xrange(round(length(xrange)/2)),0.02,1],xrange,sig);
dataParameters.ESR.fit=fx;

fxrange=xrange(1):(xrange(2)-xrange(1))/100:xrange(end);

plot(handles.Plot_Sig_Over_Ref, single(fxrange),single(lorB(fx,fxrange)),'-r')
hold(handles.Plot_Sig_Over_Ref, 'on')
plot(handles.Plot_Sig_Over_Ref, single(xrange),single(sig),'-bo') 
hold(handles.Plot_Sig_Over_Ref, 'off')
fit = true;
end

function Rabifit(handles)
global data dataParameters fx fxrange fitFnx fit

sig=data.Rabi.signal./data.Rabi.reference;

sinB=@(x,xdata) x(1)*sin(2*3.14159265359*(x(2)*xdata-x(3))).*exp(-x(5)*xdata)+x(4);
fitFnx = sinB ;

xrange= dataParameters.Rabi.vector;

%Find appropriate frequencies
sampFreq=1/dataParameters.Rabi.step ;

norm=100;
for ifreq=0:3
    freq = 10^-ifreq;
    [fxN,normN] = lsqcurvefit(sinB,[(max(sig)-min(sig))/2,freq,pi/2,mean(sig),freq/2],xrange,sig,[0,0,-1,0,0],[10^6,sampFreq/2,1,10^10,10^10]);
    if normN<norm
        norm=normN;
        fx=fxN;
    end        
end

dataParameters.Rabi.fit=[fx,norm];

fxrange=xrange(1):(xrange(2)-xrange(1))/100:xrange(end);

plot(handles.Plot_Sig_Over_Ref, single(fxrange),single(sinB(fx,fxrange)),'-r')
hold(handles.Plot_Sig_Over_Ref, 'on')
plot(handles.Plot_Sig_Over_Ref, single(xrange),single(sig),'-bo') 
hold(handles.Plot_Sig_Over_Ref, 'off')
fit = true;
end

function Pi_Pulse_Calibratefit(handles)
global data dataParameters fx fxrange fitFnx fit

sig=data.Pi_Pulse_Calibrate.signal/10^6;

lorB=@(x,xdata) x(1)*(((xdata-x(2))/x(3)).^2+1).^-1+x(4);
fitFnx=lorB;

xrange=dataParameters.Pi_Pulse_Calibrate.vector;

fx = lsqcurvefit(lorB,[-1,xrange(round(length(xrange)/2)),0.02,1],xrange,sig);
dataParameters.Pi_Pulse_Calibrate.fit=fx;

fxrange=xrange(1):(xrange(2)-xrange(1))/100:xrange(end);

plot(handles.Plot_Sig_Over_Ref, single(fxrange),single(lorB(fx,fxrange)),'-r')
hold(handles.Plot_Sig_Over_Ref, 'on')
plot(handles.Plot_Sig_Over_Ref, single(xrange),single(sig),'-bo') 
hold(handles.Plot_Sig_Over_Ref, 'off')
fit = true;
end

function Stop(handles)
global bGo;

bGo = false;
end

function clearFPGA()

global Detector

'Clearing FPGA. Ignore Warnings'
readData = 1;
fwrite(Detector,[0;0]);
while ~isempty(readData)
   readData = readCounter(Detector,1,1,'seq');
end
end

function tooManyIterations
    % Create a figure and axes
    f = figure(1010);

    % Create static text
    txtFig = uicontrol('Style', 'text', 'String', ['Loop Standard and Loop Count were set high for this sort of measurement (>10^6 total measurements). Are you sure you want to continue?'],...
        'Position', [140 180 300 50]) ;
    
   % Create push buttons
    btnY = uicontrol('Style', 'pushbutton', 'String', 'Yes',...
        'Position', [220 160 50 20],...
        'Callback', @absolutely);   
    
    btnN = uicontrol('Style', 'pushbutton', 'String', 'No',...
        'Position', [320 160 50 20],...
        'Callback', @doubtful);  
    
    function absolutely(source, callbackdata)
        global yn
        yn=1;
        close(1010)
    end

    function doubtful(source, callbackdata)
        global yn
        yn=0;
        close(1010)
    end
end