function WidefieldFunctionPool(varargin)

switch varargin{1}
    case 'InitGUI'
        InitGUI;
    case 'Run'
        Run(varargin{2:3});
    case 'Close'
        Close;
    case 'DisplaySpectra'
        DisplaySpectra(varargin{2:end});
    case 'DisplayImage'
        DisplayImage(varargin{2});
    case 'InitParams'
        InitParams;
end

function InitGUI
    global lf
    Setup_LightField_Environment;
    lf = lfm(true); % prepares an instance of Lightfield; VISIBLE indicates that Lightfield will open alongside the MATLAB workstation.
    lf.load_experiment('rt2_wide');
    LoadNIDAQmx;% initialize NIDAQ
    % load SRS SG384 DLL
    SignalGeneratorFunctionPool('Init',PortMap('SG com'));
    % specify pixel-to-micron conversion
    % load PulseBlaster DLL 
    LoadPBESR;
function Run(axes,axes2)
global gWide lf gSG hCPS
try
    disp('Commencing widefield ESR...')
    % TURN ON AOM
    PBFunctionPool('PBON',2^SequencePool('PBDictionary','AOM'));
    % TURN ON SRS
    SignalGeneratorFunctionPool('WriteFreq');
    SignalGeneratorFunctionPool('WritePow');
    gSG.sweepRate=gWide.AcquisitionFrameRate/gWide.N;
    SignalGeneratorFunctionPool('SetMod');
    gSG.bOn=1; SignalGeneratorFunctionPool('RFOnOff');
    i=1;
    gWide.raw=NaN;
    while i<=gWide.Average
        
        % PREPARE PULSE TRAIN / ANALOG VOLTAGE
        %%%%% Pulse Train %%%%%
        %%%%% Analog write %%%%

        gWide.iAverage=i;
        % Prepare triggering signal on DAQ based on max frame rate
        [vec]=MakeSweepVector();
        [~, hCPS.hPulse] = DigPulseTrainCont(gWide.AcquisitionFrameRate,0.5,gWide.samps);
        [~, hCPS.hScan ] = DAQmxFunctionPool('WriteAnalogVoltage',PortMap('SG ext mod'),vec, gWide.samps,gWide.AcquisitionFrameRate);
        lf.set_frames(gWide.samps); % max is 10^9
        % PREPARE LIGHTFIELD TO SEE TRIGGERS
        lf.experiment.Acquire;
        % BEGIN TRIGGERS
        status = DAQmxStartTask(hCPS.hScan);  DAQmxErr(status);
        status = DAQmxStartTask(hCPS.hPulse);    DAQmxErr(status);
        DAQmxWaitUntilTaskDone(hCPS.hPulse,gWide.UpdateTime*1.1);
        
        DAQmxStopTask(hCPS.hScan);
        DAQmxStopTask(hCPS.hPulse);
        pause(2);
        raw=lf.readout;
        
        %TemporarySave(BackupFile);
        DAQmxClearTask(hCPS.hPulse);
        DAQmxClearTask(hCPS.hScan);

        if size(raw,3)~=gWide.samps
            disp(strcat('Size of data: ',num2str(size(gWide.raw,3))));
            disp(strcat('Expected samples: ',num2str(gWide.samps)));
            disp('Not all data was acquired. Redoing run.')
            drawnow;
            if ~gWide.bOn
                disp('Aborting widefield ESR...')
                break;
            end
            continue
        else
            if i==1
                gWide.signal=ProcessData(raw);
            else
                gWide.signal=(((i-1)*gWide.signal)+ProcessData(raw))/i;
            end
        end
        
        DisplaySpectra(axes2, gWide.dimension, gWide.x, gWide.y,axes);
        drawnow;
        % DELETE EXTRANEOUS FILES
%        file=lf.get(PrincetonInstruments.LightField.AddIns.ExperimentSettings.AcquisitionOutputFilesResult);
%        delete file
        if ~gWide.bOn
            disp('Aborting widefield ESR...')
            break;
        end
        i=i+1;
    end
catch ME
    KillAllTasks;
    gSG.bOn=0; SignalGeneratorFunctionPool('RFOnOff');
    rethrow(ME);
end
gSG.bOn=0; SignalGeneratorFunctionPool('RFOnOff');
% DISPLAY PLOTS

disp('Widefield ESR completed!')  
gWide.bOn=0;
  
function InitParams
% helper function for RUN
global gWide gSG lf
%lf.set_exposure(round(1/gWide.AcquisitionFrameRate*1000,3)-2);

%lf.set(PrincetonInstruments.LightField.AddIns.TriggerResponse,2);
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%FIX THIS%%%%%%%%%%%%%%%%%%%%%%%%
% Prepare sweep vector on analog output of NI DAQ
gSG.sweepDev=(gWide.To-gWide.From)/2;
gSG.Freq=(gWide.To+gWide.From)/2;



% If the boolean NORMALIZE is true, then prepare Thorlabs software to read photodiode approximately as fast as exposure timescale
gSG.bfixedPow=1;
gSG.bfixedFreq=0;
gSG.bMod='Sweep';
gSG.bModSrc='External';

function DisplaySpectra(spectraAxes,dimension,x,y,imageAxes,app)
global gWide
x=round(x);
y=round(y);
if gWide.PlotEnd==inf
    PlotEnd=length(gWide.SweepParam);
end
if gWide.PlotStart>gWide.PlotEnd || gWide.PlotStart>length(gWide.SweepParam)
    error('Plotting out of bounds')
end
mw=gWide.SweepParam(gWide.PlotStart:PlotEnd)/1e9;
cla(spectraAxes);
switch dimension
    case 'Point'
        data=squeeze(gWide.signal(x,y,gWide.PlotStart:PlotEnd));
        plot(spectraAxes, mw,data)
        if min(data)==max(data)
            ylim(spectraAxes,[min(data)-1 max(data)+1])
        else
            ylim(spectraAxes,[min(data) max(data)])
        end
        
        ylabel(spectraAxes,'Counts')
        spectraAxes.YDir = 'normal';
    case 'Vertical'
        data=squeeze(gWide.signal(x,:,gWide.PlotStart:PlotEnd));
        
        for i=1:size(data,1)
            data(i,:)=data(i,:)-mean(data(i,:));
            data(i,:)=data(i,:)/std(data(i,:));
        end
        
        imagesc(spectraAxes, mw, 1:size(data,1),data,[min(data,[],'all') max(data,[],'all')])
        
        ylim(spectraAxes,[1 size(data,1)])
        ylabel(spectraAxes,'Pixel')
    case 'Horizontal'
        data=squeeze(gWide.signal(:,y,gWide.PlotStart:PlotEnd));
        
        for i=1:size(data,1)
            data(i,:)=data(i,:)-mean(data(i,:));
            data(i,:)=data(i,:)/std(data(i,:));
        end
        
        
        imagesc(spectraAxes, mw, 1:size(data,1),data,[min(data,[],'all') max(data,[],'all')])
        ylim(spectraAxes,[1 size(data,1)])
        ylabel(spectraAxes,'Pixel')
end
xlim(spectraAxes,[mw(1) mw(end)])
DisplayImage(imageAxes)
UpdateSliders(app,size(gWide.signal,1),size(gWide.signal,2));

  % user can specify 0D or 1D cut of data to see subset of spectra
function Save
function Close
% CLOSE GUI
global lf
if lf.experiment.IsRunning
  error('LightField is still acquiring. Please stop LightField and try again.')
end
lf.close;

function [sigDatum] = ProcessData(varargin)
global gWide

AA=varargin{1};
N=gWide.N;
sigDatum=zeros(size(AA,1),size(AA,2),N);

for k=1:size(sigDatum,3)
    sigDatum(:,:,k)=sum(AA(:,:,k:N:end),3);
end

% if ~mod(gWide.iAverage,2)
%      sigDatum=flip(sigDatum,3);
% end
sigDatum=sigDatum/(gWide.samps/gWide.N);

function [vec]=MakeSweepVector
global gWide 
i=gWide.iAverage;
vec=-1:(2/(gWide.N-1)):1;
% if ~mod(i,2)
%     vec=-vec;
% end
sampsTemp=gWide.AcquisitionFrameRate*gWide.UpdateTime;
vec=repmat(vec,1,ceil(sampsTemp/gWide.N));
gWide.samps=length(vec);



function DisplayImage(axes)
global gWide
cla(axes)
data=squeeze(gWide.signal(:,:,2))';
imagesc(axes,data);
xlim(axes,[1 size(data,2)])
ylim(axes,[1 size(data,1)])
pbaspect(axes,[1 size(data,1)/size(data,2) 1]);

hold(axes,'on')
switch gWide.dimension
    case 'Point'
        x=round(gWide.x);
        y=round(gWide.y);
        line(axes,[x x], [1 size(data,1)], 'Color', 'r');
        line(axes,[1 size(data,2)],[y y], 'Color', 'r');
    case 'Vertical'
        x=round(gWide.x);
        line(axes,[x x], [1 size(data,1)], 'Color', 'r');
    case 'Horizontal'
        y=round(gWide.y);
        line(axes,[1 size(data,2)],[y y], 'Color', 'r');
end



set(axes,'colorscale','log')
colorbar(axes)