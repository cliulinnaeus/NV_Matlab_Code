function RunSequence(hObject, eventdata, handles)
[y,Fs] = audioread('WindowsNotify.wav');
BackupFile = 'C:\MATLAB_Code\Data\TempDataBackup\Temp.mat';
global gmSEQ gSG tmax hCPS gSG2 

% Stop the previous sequence if it is running
% if gmSEQ.bExp
%     error("Previous experiment is running. Please first stop previous experiment.");
% end

gmSEQ.bGo = 1;
gmSEQ.bExp = 1; % experiment status tag
SequencePool(string(gmSEQ.name));
InitializeData(handles);

disp(strcat('Commencing ',{' '},string(gmSEQ.name), ' sequence...'))
drawnow;
 
if gSG.bfixedPow && gSG.bfixedFreq
    CreateSavePath_Ave()
    
    gmSEQ.signal_Ave =NaN(1,gmSEQ.NSweepParam);
    gmSEQ.reference_Ave=NaN(1,gmSEQ.NSweepParam);
    gmSEQ.reference2_Ave=NaN(1,gmSEQ.NSweepParam);
    gmSEQ.reference3_Ave=NaN(1,gmSEQ.NSweepParam);

    gmSEQ.refCounts=Track('Init');
    SignalGeneratorFunctionPool('SetMod');
    SignalGeneratorFunctionPool('WritePow');
    SignalGeneratorFunctionPool('WriteFreq');
    gSG.bOn=1;  SignalGeneratorFunctionPool('RFOnOff');      

    CreateCaliLog(hObject, eventdata, handles);
    gmSEQ.bRandom = false;  % Shuffle the input, added by Weijie 04/20/2022
    if gmSEQ.bRandom 
        disp("Random measurement ongoing...")
    end

    try
        [~, hCounter] = SetNCounters(gmSEQ.ctrN*gmSEQ.Repeat,'/Dev1/PFI1',500000);

        ImageCorrCounter = 0; % a Counter to identify when to track
        CaliCounter = 0;

        for i=1:gmSEQ.Average
            gmSEQ.iAverage=i;
            handles.biAverage.String=num2str(gmSEQ.iAverage);
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

                ImageCorrCounter = ImageCorrCounter+1;
                if (mod(ImageCorrCounter, gmSEQ.TrackPointN)==1) % track at the starting of the measurement
                    Track('ImageCorr');
                end                

                CaliCounter = CaliCounter + 1;
                if (mod(CaliCounter, gmSEQ.CaliN)==1) || (gmSEQ.CaliN == 1)
                    if strcmp(gmSEQ.name, 'Special Cooling')
                        AutoCalibration(hObject, eventdata, handles);
                    end  
                end

                gmSEQ.m=gmSEQ.SweepParam(j); % Manually change the sweep range here. 
                if strcmp(gmSEQ.name, 'Special Cooling')
                    disp(['    gmSEQ.m = ', num2str(gmSEQ.m)]);
                end                  

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
                [sigDatum, refDatum] = ProcessData(vec);
                if i==1
                    gmSEQ.signal(j)=sigDatum;
                    gmSEQ.reference(j)=refDatum(1);
                    gmSEQ.reference2(j)=refDatum(2);
                    if gmSEQ.ctrN==4
                        gmSEQ.reference3(j)=refDatum(3);
                    end
                else
                    gmSEQ.signal(j)=((gmSEQ.signal(j)*(i-1))+sigDatum)/i;
                    gmSEQ.reference(j)=((gmSEQ.reference(j)*(i-1))+refDatum(1))/i;
                    gmSEQ.reference2(j)=((gmSEQ.reference2(j)*(i-1))+refDatum(2))/i;
                    if gmSEQ.ctrN==4
                        gmSEQ.reference3(j)=((gmSEQ.reference3(j)*(i-1))+refDatum(3))/i;
                    end
                end

                gmSEQ.signal_Ave(j) =sigDatum;
                gmSEQ.reference_Ave(j)=refDatum(1);
                gmSEQ.reference2_Ave(j)=refDatum(2);
                if gmSEQ.ctrN==4
                    gmSEQ.reference3_Ave(j)=refDatum(3);
                end 

                % save a backup of the data here in case matlab crashes
                TemporarySave(BackupFile);
                PlotData(handles);
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

            % if strcmp(gmSEQ.name, 'Special Cooling')
                SaveIgorText_Average(handles);
            % end
            SaveIgorText(handles);

            if ~gmSEQ.bGo || ~gmSEQ.bGoAfterAvg
                break
            end


        end

        ClearCounters(hCounter);
    catch ME
        KillAllTasks;
        rethrow(ME);
    end
    if gmSEQ.bTrack
        PBFunctionPool('PBON',2^SequencePool('PBDictionary','AOM'));
    end
elseif isfield(gmSEQ,'bLiO')   % activates for ESR
    gmSEQ.refCounts=Track('Init');
    SequencePool(string(gmSEQ.name));
    gmSEQ.SweepParam=gmSEQ.SweepParam*1e9;
    gSG.sweepDev=(gmSEQ.SweepParam(gmSEQ.NSweepParam)-gmSEQ.SweepParam(1))/2;
    gSG.Freq=(gmSEQ.SweepParam(gmSEQ.NSweepParam)+gmSEQ.SweepParam(1))/2;
    SignalGeneratorFunctionPool('WriteFreq');
    SignalGeneratorFunctionPool('WritePow');
    SignalGeneratorFunctionPool('SetMod');
    PBFunctionPool('PBON',2^SequencePool('PBDictionary','AOM')+2^SequencePool('PBDictionary','MWSwitch'));

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
            [ ~, hScan ] = DAQmxFunctionPool('WriteAnalogVoltage','Dev1/ao2',vec, NN,gmSEQ.NSweepParam*gSG.sweepRate);
            hCPS.hScan=hScan;
            %%%%% Create counting channel %%%%
            [~, hCounter] = SetNCounters(NN,'/Dev1/PFI13',gmSEQ.NSweepParam*gSG.sweepRate);
            hCPS.hCounter=hCounter;
            gmSEQ.iAverage=i;
            handles.biAverage.String=num2str(gmSEQ.iAverage);
            status = DAQmxStartTask(hScan);  DAQmxErr(status);
            status = DAQmxStartTask(hCounter);  DAQmxErr(status);
            status = DAQmxStartTask(hPulse);    DAQmxErr(status);

            [~, A] = ReadCountersN(hCounter,NN, gmSEQ.misc*1.1);

            DAQmxStopTask(hCounter);
            DAQmxStopTask(hScan);
            DAQmxStopTask(hPulse);
            if gmSEQ.bAAR==1
                if i==1
                    gmSEQ.signal = ProcessData(A);
                else
                    gmSEQ.signal = (gmSEQ.signal*(i-1)+ProcessData(A))/i;
                end
            else
                gmSEQ.signal = ProcessData(A);
            end

            TemporarySave(BackupFile);
            PlotData(handles);
            drawnow;
            DAQmxClearTask(hCounter);
            DAQmxClearTask(hPulse);
            DAQmxClearTask(hScan);
            if ~gmSEQ.bGo || ~gmSEQ.bGoAfterAvg
                break
            end
        end
    catch ME
        KillAllTasks;
        gSG.bOn=0; SignalGeneratorFunctionPool('RFOnOff');
        gSG2.bOn=0; SignalGeneratorFunctionPool2('RFOnOff');
        rethrow(ME);
    end
    if ~gmSEQ.bTrack
        ExperimentFunctionPool('PBOFF',hObject, eventdata, handles);
    end


elseif gSG.bfixedPow && ~gSG.bfixedFreq % for ODMR
    gmSEQ.refCounts=Track('Init');
    SignalGeneratorFunctionPool('SetMod');
    SignalGeneratorFunctionPool('WritePow');
    gSG.bOn=1; SignalGeneratorFunctionPool('RFOnOff');
    gmSEQ.SweepParam=gmSEQ.SweepParam*1e9;

    try
        [~, hCounter] = SetNCounters(gmSEQ.ctrN*gmSEQ.Repeat,'/Dev1/PFI1',500000);
        ImageCorrCounter = 0;
        for i=1:gmSEQ.Average
            gmSEQ.iAverage=i;
            handles.biAverage.String=num2str(gmSEQ.iAverage);
            j=1;
            iwarmup=1;
            while j<=gmSEQ.NSweepParam
                %             gmSEQ.refCounts=Track('Run');
                ImageCorrCounter = ImageCorrCounter+1;
                if mod(ImageCorrCounter, gmSEQ.TrackPointN) == 1 % track at the starting of the measurement
                    Track('ImageCorr');
                end
                SequencePool(string(gmSEQ.name));

                if gSG.ACmodAWG
                    gSG.Freq = gmSEQ.SweepParam(j)-str2double(get(handles.AWGFreq, 'String'))*1e9;
                else
                    gSG.Freq = gmSEQ.SweepParam(j);
                end
%                     gSG.Freq=gmSEQ.SweepParam(j);
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
                [sigDatum, refDatum] = ProcessData(vec);
                if i==1
                    gmSEQ.signal(j)=sigDatum;
                    gmSEQ.reference(j)=refDatum(1);
                    %   if gmSEQ.bCtr2
                    gmSEQ.reference2(j)=refDatum(2);

                    % Ask Satcher
                    if gmSEQ.ctrN==4
                        gmSEQ.reference3(j)=refDatum(3);
                    end
                    %   end
                else
                    gmSEQ.signal(j)=((gmSEQ.signal(j)*(i-1))+sigDatum)/i;
                    gmSEQ.reference(j)=((gmSEQ.reference(j)*(i-1))+refDatum(1))/i;
                    gmSEQ.reference2(j)=((gmSEQ.reference2(j)*(i-1))+refDatum(2))/i;

                    if gmSEQ.ctrN==4
                        gmSEQ.reference3(j)=((gmSEQ.reference3(j)*(i-1))+refDatum(3))/i;
                    end
                end
                % save a backup of the data here in case matlab crashes
                TemporarySave(BackupFile);
                PlotData(handles);
                drawnow;
                if ~gmSEQ.bGo
                    break
                end
                if (gmSEQ.bWarmUpAOM && iwarmup==2)||~gmSEQ.bWarmUpAOM||i~=1||j~=1
                    j=j+1;
                elseif gmSEQ.bWarmUpAOM
                    iwarmup=iwarmup+1;
                end

            end
            SaveIgorText(handles);
            if ~gmSEQ.bGo || ~gmSEQ.bGoAfterAvg
                break
            end
        end

        ClearCounters(hCounter);
    catch ME
        KillAllTasks;
        rethrow(ME);
    end
end

gSG.bOn=0; SignalGeneratorFunctionPool('RFOnOff');
gSG2.bOn=0; SignalGeneratorFunctionPool2('RFOnOff');

gmSEQ.bGo = 0;
gmSEQ.bExp = 0;
SaveIgorText(handles);

disp('Experiment completed!')
sound(y,Fs);
%SaveData;

function InitializeData(handles)

global gmSEQ

% for two sweeping range, with option for log10 sampling
% Add by C. Zu on 9/29/2020
if (gmSEQ.bSweep1log)
    gmSEQ.SweepParam=logspace(log10(gmSEQ.From),log10(gmSEQ.To),gmSEQ.N);
else
    gmSEQ.SweepParam=linspace(gmSEQ.From,gmSEQ.To,gmSEQ.N);
end

if (gmSEQ.bSweep2)
    if (gmSEQ.bSweep2log)
        gmSEQ.SweepParam=[gmSEQ.SweepParam logspace(log10(gmSEQ.From2),log10(gmSEQ.To2),gmSEQ.N2)];
    else
        gmSEQ.SweepParam=[gmSEQ.SweepParam linspace(gmSEQ.From2,gmSEQ.To2,gmSEQ.N2)];
    end
end

if (gmSEQ.bSweep3)
    if (gmSEQ.bSweep3log)
        gmSEQ.SweepParam=[gmSEQ.SweepParam logspace(log10(gmSEQ.From3),log10(gmSEQ.To3),gmSEQ.N3)];
    else
        gmSEQ.SweepParam=[gmSEQ.SweepParam linspace(gmSEQ.From3,gmSEQ.To3,gmSEQ.N3)];
    end
end

% Customized in the input data here 
% DEER ODMR Weijie 04/19/2022
gmSEQ.bCust = false;
if gmSEQ.bCust
    % gmSEQ.SweepParam = [linspace(0.900,0.928, 15), linspace(0.930,0.969,40), linspace(0.970, 1.018, 25), linspace(1.020, 1.069, 51),  linspace(1.070, 1.100, 16)];
    % For long time XY8
    % gmSEQ.SweepParam = [linspace(50, 20050, 5), linspace(40000, 100000, 4), linspace(150000, 400000, 6), linspace(500000, 1000000, 6)];
    gmSEQ.SweepParam = [linspace(0, 20, 5), linspace(40, 100, 4), linspace(150, 400, 6), linspace(500, 800, 4), linspace(1000, 1200, 2)];
    % gmSEQ.SweepParam = [linspace(0, 20, 5), linspace(40, 100, 4), linspace(200, 600, 5), linspace(800, 1200, 3)];
    disp("Customized input, GUI values are overwritten.")
end

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

function [signal, reference]=CreateAndSetCounters()

[ status, ~, signal ] = DAQmxCreateTask([]);
DAQmxErr(status);

[ status, ~, reference(1) ] = DAQmxCreateTask([]);
DAQmxErr(status);

DAQmxFunctionPool('SetGatedCounter',signal,'Dev1/ctr0','/Dev1/PFI8','/Dev1/PFI9');
DAQmxFunctionPool('SetGatedCounter',reference(1),'Dev1/ctr1','/Dev1/PFI8','/Dev1/PFI4');

% gmSEQ.bCtr2=0;
% ctr2=SequencePool('PBDictionary','ctr2');
% for i=1:numel(gmSEQ.CHN)
%     if gmSEQ.CHN(i).PBN==ctr2
%         [ status, ~, reference(2) ] = DAQmxCreateTask([]);
%         DAQmxErr(status);
%         gmSEQ.bCtr2=1;
%         DAQmxFunctionPool('SetGatedCounter',reference(2),'Dev1/ctr2','/Dev1/PFI8','/Dev1/PFI6');
%         break
%     end
% end

function [status, task] = SetNCounters(varargin)
%varargin(1) is the number of total samples
%varargin(2) is the source of gating
%varargin(3) is the frequency of the gating to expect
% Initialize DAQ
global gmSEQ hCPS
if strcmp(gmSEQ.meas,'SPCM')
    if isfield(gmSEQ,'bLiO')
        [status, task ] = DAQmxFunctionPool('SetCounter',varargin{1});
    else
        [status, task ] = DAQmxFunctionPool('SetGatedNCounter',varargin{1});
    end
    
elseif strcmp(gmSEQ.meas,'APD')
    [status, task ] = DAQmxFunctionPool('CreateAIChannel',varargin{2},varargin{1},varargin{3});
end
hCPS.hCounter=task;

function PlotData(handles)
global gmSEQ ScaleT ScaleStr

%axes(handles.axes2); %cla;
plot(handles.axes2, single(gmSEQ.SweepParam)*ScaleT,single(gmSEQ.signal),'-b','LineWidth', 0.5)
hold(handles.axes2, 'on')
plot(handles.axes2, single(gmSEQ.SweepParam)*ScaleT,single(gmSEQ.reference),'--b','LineWidth', 0.5)
plot(handles.axes2, single(gmSEQ.SweepParam)*ScaleT,single(gmSEQ.reference2),':b','LineWidth', 1)
plot(handles.axes2, single(gmSEQ.SweepParam)*ScaleT,single(gmSEQ.reference3),'-.b','LineWidth', 0.5)

if gmSEQ.Alternate
    plot(handles.axes2, single(gmSEQ.SweepParam)*ScaleT,single(gmSEQ.signal_2),'-r','LineWidth', 0.5)
    plot(handles.axes2, single(gmSEQ.SweepParam)*ScaleT,single(gmSEQ.reference_2),'--r','LineWidth', 0.5)
    plot(handles.axes2, single(gmSEQ.SweepParam)*ScaleT,single(gmSEQ.reference2_2),':r','LineWidth', 1)
    plot(handles.axes2, single(gmSEQ.SweepParam)*ScaleT,single(gmSEQ.reference3_2),'-.r','LineWidth', 0.5)
end

if gmSEQ.Ref
    plot(handles.axes2, single(gmSEQ.SweepParam)*ScaleT,single(gmSEQ.signal_3),'-k','LineWidth', 0.5)
    plot(handles.axes2, single(gmSEQ.SweepParam)*ScaleT,single(gmSEQ.reference_3),'--k','LineWidth', 0.5)
    plot(handles.axes2, single(gmSEQ.SweepParam)*ScaleT,single(gmSEQ.reference2_3),':k','LineWidth', 1)
    plot(handles.axes2, single(gmSEQ.SweepParam)*ScaleT,single(gmSEQ.reference3_3),'-.k','LineWidth', 0.5)   
end


grid on;
set(handles.axes2,'FontSize',8);
ylabel(handles.axes2, 'Fluorescence counts');
xlabel(handles.axes2, ScaleStr);
xlim(handles.axes2, [gmSEQ.SweepParam(1)*ScaleT gmSEQ.SweepParam(gmSEQ.NSweepParam)*ScaleT]);
hold(handles.axes2, 'off')

if gmSEQ.Alternate
    data=2*(gmSEQ.signal(~isnan(gmSEQ.signal))-gmSEQ.reference2(~isnan(gmSEQ.reference2)))./(gmSEQ.reference(~isnan(gmSEQ.reference))+gmSEQ.reference3(~isnan(gmSEQ.reference3)));
    data_2=2*(gmSEQ.signal_2(~isnan(gmSEQ.signal_2))-gmSEQ.reference2_2(~isnan(gmSEQ.reference2_2)))./(gmSEQ.reference_2(~isnan(gmSEQ.reference_2))+gmSEQ.reference3_2(~isnan(gmSEQ.reference3_2)));
    if gmSEQ.Ref
        data_3=2*(gmSEQ.signal_3(~isnan(gmSEQ.signal_3))-gmSEQ.reference2_3(~isnan(gmSEQ.reference2_3)))./(gmSEQ.reference_3(~isnan(gmSEQ.reference_3))+gmSEQ.reference3_3(~isnan(gmSEQ.reference3_3)));
    end
    
    plot(handles.axes3, gmSEQ.SweepParam(1:length(data)).*ScaleT,data,'-b')
    hold(handles.axes3, 'on')
    plot(handles.axes3, gmSEQ.SweepParam(1:length(data_2)).*ScaleT,data_2,'-r')
    if gmSEQ.Ref
        plot(handles.axes3, gmSEQ.SweepParam(1:length(data_3)).*ScaleT,data_3,'-k')
    end
    grid on;
    set(handles.axes3,'FontSize',8);
    ylabel(handles.axes3, 'Fluorescence contrast');
    xlabel(handles.axes3, ScaleStr);
    xlim(handles.axes3, [gmSEQ.SweepParam(1)*ScaleT gmSEQ.SweepParam(gmSEQ.NSweepParam)*ScaleT]);
    hold(handles.axes3, 'off')
else
    
    if ~isfield(gmSEQ,'bLiO')&&gmSEQ.ctrN~=1
        %axes(handles.axes3);% cla;
        data_err = zeros(1, size(gmSEQ.signal(~isnan(gmSEQ.signal)),1));
        if gmSEQ.ctrN==3
            if strcmp(gmSEQ.name,'T1JC')
                data=(gmSEQ.signal(~isnan(gmSEQ.signal))-gmSEQ.reference(~isnan(gmSEQ.reference)))./(gmSEQ.reference2(~isnan(gmSEQ.reference2)));
            else
                data=(gmSEQ.signal(~isnan(gmSEQ.signal))-gmSEQ.reference2(~isnan(gmSEQ.reference2)))./(gmSEQ.reference(~isnan(gmSEQ.reference))-gmSEQ.reference2(~isnan(gmSEQ.reference2)));
            end
        elseif gmSEQ.ctrN==2
            % data=gmSEQ.signal(~isnan(gmSEQ.signal))./gmSEQ.reference(~isnan(gmSEQ.reference));
            sig = gmSEQ.reference(~isnan(gmSEQ.reference));
            ref = gmSEQ.signal(~isnan(gmSEQ.signal));
            data = sig./ref;
            ref_err = 1./sqrt(gmSEQ.iAverage * ref); % Relative error of reference
            sig_err = 1./sqrt(gmSEQ.iAverage * sig); % Relative error of signal
            rel_err = sqrt(ref_err.^2 + sig_err.^2);
            data_err = rel_err .* data;
        elseif gmSEQ.ctrN==4
            if strcmp(gmSEQ.name,'Test_NV_Polarization') || strcmp(gmSEQ.name,'Special Cooling') || strcmp(gmSEQ.name,'Special Cooling_2') || strcmp(gmSEQ.name,'Special Cooling_P1_2_DurMeas')
                data = (gmSEQ.signal(~isnan(gmSEQ.signal))-gmSEQ.reference2(~isnan(gmSEQ.reference2)))./(gmSEQ.reference(~isnan(gmSEQ.reference))+gmSEQ.reference3(~isnan(gmSEQ.reference3)))*2;
            elseif strcmp(gmSEQ.name,'CtrDur') && gmSEQ.meas == "SPCM"
                data = -(gmSEQ.reference(~isnan(gmSEQ.reference))-gmSEQ.reference3(~isnan(gmSEQ.reference3)))./sqrt((gmSEQ.signal(~isnan(gmSEQ.signal))+gmSEQ.reference2(~isnan(gmSEQ.reference2))/2));
                data_err = data .* 0;
            else
                % data = (gmSEQ.reference(~isnan(gmSEQ.reference))-gmSEQ.reference3(~isnan(gmSEQ.reference3)))./(gmSEQ.signal(~isnan(gmSEQ.signal))+gmSEQ.reference2(~isnan(gmSEQ.reference2)))*2;
                ref_B = gmSEQ.signal(~isnan(gmSEQ.signal));
                ref_D = gmSEQ.reference2(~isnan(gmSEQ.reference2));
                sig_B = gmSEQ.reference(~isnan(gmSEQ.reference));
                sig_D = gmSEQ.reference3(~isnan(gmSEQ.reference3));
                data = 2*(sig_B - sig_D)./(ref_B + ref_D);
                ref_B_err = 1./sqrt(gmSEQ.iAverage * ref_B); % Relative error of bright reference
                ref_D_err = 1./sqrt(gmSEQ.iAverage * ref_D); % Relative error of dark reference
                sig_B_err = 1./sqrt(gmSEQ.iAverage * sig_B); % Relative error of bright signal
                sig_D_err = 1./sqrt(gmSEQ.iAverage * sig_D); % Relative error of dark signal
                ref_err = sqrt((ref_B_err .* ref_B).^2 + (ref_D_err .* ref_D).^2)./(ref_B + ref_D);
                sig_err = sqrt((sig_B_err .* sig_B).^2 + (sig_D_err .* sig_D).^2)./(sig_B - sig_D);
                rel_err = sqrt(ref_err.^2 + sig_err.^2);
                data_err = rel_err .* data;
            end
        end
        
        % plot(handles.axes3, gmSEQ.SweepParam(1:length(data)).*ScaleT,data,'-g')
        errorbar(handles.axes3, gmSEQ.SweepParam(1:length(data)).*ScaleT, data, data_err,'-g')

        
        grid on;
        set(handles.axes3,'FontSize',8);
        ylabel(handles.axes3, 'Fluorescence contrast');
        xlabel(handles.axes3, ScaleStr);
        xlim(handles.axes3, [gmSEQ.SweepParam(1)*ScaleT gmSEQ.SweepParam(gmSEQ.NSweepParam)*ScaleT]);
    end
end

function PlotData_SweepDelta(handles)
global gmSEQ ScaleT ScaleStr SwpInd1 SwpInd2 DataLen
 
%axes(handles.axes2); %cla;
plot(handles.axes2, single(gmSEQ.SweepParam)*ScaleT,single(gmSEQ.TotalSig(2*DataLen*(SwpInd1-1)+(SwpInd2-1)*DataLen+1,:)),'-b','LineWidth', 0.5)
hold(handles.axes2, 'on')
plot(handles.axes2, single(gmSEQ.SweepParam)*ScaleT,single(gmSEQ.TotalSig(2*DataLen*(SwpInd1-1)+(SwpInd2-1)*DataLen+2,:)),'--b','LineWidth', 0.5)
plot(handles.axes2, single(gmSEQ.SweepParam)*ScaleT,single(gmSEQ.TotalSig(2*DataLen*(SwpInd1-1)+(SwpInd2-1)*DataLen+3,:)),':b','LineWidth', 1)
plot(handles.axes2, single(gmSEQ.SweepParam)*ScaleT,single(gmSEQ.TotalSig(2*DataLen*(SwpInd1-1)+(SwpInd2-1)*DataLen+4,:)),'-.b','LineWidth', 0.5)


plot(handles.axes2, single(gmSEQ.SweepParam)*ScaleT,single(gmSEQ.TotalSig(2*DataLen*(SwpInd1-1)+(SwpInd2-1)*DataLen+5,:)),'-r','LineWidth',0.5)
plot(handles.axes2, single(gmSEQ.SweepParam)*ScaleT,single(gmSEQ.TotalSig(2*DataLen*(SwpInd1-1)+(SwpInd2-1)*DataLen+6,:)),'--r','LineWidth',0.5)
plot(handles.axes2, single(gmSEQ.SweepParam)*ScaleT,single(gmSEQ.TotalSig(2*DataLen*(SwpInd1-1)+(SwpInd2-1)*DataLen+7,:)),':r','LineWidth',1)
plot(handles.axes2, single(gmSEQ.SweepParam)*ScaleT,single(gmSEQ.TotalSig(2*DataLen*(SwpInd1-1)+(SwpInd2-1)*DataLen+8,:)),'-.r','LineWidth',0.5)

if gmSEQ.Ref
    plot(handles.axes2, single(gmSEQ.SweepParam)*ScaleT,single(gmSEQ.TotalSig(2*DataLen*(SwpInd1-1)+(SwpInd2-1)*DataLen+9,:)),'-k','LineWidth',0.5)
    plot(handles.axes2, single(gmSEQ.SweepParam)*ScaleT,single(gmSEQ.TotalSig(2*DataLen*(SwpInd1-1)+(SwpInd2-1)*DataLen+10,:)),'--k','LineWidth',0.5)
    plot(handles.axes2, single(gmSEQ.SweepParam)*ScaleT,single(gmSEQ.TotalSig(2*DataLen*(SwpInd1-1)+(SwpInd2-1)*DataLen+11,:)),':k','LineWidth',1)
    plot(handles.axes2, single(gmSEQ.SweepParam)*ScaleT,single(gmSEQ.TotalSig(2*DataLen*(SwpInd1-1)+(SwpInd2-1)*DataLen+12,:)),'-.k','LineWidth',0.5)
end

grid on;
set(handles.axes2,'FontSize',8);
ylabel(handles.axes2, 'Fluorescence counts');
xlabel(handles.axes2, ScaleStr);
xlim(handles.axes2, [gmSEQ.SweepParam(1)*ScaleT gmSEQ.SweepParam(gmSEQ.NSweepParam)*ScaleT]);
hold(handles.axes2, 'off')

data=2*(gmSEQ.TotalSig(2*DataLen*(SwpInd1-1)+(SwpInd2-1)*DataLen+1,~isnan(gmSEQ.TotalSig(2*DataLen*(SwpInd1-1)+(SwpInd2-1)*DataLen+1,:)))-gmSEQ.TotalSig(2*DataLen*(SwpInd1-1)+(SwpInd2-1)*DataLen+3,~isnan(gmSEQ.TotalSig(2*DataLen*(SwpInd1-1)+(SwpInd2-1)*DataLen+3,:))))./(gmSEQ.TotalSig(2*DataLen*(SwpInd1-1)+(SwpInd2-1)*DataLen+2,~isnan(gmSEQ.TotalSig(2*DataLen*(SwpInd1-1)+(SwpInd2-1)*DataLen+2,:)))+gmSEQ.TotalSig(2*DataLen*(SwpInd1-1)+(SwpInd2-1)*DataLen+4,~isnan(gmSEQ.TotalSig(2*DataLen*(SwpInd1-1)+(SwpInd2-1)*DataLen+4,:))));
data_2=2*(gmSEQ.TotalSig(2*DataLen*(SwpInd1-1)+(SwpInd2-1)*DataLen+5,~isnan(gmSEQ.TotalSig(2*DataLen*(SwpInd1-1)+(SwpInd2-1)*DataLen+5,:)))-gmSEQ.TotalSig(2*DataLen*(SwpInd1-1)+(SwpInd2-1)*DataLen+7,~isnan(gmSEQ.TotalSig(2*DataLen*(SwpInd1-1)+(SwpInd2-1)*DataLen+7,:))))./(gmSEQ.TotalSig(2*DataLen*(SwpInd1-1)+(SwpInd2-1)*DataLen+6,~isnan(gmSEQ.TotalSig(2*DataLen*(SwpInd1-1)+(SwpInd2-1)*DataLen+6,:)))+gmSEQ.TotalSig(2*DataLen*(SwpInd1-1)+(SwpInd2-1)*DataLen+8,~isnan(gmSEQ.TotalSig(2*DataLen*(SwpInd1-1)+(SwpInd2-1)*DataLen+8,:))));
if gmSEQ.Ref
    data_3=2*(gmSEQ.TotalSig(2*DataLen*(SwpInd1-1)+(SwpInd2-1)*DataLen+9,~isnan(gmSEQ.TotalSig(2*DataLen*(SwpInd1-1)+(SwpInd2-1)*DataLen+9,:)))-gmSEQ.TotalSig(2*DataLen*(SwpInd1-1)+(SwpInd2-1)*DataLen+11,~isnan(gmSEQ.TotalSig(2*DataLen*(SwpInd1-1)+(SwpInd2-1)*DataLen+11,:))))./(gmSEQ.TotalSig(2*DataLen*(SwpInd1-1)+(SwpInd2-1)*DataLen+10,~isnan(gmSEQ.TotalSig(2*DataLen*(SwpInd1-1)+(SwpInd2-1)*DataLen+10,:)))+gmSEQ.TotalSig(2*DataLen*(SwpInd1-1)+(SwpInd2-1)*DataLen+12,~isnan(gmSEQ.TotalSig(2*DataLen*(SwpInd1-1)+(SwpInd2-1)*DataLen+12,:))));
end

plot(handles.axes3, gmSEQ.SweepParam(1:length(data)).*ScaleT,data,'-b')
hold(handles.axes3, 'on')
plot(handles.axes3, gmSEQ.SweepParam(1:length(data_2)).*ScaleT,data_2,'-r')
if gmSEQ.Ref
    plot(handles.axes3, gmSEQ.SweepParam(1:length(data_3)).*ScaleT,data_3,'-k')
end

grid on;
set(handles.axes3,'FontSize',8);
ylabel(handles.axes3, 'Fluorescence contrast');
xlabel(handles.axes3, ScaleStr);
xlim(handles.axes3, [gmSEQ.SweepParam(1)*ScaleT gmSEQ.SweepParam(gmSEQ.NSweepParam)*ScaleT]);
hold(handles.axes3, 'off')
    
function [ValidCMD] = ValidateCMD(CMD,ClockTime)
% checks the CMD structure for erroneously short instruction delays due to
% rounding errors in building the pulse sequence via matlab
a = 1;

for k=1:size(CMD,1)
    if CMD{k,4} > 1 %1 ns is the minimum time
        
        if CMD{k,4} < (1e9*5*ClockTime) % if we find a short delay, we must implement it
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
        if strcmp(CMD{k,2},'LONG_DELAY') && CMD{k,3} == 1
            CMD{k,2} = 'CONTINUE';
            CMD{k,3} = 0;
        end
        
        % Update the ValidCMD with this CMD
        for kk=1:size(CMD,2)
            ValidCMD{a,kk} = CMD{k,kk};
        end
        a = a+1;
    end
end

function Load_PB_Sequence()

global gmSEQ

ClockTime = 1/500e6;


CMD = ValidateCMD(gmSEQ,ClockTime);


s = CMD2PBI(CMD);
Ncmd = size(CMD,1);

PBesrInit(); %initialize PBesr

% sets the clock frequency. for PBESR-PRO-400, it's 400MHz
% for PBESR-PRO-333, it's 333.3MHz
PBesrSetClock(500);

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
    if PBstatus < 0
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



function StartCounters(task)
DAQmxStartTask(task);
%     DAQmxStartTask(reference(1));
%     if gmSEQ.bCtr2
%         DAQmxStartTask(reference(2));
%     end

% function [sigDatum, refDatum] = ReadCounters(signal,reference)
% global gmSEQ
%
%     refDatum(1)=DAQmxFunctionPool('ReadCounterScalar',reference(1));
%     if gmSEQ.bCtr2
%         refDatum(2)=DAQmxFunctionPool('ReadCounterScalar',reference(2));
%     end


 
%     sigDatum=DAQmxFunctionPool('ReadCounterScalar',signal);

function [status,A] = ReadCountersN(task,samps,timeout)
global gmSEQ

if strcmp(gmSEQ.meas,'SPCM')
    [status, A]= DAQmxReadCounterU32(task, samps, timeout, zeros(1,samps), samps, libpointer('int32Ptr',0) );
elseif strcmp(gmSEQ.meas,'APD')
    [status, A] = DAQmxFunctionPool('ReadAnalogVoltage',task, samps, timeout);
end
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


function [sigDatum, refDatum] = ProcessData(RawData)
global gmSEQ gSG
if strcmp(gmSEQ.meas,'SPCM')
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
        RawData1=[diff(RawData)];
        sigDatum=sum(RawData1(1:gmSEQ.ctrN:end));
        if gmSEQ.ctrN>1
            refDatum(1,:)=sum(RawData1(2:gmSEQ.ctrN:end));
            if gmSEQ.ctrN>2
                refDatum(2,:)=sum(RawData1(3:gmSEQ.ctrN:end));
                if gmSEQ.ctrN>3
                    refDatum(3,:)=sum(RawData1(4:gmSEQ.ctrN:end));
                else
                    refDatum(3)=NaN;
                end
            else
                refDatum(2)=NaN;
            end
        else
            refDatum(1)=NaN;
            refDatum(2)=NaN;
            refDatum(3)=NaN;
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
        sigDatum=sum(RawData(1:gmSEQ.ctrN:end));
        if gmSEQ.ctrN>1
            refDatum(1,:)=sum(RawData(2:gmSEQ.ctrN:end));
            if gmSEQ.ctrN>2
                refDatum(2,:)=sum(RawData(3:gmSEQ.ctrN:end));
                if gmSEQ.ctrN>3
                    refDatum(3,:)=sum(RawData(4:gmSEQ.ctrN:end));
                else
                    refDatum(3)=NaN;
                end
            else
                refDatum(2)=NaN;
            end
        else
            refDatum(1)=NaN;
            refDatum(2)=NaN;
            refDatum(3)=NaN;
        end
    end
    
end

function CreateCaliLog(hObject, eventdata, handles)
global gCaliLog gTrackLog gmSEQ
if ~gmSEQ.bTrack
    return
end
now = clock;
date = [num2str(now(1)),'-',num2str(now(2)),'-',num2str(round(now(3)))];
fullPath=fullfile('C:\Data\',date,'\');
if ~exist(fullPath,'dir')
    mkdir(fullPath);
end

if gmSEQ.bCali
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
    
    PBFunctionPool('PBON',2^SequencePool('PBDictionary','AOM'));
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
        PBFunctionPool('PBON',2^SequencePool('PBDictionary','AOM'));
        % ImageFunctionPool('UpdateVoltage',0, 0, handles_ImageNVC);
        ImageFunctionPool('TrackImageCorr',0, 0, handles_ImageNVC);
        ImageFunctionPool('TrackZ', 0, 0, handles_ImageNVC);
        % ImageFunctionPool('TrackImageCorr',0, 0, handles_ImageNVC);
        refCounts = currentCounts;
        
        fid = fopen(string(gTrackLog.final),'at'); % a means add data, w means new data
        fprintf(fid,'%s', datestr(datetime(clock)));
        fprintf(fid,' %.4f %.4f %3.1f\n', [gScan.FixVx, gScan.FixVy, gScan.FixVz]);
        fclose(fid);
        
        pause(30); % z postion relaxation
end



function CreateSavePath_Ave()
global gSaveDataAve gmSEQ
now = clock;
date = [num2str(now(1)),'-',num2str(now(2)),'-',num2str(round(now(3)))];
fullPath=fullfile('C:\Data\',date,'\');
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
