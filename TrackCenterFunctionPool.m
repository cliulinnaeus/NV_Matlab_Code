function [handles] = TrackCenterFunctionPool(what,handles)
%function [] = TrackCenterFunctionPool(what,handles)
%
% Function Pool for Tracking GUI
% jhodges/jmaze
% 2 Nov 2007

switch what,
    case 'Stop'
        Stop;
    case 'Apply'
        Apply(handles);
    case 'TrackCenterLogic',
        TrackCenterLogic(handles);
    case 'Test',
        InitTestVolume(handles);
    case 'Refresh'
        GetForm(handles);
    case 'Initialize'
        Initialize(handles);
end

function Stop
global gStop;
disp('Stopping')
gStop = 1;

function Apply(handles)
global gConfocal gScan gTracking gCounts;
Vx = gTracking.Vx(end) + gConfocal.XOffSet;
Vy = gTracking.Vy(end) + gConfocal.YOffSet;
Vz = gTracking.Vz(end);

status=DAQmxFunctionPool('WriteVoltages',...
                {'Dev1/ao0','Dev1/ao1','Dev1/ao2'},[Vx Vy Vz]);

gScan.FixVx = gTracking.Vx(end);
gScan.FixVy = gTracking.Vy(end);
gScan.FixVz = gTracking.Vz(end);

% added 18 May 2008, jhodges
% store the Applied Values locally for stability algorithm
gTracking.Trajectory = [gTracking.Trajectory; gScan.FixVx,gScan.FixVy,gScan.FixVz]

%%%% Write New position to file
filename = 'AfterTrackingPositions.txt';
path = 'C:\jmaze\matlab\Experiment\Data\Tracking\';
file = [path filename];
fid = fopen(file,'at');
fprintf(fid,'%s\t%+8.4f\t%+8.4f\t%+8.4f\t%+8.0f\n',datestr(now,'yyyy-mm-dd_HH:MM:SS'),...
    gScan.FixVx,gScan.FixVy,gScan.FixVz,gCounts);
fclose(fid)

            
function [] = PlotHistories(handles)
global gTracking
L = size(gTracking.Trajectory,1);
if L > 1,
    inds = [L-100:L];
    inds = inds(find(inds>0));
    plot(handles.axes6,gTracking.Trajectory(inds,1),'b.-');
    plot(handles.axes7,gTracking.Trajectory(inds,2),'r.-');
    plot(handles.axes8,gTracking.Trajectory(inds,3),'g.-');
end

function [] = TrackCenterLogic(handles)
global gTracking gScan gConfocal gCounts gStop;
%function [] = TrackCenterLogic(V,Step,StepMin,StepFactor,dwell,threshold)
%function [] = TrackCenterLogic(V,Step,StepMin,StepFactor,dwell,threshold,handles,hObject)

cla(handles.axes2);
cla(handles.axes3);
cla(handles.axes4);

% plot previously tracked points
PlotHistories(handles);

%% reset the status text
set(handles.statusText,'String','Tracking Started...');

%GetInitialPosition
Vx = gConfocal.XOffSet + gScan.FixVx;
Vy = gConfocal.YOffSet + gScan.FixVy;
Vz = gScan.FixVz; % Read the piezo
%VzOffSet = SerialFunctionPool('Read','YR?')

%Assign Trajectory Variables
TrajX = [];
TrajY = [];
TrajZ = [];
TrajI = [];

%Initial StepSize
StepX = gTracking.StepSize(1);
StepY = gTracking.StepSize(2);
StepZ = gTracking.StepSize(3);

% StepFactors
StepFactor = 0.5;
[StepXFactor] = StepFactor;
[StepYFactor] = StepFactor;
[StepZFactor] = StepFactor;

% StepMin
[StepXMin] = gTracking.MinStepSize(1);
[StepYMin] = gTracking.MinStepSize(2);
[StepZMin] = gTracking.MinStepSize(3);

counter = 0;
Samples = gTracking.Samples;
SamplingFreq = gTracking.SamplingFreq;
MaxSamples = gTracking.MaxSamples;
threshold = gTracking.Threshold;
maxIter = gTracking.MaxIteration;

set(handles.axes2,'FontSize',6);
set(handles.axes3,'FontSize',6);
set(handles.axes4,'FontSize',6);

% run the loop until one of the steps is below the minimum
gStop = 0;
while (~gStop & (counter < maxIter) & (StepX > StepXMin) & (StepY > StepYMin) & (StepZ > StepZMin)),
        counter = counter + 1;
        % Define the reference and six nearest points in parameter space
        NearestV(1,:) = [Vx,Vy,Vz] + [0,0,0];
        NearestV(2,:) = [Vx,Vy,Vz] + [StepX,0,0];
        NearestV(3,:) = [Vx,Vy,Vz] + [0,StepY,0];
        NearestV(4,:) = [Vx,Vy,Vz] + [0,0,StepZ];
        NearestV(5,:) = [Vx,Vy,Vz] + [-StepX,0,0];
        NearestV(6,:) = [Vx,Vy,Vz] + [0,-StepY,0];
        NearestV(7,:) = [Vx,Vy,Vz] + [0,0,-StepZ];
        if max(abs(NearestV(:,1:2)))> 0.7 
            disp('Galvo maximum voltage reached (X and/or Y)');
            return;
        elseif max(NearestV(:,3))> 8
            disp('Piezo maximum voltage reached (Z)');
            return;
        elseif min(NearestV(:,3)) < 0
            disp('Negative Piezo voltage reached');
            return;
        end
        
        
        % Take Counts at the 7 points

        for k=1:7,
            aSamples = Samples;
            status=DAQmxFunctionPool('WriteVoltages',...
                {'Dev1/ao0','Dev1/ao1','Dev1/ao2'},NearestV(k,:));
            
            [meanI, stdI] = DAQmxFunctionPool('GetCounts',SamplingFreq,Samples);
            meanI = meanI*SamplingFreq;
            stdI = stdI*SamplingFreq;
            if k==1
                gCounts = meanI;
            end
%             while (aSamples <= MaxSamples) & (stdI/meanI > threshold)
%                 %[meanI, stdI] = GetCounts(NearestV(k,:),SamplingFreq,aSamples,handles);
%                 [meanI, stdI] = DAQmxFunctionPool('GetCounts',SamplingFreq,Samples);
%                 meanI = meanI*SamplingFreq;
%                 stdI = stdI*SamplingFreq;
%                 aSamples=2*aSamples;
%                 fprintf('\nI = %f\t std = %f',meanI,stdI/meanI);
%             end
            %pause;
            I(k,1) = meanI;
        end
        % Take the difference between the reference and the nearest neighbors
        %axes(handles.axes5);
        bar(handles.axes5,I);
        set(handles.axes5,'FontSize',6);
        set(handles.axes5,'XTickLabel',{'V0','Vx','Vy','Vz','-Vx','-Vy','-Vz'});
        drawnow;
        deltaI = I - I(1);

        % Find all points above the threshold\
        [Inds] = find( deltaI > threshold);

        % update trajectories
        TrajX = [TrajX,Vx];
        TrajY = [TrajY,Vy];
        TrajZ = [TrajZ,Vz];
        TrajI = [TrajI, I(1)];
        % create a boolean mask for points above the threshold
        bThresh = zeros(7,1);
        bThresh(Inds) = 1;
        
        % 3D deformed to 1D steps
        stepVec = [1 StepX StepY StepZ -StepX -StepY -StepZ]';
        
        % calculate the Gradient Directions 
        gradVec = deltaI./stepVec.*bThresh;
        
        % If no points greater than threshold, keep orginal reference
        if  sum(bThresh)==0,
           % If Ref. Position did not change, reduce the step sizes
            StepX = StepX*StepXFactor;
            StepY = StepY*StepYFactor;
            StepZ = StepZ*StepZFactor;
            set(handles.statusText,'String',sprintf('Step Sized Reduced to [%0.3f,%0.3f,%0.3f]',StepX,StepY,StepZ));
            continue
        end

        % Update the reference position
        G = [gradVec(2) + gradVec(5),gradVec(3)+gradVec(6),gradVec(4) + gradVec(7)];
        VA = [Vx,Vy,Vz] + G/norm(G).*[StepX,StepY,StepZ];
        Vx = VA(1);
        Vy = VA(2);
        Vz = VA(3);
        
        % if called from the gui, update some of the guidata
        set(handles.Vx,'String',sprintf('%.4f',Vx-gConfocal.XOffSet));
        set(handles.Vy,'String',sprintf('%.4f',Vy-gConfocal.YOffSet));
        set(handles.Vz,'String',sprintf('%.4f',Vz));

        plot(handles.axes2,TrajX,TrajI,'kx-');
        plot(handles.axes3,TrajY,TrajI,'kx-');
        plot(handles.axes4,TrajZ,TrajI,'kx-');
        drawnow;
end % end main while loop

% update the status based on the loop exiting
statusString='';
if (counter > maxIter),
    statusString = 'Tracking Finished. Maximum Number of Iterations Reached.';
elseif ~((StepX > StepXMin) & (StepY > StepYMin) & (StepZ > StepZMin)),
    statusString = 'Tracking Finished. Step Size Minimum Reached.';
end
set(handles.statusText,'String',statusString);

gTracking.Vx = [gTracking.Vx Vx-gConfocal.XOffSet];
gTracking.Vy = [gTracking.Vy Vy-gConfocal.YOffSet];
gTracking.Vz = [gTracking.Vz Vz];
gTracking.I = [gTracking.I I(1)];
gTracking.DTStamp = [gTracking.DTStamp now];






function Initialize(handles);
global gx0 gxS gTracking;

gTracking.StepSize = [0.005 0.005 0.040];
gTracking.MinStepSize = [0.001 0.001 0.001];
gTracking.Threshold = 1000;
gTracking.MaxIteration = 30;
if ~isfield(gTracking,'Trajectory'),
    gTracking.Trajectory = [];
end
gTracking.WindowTime = 0.001;
gTracking.Samples = 500;
gTracking.MaxSamples = 100;
gTracking.SamplingFreq = 1000;
gTracking.DeadTime = 0.001;

gTracking.Vx = [];
gTracking.Vy = [];
gTracking.Vz = [];
gTracking.I = [];
gTracking.DTStamp = [];

set(handles.axes2,'FontSize',6);
set(handles.axes3,'FontSize',6);
set(handles.axes4,'FontSize',6);
set(handles.axes5,'FontSize',6);
set(handles.axes6,'FontSize',6);
set(handles.axes7,'FontSize',6);
set(handles.axes8,'FontSize',6);



% define test center and width\
function FillUpForm(handles)
global gTracking;
%initialize parametres
v = gTracking.StepSize;
set(handles.stepSize,'String',sprintf('[%.2f, %.2f, %.2f]',v(1),v(2),v(3)));
v = gTracking.MinStepSize;
set(handles.stepSizeMin,'String',sprintf('[%.2f, %.2f, %.2f]',v(1),v(2),v(3)));
set(handles.threshold,'String',gTracking.Threshold);
set(handles.maxIter,'String',gTracking.MaxIteration);
gTracking.MaxIteration = eval(get(handles.maxIter,'String'));

function GetFrom(handles)
global gTracking;

gTracking.StepSize = eval(get(handles.stepSize,'String'));
gTracking.MinStepSize = eval(get(handles.stepSizeMin,'String'));
gTracking.Threshold = eval(get(handles.threshold,'String'));
gTracking.MaxIteration = eval(get(handles.maxIter,'String'));

        
function [meanI, stdI] = GetCounts(V,SamplingFreq,Samples,handles)
global gx0 gxS;
% Take counts for a cooridinate in parameter space
% Average for a time <dwell>
x = V(1);
y = V(2);
z= V(3);
sx = gxS(1);
sy = gxS(2);
sz = gxS(3);
x0 = gx0(1);
y0 = gx0(2);
z0 = gx0(3);
I0 = 1e5; % rough CPS max value
I = I0*exp(-(x-x0)^2/sx/2)*exp(-(y-y0)^2/sy/2)*exp(-(z-z0)^2/sz/2);

% Generate some noise for the samples
R = poissrnd(floor(I),Samples,1);

meanR = mean(R);
stdR = std(R);
meanI = meanR;
stdI = stdR;







