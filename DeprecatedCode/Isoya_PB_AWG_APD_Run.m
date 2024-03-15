function Isoya_PB_AWG_APD_Run(hObject, eventdata, handles)
global Inputs

%% define MW frequencies and powers

% should currently not be changed
Inputs.pow1 = 14; % dBm
Inputs.pow2 = 14; % dBm

Inputs.MW1 = 1; % 1=on, 0=off
Inputs.MW2 = 1; % 1=on, 0=off

%%% B = (-300/200/-100)
% Inputs.freq1 = 2.551; % GHz group A
% Inputs.freq2 = 2.686; % GHz group B,C,D

%%% B = (-300/200/-5)
% Inputs.freq1 = 2.577; % t_pi = 50
% Inputs.freq1 = 2.615; 
% Inputs.freq2 = 2.853; 

%%% B = (125/125/125)
% Inputs.freq1 = 2.663; 
% Inputs.freq2 = 3.074; 

Inputs.freq1 = 3.497; 
Inputs.freq2 = 2.244; 

% Inputs.freq1 = 2.87;
% Inputs.freq2 = 3.1;

% %%% B = (360/-330/-360)
% Inputs.freq1 = 2.26; % GHz group A
% Inputs.freq2 = 2.828; % GHz group B,C,D

%%% B = (180/-165/-180)
% Inputs.freq1 = 2.566; % GHz group A
% Inputs.freq1 = 3.474; % GHz group A (m = -1)
% Inputs.freq2 = 2.266; % GHz group A (m = +1)

%%% B = (460/-200/-230) @ 2015/08/31
% Inputs.freq1 = 2.973; % GHz 
% Inputs.freq2 = 3.076; % GHz 

%%% B = (200/-185/-200) @ 2015/08/11
% Inputs.freq1 = 2.533; % GHz 
% Inputs.freq2 = 2.813; % GHz 
 
%%% B = (200/-85/100) @ 2015/08/21
% Inputs.freq1 = 2.634; % GHz 
% Inputs.freq2 = 2.816; % GHz 

%%% B = (200/-85/-100) @ 2015/10/16
% Inputs.freq1 = 2.778; % GHz 
% Inputs.freq2 = 2.816; % GHz 

%%% B = (160/-80/-160) @ 2015/08/21
% Inputs.freq1 = 2.64; % GHz 
% Inputs.freq2 = 2.76; % GHz 

SetMWPower('ON');

%% increase nCount if there are reference counters

if Inputs.AddContrast && ~isfield(Inputs,'AddContrastMod')
    Inputs.nCount = Inputs.nCount + 2*Inputs.AddContrast;
    Inputs.AddContrastMod=1;
elseif Inputs.AddContrastAll && ~isfield(Inputs,'AddContrastMod')
    Inputs.nCount = 2*Inputs.nCount;
    Inputs.AddContrastMod=1;
elseif Inputs.AddContrast && isfield(Inputs,'AddContrastMod')
    error('please recompile!')
elseif Inputs.AddContrastAll && isfield(Inputs,'AddContrastMod')
    error('please recompile!')
end

%% setting configurations
Inputs.bReloadSeq = get(handles.bSeqReload,'Value');    % reload seq if AWG sequence should be refreshed
Inputs.bTrack = get(handles.bTracking,'Value');         % if tracking is needed
Inputs.GreenPowDev = 'Dev1/ai3';                        % Green Power Measurement
Inputs.TrackType = 'beam_fast'; % 'point';           % Tracking type
Inputs.TrackThres = 0.15;                                % Tracking threshold depending on the current cts (below 0.8 and above 1.2)
Inputs.bApdRig = get(handles.bAPDrig, 'Value');         % indicate if APD RIG should be used

set(handles.text1,'String','running...')
set(handles.text1,'ForegroundColor',[0 0.5 0])

disp(' ')
disp('--- Measurement initialized...')

%% setting AWG
if Inputs.bSweepwf
    global Compiler_loop_total
    Inputs.SeqSteps = length(Compiler_loop_total);
end
awg_trans_t=Inputs.SeqSteps/900*132;                                            % estimated from experience
disp(['Sending waveform data to AWG (~' num2str(round(awg_trans_t)) 's)...'])

Inputs.seq_timeout = Inputs.timeout * 1.2;
Inputs.NPulse=Inputs.nCount*Inputs.npoints;                                     % get the number of readout pulses
if Inputs.bBrightMeasure
    Inputs.NPulse=Inputs.nCount_all*Inputs.npoints;
end

%% define output variables
DefineOutputVariable(hObject, eventdata, handles);

%% load AWG sequence

% Switch_Readout();                 % use pb0 for jims box instead of SPCAPD

if ~Inputs.bSweepwf
    if Inputs.bReloadSeq
        Load_AWG_Sequence();        % load sequence
    end
end

%% run sequence and get data
Run_Data_Acquisition(hObject, eventdata, handles);

%% save measured data

Inputs.GreenPower = (Inputs.GreenVolt-0.02311)/(1.0549-0.02311)*40.7;
global gIsoya_PD
gIsoya_PD.SequenceInfo = Inputs;

% Save Data
SaveData();

%% turn off AWG and MW

% Switch_Readout();
SetMWPower('OFF');
OutputAWG(0);

%% finish run

set(handles.stop,'Value',0);
set(handles.text1,'String','ready!')
set(handles.text1,'ForegroundColor',[0 0 0])

disp('Goodbye!')
disp(' ')

end

%% Function Library

function SetMWPower(flag)
global Inputs

MW1 = Inputs.MW1;
MW2 = Inputs.MW2;

if MW1
    if strcmp(flag, 'ON')
        SetSG1(Inputs.pow1,Inputs.freq1,1);
    else 
        SetSG1(Inputs.pow1,Inputs.freq1,0);
    end
end
if MW2
    if strcmp(flag, 'ON')
        SetSG2(Inputs.pow2,Inputs.freq2,1);
    else
        SetSG2(Inputs.pow2,Inputs.freq2,0);
    end
end

end

function DefineOutputVariable(hObject, eventdata, handles)
    
clear gIsoya_PD;
global gIsoya_PD Inputs Readout
gIsoya_PD = [];
gIsoya_PD.raw = [];
gIsoya_PD.avr = [];
gIsoya_PD.misc = [];

if strcmp(Readout,'Jim')
    %ADC parameters
    Inputs.num_samp = 20;
    Inputs.ign_pts = 3;         %how many points should be ignored, including first >0 point
    Inputs.read_pts = 10; 
end

if Inputs.bSweepwf
    global Compiler_Seq_Cell_total Trigger_Seq
    gIsoya_PD.Compiler_Seq_Cell_total=Compiler_Seq_Cell_total;
    gIsoya_PD.Trigger_Seq = Trigger_Seq;
else
    global Compiler_Seq Trigger_Seq
    gIsoya_PD.Compiler_Seq = Compiler_Seq;
    gIsoya_PD.Trigger_Seq = Trigger_Seq;
end

gIsoya_PD.SequenceInfo = Inputs;

end

function BackupData()  

global gIsoya_PD

FileName = ['BackUpData'];

BackupPath = ['C:\jmaze\matlab\Experiment\Data\IsoyaData\' FileName '.mat'];
BackupPath_DropBox = ['C:\Users\BlackDiamond\Dropbox\SharedFlies\IsoyaSample\Data\' FileName '.mat'];

save(BackupPath, 'gIsoya_PD', '-mat');
save(BackupPath_DropBox, 'gIsoya_PD', '-mat');

end

function SaveData()

global gIsoya_PD

FileName = datestr(datenum(now), 'yyyy-mm-dd_HH-MM-SS');

BackupPath = ['C:\jmaze\matlab\Experiment\Data\IsoyaData\' FileName '.mat'];
BackupPath_DropBox = ['C:\Users\BlackDiamond\Dropbox\SharedFlies\IsoyaSample\Data\' FileName '.mat'];

save(BackupPath, 'gIsoya_PD', '-mat');
save(BackupPath_DropBox, 'gIsoya_PD', '-mat');

disp(['Data saved as: ' BackupPath_DropBox '.mat'])

end

function Voltage = ReadGreenVoltage(Device)
    DAQmx_Val_Volts= 10348;         % measure volts
    DAQmx_Val_Cfg_Default =-1;      % Default

    [ status, TaskName, taskHandle ] = DAQmxCreateTask([]);
    status = DAQmxCreateAIVoltageChan(taskHandle,Device,'',DAQmx_Val_Cfg_Default,-10.0,10.0,DAQmx_Val_Volts,[]);
    [status, Voltage] = DAQmxReadAnalogScalarF64(taskHandle);
    status = DAQmxClearTask(taskHandle);

    if status ~= 0
        disp(['Error in reading voltage in Device ' Device]);
    else
        disp(['Green Power from PD: ', num2str(Voltage) ' Volt, ', num2str((Voltage-0.02311)/(1.0549-0.02311)*40.7), ' uW'])
    end
end

function Run_Data_Acquisition(hObject, eventdata, handles)

global Readout Inputs
disp('Acquisition running...')

if strcmp(Readout,'Jim')
 
    % run AWG sequence
    if ~Inputs.bSweepwf
        Run_AWG_Sequence();
    end
    % readout
    Run_ADC_for_DataAcquisition(hObject, eventdata, handles);
    
elseif strcmp(Readout,'DAQ')
    
    % run sequence
    if ~Inputs.bSweepwf
        Run_AWG_Sequence();
    end
    % readout
    Run_DAQ_for_DataAcquisition(hObject, eventdata, handles);
    
end

end

function Run_DAQ_for_DataAcquisition(hObject, eventdata, handles)

global Inputs gPosOriginal gScan gCPS

gCPS=0;
curr_it=1;
if Inputs.bSweepwf && curr_it == 1
    global Trigger_Seq Trigger_Seq_length
    global Compiler_Seq_Cell_total Compiler_Seq_length gNrepeat Compiler_loop_total
    Compiler_Seq_index = cumsum(Compiler_Seq_length);

    Trigger_Seq_Total = Trigger_Seq;
    Trigger_Seq_index = cumsum(Trigger_Seq_length);
end

sweep_it_track=1;
while (get(handles.stop,'Value')) == 0 %&& (curr_it <= 50)
    
    if Inputs.bTrack %&& mod(curr_it,Inputs.TrackInt)==1
        if curr_it == 1
            gPosOriginal.X = gScan.FixVx;
            gPosOriginal.Y = gScan.FixVy;
            gPosOriginal.Z = gScan.FixVz;
        end
        if ~Inputs.bSweepwf     % all-in-one seq
            if curr_it==1                                                                       % for the first run                                    
                Isoya_track(Inputs.TrackType,curr_it,hObject, eventdata, handles)               % start tracking
                PBFunctionPool('PBON',2^5);                                                     % green on
                pause(0.5)
                gCPS = MeasureCounts();                                                         % measure initial photon count (reference)
                
                Inputs.GreenVolt = [Inputs.GreenVolt ReadGreenVoltage(Inputs.GreenPowDev)];     % measure initial green voltage
                pause(0.5)
                PBFunctionPool('PBON',0);                                                       % green off
            
            else                                                                                % later times
                PBFunctionPool('PBON',2^5);                                                     % green on
                pause(0.5)
                curr_CPS = MeasureCounts();                                                     % measure current photon count
                if curr_CPS<(1-Inputs.TrackThres)*gCPS || curr_CPS>(1+Inputs.TrackThres)*gCPS   % compare with reference
                    Isoya_track(Inputs.TrackType,curr_it,hObject, eventdata, handles)           
                    PBFunctionPool('PBON',2^5);
                    pause(0.5)
                    gCPS = MeasureCounts();
                elseif mod(curr_it,Inputs.bTrackingInterval) == 0                               % if current iteration number matches with the tracking period
                    Isoya_track(Inputs.TrackType,curr_it,hObject, eventdata, handles)
                    PBFunctionPool('PBON',2^5);
                    pause(0.5)
                    gCPS = MeasureCounts();
                end
                Inputs.GreenVolt = [Inputs.GreenVolt ReadGreenVoltage(Inputs.GreenPowDev)];     % measure current green voltage
                pause(0.5)
                PBFunctionPool('PBON',0);                                                       % green off
            end
        elseif Inputs.bSweepwf              % waveform sweeping
            if curr_it==1
                PBFunctionPool('PBON',2^5);
                pause(0.5)
                Isoya_track(Inputs.TrackType,curr_it,hObject, eventdata, handles)
                PBFunctionPool('PBON',2^5);
                pause(0.5)
                gCPS = MeasureCounts();
                
                Inputs.GreenVolt = [Inputs.GreenVolt ReadGreenVoltage(Inputs.GreenPowDev)];
                pause(0.5)
                PBFunctionPool('PBON',0);
            else
                PBFunctionPool('PBON',2^5);
                pause(0.5)
                curr_CPS = MeasureCounts();
                if curr_CPS<(1-Inputs.TrackThres)*gCPS || curr_CPS>(1+Inputs.TrackThres)*gCPS
                    Isoya_track(Inputs.TrackType,curr_it,hObject, eventdata, handles)
                    PBFunctionPool('PBON',2^5);
                    pause(0.5)
                    gCPS = MeasureCounts();
                elseif mod(curr_it,Inputs.bTrackingInterval) == 0
                    Isoya_track(Inputs.TrackType,curr_it,hObject, eventdata, handles)
                    PBFunctionPool('PBON',2^5);
                    pause(0.5)
                    gCPS = MeasureCounts();
                end
                Inputs.GreenVolt = [Inputs.GreenVolt ReadGreenVoltage(Inputs.GreenPowDev)];
                pause(0.5)
                PBFunctionPool('PBON',0);
                
            end
        end
    end
    
    %%% wavefrom sweeping mode
    if Inputs.bSweepwf              
        
        volts=zeros(1,Inputs.NPulse);
        for i = 1:Inputs.npoints
            
            if i ~= 1 && Inputs.bTrack
                PBFunctionPool('PBON',2^5);
                pause(0.5)
                curr_CPS = MeasureCounts();
                if curr_CPS<(1-Inputs.TrackThres)*gCPS || curr_CPS>(1+Inputs.TrackThres)*gCPS
                    Isoya_track(Inputs.TrackType,curr_it,hObject, eventdata, handles)
                    PBFunctionPool('PBON',2^5);
                    pause(0.5)
                    gCPS = MeasureCounts();
                elseif strcmp(Inputs.TrackType,'beam_fast')
                    Isoya_track(Inputs.TrackType,curr_it,hObject, eventdata, handles)
                    PBFunctionPool('PBON',2^5);
                    pause(0.5)
                    gCPS = MeasureCounts();
                end
                Inputs.GreenVolt = [Inputs.GreenVolt ReadGreenVoltage(Inputs.GreenPowDev)];
                pause(0.5)
                PBFunctionPool('PBON',0);
            end
            
            if mod(i,20) == 0
                BackupData();
            end

            
            % start to measure sequence preparation time
            tic;
            
            pause(0.1)
            if get(handles.stop,'Value') == 1, break; end
            pause(0.1)
            
            % define the trigger pulse for each time step
            if i == 1
                Trigger_Seq = Trigger_Seq_Total(1:Trigger_Seq_index(i),:);
            else
                Trigger_Seq = Trigger_Seq_Total(Trigger_Seq_index(i-1)+1:Trigger_Seq_index(i),:);
            end
            
            % load the particular AWG sequence
            if i == 1
                Inputs.Seq_Cell = Compiler_Seq_Cell_total(1:Compiler_Seq_index(i));
                Inputs.Loops = Compiler_loop_total(1:Compiler_Seq_index(i));
            else
                Inputs.Seq_Cell = Compiler_Seq_Cell_total(Compiler_Seq_index(i-1)+1:Compiler_Seq_index(i));
                Inputs.Loops = Compiler_loop_total(Compiler_Seq_index(i-1)+1:Compiler_Seq_index(i));
            end
            
            % if frequency is swept
            if Inputs.bSweepFreq
                SetMWPower('OFF');
                pause(0.2)
                Inputs.freq2 = Inputs.bSweepFreqList(i);
                SetMWPower('ON');
            end
            
            % load and run the AWG sequence            
            Load_AWG_Sequence();
            pause(0.2)
            Run_AWG_Sequence();
            pause(0.2)
            
            % load the PB sequence
            Load_PB_Sequence();
            pause(0.2)
            
            TotalNSamples = Inputs.nSamples * Inputs.nCount;
            
            %%%%%% Prepare Main Counter %%%%%%
            task = SetPulseWidthMeas('Dev1/ctr0',TotalNSamples);
            
            %%%%%% Prepare APD RIG Counter %%%%%%
            if Inputs.bApdRig
                task1 = SetPulseWidthMeas2('Dev2/ctr0',2*TotalNSamples);
                task2 = SetPulseWidthMeas2('Dev2/ctr1',2*TotalNSamples);
                task3 = SetPulseWidthMeas2('Dev2/ctr2',2*TotalNSamples);
                task4 = SetPulseWidthMeas2('Dev2/ctr3',2*TotalNSamples);
            end
            
            status = DAQmxStartTask(task);
            DAQmxErr(status);
            
            if Inputs.bApdRig
                status = DAQmxStartTask(task1);
                DAQmxErr(status);
                status = DAQmxStartTask(task2);
                DAQmxErr(status);
                status = DAQmxStartTask(task3);
                DAQmxErr(status);
                status = DAQmxStartTask(task4);
                DAQmxErr(status);
            end
            
            % measure the sequence preparation time
            tprep=toc;
            disp(['Sequence preparation took ' num2str(round(tprep)) ' seconds!'])
            
            % run PB
            Run_PB_Sequence();
            
            % update timeout
            if Inputs.bWaitTime
                time_out = (Inputs.nSamples*(Inputs.nCount+gNrepeat+1)*(Inputs.bWaitTime + Inputs.sweepvec(i) + Inputs.EndAdd + Inputs.GreenPrePulseLen + Inputs.gr_ton)*1e-9)*1.5;
            else
                time_out = (Inputs.nSamples*(Inputs.nCount+gNrepeat+1)*(Inputs.sweepvec(i) + Inputs.EndAdd + Inputs.gr_ton)*1e-9)*1.5;
            end
            disp(['Sequence averaging took ' num2str(round(time_out/1.5)) ' seconds!'])
            
            if time_out/1.5 < tprep
                disp('CAREFUL, YOU ARE WASTING TIME!')
            end
            
            %%%%%% Readout counters from DAQ %%%%%%
            [A,sCounter] = ReadCounters(task,TotalNSamples,time_out);
            RawData = A.Ctr0;
            
            StopCounter(task);
            DAQmxClearTask(task);
            ClearCounters(task);
            
            if Inputs.bApdRig
                [A,sCounter] = ReadCounters2(task1,2*TotalNSamples,time_out);
                RawData1=diff(A);
                RawData1_fin=RawData1(1:2:end);
                
                [A,sCounter] = ReadCounters2(task2,2*TotalNSamples,time_out);
                RawData2=diff(A);
                RawData2_fin=RawData2(1:2:end);
                
                [A,sCounter] = ReadCounters2(task3,2*TotalNSamples,time_out);
                RawData3=diff(A);
                RawData3_fin=RawData3(1:2:end);
                
                [A,sCounter] = ReadCounters2(task4,2*TotalNSamples,time_out);
                RawData4=diff(A);
                RawData4_fin=RawData4(1:2:end);
                
                StopCounter(task1);
                DAQmxClearTask(task1);
                ClearCounters(task1);
                
                StopCounter(task2);
                DAQmxClearTask(task2);
                ClearCounters(task2);
                
                StopCounter(task3);
                DAQmxClearTask(task3);
                ClearCounters(task3);
                
                StopCounter(task4);
                DAQmxClearTask(task4);
                ClearCounters(task4);
            end
            
            %%%%%% Here Process rawdata %%%%%%
            scaling = 1e9 / Inputs.DAQcounterlength;
            counts_main = scaling * mean(reshape(RawData, Inputs.nCount, Inputs.nSamples), 2)';
            if Inputs.bApdRig
                counts_1 = scaling * mean(reshape(RawData1_fin, Inputs.nCount, Inputs.nSamples), 2)';
                counts_2 = scaling * mean(reshape(RawData2_fin, Inputs.nCount, Inputs.nSamples), 2)';
                counts_3 = scaling * mean(reshape(RawData3_fin, Inputs.nCount, Inputs.nSamples), 2)';
                counts_4 = scaling * mean(reshape(RawData4_fin, Inputs.nCount, Inputs.nSamples), 2)';
                volts(Inputs.nCount*(i-1)+1:Inputs.nCount*(i-1)+Inputs.nCount) =  mean([counts_main;counts_1;counts_2;counts_3;counts_4],1);
            else
                volts(Inputs.nCount*(i-1)+1:Inputs.nCount*(i-1)+Inputs.nCount) =  counts_main;
            end
            PlotResults(curr_it, volts);
            
            sweep_it_track=sweep_it_track+1;
            
        end
        
        
    %%% all-in-one sequence mode
    else
        
        Load_PB_Sequence();
        pause(0.2)
        
        if curr_it==1
            disp(['Data acquisition takes ' num2str(Inputs.seq_timeout) ' seconds'])
        end
        
        TotalNSamples = Inputs.nSamples * Inputs.NPulse;
        
        %%%%%% Prepare Main Counter %%%%%%
        task = SetPulseWidthMeas('Dev1/ctr0',TotalNSamples);
        
        %%%%%% Prepare APD RIG Counter %%%%%%
        if Inputs.bApdRig
            task1 = SetPulseWidthMeas2('Dev2/ctr0',2*TotalNSamples);
            task2 = SetPulseWidthMeas2('Dev2/ctr1',2*TotalNSamples);
            task3 = SetPulseWidthMeas2('Dev2/ctr2',2*TotalNSamples);
            task4 = SetPulseWidthMeas2('Dev2/ctr3',2*TotalNSamples);
        end
        
        status = DAQmxStartTask(task);
        DAQmxErr(status);
        
        if Inputs.bApdRig
            status = DAQmxStartTask(task1);
            DAQmxErr(status);
            status = DAQmxStartTask(task2);
            DAQmxErr(status);
            status = DAQmxStartTask(task3);
            DAQmxErr(status);
            status = DAQmxStartTask(task4);
            DAQmxErr(status);
        end
        
        %run PB
        Run_PB_Sequence();
        
        %update timeout
        time_out = Inputs.seq_timeout;
        
        %%%%%% Readout counters from DAQ %%%%%%
        [A,sCounter] = ReadCounters(task,TotalNSamples,time_out);
        RawData = A.Ctr0;
        
        StopCounter(task);
        DAQmxClearTask(task);
        ClearCounters(task);
        
        if Inputs.bApdRig
            [A,sCounter] = ReadCounters2(task1,2*TotalNSamples,time_out);
            RawData1=diff(A);
            RawData1_fin=RawData1(1:2:end);
            
            [A,sCounter] = ReadCounters2(task2,2*TotalNSamples,time_out);
            RawData2=diff(A);
            RawData2_fin=RawData2(1:2:end);
            
            [A,sCounter] = ReadCounters2(task3,2*TotalNSamples,time_out);
            RawData3=diff(A);
            RawData3_fin=RawData3(1:2:end);
            
            [A,sCounter] = ReadCounters2(task4,2*TotalNSamples,time_out);
            RawData4=diff(A);
            RawData4_fin=RawData4(1:2:end);
            
            StopCounter(task1);
            DAQmxClearTask(task1);
            ClearCounters(task1);
            
            StopCounter(task2);
            DAQmxClearTask(task2);
            ClearCounters(task2);
            
            StopCounter(task3);
            DAQmxClearTask(task3);
            ClearCounters(task3);
            
            StopCounter(task4);
            DAQmxClearTask(task4);
            ClearCounters(task4);
        end
        
        scaling = 1e9 / Inputs.DAQcounterlength;
        counts_main = scaling * mean(reshape(RawData, Inputs.NPulse, Inputs.nSamples), 2)';
        
        if Inputs.bApdRig
            counts_1 = scaling * mean(reshape(RawData1_fin, Inputs.NPulse, Inputs.nSamples), 2)';
            counts_2 = scaling * mean(reshape(RawData2_fin, Inputs.NPulse, Inputs.nSamples), 2)';
            counts_3 = scaling * mean(reshape(RawData3_fin, Inputs.NPulse, Inputs.nSamples), 2)';
            counts_4 = scaling * mean(reshape(RawData4_fin, Inputs.NPulse, Inputs.nSamples), 2)';
            
            volts = mean([counts_main;counts_1;counts_2;counts_3;counts_4],1);
        else
            volts = counts_main;
        end
        
        PlotResults(curr_it, volts);
        
        sweep_it_track=sweep_it_track+1;
        
    end
    
    BackupData();
    
    curr_it=curr_it+1;
end

disp('Stopping...')

end

function Run_ADC_for_DataAcquisition(hObject, eventdata, handles)

global Inputs

curr_it=1;
if Inputs.bSweepwf && curr_it == 1
    global Trigger_Seq Trigger_Seq_length
    global Compiler_Seq_Cell_total Compiler_Seq_length gNrepeat Compiler_loop_total
    Compiler_Seq_index = cumsum(Compiler_Seq_length);
    
    Trigger_Seq_Total = Trigger_Seq;
    Trigger_Seq_index = cumsum(Trigger_Seq_length);
end
while (get(handles.stop,'Value') == 0)
    
    if Inputs.bTrack && mod(curr_it,Inputs.TrackInt)==1
        PBFunctionPool('PBON',2^5);
        pause(0.5)
        Isoya_track(Inputs.TrackType,curr_it,hObject, eventdata, handles)
        PBFunctionPool('PBON',0);
        pause(0.5)
    end
    
    if Inputs.bSweepwf
        
        if curr_it==1
            disp(['Data acquisition takes ' num2str(Inputs.seq_timeout) ' seconds'])
        end
        
        volts=zeros(1,Inputs.NPulse);
        for i = 1:Inputs.npoints
            
            if get(handles.stop,'Value') == 1, break; end
            
            % define the trigger pulse for each time step
            if i == 1
                Trigger_Seq = Trigger_Seq_Total(1:Trigger_Seq_index(i),:);
            else
                Trigger_Seq = Trigger_Seq_Total(Trigger_Seq_index(i-1)+1:Trigger_Seq_index(i),:);
            end
            
            % Load the particular AWG sequence
            if i == 1
                Inputs.Seq_Cell = Compiler_Seq_Cell_total(1:Compiler_Seq_index(i));
                Inputs.Loops = Compiler_loop_total(1:Compiler_Seq_index(i));
            else
                Inputs.Seq_Cell = Compiler_Seq_Cell_total(Compiler_Seq_index(i-1)+1:Compiler_Seq_index(i));
                Inputs.Loops = Compiler_loop_total(Compiler_Seq_index(i-1)+1:Compiler_Seq_index(i));
            end
            
            Load_AWG_Sequence();
            pause(0.2)
            % Run the loaded AWG sequence
            Run_AWG_Sequence();
            pause(0.2)
            
            Load_PB_Sequence();
            pause(0.2)
            
            ADC_init(Inputs.nSamples,Inputs.nCount);
            pause(0.2)
            
            %run PB
            Run_PB_Sequence();
            
            %update timeout
            pause(max(1,Inputs.nSamples*(Inputs.nCount+gNrepeat+1)*(Inputs.sweepvec(i) + Inputs.EndAdd + Inputs.gr_ton)*1e-9)*1.2)
            
            [data read_time] = ADC_read(Inputs.nSamples,Inputs.nCount,Inputs.num_samp);
            
            data(find(data>1))=0;
            data(find(data<0.02))=0;
            color2 = [rand rand rand];
            for m=1:Inputs.nCount
                i_l=(m-1)*Inputs.num_samp+1;
                i_u=m*Inputs.num_samp;
                rel_data=data(i_l:i_u);
                ind = find(rel_data, 1);
                rel_data_pts=rel_data(ind+Inputs.ign_pts+1:ind+Inputs.ign_pts+Inputs.read_pts-2);
                
                volts(Inputs.nCount*(i-1)+m) = mean(rel_data_pts);
            end
            PlotResults(curr_it, volts);
        end
        
        
    else
        
        if curr_it==1
            disp(['Data acquisition takes ' num2str(Inputs.seq_timeout) ' seconds'])
        end
        
        Load_PB_Sequence();
        pause(0.2)
        
        ADC_init(Inputs.nSamples,Inputs.NPulse);
        pause(0.2)
        
        %run PB
        Run_PB_Sequence();
        
        pause(1.2*Inputs.seq_timeout)
        
        [data read_time] = ADC_read(Inputs.nSamples,Inputs.NPulse,Inputs.num_samp);
        
        figure(1000)
        plot(data)
        
        data(find(data>1))=0;
        data(find(data<0.02))=0;
        volts=zeros(1,Inputs.NPulse);
        for m=1:Inputs.NPulse
            i_l=(m-1)*Inputs.num_samp+1;
            i_u=m*Inputs.num_samp;
            rel_data=data(i_l:i_u);
            ind = find(rel_data, 1);
            rel_data_pts=rel_data(ind+1+Inputs.ign_pts:ind+Inputs.ign_pts+Inputs.read_pts-2);
            volts(m)=mean(rel_data_pts);
        end
        PlotResults(curr_it, volts);
    end
    
    BackupData();
    
    curr_it=curr_it+1;
end

disp('Stopping...')


 
end

function PlotResults(curr_it, volts)

global Inputs gIsoya_PD 
 
    plotcode=Inputs.plotString;
    if Inputs.bBrightMeasure
        nCounters = Inputs.nCount_all;
    else
        nCounters = Inputs.nCount;
    end
    
    if Inputs.bSweepwf
        if length(volts(volts>0)) == nCounters
            gIsoya_PD.raw=[gIsoya_PD.raw;volts];
        else
            if ~isempty(gIsoya_PD.raw)
                gIsoya_PD.raw(end,:)=volts;
            else
                gIsoya_PD.raw=volts;
            end
        end
    else
        gIsoya_PD.raw=[gIsoya_PD.raw;volts];
    end
    
    C_temp = {};
    
    if curr_it == 1
        
        for j = 1:nCounters
            eval(['C',  num2str(j) ' = gIsoya_PD.raw(1,j:nCounters:end);'])
        end 
        
        strcell = strsplit(plotcode,',');
        strl=length(strcell);
        
        if Inputs.bSweepFreq
            gIsoya_PD.avr=Inputs.bSweepFreqList;
        else
            gIsoya_PD.avr=Inputs.sweepvec;
        end
        for kk=1:strl
            gIsoya_PD.avr = [gIsoya_PD.avr;eval(strcell{kk})];
        end
        
    else
        for j = 1:nCounters
            C_temp{j} = gIsoya_PD.raw(:,j:nCounters:end);
            if Inputs.bSweepwf
                for i = 1:size(C_temp{j},2)
                    if C_temp{j}(end,i) < 0.02
                        C_temp{j}(end,i) = C_temp{j}(end-1,i);
                    end
                end
            end
        end
        
        for j = 1:nCounters
            eval(['C',  num2str(j) ' = mean(C_temp{j});'])
        end
        
        strcell = strsplit(plotcode,',');
        strl=length(strcell);
        
        if Inputs.bSweepFreq
            gIsoya_PD.avr=Inputs.bSweepFreqList;
        else
            gIsoya_PD.avr=Inputs.sweepvec;
        end
        for kk=1:strl
            gIsoya_PD.avr = [gIsoya_PD.avr;eval(strcell{kk})];
        end
    end
 
    %plot result
    figure(121)
    subplot(2,1,1)
    plot(volts,'.b','MarkerSize',16)
    title('current iteration')
    if ~Inputs.bSweepwf
        hold on
    end
    hold off
    
    subplot(2,1,2)
    strcell = strsplit(plotcode,',');
    strl=length(strcell);
    col=hsv(strl);
    for kk=1:strl
        if Inputs.semilogplot
            semilogx(gIsoya_PD.avr(1,:),gIsoya_PD.avr(kk+1,:),'.-','color',col(kk,:))
            xlim([gIsoya_PD.avr(1,2) gIsoya_PD.avr(1,end)])
        else
            plot(gIsoya_PD.avr(1,:),gIsoya_PD.avr(kk+1,:),'.-','color',col(kk,:))
            xlim([gIsoya_PD.avr(1,1) gIsoya_PD.avr(1,end)])
        end
        hold on;
    end
    
    hold off
    legend(strcell)
    title(['avrg #' num2str(curr_it) ' normalized (whole range)'])
    xlabel('\tau (ns)')
    
end

function Load_PB_Sequence()

global Trigger_Seq

ClockTime = 1/400e6;


CMD = ValidateCMD(Trigger_Seq,ClockTime);


s = CMD2PBI(CMD);
Ncmd = size(CMD,1);

PBesrInit(); %initialize PBesr

% sets the clock frequency. for PBESR-PRO-400, it's 400MHz
% for PBESR-PRO-333, it's 333.3MHz
PBesrSetClock(400);

PBesrStartProgramming(); % enter the programming mode

% Loop over all commands
for cmd = 1:Ncmd
    flag = CMD{cmd,1};
    flag_option = CMD{cmd,5};
    inst = char(CMD{cmd,2});
    inst_arg = CMD{cmd,3};
    length = CMD{cmd,4};
    % give the instruction to the PB
    PBstatus = PBesrInstruction(flag, flag_option, inst, inst_arg, length);
    if PBstatus < 0,
        warning('Invalid PulseBlaster Instruction (Line %d)\nCMD = [%d]\t[%s]\t[%d]\t[%g]\t[%s]',cmd,flag,inst,inst_arg,length,flag_option);
    end
end

% Last command is to stop the outputs
flag = 0; % set all lines low
PBesrInstruction(flag, flag_option, 'CONTINUE', 0, 100);
PBesrInstruction(flag, flag_option, 'STOP', 0, 100);

PBesrStopProgramming(); % exit the programming mode

PBesrClose(); %close PBesr
%set status to 0, implement in the future

status = 0;

end

function task = SetPulseWidthMeas(Device,N)

DAQmx_Val_Volts= 10348; % measure volts
DAQmx_Val_Rising = 10280; % Rising
DAQmx_Val_Falling =10171; % Falling
DAQmx_Val_FiniteSamps = 10178; % Finite Samples
DAQmx_Val_CountUp = 10128; % Count Up
DAQmx_Val_CountDown = 10124; % Count Down
DAQmx_Val_GroupByChannel = 0; % Group per channel
DAQmx_Val_ContSamps =10123; % Continuous Samples
DAQmx_Val_SampClkPeriods = 10286; % Sample Clock Periods
DAQmx_Val_Seconds =10364; % Seconds
DAQmx_Val_Ticks =10304; % Ticks

[ status, TaskName, task ] = DAQmxCreateTask([]);
DAQmxErr(status);

status = DAQmxCreateCIPulseWidthChan(task,Device,'',...
    0.000000100,18.38860750,DAQmx_Val_Seconds,DAQmx_Val_Rising,'');
DAQmxErr(status);

%N has to be the number of samples to read (this is important)
status = DAQmxCfgImplicitTiming(task, DAQmx_Val_FiniteSamps ,N);
DAQmxErr(status);

result = DAQmxGet(task, 'CI.CtrTimebaseSrc', Device);
DAQmxSet(task, 'CI.CtrTimebaseSrc', Device, '/Dev1/PFI8');

DupCount = DAQmxGet(task, 'CI.DupCountPrevent', Device);
DAQmxSet(task, 'CI.DupCountPrevent', Device,1);

end

function task = SetPulseWidthMeas2(Device,N)

DAQmx_Val_Volts= 10348; % measure volts
DAQmx_Val_Rising = 10280; % Rising
DAQmx_Val_Falling =10171; % Falling
DAQmx_Val_FiniteSamps = 10178; % Finite Samples
DAQmx_Val_CountUp = 10128; % Count Up
DAQmx_Val_CountDown = 10124; % Count Down
DAQmx_Val_GroupByChannel = 0; % Group per channel
DAQmx_Val_ContSamps =10123; % Continuous Samples
DAQmx_Val_SampClkPeriods = 10286; % Sample Clock Periods
DAQmx_Val_Seconds =10364; % Seconds
DAQmx_Val_Ticks =10304; % Ticks

[ status, TaskName, task ] = DAQmxCreateTask([]);
DAQmxErr(status);

status = DAQmxCreateCICountEdgesChan(task,Device,'',...
    DAQmx_Val_Rising , 0, DAQmx_Val_CountUp);
DAQmxErr(status);


max_freq=1e7;

status = DAQmxCfgSampClkTiming(task,'/Dev2/PFI9',max_freq,...
    DAQmx_Val_Rising,DAQmx_Val_ContSamps ,N);
DAQmxErr(status);

end

function ClearCounters(task)
DAQmxClearTask(task);
end

function StopCounter(task)
DAQmxStopTask(task);
end

function [A,status] = ReadCounters(task,Nrep,timeout)
[auxA0,status] = ReadCounter(task,Nrep,timeout); %uint32
A.Ctr0 = int32(auxA0);
end

function [A,status] = ReadCounters2(task,Nrep,timeout)
[status, A]= DAQmxReadCounterU32(task, Nrep,...
timeout, zeros(1,Nrep), Nrep, libpointer('int32Ptr',0) );     
end

function [readArray,status] = ReadCounter(task,Nrep,timeout)
numSampsPerChan = Nrep;
readArray = zeros(1,Nrep);
arraySizeInSamps = Nrep;
sampsPerChanRead = libpointer('int32Ptr',0);

%Debug here
[status, readArray, aux] = DAQmxReadCounterU32(task, numSampsPerChan,...
    timeout, readArray, arraySizeInSamps, sampsPerChanRead );
if status ~= 0
    fprintf('\nN=%.0f Size = (%.0f, %.0f)\n',Nrep,size(readArray));
    DAQmxErr(status);
end

end

function Run_PB_Sequence()
% function RunPBSequence

PBesrInit(); %initialize PBesr
% sets the clock frequency. for PBESR-PRO-400, it's 400MHz
% for PBESR-PRO-333, it's 333.3MHz
PBesrSetClock(400);

PBesrStart(); %start pulsing. it will start pulse sequence which were progammed/loaded to PBESR card before.

PBesrClose(); %close PBesr
%set status to 0, implement in the future
status = 0;

end

function Run_AWG_Sequence()
   
    OutputAWG(1);
    
    WaitAWGready();
    disp('AWG ready!')
end

function [ValidCMD] = ValidateCMD(CMD,ClockTime)
% checks the CMD structure for erroneously short instruction delays due to
% rounding errors in building the pulse sequence via matlab
a = 1;

for k=1:size(CMD,1),
    if CMD{k,4} > 1, %1 ns is the minimum time
        
        if CMD{k,4} < (1e9*5*ClockTime), % if we find a short delay, we must implement it
            %warning('Pulse Blaster Sequence specified needs short delays.  This is not yet implemented!');
            
            % SHORT DELAY PRIMER
            % jhodges, 18 July 2008
            %
            % By setting bits 21-23 on the pulse blaster we can invoke
            % delays that are shorter than the minimum instruction time for
            % a CONTINUE command (5 clock cycles)
            %
            % SHORT Delays only work for the 4 BNC lines on the output of
            % the pulse blaster.  These correspond to PB0 - PB3, or bits
            % 0 - 3.  You cannot specify which of the 4 BNCs drive high.
            
            % Note that the flags should be set such that bits 21-23 are
            % only set high when the BNCs are in use and should be set to
            % 000 = 0xE00000 when the lines are not in use
            %
            % The following code, which will run in the Spin Core Pulse Interpreter,\
            % has these possible behaviors:
            % 0xFFFFFF, 500ns, LOOP, 100000 //start loop
            % 0x*00000, 100ns //all lines low
            % 0x600008, 20ns // Bit3 short pulse, 3 clock cycles
            % 0x000008, 100ns //all lines low again
            % 0x000000, 100ns, END_LOOP
            % 0x000000, 100ns
            % 0x000000, 100ns, STOP
            %
            % If *=E, that is setting all bits high, then the instruction
            % on the third line does not produce only 3 clock cycles on bit
            % 3, but produces and extra pulse
            %
            % If *=0, the pulse program works as expected with a short, 3
            % cycle pulse on bit3
            
            
            % Short delays should already be CONTINUE commands from the
            % preceeding logic
            Delay = CMD{k,4};
            ClockPeriods = round(Delay/ClockTime/1e9);
            % find the binary representation of ClockPeriods
            CPBinary = dec2bin(ClockPeriods,3);
            CPBinary = CPBinary(length(CPBinary)-2:end);
            ShortBitFlag = 2^21*str2num(CPBinary(3)) + ...
                2^22*str2num(CPBinary(2)) + ...
                2^23*str2num(CPBinary(1));
            
            % now we bit-wise or the ShortBitFlags with the original
            % instruction
            CMD{k,1} = bitor(CMD{k,1},ShortBitFlag);
            CMD{k,2} = 'CONTINUE';
            CMD{k,4} = 6*1e9*ClockTime;
            CMD{k,5} = ' '; %flag option should be null
        else
            CMD{k,5} = 'ON'; % ON sets bits 21-23 high
        end
        
        % Due to a peculiarity in the PB to CMD logic, we can end up
        % having LONG_DELAY types with only 1 multiplier.  These should be
        % made into continue delays
        if strcmp(CMD{k,2},'LONG_DELAY') & CMD{k,3} == 1,
            CMD{k,2} = 'CONTINUE';
            CMD{k,3} = 0;
        end
        
        % Update the ValidCMD with this CMD
        for kk=1:size(CMD,2),
            ValidCMD{a,kk} = CMD{k,kk};
        end
        a = a+1;
    end
end
end

function s = CMD2PBI(CMD)
% converts a CMD structure to pulse blaster interpreter code for debugging
s = '';
for k=1:size(CMD,1),
    flags = dec2hex(CMD{k,1},6);
    delay = CMD{k,4};
    inst = CMD{k,2};
    inst_opt = CMD{k,3};
    flag_opt = CMD{k,5};
    
    if strcmp(flag_opt,'ON'),
        ON = hex2dec('E00000');
        flags = bitor(ON,CMD{k,1});
        flags = dec2hex(flags);
    end
    
    s = [s,sprintf('0x%s,\t%0.3fns,\t%s,\t%d\n',flags,delay,inst,inst_opt)];
    
end

end

function SetSG1(pow,freq,state)

sg = gpib('ni', 0, 28);

fopen(sg);

fprintf(sg,['Pow ' num2str(pow) ' dBm']);
fprintf(sg,['Freq ' num2str(round(freq*10^9))]);

pause(0.1)

if state
    fprintf(sg,'outp on');
else
    fprintf(sg,'outp off');
end
    
pause(0.1)

fclose(sg);
delete(sg);
clear sg;
end

function SetSG2(pow,freq,state)

sg = gpib('ni', 0, 29);

fopen(sg);

fprintf(sg,['Pow ' num2str(pow) ' dBm']);
fprintf(sg,['Freq ' num2str(round(freq*10^9))]);

pause(0.1)

if state
    fprintf(sg,'outp on');
else
    fprintf(sg,'outp off');
end
    
pause(0.1)

fclose(sg);
delete(sg);
clear sg;
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

% fprintf(s,'A53248;p,,,,');
% out2 = fscanf(s)

% out
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

function Load_AWG_Sequence() 
global Inputs

tic % measure time for sequence transfer to AWG

nWF=length(Inputs.Seq_Cell);

for kk=1:nWF
AWGseq = Inputs.Seq_Cell{kk};  % length(Inputs(1,1,:))

PulseLength = sum(AWGseq(:,1));  

samples = round(PulseLength * Inputs.SamplingRate);

t = 0:1:samples-1;
t=t/samples;

%%%%%% program pulse sequence %%%%%%  
y1 = [];
y2 = [];
m1 = []; 
m2 = []; 
m3 = []; 
m4 = []; 
for k=1:size(AWGseq,1)
    y1 = [y1 AWGseq(k,2)*ones(1,round(AWGseq(k,1)*Inputs.SamplingRate))];
    y2 = [y2 AWGseq(k,3)*ones(1,round(AWGseq(k,1)*Inputs.SamplingRate))];
    m1 = [m1 AWGseq(k,4)*ones(1,round(AWGseq(k,1)*Inputs.SamplingRate))];
    m2 = [m2 AWGseq(k,5)*ones(1,round(AWGseq(k,1)*Inputs.SamplingRate))];
    m3 = [m3 AWGseq(k,6)*ones(1,round(AWGseq(k,1)*Inputs.SamplingRate))];
    m4 = [m4 AWGseq(k,7)*ones(1,round(AWGseq(k,1)*Inputs.SamplingRate))];
end 
y1 = single(y1); 
y2 = single(y2); 
m1 = single(m1); 
m2 = single(m2); 
m3 = single(m3); 
m4 = single(m4); 

clear t; %% free up memory 
 
SendWF2TekAWG(samples,y1,y2,m1,m2,m3,m4,['isoya_sm_s' num2str(kk) '_']); 
end
 
CreateTekSeq(nWF);

timeawg=toc;

disp(['AWG transfer took ' num2str(timeawg) ' seconds'])

end

function SendWF2TekAWG(samples,y1,y2,m1,m2,m3,m4,name) 

global gAWG_calib
%%%%%% Parameters %%%%%%
visa_vendor = 'ni';
if strcmp(gAWG_calib.Connection, 'GPIB')
    visa_address = 'GPIB0::1::INSTR';
elseif strcmp(gAWG_calib.Connection, 'LAN')
    visa_address = 'TCPIP0::169.254.49.1::inst0';
end

%%%%%% pre-processing %%%%%%
buffer = 2 * samples;

%%%%%% example marker %%%%%% 
m1 = bitshift(uint8(logical(m1)),6); %check dec2bin(m1(2),8)
m2 = bitshift(uint8(logical(m2)),7); %check dec2bin(m2(2),8)
m3 = bitshift(uint8(logical(m3)),6); %check dec2bin(m1(2),8)
m4 = bitshift(uint8(logical(m4)),7); %check dec2bin(m2(2),8)

%%%%%% merge markers %%%%%% 
m12 = m1 + m2; %check dec2bin(m(2),8)
m34 = m3 + m4; %check dec2bin(m(2),8)

%%%%%% stitch wave data with marker data as per progammer manual %%%%%% 
binblock1 = zeros(1,samples*5,'uint8'); % real uses 5 bytes per sample
for k=1:samples
    binblock1((k-1)*5+1:(k-1)*5+5) = [typecast(y1(k),'uint8') m12(k)];
end
binblock2 = zeros(1,samples*5,'uint8'); % real uses 5 bytes per sample
for k=1:samples
    binblock2((k-1)*5+1:(k-1)*5+5) = [typecast(y2(k),'uint8') m34(k)];
end
clear y1 y2 m;

%%%%%% build binblock header %%%%%% 
bytes = num2str(length(binblock1));
header = ['#' num2str(length(bytes)) bytes];

%%%%%% instrument communication %%%%%%
%%%%%% initialize the instrument %%%%%% 
awg = visa(visa_vendor,visa_address,'InputBufferSize',max([buffer 512]), ...
    'OutputBufferSize',max([buffer 512]));

fopen(awg);

%%%%%% clear waveform %%%%%% 
fwrite(awg,['wlis:wav:del "' name 'ch1"']) 
fwrite(awg,['wlis:wav:del "' name 'ch2"'])

%%%%%% write ch 1 %%%%%% 
fwrite(awg,[':wlist:waveform:new "' name 'ch1",' num2str(samples) ',real;']);
cmd1 = [':wlist:waveform:data "' name 'ch1",' header binblock1 ';'];
%fwrite(awg,'sour1:wav "isoya_sm_ch1_s1"')

%%%%%% write ch 2 %%%%%% 
fwrite(awg,[':wlist:waveform:new "' name 'ch2",' num2str(samples) ',real;']);
cmd2 = [':wlist:waveform:data "' name 'ch2",' header binblock2 ';'];
%fwrite(awg,'sour2:wav "isoya_sm_ch2_s1"')

bytes = length(cmd1);

if buffer >= bytes
    fwrite(awg,cmd1)
else
    awg.EOIMode = 'off';
    for i = 1:buffer:bytes-buffer
        fwrite(awg,cmd1(i:i+buffer-1))
    end
    awg.EOIMode = 'on';
    i=i+buffer;
    fwrite(awg,cmd1(i:end))
end

bytes = length(cmd2);
if buffer >= bytes
    fwrite(awg,cmd2)
else
    awg.EOIMode = 'off';
    for i = 1:buffer:bytes-buffer
        fwrite(awg,cmd2(i:i+buffer-1))
    end
    awg.EOIMode = 'on';
    i=i+buffer;
    fwrite(awg,cmd2(i:end))
end

fclose(awg);
%%%%%% delete all instrument objects %%%%%% 
delete(instrfindall);
clear awg;

end

function CreateTekSeq(nWF)
global Inputs gAWG_calib

%%%%%% variables %%%%%%

    
    MARK1_HIGH_Ch1 = gAWG_calib.Mk1.HIGH_VOLT;
    MARK1_LOW_Ch1 = gAWG_calib.Mk1.LOW_VOLT;
    MARK1_DELAY_Ch1 = gAWG_calib.Mk1.DELAY;
    
    MARK2_HIGH_Ch1 = gAWG_calib.Mk2.HIGH_VOLT;
    MARK2_LOW_Ch1 = gAWG_calib.Mk2.LOW_VOLT;
    MARK2_DELAY_Ch1 = gAWG_calib.Mk2.DELAY;
    
    MARK1_HIGH_Ch2 = gAWG_calib.Mk3.HIGH_VOLT;
    MARK1_LOW_Ch2 = gAWG_calib.Mk3.LOW_VOLT;
    MARK1_DELAY_Ch2 = gAWG_calib.Mk3.DELAY;
    
    MARK2_HIGH_Ch2 = gAWG_calib.Mk4.HIGH_VOLT;
    MARK2_LOW_Ch2 = gAWG_calib.Mk4.LOW_VOLT;  
    MARK2_DELAY_Ch2 = gAWG_calib.Mk4.DELAY;



%%%%%% Parameters %%%%%%
visa_vendor = 'ni';
if strcmp(gAWG_calib.Connection, 'GPIB')
    visa_address = 'GPIB0::1::INSTR';
elseif strcmp(gAWG_calib.Connection, 'LAN')
    visa_address = 'TCPIP0::169.254.49.1::inst0';
end

%%%%%% instrument communication %%%%%%
%%%%%% initialize the instrument %%%%%% 
awg = visa(visa_vendor,visa_address);

fopen(awg);

%go to sequence mode
fwrite(awg,'AWGC:RMOD SEQ');

%write waveforms into sequence
fwrite(awg,['SEQ:LENG ' num2str(nWF)]);
for kk=1:nWF
    fwrite(awg,['SEQ:ELEM' num2str(kk) ':WAV1 "isoya_sm_s' num2str(kk) '_ch1"']);
    fwrite(awg,['SEQ:ELEM' num2str(kk) ':WAV2 "isoya_sm_s' num2str(kk) '_ch2"']);
    nLoop = Inputs.Loops(kk);
    fwrite(awg,['SEQ:ELEM' num2str(kk) ':LOOP:COUN ' num2str(nLoop)])
    fwrite(awg,['SEQ:ELEM' num2str(kk) ':GOTO:STAT 0'])
end
fwrite(awg,['SEQ:ELEM' num2str(1) ':TWA 1']) % wait for trigger
fwrite(awg,['SEQ:ELEM' num2str(nWF) ':GOTO:STAT 1']) % go back to step 1
fwrite(awg,['SEQ:ELEM' num2str(nWF) ':GOTO:IND 1'])

%%%%%% Analog Channel Setup %%%%%% 
fwrite(awg,'AWGCONTROL:DOUTPUT1:STATE 1')
fwrite(awg,'sour1:volt:ampl 1')
fwrite(awg,'AWGCONTROL:DOUTPUT2:STATE 1')
fwrite(awg,'sour2:volt:ampl 1')

%%%%% marker setup %%%%%%
fwrite(awg,['sour1:mark1:volt:high ' num2str(MARK1_HIGH_Ch1)])
fwrite(awg,['sour1:mark1:volt:low ' num2str(MARK1_LOW_Ch1)])
fwrite(awg,['sour1:mark1:del ' num2str(MARK1_DELAY_Ch1) 'ps'])

fwrite(awg,['sour1:mark2:volt:high ' num2str(MARK2_HIGH_Ch1)])
fwrite(awg,['sour1:mark2:volt:low ' num2str(MARK2_LOW_Ch1)])
fwrite(awg,['sour1:mark2:del ' num2str(MARK2_DELAY_Ch1) 'ps'])

fwrite(awg,['sour2:mark1:volt:high ' num2str(MARK1_HIGH_Ch2)])
fwrite(awg,['sour2:mark1:volt:low ' num2str(MARK1_LOW_Ch2)])
fwrite(awg,['sour2:mark1:del ' num2str(MARK1_DELAY_Ch2) 'ps'])

fwrite(awg,['sour2:mark2:volt:high ' num2str(MARK2_HIGH_Ch2)])
fwrite(awg,['sour2:mark2:volt:low ' num2str(MARK2_LOW_Ch2)])
fwrite(awg,['sour2:mark2:del ' num2str(MARK2_DELAY_Ch2) 'ps'])

fwrite(awg, ['Freq ' num2str(Inputs.SamplingRate*1e9)]); 

%%%%%% switch output on %%%%%% 
%fwrite(awg,'OUTP1 1')
%fwrite(awg,'OUTP2 1') 
% fwrite(awg, 'AWGC:RUN')

fclose(awg);
%%%%%% delete all instrument objects %%%%%% 
delete(instrfindall);
clear awg;

%pause(10)

end

function TrackBeam2D()

global gScan gPosOriginal

X0 = gScan.FixVx;
Y0 = gScan.FixVy;
Z0 = gScan.FixVz;
disp(['current coordinate (x0, y0, z0) = ( ', num2str(X0), ' , ', num2str(Y0), ', ', num2str(Z0), ' )'])

%%%%%%%%% XY scan %%%%%%%%%%%

dX = 0.5;
dY = 0.5;
numX = 7;
numY = 7;

minX = X0 - dX/2;
maxX = X0 + dX/2;

minY = Y0 - dY/2;
maxY = Y0 + dY/2;

X = minX:(maxX-minX)/(numX-1):maxX;
Y = minY:(maxY-minY)/(numY-1):maxY;

ListCPS = zeros(numX,numY); 

% close(figure(246))
for i = 1:numX
    for j = 1:numY
        FixPiezoPosition(X(i), Y(j), Z0);
        
        CPS = MeasureCounts();
        ListCPS(i,j) = CPS;
        
        figure(246)
        subplot(2,1,1)
        
        imagesc(X,Y,ListCPS');
        colormap(pink);
%         daspect([1 1 1]);
        hold on

    end
end

[ind_X, ind_Y] = find(ListCPS == max(ListCPS(:)));
if length(ind_X) ~= 1
    ind_X = ind_X(1);
elseif length(ind_Y) ~= 1
    ind_Y = ind_Y(1);
end
hold on
plot(X(ind_X),Y(ind_Y),'or')

xlabel('x (\mum)');
ylabel('y (\mum)');
title('xy scan');
colorbar('location','EastOutside');

% update coordinate
X0 = X(ind_X);
gScan.FixVx = X0;

Y0 = Y(ind_Y);
gScan.FixVy = Y0;

%%%%%%%%% YZ scan %%%%%%%%%%%

dY = 2;
dZ = 1;
numY = 7;
numZ = 7;

minY = Y0 - dY/2;
maxY = Y0 + dY/2;

minZ = Z0 - dZ/2;
maxZ = Z0 + dZ/2;

Y = minY:(maxY-minY)/(numY-1):maxY;
Z = minZ:(maxZ-minZ)/(numZ-1):maxZ;

ListCPS = zeros(numY,numZ); 
for i = 1:numY
    for j = 1:numZ
        FixPiezoPosition(X0, Y(i), Z(j));
        
        CPS = MeasureCounts();
        ListCPS(i,j) = CPS;
        
        figure(246)
        subplot(2,1,2)

        imagesc(Y,Z,ListCPS');
        colormap(pink);
%         daspect([1 1 1]);
        hold on
    end
end

ind_Y = find(sum(ListCPS,2) == max(sum(ListCPS,2)));
ind_Z = find(sum(ListCPS(:,[1:ind_Y-1,ind_Y+1:end]),1) == min(sum(ListCPS(:,[1:ind_Y-1,ind_Y+1:end]),1)));
if length(ind_Y) ~= 1
    ind_Y = ind_Y(1);
elseif length(ind_Z) ~= 1
    ind_Z = ind_Z(1);
end
hold on
plot(Y(ind_Y),Z(ind_Z),'or')

xlabel('y (\mum)');
ylabel('z (\mum)');
title('yz scan');
colorbar('location','EastOutside');

% update coordinate
Y0 = Y(ind_Y);
gScan.FixVy = Y0;

Z0 = Z(ind_Z);
gScan.FixVz = Z0;

if abs(X0-gPosOriginal.X) > 2
    gScan.FixVx = gPosOriginal.X;
    X0 = gScan.FixVx;
    disp(['x position returned back to the original']);
    TrackBeam2D();
end

FixPiezoPosition(X0, Y0, Z0);
disp(['updated coordinate (x0, y0, z0) = ( ', num2str(gScan.FixVx), ' , ', num2str(gScan.FixVy), ', ', num2str(gScan.FixVz), ' )'])


end

function TrackZ()

global gScan 

X = gScan.FixVx;
Y = gScan.FixVy;
Z0 = gScan.FixVz;

ListCPS = []; 
for kk = 0:20 
    
    Z = (kk-10)/5 + Z0; 
    FixPiezoPosition(X, Y, Z); 
    
    CPS = MeasureCounts(); 
    ListCPS = [ListCPS; Z, CPS]; 
    
    figure(146)
%     subplot(3,1,3)
    plot(ListCPS(:,1), ListCPS(:,2), '.b') 
    
end 

%Z0 = FitGaussInv(ListCPS, Z0);
pos = find(ListCPS(:,2)==max(ListCPS(:,2)));
z_new = ListCPS(pos,1);
figure(146)
% subplot(3,1,3)
hold on;
plot(ListCPS(pos,1),ListCPS(pos,2),'or')
hold off;

% if z_new>ListCPS(1,1) && z_new<ListCPS(end,1)
gScan.FixVz = z_new; 
FixPiezoPosition(X,Y,z_new);
% else
%     FixPiezoPosition(X,Y,Z0);
%     disp('z out of range, defaulting to middle')   
% end

end

function TrackBeam2D_fast(curr_it)

global gScan gPiezo gImageOriginal gTrackingPoint gCounts

X0 = gScan.FixVx;
Y0 = gScan.FixVy;
Z0 = gScan.FixVz;
disp(['current coordinate (x0, y0, z0) = ( ', num2str(X0), ' , ', num2str(Y0), ', ', num2str(Z0), ' )'])

dX = 30;
dY = 5;

NX = 200;
NY = 50;

minX = X0 - dX/2;
maxX = X0 + dX/2;

minY = Y0 - dY/2;
maxY = Y0 + dY/2;

%%% execute fast xy scan and plot at end
%%%%%%%%%%%%%%%%% TWO DIMENSIONAL SCAN XY %%%%%%%%%%%%%%%%%%%%
%Number of Triggers
TPixel = 0.001;
n = round(TPixel*gPiezo.SampRate);      

NT = NY*NX*n;  
timeout = 10*NT/gPiezo.SampRate;

X = minX:(maxX-minX)/(NX-1):maxX;
Y = minY:(maxY-minY)/(NY-1):maxY;
Z = Z0;

hCounter = PiezoSetPulseWidthMeas('Dev1/Ctr0', NT+NY-1);
status = DAQmxStartTask(hCounter);  DAQmxErr(status);
gPiezo.ScanXY(X,Y,Z,TPixel);
[A,status, NRead] = PiezoReadCounter(hCounter, NT+NY-1,timeout); DAQmxErr(status);
DAQmxStopTask(hCounter);

for uu=1:NY-1
    A(NX*n*uu+1)=[];
end
B = reshape(A,n,NX*NY);    
C = sum(B,1); 
D = reshape(C,NX,NY);  
D = D*gPiezo.SampRate/n/1000;
I = D';     %in kcps

CPS = mean(mean(D));

%%% plot
if curr_it == 1
    
    figure(246)
    clf;
    h1 = subplot(3,2,1);
    ax1 = get(h1, 'Position');
    set(h1, 'Position', ax1);
    
    imagesc(X,Y,I);
    hold on
    
    % plot the initial tracking point
    ind_X = find(abs(X - X0) == min(abs(X - X0)));
    ind_Y = find(abs(Y - Y0) == min(abs(Y - Y0)));
    if length(ind_X) ~= 1
        ind_X = ind_X(1);
    end
    if length(ind_Y) ~= 1
        ind_Y = ind_Y(1);
    end
    plot(X(ind_X),Y(ind_Y),'or')
    hold off
    
    colormap(pink);
    daspect([1 1 1]);
    
    xlabel('x (\mum)');
    ylabel('y (\mum)');
    title('xy scan for the first image');
    colorbar('location','EastOutside');
    
    gImageOriginal = I;
    gTrackingPoint = [X0 Y0 Z0];
    gCounts = I(ind_Y,ind_X)*1e3;
    
    % plot the fluoresence level
    figure(246)
    subplot(3,2,4)
    plot(gCounts)
    xlabel('Tracking iterations')
    ylabel('Photon Counts')
    
    % plot the tracking point trace
    figure(246)
    subplot(3,2,5)
    plot(gTrackingPoint(:,1),gTrackingPoint(:,2),'o')
    xlabel('x position')
    ylabel('y position')
    title('Tracking history in (x,y) plane')
    disp('reference image is taken')
else
    %%% plot uncorrected image with the original %%%
    figure(246)
    h1 = subplot(3,2,1);
    ax1 = get(h1, 'Position');
    set(h1, 'Position', ax1);
    
    imagesc(X,Y,gImageOriginal);
    hold on
    plot(gTrackingPoint(end,1),gTrackingPoint(end,2),'or')
    hold off
    
    colormap(pink);
    daspect([1 1 1]);
    xlabel('x (\mum)');
    ylabel('y (\mum)');
    title('xy scan before correction');
    colorbar('location','EastOutside');
    
    %%% position correction %%%
    template = gImageOriginal;
    offsetTemplate = I;
    
    cc = xcorr2(offsetTemplate,template);
    [max_cc, imax] = max(abs(cc(:)));
    [ypeak, xpeak] = ind2sub(size(cc),imax(1));
    corr_offset = [ (ypeak-size(template,1)) (xpeak-size(template,2)) ];
    
    x_offset = corr_offset(2);
    y_offset = corr_offset(1);
    
    x_off_dist = (maxX-minX)/(NX-1)*x_offset;
    y_off_dist = (maxY-minY)/(NY-1)*y_offset;
    
    %%% plot corrected image with the original %%%
    figure(246)
    h2 = subplot(3,2,2);
    ax2 = get(h2, 'Position');
    set(h2, 'Position', ax2);
    
    imagesc(X+x_off_dist,Y+y_off_dist,I);
    hold on
    
    ind_X = find(abs(X - (X0+x_off_dist)) == min(abs(X- (X0+x_off_dist))));
    ind_Y = find(abs(Y - (Y0+y_off_dist)) == min(abs(Y- (Y0+y_off_dist))));
    if length(ind_X) ~= 1
        ind_X = ind_X(1);
    end
    if length(ind_Y) ~= 1
        ind_Y = ind_Y(1);
    end
    plot(X(ind_X),Y(ind_Y),'or')
    hold off

    colormap(pink);
    daspect([1 1 1]);
    xlabel('x (\mum)');
    ylabel('y (\mum)');
    title('xy scan after correction');
    colorbar('location','EastOutside');   
    
    % update coordinate
    X0 = X0 + x_off_dist;
    gScan.FixVx = X0;    

    Y0 = Y0 + y_off_dist;
    gScan.FixVy = Y0;
    
    gImageOriginal = I;
    gTrackingPoint = [gTrackingPoint; [X0 Y0 Z0]];
    
    disp(['position for the current image is corrected by x: ', num2str(x_off_dist), ' and y: ', num2str(y_off_dist)])

    hold off    
    
end

%%%%%%%%%%%%%%%%% TWO DIMENSIONAL SCAN YZ %%%%%%%%%%%%%%%%%%%%

dY = 1;
dZ = 1;
numY = 7;
numZ = 7;

minY = Y0 - dY/2;
maxY = Y0 + dY/2;

minZ = Z0 - dZ/2;
maxZ = Z0 + dZ/2;

Y = minY:(maxY-minY)/(numY-1):maxY;
Z = minZ:(maxZ-minZ)/(numZ-1):maxZ;

ListCPS = zeros(numY,numZ); 
for i = 1:numY
    for j = 1:numZ
        FixPiezoPosition(X0, Y(i), Z(j));
        
        CPS = MeasureCounts();
        ListCPS(i,j) = CPS;
        
        figure(246)
        h3 = subplot(3,2,3);
        ax3 = get(h3, 'Position');
        set(h3, 'Position', ax3);
        
        imagesc(Y,Z,ListCPS');
        colormap(pink);
        daspect([1 1 1]);
        hold on
    end
end

[ind_Y, ind_Z] = find(ListCPS == max(ListCPS(:)));
if length(ind_Y) ~= 1
    ind_Y = ind_Y(1);
end
if length(ind_Z) ~= 1
    ind_Z = ind_Z(1);
end

hold on
plot(Y(ind_Y),Z(ind_Z),'or')
xlabel('y (\mum)');
ylabel('z (\mum)');
title('yz scan');
colorbar('location','EastOutside');
hold off

% update coordinate
Y0 = Y(ind_Y);
gScan.FixVy = Y0;

Z0 = Z(ind_Z);
gScan.FixVz = Z0;

gCounts = [gCounts; ListCPS(ind_Y,ind_Z)];
% plot the fluoresence level
figure(246)
subplot(3,2,4)
plot(gCounts)
xlabel('Tracking iterations')
ylabel('Photon Counts')


% update the tracking point trace in y and z
gTrackingPoint(end:2) = Y0;
gTrackingPoint(end:3) = Z0;

% plot the tracking point trace
figure(246)
subplot(3,2,5)
plot(gTrackingPoint(:,1),gTrackingPoint(:,2),'-o')
xlabel('x position')
ylabel('y position')
title('Tracking history in (x,y) plane')

figure(246)
subplot(3,2,6)
plot(gTrackingPoint(:,3),'-o')
xlabel('tracking iterations')
ylabel('z position')
title('Tracking history for z')

FixPiezoPosition(X0, Y0, Z0);
disp(['updated coordinate (x0, y0, z0) = ( ', num2str(gScan.FixVx), ' , ', num2str(gScan.FixVy), ', ', num2str(gScan.FixVz), ' )'])

end

function [readArray,status, NRead] = PiezoReadCounter(task,N,timeout)
numSampsPerChan = N;
readArray = libpointer('int64Ptr',zeros(1,N));
readArray = zeros(1,N);
arraySizeInSamps = N;
sampsPerChanRead = libpointer('int32Ptr',0);

[status, readArray, NRead]= DAQmxReadCounterU32(task, numSampsPerChan,...
    timeout, readArray, arraySizeInSamps, sampsPerChanRead );

if status ~= 0

    fprintf('\nN=%.0f Size = (%.0f, %.0f)\n',N,size(readArray));
    DAQmxErr(status);
end
end

function task = PiezoSetPulseWidthMeas(Device,N)

DAQmx_Val_Volts= 10348; % measure volts
DAQmx_Val_Rising = 10280; % Rising
DAQmx_Val_Falling =10171; % Falling
DAQmx_Val_FiniteSamps = 10178; % Finite Samples
DAQmx_Val_CountUp = 10128; % Count Up
DAQmx_Val_CountDown = 10124; % Count Down
DAQmx_Val_GroupByChannel = 0; % Group per channel
DAQmx_Val_ContSamps =10123; % Continuous Samples
DAQmx_Val_SampClkPeriods = 10286; % Sample Clock Periods
DAQmx_Val_Seconds =10364; % Seconds
DAQmx_Val_Ticks =10304; % Ticks

[ status, TaskName, task ] = DAQmxCreateTask([]);
DAQmxErr(status);
%disp(['NI: Create Counter Task  :' num2str(status)]);

status = DAQmxCreateCIPulseWidthChan(task,Device,'',...
    0.000000100,18.38860750,DAQmx_Val_Seconds,DAQmx_Val_Rising,'');
DAQmxErr(status);
%disp(['NI: Create Counter       :' num2str(status)]);

%status = DAQmxCfgImplicitTiming(task, DAQmx_Val_ContSamps ,10000);
%N has to be the number of samples to read (this is important)
status = DAQmxCfgImplicitTiming(task, DAQmx_Val_FiniteSamps ,N);
DAQmxErr(status);
%disp(['NI: Cofigure implicit Timing     :' num2str(status)]);

result = DAQmxGet(task, 'CI.CtrTimebaseSrc', Device);
         DAQmxSet(task, 'CI.CtrTimebaseSrc', Device, '/Dev1/PFI8');
         
result = DAQmxGet(task, 'CI.PulseWidthTerm', Device);
         DAQmxSet(task, 'CI.PulseWidthTerm', Device, '/Dev1/PFI1');
result = DAQmxGet(task, 'CI.PulseWidthTerm', Device);

PulseWidthDigFltrTimebaseSrc = result;

DupCount = DAQmxGet(task, 'CI.DupCountPrevent', Device);
DAQmxSet(task, 'CI.DupCountPrevent', Device,1);
end

function TrackBeam()
global gScan 

X0 = gScan.FixVx;
Y = gScan.FixVy;
Z = gScan.FixVz;

ListCPS = []; 
for kk = 0:10 
    
    X = (kk-5)/5 + X0; 
    FixPiezoPosition(X, Y, Z); 
    
    CPS = MeasureCounts(); 
    ListCPS = [ListCPS; X, CPS]; 
    
    figure(146) 
    subplot(3,1,1)
    plot(ListCPS(:,1), ListCPS(:,2), '.b') 
    
end 

%y_new = FitGauss(ListCPS, Y0); 
pos = find(ListCPS(:,2)==max(ListCPS(:,2)));
x_new = ListCPS(pos,1);
figure(146)
subplot(3,1,1)
hold on;
plot(ListCPS(pos,1),ListCPS(pos,2),'or')
hold off;

% if x_new > ListCPS(1,1) && x_new < ListCPS(end,1)
    gScan.FixVx = x_new;
    FixPiezoPosition(x_new,Y,Z);
% else
%     FixPiezoPosition(X0,Y,Z);
%     disp('x out of range, defaulting to middle')
% end

X = gScan.FixVx;
Y0 = gScan.FixVy;
Z = gScan.FixVz;

ListCPS = []; 
for kk = 0:10 
    
    Y = (kk-5)/5 + Y0; 
    FixPiezoPosition(X, Y, Z); 
    
    CPS = MeasureCounts(); 
    ListCPS = [ListCPS; Y, CPS]; 
    
    figure(146) 
    subplot(3,1,2)
    plot(ListCPS(:,1), ListCPS(:,2), '.b') 
    
end 

%y_new = FitGauss(ListCPS, Y0); 
pos = find(ListCPS(:,2)==max(ListCPS(:,2)));
y_new = ListCPS(pos,1);
figure(146)
subplot(3,1,2)
hold on;
plot(ListCPS(pos,1),ListCPS(pos,2),'or')
hold off;

% if y_new > ListCPS(1,1) && y_new < ListCPS(end,1)
    gScan.FixVy = y_new;
    FixPiezoPosition(X,y_new,Z);
% else
%     FixPiezoPosition(X,Y0,Z);
%     disp('y out of range, defaulting to middle')
% end

X = gScan.FixVx;
Y = gScan.FixVy;
Z0 = gScan.FixVz;

ListCPS = []; 
for kk = 0:10 
    
    Z = (kk-5)/5 + Z0; 
    FixPiezoPosition(X, Y, Z); 
    
    CPS = MeasureCounts(); 
    ListCPS = [ListCPS; Z, CPS]; 
    
    figure(146)
    subplot(3,1,3)
    plot(ListCPS(:,1), ListCPS(:,2), '.b') 
    
end 

%Z0 = FitGaussInv(ListCPS, Z0);
pos = find(ListCPS(:,2)==max(ListCPS(:,2)));
z_new = ListCPS(pos,1);
figure(146)
subplot(3,1,3)
hold on;
plot(ListCPS(pos,1),ListCPS(pos,2),'or')
hold off;

% if z_new>ListCPS(1,1) && z_new<ListCPS(end,1)
gScan.FixVz = z_new; 
FixPiezoPosition(X,Y,z_new);
% else
%     FixPiezoPosition(X,Y,Z0);
%     disp('z out of range, defaulting to middle')   
% end
end

function FixPiezoPosition(X, Y, Z)

global gPiezo;
%New Piezo
msg = 'Piezo Positions out of Range!';
if X > gPiezo.HighEndOfRange(1),  disp(['X too high, ' msg]); return; end
if X < gPiezo.LowEndOfRange(1), disp(['X too low, ' msg]); return;   end
if Y > gPiezo.HighEndOfRange(2), disp(['Y too high, ' msg]); return;  end
if Y < gPiezo.LowEndOfRange(2), disp(['Y too low, ' msg]); return;  end
if Z > gPiezo.HighEndOfRange(3), disp(['Z too high, ' msg]); return;  end
if Z < gPiezo.LowEndOfRange(3), disp(['Z too low, ' msg]); return;  end

gPiezo.MOV(['1', '2', '3'],[X, Y, Z]);
pause(1);
PiezoQueries('qPOS');

end

function PiezoQueries(what,hObject, eventdata, handles)
global gPiezo;

switch what
    case 'qPOS'
        p = gPiezo.qPOS(['1', '2', '3']);
        %fprintf('Piezo Positions (X, Y, Z) = (%.4f, %.4f, %.4f)\n', p);
    otherwise
        disp('Piezo query unknown');
end

end

function CPS = MeasureCounts() 

global hCPS;

NRead = 50;
DT = 0.0001;
TimeOut = DT * NRead * 1.1;
Freq = 1/DT;

hCounter = SetCounter(NRead+1);
[status, hPulse] = DigPulseTrainCont(Freq,0.5,10000);

hCPS.hCounter = hCounter;
hCPS.hPulse = hPulse;

status = DAQmxStartTask(hCounter);  DAQmxErr(status);
status = DAQmxStartTask(hPulse);    DAQmxErr(status);

DAQmxWaitUntilTaskDone(hCounter,TimeOut);

DAQmxStopTask(hPulse);

A = ReadCounter(hCounter,NRead+1,TimeOut);
DAQmxStopTask(hCounter);
A = diff(A);

CPS = sum(A)/(NRead * DT);

DAQmxClearTask(hPulse);
DAQmxClearTask(hCounter);
end

function task = SetCounter(N)
DAQmx_Val_Volts= 10348; % measure volts
DAQmx_Val_Rising = 10280; % Rising
DAQmx_Val_FiniteSamps = 10178; % Finite Samples
DAQmx_Val_CountUp = 10128; % Count Up
DAQmx_Val_CountDown = 10124; % Count Down
DAQmx_Val_GroupByChannel = 0; % Group per channel
DAQmx_Val_ContSamps =10123; % Continuous Samples

[ status, TaskName, task ] = DAQmxCreateTask([]);

if status,
    disp(['NI: Create Counter Task  :' num2str(status)]);
end
status = DAQmxCreateCICountEdgesChan(task,'Dev1/ctr0','',...
    DAQmx_Val_Rising , 0, DAQmx_Val_CountUp);

if status,
    disp(['NI: Create Counter       :' num2str(status)]);
end
status = DAQmxCfgSampClkTiming(task,'/Dev1/PFI13',1.0,...
    DAQmx_Val_Rising,DAQmx_Val_FiniteSamps ,N);
if status,
    disp(['NI: Cofigure the Clk     :' num2str(status)]);
end
end

function [status, task] = DigPulseTrainCont(Freq,DutyCycle,Samps)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%% Written by Jeronimo Maze, July 2007 %%%%%%%%%%%%%%%%%%
%%%%%%%%%% Harvard University, Cambridge, USA  %%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

DAQmx_Val_Volts= 10348; % measure volts
DAQmx_Val_Rising = 10280; % Rising
DAQmx_Val_FiniteSamps = 10178; % Finite Samples
DAQmx_Val_CountUp = 10128; % Count Up
DAQmx_Val_CountDown = 10124; % Count Down
DAQmx_Val_GroupByChannel = 0; % Group per channel
DAQmx_Val_ContSamps =10123; % Continuous Samples
DAQmx_Val_Hz = 10373; % Hz
DAQmx_Val_Low =10214; % Low

[s,a,task] = DAQmxCreateTask('');
DAQmxErr(s);
s = DAQmxCreateCOPulseChanFreq(task,'Dev1/ctr1','',DAQmx_Val_Hz,DAQmx_Val_Low,0.0,Freq, DutyCycle);
DAQmxErr(s);
status = s + DAQmxCfgImplicitTiming(task,DAQmx_Val_ContSamps,Samps);
DAQmxErr(s);
end

function bnew = FitGauss(ListCPS, Y0) 

FitType = fittype('a * exp(-(x - b).^2 / d) + e');
a0 = max(ListCPS(:,2));
e0 = 0;
b0 = Y0;
d0 = (Y0-ListCPS(1,1))/4;
Fit = fit(ListCPS(:,1), ListCPS(:,2), FitType, 'StartPoint', [a0, b0, d0,e0]);

xf = [ListCPS(1,1):(ListCPS(end,1)-ListCPS(1,1))/100:ListCPS(end,1)];

figure(146) 
plot(xf, Fit(xf), '-r') 
hold on 
plot(ListCPS(:,1), ListCPS(:,2), '.b') 
hold off 

bnew = Fit.b; 
end

function bnew = FitGaussInv(ListCPS, Z0) 

FitType = fittype('a * exp(-(x - b).^2 / d) + e');
a0 = min(ListCPS(:,2))-max(ListCPS(:,2));
e0 = max(ListCPS(:,2));
b0 = Z0;
d0 = (Z0-ListCPS(1,1))/4;
Fit = fit(ListCPS(:,1), ListCPS(:,2), FitType, 'StartPoint', [a0, b0, d0, e0]);

xf = [ListCPS(1,1):(ListCPS(end,1)-ListCPS(1,1))/100:ListCPS(end,1)];

figure(147) 
plot(xf, Fit(xf), '-r') 
hold on 
plot(ListCPS(:,1), ListCPS(:,2), '.b') 
hold off 

bnew = Fit.b; 

end

function OutputAWG(state)

global gAWG_calib
%%%%%% Parameters %%%%%%
visa_vendor = 'ni';
if strcmp(gAWG_calib.Connection, 'GPIB')
    visa_address = 'GPIB0::1::INSTR';
elseif strcmp(gAWG_calib.Connection, 'LAN')
    visa_address = 'TCPIP0::169.254.49.1::inst0';
end

%%%%%% instrument communication %%%%%%
%%%%%% initialize the instrument %%%%%% 
awg = visa(visa_vendor,visa_address);

fopen(awg);

if state==1
    %%%%%% switch output on %%%%%% 
    fwrite(awg,'OUTP1 1')
    fwrite(awg,'OUTP2 1') 
    fwrite(awg, 'AWGC:RUN')
else
    %%%%%% switch output off %%%%%% 
    fwrite(awg, 'AWGC:STOP')
    fwrite(awg,'OUTP1 0')
    fwrite(awg,'OUTP2 0')       
end

fclose(awg);
%%%%%% delete all instrument objects %%%%%% 
delete(instrfindall);
clear awg;

end

function WaitAWGready()

global gAWG_calib
%%%%%% Parameters %%%%%%
visa_vendor = 'ni';
if strcmp(gAWG_calib.Connection, 'GPIB')
    visa_address = 'GPIB0::1::INSTR';
elseif strcmp(gAWG_calib.Connection, 'LAN')
    visa_address = 'TCPIP0::169.254.49.1::inst0';
end

%%%%%% instrument communication %%%%%%
%%%%%% initialize the instrument %%%%%% 
awg = visa(visa_vendor,visa_address);

fopen(awg);

awg.Timeout = 1000;

%this will take long because AWG is checking sequence with OPC/Run
fwrite(awg, 'AWGC:RST?');
rawg=fscanf(awg,'%s');

fclose(awg);
%%%%%% delete all instrument objects %%%%%% 
delete(instrfindall);
clear awg;

% if ~(strcmp(rawg,'1') || strcmp(rawg,'2'))
%     error('AWG error, probably sequence too long')
% end



% %check if running
% awg.Timeout = 5;
% fwrite(awg, 'AWGC:RUN?');
% rawg=fscanf(awg,'%s');

% if ~strcmp(rawg,'1')
%     error('AWG error, probably sequence too long')
% end

end


