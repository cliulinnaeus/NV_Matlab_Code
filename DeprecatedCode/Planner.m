function varargout = Planner(varargin)
% PLANNER M-file for Planner.fig
%      PLANNER, by itself, creates a new PLANNER or raises the existing
%      singleton*.
%
%      H = PLANNER returns the handle to a new PLANNER or the handle to
%      the existing singleton*.
%
%      PLANNER('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in PLANNER.M with the given input arguments.
%
%      PLANNER('Property','Value',...) creates a new PLANNER or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before Planner_OpeningFunction gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to Planner_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help Planner

% Last Modified by GUIDE v2.5 21-Jul-2008 11:24:39

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @Planner_OpeningFcn, ...
                   'gui_OutputFcn',  @Planner_OutputFcn, ...
                   'gui_LayoutFcn',  [] , ...
                   'gui_Callback',   []);
if nargin && ischar(varargin{1})
    gui_State.gui_Callback = str2func(varargin{1});
end

if nargout
    [varargout{1:nargout}] = gui_mainfcn(gui_State, varargin{:});
else
    gui_mainfcn(gui_State, varargin{:});
end
% End initialization code - DO NOT EDIT


% --- Executes just before Planner is made visible.
function Planner_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to Planner (see VARARGIN)

% Choose default command line output for Planner
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes Planner wait for user response (see UIRESUME)
% uiwait(handles.figure1);
PlannerFunctionPool('Initialize',hObject, eventdata, handles);

% --- Outputs from this function are returned to the command line.
function varargout = Planner_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on button press in CreateProject.
function CreateProject_Callback(hObject, eventdata, handles)
% hObject    handle to CreateProject (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
PlannerFunctionPool('CreateProject',hObject, eventdata, handles);

% --- Executes on button press in LoadProject.
function LoadProject_Callback(hObject, eventdata, handles)
% hObject    handle to LoadProject (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
PlannerFunctionPool('LoadProject',hObject, eventdata, handles);


% --- Executes on button press in SaveProject.
function SaveProject_Callback(hObject, eventdata, handles)
% hObject    handle to SaveProject (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
PlannerFunctionPool('SaveProject',hObject, eventdata, handles);


% --- Executes on button press in SaveProjectAs.
function SaveProjectAs_Callback(hObject, eventdata, handles)
% hObject    handle to SaveProjectAs (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
PlannerFunctionPool('SaveProjectAs',hObject, eventdata, handles);



function ProjectName_Callback(hObject, eventdata, handles)
% hObject    handle to ProjectName (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of ProjectName as text
%        str2double(get(hObject,'String')) returns contents of ProjectName as a double


% --- Executes during object creation, after setting all properties.
function ProjectName_CreateFcn(hObject, eventdata, handles)
% hObject    handle to ProjectName (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in AddTask.
function AddTask_Callback(hObject, eventdata, handles)
% hObject    handle to AddTask (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
PlannerFunctionPool('AddTask',hObject, eventdata, handles);


% --- Executes on button press in DuplicateTask.
function DuplicateTask_Callback(hObject, eventdata, handles)
% hObject    handle to DuplicateTask (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
PlannerFunctionPool('DuplicateTask',hObject, eventdata, handles);


% --- Executes on button press in SaveTask.
function SaveTask_Callback(hObject, eventdata, handles)
% hObject    handle to SaveTask (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
PlannerFunctionPool('SaveTask',hObject, eventdata, handles);


% --- Executes on button press in MoveTaskUp.
function MoveTaskUp_Callback(hObject, eventdata, handles)
% hObject    handle to MoveTaskUp (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
PlannerFunctionPool('MoveTaskUp',hObject, eventdata, handles);


% --- Executes on selection change in TaskType.
function TaskType_Callback(hObject, eventdata, handles)
% hObject    handle to TaskType (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = get(hObject,'String') returns TaskType contents as cell array
%        contents{get(hObject,'Value')} returns selected item from TaskType
PlannerFunctionPool('TaskType',hObject, eventdata, handles);


% --- Executes during object creation, after setting all properties.
function TaskType_CreateFcn(hObject, eventdata, handles)
% hObject    handle to TaskType (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in MoveTaskDown.
function MoveTaskDown_Callback(hObject, eventdata, handles)
% hObject    handle to MoveTaskDown (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
PlannerFunctionPool('MoveTaskDown',hObject, eventdata, handles);



function TaskName_Callback(hObject, eventdata, handles)
% hObject    handle to TaskName (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of TaskName as text
%        str2double(get(hObject,'String')) returns contents of TaskName as a double
PlannerFunctionPool('TaskName',hObject, eventdata, handles);


% --- Executes during object creation, after setting all properties.
function TaskName_CreateFcn(hObject, eventdata, handles)
% hObject    handle to TaskName (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in RunProject.
function RunProject_Callback(hObject, eventdata, handles)
% hObject    handle to RunProject (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
PlannerFunctionPool('RunProject',hObject, eventdata, handles);


% --- Executes on selection change in ProjectTask.
function ProjectTask_Callback(hObject, eventdata, handles)
% hObject    handle to ProjectTask (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = get(hObject,'String') returns ProjectTask contents as cell array
%        contents{get(hObject,'Value')} returns selected item from ProjectTask
PlannerFunctionPool('ProjectTask',hObject, eventdata, handles);


% --- Executes during object creation, after setting all properties.
function ProjectTask_CreateFcn(hObject, eventdata, handles)
% hObject    handle to ProjectTask (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: listbox controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in WhichParameters.
function WhichParameters_Callback(hObject, eventdata, handles)
% hObject    handle to WhichParameters (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = get(hObject,'String') returns WhichParameters contents as cell array
%        contents{get(hObject,'Value')} returns selected item from WhichParameters


% --- Executes during object creation, after setting all properties.
function WhichParameters_CreateFcn(hObject, eventdata, handles)
% hObject    handle to WhichParameters (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in DeleteTask.
function DeleteTask_Callback(hObject, eventdata, handles)
% hObject    handle to DeleteTask (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
PlannerFunctionPool('DeleteTask',hObject, eventdata, handles);



function MWPower_Callback(hObject, eventdata, handles)
% hObject    handle to MWPower (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of MWPower as text
%        str2double(get(hObject,'String')) returns contents of MWPower as a double
PlannerFunctionPool('UpdateParam',hObject, eventdata, handles);


% --- Executes during object creation, after setting all properties.
function MWPower_CreateFcn(hObject, eventdata, handles)
% hObject    handle to MWPower (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function MWFreq_Callback(hObject, eventdata, handles)
% hObject    handle to MWFreq (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of MWFreq as text
%        str2double(get(hObject,'String')) returns contents of MWFreq as a double
PlannerFunctionPool('UpdateParam',hObject, eventdata, handles);


% --- Executes during object creation, after setting all properties.
function MWFreq_CreateFcn(hObject, eventdata, handles)
% hObject    handle to MWFreq (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function MWFreqOffSet_Callback(hObject, eventdata, handles)
% hObject    handle to MWFreqOffSet (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of MWFreqOffSet as text
%        str2double(get(hObject,'String')) returns contents of MWFreqOffSet as a double
PlannerFunctionPool('UpdateParam',hObject, eventdata, handles);

% --- Executes during object creation, after setting all properties.
function MWFreqOffSet_CreateFcn(hObject, eventdata, handles)
% hObject    handle to MWFreqOffSet (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in bMWUseCWFreq.
function bMWUseCWFreq_Callback(hObject, eventdata, handles)
% hObject    handle to bMWUseCWFreq (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of bMWUseCWFreq
PlannerFunctionPool('UpdateParam',hObject, eventdata, handles);


% --- Executes on selection change in MWCWTransition.
function MWCWTransition_Callback(hObject, eventdata, handles)
% hObject    handle to MWCWTransition (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = get(hObject,'String') returns MWCWTransition contents as cell array
%        contents{get(hObject,'Value')} returns selected item from MWCWTransition
PlannerFunctionPool('UpdateParam',hObject, eventdata, handles);


% --- Executes during object creation, after setting all properties.
function MWCWTransition_CreateFcn(hObject, eventdata, handles)
% hObject    handle to MWCWTransition (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function Bx_Callback(hObject, eventdata, handles)
% hObject    handle to Bx (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of Bx as text
%        str2double(get(hObject,'String')) returns contents of Bx as a double
PlannerFunctionPool('Bx',hObject, eventdata, handles);

% --- Executes during object creation, after setting all properties.
function Bx_CreateFcn(hObject, eventdata, handles)
% hObject    handle to Bx (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function By_Callback(hObject, eventdata, handles)
% hObject    handle to By (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of By as text
%        str2double(get(hObject,'String')) returns contents of By as a double
PlannerFunctionPool('By',hObject, eventdata, handles);


% --- Executes during object creation, after setting all properties.
function By_CreateFcn(hObject, eventdata, handles)
% hObject    handle to By (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function Bz_Callback(hObject, eventdata, handles)
% hObject    handle to Bz (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of Bz as text
%        str2double(get(hObject,'String')) returns contents of Bz as a double
PlannerFunctionPool('Bz',hObject, eventdata, handles);


% --- Executes during object creation, after setting all properties.
function Bz_CreateFcn(hObject, eventdata, handles)
% hObject    handle to Bz (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function Phi_Callback(hObject, eventdata, handles)
% hObject    handle to Phi (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of Phi as text
%        str2double(get(hObject,'String')) returns contents of Phi as a double
PlannerFunctionPool('Phi',hObject, eventdata, handles);


% --- Executes during object creation, after setting all properties.
function Phi_CreateFcn(hObject, eventdata, handles)
% hObject    handle to Phi (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function B_Callback(hObject, eventdata, handles)
% hObject    handle to B (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of B as text
%        str2double(get(hObject,'String')) returns contents of B as a double
PlannerFunctionPool('B',hObject, eventdata, handles);


% --- Executes during object creation, after setting all properties.
function B_CreateFcn(hObject, eventdata, handles)
% hObject    handle to B (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in bGaussAmps.
function bGaussAmps_Callback(hObject, eventdata, handles)
% hObject    handle to bGaussAmps (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of bGaussAmps
PlannerFunctionPool('UpdateParam',hObject, eventdata, handles);



function Theta_Callback(hObject, eventdata, handles)
% hObject    handle to Theta (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of Theta as text
%        str2double(get(hObject,'String')) returns contents of Theta as a double
PlannerFunctionPool('Theta',hObject, eventdata, handles);


% --- Executes during object creation, after setting all properties.
function Theta_CreateFcn(hObject, eventdata, handles)
% hObject    handle to Theta (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in bTrackAlways.
function bTrackAlways_Callback(hObject, eventdata, handles)
% hObject    handle to bTrackAlways (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of bTrackAlways
PlannerFunctionPool('UpdateParam',hObject, eventdata, handles);



function TrackThreshold_Callback(hObject, eventdata, handles)
% hObject    handle to TrackThreshold (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of TrackThreshold as text
%        str2double(get(hObject,'String')) returns contents of TrackThreshold as a double
PlannerFunctionPool('UpdateParam',hObject, eventdata, handles);


% --- Executes during object creation, after setting all properties.
function TrackThreshold_CreateFcn(hObject, eventdata, handles)
% hObject    handle to TrackThreshold (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function PIOver2_Callback(hObject, eventdata, handles)
% hObject    handle to PIOver2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of PIOver2 as text
%        str2double(get(hObject,'String')) returns contents of PIOver2 as a double
PlannerFunctionPool('UpdateParam',hObject, eventdata, handles);


% --- Executes during object creation, after setting all properties.
function PIOver2_CreateFcn(hObject, eventdata, handles)
% hObject    handle to PIOver2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function PI_Callback(hObject, eventdata, handles)
% hObject    handle to PI (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of PI as text
%        str2double(get(hObject,'String')) returns contents of PI as a double
PlannerFunctionPool('UpdateParam',hObject, eventdata, handles);


% --- Executes during object creation, after setting all properties.
function PI_CreateFcn(hObject, eventdata, handles)
% hObject    handle to PI (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in bUseTauFromRabi.
function bUseTauFromRabi_Callback(hObject, eventdata, handles)
% hObject    handle to bUseTauFromRabi (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of bUseTauFromRabi
PlannerFunctionPool('UpdateParam',hObject, eventdata, handles);



function TauValue_Callback(hObject, eventdata, handles)
% hObject    handle to TauValue (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of TauValue as text
%        str2double(get(hObject,'String')) returns contents of TauValue as a double
PlannerFunctionPool('UpdateParam',hObject, eventdata, handles);


% --- Executes during object creation, after setting all properties.
function TauValue_CreateFcn(hObject, eventdata, handles)
% hObject    handle to TauValue (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in bSweep.
function bSweep_Callback(hObject, eventdata, handles)
% hObject    handle to bSweep (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of bSweep
PlannerFunctionPool('UpdateParam',hObject, eventdata, handles);



function MinTau_Callback(hObject, eventdata, handles)
% hObject    handle to MinTau (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of MinTau as text
%        str2double(get(hObject,'String')) returns contents of MinTau as a double
PlannerFunctionPool('UpdateParam',hObject, eventdata, handles);


% --- Executes during object creation, after setting all properties.
function MinTau_CreateFcn(hObject, eventdata, handles)
% hObject    handle to MinTau (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function NTau_Callback(hObject, eventdata, handles)
% hObject    handle to NTau (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of NTau as text
%        str2double(get(hObject,'String')) returns contents of NTau as a double
PlannerFunctionPool('UpdateParam',hObject, eventdata, handles);


% --- Executes during object creation, after setting all properties.
function NTau_CreateFcn(hObject, eventdata, handles)
% hObject    handle to NTau (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function MaxTau_Callback(hObject, eventdata, handles)
% hObject    handle to MaxTau (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of MaxTau as text
%        str2double(get(hObject,'String')) returns contents of MaxTau as a double
PlannerFunctionPool('UpdateParam',hObject, eventdata, handles);


% --- Executes during object creation, after setting all properties.
function MaxTau_CreateFcn(hObject, eventdata, handles)
% hObject    handle to MaxTau (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in TauNumber.
function TauNumber_Callback(hObject, eventdata, handles)
% hObject    handle to TauNumber (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = get(hObject,'String') returns TauNumber contents as cell array
%        contents{get(hObject,'Value')} returns selected item from TauNumber
PlannerFunctionPool('UpdateTaskFormTau',hObject, eventdata, handles);


% --- Executes during object creation, after setting all properties.
function TauNumber_CreateFcn(hObject, eventdata, handles)
% hObject    handle to TauNumber (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in bTau2FromT2Star.
function bTau2FromT2Star_Callback(hObject, eventdata, handles)
% hObject    handle to bTau2FromT2Star (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of bTau2FromT2Star
PlannerFunctionPool('UpdateParam',hObject, eventdata, handles);



function CenterFreq_Callback(hObject, eventdata, handles)
% hObject    handle to CenterFreq (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of CenterFreq as text
%        str2double(get(hObject,'String')) returns contents of CenterFreq as a double
PlannerFunctionPool('UpdateParam',hObject, eventdata, handles);


% --- Executes during object creation, after setting all properties.
function CenterFreq_CreateFcn(hObject, eventdata, handles)
% hObject    handle to CenterFreq (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function SpanFreq_Callback(hObject, eventdata, handles)
% hObject    handle to SpanFreq (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of SpanFreq as text
%        str2double(get(hObject,'String')) returns contents of SpanFreq as a double
PlannerFunctionPool('UpdateParam',hObject, eventdata, handles);


% --- Executes during object creation, after setting all properties.
function SpanFreq_CreateFcn(hObject, eventdata, handles)
% hObject    handle to SpanFreq (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function NFreq_Callback(hObject, eventdata, handles)
% hObject    handle to NFreq (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of NFreq as text
%        str2double(get(hObject,'String')) returns contents of NFreq as a double
PlannerFunctionPool('UpdateParam',hObject, eventdata, handles);


% --- Executes during object creation, after setting all properties.
function NFreq_CreateFcn(hObject, eventdata, handles)
% hObject    handle to NFreq (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function Samples_Callback(hObject, eventdata, handles)
% hObject    handle to Samples (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of Samples as text
%        str2double(get(hObject,'String')) returns contents of Samples as a double
PlannerFunctionPool('UpdateParam',hObject, eventdata, handles);


% --- Executes during object creation, after setting all properties.
function Samples_CreateFcn(hObject, eventdata, handles)
% hObject    handle to Samples (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function Averages_Callback(hObject, eventdata, handles)
% hObject    handle to Averages (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of Averages as text
%        str2double(get(hObject,'String')) returns contents of Averages as a double
PlannerFunctionPool('UpdateParam',hObject, eventdata, handles);


% --- Executes during object creation, after setting all properties.
function Averages_CreateFcn(hObject, eventdata, handles)
% hObject    handle to Averages (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


