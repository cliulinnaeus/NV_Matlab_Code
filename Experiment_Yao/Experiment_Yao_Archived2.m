function varargout = Experiment_Yao(varargin)
% EXPERIMENT_YAO MATLAB code for Experiment_Yao.fig
%      EXPERIMENT_YAO, by itself, creates a new EXPERIMENT_YAO or raises the existing
%      singleton*.
%
%      H = EXPERIMENT_YAO returns the handle to a new EXPERIMENT_YAO or the handle to
%      the existing singleton*.
%
%      EXPERIMENT_YAO('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in EXPERIMENT_YAO.M with the given input arguments.
%
%      EXPERIMENT_YAO('Property','Value',...) creates a new EXPERIMENT_YAO or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before Experiment_Yao_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to Experiment_Yao_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help Experiment_Yao

% Last Modified by GUIDE v2.5 29-Jun-2016 10:46:27

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @Experiment_Yao_OpeningFcn, ...
                   'gui_OutputFcn',  @Experiment_Yao_OutputFcn, ...
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


% --- Executes just before Experiment_Yao is made visible.
function Experiment_Yao_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to Experiment_Yao (see VARARGIN)

% Choose default command line output for Experiment_Yao
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);
ExperimentYaoFunctionPool('Start',hObject, eventdata, handles)

% UIWAIT makes Experiment_Yao wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = Experiment_Yao_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on button press in Rabi.
function Rabi_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
ExperimentYaoFunctionPool('Rabi',hObject, eventdata, handles)


% --- Executes on button press in User.
function User_Wave_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
ExperimentYaoFunctionPool('UserWave',hObject, eventdata, handles)



function Ch1_Callback(hObject, eventdata, handles)
% hObject    handle to Ch1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit1 as text
%        str2double(get(hObject,'String')) returns contents of edit1 as a double


% --- Executes during object creation, after setting all properties.
function Ch1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to Ch1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in pushbutton4.
function Set_DC_Offsets_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
ExperimentYaoFunctionPool('DC_Offsets',hObject, eventdata, handles)


% --- Executes on button press in pushbutton5.
function Ready_AWG_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton5 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
ExperimentYaoFunctionPool('Ready_AWG',hObject, eventdata, handles)


% --- Executes on button press in pushbutton6.
function Plot_Test_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton6 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
plot(handles.axes1,(1:10),(1:10))
hold on
plot(handles.axes1,(1:10),(1:2:20))
set(handles.axes1,'XMinorTick','on')


% --- Executes on button press in pushbutton7.
function AOM_Delay_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton7 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
ExperimentYaoFunctionPool('AOM_Delay',hObject, eventdata, handles)



function Notes_Callback(hObject, eventdata, handles)
% hObject    handle to Notes (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of Notes as text
%        str2double(get(hObject,'String')) returns contents of Notes as a double


% --- Executes during object creation, after setting all properties.
function Notes_CreateFcn(hObject, eventdata, handles)
% hObject    handle to Notes (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in UpdateString.
function Update_String_Callback(hObject, eventdata, handles)
% hObject    handle to UpdateString (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
ExperimentYaoFunctionPool('Update String',hObject, eventdata, handles)



function P1_Initial_Width_Callback(hObject, eventdata, handles)
% hObject    handle to P1_Initial_Width (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of P1_Initial_Width as text
%        str2double(get(hObject,'String')) returns contents of P1_Initial_Width as a double


% --- Executes during object creation, after setting all properties.
function P1_Initial_Width_CreateFcn(hObject, eventdata, handles)
% hObject    handle to P1_Initial_Width (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function P1_Initial_Amp_Callback(hObject, eventdata, handles)
% hObject    handle to P1_Initial_Amp (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of P1_Initial_Amp as text
%        str2double(get(hObject,'String')) returns contents of P1_Initial_Amp as a double


% --- Executes during object creation, after setting all properties.
function P1_Initial_Amp_CreateFcn(hObject, eventdata, handles)
% hObject    handle to P1_Initial_Amp (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function P1_Initial_Time_Callback(hObject, eventdata, handles)
% hObject    handle to P1_Initial_Time (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of P1_Initial_Time as text
%        str2double(get(hObject,'String')) returns contents of P1_Initial_Time as a double


% --- Executes during object creation, after setting all properties.
function P1_Initial_Time_CreateFcn(hObject, eventdata, handles)
% hObject    handle to P1_Initial_Time (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function P1_Modulation_Step_Callback(hObject, eventdata, handles)
% hObject    handle to P1_Modulation_Step (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of P1_Modulation_Step as text
%        str2double(get(hObject,'String')) returns contents of P1_Modulation_Step as a double


% --- Executes during object creation, after setting all properties.
function P1_Modulation_Step_CreateFcn(hObject, eventdata, handles)
% hObject    handle to P1_Modulation_Step (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in P1_Sweep.
function P1_Sweep_Callback(hObject, eventdata, handles)
% hObject    handle to P1_Sweep (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns P1_Sweep contents as cell array
%        contents{get(hObject,'Value')} returns selected item from P1_Sweep


% --- Executes during object creation, after setting all properties.
function P1_Sweep_CreateFcn(hObject, eventdata, handles)
% hObject    handle to P1_Sweep (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: listbox controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in P1_On.
function P1_On_Callback(hObject, eventdata, handles)
% hObject    handle to P1_On (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of P1_On



function P1_Offset_Callback(hObject, eventdata, handles)
% hObject    handle to P1_Offset (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of P1_Offset as text
%        str2double(get(hObject,'String')) returns contents of P1_Offset as a double


% --- Executes during object creation, after setting all properties.
function P1_Offset_CreateFcn(hObject, eventdata, handles)
% hObject    handle to P1_Offset (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function P2_Initial_Width_Callback(hObject, eventdata, handles)
% hObject    handle to P2_Initial_Width (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of P2_Initial_Width as text
%        str2double(get(hObject,'String')) returns contents of P2_Initial_Width as a double


% --- Executes during object creation, after setting all properties.
function P2_Initial_Width_CreateFcn(hObject, eventdata, handles)
% hObject    handle to P2_Initial_Width (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function P2_Initial_Amp_Callback(hObject, eventdata, handles)
% hObject    handle to P2_Initial_Amp (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of P2_Initial_Amp as text
%        str2double(get(hObject,'String')) returns contents of P2_Initial_Amp as a double


% --- Executes during object creation, after setting all properties.
function P2_Initial_Amp_CreateFcn(hObject, eventdata, handles)
% hObject    handle to P2_Initial_Amp (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function P2_Initial_Time_Callback(hObject, eventdata, handles)
% hObject    handle to P2_Initial_Time (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of P2_Initial_Time as text
%        str2double(get(hObject,'String')) returns contents of P2_Initial_Time as a double


% --- Executes during object creation, after setting all properties.
function P2_Initial_Time_CreateFcn(hObject, eventdata, handles)
% hObject    handle to P2_Initial_Time (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function P2_Modulation_Step_Callback(hObject, eventdata, handles)
% hObject    handle to P2_Modulation_Step (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of P2_Modulation_Step as text
%        str2double(get(hObject,'String')) returns contents of P2_Modulation_Step as a double


% --- Executes during object creation, after setting all properties.
function P2_Modulation_Step_CreateFcn(hObject, eventdata, handles)
% hObject    handle to P2_Modulation_Step (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in P2_Sweep.
function P2_Sweep_Callback(hObject, eventdata, handles)
% hObject    handle to P2_Sweep (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns P2_Sweep contents as cell array
%        contents{get(hObject,'Value')} returns selected item from P2_Sweep


% --- Executes during object creation, after setting all properties.
function P2_Sweep_CreateFcn(hObject, eventdata, handles)
% hObject    handle to P2_Sweep (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: listbox controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in P2_On.
function P2_On_Callback(hObject, eventdata, handles)
% hObject    handle to P2_On (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of P2_On



function P2_Offset_Callback(hObject, eventdata, handles)
% hObject    handle to P2_Offset (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of P2_Offset as text
%        str2double(get(hObject,'String')) returns contents of P2_Offset as a double


% --- Executes during object creation, after setting all properties.
function P2_Offset_CreateFcn(hObject, eventdata, handles)
% hObject    handle to P2_Offset (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in P1_Channel.
function P1_Channel_Callback(hObject, eventdata, handles)
% hObject    handle to P1_Channel (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns P1_Channel contents as cell array
%        contents{get(hObject,'Value')} returns selected item from P1_Channel


% --- Executes during object creation, after setting all properties.
function P1_Channel_CreateFcn(hObject, eventdata, handles)
% hObject    handle to P1_Channel (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: listbox controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in P2_Channel.
function P2_Channel_Callback(hObject, eventdata, handles)
% hObject    handle to P2_Channel (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns P2_Channel contents as cell array
%        contents{get(hObject,'Value')} returns selected item from P2_Channel


% --- Executes during object creation, after setting all properties.
function P2_Channel_CreateFcn(hObject, eventdata, handles)
% hObject    handle to P2_Channel (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: listbox controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function P1_Final_Mod_Value_Callback(hObject, eventdata, handles)
% hObject    handle to P1_Final_Mod_Value (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of P1_Final_Mod_Value as text
%        str2double(get(hObject,'String')) returns contents of P1_Final_Mod_Value as a double


% --- Executes during object creation, after setting all properties.
function P1_Final_Mod_Value_CreateFcn(hObject, eventdata, handles)
% hObject    handle to P1_Final_Mod_Value (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function P2_Final_Mod_Value_Callback(hObject, eventdata, handles)
% hObject    handle to P2_Final_Mod_Value (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of P2_Final_Mod_Value as text
%        str2double(get(hObject,'String')) returns contents of P2_Final_Mod_Value as a double


% --- Executes during object creation, after setting all properties.
function P2_Final_Mod_Value_CreateFcn(hObject, eventdata, handles)
% hObject    handle to P2_Final_Mod_Value (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function Pulse_Length_Callback(hObject, eventdata, handles)
% hObject    handle to Pulse_Length (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of Pulse_Length as text
%        str2double(get(hObject,'String')) returns contents of Pulse_Length as a double


% --- Executes during object creation, after setting all properties.
function Pulse_Length_CreateFcn(hObject, eventdata, handles)
% hObject    handle to Pulse_Length (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function ESR_Start_Callback(hObject, eventdata, handles)
% hObject    handle to ESR_Start (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of ESR_Start as text
%        str2double(get(hObject,'String')) returns contents of ESR_Start as a double


% --- Executes during object creation, after setting all properties.
function ESR_Start_CreateFcn(hObject, eventdata, handles)
% hObject    handle to ESR_Start (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function ESR_End_Callback(hObject, eventdata, handles)
% hObject    handle to ESR_End (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of ESR_End as text
%        str2double(get(hObject,'String')) returns contents of ESR_End as a double


% --- Executes during object creation, after setting all properties.
function ESR_End_CreateFcn(hObject, eventdata, handles)
% hObject    handle to ESR_End (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function ESR_Step_Callback(hObject, eventdata, handles)
% hObject    handle to ESR_Step (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of ESR_Step as text
%        str2double(get(hObject,'String')) returns contents of ESR_Step as a double


% --- Executes during object creation, after setting all properties.
function ESR_Step_CreateFcn(hObject, eventdata, handles)
% hObject    handle to ESR_Step (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in ESR.
function ESR_Callback(hObject, eventdata, handles)
% hObject    handle to ESR (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
ExperimentYaoFunctionPool('ESR',hObject, eventdata, handles)



function ESR_Power_Callback(hObject, eventdata, handles)
% hObject    handle to ESR_Power (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of ESR_Power as text
%        str2double(get(hObject,'String')) returns contents of ESR_Power as a double


% --- Executes during object creation, after setting all properties.
function ESR_Power_CreateFcn(hObject, eventdata, handles)
% hObject    handle to ESR_Power (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in radiobutton3.
function radiobutton3_Callback(hObject, eventdata, handles)
% hObject    handle to radiobutton3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of radiobutton3
