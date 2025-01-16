function RunSequence(hObject, eventdata, handles)
[y,Fs] = audioread('ExptCompleted.mp3');
BackupFile = 'C:\MATLAB_Code\Data\TempDataBackup\Temp.mat';
global gmSEQ gSG tmax hCPS gSG2 gSG3 fpga

%connect to fpga if not already connected
Set_FPGA_GUI_buttons(handles, 'on')
if isempty(fpga.client_socket)
    fpga = FPGA_AWG_Client();
    msg = fpga.connect(PortMap('FPGA Host'),PortMap('FPGA Port'));
    handles.fpga_ack_str.String = msg;
end

fpga.delete_all_envelope_data();
fpga.delete_all_waveform_cfg();
fpga.delete_all_programs();
% set trigger
fpga.set_trigger_mode('external');

% default setting
gmSEQ.bRaman = 0;
gmSEQ.bGo = 1;
gmSEQ.bExp = 1; % experiment status tag
getUserInputFromGUI(handles);
SequencePool(string(gmSEQ.name))
InitializeData(handles);

%%% init fpga
fpga_in_use = isfield(gmSEQ,'use_fpga') && gmSEQ.use_fpga == 1 ;


disp(strcat('Commencing ',{' '},string(gmSEQ.name), ' sequence...'))
set(handles.runningText,'string','Running')
drawnow;

gmSEQ.bRandom = 0;  % Shuffle the input, added by Weijie 04/20/2022

if gSG.bfixedPow && gSG.bfixedFreq %pulsed seq
    CreateSavePath_Ave()
    
    %gmSEQ.bTomo = gmSEQ.Alternate;
    gmSEQ.bTomo = 0;
    if gmSEQ.bTomo
        gmSEQ.dataN = gmSEQ.Ntomo*gmSEQ.ctrN;
        disp("Tomographical measurement ongoing...")
    else
        gmSEQ.dataN = gmSEQ.ctrN;
    end
    
    numPDChan=0;
    if gmSEQ.measPD
        if strcmp(gmSEQ.meas2,'PD0')
            numPDChan = numPDChan+1;
        end
        if strcmp(gmSEQ.meas3,'PD1')
            numPDChan = numPDChan+1;
        end
    end
    
    %append the voltage data to the counts data. Hence we need to expand
    %the counts array by the corresponding voltage channels to read.
    %TODO: store voltage data to a separate file
    gmSEQ.signal_Ave = NaN(gmSEQ.dataN*(numPDChan+1), gmSEQ.NSweepParam);
    gmSEQ.signal = NaN(gmSEQ.dataN*(numPDChan+1), gmSEQ.NSweepParam);
    
    %%% if use fpga this is not needed, freq and amp will be imported
    %%% through the sequence_name.m
    %%% TODO: add a button for turning on the FPGA. If using FPGA, skip the
    %%% following lines
    gmSEQ.refCounts=Track('Init');
    SignalGeneratorFunctionPool('SetMod');
    SignalGeneratorFunctionPool('WritePow');
    SignalGeneratorFunctionPool('WriteFreq');
    gSG.bOn=1;  SignalGeneratorFunctionPool('RFOnOff');

    CreateCaliLog(hObject, eventdata, handles);
    
    if gmSEQ.bRandom
        disp("Random measurement ongoing...")
    end
    
    try
        Set_FPGA_GUI_buttons(handles, 'off')
        %DAQmxResetDevice('Dev1');
        [~, hCounter0] = SetNCounters(0,1*gmSEQ.ctrN*gmSEQ.Repeat,PortMap('Ctr Gate'),500000);
        %         [~, hCounter1] = SetNCounters(1,1*gmSEQ.ctrN*gmSEQ.Repeat,PortMap('Ctr Gate'),500000);
        %         [~, hCounter2] = SetNCounters(2,1*gmSEQ.ctrN*gmSEQ.Repeat,PortMap('Ctr Gate'),500000);
        %         [~, hCounter3] = SetNCounters(3,1*gmSEQ.ctrN*gmSEQ.Repeat,PortMap('Ctr Gate'),500000);
        if gmSEQ.measPD
            [~, hCounterPD0] = SetPDCounters([],1*gmSEQ.ctrN*gmSEQ.Repeat,PortMap('Ctr Gate'),500000,numPDChan);
        end
        
        for i=1:gmSEQ.Average
            gmSEQ.iAverage=i;
            handles.biAverage.String=num2str(gmSEQ.iAverage);
            % disp("Running the round " + num2str(i))
            raw_j=1;
            iwarmup=1;
            
            randomList = randperm(gmSEQ.NSweepParam); % Shuffle the input, added by Weijie 04/20/2022
            
            while raw_j<=gmSEQ.NSweepParam
                % gmSEQ.refCounts=Track('Run');
                if gmSEQ.bRandom
                    j = randomList(raw_j);  % Shuffle the input, added by Weijie 04/20/2022
                else
                    j = raw_j;
                end
                Calibration(hObject, eventdata, handles)
                gmSEQ.m=gmSEQ.SweepParam(j); % Manually change the sweep range here.
                if strcmp(gmSEQ.name, 'Special Cooling')
                    disp(['    gmSEQ.m = ', num2str(gmSEQ.m)]);
                end
                
                if gmSEQ.bTomo
                    for axis = 0:gmSEQ.Ntomo-1
                        gmSEQ.CoolSwitch = axis;
                        SequencePool(string(gmSEQ.name));
                        DrawSequence(gmSEQ,hObject, eventdata, handles.axes1);
                        for k=1:numel(gmSEQ.CHN)
                            gmSEQ.CHN(k).T=gmSEQ.CHN(k).T/1e9;
                            gmSEQ.CHN(k).DT=gmSEQ.CHN(k).DT/1e9;
                            gmSEQ.CHN(k).Delays=gmSEQ.CHN(k).Delays/1e9;
                        end
                        PBFunctionPool('PreprocessPBSequence',gmSEQ); % todo: account for ns
                        
                        %%%
                        StartCounters(hCounter);
                        Run_PB_Sequence();
                        [~, vec] = ReadCountersN(hCounter,(gmSEQ.ctrN*gmSEQ.Repeat),gmSEQ.Repeat*tmax/1e9*1.5);
                        DAQmxStopTask(hCounter);
                        %%%
                        
                        sigDatum = ProcessData(vec);
                        for k = 1:gmSEQ.ctrN
                            gmSEQ.signal_Ave(gmSEQ.ctrN*axis + k, j) = sigDatum(k);
                            if i == 1
                                gmSEQ.signal(gmSEQ.ctrN*axis + k, j) = sigDatum(k);
                            else
                                gmSEQ.signal(gmSEQ.ctrN*axis + k, j) = (gmSEQ.signal(gmSEQ.ctrN*axis + k, j)*(i-1)+sigDatum(k))/i;
                            end
                        end
                    end
                else
                    SequencePool(string(gmSEQ.name));
                    DrawSequence(gmSEQ,hObject, eventdata, handles.axes1);
                    for k=1:numel(gmSEQ.CHN)
                        gmSEQ.CHN(k).T=gmSEQ.CHN(k).T/1e9;
                        gmSEQ.CHN(k).DT=gmSEQ.CHN(k).DT/1e9;
                        gmSEQ.CHN(k).Delays=gmSEQ.CHN(k).Delays/1e9;
                    end
                    PBFunctionPool('PreprocessPBSequence',gmSEQ); % todo: account for ns
                    
                    
                    
                    %%%
                    StartCounters(hCounter0);
                    if gmSEQ.measPD;StartCounters(hCounterPD0);end
                    %                     StartCounters(hCounter2);
                    %                     StartCounters(hCounter3);
                    fpga.start_program(string(gmSEQ.name));
                    %handles.fpga_ack_str = msg;
                    pause(0.1)
                    Run_PB_Sequence();
                    
                    [~, vec0] = ReadCountersN(hCounter0,(1*gmSEQ.ctrN*gmSEQ.Repeat),gmSEQ.Repeat*tmax/1e9*1.5);
                    if gmSEQ.measPD;[~, vec1] = ReadCountersPD(hCounterPD0,(1*gmSEQ.ctrN*gmSEQ.Repeat),gmSEQ.Repeat*tmax/1e9*1.5,numPDChan);end
                    %                     [~, vec2] = ReadCountersN(hCounter2,(1*gmSEQ.ctrN*gmSEQ.Repeat),gmSEQ.Repeat*tmax/1e9*1.5);
                    %                     [~, vec3] = ReadCountersN(hCounter3,(1*gmSEQ.ctrN*gmSEQ.Repeat),gmSEQ.Repeat*tmax/1e9*1.5);
                    DAQmxStopTask(hCounter0);
                    
                    %%% fpga stop program
                    pause(0.1)
                    fpga.stop_program();
                    if gmSEQ.measPD;DAQmxStopTask(hCounterPD0);end
                    %                     DAQmxStopTask(hCounter2);
                    %                     DAQmxStopTask(hCounter3);
                    %%%
                    
                    %vec = [0 0 0];
                    sigDatum0 = ProcessData(vec0);
                    %                     sigDatum2 = ProcessData(vec2);
                    %                     sigDatum3 = ProcessData(vec3);
                    %                     sigDatum = sigDatum0+sigDatum1+sigDatum2+sigDatum3;
                    
                    %process PD voltage data acquired
                    if gmSEQ.measPD
                        sigVoltDatum = NaN(numPDChan,gmSEQ.ctrN);
                        for iPD = 1:numPDChan
                            sigVoltProcessing = vec1(1+(gmSEQ.ctrN*gmSEQ.Repeat)*(iPD-1):(gmSEQ.ctrN*gmSEQ.Repeat)*iPD);
                            for ic = 1:gmSEQ.ctrN
                                sigVoltDatum(iPD,ic)=sum(sigVoltProcessing(ic:gmSEQ.ctrN:end))/(length(sigVoltProcessing)/gmSEQ.ctrN); %store the average voltage across "repeats"
                            end                       
                            
                            %store voltage data
                            for k = 1:gmSEQ.ctrN
                                data_index = k+iPD*gmSEQ.ctrN; %the index of the data in the stored data
                                gmSEQ.signal_Ave(data_index, j) = sigVoltDatum(iPD,k);
                                if i == 1
                                    gmSEQ.signal(data_index, j) = sigVoltDatum(iPD,k);
                                else
                                    gmSEQ.signal(data_index, j) = (gmSEQ.signal(data_index, j)*(i-1)+sigVoltDatum(iPD,k))/i;
                                end
                            end
                        end
                    end
                    
                    
                    sigDatum = sigDatum0;
                    for k = 1:gmSEQ.ctrN
                        gmSEQ.signal_Ave(k, j) = sigDatum(k);
                        if i == 1
                            gmSEQ.signal(k, j) = sigDatum(k);
                        else
                            gmSEQ.signal(k, j) = (gmSEQ.signal(k, j)*(i-1)+sigDatum(k))/i;
                        end
                    end
                    
                    if gmSEQ.saveRaw
                        csvwrite('D:\RawData.csv', mean(gmSEQ.signal,2));
                    end
                    
                    

                end
                
                % save a backup of the data here in case matlab crashes
                TemporarySave(BackupFile);
                if gmSEQ.ctrN<=20 %do not plot if too many counter gates
                    PlotData(handles,raw_j);
                end
                drawnow;
                if ~gmSEQ.bGo
                    break
                end
                if (gmSEQ.bWarmUpAOM && iwarmup==3)||~gmSEQ.bWarmUpAOM||i~=1||raw_j~=1
                    raw_j=raw_j+1;
                elseif gmSEQ.bWarmUpAOM
                    iwarmup=iwarmup+1;
                end
                
            end
            SaveIgorText_Average(handles);
            SaveIgorText(handles);
            
            if ~gmSEQ.bGo || ~gmSEQ.bGoAfterAvg
                break
            end
        end
        Set_FPGA_GUI_buttons(handles, 'on');
        ClearCounters(hCounter0);
        if gmSEQ.measPD;ClearCounters(hCounterPD0);end
        %         ClearCounters(hCounter2);
        %         ClearCounters(hCounter3);
    catch ME
        KillAllTasks; %kill all niDAQ tasks
        set(handles.runningText,'string','Error!')
        gSG.bOn=0; SignalGeneratorFunctionPool('RFOnOff');
        fpga.stop_program();
        Set_FPGA_GUI_buttons(handles, 'on')
        rethrow(ME);
    end
    if gmSEQ.bTrack
        PBFunctionPool('PBON',2^SequencePool('PBDictionary','AOM'));
    end
    
    
elseif isfield(gmSEQ,'bLiO')   % activates for ESR
    CreateSavePath_Ave()
    gmSEQ.dataN = gmSEQ.ctrN;
    gmSEQ.signal_Ave = NaN(gmSEQ.dataN, gmSEQ.NSweepParam);
    gmSEQ.signal = NaN(gmSEQ.dataN, gmSEQ.NSweepParam);
    gmSEQ.refCounts=Track('Init');
    SequencePool(string(gmSEQ.name));
    gmSEQ.SweepParam=gmSEQ.SweepParam*1e9;
    gSG.sweepDev=(gmSEQ.SweepParam(gmSEQ.NSweepParam)-gmSEQ.SweepParam(1))/2;
    gSG.Freq=(gmSEQ.SweepParam(gmSEQ.NSweepParam)+gmSEQ.SweepParam(1))/2;
    SignalGeneratorFunctionPool('WriteFreq');
    if gSG.Pow > -10%%%%%%
        error("Too large MW power. ")
    end
    SignalGeneratorFunctionPool('WritePow');
    SignalGeneratorFunctionPool('SetMod');
    PBFunctionPool('PBON',2^SequencePool('PBDictionary','GreenAOM')+2^SequencePool('PBDictionary','MWSwitch'));
    
    %     if gmSEQ.bWarmUpAOM %%% probably not necessary for this method of ESR
    %         gSG.bOn=1; SignalGeneratorFunctionPool('RFOnOff');
    %         pause(30);
    %     end
    try
        [vec, NN]=MakeSweepVector();
        
        gSG.bOn=1; SignalGeneratorFunctionPool('RFOnOff');
        for i=1:gmSEQ.Average
            
            % tracking disable
            %gmSEQ.refCounts=Track('Run');
            %%%%% Pulse Train %%%%%
            [~, hPulse] = DigPulseTrainCont(gmSEQ.NSweepParam*gSG.sweepRate,0.5,NN);
            hCPS.hPulse=hPulse;
            %%%%% Analog write %%%%
            [ ~, hScan ] = DAQmxFunctionPool('WriteAnalogVoltage',PortMap('SG ext mod'),vec, NN,gmSEQ.NSweepParam*gSG.sweepRate);
            hCPS.hScan=hScan;
            %%%%% Create counting channel %%%%
            [~, hCounter] = SetNCounters(0,NN,'/Dev2/PFI13',gmSEQ.NSweepParam*gSG.sweepRate);
            hCPS.hCounter=hCounter;
            gmSEQ.iAverage=i;
            handles.biAverage.String=num2str(gmSEQ.iAverage);
            status = DAQmxStartTask(hScan);  DAQmxErr(status);            status = DAQmxStartTask(hCounter);  DAQmxErr(status);
            status = DAQmxStartTask(hPulse);    DAQmxErr(status);
            
            [~, A] = ReadCountersN(hCounter,NN, gmSEQ.misc*1.1);
            pause(0.5)
            
            DAQmxStopTask(hCounter);
            DAQmxStopTask(hScan);
            DAQmxStopTask(hPulse);
            if gmSEQ.bAAR==1
                gmSEQ.signal_Ave(1,:) = ProcessData(A);
                if i==1
                    gmSEQ.signal(1,:) = ProcessData(A);
                else
                    gmSEQ.signal(1,:) = (gmSEQ.signal(1,:)*(i-1)+ProcessData(A))/i;
                end
            else
                gmSEQ.signal(1,:) = ProcessData(A);
                gmSEQ.signal_Ave(1,:) = ProcessData(A);
            end
            
            TemporarySave(BackupFile);
            PlotData(handles,0);
            drawnow;
            DAQmxClearTask(hCounter);
            DAQmxClearTask(hPulse);
            DAQmxClearTask(hScan);
            if ~gmSEQ.bGo || ~gmSEQ.bGoAfterAvg
                break
            end
            SaveIgorText_Average(handles);
        end
    catch ME
        KillAllTasks;
        gSG.bOn=0; SignalGeneratorFunctionPool('RFOnOff');
        %gSG2.bOn=0; SignalGeneratorFunctionPool2('RFOnOff');
        set(handles.runningText,'string','Error!')
        rethrow(ME);
    end
    if ~gmSEQ.bTrack
        ExperimentFunctionPool('PBOFF',hObject, eventdata, handles);
    end
    gSG.bOn=0; SignalGeneratorFunctionPool('RFOnOff');
    
elseif gSG.bfixedPow && ~gSG.bfixedFreq % for ODMR
    CreateSavePath_Ave()
    
    gmSEQ.refCounts=Track('Init');
    SignalGeneratorFunctionPool('SetMod');
    SignalGeneratorFunctionPool('WritePow');
    gSG.bOn=1; SignalGeneratorFunctionPool('RFOnOff');
    gmSEQ.SweepParam=gmSEQ.SweepParam*1e9;
    CreateCaliLog(hObject, eventdata, handles);
    
    gmSEQ.bTomo = gmSEQ.Alternate;
    if gmSEQ.bTomo
        gmSEQ.dataN = 3*gmSEQ.ctrN;
        disp("Tomographical measurement ongoing...")
    else
        gmSEQ.dataN = gmSEQ.ctrN;
    end
    gmSEQ.signal_Ave = NaN(gmSEQ.dataN, gmSEQ.NSweepParam);
    gmSEQ.signal = NaN(gmSEQ.dataN, gmSEQ.NSweepParam);
    
    if gmSEQ.bRandom
        disp("Random measurement ongoing...")
    end
    
    try
        [~, hCounter] = SetNCounters(0,1*gmSEQ.ctrN*gmSEQ.Repeat,PortMap('Ctr Gate'),500000);
        for i=1:gmSEQ.Average
            gmSEQ.iAverage=i;
            handles.biAverage.String=num2str(gmSEQ.iAverage);
            raw_j=1;
            iwarmup=1;
            
            randomList = randperm(gmSEQ.NSweepParam); % Shuffle the input, added by Weijie 04/20/2022
            
            while raw_j<=gmSEQ.NSweepParam
                %  gmSEQ.refCounts=Track('Run');
                if gmSEQ.bRandom
                    j = randomList(raw_j);  % Shuffle the input, added by Weijie 04/20/2022
                else
                    j = raw_j;
                end
                
                Calibration(hObject, eventdata, handles)
                SequencePool(string(gmSEQ.name));
                
                if gSG.ACmodAWG
                    gSG.Freq = gmSEQ.SweepParam(j)-str2double(get(handles.AWGFreq, 'String'))*1e9;
                else
                    gSG.Freq = gmSEQ.SweepParam(j);
                end
                %
                SignalGeneratorFunctionPool('WriteFreq');
                % SignalGeneratorFunctionPool('WritePow');
                % gmSEQ.m=gmSEQ.SweepParam(j);
                
                SequencePool(string(gmSEQ.name));
                DrawSequence(gmSEQ,hObject, eventdata, handles.axes1);
                for k=1:numel(gmSEQ.CHN)
                    gmSEQ.CHN(k).T=gmSEQ.CHN(k).T/1e9;
                    gmSEQ.CHN(k).DT=gmSEQ.CHN(k).DT/1e9;
                    gmSEQ.CHN(k).Delays=gmSEQ.CHN(k).Delays/1e9;
                end
                PBFunctionPool('PreprocessPBSequence',gmSEQ); % todo: account for ns
                StartCounters(hCounter);
                
                Run_PB_Sequence();
                %pause(gmSEQ.Repeat*tmax/1e9*1.1);
                %ExperimentFunctionPool('PBOFF',hObject, eventdata, handles);
                [~, vec] = ReadCountersN(hCounter,(gmSEQ.ctrN*gmSEQ.Repeat),gmSEQ.Repeat*tmax/1e9*1.5);
                DAQmxStopTask(hCounter);
                sigDatum = ProcessData(vec);
                
                for k = 1:gmSEQ.ctrN
                    gmSEQ.signal_Ave(k, j) = sigDatum(k);
                    if i == 1
                        gmSEQ.signal(k, j) = sigDatum(k);
                    else
                        gmSEQ.signal(k, j) = (gmSEQ.signal(k, j)*(i-1)+sigDatum(k))/i;
                    end
                end
                
                % save a backup of the data here in case matlab crashes
                TemporarySave(BackupFile);
                PlotData(handles,raw_j);
                drawnow;
                if ~gmSEQ.bGo
                    break
                end
                if (gmSEQ.bWarmUpAOM && iwarmup==2)||~gmSEQ.bWarmUpAOM||i~=1||raw_j~=1
                    raw_j=raw_j+1;
                elseif gmSEQ.bWarmUpAOM
                    iwarmup=iwarmup+1;
                end
                
            end
            SaveIgorText(handles);
            SaveIgorText_Average(handles);
            
            if ~gmSEQ.bGo || ~gmSEQ.bGoAfterAvg
                break
            end
        end
        
        ClearCounters(hCounter);
    catch ME
        KillAllTasks;
        gSG.bOn=0; SignalGeneratorFunctionPool('RFOnOff');
        set(handles.runningText,'string','Error!')
        rethrow(ME);
    end
end

gSG.bOn=0; SignalGeneratorFunctionPool('RFOnOff');
% gSG2.bOn=0; SignalGeneratorFunctionPool2('RFOnOff');
% gSG3.bOn=0; SignalGeneratorFunctionPool3('RFOnOff');

% The following stop is just for test, added by Weijie 07/30/2022
% chaseFunctionPool('stopChase', gmSEQ.MWAWG)
% chaseFunctionPool('stopChase', gmSEQ.P1AWG)
% chaseFunctionPool('stopChase', gmSEQ.MWAWG2)


gmSEQ.bGo = 0;
gmSEQ.bExp = 0;
SaveIgorText(handles);

disp('Experiment completed!')
set(handles.runningText,'string','Stopped')
%sound(y,Fs);

function getUserInputFromGUI(handles)
global gmSEQ

% for two sweeping range, with option for log10 sampling
% Add by C. Zu on 9/29/2020
if get(handles.bSweep1log,'Value')
    gmSEQ.SweepParam=round(logspace(log10(gmSEQ.From),log10(gmSEQ.To),gmSEQ.N));
    gmSEQ.SweepParam = unique(gmSEQ.SweepParam,'first'); %remove repeating elements
else
    gmSEQ.SweepParam=linspace(gmSEQ.From,gmSEQ.To,gmSEQ.N);
end

if (gmSEQ.bSweep2)
    if (gmSEQ.bSweep2log)
        gmSEQ.SweepParam=round([gmSEQ.SweepParam logspace(log10(gmSEQ.From2),log10(gmSEQ.To2),gmSEQ.N2)]);
        gmSEQ.SweepParam = unique(gmSEQ.SweepParam,'first'); %remove repeating elements
    else
        gmSEQ.SweepParam=[gmSEQ.SweepParam linspace(gmSEQ.From2,gmSEQ.To2,gmSEQ.N2)];
    end
end

if (gmSEQ.bSweep3)
    if (gmSEQ.bSweep3log)
        gmSEQ.SweepParam=round([gmSEQ.SweepParam logspace(log10(gmSEQ.From3),log10(gmSEQ.To3),gmSEQ.N3)]);
        gmSEQ.SweepParam = unique(gmSEQ.SweepParam,'first'); %remove repeating elements
    else
        gmSEQ.SweepParam=[gmSEQ.SweepParam linspace(gmSEQ.From3,gmSEQ.To3,gmSEQ.N3)];
    end
end

% Customized in the input data here
% DEER ODMR Weijie 04/19/2022
gmSEQ.bCust = get(handles.useCustPoints,'Value');
if gmSEQ.bCust
    % gmSEQ.SweepParam = [linspace(0.900,0.928, 15), linspace(0.930,0.969,40), linspace(0.970, 1.018, 25), linspace(1.020, 1.069, 51),  linspace(1.070, 1.100, 16)];
    aaa = linspace(6,206,51);
    aaa(end) = [];
    bbb = linspace(206,606,21);
    gmSEQ.SweepParam = [aaa bbb];
    % gmSEQ.SweepParam = [linspace(50, 20050, 5), linspace(40000, 100000, 4), linspace(150000, 400000, 6), linspace(500000, 800000, 4)];
    % Seq F 100 ns
    % gmSEQ.SweepParam = [linspace(0, 20, 6), linspace(30, 60, 4), linspace(80, 200, 7), linspace(240, 400, 5)];
    % Seq F 200 ns
    % gmSEQ.SweepParam = [linspace(0, 10, 6), linspace(15, 30, 4), linspace(40, 100, 7), linspace(120, 200, 5)];
    % Seq F 300 ns
    % gmSEQ.SweepParam = [linspace(0, 6, 4), linspace(10, 30, 6), linspace(40, 90, 6), linspace(110, 150, 3)];
    % Seq G 100 ns
    % gmSEQ.SweepParam = [linspace(0, 6, 4), linspace(10, 30, 6), linspace(40, 200, 9)];
    % Cory 100 ns
    % gmSEQ.SweepParam = [linspace(0, 5, 6), linspace(6, 20, 8), linspace(30, 80, 6)];
    
    disp("Customized input, GUI values are overwritten.")
end

function InitializeData(handles)
global gmSEQ
gmSEQ.NSweepParam=length(gmSEQ.SweepParam);
gmSEQ.signal=NaN(1,gmSEQ.NSweepParam);
gmSEQ.reference=NaN(1,gmSEQ.NSweepParam);
gmSEQ.reference2=NaN(1,gmSEQ.NSweepParam);
gmSEQ.reference3=NaN(1,gmSEQ.NSweepParam);

gmSEQ.bGo=1;
gmSEQ.bGoAfterAvg=1;
for i=1:numel(gmSEQ.CHN)
    if gmSEQ.CHN(i).PBN==SequencePool('PBDictionary','ctr0')
        gmSEQ.ctrN=gmSEQ.CHN(i).NRise;
    end
end

function Run_PB_Sequence
% function RunPBSequence

PBesrInit(); %initialize PBesr
% sets the clock frequency. for PBESR-PRO-400, it's 400MHz
% for PBESR-PRO-333, it's 333.3MHz
PBesrSetClock(500);

PBesrStart(); %start pulsing. it will start pulse sequence which were progammed/loaded to PBESR card before.

PBesrClose(); %close PBesr
%set status to 0, implement in the future
status = 0;

function [status, task] = SetNCounters(varargin)
%varargin(1) is the number of total samples
%varargin(2) is the source of gating
%varargin(3) is the frequency of the gating to expect
% Initialize DAQ
global gmSEQ hCPS
if strcmp(gmSEQ.meas,'SPCM')
    if isfield(gmSEQ,'bLiO')
        [status, task ] = DAQmxFunctionPool('SetCounter',varargin{2},varargin{1});
    else
        [status, task ] = DAQmxFunctionPool('SetGatedNCounter',varargin{2},varargin{1});
    end
    
elseif strcmp(gmSEQ.meas,'APD')
    numCHNtoCreate = 1;
    [status, task ] = DAQmxFunctionPool('CreateAIChannel',varargin{3},varargin{2},varargin{4}, numCHNtoCreate);
end
hCPS.hCounter=task;

function [status, task] = SetPDCounters(varargin)
% Initialize DAQ
global hCPS
[status, task ] = DAQmxFunctionPool('CreateAIChannel',varargin{3},varargin{2},varargin{4},varargin{5});
hCPS.hPDCounter0=task;

function PlotData(handles,raw_j)
global gmSEQ
%axes(handles.axes2); %cla;

% Implement the special case and ESR later
for i = 1:gmSEQ.dataN
    if gmSEQ.dataN == 1
        plot(handles.axes2, single(gmSEQ.SweepParam)*gmSEQ.ScaleT,single(gmSEQ.signal(i, :)),'-', ...
            'color', [0, 0, 1],'LineWidth', 0.5, 'DisplayName', sprintf('signal %d', i))
    else
        plot(handles.axes2, single(gmSEQ.SweepParam)*gmSEQ.ScaleT,single(gmSEQ.signal(i, :)),'-', ...
            'color', [0, (i-1)/(gmSEQ.dataN - 1), 1-(i-1)/(gmSEQ.dataN - 1)],'LineWidth', 0.5, 'DisplayName', sprintf('signal %d', i))
    end
    if i == 1
        hold(handles.axes2, 'on')
    end
end
grid on;
set(handles.axes2,'FontSize',8);
ylabel(handles.axes2, 'Fluorescence counts');
xlabel(handles.axes2, gmSEQ.ScaleStr);

% don't rescale x axis of the plots if num of sweep param is set to 1
if length(gmSEQ.SweepParam) ~= 1
    xlim(handles.axes2, [gmSEQ.SweepParam(1)*gmSEQ.ScaleT gmSEQ.SweepParam(gmSEQ.NSweepParam)*gmSEQ.ScaleT]);
end

if get(handles.bShowLegend,'Value')
    legend(handles.axes2)
end
if raw_j~=0
    xline(handles.axes2, single(gmSEQ.SweepParam(raw_j))*gmSEQ.ScaleT,'--', 'color','r','HandleVisibility','off')
end
hold(handles.axes2, 'off')


if ~isfield(gmSEQ,'bLiO')&&gmSEQ.ctrN~=1 % Do not plot ESR
    % Remove NaN (empty data)
    for i = 1:gmSEQ.dataN
        signal(i,:) = gmSEQ.signal(i, ~isnan(gmSEQ.signal(i,:)));
    end
    
    if gmSEQ.bTomo
        % Generalize version
        if gmSEQ.ctrN ~= 4
            error("This function has not been implemented.")
        end
        for i = 1:gmSEQ.Ntomo
            [data(i,:), data_err(i,:)] = ContrastDiff(signal(4*(i-1)+1,:), signal(4*(i-1)+3,:),...
                signal(4*(i-1)+2,:), signal(4*(i-1)+4,:), gmSEQ.iAverage);
            errorbar(handles.axes3, gmSEQ.SweepParam(1:length(data(i,:))).*gmSEQ.ScaleT, data(i,:), data_err(i,:), ...
                'color', [(i-1)/(gmSEQ.Ntomo - 1), 0, 1-(i-1)/(gmSEQ.Ntomo - 1)], ...
                'DisplayName', num2str(i))
            hold(handles.axes3, 'on')
        end
        legend(handles.axes3)
        hold(handles.axes3, 'off')
    else
        if gmSEQ.ctrN==3
            if strcmp(gmSEQ.name,'T1JC')
                data=signal(1,:)-signal(2,:)./signal(3,:);
            else
                data=signal(1,:);
                data_err = zeros(size(data));
                % data=signal(1,:)-signal(3,:)./(signal(2,:)-signal(4,:));
            end
        elseif gmSEQ.ctrN==2
            if strcmp(gmSEQ.name,'Scan_CounterGate_time') || strcmp(gmSEQ.name,'f_CtrGateCali')
                sig = signal(2,:);
                ref = signal(1,:);
                data = (ref-sig)./ref.*sqrt(sig);        % contrast / noise in signal
                data_err =zeros(size(sig));
            else
                sig = signal(2,:);
                ref = signal(1,:);
                data = sig./ref;
                %data = ref-sig;
                ref_err = 1./sqrt(gmSEQ.iAverage * ref); % Relative error of reference
                sig_err = 1./sqrt(gmSEQ.iAverage * sig); % Relative error of signal
                rel_err = sqrt(ref_err.^2 + sig_err.^2);
                data_err = rel_err .* data;
            end
        elseif gmSEQ.ctrN==4
            if strcmp(gmSEQ.name,'Test_NV_Polarization') || strcmp(gmSEQ.name,'Special Cooling') || strcmp(gmSEQ.name,'Special Cooling_2') || strcmp(gmSEQ.name,'Special Cooling_P1_2_DurMeas')
                data = (signal(1,:)-signal(3,:))./(signal(2,:)+signal(4,:))*2;
            elseif strcmp(gmSEQ.name,'CtrDur') && gmSEQ.meas == "SPCM"
                data = -(signal(2,:)-signal(4,:))./sqrt((signal(1,:)+signal(3,:))/2);
                data_err = data .* 0;
            elseif strcmp(gmSEQ.name,'Elec_Pol_Extract') || strcmp(gmSEQ.name,'Rabi_fix_MWDutyCycle')
                sig1 = signal(2,:);
                ref1 = signal(1,:);
                data1 = sig1./ref1;
                ref_err1 = 1./sqrt(gmSEQ.iAverage * ref1); % Relative error of reference
                sig_err1 = 1./sqrt(gmSEQ.iAverage * sig1); % Relative error of signal
                rel_err1 = sqrt(ref_err1.^2 + sig_err1.^2);
                data_err1 = rel_err1 .* data1;
                
                sig2 = signal(4,:);
                ref2 = signal(3,:);
                data2 = sig2./ref2;
                ref_err2 = 1./sqrt(gmSEQ.iAverage * ref2); % Relative error of reference
                sig_err2 = 1./sqrt(gmSEQ.iAverage * sig2); % Relative error of signal
                rel_err2 = sqrt(ref_err2.^2 + sig_err2.^2);
                data_err2 = rel_err2 .* data2;
            elseif strcmp(gmSEQ.name,'T1_Rb_S00_S01_Rd')||strcmp(gmSEQ.name,'T1_Rb_S00_S01_Rd_newRef')
                % data = (gmSEQ.reference(~isnan(gmSEQ.reference))-gmSEQ.reference3(~isnan(gmSEQ.reference3)))./(gmSEQ.signal(~isnan(gmSEQ.signal))+gmSEQ.reference2(~isnan(gmSEQ.reference2)))*2;
                ref_B = signal(1,:);
                ref_D = signal(3,:);
                sig_B = signal(2,:);
                sig_D = signal(4,:);
                
                [data, data_err] = ContrastDiff(ref_B, ref_D,sig_B, sig_D, gmSEQ.iAverage);
            elseif strcmp(gmSEQ.name,'Echo')
                ref_B = signal(1,:);
                ref_D = signal(3,:);
                sig_B = signal(2,:);
                sig_D = signal(4,:); 
                [data, data_err] = ContrastDiff(ref_B, ref_D,sig_B, sig_D, gmSEQ.iAverage);
            elseif strcmp(gmSEQ.name,'Echo_wDarkRef')
                ref_B = signal(3,:);
                ref_D = signal(1,:);
                sig_B = signal(2,:);
                sig_D = signal(4,:); 
                data = (sig_B - sig_D)./(ref_B - ref_D);
                N =  gmSEQ.iAverage;
                ref_B_err = 1./sqrt(N * ref_B); % Relative error of bright reference
                ref_D_err = 1./sqrt(N * ref_D); % Relative error of dark reference
                sig_B_err = 1./sqrt(N * sig_B); % Relative error of bright signal
                sig_D_err = 1./sqrt(N * sig_D); % Relative error of dark signal
                ref_err = sqrt((ref_B_err .* ref_B).^2 + (ref_D_err .* ref_D).^2)./(ref_B + ref_D);
                sig_err = sqrt((sig_B_err .* sig_B).^2 + (sig_D_err .* sig_D).^2)./(sig_B - sig_D);
                rel_err = sqrt(ref_err.^2 + sig_err.^2);
                data_err = rel_err .* data;
            elseif strcmp(gmSEQ.name,'f_DEER_scan_freq')||strcmp(gmSEQ.name,'f_Echo')||strcmp(gmSEQ.name,'f_DEER_scan_tau')...
                    ||strcmp(gmSEQ.name,'f_DEER_scan_dur')||strcmp(gmSEQ.name,'f_DEER_scan_power')
                ref_B = signal(1,:);
                ref_D = signal(3,:);
                sig_B = signal(2,:);
                sig_D = signal(4,:); 
                [data, data_err] = ContrastDiff2(ref_B, ref_D,sig_B, sig_D, gmSEQ.iAverage);
            elseif strcmp(gmSEQ.name,'f_XY8')||strcmp(gmSEQ.name,'f_DEER_XY8')
                ref_B = signal(1,:);
                sig_D = signal(2,:);
                ref_D = signal(3,:);
                sig_B = signal(4,:); 
                [data, data_err] = ContrastDiff2(ref_B, ref_D,sig_B, sig_D, gmSEQ.iAverage);
            else          
                ref_B = signal(3,:);
                ref_D = signal(1,:);
                sig_B = signal(4,:);
                sig_D = signal(2,:);           
                [data, data_err] = ContrastDiff(ref_B, ref_D,sig_B, sig_D, gmSEQ.iAverage);
            end
        elseif gmSEQ.ctrN==5
            sig_B = signal(2,:);
            ref_B = signal(1,:);
            sig_D = signal(4,:);
            ref_D = signal(3,:);
            data = sig_B-sig_D;
            data_err = zeros(size(signal(1,:)));
        else
            data = zeros(size(signal(1,:)));
            data_err = data;
        end
        % plot(handles.axes3, gmSEQ.SweepParam(1:length(data)).*ScaleT,data,'-g')
        if strcmp(gmSEQ.name,'Elec_Pol_Extract')|| strcmp(gmSEQ.name,'Rabi_fix_MWDutyCycle')
            errorbar(handles.axes3, gmSEQ.SweepParam(1:length(data1)).*gmSEQ.ScaleT, data1, data_err1,'-r')
            hold(handles.axes3,'on')
            errorbar(handles.axes3, gmSEQ.SweepParam(1:length(data2)).*gmSEQ.ScaleT, data2, data_err2,'-b')
            hold(handles.axes3,'off')
        else
            errorbar(handles.axes3, gmSEQ.SweepParam(1:length(data)).*gmSEQ.ScaleT, data, data_err,'-g')
        end
    end
    grid on;
    set(handles.axes3,'FontSize',8);
    ylabel(handles.axes3, 'Fluorescence contrast');
    xlabel(handles.axes3, gmSEQ.ScaleStr);
    if length(gmSEQ.SweepParam) ~= 1
        xlim(handles.axes3, [gmSEQ.SweepParam(1)*gmSEQ.ScaleT gmSEQ.SweepParam(gmSEQ.NSweepParam)*gmSEQ.ScaleT]);
    end
    if raw_j~=0
        xline(handles.axes3, single(gmSEQ.SweepParam(raw_j))*gmSEQ.ScaleT,'--', 'color','r','HandleVisibility','off')
    end
end

function [data, data_err] = ContrastDiff(ref_B, ref_D,sig_B, sig_D, N)
data = 2*(sig_B - sig_D)./(ref_B + ref_D);
%data = (sig_B - sig_D)./(ref_B - ref_D); %Normalize to 1
ref_B_err = 1./sqrt(N * ref_B); % Relative error of bright reference
ref_D_err = 1./sqrt(N * ref_D); % Relative error of dark reference
sig_B_err = 1./sqrt(N * sig_B); % Relative error of bright signal
sig_D_err = 1./sqrt(N * sig_D); % Relative error of dark signal
ref_err = sqrt((ref_B_err .* ref_B).^2 + (ref_D_err .* ref_D).^2)./(ref_B + ref_D);
sig_err = sqrt((sig_B_err .* sig_B).^2 + (sig_D_err .* sig_D).^2)./(sig_B - sig_D);
rel_err = sqrt(ref_err.^2 + sig_err.^2);
data_err = rel_err .* data;

function [data, data_err] = ContrastDiff2(ref_B, ref_D,sig_B, sig_D, N)
data = (sig_B - sig_D)./(ref_B - ref_D); %Normalize to 1
ref_B_err = 1./sqrt(N * ref_B); % Relative error of bright reference
ref_D_err = 1./sqrt(N * ref_D); % Relative error of dark reference
sig_B_err = 1./sqrt(N * sig_B); % Relative error of bright signal
sig_D_err = 1./sqrt(N * sig_D); % Relative error of dark signal
ref_err = sqrt((ref_B_err .* ref_B).^2 + (ref_D_err .* ref_D).^2)./(ref_B + ref_D);
sig_err = sqrt((sig_B_err .* sig_B).^2 + (sig_D_err .* sig_D).^2)./(sig_B - sig_D);
rel_err = sqrt(ref_err.^2 + sig_err.^2);
data_err = rel_err .* data;

function StartCounters(task)
DAQmxStartTask(task);

function [status,A] = ReadCountersN(task,samps,timeout)
global gmSEQ

if strcmp(gmSEQ.meas,'SPCM')
    [status, A]= DAQmxReadCounterU32(task, samps, timeout, zeros(1,samps), samps, libpointer('int32Ptr',0) );
elseif strcmp(gmSEQ.meas,'APD')
    numCHNtoRead = 1;
    [status, A] = DAQmxFunctionPool('ReadAnalogVoltage',task, samps, timeout, numCHNtoRead);
end
DAQmxErr(status);

function [status,A] = ReadCountersPD(task,samps,timeout,numPDChan)
[status, A] = DAQmxFunctionPool('ReadAnalogVoltage',task, samps, timeout,numPDChan);
DAQmxErr(status);

function ClearCounters(task)
DAQmxClearTask(task);

function TemporarySave(BackupFile)
global gSG gmSEQ

% convert relevant globals to a bigger structure
BackupExp.gmSEQ=gmSEQ;
BackupExp.gSG=gSG;
%save the data in matlab binary format
save(BackupFile,'BackupExp');

function [vec, NN] = MakeSweepVector
global gSG gmSEQ
vecA=-1:(2/(gmSEQ.NSweepParam-1)):1;

vec=[vecA fliplr(vecA)];

vec=repmat(vec,1,ceil(gSG.sweepRate*gmSEQ.misc/2));
if strcmp(gmSEQ.meas,'SPCM')
    vec=[vec(1) vec];
end
NN=length(vec);

function sigDatum = ProcessData(RawData)
global gmSEQ gSG
if strcmp(gmSEQ.meas,'SPCM')
    % for ESR
    if isfield(gmSEQ,'bLiO')
        AA=diff(RawData);
        sigDatum=zeros(1,gmSEQ.NSweepParam);
        samps=gmSEQ.misc*gSG.sweepRate;
        AA=reshape(AA,[gmSEQ.NSweepParam samps]);
        AA(:,2:2:(samps))=flipud(AA(:,2:2:(samps)));
        for i=1:gmSEQ.NSweepParam
            sigDatum(i)=sum(AA(i,:))/(samps);
        end
    else
        if 1
            %RawData1 = diff(RawData); %use if DAQ generate sample at the rising edge
            RawData1 = diff([0 RawData]); %use if DAQ generate sample at the falling edge
            
            % if save raw box is checked, then save raw data to csv (will be overwritten)
%             if gmSEQ.saveRaw
%                 csvwrite('D:\RawData.csv', RawData1);
%             end
            
            
            sigDatum = NaN(1, gmSEQ.ctrN);
            for i = 1:gmSEQ.ctrN
                sigDatum(i)=sum(RawData1(i:gmSEQ.ctrN:end));
            end
        else %use when daq is sampling at both rising and falling edge of the gate pulse
            RawData2 = diff(RawData);
            sigDatum = NaN(1, gmSEQ.ctrN);
            for i = 1:gmSEQ.ctrN
                sigDatum(i)=sum(RawData2(2*i:gmSEQ.ctrN*2:end));
            end
        end
        
    end
elseif strcmp(gmSEQ.meas,'APD')
    if isfield(gmSEQ,'bLiO')
        sigDatum=zeros(1,gmSEQ.NSweepParam);
        samps=gmSEQ.misc*gSG.sweepRate;
        RawData=reshape(RawData,[gmSEQ.NSweepParam samps]);
        RawData(:,2:2:(samps))=flipud(RawData(:,2:2:(samps)));
        for i=1:gmSEQ.NSweepParam
            sigDatum(i)=sum(RawData(i,:))/(samps);
        end
    else
        sigDatum = NaN(1, gmSEQ.ctrN);
        for i = 1:gmSEQ.ctrN
            sigDatum(i)=sum(RawData(i:gmSEQ.ctrN:end))/(length(RawData)/gmSEQ.ctrN);
        end
    end
    
end

function CreateCaliLog(hObject, eventdata, handles)
global gCaliLog gTrackLog gmSEQ gCaliCounter
if ~gmSEQ.bTrack
    return
end
now = clock;
date = [num2str(now(1)),'-',num2str(now(2)),'-',num2str(round(now(3)))];
fullPath=fullfile('D:\Data\',date,'\');
if ~exist(fullPath,'dir')
    mkdir(fullPath);
end

if gmSEQ.bCali
    gCaliCounter.RFCali = 0;
    gCaliLog.path = fullPath;
    gCaliLog.file = ['_' date '_CaliLog.txt'];
    name=regexprep(gmSEQ.name,'\W',''); % rewrite the sequence name without spaces/weird characters
    %File name and prompt
    B=fullfile(gCaliLog.path, strcat(name, gCaliLog.file));
    file = strcat(name, gCaliLog.file);
    
    %Prevent overwriting
    mfile = strrep(B,'.txt','*');
    mfilename = strrep(gCaliLog.file,'.txt','');
    A = ls(char(mfile));
    ImgN = 0;
    for f = 1:size(A,1)
        sImgN = sscanf(A(f,:),strcat(name, string(mfilename), '_%d.txt'));
        if ~isempty(sImgN)
            if sImgN > ImgN
                ImgN = sImgN;
            end
        end
    end
    ImgN = ImgN + 1;
    file = strrep(file,'.txt',sprintf('_%03d.txt',ImgN));
    gCaliLog.final= fullfile(gCaliLog.path, file);
end
if gmSEQ.bTrack
    gCaliCounter.ImageCorr = 0;
    gTrackLog.path = fullPath;
    gTrackLog.file = ['_' date '_TrackLog.txt'];
    name=regexprep(gmSEQ.name,'\W',''); % rewrite the sequence name without spaces/weird characters
    %File name and prompt
    B=fullfile(gTrackLog.path, strcat(name, gTrackLog.file));
    file = strcat(name, gTrackLog.file);
    
    %Prevent overwriting
    mfile = strrep(B,'.txt','*');
    mfilename = strrep(gTrackLog.file,'.txt','');
    A = ls(char(mfile));
    ImgN = 0;
    for f = 1:size(A,1)
        sImgN = sscanf(A(f,:),strcat(name, string(mfilename), '_%d.txt'));
        if ~isempty(sImgN)
            if sImgN > ImgN
                ImgN = sImgN;
            end
        end
    end
    ImgN = ImgN + 1;
    file = strrep(file,'.txt',sprintf('_%03d.txt',ImgN));
    gTrackLog.final= fullfile(gTrackLog.path, file);
end

function Calibration(hObject, eventdata, handles)
global gCaliCounter gmSEQ
if gmSEQ.bTrack
    gCaliCounter.ImageCorr = gCaliCounter.ImageCorr + 1;
    if (mod(gCaliCounter.ImageCorr, gmSEQ.TrackPointN)==1) % track at the starting of the measurement
        Track('ImageCorr');
    end
end

if 0
%if gmSEQ.bCali
    gCaliCounter.RFCali = gCaliCounter.RFCali + 1;
    if (mod(gCaliCounter.RFCali, gmSEQ.CaliN)==1) || (gmSEQ.CaliN == 1)
        if strcmp(gmSEQ.name, 'Special Cooling')
            AutoCalibration(hObject, eventdata, handles);
        end
    end
end

function AutoCalibration(hObject, eventdata, handles)
global gmSEQ gSG gSG2 gSaveDataAve gCaliLog

if ~gmSEQ.bCali
    return;
end
% Save the current parameters
gmSEQt = gmSEQ;
gSGt = gSG;
gSG2t = gSG2;
gSaveDataAvet = gSaveDataAve;

% Set Laser AWG power here
h = findobj('Tag','ImageNVCGUI');
if ~isempty(h)
    % get handles and other user-defined data associated to Gui1
    handles_ImageNVC = guidata(h);
end
PBFunctionPool('PBON',2^SequencePool('PBDictionary','AOM'));
ImageFunctionPool('UpdateVoltage',0, 0, handles_ImageNVC);

ExperimentFunctionPool('AutoCalibration', hObject, eventdata, handles, false);
gSGt.Freq = gSG.Freq;
gSGt.Pow = gSG.Pow;
gmSEQt.SAmp1 = gSG.AWGAmp;
gmSEQt.SAmp2 = gSG.AWGAmp;
gmSEQt.SAmp1_M = gSG.AWGAmp;
gmSEQt.SAmp2_M = gSG.AWGAmp;

% Log
fid = fopen(string(gCaliLog.final),'at'); % a means add data, w means new data
fprintf(fid,'%s', [datestr(datetime(clock))]);
fprintf(fid,' %4.3f %2.1f %.2f\n', [gSG.Freq/1e9 + 0.125, gSG.Pow, gSG.AWGAmp]);
fclose(fid);

% Load the parameters
gmSEQ = gmSEQt;
gSG = gSGt;
gSG2 = gSG2t;
gSaveDataAve = gSaveDataAvet;

% Reset MW
gmSEQ.refCounts=Track('Init');
SignalGeneratorFunctionPool('SetMod');
SignalGeneratorFunctionPool('WritePow');
SignalGeneratorFunctionPool('WriteFreq');
gSG.bOn=1; SignalGeneratorFunctionPool('RFOnOff');

function refCounts = Track(what)
global gmSEQ gSG gTrackLog gScan

if gmSEQ.bTrack
    % get the handle of Gui1
    h = findobj('Tag','ImageNVCGUI');
    
    % if exists (not empty)
    if ~isempty(h)
        % get handles and other user-defined data associated to Gui1
        handles_ImageNVC = guidata(h);
    end
    
    PBFunctionPool('PBON',2^SequencePool('PBDictionary','GreenAOM'));
    currentCounts = ImageFunctionPool('RunCPSOnce',0, 0, handles_ImageNVC);
    if ~isfield(gmSEQ,'bLiO')
        ExperimentFunctionPool('PBOFF',0, 0, handles_ImageNVC);
    end
else
    refCounts=0;
    return
end

switch what
    case 'Init'
        refCounts=currentCounts;
        return
    case 'Run'
        if currentCounts<.9*gmSEQ.refCounts
            PBFunctionPool('PBON',2^SequencePool('PBDictionary','AOM'));
            %             for i=1:3
            %                 currentCounts = ImageFunctionPool('NewTrackFast',0, 0, handles_ImageNVC);
            %                 drawnow;
            %                 if gmSEQ.bGo==0
            %                     refCounts=currentCounts;
            %                     return
            %                 end
            %             end
            ImageFunctionPool('TrackImageCorr',0, 0, handles_ImageNVC);
            ImageFunctionPool('TrackZ', 0, 0, handles_ImageNVC);
            if ~isfield(gmSEQ,'bLiO')
                ExperimentFunctionPool('PBOFF',0, 0, handles_ImageNVC);
            end
            fid = fopen(string(gTrackLog.final),'at'); % a means add data, w means new data
            fprintf(fid,'%s', datestr(datetime(clock)));
            fprintf(fid,' %.4f %.4f %3.1f\n', [gScan.FixVx, gScan.FixVy, gScan.FixVz]);
            fclose(fid);
            refCounts=currentCounts;
        else
            refCounts=gmSEQ.refCounts;
        end
    case 'ImageCorr'
        %disp(['ImageCorrelate']);
        PBFunctionPool('PBON',2^SequencePool('PBDictionary','GreenAOM'));
        % ImageFunctionPool('UpdateVoltage',0, 0, handles_ImageNVC);
        ImageFunctionPool('TrackZ', 0, 0, handles_ImageNVC);% not written
        ImageFunctionPool('TrackImageCorr',0, 0, handles_ImageNVC);
        % ImageFunctionPool('TrackImageCorr',0, 0, handles_ImageNVC);
        refCounts = currentCounts;
        
        fid = fopen(string(gTrackLog.final),'at'); % a means add data, w means new data
        fprintf(fid,'%s', datestr(datetime(clock)));
        fprintf(fid,' %.4f %.4f %3.1f\n', [gScan.FixVx, gScan.FixVy, gScan.FixVz]);
        fclose(fid);
        
        % pause(20); % z postion relaxation
end

function CreateSavePath_Ave()
global gSaveDataAve gmSEQ
now = clock;
date = [num2str(now(1)),'-',num2str(now(2)),'-',num2str(round(now(3)))];
fullPath=fullfile('D:\Data\',date,'\');
if ~exist(fullPath,'dir')
    mkdir(fullPath);
end
gSaveDataAve.path = fullPath;

gSaveDataAve.file = ['_' date '_Ave.txt'];
name=regexprep(gmSEQ.name,'\W',''); % rewrite the sequence name without spaces/weird characters
%File name and prompt
B=fullfile(gSaveDataAve.path, strcat(name, gSaveDataAve.file));
file = strcat(name, gSaveDataAve.file);

%Prevent overwriting
mfile = strrep(B,'.txt','*');
mfilename = strrep(gSaveDataAve.file,'.txt','');

A = ls(char(mfile));
ImgN = 0;
for f = 1:size(A,1)
    sImgN = sscanf(A(f,:),strcat(name, string(mfilename), '_%d.txt'));
    if ~isempty(sImgN)
        if sImgN > ImgN
            ImgN = sImgN;
        end
    end
end
ImgN = ImgN + 1;
gSaveDataAve.file = strrep(file,'.txt',sprintf('_%03d.txt',ImgN));

function Set_FPGA_GUI_buttons(handles, is_enable)
handles.fpga_get_waveform_lsit.Enable = is_enable;
handles.fpga_get_program_list.Enable = is_enable;
handles.fpga_get_envelope_list.Enable = is_enable;
handles.fpga_get_state.Enable = is_enable;
handles.fpga_get_connect.Enable = is_enable;
handles.fpga_get_disconnect.Enable = is_enable;

