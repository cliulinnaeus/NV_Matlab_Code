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

% Last Modified by GUIDE v2.5 03-Jun-2016 18:24:50

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



function DCAn1_Callback(hObject, eventdata, handles)
% hObject    handle to DCAn1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of DCAn1 as text
%        str2double(get(hObject,'String')) returns contents of DCAn1 as a double


% --- Executes during object creation, after setting all properties.
function DCAn1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to DCAn1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function DCAn2_Callback(hObject, eventdata, handles)
% hObject    handle to DCAn2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of DCAn2 as text
%        str2double(get(hObject,'String')) returns contents of DCAn2 as a double


% --- Executes during object creation, after setting all properties.
function DCAn2_CreateFcn(hObject, eventdata, handles)
% hObject    handle to DCAn2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function DCAn3_Callback(hObject, eventdata, handles)
% hObject    handle to DCAn3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of DCAn3 as text
%        str2double(get(hObject,'String')) returns contents of DCAn3 as a double


% --- Executes during object creation, after setting all properties.
function DCAn3_CreateFcn(hObject, eventdata, handles)
% hObject    handle to DCAn3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function DCAn4_Callback(hObject, eventdata, handles)
% hObject    handle to DCAn4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of DCAn4 as text
%        str2double(get(hObject,'String')) returns contents of DCAn4 as a double


% --- Executes during object creation, after setting all properties.
function DCAn4_CreateFcn(hObject, eventdata, handles)
% hObject    handle to DCAn4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function DCMk1_Callback(hObject, eventdata, handles)
% hObject    handle to DCMk1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of DCMk1 as text
%        str2double(get(hObject,'String')) returns contents of DCMk1 as a double


% --- Executes during object creation, after setting all properties.
function DCMk1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to DCMk1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function DCMk2_Callback(hObject, eventdata, handles)
% hObject    handle to DCMk2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of DCMk2 as text
%        str2double(get(hObject,'String')) returns contents of DCMk2 as a double


% --- Executes during object creation, after setting all properties.
function DCMk2_CreateFcn(hObject, eventdata, handles)
% hObject    handle to DCMk2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function DCMk3_Callback(hObject, eventdata, handles)
% hObject    handle to DCMk3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of DCMk3 as text
%        str2double(get(hObject,'String')) returns contents of DCMk3 as a double


% --- Executes during object creation, after setting all properties.
function DCMk3_CreateFcn(hObject, eventdata, handles)
% hObject    handle to DCMk3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function DCMk4_Callback(hObject, eventdata, handles)
% hObject    handle to DCMk4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of DCMk4 as text
%        str2double(get(hObject,'String')) returns contents of DCMk4 as a double


% --- Executes during object creation, after setting all properties.
function DCMk4_CreateFcn(hObject, eventdata, handles)
% hObject    handle to DCMk4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function DCMk5_Callback(hObject, eventdata, handles)
% hObject    handle to DCMk5 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of DCMk5 as text
%        str2double(get(hObject,'String')) returns contents of DCMk5 as a double


% --- Executes during object creation, after setting all properties.
function DCMk5_CreateFcn(hObject, eventdata, handles)
% hObject    handle to DCMk5 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function DCMk6_Callback(hObject, eventdata, handles)
% hObject    handle to DCMk6 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of DCMk6 as text
%        str2double(get(hObject,'String')) returns contents of DCMk6 as a double


% --- Executes during object creation, after setting all properties.
function DCMk6_CreateFcn(hObject, eventdata, handles)
% hObject    handle to DCMk6 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function DCMk7_Callback(hObject, eventdata, handles)
% hObject    handle to DCMk7 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of DCMk7 as text
%        str2double(get(hObject,'String')) returns contents of DCMk7 as a double


% --- Executes during object creation, after setting all properties.
function DCMk7_CreateFcn(hObject, eventdata, handles)
% hObject    handle to DCMk7 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function DCMk8_Callback(hObject, eventdata, handles)
% hObject    handle to DCMk8 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of DCMk8 as text
%        str2double(get(hObject,'String')) returns contents of DCMk8 as a double


% --- Executes during object creation, after setting all properties.
function DCMk8_CreateFcn(hObject, eventdata, handles)
% hObject    handle to DCMk8 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function AmpAn1_Callback(hObject, eventdata, handles)
% hObject    handle to AmpAn1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of AmpAn1 as text
%        str2double(get(hObject,'String')) returns contents of AmpAn1 as a double


% --- Executes during object creation, after setting all properties.
function AmpAn1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to AmpAn1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function AmpAn2_Callback(hObject, eventdata, handles)
% hObject    handle to AmpAn2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of AmpAn2 as text
%        str2double(get(hObject,'String')) returns contents of AmpAn2 as a double


% --- Executes during object creation, after setting all properties.
function AmpAn2_CreateFcn(hObject, eventdata, handles)
% hObject    handle to AmpAn2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function AmpAn3_Callback(hObject, eventdata, handles)
% hObject    handle to AmpAn3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of AmpAn3 as text
%        str2double(get(hObject,'String')) returns contents of AmpAn3 as a double


% --- Executes during object creation, after setting all properties.
function AmpAn3_CreateFcn(hObject, eventdata, handles)
% hObject    handle to AmpAn3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function AmpAn4_Callback(hObject, eventdata, handles)
% hObject    handle to AmpAn4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of AmpAn4 as text
%        str2double(get(hObject,'String')) returns contents of AmpAn4 as a double


% --- Executes during object creation, after setting all properties.
function AmpAn4_CreateFcn(hObject, eventdata, handles)
% hObject    handle to AmpAn4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function AmpMk1_Callback(hObject, eventdata, handles)
% hObject    handle to AmpMk1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of AmpMk1 as text
%        str2double(get(hObject,'String')) returns contents of AmpMk1 as a double


% --- Executes during object creation, after setting all properties.
function AmpMk1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to AmpMk1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function AmpMk2_Callback(hObject, eventdata, handles)
% hObject    handle to AmpMk2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of AmpMk2 as text
%        str2double(get(hObject,'String')) returns contents of AmpMk2 as a double


% --- Executes during object creation, after setting all properties.
function AmpMk2_CreateFcn(hObject, eventdata, handles)
% hObject    handle to AmpMk2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function AmpMk3_Callback(hObject, eventdata, handles)
% hObject    handle to AmpMk3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of AmpMk3 as text
%        str2double(get(hObject,'String')) returns contents of AmpMk3 as a double


% --- Executes during object creation, after setting all properties.
function AmpMk3_CreateFcn(hObject, eventdata, handles)
% hObject    handle to AmpMk3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function AmpMk4_Callback(hObject, eventdata, handles)
% hObject    handle to AmpMk4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of AmpMk4 as text
%        str2double(get(hObject,'String')) returns contents of AmpMk4 as a double


% --- Executes during object creation, after setting all properties.
function AmpMk4_CreateFcn(hObject, eventdata, handles)
% hObject    handle to AmpMk4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function AmpMk5_Callback(hObject, eventdata, handles)
% hObject    handle to AmpMk5 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of AmpMk5 as text
%        str2double(get(hObject,'String')) returns contents of AmpMk5 as a double


% --- Executes during object creation, after setting all properties.
function AmpMk5_CreateFcn(hObject, eventdata, handles)
% hObject    handle to AmpMk5 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function AmpMk6_Callback(hObject, eventdata, handles)
% hObject    handle to AmpMk6 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of AmpMk6 as text
%        str2double(get(hObject,'String')) returns contents of AmpMk6 as a double


% --- Executes during object creation, after setting all properties.
function AmpMk6_CreateFcn(hObject, eventdata, handles)
% hObject    handle to AmpMk6 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function AmpMk7_Callback(hObject, eventdata, handles)
% hObject    handle to AmpMk7 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of AmpMk7 as text
%        str2double(get(hObject,'String')) returns contents of AmpMk7 as a double


% --- Executes during object creation, after setting all properties.
function AmpMk7_CreateFcn(hObject, eventdata, handles)
% hObject    handle to AmpMk7 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function AmpMk8_Callback(hObject, eventdata, handles)
% hObject    handle to AmpMk8 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of AmpMk8 as text
%        str2double(get(hObject,'String')) returns contents of AmpMk8 as a double


% --- Executes during object creation, after setting all properties.
function AmpMk8_CreateFcn(hObject, eventdata, handles)
% hObject    handle to AmpMk8 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function Sweep_Parameter_String_Callback(hObject, eventdata, handles)
% hObject    handle to Sweep_Parameter_String (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of Sweep_Parameter_String as text
%        str2double(get(hObject,'String')) returns contents of Sweep_Parameter_String as a double


% --- Executes during object creation, after setting all properties.
function Sweep_Parameter_String_CreateFcn(hObject, eventdata, handles)
% hObject    handle to Sweep_Parameter_String (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function Sweep_Min_Callback(hObject, eventdata, handles)
% hObject    handle to Sweep_Min (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of Sweep_Min as text
%        str2double(get(hObject,'String')) returns contents of Sweep_Min as a double


% --- Executes during object creation, after setting all properties.
function Sweep_Min_CreateFcn(hObject, eventdata, handles)
% hObject    handle to Sweep_Min (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function Sweep_Max_Callback(hObject, eventdata, handles)
% hObject    handle to Sweep_Max (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of Sweep_Max as text
%        str2double(get(hObject,'String')) returns contents of Sweep_Max as a double


% --- Executes during object creation, after setting all properties.
function Sweep_Max_CreateFcn(hObject, eventdata, handles)
% hObject    handle to Sweep_Max (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function Sweep_Step_Callback(hObject, eventdata, handles)
% hObject    handle to Sweep_Step (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of Sweep_Step as text
%        str2double(get(hObject,'String')) returns contents of Sweep_Step as a double


% --- Executes during object creation, after setting all properties.
function Sweep_Step_CreateFcn(hObject, eventdata, handles)
% hObject    handle to Sweep_Step (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in Populate_Sweep_Vector.
function Populate_Sweep_Vector_Callback(hObject, eventdata, handles)
% hObject    handle to Populate_Sweep_Vector (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)



function Sweep_Vector_Callback(hObject, eventdata, handles)
% hObject    handle to Sweep_Vector (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of Sweep_Vector as text
%        str2double(get(hObject,'String')) returns contents of Sweep_Vector as a double


% --- Executes during object creation, after setting all properties.
function Sweep_Vector_CreateFcn(hObject, eventdata, handles)
% hObject    handle to Sweep_Vector (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function WFCh1_Callback(hObject, eventdata, handles)
% hObject    handle to WFCh1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of WFCh1 as text
%        str2double(get(hObject,'String')) returns contents of WFCh1 as a double


% --- Executes during object creation, after setting all properties.
function WFCh1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to WFCh1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function WFCh2_Callback(hObject, eventdata, handles)
% hObject    handle to WFCh2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of WFCh2 as text
%        str2double(get(hObject,'String')) returns contents of WFCh2 as a double


% --- Executes during object creation, after setting all properties.
function WFCh2_CreateFcn(hObject, eventdata, handles)
% hObject    handle to WFCh2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function WFCh3_Callback(hObject, eventdata, handles)
% hObject    handle to WFCh3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of WFCh3 as text
%        str2double(get(hObject,'String')) returns contents of WFCh3 as a double


% --- Executes during object creation, after setting all properties.
function WFCh3_CreateFcn(hObject, eventdata, handles)
% hObject    handle to WFCh3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function WFCh4_Callback(hObject, eventdata, handles)
% hObject    handle to WFCh4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of WFCh4 as text
%        str2double(get(hObject,'String')) returns contents of WFCh4 as a double


% --- Executes during object creation, after setting all properties.
function WFCh4_CreateFcn(hObject, eventdata, handles)
% hObject    handle to WFCh4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function WFMk1_Callback(hObject, eventdata, handles)
% hObject    handle to WFMk1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of WFMk1 as text
%        str2double(get(hObject,'String')) returns contents of WFMk1 as a double


% --- Executes during object creation, after setting all properties.
function WFMk1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to WFMk1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function WFMk2_Callback(hObject, eventdata, handles)
% hObject    handle to WFMk2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of WFMk2 as text
%        str2double(get(hObject,'String')) returns contents of WFMk2 as a double


% --- Executes during object creation, after setting all properties.
function WFMk2_CreateFcn(hObject, eventdata, handles)
% hObject    handle to WFMk2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function WFMk3_Callback(hObject, eventdata, handles)
% hObject    handle to WFMk3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of WFMk3 as text
%        str2double(get(hObject,'String')) returns contents of WFMk3 as a double


% --- Executes during object creation, after setting all properties.
function WFMk3_CreateFcn(hObject, eventdata, handles)
% hObject    handle to WFMk3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function WFMk4_Callback(hObject, eventdata, handles)
% hObject    handle to WFMk4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of WFMk4 as text
%        str2double(get(hObject,'String')) returns contents of WFMk4 as a double


% --- Executes during object creation, after setting all properties.
function WFMk4_CreateFcn(hObject, eventdata, handles)
% hObject    handle to WFMk4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function WFMk5_Callback(hObject, eventdata, handles)
% hObject    handle to WFMk5 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of WFMk5 as text
%        str2double(get(hObject,'String')) returns contents of WFMk5 as a double


% --- Executes during object creation, after setting all properties.
function WFMk5_CreateFcn(hObject, eventdata, handles)
% hObject    handle to WFMk5 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function WFMk6_Callback(hObject, eventdata, handles)
% hObject    handle to WFMk6 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of WFMk6 as text
%        str2double(get(hObject,'String')) returns contents of WFMk6 as a double


% --- Executes during object creation, after setting all properties.
function WFMk6_CreateFcn(hObject, eventdata, handles)
% hObject    handle to WFMk6 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function WFMk7_Callback(hObject, eventdata, handles)
% hObject    handle to WFMk7 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of WFMk7 as text
%        str2double(get(hObject,'String')) returns contents of WFMk7 as a double


% --- Executes during object creation, after setting all properties.
function WFMk7_CreateFcn(hObject, eventdata, handles)
% hObject    handle to WFMk7 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function WFMk8_Callback(hObject, eventdata, handles)
% hObject    handle to WFMk8 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of WFMk8 as text
%        str2double(get(hObject,'String')) returns contents of WFMk8 as a double


% --- Executes during object creation, after setting all properties.
function WFMk8_CreateFcn(hObject, eventdata, handles)
% hObject    handle to WFMk8 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in UseCh1.
function UseCh1_Callback(hObject, eventdata, handles)
% hObject    handle to UseCh1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of UseCh1


% --- Executes on button press in UseCh2.
function UseCh2_Callback(hObject, eventdata, handles)
% hObject    handle to UseCh2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of UseCh2


% --- Executes on button press in UseCh3.
function UseCh3_Callback(hObject, eventdata, handles)
% hObject    handle to UseCh3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of UseCh3


% --- Executes on button press in UseCh4.
function UseCh4_Callback(hObject, eventdata, handles)
% hObject    handle to UseCh4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of UseCh4
