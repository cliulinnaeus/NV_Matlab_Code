function RunSequence(what, hObject, eventdata, handles)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%% Written by Jeronimo Maze, July 2007 %%%%%%%%%%%%%%%%%%
%%%%%%%%%% Harvard University, Cambridge, USA  %%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

global gbRunGo;
global gTimeStep;
gTimeStep = 2e-9; %500 MHz

switch what
    case 'Run'
        RunRun(hObject, eventdata, handles);
    case 'Stop'
        gbRunGo = false;
end


function RunRun(hObject, eventdata, handles)
global gExp gSweepSEQ bPBGo gSEQ gSG gbRunGo gDATA gSweepOther;

%% update gExp global with GUI values at start of run
UpdateGExp(hObject,eventdata,handles);

%% TrackingThreshold
if isfield(handles,'TrackingThreshold')
    TrackingThreshold = handles.TrackingThreshold;
else,
    TrackingThreshold = .9;
end
%% Record Timestamp of Experiment Start as unix time integer
gExp.StartDateTime = now();

gbRunGo = true;
planSweep = PlanSweep(hObject, eventdata, handles); %Create Sweep Vector,NTimes, Counter
DATA = InitializeData(planSweep,hObject, eventdata, handles); %Initialize Data,plot
%return
if planSweep.bTracking
    
    % The first time through, initiate Tracking
    PBFunctionPool('PBON',2^5+2^4); %Turn On Green
    TrackCenter(1);
    
    SampFreq = 1000;
    Samples= 500;
    %Counts = DAQmxFunctionPool('GetCounts',SampFreq,Samples);

    IniCounts = DAQmxFunctionPool('GetCounts',SampFreq,Samples);
    IniCounts = IniCounts*SampFreq;
    PBFunctionPool('PBON',0); %Turn Off Green
    
    % update GUI of counts
    set(handles.refCountsText,'String',IniCounts);
    
    % record the Initial Counts into gExp
    gExp.InitialCounts = IniCounts;
else
    gExp.InitialCounts = 0; 
end

gSG.iC=1;
% get the total number of elements in the two Dimensions
TotalLoopElements = length(planSweep.Loop(1).IndexV)*...
    length(planSweep.Loop(2).IndexV);

EstimatedTime = planSweep.Average * gSEQ.Samples * GetLengthSEQ2 * ...
    gSEQ.NTimes * TotalLoopElements / 3600;
Str = sprintf('Estimated Time : %.1f Hours',EstimatedTime);
set(handles.EstimatedTime,'String',Str);

% clear the progress bar axes
cla(handles.axes4);
% IndexRun keeps track of the single run index
planSweep.IndexRun = 0;
for ave = 1:planSweep.Average
    %update the average number on the gui
    UpdateAverageIndicator(ave,planSweep.Average,handles, EstimatedTime);
    planSweep.IndexAve = ave;
    %Loop
    for sl = planSweep.Loop(2).IndexV
        planSweep.Loop(2).Index = sl;
        for fl = planSweep.Loop(1).IndexV
            planSweep.Loop(1).Index = fl;
            PrepareSEQandSG(planSweep,hObject, eventdata, handles);
            %return
            planSweep.IndexRun = planSweep.IndexRun + 1; %Index needed for Fourier data srtucture
            DATA = RunExperiment(DATA,planSweep,hObject, eventdata, handles);
            PlotDATA(planSweep,DATA,handles);
            %update progress bar
            UpdateProgressBar(sl*fl,TotalLoopElements,handles);
            
            if planSweep.bTracking
                PBFunctionPool('PBON',2^5+2^4); %Turn On green
                Counts = DAQmxFunctionPool('GetCounts',SampFreq,Samples);
                Counts = Counts*SampFreq;
                % update GUI of counts
                set(handles.refCountsText,'String',Counts);
                if Counts < TrackingThreshold*IniCounts
                    TrackCenter(1);
                end
                PBFunctionPool('PBON',0); %Turn OffG reen
            end
            drawnow;
            if ~gbRunGo break; end
        end
        if ~gbRunGo break; end
    end
    if ~gbRunGo break; end
    
    % added by jhodges, 06 March 2008
    % Save the Data at each loop in case Matlab crashes
    TempData = CleanUpData(DATA,planSweep,hObject,eventdata,handles);
    BackupFile = 'C:\MATLAB_Code\Data\TempDataBackup\Temp.mat';
    TemporarySave(TempData,BackupFile);
end %End of average loop

ClearCounters(planSweep);
%DAQmxClearTask(planSweep.hCounter);
DrawSequence(gSEQ, hObject, eventdata, handles);

% clean up the raw data structure
DATA = CleanUpData(DATA,planSweep,hObject,eventdata,handles);

gDATA = DATA;


function planSweep = PlanSweep(hObject, eventdata, handles)
global gSweepSEQ gSEQ gSG gSweepOther;

planSweep = [];
%Fourier parameters
planSweep.bFourierDataStructure = get(handles.bFourierDataStructure,'Value');
planSweep.NFourierRuns = eval(get(handles.NFourierRuns,'String'));
planSweep.bPlotFourier = get(handles.bPlotFourier,'Value');
%Whether or not using two counters, Check if PB6 is among the channels
if IsChannelInSEQ(gSEQ,6)
    planSweep.bTwoCounters = true;
else
    planSweep.bTwoCounters = false;
end
%Whether or not plot current vector
planSweep.bPlotCV = get(handles.bPlotCV,'Value');
%Averaging variables
planSweep.bAverage = get(handles.bAverage,'Value');
if planSweep.bAverage 
    planSweep.Average = eval(get(handles.Average,'String'));
else
    planSweep.Average = 1;
end

gSEQ.Samples = eval(get(handles.Samples,'String'));
bRepeat = get(handles.bRepeat,'Value');
if bRepeat
    gSEQ.NTimes = eval(get(handles.RepeatNTimes,'String'));
else
    gSEQ.NTimes = 1;
end
bSweepSG = get(handles.bSweepSG,'Value');
bSweepSEQ = get(handles.bSweepSEQ,'Value');
bSweepOther = get(handles.cbSweepOther,'Value');

planSweep.bTracking = get(handles.bTracking,'Value');
planSweep.bSweepWithPB = false;
planSweep.bSweepCPB = false;

for loop=1:2
    planSweep.Loop(loop).Vector = 1;
    planSweep.Loop(loop).IndexV = 1;
    planSweep.Loop(loop).Index = 1;
    planSweep.Loop(loop).What = '';
    planSweep.Loop(loop).Dim = [];
    planSweep.Loop(loop).bSweepWithPB = 0;
end
%Priority SEQ
loop = 0;
dimPlot = 0;
if bSweepSEQ
    disp('Sweep Sequence Activated');
    for dim=1:numel(gSweepSEQ.DIM)
        if gSweepSEQ.DIM(dim).bEnable
            loop = loop + 1;
            dimPlot = dimPlot + 1;
            planSweep.Loop(loop).Vector = gSweepSEQ.DIM(dim).From:(gSweepSEQ.DIM(dim).To-gSweepSEQ.DIM(dim).From)/(gSweepSEQ.DIM(dim).NPoints-1):gSweepSEQ.DIM(dim).To;
            planSweep.Loop(loop).IndexV = 1:gSweepSEQ.DIM(dim).NPoints;
            planSweep.Loop(loop).Index = 1;
            planSweep.Loop(loop).What = 'SEQ';
            planSweep.Loop(loop).Dim = dim;
        end
    end
end


if bSweepSG
    gSG
    if gSG.bSweepC              %Sweep Carrier
        disp('Sweep SG Carrier');
        loop = loop + 1;
        dimPlot = dimPlot + 1;
        planSweep.Loop(loop).Vector = gSG.minCarrier:(gSG.maxCarrier-gSG.minCarrier)/(gSG.NCarrier-1):gSG.maxCarrier;
        planSweep.Loop(loop).IndexV = 1:gSG.NCarrier;
        planSweep.Loop(loop).Index = 1;
        planSweep.Loop(loop).What = 'SG_Carrier';
        planSweep.Loop(loop).Dim = dimPlot;
    elseif gSG.bSweepCPB        %SweepCarrier with Pulse Blaster
        disp('Sweep SG Carrier with Pulse Blaster');
        %loop = loop + 1; %loop should not be increased when sweeping with
        %pulseblaster
        %dimPlot = dimPlot + 1;
        %planSweep.bSweepWithPB = true;
        %planSweep.bSweepCPB = true;
        %planSweep.PBVector = gSG.minCarrier:(gSG.maxCarrier-gSG.minCarrier)/(gSG.NCarrier-1):gSG.maxCarrier;
        
        loop = loop + 1;
        dimPlot = dimPlot + 1;
        planSweep.Loop(loop).bSweepWithPB = 1;
        planSweep.Loop(loop).Vector = gSG.minCarrier:(gSG.maxCarrier-gSG.minCarrier)/(gSG.NCarrier-1):gSG.maxCarrier;
        planSweep.Loop(loop).IndexV = 1;
        planSweep.Loop(loop).Index = 1;
        planSweep.Loop(loop).What = 'SG_Carrier_PB';
        planSweep.Loop(loop).Dim = dimPlot;

    end
    if gSG.bSweepS              %Sweep Signal
        loop = loop + 1;
        dimPlot = dimPlot + 1;
        planSweep.Loop(loop).Vector = gSG.minSignal:(gSG.maxSignal-gSG.minSignal)/(gSG.NSignal-1):gSG.maxSignal;
        planSweep.Loop(loop).IndexV = 1:gSG.NSignal;
        planSweep.Loop(loop).Index = 1;
        planSweep.Loop(loop).What = 'SG_Signal';
        planSweep.Loop(loop).Dim = dimPlot;
    end
    if gSG.bSweepP              %Sweep Power
        loop = loop + 1;
        dimPlot = dimPlot + 1;
        planSweep.Loop(loop).Vector = gSG.minPower:(gSG.maxPower-gSG.minPower)/(gSG.NPower-1):gSG.maxPower;
        planSweep.Loop(loop).IndexV = 1:gSG.NPower;
        planSweep.Loop(loop).Index = 1;
        planSweep.Loop(loop).What = 'SG_NPower';
        planSweep.Loop(loop).Dim = dimPlot;
    end
end

% Added 18 January 2008, jhodges
% Adding section for Looping over other parameters besides PulseBlaser, i.e
% GPIB controlled devices
if bSweepOther
    
    disp('Sweep Other Activated');
    %increment the loop counter
    loop = loop + 1;
    dimPlot = dimPlot + 1;

    % Get the length of the loops to sweep
    planSweep.Loop(loop).Vector = gSweepOther.TotalVector;
    planSweep.Loop(loop).IndexV = [1:1:gSweepOther.TotalLength];
    planSweep.Loop(loop).Index = 1;
    planSweep.Loop(loop).What = 'Other';
    planSweep.Loop(loop).Phase = gSweepOther.Phase;
    planSweep.Loop(loop).Dim = dimPlot;
   
end;

planSweep.Dim = loop;
%Set counter
%and determine the number of samples to read before calling it
if planSweep.bTwoCounters
    planSweep.N = GetBufferSize(hObject, eventdata, handles);
    planSweep.N1 = GetBufferSizePB6(hObject, eventdata, handles);
    %disp(['Two Counters: Buffer Size 2: ' num2str(planSweep.N)]);
    planSweep.hCounter0 = SetGatedCounter('Dev1/ctr0','/Dev1/PFI8','/Dev1/PFI9');
    planSweep.hCounter1 = SetGatedCounter('Dev1/ctr1','/Dev1/PFI8','/Dev1/PFI4');
else
    N = GetBufferSize(hObject, eventdata, handles);
    planSweep.N = N;
    %disp(['Buffer Size 2: ' num2str(planSweep.N)]);
    planSweep.hCounter0 = SetGatedCounter('Dev1/ctr0','/Dev1/PFI8','/Dev1/PFI9');
end

global gplanSweep;
gplanSweep = planSweep


function PrepareSEQandSG(planSweep,hObject, eventdata, handles)
global gSweepSEQ gSEQ gSG gmSEQ gSweepOther;

mSEQ = gSEQ;
for loop=1:numel(planSweep.Loop)
    switch planSweep.Loop(loop).What
        case 'SG_Carrier'
            gSG.iC = planSweep.Loop(loop).Index;
            SignalGeneratorMaster('RunCarrier',hObject, eventdata, handles);
        case 'SG_Carrier_PB'
            %disp('SG set to be trigger by PB')
            SignalGeneratorFunctionPool('SweepCarrierExt',hObject, eventdata, handles);
        case 'SG_Signal'
        case 'SG_Power'
        case 'SEQ'
            %disp('Here at PrepareSEQandSG')
            mSEQ = SweepSEQ(mSEQ,planSweep,loop);
            %mSEQ.CHN(2)
        %% jhodges, 20 January 2007
        %% added in case for `Other`
        case 'Other'
            gSweepOther.Index = planSweep.Loop(loop).Index;
            SweepOtherFunctionPool('UpdateDevice',hObject,eventdata,handles);
            pause(.5);
            % commented these two lines out in order to do ENDOR, jhodges,
            % 23Aug2008
            %
            %SweepOtherFunctionPool('SetBurstMode',hObject,eventdata,handles);
            %SweepOtherFunctionPool('SetBurstPhase',hObject,eventdata,handles);
        otherwise
    end
    % jhodges, 13 July 2008
    % Writing a text file to the universal pb program is now depreciated
    %WritePBUnivPulSeq(mSEQ);
end

% store the pulse sequence for the current sweep as a global: gmSEQ
gmSEQ = mSEQ;
DrawSequence(mSEQ, hObject, eventdata, handles);

function DATA = RunExperiment(DATA,planSweep,hObject, eventdata, handles)
global gSEQ gbRunGo gmSEQ test2;

%path = 'C:\Dev-Cpp\Examples\pulseblaster\pbesrpro_devc\';
%file = 'UniversalPulsedESR_V2.exe';
%%%%%%  Get time out    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% jhodges, 13 july 2008
% replaced gSEQ with gmSEQ
R = 1; bPBGo = true; 



while bPBGo & R <= gmSEQ.NTimes
    if planSweep.Loop(1).bSweepWithPB
        %disp('Reseting SG sweep');
        Device('SG',['ABOR ']);
    end

%GEORG, SHOULD NOT NEED TO BE HERE, But added so that the program works!!!    
PBFunctionPool('PBON',0);


    PBFunctionPool('PreprocessPBSequence',gmSEQ);
    status = StartCounter(planSweep);%status = DAQmxStartTask(hCounter);

    % jhodges, 13 july 2008
    % Running PulseBlaster.exe dos command depreciated.
    % Changed to spinapi.dll calls
    %status = dos([path file]);          %Start Pulse Blaster
    
    PBFunctionPool('RunPBSequence');
    
    global gTimeOut
%timeout = 1.2 * gmSEQ.Samples * GetLengthSEQ ;
timeout = gTimeOut;
test2=planSweep.IndexRun;
    [A.Ctr0, sCounter1]=ReadCounterScalar(planSweep.hCounter0);
    DATA.A0(planSweep.IndexRun-((planSweep.IndexAve-1)*gSEQ.Samples))=A.Ctr0;
    A.Ctr0=DATA.A0;
    if planSweep.bTwoCounters
        [A.Ctr1, sCounter2]=ReadCounterScalar(planSweep.hCounter1);
        DATA.A1(planSweep.IndexRun)=A.Ctr1;
        A.Ctr1=DATA.A1;
    end
   % [A,sCounter1,sCounter2] = ReadCounters(planSweep,timeout);
    %[A,sCounter] = ReadCounter(hCounter,planSweep.N,timeout); %uint32
   % StopCounter(planSweep);%DAQmxStopTask(hCounter);
    
    repeatPoint = 2; 
    while (sCounter1<0 | sCounter2<0)& repeatPoint < 2
        [status1, status2] = StartCounter(planSweep);
        %status = dos([path file]);          %Start Pulse Blaster
        PBFunctionPool('RunPBSequence');
        [A,sCounter1II,sCounter2II] = ReadCounters(planSweep,timeout);
        %[A,sCounterII] = ReadCounter(hCounter,planSweep.N,timeout); %uint32
        StopCounter(planSweep);%DAQmxStopTask(hCounter);
        %The following line should be uncommented during normal operation
        if (sCounter1II < 0 | sCounter2II < 0), repeatPoint = 0; end
        repeatPoint = repeatPoint + 1;
        drawnow;
        if ~gbRunGo break; end
    end
    StopCounter(planSweep);
    DATA = ProcessData(DATA,A,R,planSweep,handles);
    R = R + 1;
    drawnow;
    if ~bPBGo, break; end
    if ~gbRunGo break; end
end

%DATA.A

function PlotDATA(planSweep,DATA,handles)
strColor = {'r','g','b','m','c'};
global test;
if planSweep.bPlotFourier
    disp('I cannot be');
    M = mod(planSweep.IndexRun,planSweep.NFourierRuns);
    if M == 0, M = planSweep.NFourierRuns; end

    for ix=1:DATA.NX
        if get(handles.bFourierSignalAxes2,'Value') %plot Signal
            plot(handles.axes2,DATA.FOURIER.Time,DATA.FOURIER.X(ix).Signal);
        else %plot Fourier
            plot(handles.axes2,DATA.FOURIER.Freq,DATA.FOURIER.X(ix).Fourier);
            xlim(handles.axes2,[0.1 1]*max(DATA.FOURIER.Freq));
        end
        if get(handles.bCFourierSignalAxes3,'Value') %plot Signal
            plot(handles.axes3,DATA.FOURIER.Time,DATA.FOURIER.AVE(M).X(ix).Signal);
        else %plot Fourier
            plot(handles.axes3,DATA.FOURIER.Freq,DATA.FOURIER.AVE(M).X(ix).Fourier);
            xlim(handles.axes3,[0.1 1]*max(DATA.FOURIER.Freq));
        end
    end
    return;
end

%if planSweep.bPlotCV
if get(handles.bPlotCV,'Value')
    plot(handles.axes3,1:length(DATA.X(1).CurrentVector),DATA.X(1).CurrentVector,strColor{1});
    hold(handles.axes3,'on');
    for ix=2:DATA.NX
        plot(handles.axes3,1:length(DATA.X(ix).CurrentVector),DATA.X(ix).CurrentVector,strColor{ix});
    end
    hold(handles.axes3,'off');
else
    %Plot something instead of current vector
end

% 9 Oct 2008, jhodges & ljiang
% in case we need to plot more than strColor, repmat
if DATA.NX > 5,
    strColor = repmat(strColor,1,ceil(DATA.NX/5));
end

if planSweep.Dim == 0
    hold(handles.axes2,'on');
    for ix=1:DATA.NX
        %errorbar(handles.axes2,0,DATA.X(ix).xmean(1),DATA.X(ix).xstd(1),'k');
        plot(handles.axes2,0,DATA.X(ix).xmean(1),['.' strColor{ix}]);
    end
    hold(handles.axes2,'off');
elseif planSweep.Dim == 1
    plotv = 1:planSweep.Loop(1).Index;
    if get(handles.bImage,'Value')
        x = planSweep.Loop(1).Vector;
        y = 1;
        z = DATA.X(1).xmean(:,:);
        imagesc(x,y,z,'Parent',handles.axes2);
    else
        cla(handles.axes2);
        reset(handles.axes2);
        hold(handles.axes2,'on');
        for ix=1:DATA.NX
            x = planSweep.Loop(1).Vector;
            y = DATA.X(ix).CurrentVector(1:length(x));
            
            if get(handles.bSweepSG,'Value')
                plot(handles.axes2,x,y,['b-']);
            else
                plot(handles.axes2,x,y,['.' strColor{ix}]);
            end
            %errorbar(x,y2,std2,'.r');
        end
        hold(handles.axes2,'off');
    end
elseif planSweep.Dim == 2
    plotv2 = 1:planSweep.Loop(2).Index;
    if planSweep.Loop(2).Index > 1
        plotv1 = 1:length(planSweep.Loop(1).IndexV);
    else
        plotv1 = 1:planSweep.Loop(1).Index;
    end
    if get(handles.bImage,'Value')
        %y = planSweep.Loop(2).Vector(1:planSweep.Loop(2).Index);
        y = planSweep.Loop(2).Vector;
        if planSweep.Loop(1).bSweepWithPB
            x = planSweep.Loop(1).Vector;
            z1 = DATA.X(1).xmean(:,:);
            %z2 = DATA.X(2).xmean(planSweep.Loop(2).Index,:);
        else
            x = planSweep.Loop(1).Vector(:);
            z1 = DATA.X(1).xmean(:,:);
            %z2 = DATA.X(2).xmean(planSweep.Loop(2).Index,planSweep.Loop(1).Index);
        end
       imagesc(x,y,z1,'Parent',handles.axes2);
    else
        cla(handles.axes2);
        for ix=1:DATA.NX
            hold(handles.axes2,'on');
            for k=1:length(planSweep.Loop(2).Vector)
                x = planSweep.Loop(1).Vector;
                y = planSweep.Loop(2).Vector(k)*ones(size(x));
                z = DATA.X(ix).xmean(k,:);
                color = mod(k,5); if color == 0, color =5; end
                plot3(handles.axes2,x,y,z,['-' strColor{color}]);
            end
            hold(handles.axes2,'off');
        end
        view(handles.axes2,10,10);
    end
elseif  planSweep.Dim == 3
end
test=DATA;
%SweepSignal Generator
%Sweep Sequence

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%  INITIALIZATION OF VARIABLES %%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%
function DATA = InitializeData(planSweep,hObject, eventdata, handles)
global gSEQ;

if planSweep.bSweepWithPB
    N = gSEQ.Samples;
else
    N = gSEQ.NTimes * gSEQ.Samples;
end

chnPB0 = GetChanPBN(0); %Allocate memory for DATA.A0
DATA.NX0 = gSEQ.CHN(chnPB0).NRise;
N0 = N * DATA.NX0;
DATA.A0 = int32(zeros(1,N0));
DATA.NX = DATA.NX0;
if planSweep.bTwoCounters
    chnPB6 = GetChanPBN(6); %Allocate memory for DATA.A1
    DATA.NX1 = gSEQ.CHN(chnPB6).NRise;
    N1 = N * DATA.NX1;
    DATA.A1 = int32(zeros(1,N1));
    DATA.NX = DATA.NX + DATA.NX1;
end
%disp(['Buffer Size: ' num2str(N)]);
for ix=1:DATA.NX
    DATA.X(ix).CurrentVector = zeros(1,N);
    if planSweep.Dim==0
        for iave=1:planSweep.Average
            DATA.AVE(iave).X(ix).xmean = 0.0;
        end
        DATA.X(ix).xmean = 0.0;
        DATA.X(ix).xstd = 0.0;
        DATA.X(ix).xmin = 0.0;
        DATA.X(ix).xmax = 0.0;
        DATA.X(ix).var = 0.0;
    elseif planSweep.Dim==1
        SizeLoop1 = length(planSweep.Loop(1).Vector);
        for iave=1:planSweep.Average
            DATA.AVE(iave).X(ix).xmean = zeros(1,SizeLoop1);
        end
        DATA.X(ix).xmean = zeros(1,SizeLoop1);
        DATA.X(ix).xstd = zeros(1,SizeLoop1);
        DATA.X(ix).xmin = zeros(1,SizeLoop1);
        DATA.X(ix).xmax = zeros(1,SizeLoop1);
        axes(handles.axes2);
        view(0,90);
    elseif planSweep.Dim==2
        SizeLoop1 = length(planSweep.Loop(1).Vector);
        SizeLoop2 = length(planSweep.Loop(2).IndexV);
        for iave=1:planSweep.Average
            DATA.AVE(iave).X(ix).xmean = zeros(SizeLoop2,SizeLoop1);
        end
        DATA.X(ix).xmean = zeros(SizeLoop2,SizeLoop1);
        DATA.X(ix).xstd = zeros(SizeLoop2,SizeLoop1);
        DATA.X(ix).xmin = zeros(SizeLoop2,SizeLoop1);
        DATA.X(ix).xmax = zeros(SizeLoop2,SizeLoop1);
    end
    %Fourier Data structure
    if planSweep.bFourierDataStructure
        DATA.FOURIER.X(ix).Signal = zeros(1,N);
        DATA.FOURIER.X(ix).Fourier = zeros(1,2^(nextpow2(N)-1)); % Next power of 2 from length of y required for FFT
        DATA.FOURIER.bTimeFreq = 0;
        DATA.FOURIER.Time = zeros(1,N);
        DATA.FOURIER.Freq = zeros(1,2^(nextpow2(N)-1)); % Next power of 2 from length of y required for FFT
        for iave=1:planSweep.NFourierRuns
            DATA.FOURIER.AVE(iave).X(ix).Signal = zeros(1,N);
            DATA.FOURIER.AVE(iave).X(ix).Fourier = 2^nextpow2(N);
        end
    end
end
axes(handles.axes3);    cla;
axes(handles.axes2);    cla;

function DATA = ProcessData(DATA,A,R,planSweep,handles)
global gSEQ gbRunGo;
%R repitition number
NB0 = length(A.Ctr0);
if planSweep.bTwoCounters
    NB1 = length(A.Ctr1);
end
%bSweepWithPB = planSweep.bSweepWithPB

if planSweep.bSweepWithPB
    disp('One')
    DATA.A0(1:NB0) = DATA.A0(1:NB0) + A.Ctr0;
    axes(handles.axes3);    plot(A.Ctr0);
    axes(handles.axes2);    plot(planSweep.PBVector,DATA.A0);
else
    %disp('Two')
   % DATA.A0(NB0*(R-1)+1:NB0*R) = A.Ctr0;
   
    if planSweep.bTwoCounters
      %  DATA.A1(NB1*(R-1)+1:NB1*R) = A.Ctr1;
    end
end
drawnow;
%DATA.A(NB*(R-1)+1:NB*R) = DATA.A(NB*(R-1)+1:NB*R) + A;
if R<gSEQ.NTimes & gbRunGo return; end

N = planSweep.IndexAve;

M = mod(planSweep.IndexRun,planSweep.NFourierRuns);
if M == 0, M = planSweep.NFourierRuns; end

X = DATA.A0;
if planSweep.bTwoCounters
    X1 = DATA.A1;
    X = double([ X; X1 ]);
else
    X = double(X);
end

for ix=1:DATA.NX
    if planSweep.bFourierDataStructure
        if ~DATA.FOURIER.bTimeFreq 
            dTime =GetLengthSEQ; 
            Time = dTime * [1:length(X(ix,:))];
            DATA.FOURIER.Time = Time;
            [Freq,sFFT,MsFFT] = MyFourier(DATA.FOURIER.Time, X(ix,:));             
            DATA.FOURIER.Freq = Freq;
            DATA.FOURIER.bTimeFreq = true;
        else
            [Freq, sFFT,MsFFT] = MyFourier(DATA.FOURIER.Time, X(ix,:));             
        end
        DATA.FOURIER.X(ix).Signal(1,:) = (DATA.FOURIER.X(ix).Signal(1,:)*(M-1) + X(ix,:))/M;
        DATA.FOURIER.X(ix).Fourier(1,:) = (DATA.FOURIER.X(ix).Fourier(1,:)*(M-1) + MsFFT)/M;
        DATA.FOURIER.AVE(M).X(ix).Signal = X(ix,:);
        DATA.FOURIER.AVE(M).X(ix).Fourier = MsFFT;
    end
    
    DATA.X(ix).CurrentVector = X(ix,:);
    if planSweep.Dim==0
        %disp('Dimension is ZERO'); %There shouldnt be DIM equal to zero
        DATA.AVE(N).X(ix).xmean = mean(X(ix,:));
        DATA.AVE(N).X(ix).xstd = std(X(ix,:));
        DATA.X(ix).xmean = (DATA.X(ix).xmean*(N-1) + mean(X(ix,:)))/N;
        DATA.X(ix).xstd = (DATA.X(ix).xstd*(N-1) + std(X(ix,:)))/N;
        DATA.X(ix).xmin = (DATA.X(ix).xmin*(N-1) + min(X(ix,:)))/N;
        DATA.X(ix).xmax = (DATA.X(ix).xmax*(N-1) + max(X(ix,:)))/N;
    elseif planSweep.Dim==1
        if planSweep.Loop(1).bSweepWithPB
            %disp('Dim = 1, Dim1 sweep with PB')
            DATA.AVE(N).X(ix).xmean(1,:) = X(ix,:);
            DATA.AVE(N).X(ix).xstd(1,:) = 0*X(ix,:); %Does not make sense to calculate std in with PB sweeping
            DATA.X(ix).xmean(1,:) = (DATA.X(ix).xmean(1,:)*(N-1) + X(ix,:))/N;
            DATA.X(ix).xstd(1,:) = (DATA.X(ix).xstd(1,:)*(N-1) + 0)/N;
            DATA.X(ix).xmin(1,:) = (DATA.X(ix).xmin(1,:)*(N-1) + 0)/N;
            DATA.X(ix).xmax(1,:) = (DATA.X(ix).xmax(1,:)*(N-1) + 0)/N;
        else
            ifl = planSweep.Loop(1).Index;
            DATA.AVE(N).X(ix).xmean(1,ifl) = mean(X(ix,:));
            DATA.AVE(N).X(ix).xstd(1,ifl) = std(X(ix,:));
            DATA.X(ix).xmean(1,ifl) = (DATA.X(ix).xmean(1,ifl)*(N-1) + mean(X(ix,:)))/N;
            DATA.X(ix).xstd(1,ifl) = (DATA.X(ix).xstd(1,ifl)*(N-1) + std(X(ix,:)))/N;
            DATA.X(ix).xmin(1,ifl) = (DATA.X(ix).xmin(1,ifl)*(N-1) + min(X(ix,:)))/N;
            DATA.X(ix).xmax(1,ifl) = (DATA.X(ix).xmax(1,ifl)*(N-1) + max(X(ix,:)))/N;
        end
    elseif planSweep.Dim==2
        if planSweep.Loop(1).bSweepWithPB
            %disp('Dim = 2, Dim1 sweep with PB')
            isl = planSweep.Loop(2).Index;
            DATA.AVE(N).X(ix).xmean(isl,:) = X(ix,:);
            DATA.AVE(N).X(ix).xstd(isl,:) = 0*X(ix,:);
            DATA.X(ix).xmean(isl,:) = (DATA.X(ix).xmean(isl,:)*(N-1) + X(ix,:))/N;
            DATA.X(ix).xstd(isl,:) = (DATA.X(ix).xstd(isl,:)*(N-1) + 0)/N;
            DATA.X(ix).xmin(isl,:) = (DATA.X(ix).xmin(isl,:)*(N-1) + 0)/N;
            DATA.X(ix).xmax(isl,:) = (DATA.X(ix).xmax(isl,:)*(N-1) + 0)/N;
        else
            ifl = planSweep.Loop(1).Index;
            isl = planSweep.Loop(2).Index;
            DATA.AVE(N).X(ix).xmean(isl,ifl) = mean(X(ix,:));
            DATA.AVE(N).X(ix).xstd(isl,ifl) = std(X(ix,:));
            DATA.X(ix).xmean(isl,ifl) = (DATA.X(ix).xmean(isl,ifl)*(N-1) + mean(X(ix,:)))/N;
            DATA.X(ix).xstd(isl,ifl) = (DATA.X(ix).xstd(isl,ifl)*(N-1) + std(X(ix,:)))/N;
            DATA.X(ix).xmin(isl,ifl) = (DATA.X(ix).xmin(isl,ifl)*(N-1) + min(X(ix,:)))/N;
            DATA.X(ix).xmax(isl,ifl) = (DATA.X(ix).xmax(isl,ifl)*(N-1) + max(X(ix,:)))/N;
        end
    end
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
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

DupCount = DAQmxGet(task, 'CI.DupCountPrevent', Device);
DAQmxSet(task, 'CI.DupCountPrevent', Device,1); 
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

function task = SetGatedCounter(counter,src,gate)
% Added by Satcher Hsieh 10/21/2016
[ status, ~, task ] = DAQmxCreateTask([]);

if status
	DAQmxErr(status);
end
DAQmxFunctionPool('SetGatedCounter',task,counter,src,gate)


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function task=SetGatedCountingDEPRECATED(Device)
	% I have no idea what this function was used for. It was never referenced in this function pool. --Satcher
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

status = 	DAQmxCreateCICountEdgesChan(task,'Dev1/ctr0','',...
    DAQmx_Val_Rising,0,DAQmx_Val_CountUp);
DAQmxErr(status);
%disp(['NI: Create Counter       :' num2str(status)]);

status = DAQmxCfgSampClkTiming(task,'/Dev1/PFI9',1000.0,...
    DAQmx_Val_Falling,DAQmx_Val_ContSamps ,1000.0);
DAQmxErr(status);
%disp(['NI: Cofigure the Clk     :' num2str(status)]);

function [readArray,status] = ReadCounter(task,N,timeout)
numSampsPerChan = N;
%readArray = libpointer('int64Ptr',zeros(1,N));
readArray = zeros(1,N);
arraySizeInSamps = N;
sampsPerChanRead = libpointer('int32Ptr',0);

[status, readArray, aux]= DAQmxReadCounterU32(task, numSampsPerChan,...
    timeout, readArray, arraySizeInSamps, sampsPerChanRead );
if status ~= 0

    fprintf('\nN=%.0f Size = (%.0f, %.0f)\n',N,size(readArray));
    DAQmxErr(status);
end
function [data, status] = ReadCounterScalar(task)
% added by Satcher 10/23/2016
[data, status]=DAQmxFunctionPool('ReadCounterScalar',task);

function N = GetBufferSize(hObject, eventdata, handles)
%this function gets the buffer size from PB7
global gSEQ;
chnPB0 = GetChanPBN(0);
gSEQ.CHN(1)
gSEQ.CHN(2)
gSEQ.CHN(3)
gSEQ.CHN(4)
NRise = gSEQ.CHN(chnPB0).NRise;
N = gSEQ.Samples * NRise;

function N = GetBufferSizePB6(hObject, eventdata, handles)
global gSEQ;
chnPB6 = GetChanPBN(6);
NRise = gSEQ.CHN(chnPB6).NRise;
N = gSEQ.Samples * NRise;

function chnPB0 = GetChanPBN(PBN)
global gSEQ;
chnPB0 = [];
for chn = 1:length(gSEQ.CHN)
    if gSEQ.CHN(chn).PBN == 0
        chnPB0 = chn;
    end
end

function mSEQ = SweepSEQ(SEQ,planSweep,loop)
global gSweepSEQ;

mSEQ = SEQ;
dim = planSweep.Loop(loop).Dim;
ValueTDT = planSweep.Loop(loop).Vector(planSweep.Loop(loop).Index);
if gSweepSEQ.DIM(dim).bTDT == 0 %T
    mSEQ = ChangeT(mSEQ,dim,ValueTDT);
elseif gSweepSEQ.DIM(dim).bTDT == 1 %DT
    mSEQ = ChangeDT(mSEQ,dim,ValueTDT);
end
%mSEQ.CHN(2)

function SEQ = ChangeDT(SEQ,dim,DT)
global gSweepSEQ gTimeStep;
%gSweepSEQ.DIM(dim);
Value = DT;  
Value = round(Value/gTimeStep)*gTimeStep;
if gSweepSEQ.DIM(dim).bRiseType %Type (1)
    for chn=1:length(SEQ.CHN)
        for Rise = 1:SEQ.CHN(chn).NRise
            if strcmp(SEQ.CHN(chn).Type{Rise},gSweepSEQ.DIM(dim).Type)
                SEQ = ChangeDT2(SEQ,dim,Value,chn,Rise);
            end
        end
    end
else %Rise (0)
    Rise = gSweepSEQ.DIM(dim).RiseN;
    PBN = gSweepSEQ.DIM(dim).PBN;
    chn = GetCHN(SEQ,PBN);
    SEQ = ChangeDT2(SEQ,dim,Value,chn,Rise);
end

function SEQ = ChangeDT2(SEQ,dim,Value,chn,Rise)
global gSweepSEQ;
bShift = gSweepSEQ.DIM(dim).bShift;
bShiftAll = gSweepSEQ.DIM(dim).bShiftAll;

if gSweepSEQ.DIM(dim).bAdd
    Value = SEQ.CHN(chn).DT(Rise) + Value;
    disp('Add');
end

if bShift
    FromTime = SEQ.CHN(chn).T(Rise) + SEQ.CHN(chn).DT(Rise);
    Shift = Value - SEQ.CHN(chn).DT(Rise);
    T = SEQ.CHN(chn).T;
    T(find(T>=FromTime))=T(find(T>=FromTime)) + Shift;
    SEQ.CHN(chn).T = T;
    SEQ.CHN(chn).DT(Rise) = Value;
elseif bShiftAll
    FromTime = SEQ.CHN(chn).T(Rise) + SEQ.CHN(chn).DT(Rise);
    Shift = Value - SEQ.CHN(chn).DT(Rise);
    SEQ = ShiftEvents(SEQ,Shift,FromTime);
    SEQ.CHN(chn).DT(Rise) = Value;
else
    SEQ.CHN(chn).DT(Rise) = Value;
end

function SEQ = ChangeT(SEQ,dim,TimeOn)
global gSweepSEQ gTimeStep;
Value = TimeOn;  
Value = round(Value/gTimeStep)*gTimeStep;

if gSweepSEQ.DIM(dim).bRiseType %Type (1)
    for chn=1:length(SEQ.CHN)
        for Rise = 1:SEQ.CHN(chn).NRise
            if strcmp(SEQ.CHN(chn).Type{Rise},gSweepSEQ.DIM(dim).Type)
                SEQ = ChangeT2(SEQ,dim,Value,chn,Rise);
            end
        end
    end
else %Rise (0)
    Rise = gSweepSEQ.DIM(dim).RiseN;
    PBN = gSweepSEQ.DIM(dim).PBN;
    chn = GetCHN(SEQ,PBN);
    SEQ = ChangeT2(SEQ,dim,Value,chn,Rise);
end


function SEQ = ChangeT2(SEQ,dim,Value,chn,Rise)
global gSweepSEQ;
bShift = gSweepSEQ.DIM(dim).bShift;
bShiftAll = gSweepSEQ.DIM(dim).bShiftAll;

if gSweepSEQ.DIM(dim).bAdd
    Value = SEQ.CHN(chn).T(Rise) + Value;
    %disp('Add');
end

if bShift
    FromTime = SEQ.CHN(chn).T(Rise);
    Shift = Value - FromTime;
    T = SEQ.CHN(chn).T;
    T(find(T>=FromTime))=T(find(T>=FromTime)) + Shift;
    SEQ.CHN(chn).T = T;
    SEQ.CHN(chn).T(Rise) = Value;
elseif bShiftAll
    FromTime = SEQ.CHN(chn).T(Rise);
    Shift = Value - FromTime;
    SEQ = ShiftEvents(SEQ,Shift,FromTime);
    SEQ.CHN(chn).T(Rise) = Value;
else
    SEQ.CHN(chn).T(Rise) = Value;
end


function SEQ = ShiftEvents(SEQ,Shift,FromTime)
%fprintf('\nInShift Events');
for chn=1:numel(SEQ.CHN)
    T = SEQ.CHN(chn).T;
    T(find(T>=FromTime))=T(find(T>=FromTime)) + Shift;
    SEQ.CHN(chn).T = T;
end

function [bYes,chn]=IsChannelInSEQ(SEQ,PBN)
bYes = 0;
chn = 0;
for ichn=1:numel(SEQ.CHN)
    if SEQ.CHN(ichn).PBN==PBN
        bYes = true;
        chn=ichn;
        return;
    end
end



function chn = GetCHN(SEQ,PBN)
%PBN
for ichn=1:numel(SEQ.CHN)
    if SEQ.CHN(ichn).PBN==PBN
        chn=ichn;
        return;
    end
end

function L = GetLengthSEQ
global gSEQ gmSEQ;
%This function should return a scalar
%Get maximum positive time
LA=0; LB=0;
for chn=1:length(gmSEQ.CHN(:))
    for rise=1:gmSEQ.CHN(chn).NRise
        La = gmSEQ.CHN(chn).T(rise);
        Lb = gmSEQ.CHN(chn).T(rise) + gmSEQ.CHN(chn).DT(rise);
        if Lb>LB
            LB=Lb;
        end
        if La<LA
            LA=La;
        end
    end
end
L = LB - LA;

function L = GetLengthSEQ2
global gSEQ;
%This function should return a scalar
%Get maximum positive time
LA=0; LB=0;
for chn=1:length(gSEQ.CHN(:))
    for rise=1:gSEQ.CHN(chn).NRise
        La = gSEQ.CHN(chn).T(rise);
        Lb = gSEQ.CHN(chn).T(rise) + gSEQ.CHN(chn).DT(rise);
        if Lb>LB
            LB=Lb;
        end
        if La<LA
            LA=La;
        end
    end
end
L = LB - LA;


function [DATA] = CleanUpData(DATA,planSweep,hObject,eventdata,handles)
bSweepSG = get(handles.bSweepSG,'Value');
bSweepSEQ = get(handles.bSweepSEQ,'Value');

%What in the world is this doing here??????? JM 2008 - 08 - 29
%if bSweepSG,
    %disp('Here at cleaning');
    %What in the world is this doing here??????? JM
    %DATA.X.xmean = double(DATA.X.CurrentVector);
%end

% add in planSweep data
for k=1:length(planSweep.Loop),
    DATA.Sweep(k).X = planSweep.Loop(k).Vector;
end

function [] = UpdateAverageIndicator(current,total,handles,EstimatedTime)
set(handles.AvgIndicator,'String',sprintf('(%d/%d)',current,total));
Str = sprintf('Estimated Time : %.1f / %.1f Hours',...
    (total-current+1)/total*EstimatedTime,EstimatedTime);
set(handles.EstimatedTime,'String',Str);

% clear the Progress Bar
cla(handles.axes4);

function [] = UpdateProgressBar(current,total,handles)

% make the handles visible
set(handles.axes4,'Visible','on');
% focus the axes
axes(handles.axes4);
daspect([1 10 1]);
rectangle('Position',[0 0 current/total 1],'FaceColor','r','EdgeColor','r');
xlim([0 1]);
ylim([0 1]);
set(gca,'XTick',[],'YTick',[],'XTickMode','manual','YTickMode','manual',...
        'XColor',[1 1 1],'YColor',[1 1 1]);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%    
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%    Counters Functions   %%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function StopCounter(planSweep)
DAQmxStopTask(planSweep.hCounter0);
if planSweep.bTwoCounters
    DAQmxStopTask(planSweep.hCounter1);
end

function [status1, status2] = StartCounter(planSweep)
status1 = DAQmxStartTask(planSweep.hCounter0);
status2 = 0;
if planSweep.bTwoCounters
    status2 = DAQmxStartTask(planSweep.hCounter1);
end
%disp(['NI: Start Counter        :' num2str(status1)])
%disp(['NI: Start Counter        :' num2str(status2)])

function [A,status1,status2] = ReadCounters(planSweep,timeout)
[auxA0,status1] = ReadCounter(planSweep.hCounter0,planSweep.N,timeout); %uint32
A.Ctr0 = int32(auxA0);
status2 = 0;
if planSweep.bTwoCounters
    [auxA1,status2] = ReadCounter(planSweep.hCounter1,planSweep.N,timeout); %uint32
    A.Ctr1 = int32(auxA1);
end


function ClearCounters(planSweep)
DAQmxClearTask(planSweep.hCounter0);
if planSweep.bTwoCounters
    DAQmxClearTask(planSweep.hCounter1);
end

function [] = UpdateGExp(hObject,eventdata,handles);
global gExp gSEQ gSweepSEQ gSG;
if isempty(gSEQ)
    gExp.SEQPath = '';
    gExp.SEQFile = '';
else
    path = gSEQ.file(1:max(strfind(gSEQ.file,'\')));
    file = gSEQ.file(max(strfind(gSEQ.file,'\'))+1:length(gSEQ.file));
    gExp.SEQPath = path;
    gExp.SEQFile = file;
end

if isempty(gSweepSEQ)
    gExp.SWEEPPath = '';
    gExp.SWEEPFile = '';
else
    gExp.SWEEPPath = gSweepSEQ.path;
    gExp.SWEEPFile = gSweepSEQ.file;
end

if isempty(gSG)
    gExp.SGPath = '';
    gExp.SGFile = '';
else
    gExp.SGPath = gSG.path;
    gExp.SGFile = gSG.filename;
end

%Get Magnetic Field
gExp.Bx = 0;
gExp.By = 0;
gExp.Bz = 0;
%GreenPower
gExp.GreenPower = 0;

gExp.Samples = eval(get(handles.Samples,'String'));
gExp.Average = eval(get(handles.Average,'String'));
gExp.Repeat = eval(get(handles.RepeatNTimes,'String'));
gExp.bRepeat = get(handles.bRepeat,'Value');
gExp.bSweepSEQ = get(handles.bSweepSEQ,'Value');
gExp.bSweepSG = get(handles.bSweepSG,'Value');
gExp.bSweepOther = get(handles.cbSweepOther,'Value');
gExp.bPlotA = get(handles.bPlotCV,'Value');
gExp.bTracking = get(handles.bTracking,'Value');

function [] = TemporarySave(TempData,BackupFile)
global gExp gSweepSEQ gSEQ gSG gDATA gSweepOther;

% convert relevant globals to a bigger structure
BackupExp.MetaData = gExp;
BackupExp.SweepSEQ = gSweepSEQ;
BackupExp.SignalGenerator = gSG;
BackupExp.PulseSequence = gSEQ;
BackupExp.SweepOther = gSweepOther;
BackupExp.gData = gDATA;
BackupExp.TempData = TempData;
%save the data in matlab binary format
save(BackupFile,'BackupExp');

function [freq,sfft,Msfft]=MyFourier(t,signal)
L = length(signal);
NFFT = 2^nextpow2(L); % Next power of 2 from length of y
sfft = fft(signal,NFFT)/L;
dt = max(t)/length(t);
Fs = 1/dt;
freq = Fs/2*linspace(0,1,NFFT/2);
Msfft = 2*abs(sfft(1:NFFT/2));

