function Rabi(min, max, step)

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

dataParameters.Rabi.min=min;
dataParameters.Rabi.max=max;
dataParameters.Rabi.step=step ;
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
    
        
    if ancillaRef(i)>TheoreticalThreshold
        data.Rabi.signal(i)=ancillaSig(i);
        data.Rabi.reference(i)=ancillaRef(i);
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