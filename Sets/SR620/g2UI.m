function varargout = g2UI(varargin)
% g2UI MATLAB code for g2UI.fig
%      g2UI, by itself, creates a new g2UI or raises the existing
%      singleton*.
%
%      H = g2UI returns the handle to a new g2UI or the handle to
%      the existing singleton*.
%
%      g2UI('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in g2UI.M with the given input arguments.
%
%      g2UI('Property','Value',...) creates a new g2UI or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before g2UI_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to g2UI_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help g2UI

% Last Modified by GUIDE v2.5 04-Jun-2018 18:47:56

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @g2UI_OpeningFcn, ...
                   'gui_OutputFcn',  @g2UI_OutputFcn, ...
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


% --- Executes just before g2UI is made visible.
function g2UI_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to g2UI (see VARARGIN)

% Choose default command line output for g2UI
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes g2UI wait for user response (see UIRESUME)
% uiwait(handles.figure1);

% Initialize SR620 object
global device
device = SR620('GPIB0::16::INSTR');

% Set plotting defaults
xlabel('Time (s)');
ylabel('Count');

% Set display defaults
handles.axisMinBox.String = device.minInterval;
handles.axisMaxBox.String = device.maxInterval;
handles.binSizeBox.String = device.binSize;
handles.measureAtOnceBox.String = device.measureAtOnce;
handles.minTrackBox.String = device.minTrack;
handles.minTimeBox.String = device.minTime;
handles.voltBox1.String = '3.3';
handles.voltBox2.String = '3.3';
set(handles.slopeSelect1,'Value',1);
set(handles.slopeSelect2,'Value',1);


% --- Outputs from this function are returned to the command line.
function varargout = g2UI_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;

function edit1_Callback(hObject, eventdata, handles)
% hObject    handle to edit1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit1 as text
%        str2double(get(hObject,'String')) returns contents of edit1 as a double

% --- Executes on button press in takedata.
function takedata_Callback(hObject, eventdata, handles)
% hObject    handle to takedata (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global device

device.g2Measure(num2str(device.numSample));%,device.cabletest);
handles.filenameDisplayBox.String = strcat('Wrote measurement to:', '');

function numSampleBox_Callback(hObject, eventdata, handles)
% hObject    handle to numSampleBox (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of numSampleBox as text
%        str2double(get(hObject,'String')) returns contents of numSampleBox as a double
global device

device.set_numSamples(get(hObject,'String'))


% --- Executes during object creation, after setting all properties.
function numSampleBox_CreateFcn(hObject, eventdata, handles)
% hObject    handle to numSampleBox (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

% --- Executes on button press in testBox.
function testBox_Callback(hObject, eventdata, handles)
% hObject    handle to testBox (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of testBox
global device

if get(hObject,'Value')
    device.cabletest = true;
else
    device.cabletest = false;
end


% --- Executes on button press in plotButton.
function plotButton_Callback(hObject, eventdata, handles)
% hObject    handle to plotButton (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global device

histDisplay = device.g2Calculate();



function queryBox_Callback(hObject, eventdata, handles)
% hObject    handle to queryBox (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of queryBox as text
%        str2double(get(hObject,'String')) returns contents of queryBox as a double
global query_to_send
query_to_send = get(hObject,'String');


% --- Executes during object creation, after setting all properties.
function queryBox_CreateFcn(hObject, eventdata, handles)
% hObject    handle to queryBox (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

% --- Executes on button press in submitQueryButton.
function submitQueryButton_Callback(hObject, eventdata, handles)
% hObject    handle to submitQueryButton (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global device
global query_to_send

device.open();
handles.queryResponseText.String = query(device.visa, query_to_send);
device.close();
%set(handles.queryResponseText, 'String', query(device.visa, query_to_send));


% --- Executes on button press in submitWriteButton.
function submitWriteButton_Callback(hObject, eventdata, handles)
% hObject    handle to submitWriteButton (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global device
global write_to_send

device.open();
device.write(write_to_send)
device.close();


function writeBox_Callback(hObject, eventdata, handles)
% hObject    handle to writeBox (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of writeBox as text
%        str2double(get(hObject,'String')) returns contents of writeBox as a double

global write_to_send
write_to_send = get(hObject,'String');


% --- Executes during object creation, after setting all properties.
function writeBox_CreateFcn(hObject, eventdata, handles)
% hObject    handle to writeBox (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in idnBox.
function idnBox_Callback(hObject, eventdata, handles)
% hObject    handle to idnBox (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global device

device.open();
handles.idnText.String = query(device.visa, '*IDN?');
device.close();
pause(1);
device.open();
handles.idnText.String = '...';
device.close();


% --- Executes on button press in autoscaleButton.
function autoscaleButton_Callback(hObject, eventdata, handles)
% hObject    handle to autoscaleButton (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Try to adjust axis to range from 0.1st percentile to 99.9th with N/300
% bins where N is number of data points. If doesn't work, revert.
% Dynamically update plot.
global device

oldSettingMin = device.minInterval;
oldSettingMax = device.maxInterval;
oldSettingWidth = device.binSize;

try
    % Determine bin size using Freedman-Diaconis rule
    IQR = prctile(device.currentData,75) - prctile(device.currentData,25);
    
    if device.measureCounts
        device.binSize = 2 * IQR * length(device.currentData)^(-1/3); % How many bins we want

        device.minInterval = prctile(device.currentData,0.1);
        device.maxInterval = prctile(device.currentData,99.9);
    else
        device.binSize = 2 * IQR * length(device.currentData)^(-1/3) / 1e-9; % How many bins we want

        device.minInterval = prctile(device.currentData,0.1) / 1e-9;
        device.maxInterval = prctile(device.currentData,99.9) / 1e-9;
    end
    
    device.edges = device.minInterval:device.binSize:device.maxInterval-device.binSize;
    device.g2Hist(device.currentData);
catch ME
    device.minInterval = oldSettingMin;
    device.maxInterval = oldSettingMax;
    device.binSize = oldSettingWidth;
    device.edges = device.minInterval:device.binSize:device.maxInterval-device.binSize;
end

% Edit input text boxes to match autoscaling
handles.axisMinBox.String = device.minInterval;
handles.axisMaxBox.String = device.maxInterval;
handles.binSizeBox.String = device.binSize;



function axisMinBox_Callback(hObject, eventdata, handles)
% hObject    handle to axisMinBox (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of axisMinBox as text
%        str2double(get(hObject,'String')) returns contents of axisMinBox as a double

% Try to change t min to new one. If it's an invalid choice, revert to
% the old one. Also dynamically update plot.
global device
oldSetting = device.minInterval;

try
    device.minInterval = str2double(get(hObject,'String'));
    device.edges = device.minInterval:device.binSize:device.maxInterval-device.binSize;
    device.g2Hist(device.currentData);
catch ME
    device.minInterval = oldSetting;
    handles.axisMinBox.String = device.minInterval;
    return;
end


% --- Executes during object creation, after setting all properties.
function axisMinBox_CreateFcn(hObject, eventdata, handles)
% hObject    handle to axisMinBox (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


function axisMaxBox_Callback(hObject, eventdata, handles)
% hObject    handle to axisMaxBox (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of axisMaxBox as text
%        str2double(get(hObject,'String')) returns contents of axisMaxBox as a double
global device

% Try to change t max to new one. If it's an invalid choice, revert to
% the old one. Also dynamically update plot.
oldSetting = device.maxInterval;

try
    device.maxInterval = str2double(get(hObject,'String'));
    device.edges = device.minInterval:device.binSize:device.maxInterval-device.binSize;
    device.g2Hist(device.currentData);
catch ME
    device.maxInterval = oldSetting;
    handles.axisMaxBox.String = device.maxInterval;
    return;
end

% --- Executes during object creation, after setting all properties.
function axisMaxBox_CreateFcn(hObject, eventdata, handles)
% hObject    handle to axisMaxBox (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function binSizeBox_Callback(hObject, eventdata, handles)
% hObject    handle to binSizeBox (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of binSizeBox as text
%        str2double(get(hObject,'String')) returns contents of binSizeBox as a double
global device

% Try to change bin width to new one. If it's an invalid choice, revert to
% the old one. Also dynamically update plot.
oldSetting = device.binSize;

try
    device.binSize = str2double(get(hObject,'String'));
    device.edges = device.minInterval:device.binSize:device.maxInterval-device.binSize;
    device.g2Hist(device.currentData);
catch ME
    device.binSize = oldSetting;
    handles.binSizeBox.String = device.binSize;
    return;
end


% --- Executes during object creation, after setting all properties.
function binSizeBox_CreateFcn(hObject, eventdata, handles)
% hObject    handle to binSizeBox (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in countsBox.
function countsBox_Callback(hObject, eventdata, handles)
% hObject    handle to countsBox (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of countsBox
global device

if get(hObject,'Value')
    device.countsMeasure = true;
    xlabel('Measured Counts');
    ylabel('Count');
else
    device.countsMeasure = false;
    xlabel('Time (s)');
    ylabel('Count');
end


% --- Executes on button press in defaultButton.
function defaultButton_Callback(hObject, eventdata, handles)
% hObject    handle to defaultButton (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global device

handles.voltBox1.String = '3.3';
handles.voltBox2.String = '3.3';
set(handles.slopeSelect1,'Value',1);
set(handles.slopeSelect2,'Value',1);
set(handles.slopeSelect1,'Value',1);
set(handles.slopeSelect2,'Value',1);
set(handles.select0,'Value', 1);
set(handles.select1,'Value', 0);
set(handles.select2,'Value', 0);
set(handles.select3,'Value', 0);
set(handles.select4,'Value', 0);
set(handles.select5,'Value', 0);
set(handles.select6,'Value', 0);
set(handles.select7,'Value', 0);
set(handles.select8,'Value', 0);
set(handles.select9,'Value', 0);
set(handles.select10,'Value', 0);
set(handles.select11,'Value', 0);
set(handles.select12,'Value', 0);
set(handles.mode0,'Value', 1);
set(handles.mode1,'Value', 0);
set(handles.mode2,'Value', 0);
set(handles.mode3,'Value', 0);
set(handles.mode4,'Value', 0);
set(handles.mode5,'Value', 0);
set(handles.mode6,'Value', 0);

device.open();
fprintf(device.visa, 'LEVL 1,3.3');
fprintf(device.visa, 'LEVL 2,3.3');
fprintf(device.visa, 'TSLP 1,0');
fprintf(device.visa, 'TSLP 2,0');

fprintf(device.visa, 'MODE 0');
fprintf(device.visa, 'ARMM 0');

device.countsMeasure = false;
device.close()


% --- Executes on selection change in slopeSelect1.
function slopeSelect1_Callback(hObject, eventdata, handles)
% hObject    handle to slopeSelect1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns slopeSelect1 contents as cell array
%        contents{get(hObject,'Value')} returns selected item from slopeSelect1
global device

% Determine the selected data set.
str = get(hObject, 'String');
val = get(hObject,'Value');

% Set current data to the selected data set.
switch str{val}
    case 'Positive' % User selects peaks.
       device.write('TSLP 1,0');
    case 'Negative' % User selects membrane.
       device.write('TSLP 1,1');
end

% Save the handles structure.
guidata(hObject,handles)



% --- Executes during object creation, after setting all properties.
function slopeSelect1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to slopeSelect1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function voltBox1_Callback(hObject, eventdata, handles)
% hObject    handle to voltBox1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of voltBox1 as text
%        str2double(get(hObject,'String')) returns contents of voltBox1 as a double
global device

try
    newVolt = str2double(get(hObject,'String'));
    command = strcat('LEVL 1,',get(hObject,'String'));
    device.write(command);
catch ME
    return;
end


% --- Executes during object creation, after setting all properties.
function voltBox1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to voltBox1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function voltBox2_Callback(hObject, eventdata, handles)
% hObject    handle to voltBox2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of voltBox2 as text
%        str2double(get(hObject,'String')) returns contents of voltBox2 as a double
global device

try
    newVolt = str2double(get(hObject,'String'));
    command = strcat('LEVL 2,',get(hObject,'String'));
    device.write(command);
catch ME
    return;
end

% --- Executes during object creation, after setting all properties.
function voltBox2_CreateFcn(hObject, eventdata, handles)
% hObject    handle to voltBox2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in slopeSelect2.
function slopeSelect2_Callback(hObject, eventdata, handles)
% hObject    handle to slopeSelect2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns slopeSelect2 contents as cell array
%        contents{get(hObject,'Value')} returns selected item from slopeSelect2
global device

% Determine the selected data set.
str = get(hObject, 'String');
val = get(hObject,'Value');

% Set current data to the selected data set.
switch str{val}
    case 'Positive' % User selects peaks.
       device.write('TSLP 2,0');
    case 'Negative' % User selects membrane.
       device.write('TSLP 2,1');
end

% Save the handles structure.
guidata(hObject,handles)


% --- Executes during object creation, after setting all properties.
function slopeSelect2_CreateFcn(hObject, eventdata, handles)
% hObject    handle to slopeSelect2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in select0.
function select0_Callback(hObject, eventdata, handles)
% hObject    handle to select0 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of select0
global device

device.open();
if get(hObject,'Value') == 1
    device.write('ARMM 0');
end
device.close();


% --- Executes on button press in select1.
function select1_Callback(hObject, eventdata, handles)
% hObject    handle to select1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of select1
global device

device.open();
if get(hObject,'Value') == 1
    device.write('ARMM 1');
end
device.close();

% --- Executes on button press in select2.
function select2_Callback(hObject, eventdata, handles)
% hObject    handle to select2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of select2
global device

device.open();
if get(hObject,'Value') == 1
    device.write('ARMM 2');
end
device.close();

% --- Executes on button press in select3.
function select3_Callback(hObject, eventdata, handles)
% hObject    handle to select3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of select3
global device

device.open();
if get(hObject,'Value') == 1
    device.write('ARMM 3');
end
device.close();


% --- Executes on button press in select4.
function select4_Callback(hObject, eventdata, handles)
% hObject    handle to select4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of select4
global device

device.open();
if get(hObject,'Value') == 1
    device.write('ARMM 4');
end
device.close();


% --- Executes on button press in select5.
function select5_Callback(hObject, eventdata, handles)
% hObject    handle to select5 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of select5
global device

device.open();
if get(hObject,'Value') == 1
    device.write('ARMM 5');
end
device.close();


% --- Executes on button press in select6.
function select6_Callback(hObject, eventdata, handles)
% hObject    handle to select6 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of select6
global device

device.open();
if get(hObject,'Value') == 1
    device.write('ARMM 6');
end
device.close();


% --- Executes on button press in select7.
function select7_Callback(hObject, eventdata, handles)
% hObject    handle to select7 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of select7
global device

device.open();
if get(hObject,'Value') == 1
    device.write('ARMM 7');
end
device.close();

% --- Executes on button press in select8.
function select8_Callback(hObject, eventdata, handles)
% hObject    handle to select8 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of select8
global device

device.open();
if get(hObject,'Value') == 1
    device.write('ARMM 8');
end
device.close();

% --- Executes on button press in select9.
function select9_Callback(hObject, eventdata, handles)
% hObject    handle to select9 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of select9
global device

device.open();
if get(hObject,'Value') == 1
    device.write('ARMM 9');
end
device.close();

% --- Executes on button press in select10.
function select10_Callback(hObject, eventdata, handles)
% hObject    handle to select10 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of select10
global device

device.open();
if get(hObject,'Value') == 1
    device.write('ARMM 10');
end
device.close();

% --- Executes on button press in select11.
function select11_Callback(hObject, eventdata, handles)
% hObject    handle to select11 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of select11
global device

device.open();
if get(hObject,'Value') == 1
    device.write('ARMM 11');
end
device.close();

% --- Executes on button press in select12.
function select12_Callback(hObject, eventdata, handles)
% hObject    handle to select12 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of select12
global device

device.open();
if get(hObject,'Value') == 1
    device.write('ARMM 12');
end
device.close();


% --- Executes on button press in cableTestButton.
function cableTestButton_Callback(hObject, eventdata, handles)
% hObject    handle to cableTestButton (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global device

handles.voltBox1.String = '3.3';
handles.voltBox2.String = '3.3';
set(handles.slopeSelect1,'Value',1);
set(handles.slopeSelect2,'Value',1);
set(handles.select0,'Value', 0);
set(handles.select1,'Value', 1);
set(handles.select2,'Value', 0);
set(handles.select3,'Value', 0);
set(handles.select4,'Value', 0);
set(handles.select5,'Value', 0);
set(handles.select6,'Value', 0);
set(handles.select7,'Value', 0);
set(handles.select8,'Value', 0);
set(handles.select9,'Value', 0);
set(handles.select10,'Value', 0);
set(handles.select11,'Value', 0);
set(handles.select12,'Value', 0);
set(handles.mode0,'Value', 1);
set(handles.mode1,'Value', 0);
set(handles.mode2,'Value', 0);
set(handles.mode3,'Value', 0);
set(handles.mode4,'Value', 0);
set(handles.mode5,'Value', 0);
set(handles.mode6,'Value', 0);

device.open();
fprintf(device.visa, 'LEVL 1,3.3');
fprintf(device.visa, 'LEVL 2,3.3');
fprintf(device.visa, 'TSLP 1,0');
fprintf(device.visa, 'TSLP 2,0');

fprintf(device.visa, 'MODE 0');
fprintf(device.visa, 'ARMM 1');

device.countsMeasure = false;
device.close();


% --- Executes on button press in countsButton.
function countsButton_Callback(hObject, eventdata, handles)
% hObject    handle to countsButton (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global device

handles.voltBox1.String = '3.3';
handles.voltBox2.String = '3.3';
set(handles.slopeSelect1,'Value',1);
set(handles.slopeSelect2,'Value',1);
set(handles.select0,'Value', 1);
set(handles.select1,'Value', 0);
set(handles.select2,'Value', 0);
set(handles.select3,'Value', 0);
set(handles.select4,'Value', 0);
set(handles.select5,'Value', 0);
set(handles.select6,'Value', 0);
set(handles.select7,'Value', 0);
set(handles.select8,'Value', 0);
set(handles.select9,'Value', 0);
set(handles.select10,'Value', 0);
set(handles.select11,'Value', 0);
set(handles.select12,'Value', 0);
set(handles.mode0,'Value', 0);
set(handles.mode1,'Value', 0);
set(handles.mode2,'Value', 0);
set(handles.mode3,'Value', 0);
set(handles.mode4,'Value', 0);
set(handles.mode5,'Value', 0);
set(handles.mode6,'Value', 1);

device.open();
fprintf(device.visa, 'LEVL 1,3.3');
fprintf(device.visa, 'LEVL 2,3.3');
fprintf(device.visa, 'TSLP 1,0');
fprintf(device.visa, 'TSLP 2,0');

fprintf(device.visa, 'MODE 6');
fprintf(device.visa, 'ARMM 0');

device.countsMeasure = true;
device.close();


% --- Executes on button press in mode0.
function mode0_Callback(hObject, eventdata, handles)
% hObject    handle to mode0 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of mode0
global device

device.open();
if get(hObject,'Value') == 1
    device.write('MODE 0');
end
device.close();


% --- Executes on button press in mode1.
function mode1_Callback(hObject, eventdata, handles)
% hObject    handle to mode1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of mode1
global device

device.open();
if get(hObject,'Value') == 1
    device.write('MODE 1');
end
device.close();


% --- Executes on button press in mode2.
function mode2_Callback(hObject, eventdata, handles)
% hObject    handle to mode2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of mode2
global device

device.open();
if get(hObject,'Value') == 1
    device.write('MODE 2');
end
device.close();


% --- Executes on button press in mode3.
function mode3_Callback(hObject, eventdata, handles)
% hObject    handle to mode3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of mode3
global device

device.open();
if get(hObject,'Value') == 1
    device.write('MODE 3');
end
device.close();


% --- Executes on button press in mode4.
function mode4_Callback(hObject, eventdata, handles)
% hObject    handle to mode4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of mode4
global device

device.open();
if get(hObject,'Value') == 1
    device.write('MODE 4');
end
device.close();


% --- Executes on button press in mode5.
function mode5_Callback(hObject, eventdata, handles)
% hObject    handle to mode5 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of mode5
global device

device.open();
if get(hObject,'Value') == 1
    device.write('MODE 5');
end
device.close();


% --- Executes on button press in mode6.
function mode6_Callback(hObject, eventdata, handles)
% hObject    handle to mode6 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of mode6
global device

device.open();
if get(hObject,'Value') == 1
    device.write('MODE 6');
end
device.close();



function measureAtOnceBox_Callback(hObject, eventdata, handles)
% hObject    handle to measureAtOnceBox (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of measureAtOnceBox as text
%        str2double(get(hObject,'String')) returns contents of measureAtOnceBox as a double
global device
oldSetting = device.measureAtOnce;

try
    device.measureAtOnce = str2double(get(hObject,'String'));
    if ~(device.measureAtOnce > 0)
        error('Nonpositive number detected')
    end
catch ME
    device.measureAtOnce = oldSetting;
    handles.measureAtOnceBox.String = device.measureAtOnce;
    return;
end


% --- Executes during object creation, after setting all properties.
function measureAtOnceBox_CreateFcn(hObject, eventdata, handles)
% hObject    handle to measureAtOnceBox (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function minTimeBox_Callback(hObject, eventdata, handles)
% hObject    handle to minTimeBox (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of minTimeBox as text
%        str2double(get(hObject,'String')) returns contents of minTimeBox as a double
global device
oldSetting = device.minTime;

try
    device.minTime = str2double(get(hObject,'String'));
    if ~(device.minTime > 0)
        error('Nonpositive number detected')
    end
catch ME
    device.minTime = oldSetting;
    handles.minTimeBox.String = device.minTime;
    return;
end



% --- Executes during object creation, after setting all properties.
function minTimeBox_CreateFcn(hObject, eventdata, handles)
% hObject    handle to minTimeBox (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function minTrackBox_Callback(hObject, eventdata, handles)
% hObject    handle to minTrackBox (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of minTrackBox as text
%        str2double(get(hObject,'String')) returns contents of minTrackBox as a double
global device
oldSetting = device.minTrack;

try
    device.minTrack = str2double(get(hObject,'String'));
    if ~(device.minTrack > 0)
        error('Nonpositive number detected')
    end
catch ME
    device.minTrack = oldSetting;
    handles.minTrackBox.String = device.minTrack;
    return;
end


% --- Executes during object creation, after setting all properties.
function minTrackBox_CreateFcn(hObject, eventdata, handles)
% hObject    handle to minTrackBox (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
