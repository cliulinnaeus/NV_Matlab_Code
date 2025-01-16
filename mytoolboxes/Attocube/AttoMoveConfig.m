function varargout = AttoMoveConfig(varargin)
% ATTOMOVECONFIG MATLAB code for AttoMoveConfig.fig
%      ATTOMOVECONFIG, by itself, creates a new ATTOMOVECONFIG or raises the existing
%      singleton*.
%
%      H = ATTOMOVECONFIG returns the handle to a new ATTOMOVECONFIG or the handle to
%      the existing singleton*.
%
%      ATTOMOVECONFIG('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in ATTOMOVECONFIG.M with the given input arguments.
%
%      ATTOMOVECONFIG('Property','Value',...) creates a new ATTOMOVECONFIG or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before AttoMoveConfig_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to AttoMoveConfig_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help AttoMoveConfig

% Last Modified by GUIDE v2.5 12-Dec-2024 15:43:10

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @AttoMoveConfig_OpeningFcn, ...
                   'gui_OutputFcn',  @AttoMoveConfig_OutputFcn, ...
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


% --- Executes just before AttoMoveConfig is made visible.
function AttoMoveConfig_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to AttoMoveConfig (see VARARGIN)

% Choose default command line output for AttoMoveConfig
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes AttoMoveConfig wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = AttoMoveConfig_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on selection change in Confocal_X_select.
function Confocal_X_select_Callback(hObject, eventdata, handles)
% hObject    handle to Confocal_X_select (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns Confocal_X_select contents as cell array
%        contents{get(hObject,'Value')} returns selected item from Confocal_X_select


% --- Executes during object creation, after setting all properties.
function Confocal_X_select_CreateFcn(hObject, eventdata, handles)
% hObject    handle to Confocal_X_select (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in Confocal_Y_select.
function Confocal_Y_select_Callback(hObject, eventdata, handles)
% hObject    handle to Confocal_Y_select (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns Confocal_Y_select contents as cell array
%        contents{get(hObject,'Value')} returns selected item from Confocal_Y_select


% --- Executes during object creation, after setting all properties.
function Confocal_Y_select_CreateFcn(hObject, eventdata, handles)
% hObject    handle to Confocal_Y_select (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in Confocal_Z_select.
function Confocal_Z_select_Callback(hObject, eventdata, handles)
% hObject    handle to Confocal_Z_select (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns Confocal_Z_select contents as cell array
%        contents{get(hObject,'Value')} returns selected item from Confocal_Z_select


% --- Executes during object creation, after setting all properties.
function Confocal_Z_select_CreateFcn(hObject, eventdata, handles)
% hObject    handle to Confocal_Z_select (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in optimizePLeveryMove.
function optimizePLeveryMove_Callback(hObject, eventdata, handles)
% hObject    handle to optimizePLeveryMove (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of optimizePLeveryMove



function attoZInit_Callback(hObject, eventdata, handles)
% hObject    handle to attoZInit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of attoZInit as text
%        str2double(get(hObject,'String')) returns contents of attoZInit as a double


% --- Executes during object creation, after setting all properties.
function attoZInit_CreateFcn(hObject, eventdata, handles)
% hObject    handle to attoZInit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function attoZRange_Callback(hObject, eventdata, handles)
% hObject    handle to attoZRange (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of attoZRange as text
%        str2double(get(hObject,'String')) returns contents of attoZRange as a double


% --- Executes during object creation, after setting all properties.
function attoZRange_CreateFcn(hObject, eventdata, handles)
% hObject    handle to attoZRange (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function attoZPoints_Callback(hObject, eventdata, handles)
% hObject    handle to attoZPoints (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of attoZPoints as text
%        str2double(get(hObject,'String')) returns contents of attoZPoints as a double


% --- Executes during object creation, after setting all properties.
function attoZPoints_CreateFcn(hObject, eventdata, handles)
% hObject    handle to attoZPoints (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function attoXStart_Callback(hObject, eventdata, handles)
% hObject    handle to attoXStart (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of attoXStart as text
%        str2double(get(hObject,'String')) returns contents of attoXStart as a double


% --- Executes during object creation, after setting all properties.
function attoXStart_CreateFcn(hObject, eventdata, handles)
% hObject    handle to attoXStart (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function attoXEnd_Callback(hObject, eventdata, handles)
% hObject    handle to attoXEnd (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of attoXEnd as text
%        str2double(get(hObject,'String')) returns contents of attoXEnd as a double


% --- Executes during object creation, after setting all properties.
function attoXEnd_CreateFcn(hObject, eventdata, handles)
% hObject    handle to attoXEnd (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function attoNpoints_Callback(hObject, eventdata, handles)
% hObject    handle to attoNpoints (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of attoNpoints as text
%        str2double(get(hObject,'String')) returns contents of attoNpoints as a double


% --- Executes during object creation, after setting all properties.
function attoNpoints_CreateFcn(hObject, eventdata, handles)
% hObject    handle to attoNpoints (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function attoYStart_Callback(hObject, eventdata, handles)
% hObject    handle to attoYStart (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of attoYStart as text
%        str2double(get(hObject,'String')) returns contents of attoYStart as a double


% --- Executes during object creation, after setting all properties.
function attoYStart_CreateFcn(hObject, eventdata, handles)
% hObject    handle to attoYStart (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function attoYEnd_Callback(hObject, eventdata, handles)
% hObject    handle to attoYEnd (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of attoYEnd as text
%        str2double(get(hObject,'String')) returns contents of attoYEnd as a double


% --- Executes during object creation, after setting all properties.
function attoYEnd_CreateFcn(hObject, eventdata, handles)
% hObject    handle to attoYEnd (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function attoYPoints_Callback(hObject, eventdata, handles)
% hObject    handle to attoYPoints (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of attoYPoints as text
%        str2double(get(hObject,'String')) returns contents of attoYPoints as a double


% --- Executes during object creation, after setting all properties.
function attoYPoints_CreateFcn(hObject, eventdata, handles)
% hObject    handle to attoYPoints (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on key press with focus on Confocal_X_select and none of its controls.
function Confocal_X_select_KeyPressFcn(hObject, eventdata, handles)
% hObject    handle to Confocal_X_select (see GCBO)
% eventdata  structure with the following fields (see MATLAB.UI.CONTROL.UICONTROL)
%	Key: name of the key that was pressed, in lower case
%	Character: character interpretation of the key(s) that was pressed
%	Modifier: name(s) of the modifier key(s) (i.e., control, shift) pressed
% handles    structure with handles and user data (see GUIDATA)



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
