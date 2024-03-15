function varargout=ImageESRFunctionPool(varargin)

switch varargin{1}
    case 'Init'
        Init;
    case 'Run'
        Run;
    case 'SaveSweep'
        SaveSweep;
end

function Init
% Maybe don't need this.

function Run
global gConfocal gmSEQ gESR

% Construct a questdlg
choice = questdlg('Please confirm that the average number of iterations on Experiment_PB_DAQ is set to a reasonable number.', ...
	'Don''t integrate forever', ...
	'OK','Cancel','OK');
% Handle response
switch choice
    case 'OK'
    case 'Cancel'
        gESR.bGo=0;
        return
end

% get the handle of Gui1
h = findobj('Tag','ExperimentGUI');

% if exists (not empty)
if ~isempty(h)
% get handles and other user-defined data associated to Gui1
    handles_Experiment = guidata(h);
end

% get the handle of Gui1
h2 = findobj('Tag','ImageNVCGUI');

% if exists (not empty)
if ~isempty(h2)
% get handles and other user-defined data associated to Gui1
    handles_ImageNVC = guidata(h2);
end
% Get relevant sequence parameters (particularly gmSEQ.NSweepParam)
ExperimentFunctionPool('LoadUserInputs',0,0,handles_Experiment);
InitializeData(handles_Experiment);
gESR.SweepParam=gmSEQ.SweepParam;
%Consider rewriting ExperimentFunctionPool s.t. it calls InitializeData
%separately from RunSequence. Then, you can redefine the average number to
%be 1 to avoid running an infinite averaging sequence.

% Prepare vectors corresponding to X,Y,Z scan directions
planScan=PlanScan;
% 

BackupImageFile=PortMap('BackupImageFile');

for k=1:gESR.NVz
    ImageFunctionPool('WriteVoltage',0,0,0,3,planScan.SweepVz(k));
    for j=1:gESR.NVy
        if strcmp(gESR.direction,'Cartesian')
            ImageFunctionPool('WriteVoltage',0,0,0,2,planScan.SweepVy(j)+gConfocal.YOffSet);
        
        end
        
        for i=1:gESR.NVx
            ImageFunctionPool('WriteVoltage',0,0,0,1,planScan.SweepVx(i)+gConfocal.XOffSet);
            
            if strcmp(gESR.direction,'Diagonal XY')
                ImageFunctionPool('WriteVoltage',0,0,0,2,planScan.SweepVy(i)+gConfocal.YOffSet);
                disp(['Sweeping sequence at location (', num2str(planScan.SweepVx(i)),', ', num2str(planScan.SweepVy(i)),', ',num2str(planScan.SweepVz(k)),')'])
            else
                disp(['Sweeping sequence at location (', num2str(planScan.SweepVx(i)),', ', num2str(planScan.SweepVy(j)),', ',num2str(planScan.SweepVz(k)),')'])
            end
            
            %DrawCrossHairs(handles_ImageNVC,[planScan.SweepVx(i)
            %planScan.SweepVy(j) planScan.SweepVz(k)]); % This isn't
            %working yet.
            
            
            % Run ESR sequence
            gmSEQ.bGo=0; % this is to prevent ExperimentFunctionPool from thinking a sequence already is happening
            ExperimentFunctionPool('Run',0,0,handles_Experiment);
            % Store data into separate global variable of size (Nx,Ny,Nz,NSweepParam)
            if strcmp(gmSEQ.name,'ESR')
                
                if strcmp(gESR.direction,'Diagonal XY')
                    gESR.data(i,1,k,:)=gmSEQ.signal;
                else
                    gESR.data(i,j,k,:)=gmSEQ.signal;
                end
            else
                gESR.data(i,j,k,:)=ExperimentFunctionPool('Normalize',0,[],[]);
                if strcmp(gESR.direction,'Diagonal XY')
                    gESR.data(i,1,k,:)=gmSEQ.signal;
                else
                    gESR.data(i,j,k,:)=gmSEQ.signal;
                end
            end
            
            drawnow;
            if ~gESR.bGo, break; end
        end
        Rescan;
        TemporarySave(BackupImageFile);
        if ~gESR.bGo || strcmp(gESR.direction,'Diagonal XY'), break; end
    end
    if ~gESR.bGo, break; end
end
gESR.data=squeeze(gESR.data);

%ImageFunctionPool('WriteVoltage',0,0,0,1,gConfocal.XOffSet);
%ImageFunctionPool('WriteVoltage',0,0,0,2,gConfocal.YOffSet);
%ImageFunctionPool('WriteVoltage',0,0,0,3,50);

gESR.bGo=0;
disp('ESR sweep completed.');
% ImageESR should set gESR.bGo=1; Should prepare gESR.max/min/N; 


function planScan=PlanScan
global gESR gmSEQ
gESR.sweep=[];
if ~gESR.bFixVx
    planScan.SweepVx=gESR.minVx:(gESR.maxVx-gESR.minVx)/(gESR.NVx-1):gESR.maxVx;
    gESR.sweep=[gESR.sweep 'x'];
else
    planScan.SweepVx=gESR.FixVx;
    gESR.NVx=1;
end

if ~gESR.bFixVy
    planScan.SweepVy=gESR.minVy:(gESR.maxVy-gESR.minVy)/(gESR.NVy-1):gESR.maxVy;
    gESR.sweep=[gESR.sweep 'y'];
else
    planScan.SweepVy=gESR.FixVy;
    gESR.NVy=1;
end

if ~gESR.bFixVz
    planScan.SweepVz=gESR.minVz:(gESR.maxVz-gESR.minVz)/(gESR.NVz-1):gESR.maxVz;
    gESR.sweep=[gESR.sweep 'z'];
else
    planScan.SweepVz=gESR.FixVz;
    gESR.NVz=1;
end
if strcmp(gESR.direction,'Diagonal XY')
    gESR.data=(NaN(gESR.NVx,1,gESR.NVz,gmSEQ.NSweepParam));
else
    gESR.data=(NaN(gESR.NVx,gESR.NVy,gESR.NVz,gmSEQ.NSweepParam));
end


function DrawCrossHairs(handles, vec)
global gScan

% get the current limits of the axes1
XLimits = get(handles.axes1,'XLim');
YLimits = get(handles.axes1,'YLim');

p.x = vec(1);
p.y = vec(2);

% draw two lines
if isfield(gScan,'xLineHandle')
    if ishandle(gScan.xLineHandle)
        set(gScan.xLineHandle,'XData',[XLimits(1),XLimits(2)]);
        set(gScan.xLineHandle,'YData',[p.y p.y]);
    else
        gScan.xLineHandle = line(handles.axes1,[XLimits(1),XLimits(2)],[p.y p.y],[1,1]);
    end
else
    gScan.xLineHandle = line(handles.axes1,[XLimits(1),XLimits(2)],[p.y p.y],[1,1]);
end


if isfield(gScan,'yLineHandle')
    if ishandle(gScan.yLineHandle)
        set(gScan.yLineHandle,'XData',[p.x p.x]);
        set(gScan.yLineHandle,'YData',[YLimits(1),YLimits(2)]);
    else
        gScan.yLineHandle = line(handles.axes1,[p.x p.x],[YLimits(1),YLimits(2)],[1,1]);
    end
else
    gScan.yLineHandle = line(handles.axes1,[p.x p.x],[YLimits(1),YLimits(2)],[1,1]);
end

function SaveSweep
global gESR

% Map the squeezed data matrix to the corresponding
% parameters
gESR.sweep;
% Things to save: min/max/N for all spatial coordinates, NSweepParam

function Rescan
     % get the handle of Gui1
     h = findobj('Tag','ImageNVCGUI');

     % if exists (not empty)
     if ~isempty(h)
        % get handles and other user-defined data associated to Gui1
        handles_ImageNVC = guidata(h);
     end
     ImageFunctionPool('Scan',0, 0, handles_ImageNVC);
     ImageFunctionPool('Save',0, 0, handles_ImageNVC);
     
     	
function TemporarySave(BackupFile)
global gESR gmSEQ

% convert relevant globals to a bigger structure
BackupExp.gmSEQ=gmSEQ;
BackupExp.gESR=gESR;
%save the data in matlab binary format
save(BackupFile,'BackupExp');