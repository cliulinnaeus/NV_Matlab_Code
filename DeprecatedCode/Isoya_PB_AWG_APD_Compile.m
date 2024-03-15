function Isoya_PB_AWG_APD_Compile(hObject, eventdata, handles)

%%%%%%%%%%%%%%%%%%%
%%%%%% INPUT %%%%%%
%%%%%%%%%%%%%%%%%%%
clear global Inputs Readout Measurement Trigger_Seq Compiler_Seq PB_Seq gNrepeat;
clear global gTrackingPoint
clear global gCountsSet
clear global gTrackingTime
global Inputs Readout Measurement Trigger_Seq Compiler_Seq gAWG_calib gNrepeat gBeam;

%% initial compiler setting
if isempty(gAWG_calib)
    error('need to calibrate IQs first')            % check whether AWG values are set
end

Inputs.bSweepwf = get(handles.bSweepwf,'Value');    % if the waveform is swept
Inputs.Ch6_length = 50;                             % for triggering data acqusition of NI DAQ2
Inputs.GreenVolt = [];    
Inputs.bTrackingPoint = gBeam.bTrackingPoint;
% monitor green power during the measurement
plot_seq = get(handles.bPlot,'Value');              % plot pulse sequence
bAPD = get(handles.fAPD,'Value');                   % whether we use single photon APD or PD(Jim's box)

%% define measurement
% Define AWG Measurement Sequence (adjust in Isoya_AWG_Measure )
if Inputs.bSweepwf
%     Measurement = 'Isoya_AWG_Measure_sweep_HH'; 
    
%     Measurement = 'Isoya_AWG_Measure_T1'; 
%     Measurement = 'Isoya_AWG_Measure_sweep_Ramsey'; 
%     Measurement = 'Isoya_AWG_Measure_sweep_DEER'; 
%     Measurement = 'Isoya_AWG_Measure_sweep_Rabi'; 
%     Measurement = 'Isoya_AWG_Measure_sweep_HH_delay'; 
%     Measurement = 'Isoya_AWG_Measure_sweep_HH_power_1to3';

%     Measurement = 'Isoya_AWG_Measure_sweep_HH_power';
%     Measurement = 'Isoya_AWG_Measure_sweep_spinlock'; 
   Measurement = 'Isoya_AWG_Measure_sweep_timecrystal';
%    Measurement = 'Isoya_AWG_Measure_sweep_timecrystal_spin1';
%     Measurement = 'Isoya_AWG_Measure_sweep_dynamical_decoupling'; 
else
    Measurement = 'Isoya_AWG_Measure_Rabi';
%     Measurement = 'Isoya_AWG_Measure_Spinlock';    
    
%     Measurement = 'Isoya_AWG_Measure_ssRabi';
%     Measurement = 'Isoya_AWG_Measure_CPMG';
%     Measurement = 'Isoya_AWG_Measure_DEER';
%     Measurement = 'Isoya_AWG_Measure_Ramsey';
end

%% waittime, green pulse, readout, and reference counter definition

if bAPD==1
	Readout = 'Jim';
else
    Readout = 'DAQ';
end

disp(['we are tracking at ', num2str(gBeam.bTrackingPoint), '%']); % 0-100                 % beam tracking point
if Inputs.bSweepwf                                  
    Inputs.bTrackingInterval = 1;                   % 1 iteration ~ 1 hour
else
    Inputs.bTrackingInterval = 10;                  % 1 iteration ~ a few tens of seconds
end

% important parameters
Inputs.DAQcounterlength = 500;                      % readout length
Inputs.bWaitTime = 1000e3;                           % charge equilibration time
Inputs.GreenPrePulseLen = 100e3;                    % polarization pulse (ns)
Inputs.EndAdd = 3e3;                                % additional time window to locate pi-pulse at the end of sequence
Inputs.gr_ton = 20e3;                               % length of green pulses for readout

Inputs.AddContrast = 0;                             % reference counters located at the end, 0 or N (works only for sweepwf)
Inputs.AddContrastAll = 0;                          % reference counters located everywhere, proportional to nCounts (works only for sweepwf)
Inputs.SweepWait = 0;                               % 0 or 1 (works only for sweepwf)
Inputs.SweepDAQclen = 0;                            % 0 or 1
Inputs.bBrightMeasure = 0;                          % the number of counters under the green (all-in-one seq) %%% please correct plotstring in the below
Inputs.nSweepGreenPol = 0;                          % 0 or 1 (all-in-one seq)
Inputs.bT1chargeComp = 0;                           % 0 or ns
Inputs.bDCconst_long = 0;                           % 0 or ns

if ~Inputs.bSweepwf                                 % for all-in-one seq
    Inputs.bT1chargeComp = Inputs.bWaitTime;
    Inputs.bWaitTime = 0;
    Inputs.AddContrast = 0;
end

%% time evolution for experiment

bCustomVector = 0;                              % if we want to define a custom sweepvector
if bCustomVector
    uT = 200;
    Inputs.sweepvec = [linspace(1*uT,50*uT,50)];
%          Inputs.sweepvec = [0 81e3];
    Inputs.sweepmin = min(Inputs.sweepvec);
    Inputs.sweepmax = max(Inputs.sweepvec);
    Inputs.npoints = length(Inputs.sweepvec);
    Inputs.nCount = 12;
else
    Inputs.sweepmin =1*801; 
    Inputs.sweepmax =150*801; 
    Inputs.npoints = 150;
    Inputs.nCount =4;
end

logsampling_short = 0;                          % if we want to do a log-sampling at short time
logsampling_long = 1;                           % if we want to do a log-sampling at long time 
Inputs.semilogplot = 0;                         % if we want to plot a data in log-x scale

add_vec=0;                                      % if we want to augement the sweepvector 
if add_vec
    t_start = 10e3;
    t_max = 100e3;
    pts = 20;
end

if Inputs.bBrightMeasure                        % if we want to measure counts under green illumination
    Inputs.nCount_all = Inputs.nCount + Inputs.bBrightMeasure;
    Inputs.bBrightTiming = round(linspace(0, 10e3, Inputs.bBrightMeasure));
end

%% how we plot the averaging data
 
if Inputs.nCount == 2
%         Inputs.plotString = 'C1, C2';
    Inputs.plotString = 'C1./C2';
%     Inputs.plotString = 'C1-C2';
%     Inputs.plotString = '(C1-C2)./(C1+C2)';
elseif Inputs.nCount == 3
    Inputs.plotString = 'C1./C3, C2./C3';
%     Inputs.plotString = 'C3-C1, C3-C2';
elseif Inputs.nCount == 4
%           Inputs.plotString = 'C1./C4,C2./C4,C3./C4';
   Inputs.plotString = '(C1-C2),(C3-C4)';
%     Inputs.plotString = 'C1,C2,C3,C4';
elseif Inputs.nCount == 5
    Inputs.plotString = 'C1./C5,C2./C5,C3./C5,C4./C5';
elseif Inputs.nCount == 6    
%     Inputs.plotString = 'C1./C6,C2./C6,C3./C6,C4./C6,C5./C6';
    Inputs.plotString = '(C1-C2),(C3-C4),(C5-C6)';
elseif Inputs.nCount == 7
    Inputs.plotString = 'C1./C7,C2./C7,C3./C7,C4./C7,C5./C7,C6./C7';
elseif Inputs.nCount == 8
    Inputs.plotString = '(C1-C2)+(C4-C3),(C5-C6)+(C8-C7)';
%     Inputs.plotString = 'C1./C8,C2./C8,C3./C8,C4./C8,C5./C8,C6./C8,C7./C8';
elseif Inputs.nCount == 9
    Inputs.plotString = 'C1./C9,C2./C9,C3./C9,C4./C9,C5./C9,C6./C9,C7./C9,C8./C9';
elseif Inputs.nCount == 10
    Inputs.plotString = '(C1-C2),(C3-C4),(C5-C6),(C7-C8),(C9-C10)';
elseif Inputs.nCount == 12
    Inputs.plotString = '(C1-C2)+(C4-C3),(C5-C6)+(C8-C7),(C9-C10)+(C12-C11)';
elseif Inputs.nCount == 14
    Inputs.plotString = '(C1-C2),(C3-C4),(C5-C6),(C7-C8),(C9-C10),(C11-C12),(C13-C14)';
elseif Inputs.nCount == 16
%     Inputs.plotString = '(C1-C3),(C5-C7),(C9-C11),(C15-C13),(C2-C4),(C6-C8),(C10-C12),(C14-C16)';
%     Inputs.plotString = '(C1-C3),(C5-C7),(C9-C11),(C13-C15),(C2-C4),(C6-C8),(C10-C12),(C14-C16)';
    Inputs.plotString = '(C1-C2)+(C4-C3),(C5-C6)+(C8-C7),(C9-C10)+(C12-C11),(C13-C14)+(C16-C15)';
%     Inputs.plotString = '(C1-C3)+(C7-C5),(C2-C4)+(C8-C6),(C9-C11)+(C15-C13),(C10-C12)+(C16-C14),(C17-C19)+(C23-C21),(C18-C20)+(C24-C22),(C25-C27)+(C31-C29),(C26-C28)+(C32-C30)';
elseif Inputs.nCount == 18
    Inputs.plotString = '(C1-C2),(C3-C4),(C5-C6),(C7-C8),(C9-C10),(C11-C12),(C13-C14),(C15-C16),(C17-C18)';
elseif Inputs.nCount == 20
    Inputs.plotString = '(C1-C2)+(C4-C3),(C5-C6)+(C8-C7),(C9-C10)+(C12-C11),(C13-C14)+(C16-C15),(C17-C18)+(C20-C19)';
elseif Inputs.nCount == 22
    Inputs.plotString = '(C1-C2)./(C21-C22),(C3-C4)./(C21-C22),(C5-C6)./(C21-C22),(C7-C8)./(C21-C22),(C9-C10)./(C21-C22),(C11-C12)./(C21-C22),(C13-C14)./(C21-C22),(C15-C16)./(C21-C22),(C17-C18)./(C21-C22),(C19-C20)./(C21-C22)';
elseif Inputs.nCount == 24
    Inputs.plotString = '(C1-C2)+(C4-C3),(C5-C6)+(C8-C7),(C9-C10)+(C12-C11),(C13-C14)+(C16-C15),(C17-C18)+(C20-C19),(C21-C22)+(C24-C23)';
elseif Inputs.nCount == 28
    Inputs.plotString = '(C1-C2)+(C4-C3),(C5-C6)+(C8-C7),(C9-C10)+(C12-C11),(C13-C14)+(C16-C15),(C17-C18)+(C20-C19),(C21-C22)+(C24-C23),(C25-C26)+(C28-C27)';
elseif Inputs.nCount == 32
    Inputs.plotString = '(C1-C3),(C2-C4),(C7-C5),(C6-C8),(C9-C11),(C10-C12),(C15-C13),(C14-C16)';
else
end

if Inputs.bBrightMeasure
    Inputs.plotString = 'C1, C10, C20, C21, C22';
end

%% how we do the data acquisition 
Inputs.SamplingRate = 1;            % AWG sampling rate in GHz (up to 5 GHz)
if Inputs.bSweepwf
    Inputs.time_avrg = 200;         % seconds (amount of time sequence loops)
else
    Inputs.time_avrg = 10;          % seconds (amount of time sequence loops)
end

%% how we generate the sweepvec for plotting the compiled sequence
if plot_seq
    Inputs.npoints = 2;
    if add_vec
        pts = 2;
    end
end

% redefine the sweepvec depending on whether or not we plot the sequence
if ~bCustomVector
    if logsampling_short
        Inputs.sweepvec = round(logspace(log(Inputs.sweepmin)/log(10),log(Inputs.sweepmax)/log(10),Inputs.npoints));
    else
        Inputs.sweepvec = [Inputs.sweepmin : (Inputs.sweepmax-Inputs.sweepmin)/(Inputs.npoints-1) : Inputs.sweepmax];
    end
end

% add more vectors depending on whether or not we want to augement the sequence
if add_vec
    Add_More_Vectors(t_start, t_max, pts, logsampling_long);
end

% finalize the sweepvec
Inputs.npoints = length(Inputs.sweepvec);
Inputs.sweepvec = round(Inputs.sweepvec*Inputs.SamplingRate)/Inputs.SamplingRate;

%% adjust the green-off lengths

Inputs.gr_toff = 10e3; %time between consecutive green pulses to keep duty cycle constant
if Inputs.bT1chargeComp
    Inputs.gr_toff = Inputs.sweepvec + Inputs.EndAdd;
end
if Inputs.bDCconst_long
    Inputs.gr_toff=Inputs.bDCconst_long;
end

%% if the transition freq is swept
Inputs.bSweepFreq = 0;
if Inputs.bSweepFreq
    Inputs.bSweepFreqList = linspace(2.652 - 0.08, 2.652 + 0.08, 41);               % transition freq, GHz 
    Inputs.FixTimeAt = 1000;                                                        % fixed time evolution
    Inputs.npoints = length(Inputs.bSweepFreqList);
    Inputs.sweepvec = Inputs.FixTimeAt * ones(1, length(Inputs.bSweepFreqList));
end

%% ready to run the seq 

DefineParameters();
disp(' ')
disp('--- Compiling new sequence!')
disp(['we are gonna measure ' Measurement])

%% CASE 1: if waveform is swept

if Inputs.bSweepwf
    
    global PB_Seq_total Compiler_Seq_length Compiler_loop_total Compiler_Seq_Cell_total Trigger_Seq_length

    Compiler_Seq_total = {};
    Compiler_Seq_Cell_total = {};
    Compiler_loop_total = [];
    Compiler_Seq_length = zeros(length(Inputs.npoints));
    
    PB_Seq_total = {};
    
    Trigger_Seq_total = {};
    Trigger_Seq_length = zeros(length(Inputs.npoints));
        
    for i = 1:Inputs.npoints
        
        %%%%%%%%%%%%%%%% for AWG %%%%%%%%%%%%%%%%%%%%%        
        if strcmp(Measurement, 'Isoya_AWG_Measure_T1') 
            [Ch1 Ch2 Mk1 Mk2 Mk3 Mk4] = Isoya_AWG_Measure_T1(Inputs.sweepvec(i),Inputs.gr_ton);
        elseif strcmp(Measurement, 'Isoya_AWG_Measure_sweep_Ramsey') 
            [Ch1 Ch2 Mk1 Mk2 Mk3 Mk4] = Isoya_AWG_Measure_sweep_Ramsey(Inputs.sweepvec(i),Inputs.gr_ton);
        elseif strcmp(Measurement, 'Isoya_AWG_Measure_sweep_DEER') 
            [Ch1 Ch2 Mk1 Mk2 Mk3 Mk4] = Isoya_AWG_Measure_sweep_DEER(Inputs.sweepvec(i),Inputs.gr_ton);
        elseif strcmp(Measurement, 'Isoya_AWG_Measure_sweep_Rabi') 
            [Ch1 Ch2 Mk1 Mk2 Mk3 Mk4] = Isoya_AWG_Measure_sweep_Rabi(Inputs.sweepvec(i),Inputs.gr_ton);
        elseif strcmp(Measurement, 'Isoya_AWG_Measure_sweep_HH') 
            [Ch1 Ch2 Mk1 Mk2 Mk3 Mk4] = Isoya_AWG_Measure_sweep_HH(Inputs.sweepvec(i),Inputs.gr_ton); 
        elseif strcmp(Measurement, 'Isoya_AWG_Measure_sweep_HH_delay')
            [Ch1 Ch2 Mk1 Mk2 Mk3 Mk4] = Isoya_AWG_Measure_sweep_HH_delay(Inputs.sweepvec(i),Inputs.gr_ton);
        elseif strcmp(Measurement, 'Isoya_AWG_Measure_sweep_spinlock') 
            [Ch1 Ch2 Mk1 Mk2 Mk3 Mk4] = Isoya_AWG_Measure_sweep_spinlock(Inputs.sweepvec(i),Inputs.gr_ton);  
        elseif strcmp(Measurement, 'Isoya_AWG_Measure_sweep_HH_power')
            [Ch1 Ch2 Mk1 Mk2 Mk3 Mk4] = Isoya_AWG_Measure_sweep_HH_power(Inputs.sweepvec(i),Inputs.gr_ton);
        elseif strcmp(Measurement, 'Isoya_AWG_Measure_sweep_HH_power_1to3')
            [Ch1 Ch2 Mk1 Mk2 Mk3 Mk4] = Isoya_AWG_Measure_sweep_HH_power_1to3(Inputs.sweepvec(i),Inputs.gr_ton);
        elseif strcmp(Measurement, 'Isoya_AWG_Measure_sweep_dynamical_decoupling')
            [Ch1 Ch2 Mk1 Mk2 Mk3 Mk4] = Isoya_AWG_Measure_sweep_dynamical_decoupling(Inputs.sweepvec(i),Inputs.gr_ton);
        elseif strcmp(Measurement, 'Isoya_AWG_Measure_sweep_timecrystal')
            [Ch1 Ch2 Mk1 Mk2 Mk3 Mk4] = Isoya_AWG_Measure_sweep_timecrystal(Inputs.sweepvec(i),Inputs.gr_ton) ;
        elseif strcmp(Measurement, 'Isoya_AWG_Measure_sweep_timecrystal_spin1')
            [Ch1 Ch2 Mk1 Mk2 Mk3 Mk4] = Isoya_AWG_Measure_sweep_timecrystal_spin1(Inputs.sweepvec(i),Inputs.gr_ton) ;
        end
        Compiler_Seq = Convert2Seq(Ch1,Ch2,Mk1,Mk2,Mk3,Mk4);
        Inputs.Loops = [];
        FinishAWGseq();
        Compiler_Seq_Cell_total = [Compiler_Seq_Cell_total Inputs.Seq_Cell];
        Compiler_loop_total = [Compiler_loop_total Inputs.Loops];
        Compiler_Seq_length(i) = length(Inputs.Seq_Cell);
        Compiler_Seq_total = [Compiler_Seq_total;Compiler_Seq];
        
        
        %%%%%%%% iteration time per sequence is set by the maximum length of total evolution time 
        if i == 1
            if Inputs.bSweepFreq
                Inputs.time_it = (Inputs.nCount+gNrepeat+1)*(Inputs.FixTimeAt + Inputs.EndAdd + Inputs.gr_ton);
            elseif Inputs.bWaitTime
                if Inputs.AddContrastAll == 0
                    Inputs.time_it = (Inputs.nCount+gNrepeat+1)*(Inputs.bWaitTime + Inputs.GreenPrePulseLen + Inputs.sweepvec(end) + Inputs.EndAdd + Inputs.gr_ton)...
                                     +  2 * Inputs.AddContrast *(Inputs.bWaitTime + Inputs.GreenPrePulseLen + Inputs.EndAdd + Inputs.gr_ton);
                else
                    Inputs.time_it = (Inputs.nCount+gNrepeat+1)*(Inputs.bWaitTime + Inputs.GreenPrePulseLen + Inputs.sweepvec(end) + Inputs.EndAdd + Inputs.gr_ton)...
                                     +  Inputs.nCount          *(Inputs.bWaitTime + Inputs.GreenPrePulseLen + Inputs.EndAdd + Inputs.gr_ton);
                end
            else
                Inputs.time_it = (Inputs.nCount+gNrepeat+1)*(Inputs.sweepvec(end) + Inputs.EndAdd + Inputs.gr_ton);
            end
        end
        
        Inputs.nSamples = round(round(Inputs.time_avrg*1e9/Inputs.time_it/100)*100);  % For PB, calculate amount of samples for praticular total evolution time
        Inputs.gr_toff = Inputs.sweepvec(i);                                          % green-off time is set by each sequence length

        %%%%%%%%%%%%%%%% for PB %%%%%%%%%%%%%%%%%%%%%
        if strcmp(Readout,'DAQ')
            Trigger_Seq = Isoya_PB_AWG_DAQ(i);
        elseif strcmp(Readout,'Jim')
            Trigger_Seq = Isoya_PB_AWG_Jim(i);
        end
        Trigger_Seq_length(i) = size(Trigger_Seq,1);
        Trigger_Seq_total = [Trigger_Seq_total;Trigger_Seq];
             
    end
    Compiler_Seq = Compiler_Seq_total;
    Trigger_Seq = Trigger_Seq_total;
    
    Inputs.Compiler_Seq_length = Compiler_Seq_length;
    Inputs.Trigger_Seq_length = Trigger_Seq_length;
    
end

%% CASE 2: if waveform is "NOT" swept (all-in-one seq)

if ~Inputs.bSweepwf

    % Create AWG sequence
    Compiler_Seq = Isoya_AWG_Compile();
    
    % Chop into sequence files and fix granularity
    FinishAWGseq();
    
    %calculate amount of samples for praticular total evolution time
    Inputs.time_it = ((Inputs.nCount+gNrepeat)*Inputs.npoints+1)*(Inputs.gr_toff(round(end/2)) + Inputs.gr_ton);
    
    if Inputs.bT1chargeComp
        Inputs.time_it = sum(Inputs.bT1chargeComp + Inputs.GreenPrePulseLen + Inputs.sweepvec + Inputs.EndAdd + Inputs.gr_ton)...
                           +(Inputs.bT1chargeComp + Inputs.GreenPrePulseLen + Inputs.EndAdd + Inputs.gr_ton);
    end
    
    Inputs.nSamples = round(round(Inputs.time_avrg*1e9/Inputs.time_it/100)*100);
    
    if strcmp(Readout,'DAQ')
        Trigger_Seq = Isoya_PB_AWG_DAQ();
    elseif strcmp(Readout,'Jim')
        Trigger_Seq = Isoya_PB_AWG_Jim();
    end
    
end

%% how to plot averaging data 
    
if plot_seq == 1
    if Inputs.bSweepwf
        Inputs.Seq_Cell = Compiler_Seq_Cell_total;
        Inputs.Loops = Compiler_loop_total;
    end
    Plot_AWG_Sequence();
    Plot_PB_Sequence();
else
    disp('Plotting suppressed by user')
end

%% Compiling done!
disp('Done!')
disp(' ')

end


%% Important function
function SeqPar = Isoya_PB_AWG_DAQ(loop_nr)

global Inputs PB_Seq gNrepeat PB_Seq_total

if Inputs.bSweepwf
    sweeptime = Inputs.gr_toff;
    if Inputs.SweepDAQclen
        gr_toff = Inputs.EndAdd;
    else
        gr_toff = sweeptime + Inputs.EndAdd;
    end     
    gr_ton = Inputs.gr_ton;
else
    gr_toff = Inputs.gr_toff;
    gr_ton = Inputs.gr_ton;
end

if Inputs.bT1chargeComp
    
    %%%%%% Define events of intividual channals %%%%%%

    %%%%%% trigger AWG %%%%%% 
    Ch2 = [ Inputs.bT1chargeComp+Inputs.GreenPrePulseLen+Inputs.EndAdd+gr_ton;...  
            100]; 

    %%%%%% green %%%%%% 
    Ch5 = [ Inputs.bT1chargeComp            Inputs.bT1chargeComp+Inputs.EndAdd+Inputs.GreenPrePulseLen;...
            Inputs.GreenPrePulseLen         gr_ton];     

    Ch0=[];
    Ch6 = [];
    if Inputs.nSweepGreenPol
        for kk=1:Inputs.npoints
            for mm=1:Inputs.nCount 
                Ch5_temp = [ (Ch5(1,end)+Ch5(2,end))+Inputs.bT1chargeComp (Ch5(1,end)+Ch5(2,end))+Inputs.bT1chargeComp+(Inputs.sweepvec(kk)+Inputs.EndAdd)+gr_ton;...  
                              Inputs.sweepvec(kk) gr_ton]; 
                Ch0_temp = [ (Ch5(1,end)+Ch5(2,end))+Inputs.bT1chargeComp+(Inputs.sweepvec(kk)+Inputs.EndAdd)+gr_ton;...  
                              Inputs.DAQcounterlength]; 
                Ch6_temp = [ (Ch5(1,end)+Ch5(2,end))+Inputs.bT1chargeComp+(Inputs.sweepvec(kk)+Inputs.EndAdd)+gr_ton (Ch5(1,end)+Ch5(2,end))+Inputs.bT1chargeComp+(Inputs.sweepvec(kk)+Inputs.EndAdd)+gr_ton+Inputs.DAQcounterlength;...  
                              Inputs.Ch6_length Inputs.Ch6_length];  
                Ch5 = [Ch5 Ch5_temp];
                Ch0 = [Ch0 Ch0_temp];
                Ch6 = [Ch6 Ch6_temp];
            end
            if Inputs.bSweepwf && kk == 1
                break;
            end
        end  
    else
        for kk=1:Inputs.npoints
            for mm=1:Inputs.nCount 
                Ch5_temp = [ (Ch5(1,end)+Ch5(2,end))+Inputs.bT1chargeComp (Ch5(1,end)+Ch5(2,end))+Inputs.bT1chargeComp+(Inputs.sweepvec(kk)+Inputs.EndAdd)+Inputs.GreenPrePulseLen;...  
                              Inputs.GreenPrePulseLen gr_ton]; 
                          
              % if we want to measure the fluorescence under the green
              if mm == 1 && Inputs.bBrightMeasure
                  Ch0_temp = [];
                  Ch6_temp = [];
                  for ii = 1:Inputs.bBrightMeasure
                      Ch0_temp = [Ch0_temp, [(Ch5(1,end)+Ch5(2,end))+Inputs.bT1chargeComp+Inputs.bBrightTiming(ii);...  
                                             Inputs.DAQcounterlength]]; 
                      Ch6_temp = [Ch6_temp, [ (Ch5(1,end)+Ch5(2,end))+Inputs.bT1chargeComp+Inputs.bBrightTiming(ii)     (Ch5(1,end)+Ch5(2,end))+Inputs.bT1chargeComp+Inputs.bBrightTiming(ii)+Inputs.DAQcounterlength;...  
                                               Inputs.Ch6_length                                                        Inputs.Ch6_length]];
                  end
                  Ch0 = [Ch0 Ch0_temp];
                  Ch6 = [Ch6 Ch6_temp];
              end
                Ch0_temp = [ (Ch5(1,end)+Ch5(2,end))+Inputs.bT1chargeComp+(Inputs.sweepvec(kk)+Inputs.EndAdd)+Inputs.GreenPrePulseLen;...
                              Inputs.DAQcounterlength];
              
                Ch6_temp = [ (Ch5(1,end)+Ch5(2,end))+Inputs.bT1chargeComp+(Inputs.sweepvec(kk)+Inputs.EndAdd)+Inputs.GreenPrePulseLen (Ch5(1,end)+Ch5(2,end))+Inputs.bT1chargeComp+(Inputs.sweepvec(kk)+Inputs.EndAdd)+Inputs.GreenPrePulseLen+Inputs.DAQcounterlength;...  
                              Inputs.Ch6_length                                                                             Inputs.Ch6_length];  
                Ch5 = [Ch5 Ch5_temp];
                Ch0 = [Ch0 Ch0_temp];
                Ch6 = [Ch6 Ch6_temp];
            end
            if Inputs.bSweepwf && kk == 1
                break;
            end
        end
    end
    
    Ch5(1,:) = Ch5(1,:)-200; %adjust for loop offset
    Ch0(1,:) = Ch0(1,:)-200; %adjust for loop offset
    Ch6(1,:) = Ch6(1,:)-200; %adjust for loop offset


    %%%%%% dummy spacer pulse %%%%%% 
    Ch10 = [ 0  ;... %% Start times
                sum(gr_ton+Inputs.GreenPrePulseLen+(Inputs.sweepvec+Inputs.EndAdd)+Inputs.bT1chargeComp)*Inputs.nCount+Inputs.bT1chargeComp+Inputs.GreenPrePulseLen+Inputs.EndAdd+gr_ton-200;... %% Pulse duration
                ];
    %%%%%% Combine all the channals to one matrix %%%%%% 
    
elseif Inputs.bDCconst_long
    
    %%%%%% Define events of intividual channals %%%%%%

    % initial wait time
    wait_time = Inputs.bDCconst_long - Inputs.sweepvec(1) - gr_ton - Inputs.EndAdd; % minimum spacing of 3 us is added
    
    %%%%%% trigger AWG %%%%%% 
    Ch2 = [ wait_time + gr_ton;...  
            100]; 

    %%%%%% green %%%%%% 
    Ch5 = [ wait_time;...
            gr_ton];     

    Ch0 = [];
    Ch6 = [];
    for kk=1:Inputs.npoints
        for mm=1:Inputs.nCount
            
            % varying wait time depending on evolution time
            evolution_time = Inputs.sweepvec(kk) + Inputs.EndAdd; % minimum spacing of 3 us is added
            wait_time = Inputs.bDCconst_long - evolution_time - gr_ton; 
            
            Ch5_temp = [ (Ch5(1,end)+Ch5(2,end)) + wait_time     (Ch5(1,end)+Ch5(2,end)) + wait_time + gr_ton + evolution_time;...  
                          gr_ton                                  gr_ton]; 
            Ch0_temp = [ (Ch5(1,end)+Ch5(2,end)) + wait_time + gr_ton + evolution_time;...  
                          Inputs.DAQcounterlength]; 
            Ch6_temp = [ (Ch5(1,end)+Ch5(2,end)) + wait_time + gr_ton + evolution_time      (Ch5(1,end)+Ch5(2,end)) + wait_time + gr_ton + evolution_time + Inputs.DAQcounterlength;...  
                          Inputs.Ch6_length                                                         Inputs.Ch6_length];  
            Ch5 = [Ch5 Ch5_temp];
            Ch0 = [Ch0 Ch0_temp];
            Ch6 = [Ch6 Ch6_temp];
        end
        if Inputs.bSweepwf && kk == 1
            break;
        end
    end
    Ch5(1,:) = Ch5(1,:)-200; %adjust for loop offset
    Ch0(1,:) = Ch0(1,:)-200; %adjust for loop offset
    Ch6(1,:) = Ch6(1,:)-200; %adjust for loop offset


    %%%%%% dummy spacer pulse %%%%%% 
    Ch10 = [ 0  ;... %% Start times
                (Inputs.npoints*(Inputs.nCount)+1)*(gr_ton+Inputs.bDCconst_long)-200;... %% Pulse duration
                ];
    %%%%%% Combine all the channals to one matrix %%%%%% 


elseif Inputs.bWaitTime
    
    if Inputs.SweepWait
        aux=gr_toff;
        gr_toff=Inputs.bWaitTime;
        Inputs.bWaitTime=aux;
    end
    
    %%%%%% Define events of intividual channals %%%%%%

    %%%%%% trigger AWG %%%%%%     
    Ch2 = [                             Inputs.bWaitTime + Inputs.GreenPrePulseLen + gr_toff + gr_ton;...  
                                        100]; 

    %%%%%% green %%%%%%    
    Ch5 = [ Inputs.bWaitTime            Inputs.bWaitTime + Inputs.GreenPrePulseLen + gr_toff;...
            Inputs.GreenPrePulseLen     gr_ton];     

    for kk=1:Inputs.npoints
        for mm=1:Inputs.nCount+gNrepeat
            Ch5_temp = [ ((kk-1)*(Inputs.nCount+gNrepeat)+mm+1)*(Inputs.bWaitTime + gr_toff + gr_ton + Inputs.GreenPrePulseLen)-gr_ton-Inputs.GreenPrePulseLen - gr_toff   ((kk-1)*(Inputs.nCount+gNrepeat)+mm+1)*(Inputs.bWaitTime + gr_toff + gr_ton + Inputs.GreenPrePulseLen)-gr_ton;...  
                          Inputs.GreenPrePulseLen                                                                                                                               gr_ton];   
            Ch5 = [Ch5 Ch5_temp];
        end
        if Inputs.bSweepwf && kk == 1
            break;
        end
    end
    
    %%% if there's reference counters at the end
    if Inputs.bSweepwf && Inputs.AddContrast
        mm=Inputs.nCount+gNrepeat;
        lencontr=2*(Inputs.bWaitTime+Inputs.GreenPrePulseLen+Inputs.EndAdd+gr_ton);
        for kk=0:Inputs.AddContrast-1
            Ch5_temp = [ (mm+1)*(Inputs.bWaitTime + gr_toff + gr_ton + Inputs.GreenPrePulseLen)+Inputs.bWaitTime+kk*lencontr   (mm+1)*(Inputs.bWaitTime + gr_toff + gr_ton + Inputs.GreenPrePulseLen)+Inputs.bWaitTime+Inputs.GreenPrePulseLen+Inputs.EndAdd+kk*lencontr ;...  
                          Inputs.GreenPrePulseLen                                                                                                                               gr_ton];   
            Ch5 = [Ch5 Ch5_temp];
            Ch5_temp = [ (mm+1)*(Inputs.bWaitTime + gr_toff + gr_ton + Inputs.GreenPrePulseLen)+Inputs.bWaitTime + Inputs.EndAdd + gr_ton + Inputs.GreenPrePulseLen+Inputs.bWaitTime+kk*lencontr   (mm+1)*(Inputs.bWaitTime + gr_toff + gr_ton + Inputs.GreenPrePulseLen)++Inputs.bWaitTime + Inputs.EndAdd + gr_ton + Inputs.GreenPrePulseLen+Inputs.bWaitTime+Inputs.GreenPrePulseLen+Inputs.EndAdd+kk*lencontr ;...  
                          Inputs.GreenPrePulseLen                                                                                                                               gr_ton];   
            Ch5 = [Ch5 Ch5_temp];
        end
        
    %%% if there's reference counters everywhere
    elseif Inputs.bSweepwf && Inputs.AddContrastAll
        Ch5 = [ Inputs.bWaitTime            Inputs.bWaitTime + Inputs.GreenPrePulseLen + gr_toff;...
                Inputs.GreenPrePulseLen     gr_ton];   

        AA = (Inputs.bWaitTime + Inputs.GreenPrePulseLen + gr_toff + gr_ton);
        BB = (Inputs.bWaitTime + Inputs.GreenPrePulseLen + Inputs.EndAdd + gr_ton);
        
        for kk=0:Inputs.nCount+gNrepeat-1; 
            Ch5_temp = [  AA + kk*(AA+BB) + Inputs.bWaitTime    kk*(AA+BB)+2*AA - gr_ton                      kk*(AA+BB)+2*AA + Inputs.bWaitTime       (kk+1)*(AA+BB) + AA - gr_ton;...  
                          Inputs.GreenPrePulseLen               gr_ton                                        Inputs.GreenPrePulseLen                  gr_ton];   
            Ch5 = [Ch5 Ch5_temp];
        end
    end
    Ch5(1,:) = Ch5(1,:)-200; %adjust for loop offset

    %%%%%% counter %%%%%% 
    Ch0 = [];
    for kk=1:Inputs.npoints
        for mm=1:Inputs.nCount
            if Inputs.SweepDAQclen
                Ch0_temp = [ ((kk-1)*(Inputs.nCount+gNrepeat)+mm+1)*(Inputs.bWaitTime + gr_toff + gr_ton +Inputs.GreenPrePulseLen)-gr_ton;...  
                Inputs.sweepvec(loop_nr);];   %10us   
    %             Ch0_temp = [ ((kk-1)*(Inputs.nCount+gNrepeat)+mm+1)*(gr_toff+gr_ton)-gr_ton+Inputs.sweepvec(loop_nr);...  
    %             Inputs.DAQcounterlength;];   %10us  
            else
                Ch0_temp = [ ((kk-1)*(Inputs.nCount+gNrepeat)+mm+1)*(Inputs.bWaitTime + gr_toff + gr_ton+Inputs.GreenPrePulseLen)-gr_ton;...    
                Inputs.DAQcounterlength;];   %10us
            end
            Ch0 = [Ch0 Ch0_temp];
        end
        if Inputs.bSweepwf && kk == 1
            break;
        end
    end
    
    %%% if there's reference counters at the end
    if Inputs.bSweepwf && Inputs.AddContrast
        mm=Inputs.nCount+gNrepeat;
        lencontr=2*(Inputs.bWaitTime+Inputs.GreenPrePulseLen+Inputs.EndAdd+gr_ton);
        for kk=0:Inputs.AddContrast-1
            Ch0_temp = [ (mm+1)*(Inputs.bWaitTime + gr_toff + gr_ton+Inputs.GreenPrePulseLen)+Inputs.bWaitTime + Inputs.EndAdd + Inputs.GreenPrePulseLen+kk*lencontr;...    
            Inputs.DAQcounterlength;];   %10us
            Ch0 = [Ch0 Ch0_temp];
            Ch0_temp = [ (mm+1)*(Inputs.bWaitTime + gr_toff + gr_ton+Inputs.GreenPrePulseLen)+2*(Inputs.bWaitTime + Inputs.EndAdd + Inputs.GreenPrePulseLen)+gr_ton+kk*lencontr;...    
            Inputs.DAQcounterlength;];   %10us
            Ch0 = [Ch0 Ch0_temp];
        end
        
    %%% if there's reference counters everywhere
    elseif Inputs.bSweepwf && Inputs.AddContrastAll
        Ch0 = [];
        AA = (Inputs.bWaitTime + Inputs.GreenPrePulseLen + gr_toff + gr_ton);
        BB = (Inputs.bWaitTime + Inputs.GreenPrePulseLen + Inputs.EndAdd + gr_ton);
        for kk=0:Inputs.nCount-1;
            Ch0_temp = [   kk*(AA+BB)+2*AA - gr_ton                     (kk+1)*(AA+BB) + AA - gr_ton;...
                           Inputs.DAQcounterlength                      Inputs.DAQcounterlength];
            Ch0 = [Ch0 Ch0_temp];
        end
        
    end
    Ch0(1,:) = Ch0(1,:)-200; %adjust for loop offset

    %%%%%% counter APD RIG %%%%%% 
    c_off=0;%Inputs.sweepvec(loop_nr);
    Ch6 = [];
    for kk=1:Inputs.npoints
        for mm=1:Inputs.nCount
            if Inputs.SweepDAQclen
                Ch6_temp = [ ((kk-1)*(Inputs.nCount+gNrepeat)+mm+1)*(Inputs.bWaitTime + gr_toff + gr_ton+Inputs.GreenPrePulseLen)-gr_ton+c_off ((kk-1)*(Inputs.nCount+gNrepeat)+mm+1)*(Inputs.bWaitTime + gr_toff + gr_ton+Inputs.GreenPrePulseLen)-gr_ton+Inputs.sweepvec(loop_nr)+c_off;...  
                                Inputs.Ch6_length Inputs.Ch6_length];     
            else
                Ch6_temp = [ ((kk-1)*(Inputs.nCount+gNrepeat)+mm+1)*(Inputs.bWaitTime + gr_toff + gr_ton+Inputs.GreenPrePulseLen)-gr_ton+c_off ((kk-1)*(Inputs.nCount+gNrepeat)+mm+1)*(Inputs.bWaitTime + gr_toff + gr_ton+Inputs.GreenPrePulseLen)-gr_ton+Inputs.DAQcounterlength+c_off;...    
                                Inputs.Ch6_length Inputs.Ch6_length];  
            end
            Ch6 = [Ch6 Ch6_temp];
        end
        if Inputs.bSweepwf && kk == 1
            break;
        end
    end 
    
    %%% if there's reference counters at the end
    if Inputs.bSweepwf && Inputs.AddContrast
        mm=Inputs.nCount+gNrepeat;
        lencontr=2*(Inputs.bWaitTime+Inputs.GreenPrePulseLen+Inputs.EndAdd+gr_ton);
        for kk=0:Inputs.AddContrast-1
            Ch6_temp = [ (mm+1)*(Inputs.bWaitTime + gr_toff + gr_ton+Inputs.GreenPrePulseLen)+Inputs.bWaitTime + Inputs.EndAdd + Inputs.GreenPrePulseLen+c_off+kk*lencontr (mm+1)*(Inputs.bWaitTime + gr_toff + gr_ton+Inputs.GreenPrePulseLen)+Inputs.bWaitTime + Inputs.EndAdd + Inputs.GreenPrePulseLen+c_off+Inputs.DAQcounterlength+kk*lencontr;...
                Inputs.Ch6_length Inputs.Ch6_length];   %10us
            Ch6 = [Ch6 Ch6_temp];
            Ch6_temp = [ (mm+1)*(Inputs.bWaitTime + gr_toff + gr_ton+Inputs.GreenPrePulseLen)+2*(Inputs.bWaitTime + Inputs.EndAdd + Inputs.GreenPrePulseLen)+gr_ton+c_off+kk*lencontr (mm+1)*(Inputs.bWaitTime + gr_toff + gr_ton+Inputs.GreenPrePulseLen)+2*(Inputs.bWaitTime + Inputs.EndAdd + Inputs.GreenPrePulseLen)+gr_ton+c_off+Inputs.DAQcounterlength+kk*lencontr;...
                Inputs.Ch6_length Inputs.Ch6_length];   %10us
            Ch6 = [Ch6 Ch6_temp];
        end
        
    %%% if there's reference counters everywhere
    elseif Inputs.bSweepwf && Inputs.AddContrastAll
        Ch6 = [];
        AA = (Inputs.bWaitTime + Inputs.GreenPrePulseLen + gr_toff + gr_ton);
        BB = (Inputs.bWaitTime + Inputs.GreenPrePulseLen + Inputs.EndAdd + gr_ton);
        for kk=0:Inputs.nCount-1;
            Ch6_temp = [   kk*(AA+BB)+2*AA - gr_ton      kk*(AA+BB)+2*AA - gr_ton + Inputs.DAQcounterlength     (kk+1)*(AA+BB)+AA - gr_ton     (kk+1)*(AA+BB)+ AA - gr_ton + Inputs.DAQcounterlength;...
                            Inputs.Ch6_length            Inputs.Ch6_length                                       Inputs.Ch6_length              Inputs.Ch6_length];
            Ch6 = [Ch6 Ch6_temp];
        end

    end
    Ch6(1,:) = Ch6(1,:)-200; %adjust for loop offset

    %%%%%% dummy spacer pulse %%%%%% 
%     if ~Inputs.bSweepwf
%         Ch10 = [ 0  ;... %% Start times
%                 (Inputs.npoints*(Inputs.nCount+gNrepeat)+1)*(Inputs.bWaitTime + gr_ton + Inputs.GreenPrePulseLen + gr_toff)-200;... %% Pulse duration
%                 ];
%     else
%         Ch10 = [ 0  ;... %% Start times
%                 ((Inputs.nCount+gNrepeat)+1)*(Inputs.bWaitTime + gr_ton + Inputs.GreenPrePulseLen + gr_toff)-200;... %% Pulse duration
%                 ];
%     end
%     
    if Inputs.bSweepwf && Inputs.AddContrast
        Ch10 = [ 0  ;... %% Start times
                ((Inputs.nCount+gNrepeat)+1)*(Inputs.bWaitTime + gr_ton + Inputs.GreenPrePulseLen + gr_toff)-200+2*Inputs.AddContrast*(Inputs.bWaitTime+Inputs.GreenPrePulseLen+Inputs.EndAdd+gr_ton);... %% Pulse duration
                ];
    elseif Inputs.bSweepwf && Inputs.AddContrastAll
        Ch10 = [ 0  ;... %% Start times
                ((Inputs.nCount+gNrepeat)+1)*(Inputs.bWaitTime + gr_ton + Inputs.GreenPrePulseLen + gr_toff)-200+ (Inputs.nCount+1)*(Inputs.bWaitTime+Inputs.GreenPrePulseLen+Inputs.EndAdd+gr_ton);... %% Pulse duration
                ];
    elseif Inputs.bSweepwf
        Ch10 = [ 0  ;... %% Start times
                ((Inputs.nCount+gNrepeat)+1)*(Inputs.bWaitTime + gr_ton + Inputs.GreenPrePulseLen + gr_toff)-200;... %% Pulse duration
                ];
    else
        Ch10 = [ 0  ;... %% Start times
                (Inputs.npoints*(Inputs.nCount+gNrepeat)+1)*(Inputs.bWaitTime + gr_ton + Inputs.GreenPrePulseLen + gr_toff)-200;... %% Pulse duration
                ];
    end
    %%%%%% Combine all the channals to one matrix %%%%%%
    
    
    if Inputs.SweepWait
        Inputs.bWaitTime=gr_toff;
    end
    
else

    %%%%%% Define events of intividual channals %%%%%%

    %%%%%% trigger AWG %%%%%% 
    Ch2 = [ gr_toff+gr_ton;...  
            100]; 

    %%%%%% green %%%%%% 
    Ch5 = [ gr_toff;...
            gr_ton];     

    for kk=1:Inputs.npoints
        for mm=1:Inputs.nCount+gNrepeat
            Ch5_temp = [ ((kk-1)*(Inputs.nCount+gNrepeat)+mm+1)*(gr_toff+gr_ton)-gr_ton;...  
                          gr_ton];   
            Ch5 = [Ch5 Ch5_temp];
        end
        if Inputs.bSweepwf && kk == 1
            break;
        end
    end
    Ch5(1,:) = Ch5(1,:)-200; %adjust for loop offset

    %%%%%% counter %%%%%% 
    Ch0 = [];
    for kk=1:Inputs.npoints
        for mm=1:Inputs.nCount
            if Inputs.SweepDAQclen
                Ch0_temp = [ ((kk-1)*(Inputs.nCount+gNrepeat)+mm+1)*(gr_toff+gr_ton)-gr_ton;...  
                Inputs.sweepvec(loop_nr);];   %10us   
    %             Ch0_temp = [ ((kk-1)*(Inputs.nCount+gNrepeat)+mm+1)*(gr_toff+gr_ton)-gr_ton+Inputs.sweepvec(loop_nr);...  
    %             Inputs.DAQcounterlength;];   %10us  
            else
                Ch0_temp = [ ((kk-1)*(Inputs.nCount+gNrepeat)+mm+1)*(gr_toff+gr_ton)-gr_ton;...    
                Inputs.DAQcounterlength;];   %10us
            end
            Ch0 = [Ch0 Ch0_temp];
        end
        if Inputs.bSweepwf && kk == 1
            break;
        end
    end 
    Ch0(1,:) = Ch0(1,:)-200; %adjust for loop offset

    %%%%%% counter APD RIG %%%%%% 
    c_off=0;%Inputs.sweepvec(loop_nr);
    Ch6 = [];
    for kk=1:Inputs.npoints
        for mm=1:Inputs.nCount
            if Inputs.SweepDAQclen
                Ch6_temp = [ ((kk-1)*(Inputs.nCount+gNrepeat)+mm+1)*(gr_toff+gr_ton)-gr_ton+c_off ((kk-1)*(Inputs.nCount+gNrepeat)+mm+1)*(gr_toff+gr_ton)-gr_ton+Inputs.sweepvec(loop_nr)+c_off;...  
                Inputs.Ch6_length Inputs.Ch6_length];     
            else
                Ch6_temp = [ ((kk-1)*(Inputs.nCount+gNrepeat)+mm+1)*(gr_toff+gr_ton)-gr_ton+c_off ((kk-1)*(Inputs.nCount+gNrepeat)+mm+1)*(gr_toff+gr_ton)-gr_ton+Inputs.DAQcounterlength+c_off;...    
                Inputs.Ch6_length Inputs.Ch6_length];  
            end
            Ch6 = [Ch6 Ch6_temp];
        end
        if Inputs.bSweepwf && kk == 1
            break;
        end
    end 
    Ch6(1,:) = Ch6(1,:)-200; %adjust for loop offset

    %%%%%% dummy spacer pulse %%%%%% 
    if ~Inputs.bSweepwf
        Ch10 = [ 0  ;... %% Start times
                (Inputs.npoints*(Inputs.nCount+gNrepeat)+1)*(gr_ton+gr_toff)-200;... %% Pulse duration
                ];
    else
        Ch10 = [ 0  ;... %% Start times
                ((Inputs.nCount+gNrepeat)+1)*(gr_ton+gr_toff)-200;... %% Pulse duration
                ];
    end
    %%%%%% Combine all the channals to one matrix %%%%%%
    
end


%delays relative to green
gDelay = [];
gDelay.Ch2 = 0; % ns % AWG trigger delay
gDelay.Ch0 = 800; % ns 930 
gDelay.Ch5 = 0; % ns 930 
gDelay.Ch6 = 800; % ns 930
gDelay.Ch10 = 0; % ns

Ch2=[   Ch2;...
        ones(1,size(Ch2,2))*2];
Ch5=[   Ch5;...
        ones(1,size(Ch5,2))*5];
Ch0=[   Ch0;...
        ones(1,size(Ch0,2))*0];
Ch6=[   Ch6;...
        ones(1,size(Ch6,2))*6];
Ch10=[   Ch10;...
        ones(1,size(Ch10,2))*10];

Ch2(1,:) = Ch2(1,:) + gDelay.Ch2;
Ch0(1,:) = Ch0(1,:) + gDelay.Ch0;
Ch5(1,:) = Ch5(1,:) + gDelay.Ch5;
Ch6(1,:) = Ch6(1,:) + gDelay.Ch6;
Ch10(1,:) = Ch10(1,:) + gDelay.Ch10;

SeqPar = [Ch0, Ch2, Ch5, Ch6, Ch10]; 
           
PB_Seq = SeqPar;
if Inputs.bSweepwf
    PB_Seq_total = [PB_Seq_total; PB_Seq];
end

Trigger_Seq = Conv2PBSeq(SeqPar);

%%%%%% add looping %%%%%%
Final_Seq = [   0,{'CONTINUE'},0,100,{'ON'};...             % added here
                0,{'LOOP'},Inputs.nSamples,100,{'ON'};...   %careful, is executed in every loop for time t
                Trigger_Seq;...
                0,{'END_LOOP'},1,100,{'ON'}];               %careful, is executed in every loop for time t
 
%%%%%% Find length %%%%%%
Timeout = lengthSequence(Final_Seq);
Inputs.timeout = Timeout + 0.1;

SeqPar = Final_Seq;

end

%% Function Library
function Add_More_Vectors(t_start, t_max, pts, logsampling)

global Inputs

if logsampling
    add_sweepvec = round(logspace(log(t_start)/log(10),log(t_max)/log(10),pts));
else
    add_sweepvec = round(linspace(t_start,t_max,pts));
end
Inputs.sweepvec = [Inputs.sweepvec add_sweepvec];

end

function DefineParameters()
    global Inputs gNrepeat
            
    Inputs.Sequence = [];
    Inputs.Loops = [];
    Inputs.auto_conv_thres = 1e3;
    gNrepeat = 0; %number of useless green pulses to MW reduce duty cycle

end

function FinishAWGseq()
    global Inputs Compiler_Seq gAWG_calib
    
    % add few ns for granularity check, whole sequence must be multiple of 64
    gran_add = 2*64-mod(sum(Compiler_Seq(:,1)),64);
    if gran_add
        Compiler_Seq = [Compiler_Seq;[gran_add 0 0 0 0 0 0]];
    end
    
    % input threshold in ns. all chunks larger than will be converted to loop
    Seq_Cell = AutoConvert2Loops(Compiler_Seq,Inputs.auto_conv_thres);
    
    % memory check
    memory=LengthOfTotWF(Seq_Cell,Inputs.SamplingRate);
    if memory <= 750000
        Inputs.Seq_Cell=Seq_Cell;
    else
        error(['ERROR, total Waveform too long: ' num2str(memory) '/750000 pts'])
    end
     
    %adjust offset
    LOW_Ch1 = 2*gAWG_calib.Ch1.LOW_VOLT;
    LOW_Ch2 = 2*gAWG_calib.Ch2.LOW_VOLT;
    Compiler_Seq(:,2)=Compiler_Seq(:,2)+LOW_Ch1;
    Compiler_Seq(:,3)=Compiler_Seq(:,3)+LOW_Ch2;
    
    Inputs.Sequence = Compiler_Seq;

end

function FinalSequence = Isoya_AWG_Compile()

global Inputs Measurement gAWG_calib

    sweepvec = Inputs.sweepvec;
    gr_toff = Inputs.gr_toff;
    gr_ton = Inputs.gr_ton;
    FinalSequence = [];

    for kk=1:length(sweepvec)
        
        %call sequence to be executed
        [Ch1 Ch2 Mk1 Mk2 Mk3 Mk4] = Isoya_AWG_Measure(sweepvec(kk),gr_toff,gr_ton,Measurement);

        FinalSequence_temp = Convert2Seq(Ch1,Ch2,Mk1,Mk2,Mk3,Mk4);
        FinalSequence=[FinalSequence;FinalSequence_temp];
    end

end

function SeqPar = Isoya_PB_Jim_Reset() 

global Inputs

gr_toff = Inputs.gr_toff;
gr_ton = Inputs.gr_ton;

%%%%%% Define events of intividual channals %%%%%%

%%%%%% Green %%%%%% 
Ch5 = [ gr_toff - 100   ;...  %adjust for added time during loop
        gr_ton          ;...
        ]; 

if ((gr_toff+gr_ton) < 20000)
    error('check your green on+off length, should be at least 20us')
end

%%%%%% Reset Jims Box %%%%%% 
Ch6 = [ 5000 - 100  ;... %% Start times 
        300         ;... %% Pulse duration  
        ];  

%%%%%% Combine all the channals to one matrix %%%%%% 
gDelay = [];
gDelay.Ch6 = 0;%ns

Ch5=[   Ch5;...
        ones(1,size(Ch5,2))*5];
Ch6=[   Ch6;...
        ones(1,size(Ch6,2))*6];
Ch6(1,:) = Ch6(1,:) + gDelay.Ch6;

SeqPar = [Ch5, Ch6]; 

end 

function SeqPar = Isoya_PB_AWG_Jim(loop_nr)

global Inputs PB_Seq PB_Seq_total gNrepeat

if Inputs.bSweepwf
    sweeptime = Inputs.gr_toff;
    gr_toff = sweeptime + Inputs.EndAdd;
    gr_ton = Inputs.gr_ton;
else
    gr_toff = Inputs.gr_toff;
    gr_ton = Inputs.gr_ton;
end

%%%%%% Define events of intividual channals %%%%%%


if Inputs.bT1chargeComp
    
    %%%%%% Define events of intividual channals %%%%%%
    
    %%%%%% trigger AWG %%%%%%
    Ch2 = [ Inputs.bT1chargeComp+Inputs.GreenPrePulseLen+Inputs.EndAdd+gr_ton;...
            100];
    
    %%%%%% trigger jims box %%%%%%
    Ch4 = [ Inputs.bT1chargeComp+Inputs.GreenPrePulseLen+Inputs.EndAdd;...
            500];
    
    %%%%%% green %%%%%%
    Ch5 = [ Inputs.bT1chargeComp Inputs.bT1chargeComp+Inputs.EndAdd+Inputs.GreenPrePulseLen;...
        Inputs.GreenPrePulseLen gr_ton];
    
    %%%%% jim's pulse %%%%%
    Ch3=[];
    if Inputs.nSweepGreenPol
        for kk=1:Inputs.npoints
            for mm=1:Inputs.nCount
                Ch5_temp = [ (Ch5(1,end)+Ch5(2,end))+Inputs.bT1chargeComp (Ch5(1,end)+Ch5(2,end))+Inputs.bT1chargeComp+(Inputs.sweepvec(kk)+Inputs.EndAdd)+gr_ton;...
                    Inputs.sweepvec(kk) gr_ton];
                Ch3_temp = [ (Ch5(1,end)+Ch5(2,end))+Inputs.bT1chargeComp+(Inputs.sweepvec(kk)+Inputs.EndAdd)+gr_ton;...
                    Inputs.DAQcounterlength];
                Ch5 = [Ch5 Ch5_temp];
                Ch3 = [Ch3 Ch3_temp];
            end
            if Inputs.bSweepwf && kk == 1
                break;
            end
        end
    else
        for kk=1:Inputs.npoints
            for mm=1:Inputs.nCount
                Ch5_temp = [ (Ch5(1,end)+Ch5(2,end))+Inputs.bT1chargeComp (Ch5(1,end)+Ch5(2,end))+Inputs.bT1chargeComp+(Inputs.sweepvec(kk)+Inputs.EndAdd)+Inputs.GreenPrePulseLen;...
                    Inputs.GreenPrePulseLen gr_ton];
                
                % if we want to measure the fluorescence under the green
                if mm == 1 && Inputs.bBrightMeasure
                    Ch3_temp = [];
                    for ii = 1:Inputs.bBrightMeasure
                        Ch3_temp = [Ch3_temp, [(Ch5(1,end)+Ch5(2,end))+Inputs.bT1chargeComp+Inputs.bBrightTiming(ii);...
                            Inputs.DAQcounterlength]];
                    end
                    Ch3 = [Ch3 Ch3_temp];
                end
                Ch3_temp = [ (Ch5(1,end)+Ch5(2,end))+Inputs.bT1chargeComp+(Inputs.sweepvec(kk)+Inputs.EndAdd)+Inputs.GreenPrePulseLen;...
                    Inputs.DAQcounterlength];
                
                Ch5 = [Ch5 Ch5_temp];
                Ch3 = [Ch3 Ch3_temp];
            end
            if Inputs.bSweepwf && kk == 1
                break;
            end
        end
    end
    
    Ch5(1,:) = Ch5(1,:)-200; %adjust for loop offset
    Ch3(1,:) = Ch3(1,:)-200; %adjust for loop offset    
    
    %%%%%% dummy spacer pulse %%%%%%
    Ch10 = [ 0  ;... %% Start times
        sum(gr_ton+Inputs.GreenPrePulseLen+(Inputs.sweepvec+Inputs.EndAdd)+Inputs.bT1chargeComp)*Inputs.nCount+Inputs.bT1chargeComp+Inputs.GreenPrePulseLen+Inputs.EndAdd+gr_ton-200;... %% Pulse duration
        ];
    %%%%%% Combine all the channals to one matrix %%%%%%
    
elseif Inputs.bDCconst_long
    
    %%%%%% Define events of intividual channals %%%%%%
    
    % initial wait time
    wait_time = Inputs.bDCconst_long - Inputs.sweepvec(1) - gr_ton - Inputs.EndAdd; % minimum spacing of 3 us is added
    
    %%%%%% trigger AWG %%%%%%
    Ch2 = [ wait_time + gr_ton;...
            100];
    
    %%%%%% green %%%%%%
    Ch5 = [ wait_time;...
        gr_ton];
    
    Ch3 = [];
    for kk=1:Inputs.npoints
        for mm=1:Inputs.nCount
            
            % varying wait time depending on evolution time
            evolution_time = Inputs.sweepvec(kk) + Inputs.EndAdd; % minimum spacing of 3 us is added
            wait_time = Inputs.bDCconst_long - evolution_time - gr_ton;
            
            Ch5_temp = [ (Ch5(1,end)+Ch5(2,end)) + wait_time     (Ch5(1,end)+Ch5(2,end)) + wait_time + gr_ton + evolution_time;...
                gr_ton                                  gr_ton];
            Ch3_temp = [ (Ch5(1,end)+Ch5(2,end)) + wait_time + gr_ton + evolution_time;...
                Inputs.DAQcounterlength];
            Ch5 = [Ch5 Ch5_temp];
            Ch3 = [Ch3 Ch3_temp];
        end
        if Inputs.bSweepwf && kk == 1
            break;
        end
    end
    Ch5(1,:) = Ch5(1,:)-200; %adjust for loop offset
    Ch3(1,:) = Ch3(1,:)-200; %adjust for loop offset
    
    %%%%%% dummy spacer pulse %%%%%%
    Ch10 = [ 0  ;... %% Start times
        (Inputs.npoints*(Inputs.nCount)+1)*(gr_ton+Inputs.bDCconst_long)-200;... %% Pulse duration
        ];
    %%%%%% Combine all the channals to one matrix %%%%%%
    
    
elseif Inputs.bWaitTime
    
    if Inputs.SweepWait
        aux=gr_toff;
        gr_toff=Inputs.bWaitTime;
        Inputs.bWaitTime=aux;
    end
    
    %%%%%% Define events of intividual channals %%%%%%
    
    %%%%%% trigger AWG %%%%%%
    Ch2 = [Inputs.bWaitTime + Inputs.GreenPrePulseLen + gr_toff + gr_ton;...
            100];
        
    %%%%%% trigger jims box %%%%%%
    Ch4 = [ Inputs.bWaitTime + Inputs.GreenPrePulseLen + gr_toff;...
            500];
    
    %%%%%% green %%%%%%
    Ch5 = [ Inputs.bWaitTime            Inputs.bWaitTime + Inputs.GreenPrePulseLen + gr_toff;...
        Inputs.GreenPrePulseLen     gr_ton];
    
    for kk=1:Inputs.npoints
        for mm=1:Inputs.nCount+gNrepeat
            Ch5_temp = [ ((kk-1)*(Inputs.nCount+gNrepeat)+mm+1)*(Inputs.bWaitTime + gr_toff + gr_ton + Inputs.GreenPrePulseLen)-gr_ton-Inputs.GreenPrePulseLen - gr_toff   ((kk-1)*(Inputs.nCount+gNrepeat)+mm+1)*(Inputs.bWaitTime + gr_toff + gr_ton + Inputs.GreenPrePulseLen)-gr_ton;...
                Inputs.GreenPrePulseLen                                                                                                                               gr_ton];
            Ch5 = [Ch5 Ch5_temp];
        end
        if Inputs.bSweepwf && kk == 1
            break;
        end
    end
    
    %%% if there's reference counters at the end
    if Inputs.bSweepwf && Inputs.AddContrast
        mm=Inputs.nCount+gNrepeat;
        lencontr=2*(Inputs.bWaitTime+Inputs.GreenPrePulseLen+Inputs.EndAdd+gr_ton);
        for kk=0:Inputs.AddContrast-1
            Ch5_temp = [ (mm+1)*(Inputs.bWaitTime + gr_toff + gr_ton + Inputs.GreenPrePulseLen)+Inputs.bWaitTime+kk*lencontr   (mm+1)*(Inputs.bWaitTime + gr_toff + gr_ton + Inputs.GreenPrePulseLen)+Inputs.bWaitTime+Inputs.GreenPrePulseLen+Inputs.EndAdd+kk*lencontr ;...
                Inputs.GreenPrePulseLen                                                                                                                               gr_ton];
            Ch5 = [Ch5 Ch5_temp];
            Ch5_temp = [ (mm+1)*(Inputs.bWaitTime + gr_toff + gr_ton + Inputs.GreenPrePulseLen)+Inputs.bWaitTime + Inputs.EndAdd + gr_ton + Inputs.GreenPrePulseLen+Inputs.bWaitTime+kk*lencontr   (mm+1)*(Inputs.bWaitTime + gr_toff + gr_ton + Inputs.GreenPrePulseLen)++Inputs.bWaitTime + Inputs.EndAdd + gr_ton + Inputs.GreenPrePulseLen+Inputs.bWaitTime+Inputs.GreenPrePulseLen+Inputs.EndAdd+kk*lencontr ;...
                Inputs.GreenPrePulseLen                                                                                                                               gr_ton];
            Ch5 = [Ch5 Ch5_temp];
        end
        
        %%% if there's reference counters everywhere
    elseif Inputs.bSweepwf && Inputs.AddContrastAll
        Ch5 = [ Inputs.bWaitTime            Inputs.bWaitTime + Inputs.GreenPrePulseLen + gr_toff;...
            Inputs.GreenPrePulseLen     gr_ton];
        
        AA = (Inputs.bWaitTime + Inputs.GreenPrePulseLen + gr_toff + gr_ton);
        BB = (Inputs.bWaitTime + Inputs.GreenPrePulseLen + Inputs.EndAdd + gr_ton);
        
        for kk=0:Inputs.nCount+gNrepeat-1;
            Ch5_temp = [  AA + kk*(AA+BB) + Inputs.bWaitTime    kk*(AA+BB)+2*AA - gr_ton                      kk*(AA+BB)+2*AA + Inputs.bWaitTime       (kk+1)*(AA+BB) + AA - gr_ton;...
                Inputs.GreenPrePulseLen               gr_ton                                        Inputs.GreenPrePulseLen                  gr_ton];
            Ch5 = [Ch5 Ch5_temp];
        end
    end
    Ch5(1,:) = Ch5(1,:)-200; %adjust for loop offset
    
    %%%%%% counter %%%%%%
    Ch3 = [];
    for kk=1:Inputs.npoints
        for mm=1:Inputs.nCount
            if Inputs.SweepDAQclen
                Ch3_temp = [ ((kk-1)*(Inputs.nCount+gNrepeat)+mm+1)*(Inputs.bWaitTime + gr_toff + gr_ton +Inputs.GreenPrePulseLen)-gr_ton;...
                    Inputs.sweepvec(loop_nr);];   %10us
                %             Ch3_temp = [ ((kk-1)*(Inputs.nCount+gNrepeat)+mm+1)*(gr_toff+gr_ton)-gr_ton+Inputs.sweepvec(loop_nr);...
                %             Inputs.DAQcounterlength;];   %10us
            else
                Ch3_temp = [ ((kk-1)*(Inputs.nCount+gNrepeat)+mm+1)*(Inputs.bWaitTime + gr_toff + gr_ton+Inputs.GreenPrePulseLen)-gr_ton;...
                    Inputs.DAQcounterlength;];   %10us
            end
            Ch3 = [Ch3 Ch3_temp];
        end
        if Inputs.bSweepwf && kk == 1
            break;
        end
    end
    
    %%% if there's reference counters at the end
    if Inputs.bSweepwf && Inputs.AddContrast
        mm=Inputs.nCount+gNrepeat;
        lencontr=2*(Inputs.bWaitTime+Inputs.GreenPrePulseLen+Inputs.EndAdd+gr_ton);
        for kk=0:Inputs.AddContrast-1
            Ch3_temp = [ (mm+1)*(Inputs.bWaitTime + gr_toff + gr_ton+Inputs.GreenPrePulseLen)+Inputs.bWaitTime + Inputs.EndAdd + Inputs.GreenPrePulseLen+kk*lencontr;...
                Inputs.DAQcounterlength;];   %10us
            Ch3 = [Ch3 Ch3_temp];
            Ch3_temp = [ (mm+1)*(Inputs.bWaitTime + gr_toff + gr_ton+Inputs.GreenPrePulseLen)+2*(Inputs.bWaitTime + Inputs.EndAdd + Inputs.GreenPrePulseLen)+gr_ton+kk*lencontr;...
                Inputs.DAQcounterlength;];   %10us
            Ch3 = [Ch3 Ch3_temp];
        end
        
        %%% if there's reference counters everywhere
    elseif Inputs.bSweepwf && Inputs.AddContrastAll
        Ch3 = [];
        AA = (Inputs.bWaitTime + Inputs.GreenPrePulseLen + gr_toff + gr_ton);
        BB = (Inputs.bWaitTime + Inputs.GreenPrePulseLen + Inputs.EndAdd + gr_ton);
        for kk=0:Inputs.nCount-1;
            Ch3_temp = [   kk*(AA+BB)+2*AA - gr_ton                     (kk+1)*(AA+BB) + AA - gr_ton;...
                Inputs.DAQcounterlength                      Inputs.DAQcounterlength];
            Ch3 = [Ch3 Ch3_temp];
        end
        
    end
    Ch3(1,:) = Ch3(1,:)-200; %adjust for loop offset
    
    
    %%%%%% dummy spacer pulse %%%%%%
    if Inputs.bSweepwf && Inputs.AddContrast
        Ch10 = [ 0  ;... %% Start times
            ((Inputs.nCount+gNrepeat)+1)*(Inputs.bWaitTime + gr_ton + Inputs.GreenPrePulseLen + gr_toff)-200+2*Inputs.AddContrast*(Inputs.bWaitTime+Inputs.GreenPrePulseLen+Inputs.EndAdd+gr_ton);... %% Pulse duration
            ];
    elseif Inputs.bSweepwf && Inputs.AddContrastAll
        Ch10 = [ 0  ;... %% Start times
            ((Inputs.nCount+gNrepeat)+1)*(Inputs.bWaitTime + gr_ton + Inputs.GreenPrePulseLen + gr_toff)-200+ (Inputs.nCount+1)*(Inputs.bWaitTime+Inputs.GreenPrePulseLen+Inputs.EndAdd+gr_ton);... %% Pulse duration
            ];
    elseif Inputs.bSweepwf
        Ch10 = [ 0  ;... %% Start times
            ((Inputs.nCount+gNrepeat)+1)*(Inputs.bWaitTime + gr_ton + Inputs.GreenPrePulseLen + gr_toff)-200;... %% Pulse duration
            ];
    else
        Ch10 = [ 0  ;... %% Start times
            (Inputs.npoints*(Inputs.nCount+gNrepeat)+1)*(Inputs.bWaitTime + gr_ton + Inputs.GreenPrePulseLen + gr_toff)-200;... %% Pulse duration
            ];
    end
    %%%%%% Combine all the channals to one matrix %%%%%%
    
    
    if Inputs.SweepWait
        Inputs.bWaitTime=gr_toff;
    end
    
else
    
    
    %%%%%% trigger AWG %%%%%%
    Ch2 = [ gr_toff + gr_ton;...
        100];
    
    %%%%%% trigger jims box %%%%%%
    Ch4 = [ gr_toff;...
        500];
    
    %%%%%% green %%%%%%
    Ch5 = [gr_toff;gr_ton];
    for kk=1:Inputs.npoints
        for mm=1:Inputs.nCount+gNrepeat
            Ch5_temp = [ ((kk-1)*(Inputs.nCount+gNrepeat)+mm+1)*(gr_toff+gr_ton)-gr_ton;...
                gr_ton];
            Ch5 = [Ch5 Ch5_temp];
        end
        if Inputs.bSweepwf && kk == 1
            break;
        end
    end
    Ch5(1,:) = Ch5(1,:)-200; %adjust for loop offset
    
    %%%%%% counter could be left out %%%%%%
    Ch0 = [];
    for kk=1:Inputs.npoints
        for mm=1:Inputs.nCount
            Ch0_temp = [ ((kk-1)*(Inputs.nCount+gNrepeat)+mm+1)*(gr_toff+gr_ton)-gr_ton;...
                500];
            Ch0 = [Ch0 Ch0_temp];
        end
        if Inputs.bSweepwf && kk == 1
            break;
        end
    end
    Ch0(1,:) = Ch0(1,:)-200; %adjust for loop offset
    
    %%%%%% jim pulse %%%%%%
    Ch3 = [];
    for kk=1:Inputs.npoints
        for mm=1:Inputs.nCount
            Ch3_temp = [ ((kk-1)*(Inputs.nCount+gNrepeat)+mm+1)*(gr_toff+gr_ton)-gr_ton;...
                500];
            Ch3 = [Ch3 Ch3_temp];
        end
        if Inputs.bSweepwf && kk == 1
            break;
        end
    end
    Ch3(1,:) = Ch3(1,:)-200; %adjust for loop offset
    
    %%%%%% dummy spacer pulse %%%%%%
    if ~Inputs.bSweepwf
        Ch10 = [ 0  ;... %% Start times
            (Inputs.npoints*(Inputs.nCount+gNrepeat)+1)*(gr_ton+gr_toff)-200;... %% Pulse duration
            ];
    else
        Ch10 = [ 0  ;... %% Start times
            ((Inputs.nCount+gNrepeat)+1)*(gr_ton+gr_toff)-200;... %% Pulse duration
            ];
    end
end
%%%%%% Combine all the channals to one matrix %%%%%% 

%delays relative to green
gDelay = [];
gDelay.Ch2 = 0; % ns % AWG trigger delay
gDelay.Ch3 = 880; % ns % pulse jimbs box
gDelay.Ch4 = 0; % ns % reset jims box
gDelay.Ch0 = 880; % ns
gDelay.Ch10 = 0; % ns

Ch2=[   Ch2;...
        ones(1,size(Ch2,2))*2];
Ch5=[   Ch5;...
        ones(1,size(Ch5,2))*5];
Ch3=[   Ch3;...
        ones(1,size(Ch3,2))*3];
Ch4=[   Ch4;...
        ones(1,size(Ch4,2))*4];
Ch0=[   Ch3(1:2,:);...
        ones(1,size(Ch3,2))*0];
Ch10=[   Ch10;...
        ones(1,size(Ch10,2))*10];

Ch2(1,:) = Ch2(1,:) + gDelay.Ch2;
Ch3(1,:) = Ch3(1,:) + gDelay.Ch3;
Ch4(1,:) = Ch4(1,:) + gDelay.Ch4;
Ch0(1,:) = Ch0(1,:) + gDelay.Ch0;
Ch10(1,:) = Ch10(1,:) + gDelay.Ch10;

SeqPar = [Ch0, Ch2, Ch3, Ch4, Ch5, Ch10]; 
           
PB_Seq = SeqPar;
if Inputs.bSweepwf
    PB_Seq_total = [PB_Seq_total; PB_Seq];
end
Trigger_Seq = Conv2PBSeq(SeqPar);

%%%%%% add looping %%%%%%
Final_Seq = [ 0,{'CONTINUE'},0,100,{'ON'};... % added here
    0,{'LOOP'},Inputs.nSamples,100,{'ON'};... %careful, is executed in every loop for time t
    Trigger_Seq;...
    0,{'END_LOOP'},1,100,{'ON'}]; %careful, is executed in every loop for time t
 
%%%%%% Find length %%%%%%
Timeout = lengthSequence(Final_Seq);
Inputs.timeout = Timeout + 0.1;

SeqPar = Final_Seq;

end

function SeqPar = Isoya_PB_Compile()

global Inputs Readout Measurement

sweepvec = Inputs.sweepvec;
gr_toff = Inputs.gr_toff;
gr_ton = Inputs.gr_ton;
offs = 0; % the initial offset will be corrected afterwards
SeqPar = [];

    for kk=1:length(sweepvec)
        
        %calculated time offset
        if kk > 1
            offs = max(SeqPar(1,:)+SeqPar(2,:));
        end
    
        %choose pulse sequence to use
        if strcmp(Readout, 'Jim')
            SeqPar_temp = Isoya_PB_Measure(sweepvec(kk),gr_toff,gr_ton,offs,Measurement);
        else
            disp('error: readout method is ill-defined')
        end
        
        % adjust for end loop time offset of 100ns
        if kk==length(sweepvec)
            [val ind] = max(SeqPar_temp(1,:)+SeqPar_temp(2,:));
            SeqPar_temp(2,ind) = SeqPar_temp(2,ind) - 100;
        end
        SeqPar = [SeqPar SeqPar_temp];
    end
end

function SeqPar = Isoya_AWG_Jim_Reset() 

global Inputs
delaytime = Inputs.gr_toff;
greentime = Inputs.gr_ton;

%%%%%% Mixer control: I %%%%%% 
Ch1 = [600;... %% Rabi 
       0;...
       0]; 

%%%%%% Mixer control: Q %%%%%% 
Ch2 = [600;... %% Rabi 
       0;...
       0]; 
   
%%%%%% Counter %%%%%% 
Mk1 = [0;...
       0];

%%%%%% Laser %%%%%% 
Mk2 = [];  
tottime=0;
for kk=1:10   
    Mk2 = [Mk2 [delaytime*kk+greentime*(kk-1);...
                greentime]]; 
    tottime = tottime + delaytime + greentime;
    if tottime >= 20000 break; end
end

%%%%%% Prepare ADC acquisition cycle %%%%%% 
Mk3 = [10000;...
         300];

%%%%%% Unknown %%%%%% 
Mk4 = [0;...
       0];  

SeqPar = Convert2Seq(Ch1,Ch2,Mk1,Mk2,Mk3,Mk4);

end 

function FinalSequence = Convert2Seq(Ch1,Ch2,Mk1,Mk2,Mk3,Mk4) 
global Inputs
gIsoySamplingRateSM = Inputs.SamplingRate;

UnsortedSeq = [[Ch1; zeros(5,size(Ch1,2))], [Ch2(1:2,:); zeros(1,size(Ch2,2)); Ch2(3,:); zeros(4,size(Ch2,2))], [Mk1; OneM(3,6,size(Mk1,2))], [Mk2; OneM(4,6,size(Mk2,2))], [Mk3; OneM(5,6,size(Mk3,2))], [Mk4; OneM(6,6,size(Mk4,2))]]; 

SortSeq = (sortrows(UnsortedSeq', 1))'; %% Order sequence to be increasing in starting time 

DropIndex = find(SortSeq(2,:) == 0); %% Find index for pulse of length 0 
SortSeq(:,DropIndex) = []; %% Drop pulse of length 0 

UnsortedEventTime = [SortSeq(1,:), SortSeq(1,:) + SortSeq(2,:);... 
                     SortSeq(3:end,:), -SortSeq(3:end,:)]; %% Shows all times where a pulse is changed 

EventTimeLong = (sortrows(UnsortedEventTime', 1))'; %% Order events times to be increasing time 

EventTime = [EventTimeLong(:,1)]; 
LastTime = EventTimeLong(1,1); 
for kk = 2:size(EventTimeLong,2) 
    
    if EventTimeLong(1,kk) ==  LastTime 
        EventTime(2:end,end) = EventTime(2:end,end) + EventTimeLong(2:end,kk); %% if more than one channal changes at the same time 
    else 
        EventTime = [EventTime, [0; EventTime(2:end,end)] + EventTimeLong(:,kk)]; %% if only one channal changes 
    end 
    
end 

if EventTime(1,1) ~= 0 %% To start pulse sequence at time = 0 
    EventTime = [zeros(7,1), EventTime]; 
end 

FinalSequence = [EventTime(1,2:end)-EventTime(1,1:end-1); EventTime(2:end,1:end-1)]'; %% convert back to sequence with pulse duration  

delmat=find(FinalSequence(:,1)==0); %% find pulses of duration 0 

FinalSequence(delmat,:) = []; %% Drop pulses of duration 0 

FinalSequence(:,4:end)=sign(FinalSequence(:,4:end));
%FinalSequence(:,2)=FinalSequence(:,2)/max([FinalSequence(:,2); 1e-9]);
%FinalSequence(:,3)=FinalSequence(:,3)/max([FinalSequence(:,3); 1e-9]);
FinalSequence=[[0 FinalSequence(1,2:end)];FinalSequence];

%%%%%% Convert to clock times %%%%%% 
%FinalSequence(:,1) = FinalSequence(:,1) * gIsoySamplingRateSM; 

%concatenate maveform description
FinalSequence2=FinalSequence(1,:);
for kk=2:size(FinalSequence,1)
    if FinalSequence(kk,2:end)==FinalSequence(kk-1,2:end)
        FinalSequence2(end,1)=FinalSequence2(end,1)+FinalSequence(kk,1);
    else
        FinalSequence2=[FinalSequence2;FinalSequence(kk,:)];
    end
end

FinalSequence=FinalSequence2;

end 

function Seq_Cell = AutoConvert2Loops(FinalSequence,thres)

global Inputs

%find parts that can be substituted by repeating wafeform
newcell=0; %indicates if new cell should be created in next iteration

if FinalSequence(1,1)>=thres && mod(FinalSequence(1,1),128)==0 %check if chunk is longer than threshold and multiple of 128ns
    Seq_Cell{1} = CreateLoopSeq(FinalSequence(1,:));
    newcell=1;
elseif FinalSequence(1,1)>=thres
    Seq_Cell{1}=[mod(FinalSequence(1,1),128)+128 FinalSequence(1,2:end)];
    Inputs.Loops(1)=1; 
    Seq_Cell{2} = CreateLoopSeq([floor(FinalSequence(1,1)/128-1)*128 FinalSequence(1,2:end)]);
    newcell=1;
else
    Seq_Cell{1}=FinalSequence(1,:);
    Inputs.Loops(1)=1;   
end

for kk=2:size(FinalSequence,1)
    if FinalSequence(kk,1)>=thres && mod(FinalSequence(kk,1),128)==0 %check if chunk is longer than threshold and multiple of 128ns
        Seq_Cell{end+1} = CreateLoopSeq(FinalSequence(kk,:));
        newcell=1;
    elseif FinalSequence(kk,1)>=thres
        if newcell==1
            Seq_Cell{end+1} = [mod(FinalSequence(kk,1),128)+128 FinalSequence(kk,2:end)];
            Inputs.Loops(end+1)=1;
        else
            Seq_Cell{end} = [Seq_Cell{end};[mod(FinalSequence(kk,1),128)+128 FinalSequence(kk,2:end)]];
        end      
        Seq_Cell{end+1} = CreateLoopSeq([floor(FinalSequence(kk,1)/128-1)*128 FinalSequence(kk,2:end)]);
        newcell=1;        
    else
        if newcell==1
            Seq_Cell{end+1} = FinalSequence(kk,:);
            Inputs.Loops(end+1)=1;
        else
            Seq_Cell{end} = [Seq_Cell{end};FinalSequence(kk,:)];
        end
        newcell=0;
    end
end

% add clever looping over repetitive sequences for I
cc_thres=0.5e3;
cc_enable=0;

uu=1;
clc=0;
while uu<=length(Seq_Cell) && cc_enable
    subseq=Seq_Cell{uu};
    if sum(subseq(:,1)) >= cc_thres && length(subseq(:,1)) >= 16
        
        %%%chop up finer
        
        %get nonzero elements in MW
        %mw_seq = subseq(find(subseq(:,2)),2);
        mw_1_i = subseq(find(subseq(:,2)),2);
        mw_1_q = subseq(find(subseq(:,4)),4);
        mw_2_i = subseq(find(subseq(:,3)),3);
        mw_2_q = subseq(find(subseq(:,6)),6);
        
        for mm=1:4
            if mm==1 
                mw_seq=mw_1_i;
                seq_ind=2;
            elseif mm==2
                 mw_seq=mw_1_q;
                 seq_ind=4;
            elseif mm==3 
                 mw_seq=mw_2_i;
                 seq_ind=3;
            else 
                 mw_seq=mw_2_q;
                 seq_ind=6;
            end
        %most frequenty entry
        [m f]=mode(mw_seq);
        %check if more than 3 times
        if f>=3
            %third minus second occurence
            ind=find(subseq(:,seq_ind)==m);
            step=ind(3)-ind(2)-1;
            %check how many after are the same
            loop_seq=subseq(ind(2):ind(2)+step,seq_ind);
            tot_loop_seq=subseq(ind(2):ind(2)+step,:);
            n_occur=0;
            kk=1;
            f_occur=0;
            n_occur_max=0;
            while kk<=length(subseq(:,seq_ind))-step
                if isequal(round(subseq(kk:kk+step,:)*1e3)*1e-3,round(tot_loop_seq*1e3)*1e-3)
                    if ~f_occur
                        f_occur = kk;
                    end
                    n_occur=n_occur+1;
                    n_occur_max=max(n_occur,n_occur_max);
                    kk=kk+step+1;
                else
                    n_occur=0;
                    kk=kk+1;
                end
                
            end
            time_of_rep=sum(subseq(ind(2):ind(2)+step,1));
            if n_occur_max>=3 && time_of_rep >= 64
                if ~clc
                    disp('Using clever loop conversion...')
                    clc=1;
                end
                %create correct sequence
                New_Seq_Cell{1}=subseq(1:f_occur-1,:);
                New_Seq_Cell{2}=subseq(ind(2):ind(2)+step,:);
                New_Seq_Cell{3}=subseq(f_occur+(step+1)*n_occur_max:end,:);
                %take care of edge cases
                if uu==1
                    Seq_Cell_temp2={Seq_Cell{uu+1:end}};
                    Seq_Cell=[New_Seq_Cell Seq_Cell_temp2];
                    
                    Loops_temp2=Inputs.Loops(uu+1:end);
                    Inputs.Loops=[1 n_occur_max 1 Loops_temp2];
                elseif uu==length(Seq_Cell)
                    Seq_Cell_temp1={Seq_Cell{1:uu-1}};
                    Seq_Cell=[Seq_Cell_temp1 New_Seq_Cell];
                    
                    Loops_temp1=Inputs.Loops(1:uu-1);
                    Inputs.Loops=[Loops_temp1 1 n_occur_max 1];
                else 
                    Seq_Cell_temp1={Seq_Cell{1:uu-1}};
                    Seq_Cell_temp2={Seq_Cell{uu+1:end}};
                    Seq_Cell=[Seq_Cell_temp1 New_Seq_Cell Seq_Cell_temp2];
                    
                    Loops_temp1=Inputs.Loops(1:uu-1);
                    Loops_temp2=Inputs.Loops(uu+1:end);
                    Inputs.Loops=[Loops_temp1 1 n_occur_max 1 Loops_temp2];
                end
                %stop evaluating other channels
                break;
            end
        end
        end
        
    end
  uu=uu+1;  
end

% % add clever looping over repetitive sequences for Q
% uu=1;
% clc=0;
% while uu<=length(Seq_Cell) && cc_enable
%     subseq=Seq_Cell{uu};
%     if sum(subseq(:,1)) >= cc_thres && length(subseq(:,1)) >= 16
%         
%         %%%chop up finer
%         
%         %get nonzero elements in MW
%         mw_seq = subseq(find(subseq(:,4)),4);
%         
%         %most frequenty entry
%         [m f]=mode(mw_seq);
%         %check if more than 4 times
%         if f>=4
%             %third minus second occurence
%             ind=find(subseq(:,4)==m);
%             step=ind(3)-ind(2)-1;
%             %check how many after are the same
%             loop_seq=subseq(ind(2):ind(2)+step,4);
%             tot_loop_seq=subseq(ind(2):ind(2)+step,:);
%             n_occur=0;
%             kk=1;
%             f_occur=0;
%             while kk<=length(subseq(:,4))-step
%                 if isequal(round(subseq(kk:kk+step,:)*1e3)*1e-3,round(tot_loop_seq*1e3)*1e-3)
%                     if ~f_occur
%                         f_occur = kk;
%                     end
%                     n_occur=n_occur+1;
%                     kk=kk+step+1;
%                 else
%                     kk=kk+1;
%                 end
%             end
%             time_of_rep=sum(subseq(ind(2):ind(2)+step,1));
%             if n_occur>=4 && time_of_rep >= 64
%                 if ~clc
%                     disp('Using clever loop conversion...')
%                     clc=1;
%                 end
%                 %create correct sequence
%                 New_Seq_Cell{1}=subseq(1:f_occur-1,:);
%                 New_Seq_Cell{2}=subseq(ind(2):ind(2)+step,:);
%                 New_Seq_Cell{3}=subseq(f_occur+(step+1)*n_occur:end,:);
%                 %take care of edge cases
%                 if uu==1
%                     Seq_Cell_temp2={Seq_Cell{uu+1:end}};
%                     Seq_Cell=[New_Seq_Cell Seq_Cell_temp2];
%                     
%                     Loops_temp2=Inputs.Loops(uu+1:end);
%                     Inputs.Loops=[1 n_occur 1 Loops_temp2];
%                 elseif uu==length(Seq_Cell)
%                     Seq_Cell_temp1={Seq_Cell{1:uu-1}};
%                     Seq_Cell=[Seq_Cell_temp1 New_Seq_Cell];
%                     
%                     Loops_temp1=Inputs.Loops(1:uu-1);
%                     Inputs.Loops=[Loops_temp1 1 n_occur 1];
%                 else
%                     Seq_Cell_temp1={Seq_Cell{1:uu-1}};
%                     Seq_Cell_temp2={Seq_Cell{uu+1:end}};
%                     Seq_Cell=[Seq_Cell_temp1 New_Seq_Cell Seq_Cell_temp2];
%                     
%                     Loops_temp1=Inputs.Loops(1:uu-1);
%                     Loops_temp2=Inputs.Loops(uu+1:end);
%                     Inputs.Loops=[Loops_temp1 1 n_occur 1 Loops_temp2];
%                 end
%             end
%         end
%         
%     end
%   uu=uu+1;  
% end

if max(Inputs.Loops)>=65000 %maximum 65,000 repetitions allowed in sequence mode
    disp('CAUTION no conversion performed, at least one of the chunks is too long with 50ns base length. can be changed in code')
    clear Seq_Cell
    Seq_Cell{1}=FinalSequence;
elseif num2str(length(Seq_Cell))>16000 %maximum 16,000 steps allowed in sequence mode
    disp(['CAUTION no conversion performed, Sequence too many steps for auto conversion: ' num2str(length(Seq_Cell)) ' steps'])
    clear Seq_Cell
    Seq_Cell{1}=FinalSequence;    
else
    disp(['Auto conversion performed: ' num2str(length(Seq_Cell)) ' sequence steps'])
    Inputs.SeqSteps=length(Seq_Cell);
end

end

function PBSeq = Conv2PBSeq(SeqPar)

%%%%%% Convert to start stop time %%%%%%
Seq = SeqPar';

Seq = [Seq(:,1), 2.^Seq(:,3);...
    Seq(:,1) + Seq(:,2), -2.^Seq(:,3)];

%%%%%% Order sequaence for increasing time %%%%%%
Seq = sortrows(Seq);
Seq = [Seq(:,1), cumsum(Seq(:,2))];

Seq = [Seq(1:end-1,2), Seq(1:(end-1),1), Seq(2:end,1) - Seq(1:(end-1),1)];

%add 0 at start
if (Seq(1,2)>0)
   Seq=[[0 0 Seq(1,2)];Seq];
end

clock = 5; % ns, shortest possible pulse
Seq = [Seq(:,1), round(Seq(:,2)/clock)*clock, round(Seq(:,3)/clock)*clock];

Seq(Seq(:,3) == 0,:) = [];

%%%%%% Convert sequaence to delay list %%%%%%
PBSeq = [];
for kk = 1:size(Seq,1)
    
    dt = Seq(kk,3);
    
    if Seq(kk,3) > 2*640,
        PBSeq = [PBSeq;...
            Seq(kk,1), {'LONG_DELAY'}, floor(dt/640), 640, {'ON'};...
            Seq(kk,1), {'CONTINUE'}, 0, dt - 640*floor(dt/640), {'ON'}];
    end
    
    if Seq(kk,3) <= 640
        PBSeq = [PBSeq;...
            Seq(kk,1), {'CONTINUE'}, 0, dt, {'ON'}];
    end
    
    if Seq(kk,3) > 640 && Seq(kk,3) <= 2*640
        PBSeq = [PBSeq;...
            Seq(kk,1), {'CONTINUE'}, 0, 640, {'ON'};...
            Seq(kk,1), {'CONTINUE'}, 0, dt - 640*floor(dt/640), {'ON'}];
    end
    
end

end

function Matrix = OneM(k, n1, n2) 

Matrix = zeros(n1,n2); 
Matrix(k,:) = ones(1,n2); 

end 

function Plot_PB_Sequence() 

global Inputs
if Inputs.bSweepwf
    global PB_Seq_total
    for i = 1:length(PB_Seq_total)-1
        PB_Seq_total{i+1}(1,:) = PB_Seq_total{i+1}(1,:) + PB_Seq_total{i}(2,end) + PB_Seq_total{i}(1,end);
    end
    SeqPar = cell2mat(PB_Seq_total');
else
    global PB_Seq
    SeqPar = PB_Seq;
end

%eliminate 0 duration pulses
SeqPar(:,SeqPar(2,:)==0) = [];

% y mapping
mapping = [unique(SeqPar(3,:));[1:length(unique(SeqPar(3,:)))]];

Min = 0;%min(SeqPar(1,:))*1e-3; 
Max = max(SeqPar(1,:)+SeqPar(2,:))*1e-3; 

figure(125) 
clf(125) 
label_vec=[];
%label_str=[];
for kk = (1:size(SeqPar,2)) 
    
    x = [SeqPar(1,kk), (SeqPar(1,kk)+SeqPar(2,kk))]*1e-3; 
    y_map = mapping(2,mapping(1,:)==SeqPar(3,kk));
    y = y_map * [1, 1]; 
    
    hold on 
    
    %%% don't use area function in matlab 2014-16 %%%
%     area(x, y + .8, 'FaceColor','b','BaseValue',y(1)) 
    fill([x, fliplr(x)], [y + .8,  y(1)*ones(1,length(y))],'b')
    plot([Min, Max], [y(1), y(1)]) 
    %text(Min-(Max-Min)/10,y(1)+0.4,['PB' num2str(round(y(1)))])
    hold off 
    if (kk==1 || label_vec(end)~=y(1)+0.4) &&  (sum(label_vec==y(1)+0.4)==0)
    label_vec(end+1)=y(1)+0.4;
    end
   % label_str(kk)=y(1);
   
    if mod(round(kk/size(SeqPar,2)*10)/10,10) == 0 && mod(round(kk/size(SeqPar,2)*10)/10,10) ~= 0 
        disp([ num2str(round(kk/size(SeqPar,2)*10)/10) ' % processed for the sequence plot'])
    end
end 

label_vec=sort(label_vec);

hold on 
plot(x,y) 
hold off  
title('PB - Sequence')
xlabel('time (\mus)')

figure(125)
set(gca,'YTick',label_vec)
labels=[];
for kk=1:length(label_vec)
    pb_nr = mapping(1,mapping(2,:)==round(label_vec(kk)-0.4));
    labels{kk}=['PB' num2str(round(pb_nr))];
end
set(gca,'YTickLabel',labels)

maxt=max(SeqPar(1,:)+SeqPar(2,:))*1e-3;
xlim([0-maxt/20 maxt+maxt/20])

ylim([0.8 max(mapping(2,:))+1])

end

function Plot_AWG_Sequence()

global Inputs  
SamplingRate = Inputs.SamplingRate; 

clf(figure(124))
figure(124)
hold on 

for mm=1:length(Inputs.Seq_Cell)

xoff=0;
for u=1:mm-1
    seq_mat=Inputs.Seq_Cell{u};
    xoff = xoff+sum(seq_mat(:,1))*Inputs.Loops(u);
end

AWGseq = Inputs.Seq_Cell{mm};
baretime=sum(AWGseq(:,1));
AWG_subseq=AWGseq;
for v=2:Inputs.Loops(mm)
AWGseq=[AWGseq;AWG_subseq];
end

t = 0; 
SumAWGseq = [zeros(size(AWGseq)); zeros(size(AWGseq))];


for kk = 1:size(AWGseq,1)-1 
     
    t = t + AWGseq(kk,1); 
    
    SumAWGseq(2*kk-1,1) = t;
    SumAWGseq(2*kk,1) = t; 
    
    SumAWGseq(2*kk-1,2:end) = AWGseq(kk,2:end); 
    SumAWGseq(2*kk,2:end) = AWGseq(kk+1,2:end); 
    
end 

%account for steps before first defined point
SumAWGseq=[[0 AWGseq(1,2:end)];SumAWGseq];

% SumAWGseq(end-1:end,:) = []; 
t = t + AWGseq(end,1);
SumAWGseq(end-1,1) = t;
SumAWGseq(end,1) = t;
SumAWGseq(end-1,2:end) = AWGseq(end,2:end); 
SumAWGseq(end,2:end) = AWGseq(end,2:end);

SumAWGseq(:,1) = SumAWGseq(:,1);% / SamplingRate; %% Convert back from clock cycles to ns 

%plot loop counter
nLoops=Inputs.Loops(mm);
if nLoops>1
    if mod(mm,2) == 0
        plot((xoff+SumAWGseq(:,1))/1e3,SumAWGseq(:,1)*0+6.8,'-k') 
        text((xoff)/1e3,7,[num2str(baretime) 'ns x ' num2str(nLoops)])
    else
        plot((xoff+SumAWGseq(:,1))/1e3,SumAWGseq(:,1)*0+7,'-k')        
        text((xoff)/1e3,7.2,[num2str(baretime) 'ns x ' num2str(nLoops)])
    end
end


%figure(124) 
% area((xoff+SumAWGseq(:,1))/1e3, SumAWGseq(:,2), 'EdgeColor','r', 'FaceColor','r', 'BaseValue',0)
% % hold on
% area((xoff+SumAWGseq(:,1))/1e3, SumAWGseq(:,3)+1.1, 'EdgeColor','g', 'FaceColor','g','BaseValue',1.1) 
% area((xoff+SumAWGseq(:,1))/1e3, SumAWGseq(:,4)+2.2, 'EdgeColor','b', 'FaceColor','b','BaseValue',2.2) 
% area((xoff+SumAWGseq(:,1))/1e3, SumAWGseq(:,5)+3.3, 'EdgeColor','m', 'FaceColor','m','BaseValue',3.3) 
% area((xoff+SumAWGseq(:,1))/1e3, SumAWGseq(:,6)+4.4, 'EdgeColor','c', 'FaceColor','c','BaseValue',4.4) 
% area((xoff+SumAWGseq(:,1))/1e3, SumAWGseq(:,7)+5.5, 'EdgeColor','k', 'FaceColor','k','BaseValue',5.5) 

plot((xoff+SumAWGseq(:,1))/1e3, SumAWGseq(:,2), '-r') 
plot((xoff+SumAWGseq(:,1))/1e3, SumAWGseq(:,3)+1.1, '-g') 
plot((xoff+SumAWGseq(:,1))/1e3, SumAWGseq(:,4)+2.2, '-b') 
plot((xoff+SumAWGseq(:,1))/1e3, SumAWGseq(:,5)+3.3, '-m') 
plot((xoff+SumAWGseq(:,1))/1e3, SumAWGseq(:,6)+4.4,'-c') 
plot((xoff+SumAWGseq(:,1))/1e3, SumAWGseq(:,7)+5.5, '-k') 

fill([(xoff+SumAWGseq(:,1))'/1e3, fliplr((xoff+SumAWGseq(:,1))'/1e3)],[SumAWGseq(:,2)'+0, 0*ones(length(SumAWGseq(:,2)),1)'], 'r') 
fill([(xoff+SumAWGseq(:,1))'/1e3, fliplr((xoff+SumAWGseq(:,1))'/1e3)],[SumAWGseq(:,3)'+1.1, 1.1*ones(length(SumAWGseq(:,3)),1)'], 'g') 
fill([(xoff+SumAWGseq(:,1))'/1e3, fliplr((xoff+SumAWGseq(:,1))'/1e3)],[SumAWGseq(:,4)'+2.2, 2.2*ones(length(SumAWGseq(:,4)),1)'], 'b') 
fill([(xoff+SumAWGseq(:,1))'/1e3, fliplr((xoff+SumAWGseq(:,1))'/1e3)],[SumAWGseq(:,5)'+3.3, 3.3*ones(length(SumAWGseq(:,5)),1)'], 'm') 
fill([(xoff+SumAWGseq(:,1))'/1e3, fliplr((xoff+SumAWGseq(:,1))'/1e3)],[SumAWGseq(:,6)'+4.4, 4.4*ones(length(SumAWGseq(:,6)),1)'], 'c') 
fill([(xoff+SumAWGseq(:,1))'/1e3, fliplr((xoff+SumAWGseq(:,1))'/1e3)],[SumAWGseq(:,7)'+5.5, 5.5*ones(length(SumAWGseq(:,7)),1)'], 'k') 

% hold off 

if mod(mm,50)==0
disp(['calculating plot: ' num2str(mm) '/' num2str(length(Inputs.Seq_Cell))])
end

end
disp('calculating plot: done')

ylim([-1.1 7.5])
figure(124)
title('AWG - Sequence')
xlabel('time (\mus)')

set(gca,'YTick', [0 1.1 2.2 3.3 4.4 5.5])
set(gca,'YTickLabel',{'MW1 - I (A1)' 'MW2 - I (A2)' 'MW1 - Q (M1)' 'MW2 - Q (M2)' 'dummy (M3)' 'dummy (M4)'})

hold off 

end 

function Sequence = CreateLoopSeq(Seq)

 global Inputs

 nLoop = round(Seq(1)/128);
 
 if round(Seq(1)/128)~=Seq(1)/128
     disp('CAREFUL, I am rounding!!!')
 end
  
 Inputs.Loops(end+1) = nLoop;
             
 Sequence = [128 Seq(2:end)];          
            
end

function memory = LengthOfTotWF(Seq_Cell,SamplingRate)

memory = 0;
for kk = 1:length(Seq_Cell)
    curr_seq = Seq_Cell{kk};
    memory = memory + sum(curr_seq(:,1));
end
memory = memory * SamplingRate;

end

function tInSec = lengthSequence(CMD)

    LoopFactor = 1;
    dt = 0;
    t = 0;
    for kk = (1:length(CMD))
        switch cell2mat(CMD(kk,2))
            case 'LOOP'
                LoopFactor = cell2mat(CMD(kk,3));
            case 'CONTINUE'
                dt = cell2mat(CMD(kk,4));
            case 'LONG_DELAY'
                nLongDelay = cell2mat(CMD(kk,3));
                dt = nLongDelay * 640;
            otherwise
        end
        t = t + dt;
    end
    
    tInSec = LoopFactor * t * 10^-9;

end