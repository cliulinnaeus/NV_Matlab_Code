function varargout = SignalGenerator(varargin)
%SIGNALGENERATOR MATLAB code file for SignalGenerator.fig
%      SIGNALGENERATOR, by itself, creates a new SIGNALGENERATOR or raises the existing
%      singleton*.
%
%      H = SIGNALGENERATOR returns the handle to a new SIGNALGENERATOR or the handle to
%      the existing singleton*.
%
%      SIGNALGENERATOR('Property','Value',...) creates a new SIGNALGENERATOR using the
%      given property value pairs. Unrecognized properties are passed via
%      varargin to SignalGenerator_OpeningFcn.  This calling syntax produces a
%      warning when there is an existing singleton*.
%
%      SIGNALGENERATOR('CALLBACK') and SIGNALGENERATOR('CALLBACK',hObject,...) call the
%      local function named CALLBACK in SIGNALGENERATOR.M with the given input
%      arguments.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help SignalGenerator

% Last Modified by GUIDE v2.5 04-Jan-2017 13:08:34

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @SignalGenerator_OpeningFcn, ...
                   'gui_OutputFcn',  @SignalGenerator_OutputFcn, ...
                   'gui_LayoutFcn',  [], ...
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


% --- Executes just before SignalGenerator is made visible.
function SignalGenerator_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   unrecognized PropertyName/PropertyValue pairs from the
%            command line (see VARARGIN)

% Choose default command line output for SignalGenerator
handles.output = hObject;
SignalGeneratorFunctionPool('InitGUI',PortMap('SG com'),handles);
% Update handles structure
guidata(hObject, handles);

% UIWAIT makes SignalGenerator wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = SignalGenerator_OutputFcn(hObject, eventdata, handles)
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes during object creation, after setting all properties.
function RFOnIndicator_CreateFcn(hObject, eventdata, handles)
% hObject    handle to RFOnIndicator (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called


% --- Executes during object creation, after setting all properties.
function strErr_Callback(hObject, eventdata, handles)
% hObject    handle to strErr (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% --- Executes during object creation, after setting all properties.
function strErr_CreateFcn(hObject, eventdata, handles)
% hObject    handle to strErr (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called


function fixFreq_Callback(hObject, eventdata, handles)
% hObject    handle to fixFreq (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of fixFreq as text
%        str2double(get(hObject,'String')) returns contents of fixFreq as a double


% --- Executes during object creation, after setting all properties.
function fixFreq_CreateFcn(hObject, eventdata, handles)
% hObject    handle to fixFreq (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function fixPow_Callback(hObject, eventdata, handles)
% hObject    handle to fixPow (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of fixPow as text
%        str2double(get(hObject,'String')) returns contents of fixPow as a double


% --- Executes during object creation, after setting all properties.
function fixPow_CreateFcn(hObject, eventdata, handles)
% hObject    handle to fixPow (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in RFOn.
function RFOn_Callback(hObject, eventdata, handles)
% hObject    handle to RFOn (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global gSG
gSG.Pow=str2double(get(handles.fixPow,'String'));
SignalGeneratorFunctionPool('WritePow');
gSG.Freq=str2double(get(handles.fixFreq,'String'))*1e9;
SignalGeneratorFunctionPool('WriteFreq');
gSG.bOn=1;
str=get(handles.puMod, 'String');
val=get(handles.puMod, 'Value');
gSG.bMod= string(str(val));
str=get(handles.puModSrc, 'String');
val=get(handles.puModSrc, 'Value');
gSG.bModSrc= string(str(val));
if strcmp(gSG.bMod,'Sweep')
    gSG.sweepDev=str2double(get(handles.sweepDev,'String'))*1e9;
    gSG.sweepRate=str2double(get(handles.sweepRate,'String'));
end

SignalGeneratorFunctionPool('SetMod');
SignalGeneratorFunctionPool('RFOnOff');
bQuery_Callback(hObject, eventdata, handles);

% --- Executes on button press in RFOff.
function RFOff_Callback(hObject, eventdata, handles)
% hObject    handle to RFOff (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global gSG
gSG.bOn=0;
SignalGeneratorFunctionPool('RFOnOff');
bQuery_Callback(hObject, eventdata, handles);

% --- Executes during object creation, after setting all properties.
function strFreq_CreateFcn(hObject, eventdata, handles)
% hObject    handle to strFreq (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called


% --- Executes during object creation, after setting all properties.
function strPow_CreateFcn(hObject, eventdata, handles)
% hObject    handle to strPow (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called


% --- Executes on button press in bQuery.
function bQuery_Callback(hObject, eventdata, handles)
% hObject    handle to bQuery (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global gSG
SignalGeneratorFunctionPool('Query');
if gSG.qbOn
    set(handles.strRFOnOff,'backgroundcolor',[0 1 0]);
    handles.strRFOnOff.String='RF On';
else
    set(handles.strRFOnOff,'backgroundcolor',[1 0 0]);
    handles.strRFOnOff.String='RF Off';
end
handles.strPow.String=num2str(gSG.qPow);
handles.strFreq.String=num2str(gSG.qFreq * 1e-9);
handles.strModSrc.String='N/A';
handles.strSweepDev.String='N/A';
handles.strSweepRate.String='N/A';
switch gSG.qbMod
    case 'None'
        handles.strMod.String='Disabled';
    case 'IQ'
        handles.strMod.String='IQ';
        handles.strModSrc.String=gSG.qModSrc;
    case 'Sweep'
        handles.strMod.String='Sweep';
        handles.strModSrc.String=gSG.qModSrc;
        handles.strSweepDev.String=num2str(gSG.qSweepDev/1e9);
        handles.strSweepRate.String=num2str(gSG.qSweepRate);
end
if or(gSG.qErr(1),gSG.qErr(2))
    handles.strErr.String=strcat('ESR error',{' '},string(gSG.qErr(1)),', INSR error',{' '},string(gSG.qErr(2)));
    set(handles.strErr,'backgroundcolor',[1 1 0]);
else
    handles.strErr.String='None';
    set(handles.strErr,'backgroundcolor',[1 1 1]);
end


function sweepDev_Callback(hObject, eventdata, handles)
% hObject    handle to sweepDev (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of sweepDev as text
%        str2double(get(hObject,'String')) returns contents of sweepDev as a double


% --- Executes during object creation, after setting all properties.
function sweepDev_CreateFcn(hObject, eventdata, handles)
% hObject    handle to sweepDev (see GCBO)
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



function sweepRate_Callback(hObject, eventdata, handles)
% hObject    handle to sweepRate (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of sweepRate as text
%        str2double(get(hObject,'String')) returns contents of sweepRate as a double


% --- Executes during object creation, after setting all properties.
function sweepRate_CreateFcn(hObject, eventdata, handles)
% hObject    handle to sweepRate (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in puModSrc.
function puModSrc_Callback(hObject, eventdata, handles)
% hObject    handle to puModSrc (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns puModSrc contents as cell array
%        contents{get(hObject,'Value')} returns selected item from puModSrc


% --- Executes during object creation, after setting all properties.
function puModSrc_CreateFcn(hObject, eventdata, handles)
% hObject    handle to puModSrc (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in puMod.
function puMod_Callback(hObject, eventdata, handles)
% hObject    handle to puMod (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns puMod contents as cell array
%        contents{get(hObject,'Value')} returns selected item from puMod


% --- Executes during object creation, after setting all properties.
function puMod_CreateFcn(hObject, eventdata, handles)
% hObject    handle to puMod (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
