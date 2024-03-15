function varargout = counts(varargin)
% COUNTS MATLAB code for counts.fig
%      COUNTS, by itself, creates a new COUNTS or raises the existing
%      singleton*.
%
%      H = COUNTS returns the handle to a new COUNTS or the handle to
%      the existing singleton*.
%
%      COUNTS('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in COUNTS.M with the given input arguments.
%
%      COUNTS('Property','Value',...) creates a new COUNTS or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before counts_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      bStop.  All inputs are passed to counts_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help counts

% Last Modified by GUIDE v2.5 01-Sep-2016 19:15:14

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @counts_OpeningFcn, ...
                   'gui_OutputFcn',  @counts_OutputFcn, ...
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


% --- Executes just before counts is made visible.
function counts_OpeningFcn(hObject, eventdata, handles, varargin)
LoadNIDAQmx;
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to counts (see VARARGIN)
%%%%%update_Callback(hObject, eventdata, handles)

% Choose default command line output for counts
handles.output = hObject;

% bupdate handles structure
guidata(hObject, handles);

% UIWAIT makes counts wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = counts_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on button press in bUpdate.
function bUpdate_Callback(hObject, eventdata, handles)
global gmSEQ
gmSEQ.meas='SPCM';
% hObject    handle to bUpdate (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global bGo hCPS

bGo = true;
NRead = 20;
intTime=str2double(get(handles.int,'String'))/NRead;
numPts=str2double(get(handles.pts,'String'));
TimeOut = intTime * NRead * 1.1;
Freq = 1/intTime;


[~, hCounter] = SetCounter(NRead+1,Freq);
[~, hPulse] = DigPulseTrainCont(Freq,0.5,NRead+1);
hCPS.hCounter = hCounter;
hCPS.hPulse = hPulse;
try
f=zeros(numPts,1);
i=0;
while bGo
    status = DAQmxStartTask(hCounter);  DAQmxErr(status);
    status = DAQmxStartTask(hPulse);    DAQmxErr(status);

    DAQmxWaitUntilTaskDone(hCounter,TimeOut);

    DAQmxStopTask(hPulse);

    A = ReadCounter(hCounter,NRead+1);
    DAQmxStopTask(hCounter);
    f(mod(i,numPts)+1)=ProcessData(A, NRead, intTime);
    p=plot(f);
    p.LineWidth=3; % trace thickness
    axes(handles.axesCounts)
    hold on
    s=scatter(mod(i,numPts)+1,f(mod(i,numPts)+1),'r');
    s.LineWidth=2; % dot thickness
    axis([1 numPts str2double(get(handles.min,'String')) str2double(get(handles.max,'String'))]);
    if (get(handles.rLog,'Value') == get(handles.rLog,'Max'))
    	set(gca, 'YScale', 'log')
    end
    hold off
    i=i+1;
    drawnow;
    if i==numPts
        bGo=0;
    end
end
catch ME
    DAQmxStopTask(hPulse);
    DAQmxStopTask(hCounter);
    DAQmxClearTask(hPulse);
    DAQmxClearTask(hCounter);
    rethrow(ME);
end

DAQmxClearTask(hPulse);
DAQmxClearTask(hCounter);



function min_Callback(hObject, eventdata, handles)
% hObject    handle to min (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% Hints: get(hObject,'String') returns contents of min as text
%        str2double(get(hObject,'String')) returns contents of min as a double


% --- Executes during object creation, after setting all properties.
function min_CreateFcn(hObject, eventdata, handles)
% hObject    handle to min (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function pts_Callback(hObject, eventdata, handles)
% hObject    handle to pts (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of pts as text
%        str2double(get(hObject,'String')) returns contents of pts as a double


% --- Executes during object creation, after setting all properties.
function pts_CreateFcn(hObject, eventdata, handles)
% hObject    handle to pts (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function max_Callback(hObject, eventdata, handles)
% hObject    handle to max (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of max as text
%        str2double(get(hObject,'String')) returns contents of max as a double


% --- Executes during object creation, after setting all properties.
function max_CreateFcn(hObject, eventdata, handles)
% hObject    handle to max (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function int_Callback(hObject, eventdata, handles)
% hObject    handle to int (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of int as text
%        str2double(get(hObject,'String')) returns contents of int as a double


% --- Executes during object creation, after setting all properties.
function int_CreateFcn(hObject, eventdata, handles)
% hObject    handle to int (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in bStop.
function bStop_Callback(hObject, eventdata, handles)
global bGo;
bGo = false;
% hObject    handle to bStop (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% function task = SetCounter(N)
% DAQmx_Val_Volts= 10348; % measure volts
% DAQmx_Val_Rising = 10280; % Rising
% DAQmx_Val_FiniteSamps = 10178; % Finite Samples
% DAQmx_Val_CountUp = 10128; % Count Up
% DAQmx_Val_CountDown = 10124; % Count Down
% DAQmx_Val_GroupByChannel = 0; % Group per channel
% DAQmx_Val_ContSamps =10123; % Continuous Samples
% 
% [ status, TaskName, task ] = DAQmxCreateTask([]);
% 
% if status,
% disp(['NI: Create Counter Task  :' num2str(status)]);
% end
% status = DAQmxCreateCICountEdgesChan(task,'Dev1/ctr0','',...
%     DAQmx_Val_Rising , 0, DAQmx_Val_CountUp);
% 
% if status,
% disp(['NI: Create Counter       :' num2str(status)]);
% end
% status = DAQmxCfgSampClkTiming(task,'/Dev1/PFI13',1.0,...
%     DAQmx_Val_Rising,DAQmx_Val_FiniteSamps ,N);
% if status,
% disp(['NI: Cofigure the Clk     :' num2str(status)]);
% end

function [status, task] = SetCounter(varargin)
%varargin(1) is the number of total samples
%varargin(2) is the frequency of the gating to expect
% Initialize DAQ
global gmSEQ
if strcmp(gmSEQ.meas,'SPCM')
    [status, task ] = DAQmxFunctionPool('SetCounter',cell2mat(varargin(1)));
elseif strcmp(gmSEQ.meas,'APD')
    [status, task ] = DAQmxFunctionPool('CreateAIChannel','/Dev1/PFI13',cell2mat(varargin(1)),cell2mat(varargin(2)));
end

function readArray = ReadCounter(task,N)
numSampsPerChan = N;
timeout = 0;
readArray = zeros(1,N);
global gmSEQ
if strcmp(gmSEQ.meas,'SPCM')
    [status, readArray]= DAQmxReadCounterU32(task, numSampsPerChan, timeout, zeros(1,numSampsPerChan), numSampsPerChan, libpointer('int32Ptr',0) ); 
elseif strcmp(gmSEQ.meas,'APD')
    [status, readArray] = DAQmxFunctionPool('ReadAnalogVoltage',task, numSampsPerChan, timeout);
end
DAQmxErr(status);

function data=ProcessData(RawData, NRead, intTime)
global gmSEQ
if strcmp(gmSEQ.meas,'SPCM')
    data=diff(RawData);
    data=sum(data)/(NRead * intTime);
elseif strcmp(gmSEQ.meas,'APD')
    data=mean(RawData);
end

% --- Executes during object creation, after setting all properties.
function axesCounts_CreateFcn(hObject, eventdata, handles)
% hObject    handle to axesCounts (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: place code in OpeningFcn to populate axesCounts
