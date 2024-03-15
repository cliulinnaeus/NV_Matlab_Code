function varargout = TrackCenter(varargin)
% TRACKCENTER M-file for TrackCenter.fig
%      TRACKCENTER, by itself, creates a new TRACKCENTER or raises the existing
%      singleton*.
%
%      H = TRACKCENTER returns the handle to a new TRACKCENTER or the handle to
%      the existing singleton*.
%
%      TRACKCENTER('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in TRACKCENTER.M with the given input arguments.
%
%      TRACKCENTER('Property','Value',...) creates a new TRACKCENTER or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before TrackCenter_OpeningFunction gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to TrackCenter_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help TrackCenter

% Last Modified by GUIDE v2.5 27-Jul-2008 10:41:08

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @TrackCenter_OpeningFcn, ...
                   'gui_OutputFcn',  @TrackCenter_OutputFcn, ...
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


% --- Executes just before TrackCenter is made visible.
function TrackCenter_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to TrackCenter (see VARARGIN)

% Choose default command line output for TrackCenter
handles.output = hObject;

%% set the historical axes labels off
set(handles.axes6,'XTick',[]);
set(handles.axes6,'YTick',[]);
set(handles.axes6,'ZTick',[]);

set(handles.axes7,'XTick',[]);
set(handles.axes7,'YTick',[]);
set(handles.axes7,'ZTick',[]);
set(handles.axes8,'XTick',[]);
set(handles.axes8,'YTick',[]);
set(handles.axes8,'ZTick',[]);


% set default variables for figure
%handles.tracking = 0;
%handles = TrackCenterFunctionPool('Test',handles);
TrackCenterFunctionPool('Initialize',handles);
% create a ga

% Update handles structure
guidata(hObject, handles);

if length(varargin) > 0,
    if varargin{1} == 1,
        TrackCenterFunctionPool('TrackCenterLogic',handles);
        TrackCenterFunctionPool('Apply',handles);
        close('TrackCenter');
    end
end
% UIWAIT makes TrackCenter wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = TrackCenter_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
%varargout{1} = handles.output;
varargout{1} = 1;



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


% --- Executes on button press in startbutton.
function startbutton_Callback(hObject, eventdata, handles)
% hObject    handle to startbutton (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% if handles.tracking == 0,
%     
%     % update the button text
%     set(handles.startbutton,'String','Stop Tracking');
%     
%     % get the relevant varibles
%     V = [eval(get(handles.Vx,'String')),...
%         eval(get(handles.Vy,'String')),...
%         eval(get(handles.Vz,'string'))];
%     Step = eval(get(handles.stepSize,'String'))
%     MinStep = eval(get(handles.stepSizeMin,'String'))
%     dwell = get(handles.dwell,'String')
%     threshold = get(handles.threshold,'String')
%     
%     handles = TrackCenterFunctionPool('TrackCenterLogic',handles);
%     handles.tracking = 1;
%     guidata(hObject,handles);
%     
% elseif handles.tracking == 1,
%     set(handles.startbutton,'String','Start Tracking');
%     handles.tracking = 0;
%     guidata(hObject,handles);
% end

%clear the axes
TrackCenterFunctionPool('TrackCenterLogic',handles);

% should we track continuously?
while (get(handles.trackContCB,'Value')),
    pause(10); % reduce the duty cycle
    TrackCenterFunctionPool('Apply',handles);
    TrackCenterFunctionPool('TrackCenterLogic',handles);    
end

% --- Executes during object creation, after setting all properties.
function startbutton_CreateFcn(hObject, eventdata, handles)
% hObject    handle to startbutton (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called


% --- Executes during object creation, after setting all properties.
function axes1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to axes1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: place code in OpeningFcn to populate axes1



function maxIter_Callback(hObject, eventdata, handles)
% hObject    handle to maxIter (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of maxIter as text
%        str2double(get(hObject,'String')) returns contents of maxIter as a double


% --- Executes during object creation, after setting all properties.
function maxIter_CreateFcn(hObject, eventdata, handles)
% hObject    handle to maxIter (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in Refresh.
function Refresh_Callback(hObject, eventdata, handles)
% hObject    handle to Refresh (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
TrackCenterFunctionPool('Refresh',handles);


% --- Executes on button press in Apply.
function Apply_Callback(hObject, eventdata, handles)
% hObject    handle to Apply (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
TrackCenterFunctionPool('Apply',handles);


% --- Executes on button press in trackContCB.
function trackContCB_Callback(hObject, eventdata, handles)
% hObject    handle to trackContCB (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of trackContCB


% --------------------------------------------------------------------
function menuClearTrajectories_Callback(hObject, eventdata, handles)
% hObject    handle to menuClearTrajectories (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global gTracking
gTracking.Trajectory = [];


% --------------------------------------------------------------------
function Untitled_1_Callback(hObject, eventdata, handles)
% hObject    handle to Untitled_1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in Stop.
function Stop_Callback(hObject, eventdata, handles)
% hObject    handle to Stop (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
TrackCenterFunctionPool('Stop',handles);


