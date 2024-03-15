function varargout = EditSequence(varargin)
% EDITSEQUENCE M-file for EditSequence.fig
%      EDITSEQUENCE, by itself, creates a new EDITSEQUENCE or raises the existing
%      singleton*.
%
%      H = EDITSEQUENCE returns the handle to a new EDITSEQUENCE or the handle to
%      the existing singleton*.
%
%      EDITSEQUENCE('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in EDITSEQUENCE.M with the given input arguments.
%
%      EDITSEQUENCE('Property','Value',...) creates a new EDITSEQUENCE or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before EditSequence_OpeningFunction gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to EditSequence_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help EditSequence

% Last Modified by GUIDE v2.5 02-Oct-2008 14:45:02

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @EditSequence_OpeningFcn, ...
                   'gui_OutputFcn',  @EditSequence_OutputFcn, ...
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


% --- Executes just before EditSequence is made visible.
function EditSequence_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to EditSequence (see VARARGIN)

% Choose default command line output for EditSequence
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes EditSequence wait for user response (see UIRESUME)
% uiwait(handles.figure1);

%Jero Added
EditSequenceStart(hObject, eventdata, handles, varargin);

% --- Outputs from this function are returned to the command line.
function varargout = EditSequence_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on selection change in popupmenu3.
function popupmenu3_Callback(hObject, eventdata, handles)
% hObject    handle to popupmenu3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = get(hObject,'String') returns popupmenu3 contents as cell array
%        contents{get(hObject,'Value')} returns selected item from popupmenu3


% --- Executes during object creation, after setting all properties.
function popupmenu3_CreateFcn(hObject, eventdata, handles)
% hObject    handle to popupmenu3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in popupmenu4.
function popupmenu4_Callback(hObject, eventdata, handles)
% hObject    handle to popupmenu4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = get(hObject,'String') returns popupmenu4 contents as cell array
%        contents{get(hObject,'Value')} returns selected item from popupmenu4


% --- Executes during object creation, after setting all properties.
function popupmenu4_CreateFcn(hObject, eventdata, handles)
% hObject    handle to popupmenu4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function TimeON1_Callback(hObject, eventdata, handles)
% hObject    handle to TimeON1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of TimeON1 as text
%        str2double(get(hObject,'String')) returns contents of TimeON1 as a double
EditgEditSEQ('TimeON',hObject, eventdata, handles)


% --- Executes during object creation, after setting all properties.
function TimeON1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to TimeON1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function DT1_Callback(hObject, eventdata, handles)
% hObject    handle to DT1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of DT1 as text
%        str2double(get(hObject,'String')) returns contents of DT1 as a double
EditgEditSEQ('DT',hObject, eventdata, handles)


% --- Executes during object creation, after setting all properties.
function DT1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to DT1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function DelayON1_Callback(hObject, eventdata, handles)
% hObject    handle to DelayON1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of DelayON1 as text
%        str2double(get(hObject,'String')) returns contents of DelayON1 as a double
EditgEditSEQ('DelayON',hObject, eventdata, handles)


% --- Executes during object creation, after setting all properties.
function DelayON1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to DelayON1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function DelayOFF1_Callback(hObject, eventdata, handles)
% hObject    handle to DelayOFF1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of DelayOFF1 as text
%        str2double(get(hObject,'String')) returns contents of DelayOFF1 as a double
EditgEditSEQ('DelayOFF',hObject, eventdata, handles)


% --- Executes during object creation, after setting all properties.
function DelayOFF1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to DelayOFF1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in PBN2.
function PBN2_Callback(hObject, eventdata, handles)
% hObject    handle to PBN2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = get(hObject,'String') returns PBN2 contents as cell array
%        contents{get(hObject,'Value')} returns selected item from PBN2
EditgEditSEQ('PBN2',hObject, eventdata, handles)


% --- Executes during object creation, after setting all properties.
function PBN2_CreateFcn(hObject, eventdata, handles)
% hObject    handle to PBN2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in Rise2.
function Rise2_Callback(hObject, eventdata, handles)
% hObject    handle to Rise2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = get(hObject,'String') returns Rise2 contents as cell array
%        contents{get(hObject,'Value')} returns selected item from Rise2


% --- Executes during object creation, after setting all properties.
function Rise2_CreateFcn(hObject, eventdata, handles)
% hObject    handle to Rise2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function TimeON2_Callback(hObject, eventdata, handles)
% hObject    handle to TimeON2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of TimeON2 as text
%        str2double(get(hObject,'String')) returns contents of TimeON2 as a double
EditgEditSEQ('TimeON2',hObject, eventdata, handles)


% --- Executes during object creation, after setting all properties.
function TimeON2_CreateFcn(hObject, eventdata, handles)
% hObject    handle to TimeON2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function DT2_Callback(hObject, eventdata, handles)
% hObject    handle to DT2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of DT2 as text
%        str2double(get(hObject,'String')) returns contents of DT2 as a double
EditgEditSEQ('DT2',hObject, eventdata, handles)


% --- Executes during object creation, after setting all properties.
function DT2_CreateFcn(hObject, eventdata, handles)
% hObject    handle to DT2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function DelayON2_Callback(hObject, eventdata, handles)
% hObject    handle to DelayON2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of DelayON2 as text
%        str2double(get(hObject,'String')) returns contents of DelayON2 as a double


% --- Executes during object creation, after setting all properties.
function DelayON2_CreateFcn(hObject, eventdata, handles)
% hObject    handle to DelayON2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function DelayOFF2_Callback(hObject, eventdata, handles)
% hObject    handle to DelayOFF2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of DelayOFF2 as text
%        str2double(get(hObject,'String')) returns contents of DelayOFF2 as a double


% --- Executes during object creation, after setting all properties.
function DelayOFF2_CreateFcn(hObject, eventdata, handles)
% hObject    handle to DelayOFF2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in PBN3.
function PBN3_Callback(hObject, eventdata, handles)
% hObject    handle to PBN3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = get(hObject,'String') returns PBN3 contents as cell array
%        contents{get(hObject,'Value')} returns selected item from PBN3
EditgEditSEQ('PBN3',hObject, eventdata, handles)


% --- Executes during object creation, after setting all properties.
function PBN3_CreateFcn(hObject, eventdata, handles)
% hObject    handle to PBN3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in RISE3.
function RISE3_Callback(hObject, eventdata, handles)
% hObject    handle to RISE3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = get(hObject,'String') returns RISE3 contents as cell array
%        contents{get(hObject,'Value')} returns selected item from RISE3


% --- Executes during object creation, after setting all properties.
function RISE3_CreateFcn(hObject, eventdata, handles)
% hObject    handle to RISE3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function TimeON3_Callback(hObject, eventdata, handles)
% hObject    handle to TimeON3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of TimeON3 as text
%        str2double(get(hObject,'String')) returns contents of TimeON3 as a double
EditgEditSEQ('TimeON3',hObject, eventdata, handles)


% --- Executes during object creation, after setting all properties.
function TimeON3_CreateFcn(hObject, eventdata, handles)
% hObject    handle to TimeON3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function DT3_Callback(hObject, eventdata, handles)
% hObject    handle to DT3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of DT3 as text
%        str2double(get(hObject,'String')) returns contents of DT3 as a double
EditgEditSEQ('DT3',hObject, eventdata, handles)


% --- Executes during object creation, after setting all properties.
function DT3_CreateFcn(hObject, eventdata, handles)
% hObject    handle to DT3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function DelayON3_Callback(hObject, eventdata, handles)
% hObject    handle to DelayON3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of DelayON3 as text
%        str2double(get(hObject,'String')) returns contents of DelayON3 as a double


% --- Executes during object creation, after setting all properties.
function DelayON3_CreateFcn(hObject, eventdata, handles)
% hObject    handle to DelayON3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function DelayOFF3_Callback(hObject, eventdata, handles)
% hObject    handle to DelayOFF3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of DelayOFF3 as text
%        str2double(get(hObject,'String')) returns contents of DelayOFF3 as a double


% --- Executes during object creation, after setting all properties.
function DelayOFF3_CreateFcn(hObject, eventdata, handles)
% hObject    handle to DelayOFF3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in PBN4.
function PBN4_Callback(hObject, eventdata, handles)
% hObject    handle to PBN4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = get(hObject,'String') returns PBN4 contents as cell array
%        contents{get(hObject,'Value')} returns selected item from PBN4
EditgEditSEQ('PBN4',hObject, eventdata, handles)


% --- Executes during object creation, after setting all properties.
function PBN4_CreateFcn(hObject, eventdata, handles)
% hObject    handle to PBN4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in RISE4.
function RISE4_Callback(hObject, eventdata, handles)
% hObject    handle to RISE4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = get(hObject,'String') returns RISE4 contents as cell array
%        contents{get(hObject,'Value')} returns selected item from RISE4


% --- Executes during object creation, after setting all properties.
function RISE4_CreateFcn(hObject, eventdata, handles)
% hObject    handle to RISE4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function TimeON4_Callback(hObject, eventdata, handles)
% hObject    handle to TimeON4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of TimeON4 as text
%        str2double(get(hObject,'String')) returns contents of TimeON4 as a double
EditgEditSEQ('TimeON4',hObject, eventdata, handles)


% --- Executes during object creation, after setting all properties.
function TimeON4_CreateFcn(hObject, eventdata, handles)
% hObject    handle to TimeON4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function DT4_Callback(hObject, eventdata, handles)
% hObject    handle to DT4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of DT4 as text
%        str2double(get(hObject,'String')) returns contents of DT4 as a double
EditgEditSEQ('DT4',hObject, eventdata, handles)


% --- Executes during object creation, after setting all properties.
function DT4_CreateFcn(hObject, eventdata, handles)
% hObject    handle to DT4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function DelayON4_Callback(hObject, eventdata, handles)
% hObject    handle to DelayON4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of DelayON4 as text
%        str2double(get(hObject,'String')) returns contents of DelayON4 as a double


% --- Executes during object creation, after setting all properties.
function DelayON4_CreateFcn(hObject, eventdata, handles)
% hObject    handle to DelayON4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function DelayOFF4_Callback(hObject, eventdata, handles)
% hObject    handle to DelayOFF4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of DelayOFF4 as text
%        str2double(get(hObject,'String')) returns contents of DelayOFF4 as a double


% --- Executes during object creation, after setting all properties.
function DelayOFF4_CreateFcn(hObject, eventdata, handles)
% hObject    handle to DelayOFF4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in PBN5.
function PBN5_Callback(hObject, eventdata, handles)
% hObject    handle to PBN5 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = get(hObject,'String') returns PBN5 contents as cell array
%        contents{get(hObject,'Value')} returns selected item from PBN5
EditgEditSEQ('PBN5',hObject, eventdata, handles)


% --- Executes during object creation, after setting all properties.
function PBN5_CreateFcn(hObject, eventdata, handles)
% hObject    handle to PBN5 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in RISE5.
function RISE5_Callback(hObject, eventdata, handles)
% hObject    handle to RISE5 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = get(hObject,'String') returns RISE5 contents as cell array
%        contents{get(hObject,'Value')} returns selected item from RISE5


% --- Executes during object creation, after setting all properties.
function RISE5_CreateFcn(hObject, eventdata, handles)
% hObject    handle to RISE5 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function TimeON5_Callback(hObject, eventdata, handles)
% hObject    handle to TimeON5 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of TimeON5 as text
%        str2double(get(hObject,'String')) returns contents of TimeON5 as a double
EditgEditSEQ('TimeON5',hObject, eventdata, handles)


% --- Executes during object creation, after setting all properties.
function TimeON5_CreateFcn(hObject, eventdata, handles)
% hObject    handle to TimeON5 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function DT5_Callback(hObject, eventdata, handles)
% hObject    handle to DT5 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of DT5 as text
%        str2double(get(hObject,'String')) returns contents of DT5 as a double
EditgEditSEQ('DT5',hObject, eventdata, handles)


% --- Executes during object creation, after setting all properties.
function DT5_CreateFcn(hObject, eventdata, handles)
% hObject    handle to DT5 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function DelayON5_Callback(hObject, eventdata, handles)
% hObject    handle to DelayON5 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of DelayON5 as text
%        str2double(get(hObject,'String')) returns contents of DelayON5 as a double


% --- Executes during object creation, after setting all properties.
function DelayON5_CreateFcn(hObject, eventdata, handles)
% hObject    handle to DelayON5 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function DelayOFF5_Callback(hObject, eventdata, handles)
% hObject    handle to DelayOFF5 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of DelayOFF5 as text
%        str2double(get(hObject,'String')) returns contents of DelayOFF5 as a double


% --- Executes during object creation, after setting all properties.
function DelayOFF5_CreateFcn(hObject, eventdata, handles)
% hObject    handle to DelayOFF5 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in PBN6.
function PBN6_Callback(hObject, eventdata, handles)
% hObject    handle to PBN6 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = get(hObject,'String') returns PBN6 contents as cell array
%        contents{get(hObject,'Value')} returns selected item from PBN6
EditgEditSEQ('PBN6',hObject, eventdata, handles)


% --- Executes during object creation, after setting all properties.
function PBN6_CreateFcn(hObject, eventdata, handles)
% hObject    handle to PBN6 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in RISE6.
function RISE6_Callback(hObject, eventdata, handles)
% hObject    handle to RISE6 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = get(hObject,'String') returns RISE6 contents as cell array
%        contents{get(hObject,'Value')} returns selected item from RISE6


% --- Executes during object creation, after setting all properties.
function RISE6_CreateFcn(hObject, eventdata, handles)
% hObject    handle to RISE6 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function TimeON6_Callback(hObject, eventdata, handles)
% hObject    handle to TimeON6 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of TimeON6 as text
%        str2double(get(hObject,'String')) returns contents of TimeON6 as a double
EditgEditSEQ('TimeON6',hObject, eventdata, handles)


% --- Executes during object creation, after setting all properties.
function TimeON6_CreateFcn(hObject, eventdata, handles)
% hObject    handle to TimeON6 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function DT6_Callback(hObject, eventdata, handles)
% hObject    handle to DT6 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of DT6 as text
%        str2double(get(hObject,'String')) returns contents of DT6 as a double
EditgEditSEQ('DT6',hObject, eventdata, handles)


% --- Executes during object creation, after setting all properties.
function DT6_CreateFcn(hObject, eventdata, handles)
% hObject    handle to DT6 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function DelayON6_Callback(hObject, eventdata, handles)
% hObject    handle to DelayON6 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of DelayON6 as text
%        str2double(get(hObject,'String')) returns contents of DelayON6 as a double


% --- Executes during object creation, after setting all properties.
function DelayON6_CreateFcn(hObject, eventdata, handles)
% hObject    handle to DelayON6 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function DelayOFF6_Callback(hObject, eventdata, handles)
% hObject    handle to DelayOFF6 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of DelayOFF6 as text
%        str2double(get(hObject,'String')) returns contents of DelayOFF6 as a double


% --- Executes during object creation, after setting all properties.
function DelayOFF6_CreateFcn(hObject, eventdata, handles)
% hObject    handle to DelayOFF6 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in PBN7.
function PBN7_Callback(hObject, eventdata, handles)
% hObject    handle to PBN7 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = get(hObject,'String') returns PBN7 contents as cell array
%        contents{get(hObject,'Value')} returns selected item from PBN7
EditgEditSEQ('PBN7',hObject, eventdata, handles)


% --- Executes during object creation, after setting all properties.
function PBN7_CreateFcn(hObject, eventdata, handles)
% hObject    handle to PBN7 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in RISE7.
function RISE7_Callback(hObject, eventdata, handles)
% hObject    handle to RISE7 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = get(hObject,'String') returns RISE7 contents as cell array
%        contents{get(hObject,'Value')} returns selected item from RISE7


% --- Executes during object creation, after setting all properties.
function RISE7_CreateFcn(hObject, eventdata, handles)
% hObject    handle to RISE7 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function TimeON7_Callback(hObject, eventdata, handles)
% hObject    handle to TimeON7 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of TimeON7 as text
%        str2double(get(hObject,'String')) returns contents of TimeON7 as a double
EditgEditSEQ('TimeON7',hObject, eventdata, handles)


% --- Executes during object creation, after setting all properties.
function TimeON7_CreateFcn(hObject, eventdata, handles)
% hObject    handle to TimeON7 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function DT7_Callback(hObject, eventdata, handles)
% hObject    handle to DT7 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of DT7 as text
%        str2double(get(hObject,'String')) returns contents of DT7 as a double
EditgEditSEQ('DT7',hObject, eventdata, handles)


% --- Executes during object creation, after setting all properties.
function DT7_CreateFcn(hObject, eventdata, handles)
% hObject    handle to DT7 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function DelayON7_Callback(hObject, eventdata, handles)
% hObject    handle to DelayON7 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of DelayON7 as text
%        str2double(get(hObject,'String')) returns contents of DelayON7 as a double


% --- Executes during object creation, after setting all properties.
function DelayON7_CreateFcn(hObject, eventdata, handles)
% hObject    handle to DelayON7 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function DelayOFF7_Callback(hObject, eventdata, handles)
% hObject    handle to DelayOFF7 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of DelayOFF7 as text
%        str2double(get(hObject,'String')) returns contents of DelayOFF7 as a double


% --- Executes during object creation, after setting all properties.
function DelayOFF7_CreateFcn(hObject, eventdata, handles)
% hObject    handle to DelayOFF7 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in PBN8.
function PBN8_Callback(hObject, eventdata, handles)
% hObject    handle to PBN8 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = get(hObject,'String') returns PBN8 contents as cell array
%        contents{get(hObject,'Value')} returns selected item from PBN8
EditgEditSEQ('PBN8',hObject, eventdata, handles)


% --- Executes during object creation, after setting all properties.
function PBN8_CreateFcn(hObject, eventdata, handles)
% hObject    handle to PBN8 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in RISE8.
function RISE8_Callback(hObject, eventdata, handles)
% hObject    handle to RISE8 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = get(hObject,'String') returns RISE8 contents as cell array
%        contents{get(hObject,'Value')} returns selected item from RISE8


% --- Executes during object creation, after setting all properties.
function RISE8_CreateFcn(hObject, eventdata, handles)
% hObject    handle to RISE8 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function TimeON8_Callback(hObject, eventdata, handles)
% hObject    handle to TimeON8 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of TimeON8 as text
%        str2double(get(hObject,'String')) returns contents of TimeON8 as a double
EditgEditSEQ('TimeON8',hObject, eventdata, handles)


% --- Executes during object creation, after setting all properties.
function TimeON8_CreateFcn(hObject, eventdata, handles)
% hObject    handle to TimeON8 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function DT8_Callback(hObject, eventdata, handles)
% hObject    handle to DT8 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of DT8 as text
%        str2double(get(hObject,'String')) returns contents of DT8 as a double
EditgEditSEQ('DT8',hObject, eventdata, handles)


% --- Executes during object creation, after setting all properties.
function DT8_CreateFcn(hObject, eventdata, handles)
% hObject    handle to DT8 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function DelayON8_Callback(hObject, eventdata, handles)
% hObject    handle to DelayON8 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of DelayON8 as text
%        str2double(get(hObject,'String')) returns contents of DelayON8 as a double


% --- Executes during object creation, after setting all properties.
function DelayON8_CreateFcn(hObject, eventdata, handles)
% hObject    handle to DelayON8 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function DelayOFF8_Callback(hObject, eventdata, handles)
% hObject    handle to DelayOFF8 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of DelayOFF8 as text
%        str2double(get(hObject,'String')) returns contents of DelayOFF8 as a double


% --- Executes during object creation, after setting all properties.
function DelayOFF8_CreateFcn(hObject, eventdata, handles)
% hObject    handle to DelayOFF8 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in PBN9.
function PBN9_Callback(hObject, eventdata, handles)
% hObject    handle to PBN9 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = get(hObject,'String') returns PBN9 contents as cell array
%        contents{get(hObject,'Value')} returns selected item from PBN9
EditgEditSEQ('PBN9',hObject, eventdata, handles)


% --- Executes during object creation, after setting all properties.
function PBN9_CreateFcn(hObject, eventdata, handles)
% hObject    handle to PBN9 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in RISE9.
function RISE9_Callback(hObject, eventdata, handles)
% hObject    handle to RISE9 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = get(hObject,'String') returns RISE9 contents as cell array
%        contents{get(hObject,'Value')} returns selected item from RISE9


% --- Executes during object creation, after setting all properties.
function RISE9_CreateFcn(hObject, eventdata, handles)
% hObject    handle to RISE9 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function TimeON9_Callback(hObject, eventdata, handles)
% hObject    handle to TimeON9 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of TimeON9 as text
%        str2double(get(hObject,'String')) returns contents of TimeON9 as a double
EditgEditSEQ('TimeON9',hObject, eventdata, handles)


% --- Executes during object creation, after setting all properties.
function TimeON9_CreateFcn(hObject, eventdata, handles)
% hObject    handle to TimeON9 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function DT9_Callback(hObject, eventdata, handles)
% hObject    handle to DT9 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of DT9 as text
%        str2double(get(hObject,'String')) returns contents of DT9 as a double
EditgEditSEQ('DT9',hObject, eventdata, handles)


% --- Executes during object creation, after setting all properties.
function DT9_CreateFcn(hObject, eventdata, handles)
% hObject    handle to DT9 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function DelayON9_Callback(hObject, eventdata, handles)
% hObject    handle to DelayON9 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of DelayON9 as text
%        str2double(get(hObject,'String')) returns contents of DelayON9 as a double


% --- Executes during object creation, after setting all properties.
function DelayON9_CreateFcn(hObject, eventdata, handles)
% hObject    handle to DelayON9 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function DelayOFF9_Callback(hObject, eventdata, handles)
% hObject    handle to DelayOFF9 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of DelayOFF9 as text
%        str2double(get(hObject,'String')) returns contents of DelayOFF9 as a double


% --- Executes during object creation, after setting all properties.
function DelayOFF9_CreateFcn(hObject, eventdata, handles)
% hObject    handle to DelayOFF9 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in RISE2.
function RISE2_Callback(hObject, eventdata, handles)
% hObject    handle to RISE2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = get(hObject,'String') returns RISE2 contents as cell array
%        contents{get(hObject,'Value')} returns selected item from RISE2


% --- Executes during object creation, after setting all properties.
function RISE2_CreateFcn(hObject, eventdata, handles)
% hObject    handle to RISE2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in DONE.
function DONE_Callback(hObject, eventdata, handles)
% hObject    handle to DONE (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
SaveSequence('SaveGlobal');
close;

% --- Executes on button press in SaveSeqAs.
function SaveSeqAs_Callback(hObject, eventdata, handles)
% hObject    handle to SaveSeqAs (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
SaveSeqAs;



% --- Executes on button press in Refresh.
function Refresh_Callback(hObject, eventdata, handles)
% hObject    handle to Refresh (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in EditOpenSeq.
function EditOpenSeq_Callback(hObject, eventdata, handles)
% hObject    handle to EditOpenSeq (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
EditSequenceFunctionPool('OpenAddSequence',hObject, eventdata, handles);

% --- Executes on selection change in popupmenu21.
function popupmenu21_Callback(hObject, eventdata, handles)
% hObject    handle to popupmenu21 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = get(hObject,'String') returns popupmenu21 contents as cell array
%        contents{get(hObject,'Value')} returns selected item from popupmenu21


% --- Executes during object creation, after setting all properties.
function popupmenu21_CreateFcn(hObject, eventdata, handles)
% hObject    handle to popupmenu21 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in SubPBN1.
function SubPBN1_Callback(hObject, eventdata, handles)
% hObject    handle to SubPBN1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = get(hObject,'String') returns SubPBN1 contents as cell array
%        contents{get(hObject,'Value')} returns selected item from SubPBN1


% --- Executes during object creation, after setting all properties.
function SubPBN1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to SubPBN1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in popupmenu23.
function popupmenu23_Callback(hObject, eventdata, handles)
% hObject    handle to popupmenu23 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = get(hObject,'String') returns popupmenu23 contents as cell array
%        contents{get(hObject,'Value')} returns selected item from popupmenu23


% --- Executes during object creation, after setting all properties.
function popupmenu23_CreateFcn(hObject, eventdata, handles)
% hObject    handle to popupmenu23 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in popupmenu24.
function popupmenu24_Callback(hObject, eventdata, handles)
% hObject    handle to popupmenu24 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = get(hObject,'String') returns popupmenu24 contents as cell array
%        contents{get(hObject,'Value')} returns selected item from popupmenu24


% --- Executes during object creation, after setting all properties.
function popupmenu24_CreateFcn(hObject, eventdata, handles)
% hObject    handle to popupmenu24 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in popupmenu25.
function popupmenu25_Callback(hObject, eventdata, handles)
% hObject    handle to popupmenu25 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = get(hObject,'String') returns popupmenu25 contents as cell array
%        contents{get(hObject,'Value')} returns selected item from popupmenu25


% --- Executes during object creation, after setting all properties.
function popupmenu25_CreateFcn(hObject, eventdata, handles)
% hObject    handle to popupmenu25 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in popupmenu26.
function popupmenu26_Callback(hObject, eventdata, handles)
% hObject    handle to popupmenu26 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = get(hObject,'String') returns popupmenu26 contents as cell array
%        contents{get(hObject,'Value')} returns selected item from popupmenu26


% --- Executes during object creation, after setting all properties.
function popupmenu26_CreateFcn(hObject, eventdata, handles)
% hObject    handle to popupmenu26 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in popupmenu27.
function popupmenu27_Callback(hObject, eventdata, handles)
% hObject    handle to popupmenu27 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = get(hObject,'String') returns popupmenu27 contents as cell array
%        contents{get(hObject,'Value')} returns selected item from popupmenu27


% --- Executes during object creation, after setting all properties.
function popupmenu27_CreateFcn(hObject, eventdata, handles)
% hObject    handle to popupmenu27 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in popupmenu28.
function popupmenu28_Callback(hObject, eventdata, handles)
% hObject    handle to popupmenu28 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = get(hObject,'String') returns popupmenu28 contents as cell array
%        contents{get(hObject,'Value')} returns selected item from popupmenu28


% --- Executes during object creation, after setting all properties.
function popupmenu28_CreateFcn(hObject, eventdata, handles)
% hObject    handle to popupmenu28 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in popupmenu29.
function popupmenu29_Callback(hObject, eventdata, handles)
% hObject    handle to popupmenu29 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = get(hObject,'String') returns popupmenu29 contents as cell array
%        contents{get(hObject,'Value')} returns selected item from popupmenu29


% --- Executes during object creation, after setting all properties.
function popupmenu29_CreateFcn(hObject, eventdata, handles)
% hObject    handle to popupmenu29 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


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


% --- Executes on selection change in popupmenu31.
function popupmenu31_Callback(hObject, eventdata, handles)
% hObject    handle to popupmenu31 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = get(hObject,'String') returns popupmenu31 contents as cell array
%        contents{get(hObject,'Value')} returns selected item from popupmenu31


% --- Executes during object creation, after setting all properties.
function popupmenu31_CreateFcn(hObject, eventdata, handles)
% hObject    handle to popupmenu31 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in popupmenu32.
function popupmenu32_Callback(hObject, eventdata, handles)
% hObject    handle to popupmenu32 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = get(hObject,'String') returns popupmenu32 contents as cell array
%        contents{get(hObject,'Value')} returns selected item from popupmenu32


% --- Executes during object creation, after setting all properties.
function popupmenu32_CreateFcn(hObject, eventdata, handles)
% hObject    handle to popupmenu32 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in popupmenu33.
function popupmenu33_Callback(hObject, eventdata, handles)
% hObject    handle to popupmenu33 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = get(hObject,'String') returns popupmenu33 contents as cell array
%        contents{get(hObject,'Value')} returns selected item from popupmenu33


% --- Executes during object creation, after setting all properties.
function popupmenu33_CreateFcn(hObject, eventdata, handles)
% hObject    handle to popupmenu33 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in popupmenu34.
function popupmenu34_Callback(hObject, eventdata, handles)
% hObject    handle to popupmenu34 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = get(hObject,'String') returns popupmenu34 contents as cell array
%        contents{get(hObject,'Value')} returns selected item from popupmenu34


% --- Executes during object creation, after setting all properties.
function popupmenu34_CreateFcn(hObject, eventdata, handles)
% hObject    handle to popupmenu34 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in popupmenu35.
function popupmenu35_Callback(hObject, eventdata, handles)
% hObject    handle to popupmenu35 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = get(hObject,'String') returns popupmenu35 contents as cell array
%        contents{get(hObject,'Value')} returns selected item from popupmenu35


% --- Executes during object creation, after setting all properties.
function popupmenu35_CreateFcn(hObject, eventdata, handles)
% hObject    handle to popupmenu35 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in popupmenu36.
function popupmenu36_Callback(hObject, eventdata, handles)
% hObject    handle to popupmenu36 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = get(hObject,'String') returns popupmenu36 contents as cell array
%        contents{get(hObject,'Value')} returns selected item from popupmenu36


% --- Executes during object creation, after setting all properties.
function popupmenu36_CreateFcn(hObject, eventdata, handles)
% hObject    handle to popupmenu36 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in popupmenu37.
function popupmenu37_Callback(hObject, eventdata, handles)
% hObject    handle to popupmenu37 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = get(hObject,'String') returns popupmenu37 contents as cell array
%        contents{get(hObject,'Value')} returns selected item from popupmenu37


% --- Executes during object creation, after setting all properties.
function popupmenu37_CreateFcn(hObject, eventdata, handles)
% hObject    handle to popupmenu37 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in AddSubSeq.
function AddSubSeq_Callback(hObject, eventdata, handles)
% hObject    handle to AddSubSeq (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
EditSequenceFunctionPool('AddSubSeq',hObject, eventdata, handles);


function NTimes_Callback(hObject, eventdata, handles)
% hObject    handle to NTimes (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of NTimes as text
%        str2double(get(hObject,'String')) returns contents of NTimes as a double


% --- Executes during object creation, after setting all properties.
function NTimes_CreateFcn(hObject, eventdata, handles)
% hObject    handle to NTimes (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in Type.
function Type_Callback(hObject, eventdata, handles)
% hObject    handle to Type (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = get(hObject,'String') returns Type contents as cell array
%        contents{get(hObject,'Value')} returns selected item from Type


% --- Executes during object creation, after setting all properties.
function Type_CreateFcn(hObject, eventdata, handles)
% hObject    handle to Type (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit48_Callback(hObject, eventdata, handles)
% hObject    handle to edit48 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit48 as text
%        str2double(get(hObject,'String')) returns contents of edit48 as a double


% --- Executes during object creation, after setting all properties.
function edit48_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit48 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in pushbutton7.
function pushbutton7_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton7 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)



function Type1_Callback(hObject, eventdata, handles)
% hObject    handle to Type1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of Type1 as text
%        str2double(get(hObject,'String')) returns contents of Type1 as a double
EditgEditSEQ('Type',hObject, eventdata, handles)


% --- Executes during object creation, after setting all properties.
function Type1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to Type1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit39_Callback(hObject, eventdata, handles)
% hObject    handle to edit39 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit39 as text
%        str2double(get(hObject,'String')) returns contents of edit39 as a double


% --- Executes during object creation, after setting all properties.
function edit39_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit39 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit40_Callback(hObject, eventdata, handles)
% hObject    handle to edit40 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit40 as text
%        str2double(get(hObject,'String')) returns contents of edit40 as a double


% --- Executes during object creation, after setting all properties.
function edit40_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit40 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit41_Callback(hObject, eventdata, handles)
% hObject    handle to edit41 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit41 as text
%        str2double(get(hObject,'String')) returns contents of edit41 as a double


% --- Executes during object creation, after setting all properties.
function edit41_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit41 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit42_Callback(hObject, eventdata, handles)
% hObject    handle to edit42 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit42 as text
%        str2double(get(hObject,'String')) returns contents of edit42 as a double


% --- Executes during object creation, after setting all properties.
function edit42_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit42 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit43_Callback(hObject, eventdata, handles)
% hObject    handle to edit43 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit43 as text
%        str2double(get(hObject,'String')) returns contents of edit43 as a double


% --- Executes during object creation, after setting all properties.
function edit43_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit43 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit44_Callback(hObject, eventdata, handles)
% hObject    handle to edit44 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit44 as text
%        str2double(get(hObject,'String')) returns contents of edit44 as a double


% --- Executes during object creation, after setting all properties.
function edit44_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit44 (see GCBO)
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



function edit46_Callback(hObject, eventdata, handles)
% hObject    handle to edit46 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit46 as text
%        str2double(get(hObject,'String')) returns contents of edit46 as a double


% --- Executes during object creation, after setting all properties.
function edit46_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit46 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in SaveSeq.
function SaveSeq_Callback(hObject, eventdata, handles)
% hObject    handle to SaveSeq (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
SaveSequence('SaveFile');

% --- Executes on button press in Cancel.
function Cancel_Callback(hObject, eventdata, handles)
% hObject    handle to Cancel (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
close;

% --- Executes on selection change in Rise3.
function Rise3_Callback(hObject, eventdata, handles)
% hObject    handle to Rise3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = get(hObject,'String') returns Rise3 contents as cell array
%        contents{get(hObject,'Value')} returns selected item from Rise3


% --- Executes during object creation, after setting all properties.
function Rise3_CreateFcn(hObject, eventdata, handles)
% hObject    handle to Rise3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in Rise4.
function Rise4_Callback(hObject, eventdata, handles)
% hObject    handle to Rise4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = get(hObject,'String') returns Rise4 contents as cell array
%        contents{get(hObject,'Value')} returns selected item from Rise4


% --- Executes during object creation, after setting all properties.
function Rise4_CreateFcn(hObject, eventdata, handles)
% hObject    handle to Rise4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in Rise5.
function Rise5_Callback(hObject, eventdata, handles)
% hObject    handle to Rise5 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = get(hObject,'String') returns Rise5 contents as cell array
%        contents{get(hObject,'Value')} returns selected item from Rise5


% --- Executes during object creation, after setting all properties.
function Rise5_CreateFcn(hObject, eventdata, handles)
% hObject    handle to Rise5 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in Rise6.
function Rise6_Callback(hObject, eventdata, handles)
% hObject    handle to Rise6 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = get(hObject,'String') returns Rise6 contents as cell array
%        contents{get(hObject,'Value')} returns selected item from Rise6


% --- Executes during object creation, after setting all properties.
function Rise6_CreateFcn(hObject, eventdata, handles)
% hObject    handle to Rise6 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in Rise7.
function Rise7_Callback(hObject, eventdata, handles)
% hObject    handle to Rise7 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = get(hObject,'String') returns Rise7 contents as cell array
%        contents{get(hObject,'Value')} returns selected item from Rise7


% --- Executes during object creation, after setting all properties.
function Rise7_CreateFcn(hObject, eventdata, handles)
% hObject    handle to Rise7 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in Rise8.
function Rise8_Callback(hObject, eventdata, handles)
% hObject    handle to Rise8 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = get(hObject,'String') returns Rise8 contents as cell array
%        contents{get(hObject,'Value')} returns selected item from Rise8


% --- Executes during object creation, after setting all properties.
function Rise8_CreateFcn(hObject, eventdata, handles)
% hObject    handle to Rise8 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in Rise9.
function Rise9_Callback(hObject, eventdata, handles)
% hObject    handle to Rise9 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = get(hObject,'String') returns Rise9 contents as cell array
%        contents{get(hObject,'Value')} returns selected item from Rise9


% --- Executes during object creation, after setting all properties.
function Rise9_CreateFcn(hObject, eventdata, handles)
% hObject    handle to Rise9 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in DelPBN1.
function DelPBN1_Callback(hObject, eventdata, handles)
% hObject    handle to DelPBN1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
EditgEditSEQ('DeletePBN',hObject, eventdata, handles)

% --- Executes on button press in DelPBN2.
function DelPBN2_Callback(hObject, eventdata, handles)
% hObject    handle to DelPBN2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
EditgEditSEQ('DeletePBN2',hObject, eventdata, handles)


% --- Executes on button press in DelPBN3.
function DelPBN3_Callback(hObject, eventdata, handles)
% hObject    handle to DelPBN3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
EditgEditSEQ('DeletePBN3',hObject, eventdata, handles)


% --- Executes on button press in DelPBN4.
function DelPBN4_Callback(hObject, eventdata, handles)
% hObject    handle to DelPBN4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
EditgEditSEQ('DeletePBN4',hObject, eventdata, handles)


% --- Executes on button press in DelPBN5.
function DelPBN5_Callback(hObject, eventdata, handles)
% hObject    handle to DelPBN5 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
EditgEditSEQ('DeletePBN5',hObject, eventdata, handles)


% --- Executes on button press in DelPBN6.
function DelPBN6_Callback(hObject, eventdata, handles)
% hObject    handle to DelPBN6 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
EditgEditSEQ('DeletePBN6',hObject, eventdata, handles)


% --- Executes on button press in DelPBN7.
function DelPBN7_Callback(hObject, eventdata, handles)
% hObject    handle to DelPBN7 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
EditgEditSEQ('DeletePBN7',hObject, eventdata, handles)


% --- Executes on button press in DelPBN8.
function DelPBN8_Callback(hObject, eventdata, handles)
% hObject    handle to DelPBN8 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
EditgEditSEQ('DeletePBN8',hObject, eventdata, handles)


% --- Executes on button press in DelPBN9.
function DelPBN9_Callback(hObject, eventdata, handles)
% hObject    handle to DelPBN9 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
EditgEditSEQ('DeletePBN9',hObject, eventdata, handles)


% --- Executes on button press in pushbutton19.
function pushbutton19_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton19 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in pushbutton20.
function pushbutton20_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton20 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)



function Rise1_Callback(hObject, eventdata, handles)
% hObject    handle to Rise1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of Rise1 as text
%        str2double(get(hObject,'String')) returns contents of Rise1 as a double
RefreshEditSeqForm('Rise',hObject, eventdata, handles)




% --- Executes on button press in pushbutton21.
function pushbutton21_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton21 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in DelRiseN1.
function DelRiseN1_Callback(hObject, eventdata, handles)
% hObject    handle to DelRiseN1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
EditgEditSEQ('DelRise',hObject, eventdata, handles)


% --- Executes on button press in AddRiseN2.
function AddRiseN2_Callback(hObject, eventdata, handles)
% hObject    handle to AddRiseN2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in pushbutton24.
function pushbutton24_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton24 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in AddRiseN3.
function AddRiseN3_Callback(hObject, eventdata, handles)
% hObject    handle to AddRiseN3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in pushbutton26.
function pushbutton26_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton26 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in pushbutton27.
function pushbutton27_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton27 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in DelRiseN4.
function DelRiseN4_Callback(hObject, eventdata, handles)
% hObject    handle to DelRiseN4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in AddRiseN5.
function AddRiseN5_Callback(hObject, eventdata, handles)
% hObject    handle to AddRiseN5 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in pushbutton30.
function pushbutton30_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton30 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in AddRiseN6.
function AddRiseN6_Callback(hObject, eventdata, handles)
% hObject    handle to AddRiseN6 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in pushbutton32.
function pushbutton32_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton32 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in pushbutton33.
function pushbutton33_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton33 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in pushbutton34.
function pushbutton34_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton34 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in AddRiseN8.
function AddRiseN8_Callback(hObject, eventdata, handles)
% hObject    handle to AddRiseN8 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in pushbutton36.
function pushbutton36_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton36 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in AddRiseN9.
function AddRiseN9_Callback(hObject, eventdata, handles)
% hObject    handle to AddRiseN9 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in pushbutton38.
function pushbutton38_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton38 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)




% --- Executes on button press in AddRiseN4.
function AddRiseN4_Callback(hObject, eventdata, handles)
% hObject    handle to AddRiseN4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)




% --- Executes on selection change in PBN1.
function PBN1_Callback(hObject, eventdata, handles)
% hObject    handle to PBN1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = get(hObject,'String') returns PBN1 contents as cell array
%        contents{get(hObject,'Value')} returns selected item from PBN1
EditgEditSEQ('PBN',hObject, eventdata, handles)




function Type2_Callback(hObject, eventdata, handles)
% hObject    handle to Type2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of Type2 as text
%        str2double(get(hObject,'String')) returns contents of Type2 as a double
EditgEditSEQ('Type2',hObject, eventdata, handles)





function Type3_Callback(hObject, eventdata, handles)
% hObject    handle to Type3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of Type3 as text
%        str2double(get(hObject,'String')) returns contents of Type3 as a double
EditgEditSEQ('Type3',hObject, eventdata, handles)





function Type4_Callback(hObject, eventdata, handles)
% hObject    handle to Type4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of Type4 as text
%        str2double(get(hObject,'String')) returns contents of Type4 as a double
EditgEditSEQ('Type4',hObject, eventdata, handles)





function Type5_Callback(hObject, eventdata, handles)
% hObject    handle to Type5 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of Type5 as text
%        str2double(get(hObject,'String')) returns contents of Type5 as a double
EditgEditSEQ('Type5',hObject, eventdata, handles)





function Type6_Callback(hObject, eventdata, handles)
% hObject    handle to Type6 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of Type6 as text
%        str2double(get(hObject,'String')) returns contents of Type6 as a double
EditgEditSEQ('Type6',hObject, eventdata, handles)





function Type7_Callback(hObject, eventdata, handles)
% hObject    handle to Type7 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of Type7 as text
%        str2double(get(hObject,'String')) returns contents of Type7 as a double
EditgEditSEQ('Type7',hObject, eventdata, handles)





function Type8_Callback(hObject, eventdata, handles)
% hObject    handle to Type8 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of Type8 as text
%        str2double(get(hObject,'String')) returns contents of Type8 as a double
EditgEditSEQ('Type8',hObject, eventdata, handles)





function Type9_Callback(hObject, eventdata, handles)
% hObject    handle to Type9 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of Type9 as text
%        str2double(get(hObject,'String')) returns contents of Type9 as a double
EditgEditSEQ('Type9',hObject, eventdata, handles)




% --- Executes on button press in ShowType.
function ShowType_Callback(hObject, eventdata, handles)
% hObject    handle to ShowType (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in ZoomLeft.
function ZoomLeft_Callback(hObject, eventdata, handles)
% hObject    handle to ZoomLeft (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
ZoomEditSEQ('Left',hObject, eventdata, handles);

% --- Executes on button press in ZoomRight.
function ZoomRight_Callback(hObject, eventdata, handles)
% hObject    handle to ZoomRight (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
ZoomEditSEQ('Right',hObject, eventdata, handles);


% --- Executes on selection change in Channel.
function Channel_Callback(hObject, eventdata, handles)
% hObject    handle to Channel (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = get(hObject,'String') returns Channel contents as cell array
%        contents{get(hObject,'Value')} returns selected item from Channel
RefreshEditSeqForm('Channel',hObject, eventdata, handles)

% --- Executes during object creation, after setting all properties.
function Channel_CreateFcn(hObject, eventdata, handles)
% hObject    handle to Channel (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end




% --- Executes on button press in AddRiseN1.
function AddRiseN1_Callback(hObject, eventdata, handles)
% hObject    handle to AddRiseN1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
EditgEditSEQ('AddRise',hObject, eventdata, handles)




% --- Executes on button press in ShowTimes.
function ShowTimes_Callback(hObject, eventdata, handles)
% hObject    handle to ShowTimes (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of ShowTimes
EditSEQRedraw('ShowTimes',hObject, eventdata, handles);

% --- Executes on button press in Shift.
function Shift_Callback(hObject, eventdata, handles)
% hObject    handle to Shift (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of Shift


% --- Executes on button press in ShiftAll.
function ShiftAll_Callback(hObject, eventdata, handles)
% hObject    handle to ShiftAll (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of ShiftAll


% --- Executes on button press in ZoomOut.
function ZoomOut_Callback(hObject, eventdata, handles)
% hObject    handle to ZoomOut (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
ZoomEditSEQ('ZoomOut',hObject, eventdata, handles);



% --- Executes on button press in bZoom.
function bZoom_Callback(hObject, eventdata, handles)
% hObject    handle to bZoom (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of bZoom




% --- Executes on button press in ShowTypes.
function ShowTypes_Callback(hObject, eventdata, handles)
% hObject    handle to ShowTypes (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of ShowTypes
EditSEQRedraw('ShowTypes',hObject, eventdata, handles);




% --- Executes on mouse press over axes background.
function axes1_ButtonDownFcn(hObject, eventdata, handles)
% hObject    handle to axes1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
RefreshEditSeqForm('ButtonDown',hObject, eventdata, handles)



% --- If Enable == 'on', executes on mouse press in 5 pixel border.
% --- Otherwise, executes on mouse press in 5 pixel border or over ZoomRight.
function ZoomRight_ButtonDownFcn(hObject, eventdata, handles)
% hObject    handle to ZoomRight (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)




% --- Executes on button press in buttonPlot.
function buttonPlot_Callback(hObject, eventdata, handles)
% hObject    handle to buttonPlot (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% get the axes object with the plot
hSeq = get(handles.axes1,'Children');
% create a new figure
hFig = figure;
hAxes = axes;
copyobj(hSeq,hAxes);



% --- Executes on button press in pbAddChannel.
function pbAddChannel_Callback(hObject, eventdata, handles)
% hObject    handle to pbAddChannel (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
EditgEditSEQ('AddChannel',hObject, eventdata, handles)




% --- Executes on button press in pbDelChannel.
function pbDelChannel_Callback(hObject, eventdata, handles)
% hObject    handle to pbDelChannel (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
EditgEditSEQ('DelChannel',hObject, eventdata, handles)




% --- Executes on key press with focus on DT1 and none of its controls.
function DT1_KeyPressFcn(hObject, eventdata, handles)
% hObject    handle to DT1 (see GCBO)
% eventdata  structure with the following fields (see UICONTROL)
%	Key: name of the key that was pressed, in lower case
%	Character: character interpretation of the key(s) that was pressed
%	Modifier: name(s) of the modifier key(s) (i.e., control, shift) pressed
% handles    structure with handles and user data (see GUIDATA)



function risePhase_Callback(hObject, eventdata, handles)
% hObject    handle to risePhase (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of risePhase as text
%        str2double(get(hObject,'String')) returns contents of risePhase as a double
%
% update the Phase
EditgEditSEQ('Phase',hObject, eventdata, handles)

% --- Executes during object creation, after setting all properties.
function risePhase_CreateFcn(hObject, eventdata, handles)
% hObject    handle to risePhase (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end




% --- Executes on button press in cbPhases.
function cbPhases_Callback(hObject, eventdata, handles)
% hObject    handle to cbPhases (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of cbPhases


% --- Executes during object creation, after setting all properties.
function AddSequenceFile_CreateFcn(hObject, eventdata, handles)
% hObject    handle to AddSequenceFile (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called




% --- Executes on button press in ReplaceSequence.
function ReplaceSequence_Callback(hObject, eventdata, handles)
% hObject    handle to ReplaceSequence (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
EditSequenceFunctionPool('ReplaceSequence',hObject, eventdata, handles);








% --- Executes during object creation, after setting all properties.
function ReplaceSequence_CreateFcn(hObject, eventdata, handles)
% hObject    handle to ReplaceSequence (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called


