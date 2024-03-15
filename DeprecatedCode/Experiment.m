function varargout = Experiment(varargin)
% SAVEAS M-file for Experiment.fig
%      SAVEAS, by itself, creates a new SAVEAS or raises the existing
%      singleton*.
%
%      H = SAVEAS returns the handle to a new SAVEAS or the handle to
%      the existing singleton*.
%
%      SAVEAS('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in SAVEAS.M with the given input arguments.
%
%      SAVEAS('Property','Value',...) creates a new SAVEAS or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before Experiment_OpeningFunction gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to Experiment_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to runsequence (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help Experiment

% Last Modified by GUIDE v2.5 18-Jun-2015 18:27:12

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @Experiment_OpeningFcn, ...
                   'gui_OutputFcn',  @Experiment_OutputFcn, ...
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


% --- Executes just before Experiment is made visible.
function Experiment_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to Experiment (see VARARGIN)

% Choose default command line output for Experiment
handles.output = hObject;

% added 18 Sept 2008, jhodges
% on window close, call this function as a safety precaution
set(handles.figure1,'CloseRequestFcn',@closeGUI);

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes Experiment wait for user response (see UIRESUME)
% uiwait(handles.figure1);
ExperimentFunctionPool('Initialize',hObject, eventdata, handles);
set(handles.bLDC,'Value',1);

% --- Outputs from this function are returned to the command line.
function varargout = Experiment_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on selection change in SEQUENCE.
function SEQUENCE_Callback(hObject, eventdata, handles)
% hObject    handle to SEQUENCE (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = get(hObject,'String') returns SEQUENCE contents as cell array
%        contents{get(hObject,'Value')} returns selected item from SEQUENCE


% --- Executes during object creation, after setting all properties.
function SEQUENCE_CreateFcn(hObject, eventdata, handles)
% hObject    handle to SEQUENCE (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in PBN.
function PBN_Callback(hObject, eventdata, handles)
% hObject    handle to PBN (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = get(hObject,'String') returns PBN contents as cell array
%        contents{get(hObject,'Value')} returns selected item from PBN


% --- Executes during object creation, after setting all properties.
function PBN_CreateFcn(hObject, eventdata, handles)
% hObject    handle to PBN (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in SweepRiseType.
function SweepRiseType_Callback(hObject, eventdata, handles)
% hObject    handle to SweepRiseType (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = get(hObject,'String') returns SweepRiseType contents as cell array
%        contents{get(hObject,'Value')} returns selected item from SweepRiseType
ExperimentFunctionPool('UpdateSweepRiseType',hObject, eventdata, handles);


% --- Executes during object creation, after setting all properties.
function SweepRiseType_CreateFcn(hObject, eventdata, handles)
% hObject    handle to SweepRiseType (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in TorDT.
function TorDT_Callback(hObject, eventdata, handles)
% hObject    handle to TorDT (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = get(hObject,'String') returns TorDT contents as cell array
%        contents{get(hObject,'Value')} returns selected item from TorDT


% --- Executes during object creation, after setting all properties.
function TorDT_CreateFcn(hObject, eventdata, handles)
% hObject    handle to TorDT (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function FROM1_Callback(hObject, eventdata, handles)
% hObject    handle to FROM1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of FROM1 as text
%        str2double(get(hObject,'String')) returns contents of FROM1 as a double
ExperimentFunctionPool('UpdateSweepFrom',hObject, eventdata, handles);


% --- Executes during object creation, after setting all properties.
function FROM1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to FROM1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function TO1_Callback(hObject, eventdata, handles)
% hObject    handle to TO1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of TO1 as text
%        str2double(get(hObject,'String')) returns contents of TO1 as a double
ExperimentFunctionPool('UpdateSweepTo',hObject, eventdata, handles);


% --- Executes during object creation, after setting all properties.
function TO1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to TO1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in popupmenu5.
function popupmenu5_Callback(hObject, eventdata, handles)
% hObject    handle to popupmenu5 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = get(hObject,'String') returns popupmenu5 contents as cell array
%        contents{get(hObject,'Value')} returns selected item from popupmenu5


% --- Executes during object creation, after setting all properties.
function popupmenu5_CreateFcn(hObject, eventdata, handles)
% hObject    handle to popupmenu5 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in popupmenu6.
function popupmenu6_Callback(hObject, eventdata, handles)
% hObject    handle to popupmenu6 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = get(hObject,'String') returns popupmenu6 contents as cell array
%        contents{get(hObject,'Value')} returns selected item from popupmenu6


% --- Executes during object creation, after setting all properties.
function popupmenu6_CreateFcn(hObject, eventdata, handles)
% hObject    handle to popupmenu6 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in popupmenu7.
function popupmenu7_Callback(hObject, eventdata, handles)
% hObject    handle to popupmenu7 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = get(hObject,'String') returns popupmenu7 contents as cell array
%        contents{get(hObject,'Value')} returns selected item from popupmenu7


% --- Executes during object creation, after setting all properties.
function popupmenu7_CreateFcn(hObject, eventdata, handles)
% hObject    handle to popupmenu7 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit5_Callback(hObject, eventdata, handles)
% hObject    handle to edit5 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit5 as text
%        str2double(get(hObject,'String')) returns contents of edit5 as a double


% --- Executes during object creation, after setting all properties.
function edit5_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit5 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit6_Callback(hObject, eventdata, handles)
% hObject    handle to edit6 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit6 as text
%        str2double(get(hObject,'String')) returns contents of edit6 as a double


% --- Executes during object creation, after setting all properties.
function edit6_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit6 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in popupmenu8.
function popupmenu8_Callback(hObject, eventdata, handles)
% hObject    handle to popupmenu8 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = get(hObject,'String') returns popupmenu8 contents as cell array
%        contents{get(hObject,'Value')} returns selected item from popupmenu8


% --- Executes during object creation, after setting all properties.
function popupmenu8_CreateFcn(hObject, eventdata, handles)
% hObject    handle to popupmenu8 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in popupmenu9.
function popupmenu9_Callback(hObject, eventdata, handles)
% hObject    handle to popupmenu9 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = get(hObject,'String') returns popupmenu9 contents as cell array
%        contents{get(hObject,'Value')} returns selected item from popupmenu9


% --- Executes during object creation, after setting all properties.
function popupmenu9_CreateFcn(hObject, eventdata, handles)
% hObject    handle to popupmenu9 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in popupmenu10.
function popupmenu10_Callback(hObject, eventdata, handles)
% hObject    handle to popupmenu10 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = get(hObject,'String') returns popupmenu10 contents as cell array
%        contents{get(hObject,'Value')} returns selected item from popupmenu10


% --- Executes during object creation, after setting all properties.
function popupmenu10_CreateFcn(hObject, eventdata, handles)
% hObject    handle to popupmenu10 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit7_Callback(hObject, eventdata, handles)
% hObject    handle to edit7 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit7 as text
%        str2double(get(hObject,'String')) returns contents of edit7 as a double


% --- Executes during object creation, after setting all properties.
function edit7_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit7 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit8_Callback(hObject, eventdata, handles)
% hObject    handle to edit8 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit8 as text
%        str2double(get(hObject,'String')) returns contents of edit8 as a double


% --- Executes during object creation, after setting all properties.
function edit8_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit8 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in popupmenu11.
function popupmenu11_Callback(hObject, eventdata, handles)
% hObject    handle to popupmenu11 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = get(hObject,'String') returns popupmenu11 contents as cell array
%        contents{get(hObject,'Value')} returns selected item from popupmenu11


% --- Executes during object creation, after setting all properties.
function popupmenu11_CreateFcn(hObject, eventdata, handles)
% hObject    handle to popupmenu11 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in popupmenu12.
function popupmenu12_Callback(hObject, eventdata, handles)
% hObject    handle to popupmenu12 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = get(hObject,'String') returns popupmenu12 contents as cell array
%        contents{get(hObject,'Value')} returns selected item from popupmenu12


% --- Executes during object creation, after setting all properties.
function popupmenu12_CreateFcn(hObject, eventdata, handles)
% hObject    handle to popupmenu12 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in popupmenu13.
function popupmenu13_Callback(hObject, eventdata, handles)
% hObject    handle to popupmenu13 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = get(hObject,'String') returns popupmenu13 contents as cell array
%        contents{get(hObject,'Value')} returns selected item from popupmenu13


% --- Executes during object creation, after setting all properties.
function popupmenu13_CreateFcn(hObject, eventdata, handles)
% hObject    handle to popupmenu13 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit9_Callback(hObject, eventdata, handles)
% hObject    handle to edit9 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit9 as text
%        str2double(get(hObject,'String')) returns contents of edit9 as a double


% --- Executes during object creation, after setting all properties.
function edit9_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit9 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit10_Callback(hObject, eventdata, handles)
% hObject    handle to edit10 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit10 as text
%        str2double(get(hObject,'String')) returns contents of edit10 as a double


% --- Executes during object creation, after setting all properties.
function edit10_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit10 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in popupmenu14.
function popupmenu14_Callback(hObject, eventdata, handles)
% hObject    handle to popupmenu14 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = get(hObject,'String') returns popupmenu14 contents as cell array
%        contents{get(hObject,'Value')} returns selected item from popupmenu14


% --- Executes during object creation, after setting all properties.
function popupmenu14_CreateFcn(hObject, eventdata, handles)
% hObject    handle to popupmenu14 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in popupmenu15.
function popupmenu15_Callback(hObject, eventdata, handles)
% hObject    handle to popupmenu15 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = get(hObject,'String') returns popupmenu15 contents as cell array
%        contents{get(hObject,'Value')} returns selected item from popupmenu15


% --- Executes during object creation, after setting all properties.
function popupmenu15_CreateFcn(hObject, eventdata, handles)
% hObject    handle to popupmenu15 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in popupmenu16.
function popupmenu16_Callback(hObject, eventdata, handles)
% hObject    handle to popupmenu16 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = get(hObject,'String') returns popupmenu16 contents as cell array
%        contents{get(hObject,'Value')} returns selected item from popupmenu16


% --- Executes during object creation, after setting all properties.
function popupmenu16_CreateFcn(hObject, eventdata, handles)
% hObject    handle to popupmenu16 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit11_Callback(hObject, eventdata, handles)
% hObject    handle to edit11 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit11 as text
%        str2double(get(hObject,'String')) returns contents of edit11 as a double


% --- Executes during object creation, after setting all properties.
function edit11_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit11 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit12_Callback(hObject, eventdata, handles)
% hObject    handle to edit12 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit12 as text
%        str2double(get(hObject,'String')) returns contents of edit12 as a double


% --- Executes during object creation, after setting all properties.
function edit12_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit12 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in popupmenu17.
function popupmenu17_Callback(hObject, eventdata, handles)
% hObject    handle to popupmenu17 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = get(hObject,'String') returns popupmenu17 contents as cell array
%        contents{get(hObject,'Value')} returns selected item from popupmenu17


% --- Executes during object creation, after setting all properties.
function popupmenu17_CreateFcn(hObject, eventdata, handles)
% hObject    handle to popupmenu17 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in popupmenu18.
function popupmenu18_Callback(hObject, eventdata, handles)
% hObject    handle to popupmenu18 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = get(hObject,'String') returns popupmenu18 contents as cell array
%        contents{get(hObject,'Value')} returns selected item from popupmenu18


% --- Executes during object creation, after setting all properties.
function popupmenu18_CreateFcn(hObject, eventdata, handles)
% hObject    handle to popupmenu18 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in popupmenu19.
function popupmenu19_Callback(hObject, eventdata, handles)
% hObject    handle to popupmenu19 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = get(hObject,'String') returns popupmenu19 contents as cell array
%        contents{get(hObject,'Value')} returns selected item from popupmenu19


% --- Executes during object creation, after setting all properties.
function popupmenu19_CreateFcn(hObject, eventdata, handles)
% hObject    handle to popupmenu19 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit13_Callback(hObject, eventdata, handles)
% hObject    handle to edit13 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit13 as text
%        str2double(get(hObject,'String')) returns contents of edit13 as a double


% --- Executes during object creation, after setting all properties.
function edit13_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit13 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit14_Callback(hObject, eventdata, handles)
% hObject    handle to edit14 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit14 as text
%        str2double(get(hObject,'String')) returns contents of edit14 as a double


% --- Executes during object creation, after setting all properties.
function edit14_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit14 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function SweepNPoints_Callback(hObject, eventdata, handles)
% hObject    handle to SweepNPoints (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of SweepNPoints as text
%        str2double(get(hObject,'String')) returns contents of SweepNPoints as a double
ExperimentFunctionPool('UpdateSweepNPoints',hObject, eventdata, handles);


% --- Executes during object creation, after setting all properties.
function SweepNPoints_CreateFcn(hObject, eventdata, handles)
% hObject    handle to SweepNPoints (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in SweepAddTime.
function SweepAddTime_Callback(hObject, eventdata, handles)
% hObject    handle to SweepAddTime (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on selection change in SweepFile.
function SweepFile_Callback(hObject, eventdata, handles)
% hObject    handle to SweepFile (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = get(hObject,'String') returns SweepFile contents as cell array
%        contents{get(hObject,'Value')} returns selected item from SweepFile


% --- Executes during object creation, after setting all properties.
function SweepFile_CreateFcn(hObject, eventdata, handles)
% hObject    handle to SweepFile (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in EditSequence.
function EditSequence_Callback(hObject, eventdata, handles)
% hObject    handle to EditSequence (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
axes(handles.axes1);
text(0,0,'Click to Redraw')
EditSequence;

function SweepAddedTime_Callback(hObject, eventdata, handles)
% hObject    handle to SweepAddedTime (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of SweepAddedTime as text
%        str2double(get(hObject,'String')) returns contents of SweepAddedTime as a double


% --- Executes during object creation, after setting all properties.
function SweepAddedTime_CreateFcn(hObject, eventdata, handles)
% hObject    handle to SweepAddedTime (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in OpenSequence.
function OpenSequence_Callback(hObject, eventdata, handles)
% hObject    handle to OpenSequence (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
OpenSequence(hObject, eventdata, handles);

% --- If Enable == 'on', executes on mouse press in 5 pixel border.
% --- Otherwise, executes on mouse press in 5 pixel border or over OpenSequence.
function OpenSequence_ButtonDownFcn(hObject, eventdata, handles)
% hObject    handle to OpenSequence (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)




% --- Executes on button press in RunSequence.
function RunSequence_Callback(hObject, eventdata, handles)
% hObject    handle to RunSequence (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
RunSequence('Run',hObject, eventdata, handles)




function Samples_Callback(hObject, eventdata, handles)
% hObject    handle to Samples (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of Samples as text
%        str2double(get(hObject,'String')) returns contents of Samples as a double


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


% --- Executes on button press in LioPB0.
function LioPB0_Callback(hObject, eventdata, handles)
% hObject    handle to LioPB0 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of LioPB0


% --- Executes on button press in LioPB1.
function LioPB1_Callback(hObject, eventdata, handles)
% hObject    handle to LioPB1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of LioPB1


% --- Executes on button press in LioPB2.
function LioPB2_Callback(hObject, eventdata, handles)
% hObject    handle to LioPB2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of LioPB2


% --- Executes on button press in LioPB3.
function LioPB3_Callback(hObject, eventdata, handles)
% hObject    handle to LioPB3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of LioPB3


% --- Executes on button press in LioPB4.
function LioPB4_Callback(hObject, eventdata, handles)
% hObject    handle to LioPB4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of LioPB4


% --- Executes on button press in LioPB5.
function LioPB5_Callback(hObject, eventdata, handles)
% hObject    handle to LioPB5 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of LioPB5


% --- Executes on button press in LioPB6.
function LioPB6_Callback(hObject, eventdata, handles)
% hObject    handle to LioPB6 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of LioPB6


% --- Executes on button press in LioPB7.
function LioPB7_Callback(hObject, eventdata, handles)
% hObject    handle to LioPB7 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of LioPB7


% --- Executes on button press in RunLeaveItOn.
function RunLeaveItOn_Callback(hObject, eventdata, handles)
% hObject    handle to RunLeaveItOn (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
%RunLeaveItOn(hObject, eventdata, handles)
ExperimentFunctionPool('PBON',hObject, eventdata, handles);

% --- Executes on button press in StopLeaveItOn.
function StopLeaveItOn_Callback(hObject, eventdata, handles)
% hObject    handle to StopLeaveItOn (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
%StopPulseBlaster;
ExperimentFunctionPool('PBOFF',hObject, eventdata, handles);



% --- Executes during object creation, after setting all properties.
function Sequence_CreateFcn(hObject, eventdata, handles)
% hObject    handle to Sequence (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called




% --- Executes on mouse press over axes background.
function axes1_ButtonDownFcn(hObject, eventdata, handles)
% hObject    handle to axes1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
CallDrawSequence(hObject, eventdata, handles);



% --- Executes on button press in SignalGenerator.
function SignalGenerator_Callback(hObject, eventdata, handles)
% hObject    handle to SignalGenerator (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
SignalGenerator;

% --- Executes on button press in TakeImage.
function TakeImage_Callback(hObject, eventdata, handles)
% hObject    handle to TakeImage (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
ImageNVC;



% --- Executes on button press in SweepSG.
function SweepSG_Callback(hObject, eventdata, handles)
% hObject    handle to SweepSG (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of SweepSG


% --- Executes on button press in CallMag.
function CallMag_Callback(hObject, eventdata, handles)
% hObject    handle to CallMag (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
Magnetometer(hObject, eventdata, handles);



% --- Executes on button press in ReadCounter.
function ReadCounter_Callback(hObject, eventdata, handles)
% hObject    handle to ReadCounter (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
bPhotodiode = get(handles.bPhotodiode,'Value');
if bPhotodiode == 1
    ExperimentAxes3('Photodiode',hObject, eventdata, handles);
else
    ExperimentAxes3('Counter0',hObject, eventdata, handles);
end



% --- Executes on button press in StopRead.
function StopRead_Callback(hObject, eventdata, handles)
% hObject    handle to StopRead (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
ExperimentAxes3('StopCounter0',hObject, eventdata, handles);
% ShutterControl(0);



% --- Executes on button press in bShift.
function bShift_Callback(hObject, eventdata, handles)
% hObject    handle to bShift (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of bShift
ExperimentFunctionPool('UpdateSweepbShift',hObject, eventdata, handles);


% --- Executes on button press in bShiftAll.
function bShiftAll_Callback(hObject, eventdata, handles)
% hObject    handle to bShiftAll (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of bShiftAll
ExperimentFunctionPool('UpdateSweepbShiftAll',hObject, eventdata, handles);


% --- Executes on button press in bRepeat.
function bRepeat_Callback(hObject, eventdata, handles)
% hObject    handle to bRepeat (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of bRepeat



function RepeatNTimes_Callback(hObject, eventdata, handles)
% hObject    handle to RepeatNTimes (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of RepeatNTimes as text
%        str2double(get(hObject,'String')) returns contents of RepeatNTimes as a double


% --- Executes during object creation, after setting all properties.
function RepeatNTimes_CreateFcn(hObject, eventdata, handles)
% hObject    handle to RepeatNTimes (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end




% --- Executes on button press in EditAxes3.
function EditAxes3_Callback(hObject, eventdata, handles)
% hObject    handle to EditAxes3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
ExperimentAxes3('EditAxes3',hObject, eventdata, handles);




% --- Executes on selection change in SweepType.
function SweepType_Callback(hObject, eventdata, handles)
% hObject    handle to SweepType (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = get(hObject,'String') returns SweepType contents as cell array
%        contents{get(hObject,'Value')} returns selected item from SweepType


% --- Executes during object creation, after setting all properties.
function SweepType_CreateFcn(hObject, eventdata, handles)
% hObject    handle to SweepType (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in bScale.
function bScale_Callback(hObject, eventdata, handles)
% hObject    handle to bScale (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of bScale
ExperimentFunctionPool('UpdateSweepbScale',hObject, eventdata, handles);


% --- Executes on button press in OpenSweepSeq.
function OpenSweepSeq_Callback(hObject, eventdata, handles)
% hObject    handle to OpenSweepSeq (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
ExperimentFunctionPool('OpenSweepSeq',hObject, eventdata, handles);

% --- Executes on button press in SweepSave.
function SweepSave_Callback(hObject, eventdata, handles)
% hObject    handle to SweepSave (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
ExperimentFunctionPool('SaveSweepSeq',hObject, eventdata, handles);

% --- Executes on button press in SweepSaveAs.
function SweepSaveAs_Callback(hObject, eventdata, handles)
% hObject    handle to SweepSaveAs (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
ExperimentFunctionPool('SaveAsSweepSeq',hObject, eventdata, handles);


% --- Executes on selection change in SweepDim.
function SweepDim_Callback(hObject, eventdata, handles)
% hObject    handle to SweepDim (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = get(hObject,'String') returns SweepDim contents as cell array
%        contents{get(hObject,'Value')} returns selected item from SweepDim
ExperimentFunctionPool('UpdateSweepDim',hObject, eventdata, handles);


% --- Executes during object creation, after setting all properties.
function SweepDim_CreateFcn(hObject, eventdata, handles)
% hObject    handle to SweepDim (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in bSweepSEQ.
function bSweepSEQ_Callback(hObject, eventdata, handles)
% hObject    handle to bSweepSEQ (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of bSweepSEQ


% --- Executes on button press in bDimN.
function bDimN_Callback(hObject, eventdata, handles)
% hObject    handle to bDimN (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of bDimN
ExperimentFunctionPool('UpdateSweepbEnable',hObject, eventdata, handles);


% --- Executes on button press in pulseWidth.
function pulseWidth_Callback(hObject, eventdata, handles)
% hObject    handle to pulseWidth (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
ExperimentAxes3('Counter0PulseWidth',hObject, eventdata, handles);




% --- Executes on button press in LoadExp.
function LoadExp_Callback(hObject, eventdata, handles)
% hObject    handle to LoadExp (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
ExperimentFunctionPool('LoadExp',hObject, eventdata, handles);


% --- Executes on button press in MakeReport.
function MakeReport_Callback(hObject, eventdata, handles)
% hObject    handle to MakeReport (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
ExperimentFunctionPool('MakeReportNew',hObject, eventdata, handles);

% --- Executes on button press in SaveExp.
function SaveExp_Callback(hObject, eventdata, handles)
% hObject    handle to SaveExp (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
ExperimentFunctionPool('SaveExp',hObject, eventdata, handles);


% --- Executes on button press in SaveAsExp.
function SaveAsExp_Callback(hObject, eventdata, handles)
% hObject    handle to SaveAsExp (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
ExperimentFunctionPool('SaveAsExp',hObject, eventdata, handles);



% --- Executes on button press in AddDim.
function AddDim_Callback(hObject, eventdata, handles)
% hObject    handle to AddDim (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in DeleteDim.
function DeleteDim_Callback(hObject, eventdata, handles)
% hObject    handle to DeleteDim (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)




% --- Executes on selection change in bRiseType.
function bRiseType_Callback(hObject, eventdata, handles)
% hObject    handle to bRiseType (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = get(hObject,'String') returns bRiseType contents as cell array
%        contents{get(hObject,'Value')} returns selected item from bRiseType
ExperimentFunctionPool('UpdateSweepbRiseType',hObject, eventdata, handles);


% --- Executes during object creation, after setting all properties.
function bRiseType_CreateFcn(hObject, eventdata, handles)
% hObject    handle to bRiseType (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end




% --- Executes on selection change in SweepPB.
function SweepPB_Callback(hObject, eventdata, handles)
% hObject    handle to SweepPB (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = get(hObject,'String') returns SweepPB contents as cell array
%        contents{get(hObject,'Value')} returns selected item from SweepPB
ExperimentFunctionPool('UpdateSweepPBN',hObject, eventdata, handles);




% --- Executes on selection change in SweepTorDT.
function SweepTorDT_Callback(hObject, eventdata, handles)
% hObject    handle to SweepTorDT (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = get(hObject,'String') returns SweepTorDT contents as cell array
%        contents{get(hObject,'Value')} returns selected item from SweepTorDT
ExperimentFunctionPool('UpdateSweepbTDT',hObject, eventdata, handles);




% --- Executes during object creation, after setting all properties.
function axes1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to axes1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: place code in OpeningFcn to populate axes1


% --- Executes on button press in bDoNotReadCtr.
function bDoNotReadCtr_Callback(hObject, eventdata, handles)
% hObject    handle to bDoNotReadCtr (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of bDoNotReadCtr


% --- Executes on button press in StopSeq.
function StopSeq_Callback(hObject, eventdata, handles)
% hObject    handle to StopSeq (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
RunSequence('Stop',hObject, eventdata, handles)




% --- If Enable == 'on', executes on mouse press in 5 pixel border.
% --- Otherwise, executes on mouse press in 5 pixel border or over MakeReport.
function MakeReport_ButtonDownFcn(hObject, eventdata, handles)
% hObject    handle to MakeReport (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)




% --------------------------------------------------------------------
function File_Callback(hObject, eventdata, handles)
% hObject    handle to File (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --------------------------------------------------------------------
function quit_Callback(hObject, eventdata, handles)
% hObject    handle to quit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
close();

% --------------------------------------------------------------------
function saveas_Callback(hObject, eventdata, handles)
% hObject    handle to saveas (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --------------------------------------------------------------------
function save_Callback(hObject, eventdata, handles)
% hObject    handle to save (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --------------------------------------------------------------------
function load_Callback(hObject, eventdata, handles)
% hObject    handle to load (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
ExperimentFunctionPool('LoadExp',hObject, eventdata, handles);

% --------------------------------------------------------------------
function experiment_Callback(hObject, eventdata, handles)
% hObject    handle to experiment (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --------------------------------------------------------------------
function make_report_Callback(hObject, eventdata, handles)
% hObject    handle to make_report (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
ExperimentFunctionPool('MakeReportNew',hObject, eventdata, handles);



% --- Executes during object creation, after setting all properties.
function axes2_CreateFcn(hObject, eventdata, handles)
% hObject    handle to axes2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: place code in OpeningFcn to populate axes2


% --- Executes on button press in RunSEQ.
function RunSEQ_Callback(hObject, eventdata, handles)
% hObject    handle to RunSEQ (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
ExperimentFunctionPool('JustRunSeq',hObject, eventdata, handles);


                                                                                             

% --- Executes on button press in bTracking.
function bTracking_Callback(hObject, eventdata, handles)
% hObject    handle to bTracking (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of bTracking

isChecked = get(hObject,'Value');

if isChecked,
    set(handles.text99,'Visible','on');    
    set(handles.refCountsText,'Visible','on');
else,
  set(handles.text99,'Visible','off');    
    set(handles.refCountsText,'Visible','off');
end
    


% --- Executes on button press in Add.



% --- Executes on button press in bAdd.
function bAdd_Callback(hObject, eventdata, handles)
% hObject    handle to bAdd (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of bAdd
ExperimentFunctionPool('UpdateSweepbAdd',hObject, eventdata, handles);




% --- Executes on button press in bPlotCV.
function bPlotCV_Callback(hObject, eventdata, handles)
% hObject    handle to bPlotCV (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of bPlotCV


% --- Executes on button press in bAverage.
function bAverage_Callback(hObject, eventdata, handles)
% hObject    handle to bAverage (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of bAverage



function Average_Callback(hObject, eventdata, handles)
% hObject    handle to Average (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of Average as text
%        str2double(get(hObject,'String')) returns contents of Average as a double


% --- Executes during object creation, after setting all properties.
function Average_CreateFcn(hObject, eventdata, handles)
% hObject    handle to Average (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in bTwoCounters.
function bTwoCounters_Callback(hObject, eventdata, handles)
% hObject    handle to bTwoCounters (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of bTwoCounters


% --- Executes on button press in cbSweepOther.
function cbSweepOther_Callback(hObject, eventdata, handles)
% hObject    handle to cbSweepOther (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of cbSweepOther


% --------------------------------------------------------------------
function menuConfigureSweepOther_Callback(hObject, eventdata, handles)
% hObject    handle to menuConfigureSweepOther (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
SweepOtherGUI();

% --------------------------------------------------------------------
function menuSweeps_Callback(hObject, eventdata, handles)
% hObject    handle to menuSweeps (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)





% --------------------------------------------------------------------
function clone_Callback(hObject, eventdata, handles)
% hObject    handle to clone (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
%
% Menu Item for Cloning
ExperimentFunctionPool('CloneExpFromReport',hObject, eventdata, handles);




% --------------------------------------------------------------------
function menuTracking_Callback(hObject, eventdata, handles)
% hObject    handle to menuTracking (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --------------------------------------------------------------------
function menuSetThreshold_Callback(hObject, eventdata, handles)
% hObject    handle to menuSetThreshold (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

ExperimentFunctionPool('SetThreshold',hObject, eventdata, handles);





% --------------------------------------------------------------------
function menuOpenPHD_Callback(hObject, eventdata, handles)
% hObject    handle to menuOpenPHD (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global gPHD;
gPHD = read_phd_harvard()



% --------------------------------------------------------------------
function menuDAQ_Callback(hObject, eventdata, handles)
% hObject    handle to menuDAQ (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in Wrap.
function Wrap_Callback(hObject, eventdata, handles)
% hObject    handle to Wrap (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of Wrap




% --- Executes on selection change in popupmenu30.
function popupmenu30_Callback(hObject, eventdata, handles)
% hObject    handle to popupmenu30 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = get(hObject,'String') returns popupmenu30 contents as cell array
%        contents{get(hObject,'Value')} returns selected item from popupmenu30


% --- Executes during object creation, after setting all properties.
function popupmenu30_CreateFcn(hObject, eventdata, handles)
% hObject    handle to popupmenu30 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in bImage.
function bImage_Callback(hObject, eventdata, handles)
% hObject    handle to bImage (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of bImage


% --- Executes on button press in bFourierDataStructure.
function bFourierDataStructure_Callback(hObject, eventdata, handles)
% hObject    handle to bFourierDataStructure (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of bFourierDataStructure


% --- Executes on button press in bPlotFourier.
function bPlotFourier_Callback(hObject, eventdata, handles)
% hObject    handle to bPlotFourier (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of bPlotFourier



function NFourierRuns_Callback(hObject, eventdata, handles)
% hObject    handle to NFourierRuns (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of NFourierRuns as text
%        str2double(get(hObject,'String')) returns contents of NFourierRuns as a double


% --- Executes during object creation, after setting all properties.
function NFourierRuns_CreateFcn(hObject, eventdata, handles)
% hObject    handle to NFourierRuns (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in bFourierSignalAxes2.
function bFourierSignalAxes2_Callback(hObject, eventdata, handles)
% hObject    handle to bFourierSignalAxes2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of bFourierSignalAxes2


% --- Executes on button press in bCFourierSignalAxes3.
function bCFourierSignalAxes3_Callback(hObject, eventdata, handles)
% hObject    handle to bCFourierSignalAxes3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of bCFourierSignalAxes3


% --- Executes on button press in Planner.
function Planner_Callback(hObject, eventdata, handles)
% hObject    handle to Planner (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
ExperimentFunctionPool('Planner',hObject, eventdata, handles);


function closeGUI(src,evnt)
%src is the handle of the object generating the callback (the source of the event)
%evnt is the The event data structure (can be empty for some callbacks)
selection = questdlg('Are you sure you want to close the Experiment?',...
                     'Close Request Function',...
                     'Yes','No','Yes');
switch selection,
   case 'Yes',
    delete(gcf)
   case 'No'
     return
end



% --- Executes on button press in bPhotodiode.
function bPhotodiode_Callback(hObject, eventdata, handles)
% hObject    handle to bPhotodiode (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of bPhotodiode


% --- Executes on button press in RunScriptSeq.
function RunScriptSeq_Callback(hObject, eventdata, handles)
% hObject    handle to RunScriptSeq (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
ShutterControl(1)
switch get(handles.ScriptSweepType,'Value')
    case 2
        RunPulseSeq(hObject, eventdata, handles);
    case 3
        SweepESR(hObject, eventdata, handles);
    case 4
        MeasureTemperature(hObject, eventdata, handles);
    case 5
        CalibrateTemperature(hObject, eventdata, handles);
    case 6
        HeatScan(hObject, eventdata, handles);
    case 7
        HeatGradient(hObject, eventdata, handles);
end
% ShutterControl(0)
%RunPulseSeq(hObject, eventdata, handles) 

% --- Executes on button press in StopScriptSeq.
function StopScriptSeq_Callback(hObject, eventdata, handles)
% hObject    handle to StopScriptSeq (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of StopScriptSeq


% --- Executes on selection change in ScriptSweepType.
function ScriptSweepType_Callback(hObject, eventdata, handles)
% hObject    handle to ScriptSweepType (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns ScriptSweepType contents as cell array
%        contents{get(hObject,'Value')} returns selected item from ScriptSweepType


% --- Executes during object creation, after setting all properties.
function ScriptSweepType_CreateFcn(hObject, eventdata, handles)
% hObject    handle to ScriptSweepType (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- If Enable == 'on', executes on mouse press in 5 pixel border.
% --- Otherwise, executes on mouse press in 5 pixel border or over ScriptSweepType.
function ScriptSweepType_ButtonDownFcn(hObject, eventdata, handles)
% hObject    handle to ScriptSweepType (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on key press with focus on ScriptSweepType and none of its controls.
function ScriptSweepType_KeyPressFcn(hObject, eventdata, handles)
% hObject    handle to ScriptSweepType (see GCBO)
% eventdata  structure with the following fields (see UICONTROL)
%	Key: name of the key that was pressed, in lower case
%	Character: character interpretation of the key(s) that was pressed
%	Modifier: name(s) of the modifier key(s) (i.e., control, shift) pressed
% handles    structure with handles and user data (see GUIDATA)


% --- Executes during object creation, after setting all properties.
function RunScriptSeq_CreateFcn(hObject, eventdata, handles)
% hObject    handle to RunScriptSeq (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called



function FromGHz_Callback(hObject, eventdata, handles)
% hObject    handle to FromGHz (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of FromGHz as text
%        str2double(get(hObject,'String')) returns contents of FromGHz as a double


% --- Executes during object creation, after setting all properties.
function FromGHz_CreateFcn(hObject, eventdata, handles)
% hObject    handle to FromGHz (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function ToGHz_Callback(hObject, eventdata, handles)
% hObject    handle to ToGHz (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of ToGHz as text
%        str2double(get(hObject,'String')) returns contents of ToGHz as a double


% --- Executes during object creation, after setting all properties.
function ToGHz_CreateFcn(hObject, eventdata, handles)
% hObject    handle to ToGHz (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in bDefault.
function bDefault_Callback(hObject, eventdata, handles)
% hObject    handle to bDefault (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of bDefault



function Om1_Callback(hObject, eventdata, handles)
% hObject    handle to Om1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of Om1 as text
%        str2double(get(hObject,'String')) returns contents of Om1 as a double


% --- Executes during object creation, after setting all properties.
function Om1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to Om1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function Om2_Callback(hObject, eventdata, handles)
% hObject    handle to Om2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of Om2 as text
%        str2double(get(hObject,'String')) returns contents of Om2 as a double


% --- Executes during object creation, after setting all properties.
function Om2_CreateFcn(hObject, eventdata, handles)
% hObject    handle to Om2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function uWdB_Callback(hObject, eventdata, handles)
% hObject    handle to uWdB (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of uWdB as text
%        str2double(get(hObject,'String')) returns contents of uWdB as a double


% --- Executes during object creation, after setting all properties.
function uWdB_CreateFcn(hObject, eventdata, handles)
% hObject    handle to uWdB (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function AvrgT_Callback(hObject, eventdata, handles)
% hObject    handle to AvrgT (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of AvrgT as text
%        str2double(get(hObject,'String')) returns contents of AvrgT as a double


% --- Executes during object creation, after setting all properties.
function AvrgT_CreateFcn(hObject, eventdata, handles)
% hObject    handle to AvrgT (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function StdT_Callback(hObject, eventdata, handles)
% hObject    handle to StdT (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of StdT as text
%        str2double(get(hObject,'String')) returns contents of StdT as a double


% --- Executes during object creation, after setting all properties.
function StdT_CreateFcn(hObject, eventdata, handles)
% hObject    handle to StdT (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function AvrgTimes_Callback(hObject, eventdata, handles)
% hObject    handle to AvrgTimes (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of AvrgTimes as text
%        str2double(get(hObject,'String')) returns contents of AvrgTimes as a double


% --- Executes during object creation, after setting all properties.
function AvrgTimes_CreateFcn(hObject, eventdata, handles)
% hObject    handle to AvrgTimes (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function TempSensitivity_Callback(hObject, eventdata, handles)
% hObject    handle to TempSensitivity (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of TempSensitivity as text
%        str2double(get(hObject,'String')) returns contents of TempSensitivity as a double


% --- Executes during object creation, after setting all properties.
function TempSensitivity_CreateFcn(hObject, eventdata, handles)
% hObject    handle to TempSensitivity (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function Vx_Callback(hObject, eventdata, handles)
% hObject    handle to Vx (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of Vx as text
%        str2double(get(hObject,'String')) returns contents of Vx as a double


% --- Executes during object creation, after setting all properties.
function Vx_CreateFcn(hObject, eventdata, handles)
% hObject    handle to Vx (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function Vy_Callback(hObject, eventdata, handles)
% hObject    handle to Vy (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of Vy as text
%        str2double(get(hObject,'String')) returns contents of Vy as a double


% --- Executes during object creation, after setting all properties.
function Vy_CreateFcn(hObject, eventdata, handles)
% hObject    handle to Vy (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function OffVx_Callback(hObject, eventdata, handles)
% hObject    handle to OffVx (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of OffVx as text
%        str2double(get(hObject,'String')) returns contents of OffVx as a double


% --- Executes during object creation, after setting all properties.
function OffVx_CreateFcn(hObject, eventdata, handles)
% hObject    handle to OffVx (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function OffVy_Callback(hObject, eventdata, handles)
% hObject    handle to OffVy (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of OffVy as text
%        str2double(get(hObject,'String')) returns contents of OffVy as a double


% --- Executes during object creation, after setting all properties.
function OffVy_CreateFcn(hObject, eventdata, handles)
% hObject    handle to OffVy (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function Vz_Callback(hObject, eventdata, handles)
% hObject    handle to Vz (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of Vz as text
%        str2double(get(hObject,'String')) returns contents of Vz as a double


% --- Executes during object creation, after setting all properties.
function Vz_CreateFcn(hObject, eventdata, handles)
% hObject    handle to Vz (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in bInfraredON.
function bInfraredON_Callback(hObject, eventdata, handles)
% hObject    handle to bInfraredON (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of bInfraredON



function NumTimes_Callback(hObject, eventdata, handles)
% hObject    handle to NumTimes (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of NumTimes as text
%        str2double(get(hObject,'String')) returns contents of NumTimes as a double


% --- Executes during object creation, after setting all properties.
function NumTimes_CreateFcn(hObject, eventdata, handles)
% hObject    handle to NumTimes (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function NV_Vx_Callback(hObject, eventdata, handles)
% hObject    handle to NV_Vx (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of NV_Vx as text
%        str2double(get(hObject,'String')) returns contents of NV_Vx as a double


% --- Executes during object creation, after setting all properties.
function NV_Vx_CreateFcn(hObject, eventdata, handles)
% hObject    handle to NV_Vx (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function NV_Vz_Callback(hObject, eventdata, handles)
% hObject    handle to NV_Vz (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of NV_Vz as text
%        str2double(get(hObject,'String')) returns contents of NV_Vz as a double


% --- Executes during object creation, after setting all properties.
function NV_Vz_CreateFcn(hObject, eventdata, handles)
% hObject    handle to NV_Vz (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function NV_Vy_Callback(hObject, eventdata, handles)
% hObject    handle to NV_Vy (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of NV_Vy as text
%        str2double(get(hObject,'String')) returns contents of NV_Vy as a double


% --- Executes during object creation, after setting all properties.
function NV_Vy_CreateFcn(hObject, eventdata, handles)
% hObject    handle to NV_Vy (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in GetNVPos.
function GetNVPos_Callback(hObject, eventdata, handles)
% hObject    handle to GetNVPos (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
temp_filename = 'CurrentNV_Position.txt';
temp_path = 'C:\MATLAB_Code\Sets';
fid = fopen([temp_path temp_filename],'r');
NV_Pos = fscanf(fid,'%f',[3,1]);
set(handles.NV_Vx,'String',num2str(NV_Pos(1)));
set(handles.NV_Vy,'String',num2str(NV_Pos(2)));
set(handles.NV_Vz,'String',num2str(NV_Pos(3)));
fclose(fid);





function rf_power_Callback(hObject, eventdata, handles)
% hObject    handle to rf_power (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of rf_power as text
%        str2double(get(hObject,'String')) returns contents of rf_power as a double


% --- Executes during object creation, after setting all properties.
function rf_power_CreateFcn(hObject, eventdata, handles)
% hObject    handle to rf_power (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit45_Callback(hObject, eventdata, handles)
% hObject    handle to edit45 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit45 as text
%        str2double(get(hObject,'String')) returns contents of edit45 as a double


% --- Executes during object creation, after setting all properties.
function edit45_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit45 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in pushbutton29.
function pushbutton29_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton29 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
MultipleNVs('Assign_freq',hObject, eventdata, handles)


% --- Executes on button press in pushbutton30.
function pushbutton30_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton30 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
ShutterControl(1);
MultipleNVs('Calibrate_NVs',hObject, eventdata, handles)
ShutterControl(0);



% --- Executes on button press in bLDC.
function bLDC_Callback(hObject, eventdata, handles)
% hObject    handle to bLDC (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of bLDC



function LDpower_Callback(hObject, eventdata, handles)
% hObject    handle to LDpower (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of LDpower as text
%        str2double(get(hObject,'String')) returns contents of LDpower as a double


% --- Executes during object creation, after setting all properties.
function LDpower_CreateFcn(hObject, eventdata, handles)
% hObject    handle to LDpower (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in GreenPort.
function GreenPort_Callback(hObject, eventdata, handles)
% hObject    handle to GreenPort (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
bSwitch = get(handles.bSwitch,'Value');
APDControl('green', bSwitch);
ShutterControl(1);


% --- Executes on button press in BluePort.
function BluePort_Callback(hObject, eventdata, handles)
% hObject    handle to BluePort (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
bSwitch = get(handles.bSwitch,'Value');
APDControl('blue', bSwitch);
ShutterControl(0);


function APDControl(what, bSwitch)

if bSwitch
    s = serial('COM7'); % APD switch
    set(s,'BaudRate',115200)
    set(s,'DataBits',8)
    set(s,'StopBits',1)
    set(s,'Parity','none')
    set(s,'FlowControl','none')
    set(s,'Terminator',{'CR/LF','LF'})
    fopen(s);
    
    switch what
        case 'blue'
            fprintf(s,'%s\n','s 1'); % 1: blue, 2: green
        case 'green'
            fprintf(s,'%s\n','s 2'); % 1: blue, 2: green
        otherwise
    end
    %fprintf(s,'%s\n','s?');
    %fscanf(s,'%s');
    fclose(s);
    delete(s);
    clear s;
else
    s = daq.createSession('ni');
    addDigitalChannel(s,'Dev1', 'Port0/Line0:7', 'OutputOnly');
    switch what
        case 'blue'
            outputSingleScan(s,[0 0 1 0 0 0 0 0]);
        case 'green'
            outputSingleScan(s,[0 0 0 0 0 0 0 0]);
        otherwise
    end
    clear s
end

function ShutterControl(bOn)

awg = gpib('ni',0,6);
fopen(awg);

if bOn
fprintf(awg,'SOURce1:FUNCtion DC'); % turn on arb function
%fprintf(awg,'SOURCE1:VOLT 0'); % set max waveform amplitude to 3 Vpp
fprintf(awg,'SOURCE1:VOLT:OFFSET 2'); % set offset to 0 V
fprintf(awg,'OUTPUT1:LOAD 50'); % set output load to 50 ohms
%fprintf(awg,'SOURCE1:FUNCtion:ARB:SRATe 10000000'); % set sample rate
%Enable Output for channel 1
fprintf(awg,'OUTPUT1 ON');
else
    fprintf(awg,'OUTPUT1 OFF');
end

fclose(awg);
delete(awg);
clear awg;

% --- Executes during object creation, after setting all properties.
function GreenPort_CreateFcn(hObject, eventdata, handles)
% hObject    handle to GreenPort (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called


% --- Executes during object creation, after setting all properties.
function axes3_CreateFcn(hObject, eventdata, handles)
% hObject    handle to axes3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: place code in OpeningFcn to populate axes3


% --- Executes on button press in bSwitch.
function bSwitch_Callback(hObject, eventdata, handles)
% hObject    handle to bSwitch (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of bSwitch
