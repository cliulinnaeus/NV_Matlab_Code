function PlannerFunctionPool(what,hObject, eventdata, handles)
%%%%%%%%%% Jeronimo Maze, Harvard University, June2008 %%%%%%%
switch what
    case {'Bx','By','Bz','B','Theta','Phi'}
        UpdateMagneticField(what,hObject, eventdata, handles);
    case {'CreateProject','LoadProject','SaveProject','SaveProjectAs'}
        Project(what,hObject, eventdata, handles);
    case {'RunProject','ProjectTask'}
        Project(what,hObject, eventdata, handles);
    case {'AddTask','TaskType','TaskName','DuplicateTask'}
        Task(what,hObject, eventdata, handles);
    case {'SaveTask','MoveTaskUp','MoveTaskDown','UpdateParam'}
        Task(what,hObject, eventdata, handles);
    case {'UpdateTaskFormTau','DeleteTask'}
        Task(what,hObject, eventdata, handles);
    case {'Param'} %Parameters related functions
        Parameters(what,hObject, eventdata, handles);
    case 'Initialize'
        Initialize(hObject, eventdata, handles);
    otherwise
        disp('Planner - I dont get it!');
end


function UpdateMagneticField(what,hObject, eventdata, handles)
SB.Bx = eval(get(handles.Bx,'String'));
SB.By = eval(get(handles.By,'String'));
SB.Bz = eval(get(handles.Bz,'String'));
SB.B = eval(get(handles.B,'String'));
SB.Theta = eval(get(handles.Theta,'String')) * pi / 180;
SB.Phi = eval(get(handles.Phi,'String')) * pi / 180;
switch what
    case 'Bx'
        SB.Bx = eval(get(handles.Bx,'String'));
        SB.B = sqrt(SB.Bx^2 + SB.By^2 + SB.Bz^2);
        if SB.B ~= 0, SB.Theta = acos(SB.Bz /SB.B);
        else, SB.Theta = 0; end
        SB.Phi = atan2(SB.By ,SB.Bx);
    case 'By'
        SB.By = eval(get(handles.By,'String')) ;
        SB.B = sqrt(SB.Bx^2 + SB.By^2 + SB.Bz^2);
        if SB.B ~= 0, SB.Theta = acos(SB.Bz /SB.B);
        else, SB.Theta = 0; end
        SB.Phi = atan2(SB.By ,SB.Bx );
    case 'Bz'
        SB.Bz = eval(get(handles.Bz,'String'));
        SB.B = sqrt(SB.Bx^2 + SB.By^2 + SB.Bz^2);
        if SB.B ~= 0, SB.Theta = acos(SB.Bz /SB.B);
        else, SB.Theta = 0; end
        SB.Phi = atan2(SB.By ,SB.Bx );
    case 'B'
        SB.B = eval(get(handles.B,'String'));
        SB.Bx = SB.B * sin(SB.Theta) * cos(SB.Phi); 
        SB.By = SB.B * sin(SB.Theta) * sin(SB.Phi);
        SB.Bz = SB.B * cos(SB.Theta) ;
    case 'Theta'
        SB.Theta = eval(get(handles.Theta,'String')) * pi/180;
        SB.Bx = SB.B * sin(SB.Theta) * cos(SB.Phi); 
        SB.By = SB.B * sin(SB.Theta) * sin(SB.Phi);
        SB.Bz = SB.B * cos(SB.Theta) ;
    case 'Phi'
        SB.Phi = eval(get(handles.Phi,'String')) * pi/180;
        SB.Bx = SB.B * sin(SB.Theta) * cos(SB.Phi); 
        SB.By = SB.B * sin(SB.Theta) * sin(SB.Phi);
        SB.Bz = SB.B * cos(SB.Theta) ;
    otherwise
        disp('UpdateMagneticField - doesnt get it!');
end
set(handles.Bx,'String',SB.Bx);
set(handles.By,'String',SB.By);
set(handles.Bz,'String',SB.Bz);
set(handles.B,'String',SB.B);
set(handles.Theta,'String',SB.Theta * 180 / pi);
set(handles.Phi,'String',SB.Phi * 180 / pi);
Task('UpdateParam',hObject, eventdata, handles);


function RunProject(hObject, eventdata, handles)
global gProject ghExp ghImg;

%ghImg = guihandles(ImageNVC);
ghExp = guihandles(Experiment);

NumTasks = length(gProject.Task);

for iTask = 1:NumTasks
    TaskType = gProject.Task(iTask).Type;
    Param = gProject.Task(iTask).Param;
    Param
    switch TaskType
        case 'CW'
            ApplyMagneticField(Param);            
            SetSignalGenerator(Param);
            LoadExperimentFile(TaskType);
            pause(1);
            SetMetaParameters(Param);
            pause(1);
            %SetSequenceParam(TaskType,Param);
            RunExperiment(TaskType,Param);
            SaveExperiment;
        case 'Rabi'
            %ApplyMagneticField(Param);            
            %SetSignalGenerator(Param);
            LoadExperimentFile(TaskType);
            SetMetaParameters(Param);
            SetSequenceParam(TaskType,Param);
            %RunSequence('Run',[], [], ghExp);
        case 'Ramsey'
            ApplyMagneticField(Param);            
            SetSignalGenerator(Param);
            LoadExperimentFile(TaskType);
            SetMetaParameters(Param);
            RunSequence('Run',[], [], ghExp);
        case 'T2'
            ApplyMagneticField(Param);            
            SetSignalGenerator(Param);
            LoadExperimentFile(TaskType);
            SetMetaParameters(Param);
            RunSequence('Run',[], [], ghExp);
        case 'T2*'
            ApplyMagneticField(Param);            
            SetSignalGenerator(Param);
            LoadExperimentFile(TaskType);
            SetMetaParameters(Param);
            RunSequence('Run',[], [], ghExp);
        case 'Magnetometry'
            ApplyMagneticField(Param);            
            SetSignalGenerator(Param);
            LoadExperimentFile(TaskType);
            SetMetaParameters(Param);
            RunSequence('Run',[], [], ghExp);
        otherwise
            disp('Planner Run - I dont get it!');
    end
end

function RunExperiment(TaskType,Param)
global ghExp ghESeq;
disp('Running Experiment...');
ghExp
RunSequence('Run',[], [], ghExp);
disp('Experiment Finished');


function SaveExperiment
global ghExp ghESeq;
ExperimentFunctionPool('MakeReportNew',[], [], ghExp);
ghReport = guihandles(Report);
disp('Saving Report...');
ReportFunctionPool('SaveReportNoGUI',[] ,[], ghReport);
disp('Report Saved');
close('Report');



function SetSequenceParam(TaskType,Param)
global ghExp ghESeq;

ghExp = guihandles(EditSequence);
EditgEditSEQ('TimeON',hObject, eventdata, handles)


function LoadExperimentFile(which)
global ghExp gExp;
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%This requires to modify ExperimentFunctionPool code
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
switch which
    case 'CW'
        gExp.file = 'ExpSet_CWb_2007-10-29.txt';
    case 'Rabi'
        gExp.file = 'ExpSet_RABI.txt';
    case 'Ramsey'
        gExp.file = 'ExpSet_T2T2STAR.txt';
    case 'T2*'
        gExp.file = 'ExpSet_T2T2STAR.txt';
    case 'T2'
        gExp.file = 'ExpSet_T2T2STAR.txt';
    case 'Magnetometry'
        gExp.file = 'ExpSet_T2T2STAR.txt';
    otherwise
end
gExp.path = 'Sets\Experiments\';
ExperimentFunctionPool('LoadExpFile',[], [], ghExp);

function SetMetaParameters(Param)
global ghExp ghImg;

set(ghExp.bTracking,'Value',Param.bTrackAlways);
set(ghExp.Samples,'String',Param.Samples);
set(ghExp.bAverage,'Value',1);
set(ghExp.Average,'String',Param.Averages);


function SetSignalGenerator(Param)
global gSG;
ghSG = guihandles(SignalGenerator);
pause(2);
close('SignalGenerator');
gSG.fixCarrier = Param.MWFreq;
gSG.fixPower = Param.MWPower;
gSG.minCarrier = Param.CenterFreq - Param.SpanFreq/2;
gSG.maxCarrier = Param.CenterFreq + Param.SpanFreq/2;;
gSG.NCarrier = Param.NFreq;
SignalGeneratorFunctionPool('SaveSetToFile',[], [], []);
SignalGeneratorFunctionPool('RunSG',[], [], []);
disp(sprintf('Signal Generator : Power: %.0f Freq: %.3f GHz',gSG.fixPower,gSG.fixCarrier));
disp(sprintf('Signal Generator : center: %.3f Span GHz %.3f GHz',Param.CenterFreq,Param.SpanFreq));


function ApplyMagneticField(Param)
global gSetB;

gSetB.Bx = Param.Bx;
gSetB.By = Param.By;
gSetB.Bz = Param.Bz;
MagnetometerFunctionPool('Apply',[],[],[]);
disp(['Applying Magnetic field B = [',num2str(gSetB.Bx),',',num2str(gSetB.By),',',num2str(gSetB.Bz),']']);
pause(2);


function Initialize(hObject, eventdata, handles)
global gProject;

StrL = {'One','Two'};
set(handles.MWCWTransition,'String',StrL);
set(handles.TaskName,'String','Task');
gProject.Path = 'Sets/Planner/';

function Project(what,hObject, eventdata, handles)
global gProject gPlanner;

switch what
    case 'ProjectTask'
        gPlanner.iTask = get(handles.ProjectTask,'Value');
        Task('UpdateTaskForm',hObject, eventdata, handles);
    case 'CreateProject'
        clear global gProject;
        global gProject;
        gProject.File = 'Project_Untitled.xml';
        gProject.Path = 'Sets/Planner/';
        gProject.Task = [];
        gProject.Param = 0;
        xml_save([gProject.Path gProject.File],gProject);
        Project('UpdateForm',hObject, eventdata, handles);
        Task('UpdateTaskForm',hObject, eventdata, handles);
    case 'LoadProject'
        [file, path, filterindex] = uigetfile('Project_*.xml', 'Load Experiment',gProject.Path);
        if file ==0, return; end
        gProject = xml_load([path file]);
        gProject.File = file;
        gProject.Path = path;
        gPlanner.iTask = 1;
        Project('UpdateForm',hObject, eventdata, handles);
        Task('UpdateTaskForm',hObject, eventdata, handles);
    case 'UpdateForm'
        set(handles.ProjectName,'String',gProject.File);
    case 'SaveProject'
        xml_save([gProject.Path gProject.File],gProject);
    case 'SaveProjectAs'
        file = [gProject.Path gProject.File ];
        [file, path, filterindex] = uiputfile('Project_*.xml', 'Save Project As',file);
        if file ==0, return; end
        gProject.File = file;
        gProject.Path = path;     
        xml_save([gProject.Path gProject.File],gProject);
    case 'RunProject'
        RunProject(hObject, eventdata, handles);
    otherwise
        disp('Planner Project - I dont get it!');
end


function Task(what,hObject, eventdata, handles)
global gProject gPlanner;

NumTasks = length(gProject.Task);

switch what
    case 'AddTask'
        gPlanner.iTask = NumTasks + 1;
        TaskName = get(handles.TaskName,'String');
        gProject.Task(gPlanner.iTask).Name = [TaskName num2str(gPlanner.iTask)];
        gProject.Task(gPlanner.iTask).Type = 'CW';
        gProject.Task(gPlanner.iTask).Param = GetDefaultParam;
        Task('UpdateTaskForm',hObject, eventdata, handles);
    case 'DuplicateTask'
        gProject.Task(NumTasks + 1) = gProject.Task(gPlanner.iTask);
        Task('UpdateTaskForm',hObject, eventdata, handles);
    case 'SaveTask'
        gProject.Task(gPlanner.iTask).Name = get(handles.TaskName,'String');
        Task('UpdateTaskForm',hObject, eventdata, handles);
    case 'UpdateParam'
        gProject.Task(gPlanner.iTask).Param = GetParamFromForm(hObject, eventdata, handles);
        %Task('UpdateTaskForm',hObject, eventdata, handles);
    case 'TaskName'
        gProject.Task(gPlanner.iTask).Name = get(handles.TaskName,'String');
        Task('UpdateTaskForm',hObject, eventdata, handles);
    case 'TaskType'
        strL = get(handles.TaskType,'String');
        index = get(handles.TaskType,'Value');
        gProject.Task(gPlanner.iTask).Type  = strL{index}; 
        Task('UpdateTaskForm',hObject, eventdata, handles);
    case 'DeleteTask'
        i=0;
        %mTask = [];
        for t=1:NumTasks
            if t ~= gPlanner.iTask
                i = i + 1;
                mTask(i) = gProject.Task(t);
            end
        end
        gProject.Task = mTask;
        if gPlanner.iTask == NumTasks 
            gPlanner.iTask = gPlanner.iTask - 1;
        end
        Task('UpdateTaskForm',hObject, eventdata, handles);
    case 'MoveTaskUp'
        mTask = gProject.Task(gPlanner.iTask);
        if gPlanner.iTask > 1
            gProject.Task(gPlanner.iTask) = gProject.Task(gPlanner.iTask - 1);
            gProject.Task(gPlanner.iTask - 1) = mTask;
            gPlanner.iTask = gPlanner.iTask - 1;
        end
        Task('UpdateTaskForm',hObject, eventdata, handles);
    case 'MoveTaskDown'
        mTask = gProject.Task(gPlanner.iTask);
        if gPlanner.iTask < NumTasks
            gProject.Task(gPlanner.iTask) = gProject.Task(gPlanner.iTask + 1);
            gProject.Task(gPlanner.iTask + 1) = mTask;
            gPlanner.iTask = gPlanner.iTask + 1;
        end
        Task('UpdateTaskForm',hObject, eventdata, handles);
    case 'UpdateTaskFormTau'
        gProject.Task(gPlanner.iTask).Param.TauNumber = get(handles.TauNumber,'Value');
        Task('UpdateTaskForm',hObject, eventdata, handles);
    case 'UpdateTaskForm'
        if NumTasks == 0, return; end;
        for i=1:NumTasks
        strList{i} = gProject.Task(i).Name;
        end
        set(handles.ProjectTask,'String',strList);
        set(handles.ProjectTask,'Value',gPlanner.iTask);
        Param = gProject.Task(gPlanner.iTask).Param;
        
        set(handles.bTrackAlways,'Value',Param.bTrackAlways);
        set(handles.TrackThreshold,'String',Param.TrackThreshold);
        set(handles.Samples,'String',Param.Samples);
        set(handles.Averages,'String',Param.Averages);        
        set(handles.Bx,'String',Param.Bx);
        set(handles.By,'String',Param.By);
        set(handles.Bz,'String',Param.Bz);
        set(handles.B,'String',Param.B);
        set(handles.Theta,'String',Param.Theta);
        set(handles.Phi,'String',Param.Phi);
        set(handles.bGaussAmps,'Value',Param.bGaussAmps);
        set(handles.MWPower,'String',Param.MWPower);
        set(handles.MWFreq,'String',Param.MWFreq);
        set(handles.MWFreqOffSet,'String',Param.MWFreqOffSet);
        set(handles.CenterFreq,'String',Param.CenterFreq);
        set(handles.SpanFreq,'String',Param.SpanFreq);
        set(handles.NFreq,'String',Param.NFreq);
        set(handles.bMWUseCWFreq,'Value',Param.bMWUseCWFreq);
        set(handles.MWCWTransition,'Value',Param.MWCWTransition);
        set(handles.PIOver2,'String',Param.PIOver2);
        set(handles.PI,'String',Param.PI);
        set(handles.bUseTauFromRabi,'Value',Param.bUseTauFromRabi);
        set(handles.TauNumber,'Value',Param.TauNumber);
        set(handles.TauValue,'String',Param.TauValue{Param.TauNumber});
        set(handles.bSweep,'Value',Param.bSweep{Param.TauNumber});
        set(handles.MinTau,'String',Param.MinTau{Param.TauNumber});
        set(handles.MaxTau,'String',Param.MaxTau{Param.TauNumber});
        set(handles.NTau,'String',Param.NTau{Param.TauNumber});
        set(handles.bTau2FromT2Star,'Value',Param.bTau2FromT2Star);
        if Param.bGaussAmps, Str = 'Gauss'; else Str = 'Amps'; end;
        set(handles.GaussAmps,'String',Str);
        set(handles.TaskName,'String',gProject.Task(gPlanner.iTask).Name);
        strL = get(handles.TaskType,'String');
        index = findCellArray(strL,gProject.Task(gPlanner.iTask).Type);
        set(handles.TaskType,'Value',index);
                
    otherwise
        disp('Planner Task - I dont get it!');
end

function index = findCellArray(strL,strWhat)
index = 0;
for i=1:length(strL)
    if strcmp(strL{i},strWhat)
        index = i;
    end
end

function Param = GetDefaultParam 
global gPlanner gProject;

Param.bTrackAlways = 1;
Param.TrackThreshold = 0.1;
Param.Samples = 10000;
Param.Averages = 50;
Param.Bx = 0;
Param.By = 0;
Param.Bz = 0;
Param.B  = 0;
Param.Theta = 0;
Param.Phi = 0;
Param.bGaussAmps = 1;
Param.MWPower = -12;
Param.MWFreq = 2.87e9;
Param.MWFreqOffSet = 0;
Param.CenterFreq = 2.87e9;
Param.SpanFreq = 0.15e9;
Param.NFreq = 301;
Param.bMWUseCWFreq = 1;
Param.MWCWTransition = 1;
Param.PIOver2 = 20e-9;
Param.PI = 40e-9;
Param.bUseTauFromRabi = 1;
Param.TauNumber = 1;
Param.TauValue{Param.TauNumber} = 1e-6;
Param.bSweep{Param.TauNumber} = 0;
Param.MinTau{Param.TauNumber} = 0.5e-6;
Param.MaxTau{Param.TauNumber} = 2e-6;
Param.NTau{Param.TauNumber} = 20;
Param.bTau2FromT2Star = 1;

function Param = GetParamFromForm(hObject, eventdata, handles)
global gPlanner gProject;

Param = gProject.Task(gPlanner.iTask).Param;
Param.bTrackAlways = get(handles.bTrackAlways,'Value');
Param.TrackThreshold = eval(get(handles.TrackThreshold,'String'));
Param.Samples = eval(get(handles.Samples,'String'));
Param.Averages = eval(get(handles.Averages,'String'));
Param.Bx = eval(get(handles.Bx,'String'));
Param.By = eval(get(handles.By,'String'));
Param.Bz = eval(get(handles.Bz,'String'));
Param.B = eval(get(handles.B,'String'));
Param.Theta = eval(get(handles.Theta,'String'));
Param.Phi = eval(get(handles.Phi,'String'));
Param.bGaussAmps = get(handles.bGaussAmps,'Value');
Param.MWPower = eval(get(handles.MWPower,'String'));
Param.MWFreq = eval(get(handles.MWFreq,'String'));
Param.MWFreqOffSet = eval(get(handles.MWFreqOffSet,'String'));
Param.CenterFreq = eval(get(handles.CenterFreq,'String'));
Param.SpanFreq = eval(get(handles.SpanFreq,'String'));
Param.NFreq = eval(get(handles.NFreq,'String'));
Param.bMWUseCWFreq = get(handles.bMWUseCWFreq,'Value');
Param.MWCWTransition = get(handles.MWCWTransition,'Value');
Param.PIOver2 = eval(get(handles.PIOver2,'String'));
Param.PI = eval(get(handles.PI,'String'));
Param.bUseTauFromRabi = get(handles.bUseTauFromRabi,'Value');
Param.TauNumber = get(handles.TauNumber,'Value');
Param.TauValue{Param.TauNumber} = eval(get(handles.TauValue,'String'));
Param.bSweep{Param.TauNumber} = get(handles.bSweep,'Value');
Param.MinTau{Param.TauNumber} = eval(get(handles.MinTau,'String'));
Param.MaxTau{Param.TauNumber} = eval(get(handles.MaxTau,'String'));
Param.NTau{Param.TauNumber} = eval(get(handles.NTau,'String'));
Param.bTau2FromT2Star = get(handles.bTau2FromT2Star,'Value');
