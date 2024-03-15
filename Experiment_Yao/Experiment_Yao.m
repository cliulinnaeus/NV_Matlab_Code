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

% Last Modified by GUIDE v2.5 16-Sep-2016 15:23:57

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
function User_Callback(hObject, eventdata, handles)
% hObject    handle to User (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
ExperimentYaoFunctionPool('User',hObject, eventdata, handles)



function Plot_Seq_Callback(hObject, eventdata, handles)
% hObject    handle to Ch1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit1 as text
%        str2double(get(hObject,'String')) returns contents of edit1 as a double


% --- Executes on button press in Set_DC_Offsets_Callback.
function Set_DC_Offsets_Callback(hObject, eventdata, handles)
% hObject    handle to Set_DC_Offsets_Callback (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
ExperimentYaoFunctionPool('DC_Offsets',hObject, eventdata, handles)


% --- Executes on button press in pushbutton5.
function Ready_AWG_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton5 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
ExperimentYaoFunctionPool('Ready_AWG',hObject, eventdata, handles)


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



function MW_Power_Callback(hObject, eventdata, handles)
% hObject    handle to MW_Power (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of MW_Power as text
%        str2double(get(hObject,'String')) returns contents of MW_Power as a double


% --- Executes during object creation, after setting all properties.
function MW_Power_CreateFcn(hObject, eventdata, handles)
% hObject    handle to MW_Power (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in User_Detect.
function User_Detect_Callback(hObject, eventdata, handles)
% hObject    handle to User_Detect (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of User_Detect


% --- Executes on button press in User_Delays.
function User_Delays_Callback(hObject, eventdata, handles)
% hObject    handle to User_Delays (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of User_Delays



function Repeat_Sequence_Callback(hObject, eventdata, handles)
% hObject    handle to Repeat_Sequence (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of Repeat_Sequence as text
%        str2double(get(hObject,'String')) returns contents of Repeat_Sequence as a double


% --- Executes during object creation, after setting all properties.
function Repeat_Sequence_CreateFcn(hObject, eventdata, handles)
% hObject    handle to Repeat_Sequence (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes during object creation, after setting all properties.
function User_CreateFcn(hObject, eventdata, handles)
% hObject    handle to User (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called


% --- Executes on button press in Infinite_Sequence.
function Infinite_Sequence_Callback(hObject, eventdata, handles)
% hObject    handle to Infinite_Sequence (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of Infinite_Sequence


% --- Executes when user attempts to close figure1.
function figure1_CloseRequestFcn(hObject, eventdata, handles)
% hObject    handle to figure1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: delete(hObject) closes the figure
%ExperimentYaoFunctionPool('Close',hObject, eventdata, handles)
delete(hObject);


% --- Executes on button press in ODMR.
function ODMR_Callback(hObject, eventdata, handles)
% hObject    handle to ODMR (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
ExperimentYaoFunctionPool('ODMR',hObject, eventdata, handles)


% --- Executes on button press in Ramsey.
function Ramsey_Callback(hObject, eventdata, handles)
% hObject    handle to Ramsey (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
ExperimentYaoFunctionPool('Ramsey',hObject, eventdata, handles)


% --- Executes on button press in Spin_Echo.
function Spin_Echo_Callback(hObject, eventdata, handles)
% hObject    handle to Spin_Echo (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
ExperimentYaoFunctionPool('SpinEcho',hObject, eventdata, handles)


% --- Executes on button press in CPMGN.
function CPMGN_Callback(hObject, eventdata, handles)
% hObject    handle to CPMGN (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
ExperimentYaoFunctionPool('CPMGN',hObject, eventdata, handles)


% --- Executes on button press in CPMGT.
function CPMGT_Callback(hObject, eventdata, handles)
% hObject    handle to CPMGT (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
ExperimentYaoFunctionPool('CPMGT',hObject, eventdata, handles)



function ODMR_Start_Callback(hObject, eventdata, handles)
% hObject    handle to ODMR_Start (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of ODMR_Start as text
%        str2double(get(hObject,'String')) returns contents of ODMR_Start as a double


% --- Executes during object creation, after setting all properties.
function ODMR_Start_CreateFcn(hObject, eventdata, handles)
% hObject    handle to ODMR_Start (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function ODMR_End_Callback(hObject, eventdata, handles)
% hObject    handle to ODMR_End (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of ODMR_End as text
%        str2double(get(hObject,'String')) returns contents of ODMR_End as a double


% --- Executes during object creation, after setting all properties.
function ODMR_End_CreateFcn(hObject, eventdata, handles)
% hObject    handle to ODMR_End (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function ODMR_Step_Callback(hObject, eventdata, handles)
% hObject    handle to ODMR_Step (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of ODMR_Step as text
%        str2double(get(hObject,'String')) returns contents of ODMR_Step as a double


% --- Executes during object creation, after setting all properties.
function ODMR_Step_CreateFcn(hObject, eventdata, handles)
% hObject    handle to ODMR_Step (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function Rabi_Start_Callback(hObject, eventdata, handles)
% hObject    handle to Rabi_Start (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of Rabi_Start as text
%        str2double(get(hObject,'String')) returns contents of Rabi_Start as a double


% --- Executes during object creation, after setting all properties.
function Rabi_Start_CreateFcn(hObject, eventdata, handles)
% hObject    handle to Rabi_Start (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function Rabi_End_Callback(hObject, eventdata, handles)
% hObject    handle to Rabi_End (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of Rabi_End as text
%        str2double(get(hObject,'String')) returns contents of Rabi_End as a double


% --- Executes during object creation, after setting all properties.
function Rabi_End_CreateFcn(hObject, eventdata, handles)
% hObject    handle to Rabi_End (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function Rabi_Step_Callback(hObject, eventdata, handles)
% hObject    handle to Rabi_Step (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of Rabi_Step as text
%        str2double(get(hObject,'String')) returns contents of Rabi_Step as a double


% --- Executes during object creation, after setting all properties.
function Rabi_Step_CreateFcn(hObject, eventdata, handles)
% hObject    handle to Rabi_Step (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function Ramsey_Start_Callback(hObject, eventdata, handles)
% hObject    handle to Ramsey_Start (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of Ramsey_Start as text
%        str2double(get(hObject,'String')) returns contents of Ramsey_Start as a double


% --- Executes during object creation, after setting all properties.
function Ramsey_Start_CreateFcn(hObject, eventdata, handles)
% hObject    handle to Ramsey_Start (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function Ramsey_End_Callback(hObject, eventdata, handles)
% hObject    handle to Ramsey_End (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of Ramsey_End as text
%        str2double(get(hObject,'String')) returns contents of Ramsey_End as a double


% --- Executes during object creation, after setting all properties.
function Ramsey_End_CreateFcn(hObject, eventdata, handles)
% hObject    handle to Ramsey_End (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function Ramsey_Step_Callback(hObject, eventdata, handles)
% hObject    handle to Ramsey_Step (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of Ramsey_Step as text
%        str2double(get(hObject,'String')) returns contents of Ramsey_Step as a double


% --- Executes during object creation, after setting all properties.
function Ramsey_Step_CreateFcn(hObject, eventdata, handles)
% hObject    handle to Ramsey_Step (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function Spin_Echo_Start_Callback(hObject, eventdata, handles)
% hObject    handle to Spin_Echo_Start (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of Spin_Echo_Start as text
%        str2double(get(hObject,'String')) returns contents of Spin_Echo_Start as a double


% --- Executes during object creation, after setting all properties.
function Spin_Echo_Start_CreateFcn(hObject, eventdata, handles)
% hObject    handle to Spin_Echo_Start (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function Spin_Echo_End_Callback(hObject, eventdata, handles)
% hObject    handle to Spin_Echo_End (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of Spin_Echo_End as text
%        str2double(get(hObject,'String')) returns contents of Spin_Echo_End as a double


% --- Executes during object creation, after setting all properties.
function Spin_Echo_End_CreateFcn(hObject, eventdata, handles)
% hObject    handle to Spin_Echo_End (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function Spin_Echo_Step_Callback(hObject, eventdata, handles)
% hObject    handle to Spin_Echo_Step (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of Spin_Echo_Step as text
%        str2double(get(hObject,'String')) returns contents of Spin_Echo_Step as a double


% --- Executes during object creation, after setting all properties.
function Spin_Echo_Step_CreateFcn(hObject, eventdata, handles)
% hObject    handle to Spin_Echo_Step (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function CPMGN_Start_Callback(hObject, eventdata, handles)
% hObject    handle to CPMGN_Start (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of CPMGN_Start as text
%        str2double(get(hObject,'String')) returns contents of CPMGN_Start as a double


% --- Executes during object creation, after setting all properties.
function CPMGN_Start_CreateFcn(hObject, eventdata, handles)
% hObject    handle to CPMGN_Start (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function CPMGN_End_Callback(hObject, eventdata, handles)
% hObject    handle to CPMGN_End (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of CPMGN_End as text
%        str2double(get(hObject,'String')) returns contents of CPMGN_End as a double


% --- Executes during object creation, after setting all properties.
function CPMGN_End_CreateFcn(hObject, eventdata, handles)
% hObject    handle to CPMGN_End (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function CPMGN_Step_Callback(hObject, eventdata, handles)
% hObject    handle to CPMGN_Step (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of CPMGN_Step as text
%        str2double(get(hObject,'String')) returns contents of CPMGN_Step as a double


% --- Executes during object creation, after setting all properties.
function CPMGN_Step_CreateFcn(hObject, eventdata, handles)
% hObject    handle to CPMGN_Step (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function CPMGT_Start_Callback(hObject, eventdata, handles)
% hObject    handle to CPMGT_Start (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of CPMGT_Start as text
%        str2double(get(hObject,'String')) returns contents of CPMGT_Start as a double


% --- Executes during object creation, after setting all properties.
function CPMGT_Start_CreateFcn(hObject, eventdata, handles)
% hObject    handle to CPMGT_Start (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function CPMGT_End_Callback(hObject, eventdata, handles)
% hObject    handle to CPMGT_End (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of CPMGT_End as text
%        str2double(get(hObject,'String')) returns contents of CPMGT_End as a double


% --- Executes during object creation, after setting all properties.
function CPMGT_End_CreateFcn(hObject, eventdata, handles)
% hObject    handle to CPMGT_End (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function CPMGT_Step_Callback(hObject, eventdata, handles)
% hObject    handle to CPMGT_Step (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of CPMGT_Step as text
%        str2double(get(hObject,'String')) returns contents of CPMGT_Step as a double


% --- Executes during object creation, after setting all properties.
function CPMGT_Step_CreateFcn(hObject, eventdata, handles)
% hObject    handle to CPMGT_Step (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function MW_Pi_Pulse_Callback(hObject, eventdata, handles)
% hObject    handle to MW_Pi_Pulse (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of MW_Pi_Pulse as text
%        str2double(get(hObject,'String')) returns contents of MW_Pi_Pulse as a double


% --- Executes during object creation, after setting all properties.
function MW_Pi_Pulse_CreateFcn(hObject, eventdata, handles)
% hObject    handle to MW_Pi_Pulse (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function CPMGN_tau_Callback(hObject, eventdata, handles)
% hObject    handle to CPMGN_tau (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of CPMGN_tau as text
%        str2double(get(hObject,'String')) returns contents of CPMGN_tau as a double


% --- Executes during object creation, after setting all properties.
function CPMGN_tau_CreateFcn(hObject, eventdata, handles)
% hObject    handle to CPMGN_tau (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function CPMGT_n_Callback(hObject, eventdata, handles)
% hObject    handle to CPMGT_n (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of CPMGT_n as text
%        str2double(get(hObject,'String')) returns contents of CPMGT_n as a double


% --- Executes during object creation, after setting all properties.
function CPMGT_n_CreateFcn(hObject, eventdata, handles)
% hObject    handle to CPMGT_n (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in User_MW.
function User_MW_Callback(hObject, eventdata, handles)
% hObject    handle to User_MW (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of User_MW



function MW_Freq_Callback(hObject, eventdata, handles)
% hObject    handle to MW_Freq (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of MW_Freq as text
%        str2double(get(hObject,'String')) returns contents of MW_Freq as a double


% --- Executes during object creation, after setting all properties.
function MW_Freq_CreateFcn(hObject, eventdata, handles)
% hObject    handle to MW_Freq (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function ESR_MWPower_Callback(hObject, eventdata, handles)
% hObject    handle to ESR_MWPower (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of ESR_MWPower as text
%        str2double(get(hObject,'String')) returns contents of ESR_MWPower as a double


% --- Executes during object creation, after setting all properties.
function ESR_MWPower_CreateFcn(hObject, eventdata, handles)
% hObject    handle to ESR_MWPower (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on mouse press over axes background.
function Plot_Seq_ButtonDownFcn(hObject, eventdata, handles)
% hObject    handle to Plot_Seq (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)



function Rounds_Callback(hObject, eventdata, handles)
% hObject    handle to Rounds (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of Rounds as text
%        str2double(get(hObject,'String')) returns contents of Rounds as a double


% --- Executes during object creation, after setting all properties.
function Rounds_CreateFcn(hObject, eventdata, handles)
% hObject    handle to Rounds (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function Spin_Echo_len_Callback(hObject, eventdata, handles)
% hObject    handle to Spin_Echo_len (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of Spin_Echo_len as text
%        str2double(get(hObject,'String')) returns contents of Spin_Echo_len as a double


% --- Executes during object creation, after setting all properties.
function Spin_Echo_len_CreateFcn(hObject, eventdata, handles)
% hObject    handle to Spin_Echo_len (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function Voltage_I_Callback(hObject, eventdata, handles)
% hObject    handle to Voltage_I (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of Voltage_I as text
%        str2double(get(hObject,'String')) returns contents of Voltage_I as a double


% --- Executes during object creation, after setting all properties.
function Voltage_I_CreateFcn(hObject, eventdata, handles)
% hObject    handle to Voltage_I (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in Sweep_Parameters.
function Sweep_Parameters_Callback(hObject, eventdata, handles)
% hObject    handle to Sweep_Parameters (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
ExperimentYaoFunctionPool('Sweep Parameters',hObject, eventdata, handles)



function Sweep_Parameters_Start_Callback(hObject, eventdata, handles)
% hObject    handle to Sweep_Parameters_Start (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of Sweep_Parameters_Start as text
%        str2double(get(hObject,'String')) returns contents of Sweep_Parameters_Start as a double


% --- Executes during object creation, after setting all properties.
function Sweep_Parameters_Start_CreateFcn(hObject, eventdata, handles)
% hObject    handle to Sweep_Parameters_Start (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function Sweep_Parameters_End_Callback(hObject, eventdata, handles)
% hObject    handle to Sweep_Parameters_End (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of Sweep_Parameters_End as text
%        str2double(get(hObject,'String')) returns contents of Sweep_Parameters_End as a double


% --- Executes during object creation, after setting all properties.
function Sweep_Parameters_End_CreateFcn(hObject, eventdata, handles)
% hObject    handle to Sweep_Parameters_End (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function Sweep_Parameters_Step_Callback(hObject, eventdata, handles)
% hObject    handle to Sweep_Parameters_Step (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of Sweep_Parameters_Step as text
%        str2double(get(hObject,'String')) returns contents of Sweep_Parameters_Step as a double


% --- Executes during object creation, after setting all properties.
function Sweep_Parameters_Step_CreateFcn(hObject, eventdata, handles)
% hObject    handle to Sweep_Parameters_Step (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in Sweep_Parameters_String.
function Sweep_Parameters_String_Callback(hObject, eventdata, handles)
% hObject    handle to Sweep_Parameters_String (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns Sweep_Parameters_String contents as cell array
%        contents{get(hObject,'Value')} returns selected item from Sweep_Parameters_String


% --- Executes during object creation, after setting all properties.
function Sweep_Parameters_String_CreateFcn(hObject, eventdata, handles)
% hObject    handle to Sweep_Parameters_String (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: listbox controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in Sweep_Parameters_Seq.
function Sweep_Parameters_Seq_Callback(hObject, eventdata, handles)
% hObject    handle to Sweep_Parameters_Seq (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns Sweep_Parameters_Seq contents as cell array
%        contents{get(hObject,'Value')} returns selected item from Sweep_Parameters_Seq


% --- Executes during object creation, after setting all properties.
function Sweep_Parameters_Seq_CreateFcn(hObject, eventdata, handles)
% hObject    handle to Sweep_Parameters_Seq (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: listbox controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in Stop.
function Stop_Callback(hObject, eventdata, handles)
% hObject    handle to Stop (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
ExperimentYaoFunctionPool('Stop',hObject, eventdata, handles)



function Voltage_Q_Callback(hObject, eventdata, handles)
% hObject    handle to Voltage_Q (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of Voltage_Q as text
%        str2double(get(hObject,'String')) returns contents of Voltage_Q as a double


% --- Executes during object creation, after setting all properties.
function Voltage_Q_CreateFcn(hObject, eventdata, handles)
% hObject    handle to Voltage_Q (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in Pi_Pulse_Cal.
function Pi_Pulse_Cal_Callback(hObject, eventdata, handles)
% hObject    handle to Pi_Pulse_Cal (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
ExperimentYaoFunctionPool('Pi Pulse Calibrate',hObject, eventdata, handles)


function Pi_Pulse_Number_Callback(hObject, eventdata, handles)
% hObject    handle to Pi_Pulse_Number (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of Pi_Pulse_Number as text
%        str2double(get(hObject,'String')) returns contents of Pi_Pulse_Number as a double


% --- Executes during object creation, after setting all properties.
function Pi_Pulse_Number_CreateFcn(hObject, eventdata, handles)
% hObject    handle to Pi_Pulse_Number (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function Pi_Pulse_Amplitude_Start_Callback(hObject, eventdata, handles)
% hObject    handle to Pi_Pulse_Amplitude_Start (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of Pi_Pulse_Amplitude_Start as text
%        str2double(get(hObject,'String')) returns contents of Pi_Pulse_Amplitude_Start as a double


% --- Executes during object creation, after setting all properties.
function Pi_Pulse_Amplitude_Start_CreateFcn(hObject, eventdata, handles)
% hObject    handle to Pi_Pulse_Amplitude_Start (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function Pi_Pulse_Amplitude_End_Callback(hObject, eventdata, handles)
% hObject    handle to Pi_Pulse_Amplitude_End (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of Pi_Pulse_Amplitude_End as text
%        str2double(get(hObject,'String')) returns contents of Pi_Pulse_Amplitude_End as a double


% --- Executes during object creation, after setting all properties.
function Pi_Pulse_Amplitude_End_CreateFcn(hObject, eventdata, handles)
% hObject    handle to Pi_Pulse_Amplitude_End (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function Pi_Pulse_Amplitude_Step_Callback(hObject, eventdata, handles)
% hObject    handle to Pi_Pulse_Amplitude_Step (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of Pi_Pulse_Amplitude_Step as text
%        str2double(get(hObject,'String')) returns contents of Pi_Pulse_Amplitude_Step as a double


% --- Executes during object creation, after setting all properties.
function Pi_Pulse_Amplitude_Step_CreateFcn(hObject, eventdata, handles)
% hObject    handle to Pi_Pulse_Amplitude_Step (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function Loop_Standard_Callback(hObject, eventdata, handles)
% hObject    handle to Loop_Standard (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of Loop_Standard as text
%        str2double(get(hObject,'String')) returns contents of Loop_Standard as a double


% --- Executes during object creation, after setting all properties.
function Loop_Standard_CreateFcn(hObject, eventdata, handles)
% hObject    handle to Loop_Standard (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function Loop_Count_Callback(hObject, eventdata, handles)
% hObject    handle to Loop_Count (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of Loop_Count as text
%        str2double(get(hObject,'String')) returns contents of Loop_Count as a double


% --- Executes during object creation, after setting all properties.
function Loop_Count_CreateFcn(hObject, eventdata, handles)
% hObject    handle to Loop_Count (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in pushbutton21.
function pushbutton21_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton21 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
ExperimentYaoFunctionPool('T1',hObject, eventdata, handles)



function T1_Start_Callback(hObject, eventdata, handles)
% hObject    handle to T1_Start (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of T1_Start as text
%        str2double(get(hObject,'String')) returns contents of T1_Start as a double


% --- Executes during object creation, after setting all properties.
function T1_Start_CreateFcn(hObject, eventdata, handles)
% hObject    handle to T1_Start (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function T1_End_Callback(hObject, eventdata, handles)
% hObject    handle to T1_End (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of T1_End as text
%        str2double(get(hObject,'String')) returns contents of T1_End as a double


% --- Executes during object creation, after setting all properties.
function T1_End_CreateFcn(hObject, eventdata, handles)
% hObject    handle to T1_End (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function T1_Step_Callback(hObject, eventdata, handles)
% hObject    handle to T1_Step (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of T1_Step as text
%        str2double(get(hObject,'String')) returns contents of T1_Step as a double


% --- Executes during object creation, after setting all properties.
function T1_Step_CreateFcn(hObject, eventdata, handles)
% hObject    handle to T1_Step (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function Ramsey_Rounds_Callback(hObject, eventdata, handles)
% hObject    handle to Ramsey_Rounds (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of Ramsey_Rounds as text
%        str2double(get(hObject,'String')) returns contents of Ramsey_Rounds as a double


% --- Executes during object creation, after setting all properties.
function Ramsey_Rounds_CreateFcn(hObject, eventdata, handles)
% hObject    handle to Ramsey_Rounds (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in Stop_After_Round.
function Stop_After_Round_Callback(hObject, eventdata, handles)
% hObject    handle to Stop_After_Round (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
ExperimentYaoFunctionPool('Stop After Round',hObject, eventdata, handles)


% --- Executes on button press in Analyze_NV.
function Analyze_NV_Callback(hObject, eventdata, handles)
% hObject    handle to Analyze_NV (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
ExperimentYaoFunctionPool('AnalyzeNV',hObject, eventdata, handles)



function Iteration_Repeats_Callback(hObject, eventdata, handles)
% hObject    handle to Iteration_Repeats (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of Iteration_Repeats as text
%        str2double(get(hObject,'String')) returns contents of Iteration_Repeats as a double


% --- Executes during object creation, after setting all properties.
function Iteration_Repeats_CreateFcn(hObject, eventdata, handles)
% hObject    handle to Iteration_Repeats (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in p_DC.
function DC_p_Callback(hObject, eventdata, handles)
% hObject    handle to p_DC (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
ExperimentYaoFunctionPool('DC_p',hObject, eventdata, handles)


% --- Executes during object creation, after setting all properties.
function p_DC_CreateFcn(hObject, eventdata, handles)
% hObject    handle to p_DC (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
