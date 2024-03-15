function varargout = ImageNVC(varargin)
% IMAGENVC M-file for ImageNVC.fig
%      IMAGENVC, by itself, creates a new IMAGENVC or raises the existing
%      singleton*.
%
%      H = IMAGENVC returns the handle to a new IMAGENVC or the handle to
%      the existing singleton*.
%
%      IMAGENVC('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in IMAGENVC.M with the given input arguments.
%
%      IMAGENVC('Property','Value',...) creates a new IMAGENVC or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before ImageNVC_OpeningFunction gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to ImageNVC_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help ImageNVC

% Last Modified by GUIDE v2.5 21-Sep-2021 22:20:14

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @ImageNVC_OpeningFcn, ...
                   'gui_OutputFcn',  @ImageNVC_OutputFcn, ...
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


% --- Executes just before ImageNVC is made visible.
function ImageNVC_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to ImageNVC (see VARARGIN)

% Choose default command line output for ImageNVC
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes ImageNVC wait for user response (see UIRESUME)
% uiwait(handles.figure1);
%Added by Jero
ImageFunctionPool('Start',hObject, eventdata, handles);


% --- Outputs from this function are returned to the command line.
function varargout = ImageNVC_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on button press in Scan.
function Scan_Callback(hObject, eventdata, handles)
% hObject    handle to Scan (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
%ImageScan('Scan',hObject, eventdata, handles);


global bGo
bGo = 1;

tic
set(handles.bMinThresh,'Value',0);
set(handles.bMaxThresh,'Value',0);
ScanEvery_T = eval(get(handles.ScanMinutes,'String'));
if get(handles.bScanEvery,'Value');
    max_it = 100;
else
    max_it = 1;
end

curr_it = 1;
while bGo == 1 && curr_it <= max_it 
    
    estimated_it = round(round(toc/60)/ScanEvery_T) + 1;
    if mod(round(toc/60),ScanEvery_T) == 0 && curr_it <= max_it && estimated_it == curr_it
        
        if get(handles.bScanEvery,'Value') && ScanEvery_T <=1
            disp('scanning minutes is too short!')
            bGo = 0;
            break;
        end
    
        disp(['#' num2str(curr_it) '-th measurement starts at ' num2str(round(toc/60)) ' min'])
        

            
            ImageFunctionPool('Scan',hObject, eventdata, handles);
  %          ImageFunctionPool('SetZero',hObject, eventdata, handles);

    
        curr_it = curr_it + 1;
    end
    
    pause(0.1)
    if get(handles.bScanStop,'Value')
        bGo = 0;
    end
    pause(0.1)
    
end
set(handles.bScanStop,'Value',0)
disp('scanning finished!')

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

function LDCControl(bOn, sg, current)

fopen(sg);
        
if bOn
    fprintf(sg,[':ILD:SET ' num2str(current)]);
    fprintf(sg,':LASER ON');
else
    fprintf(sg,[':ILD:SET ' num2str(0)]);
    fprintf(sg,':LASER OFF');
    fclose(sg);
    delete(sg);
    clear sg;
end

function ShutterControl(bOn)

% awg = gpib('ni',0,6);
% fopen(awg);

% if bOn
% fprintf(awg,'SOURce1:FUNCtion DC'); % turn on arb function
% %fprintf(awg,'SOURCE1:VOLT 0'); % set max waveform amplitude to 3 Vpp
% fprintf(awg,'SOURCE1:VOLT:OFFSET 2'); % set offset to 0 V
% fprintf(awg,'OUTPUT1:LOAD 50'); % set output load to 50 ohms
% %fprintf(awg,'SOURCE1:FUNCtion:ARB:SRATe 10000000'); % set sample rate
% %Enable Output for channel 1
% fprintf(awg,'OUTPUT1 ON');
% else
%     fprintf(awg,'OUTPUT1 OFF');
% end

% fclose(awg);
% delete(awg);
% clear awg;

function minVx_Callback(hObject, eventdata, handles)
% hObject    handle to minVx (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of minVx as text
%        str2double(get(hObject,'String')) returns contents of minVx as a double


% --- Executes during object creation, after setting all properties.
function minVx_CreateFcn(hObject, eventdata, handles)
% hObject    handle to minVx (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function maxVx_Callback(hObject, eventdata, handles)
% hObject    handle to maxVx (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of maxVx as text
%        str2double(get(hObject,'String')) returns contents of maxVx as a double


% --- Executes during object creation, after setting all properties.
function maxVx_CreateFcn(hObject, eventdata, handles)
% hObject    handle to maxVx (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function minVy_Callback(hObject, eventdata, handles)
% hObject    handle to minVy (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of minVy as text
%        str2double(get(hObject,'String')) returns contents of minVy as a double


% --- Executes during object creation, after setting all properties.
function minVy_CreateFcn(hObject, eventdata, handles)
% hObject    handle to minVy (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function maxVy_Callback(hObject, eventdata, handles)
% hObject    handle to maxVy (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of maxVy as text
%        str2double(get(hObject,'String')) returns contents of maxVy as a double


% --- Executes during object creation, after setting all properties.
function maxVy_CreateFcn(hObject, eventdata, handles)
% hObject    handle to maxVy (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function NVx_Callback(hObject, eventdata, handles)
% hObject    handle to NVx (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of NVx as text
%        str2double(get(hObject,'String')) returns contents of NVx as a double


% --- Executes during object creation, after setting all properties.
function NVx_CreateFcn(hObject, eventdata, handles)
% hObject    handle to NVx (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

function NVy_Callback(hObject, eventdata, handles)
% hObject    handle to NVy (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of NVy as text
%        str2double(get(hObject,'String')) returns contents of NVy as a double

% --- Executes during object creation, after setting all properties.
function NVy_CreateFcn(hObject, eventdata, handles)
% hObject    handle to NVy (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


function minVz_Callback(hObject, eventdata, handles)
% hObject    handle to minVz (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of minVz as text
%        str2double(get(hObject,'String')) returns contents of minVz as a double

% --- Executes during object creation, after setting all properties.
function minVz_CreateFcn(hObject, eventdata, handles)
% hObject    handle to minVz (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function MaxVz_Callback(hObject, eventdata, handles)
% hObject    handle to MaxVz (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of MaxVz as text
%        str2double(get(hObject,'String')) returns contents of MaxVz as a double


% --- Executes during object creation, after setting all properties.
function MaxVz_CreateFcn(hObject, eventdata, handles)
% hObject    handle to MaxVz (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function NVz_Callback(hObject, eventdata, handles)
% hObject    handle to NVz (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of NVz as text
%        str2double(get(hObject,'String')) returns contents of NVz as a double


% --- Executes during object creation, after setting all properties.
function NVz_CreateFcn(hObject, eventdata, handles)
% hObject    handle to NVz (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function FixVx_Callback(hObject, eventdata, handles)
% hObject    handle to FixVx (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of FixVx as text
%        str2double(get(hObject,'String')) returns contents of FixVx as a double


% --- Executes during object creation, after setting all properties.
function FixVx_CreateFcn(hObject, eventdata, handles)
% hObject    handle to FixVx (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function FixVy_Callback(hObject, eventdata, handles)
% hObject    handle to FixVy (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of FixVy as text
%        str2double(get(hObject,'String')) returns contents of FixVy as a double


% --- Executes during object creation, after setting all properties.
function FixVy_CreateFcn(hObject, eventdata, handles)
% hObject    handle to FixVy (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function FixVz_Callback(hObject, eventdata, handles)
% hObject    handle to FixVz (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of FixVz as text
%        str2double(get(hObject,'String')) returns contents of FixVz as a double


% --- Executes during object creation, after setting all properties.
function FixVz_CreateFcn(hObject, eventdata, handles)
% hObject    handle to FixVz (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function minDT_Callback(hObject, eventdata, handles)
% hObject    handle to minDT (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of minDT as text
%        str2double(get(hObject,'String')) returns contents of minDT as a double


% --- Executes during object creation, after setting all properties.
function minDT_CreateFcn(hObject, eventdata, handles)
% hObject    handle to minDT (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function maxDT_Callback(hObject, eventdata, handles)
% hObject    handle to maxDT (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of maxDT as text
%        str2double(get(hObject,'String')) returns contents of maxDT as a double


% --- Executes during object creation, after setting all properties.
function maxDT_CreateFcn(hObject, eventdata, handles)
% hObject    handle to maxDT (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function NDT_Callback(hObject, eventdata, handles)
% hObject    handle to NDT (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of NDT as text
%        str2double(get(hObject,'String')) returns contents of NDT as a double


% --- Executes during object creation, after setting all properties.
function NDT_CreateFcn(hObject, eventdata, handles)
% hObject    handle to NDT (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in bFixDT.
function bFixDT_Callback(hObject, eventdata, handles)
% hObject    handle to bFixDT (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of bFixDT



function FixDT_Callback(hObject, eventdata, handles)
% hObject    handle to FixDT (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of FixDT as text
%        str2double(get(hObject,'String')) returns contents of FixDT as a double


% --- Executes during object creation, after setting all properties.
function FixDT_CreateFcn(hObject, eventdata, handles)
% hObject    handle to FixDT (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end





function maxVz_Callback(hObject, eventdata, handles)
% hObject    handle to maxVz (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of maxVz as text
%        str2double(get(hObject,'String')) returns contents of maxVz as a double


% --- Executes during object creation, after setting all properties.
function maxVz_CreateFcn(hObject, eventdata, handles)
% hObject    handle to maxVz (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end




% --- Executes on mouse press over axes background.
function axes1_ButtonDownFcn(hObject, eventdata, handles)
% hObject    handle to axes1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
%ImageSetXYVoltage('Cursor',hObject, eventdata, handles)
ImageFunctionPool('Cursor',hObject, eventdata, handles);


% --- Executes on button press in bCursorXY.
function bCursorXY_Callback(hObject, eventdata, handles)
% hObject    handle to bCursorXY (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of bCursorXY
%ImageSetXYVoltage('CursorType',hObject, eventdata, handles);
ImageFunctionPool('CursorType',hObject, eventdata, handles);


% --- Executes on button press in Align.
function Align_Callback(hObject, eventdata, handles)
% hObject    handle to Align (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
ImageFunctionPool('Align',hObject, eventdata, handles);


% --- Executes on button press in StopAlign.
function StopAlign_Callback(hObject, eventdata, handles)
% hObject    handle to StopAlign (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
%ImageScan('StopAlign',hObject, eventdata, handles);
ImageFunctionPool('StopAlign',hObject, eventdata, handles);


% --- Executes on button press in StopScan.
function StopScan_Callback(hObject, eventdata, handles)
% hObject    handle to StopScan (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
%ImageScan('StopScan',hObject, eventdata, handles);
ImageFunctionPool('StopScan',hObject, eventdata, handles);


function CPS_Callback(hObject, eventdata, handles)
% hObject    handle to CPS (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of CPS as text
%        str2double(get(hObject,'String')) returns contents of CPS as a double


% --- Executes during object creation, after setting all properties.
function CPS_CreateFcn(hObject, eventdata, handles)
% hObject    handle to CPS (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in bScanCont.
function bScanCont_Callback(hObject, eventdata, handles)
% hObject    handle to bScanCont (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of bScanCont


% --- Executes on button press in SaveImage.
function SaveImage_Callback(hObject, eventdata, handles)
% hObject    handle to SaveImage (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
%ImageSaveImage('saveimage',hObject, eventdata, handles);
ImageFunctionPool('Save',hObject, eventdata, handles);

% --- Executes on button press in bSaveImgData.
function bSaveImgData_Callback(hObject, eventdata, handles)
% hObject    handle to bSaveImgData (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of bSaveImgData


% --- Executes on button press in bSaveImgEPS.
function bSaveImgEPS_Callback(hObject, eventdata, handles)
% hObject    handle to bSaveImgEPS (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of bSaveImgEPS


% --- Executes on button press in SaveAs.
function SaveAs_Callback(hObject, eventdata, handles)
% hObject    handle to SaveAs (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
%ImageSaveImage('ChangeFileName',hObject, eventdata, handles)
ImageFunctionPool('ChangeFileName',hObject, eventdata, handles);


% --- Executes on button press in bSaveImg.
function bSaveImg_Callback(hObject, eventdata, handles)
% hObject    handle to bSaveImg (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of bSaveImg


% --- Executes on button press in bOverwrite.
function bOverwrite_Callback(hObject, eventdata, handles)
% hObject    handle to bOverwrite (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of bOverwrite


% --- Executes on button press in UploadPrevious.
function UploadPrevious_Callback(hObject, eventdata, handles)
% hObject    handle to UploadPrevious (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
%ImageUpload('UploadPrevious',hObject, eventdata, handles);
ImageFunctionPool('UploadPrevious',hObject, eventdata, handles);

% --- Executes on button press in Upload.
function Upload_Callback(hObject, eventdata, handles)
% hObject    handle to Upload (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
%ImageUpload('Upload',hObject, eventdata, handles);
ImageFunctionPool('Upload',hObject, eventdata, handles);

% --- Executes on button press in UploadNext.
function UploadNext_Callback(hObject, eventdata, handles)
% hObject    handle to UploadNext (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
%ImageUpload('UploadNext',hObject, eventdata, handles);
ImageFunctionPool('UploadNext',hObject, eventdata, handles);

% --- Executes on button press in RunCPS.
function RunCPS_Callback(hObject, eventdata, handles)
% hObject    handle to RunCPS (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of RunCPS
%ImageCPS('Run',hObject, eventdata, handles);
ImageFunctionPool('RunCPS',hObject, eventdata, handles);


% --- Executes on button press in StopCPS.
function StopCPS_Callback(hObject, eventdata, handles)
% hObject    handle to StopCPS (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
%ImageCPS('Stop',hObject, eventdata, handles);
ImageFunctionPool('StopCPS',hObject, eventdata, handles);



% --- Executes on button press in bFixVz.
function bFixVz_Callback(hObject, eventdata, handles)
% hObject    handle to bFixVz (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of bFixVz


% --- Executes on button press in ScanZ.
function ScanZ_Callback(hObject, eventdata, handles)
% hObject    handle to ScanZ (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
%ImageScan('ScanZ',hObject, eventdata, handles);
ImageFunctionPool('ScanZ',hObject, eventdata, handles);




% --- Executes on button press in Delete.
function Delete_Callback(hObject, eventdata, handles)
% hObject    handle to Delete (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
%ImageUpload('Delete',hObject, eventdata, handles);
ImageFunctionPool('Delete',hObject, eventdata, handles);


% --- Executes on button press in bZoom.
function bZoom_Callback(hObject, eventdata, handles)
% hObject    handle to bZoom (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of bZoom
%ImageZoom('Zoom On',hObject, eventdata, handles);
ImageFunctionPool('Zoom On',hObject, eventdata, handles);

% --- Executes on button press in SetRange.
function SetRange_Callback(hObject, eventdata, handles)
% hObject    handle to SetRange (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
%ImageScan('SetRange',hObject, eventdata, handles);
ImageFunctionPool('SetRange',hObject, eventdata, handles);



% --- Executes on button press in bFixVx.
function bFixVx_Callback(hObject, eventdata, handles)
% hObject    handle to bFixVx (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of bFixVx


% --- If Enable == 'on', executes on mouse press in 5 pixel border.
% --- Otherwise, executes on mouse press in 5 pixel border or over bFixVx.
function bFixVx_ButtonDownFcn(hObject, eventdata, handles)
% hObject    handle to bFixVx (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes during object creation, after setting all properties.
function bFixVx_CreateFcn(hObject, eventdata, handles)
% hObject    handle to bFixVx (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called



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



function UploadedNotes_Callback(hObject, eventdata, handles)
% hObject    handle to UploadedNotes (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of UploadedNotes as text
%        str2double(get(hObject,'String')) returns contents of UploadedNotes as a double


% --- Executes during object creation, after setting all properties.
function UploadedNotes_CreateFcn(hObject, eventdata, handles)
% hObject    handle to UploadedNotes (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in APendNotes.
function APendNotes_Callback(hObject, eventdata, handles)
% hObject    handle to APendNotes (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in ApendNotes.
function ApendNotes_Callback(hObject, eventdata, handles)
% hObject    handle to ApendNotes (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)



% --- Executes on button press in Edit.
function Edit_Callback(hObject, eventdata, handles)
% hObject    handle to Edit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
%ImageSaveImage('Edit',hObject, eventdata, handles);
ImageFunctionPool('Edit',hObject, eventdata, handles);


% --- Executes on key press over figure1 with no controls selected.
function figure1_KeyPressFcn(hObject, eventdata, handles)
% hObject    handle to figure1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
%ImageSetXYVoltage('Arrow',hObject, eventdata, handles);
ImageFunctionPool('Arrow',hObject, eventdata, handles);


% --- Executes on mouse motion over figure - except title and menu.
function figure1_WindowButtonMotionFcn(hObject, eventdata, handles)
% hObject    handle to figure1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
%C = get (gca, 'CurrentPoint');
%disp( ['(X,Y) = (', num2str(C(1,1)), ', ',num2str(C(1,2)), ')']);



% --- Executes on button press in bMinThresh.
function bMinThresh_Callback(hObject, eventdata, handles)
% hObject    handle to bMinThresh (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of bMinThresh


% --- Executes on button press in bMaxThresh.
function bMaxThresh_Callback(hObject, eventdata, handles)
% hObject    handle to bMaxThresh (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of bMaxThresh



function MinThresh_Callback(hObject, eventdata, handles)
% hObject    handle to MinThresh (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of MinThresh as text
%        str2double(get(hObject,'String')) returns contents of MinThresh as a double


% --- Executes during object creation, after setting all properties.
function MinThresh_CreateFcn(hObject, eventdata, handles)
% hObject    handle to MinThresh (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function MaxThresh_Callback(hObject, eventdata, handles)
% hObject    handle to MaxThresh (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of MaxThresh as text
%        str2double(get(hObject,'String')) returns contents of MaxThresh as a double


% --- Executes during object creation, after setting all properties.
function MaxThresh_CreateFcn(hObject, eventdata, handles)
% hObject    handle to MaxThresh (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in RePlot.
function RePlot_Callback(hObject, eventdata, handles)
% hObject    handle to RePlot (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
%ImageSaveImage('RePlot',hObject, eventdata, handles);
ImageFunctionPool('RePlot',hObject, eventdata, handles);



% --- Executes on button press in Fix.
function Fix_Callback(hObject, eventdata, handles)
% hObject    handle to Fix (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
%ImageSetXYVoltage('Fix',hObject, eventdata, handles);
ImageFunctionPool('Fix',hObject, eventdata, handles);



function XOffSet_Callback(hObject, eventdata, handles)
% hObject    handle to XOffSet (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of XOffSet as text
%        str2double(get(hObject,'String')) returns contents of XOffSet as a double


% --- Executes during object creation, after setting all properties.
function XOffSet_CreateFcn(hObject, eventdata, handles)
% hObject    handle to XOffSet (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function YOffSet_Callback(hObject, eventdata, handles)
% hObject    handle to YOffSet (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of YOffSet as text
%        str2double(get(hObject,'String')) returns contents of YOffSet as a double


% --- Executes during object creation, after setting all properties.
function YOffSet_CreateFcn(hObject, eventdata, handles)
% hObject    handle to YOffSet (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in OffSetApply.
function OffSetApply_Callback(hObject, eventdata, handles)
% hObject    handle to OffSetApply (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
ImageFunctionPool('ApplyOffSet',hObject, eventdata, handles);



% --- Executes on button press in Track.
function Track_Callback(hObject, eventdata, handles)
% hObject    handle to Track (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
%ImageFunctionPool('Track',hObject, eventdata, handles);


numTrack = 0;
while numTrack < eval(get(handles.TrackTimes,'String'))
ImageFunctionPool('TrackImageCorr',hObject, eventdata, handles);
% ImageFunctionPool('Track',hObject, eventdata, handles);
numTrack = numTrack + 1;
disp([num2str(numTrack) ' / ' num2str(eval(get(handles.TrackTimes,'String'))) ' trials completed']);
pause(1);
end





% --- Executes on button press in cbTrackCont.
function cbTrackCont_Callback(hObject, eventdata, handles)
% hObject    handle to cbTrackCont (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of cbTrackCont


% --- Executes on button press in cbMarker.
function cbMarker_Callback(hObject, eventdata, handles)
% hObject    handle to cbMarker (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of cbMarker
ImageFunctionPool('ShowMarker',hObject,eventdata,handles);

% --- Executes on button press in LargeScan.
function LargeScan_Callback(hObject, eventdata, handles)
% hObject    handle to LargeScan (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
set(handles.minVx,'String',-0.6);
set(handles.maxVx,'String',+0.6);
set(handles.NVx,'String',150);
set(handles.minVy,'String',-0.6);
set(handles.maxVy,'String',+0.6);
set(handles.NVy,'String',150);
set(handles.bFixVx,'Value',0);
set(handles.bFixVy,'Value',0);
set(handles.bFixVz,'Value',1);
set(handles.bFixDT,'Value',1);
set(handles.FixDT,'String',0.0001);
set(handles.bCursorXY,'Value',1);
set(handles.bFastScan,'Value',1);
set(handles.bSaveImg,'Value',1);
set(handles.bExtPlot,'Value',0);
set(handles.bTrackPlot,'Value',1);



% --- Executes on button press in ZScan.
function ZScan_Callback(hObject, eventdata, handles)
% hObject    handle to ZScan (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
ImageFunctionPool('ZScan',hObject,eventdata,handles);

% --- Executes on button press in NormalScan.
function NormalScan_Callback(hObject, eventdata, handles)
% hObject    handle to NormalScan (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
ImageFunctionPool('NormalScan',hObject,eventdata,handles);


% --- Executes on button press in Xm.
function Xm_Callback(hObject, eventdata, handles)
% hObject    handle to Xm (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global gbManChange 
gbManChange.X = -1; 
gbManChange.Y = 0; 
gbManChange.Z = 0; 
ImageFunctionPool('ManualChange',hObject,eventdata,handles); 

% --- Executes on button press in Xp.
function Xp_Callback(hObject, eventdata, handles)
% hObject    handle to Xp (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global gbManChange 
gbManChange.X = 1; 
gbManChange.Y = 0; 
gbManChange.Z = 0; 
ImageFunctionPool('ManualChange',hObject,eventdata,handles); 

% --- Executes on button press in Ym.
function Ym_Callback(hObject, eventdata, handles)
% hObject    handle to Ym (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global gbManChange 
gbManChange.X = 0; 
gbManChange.Y = -1; 
gbManChange.Z = 0; 
ImageFunctionPool( 'ManualChange',hObject,eventdata,handles); 

% --- Executes on button press in Yp.
function Yp_Callback(hObject, eventdata, handles)
% hObject    handle to Yp (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global gbManChange 
gbManChange.X = 0; 
gbManChange.Y = 1; 
gbManChange.Z = 0; 
ImageFunctionPool('ManualChange',hObject,eventdata,handles); 

% --- Executes on button press in Zm.
function Zm_Callback(hObject, eventdata, handles)
% hObject    handle to Zm (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global gbManChange 
gbManChange.X = 0; 
gbManChange.Y = 0; 
gbManChange.Z = -1; 
ImageFunctionPool('ManualChange',hObject,eventdata,handles); 

% --- Executes on button press in Zp.
function Zp_Callback(hObject, eventdata, handles)
% hObject    handle to Zp (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global gbManChange 
gbManChange.X = 0; 
gbManChange.Y = 0; 
gbManChange.Z = 1; 
ImageFunctionPool('ManualChange',hObject,eventdata,handles); 



% --- Executes on button press in upd_coords.
function upd_coords_Callback(hObject, eventdata, handles)
% hObject    handle to upd_coords (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
ImageFunctionPool('GetCoords',hObject,eventdata,handles); 


% --- Executes on button press in StopTracking.
function StopTracking_Callback(hObject, eventdata, handles)
% hObject    handle to StopTracking (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of StopTracking


% --- Executes on button press in photodiode.
function photodiode_Callback(hObject, eventdata, handles)
% hObject    handle to photodiode (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of photodiode

function edit26_Callback(hObject, eventdata, handles)
% hObject    handle to edit26 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit26 as text
%        str2double(get(hObject,'String')) returns contents of edit26 as a double


% --- Executes during object creation, after setting all properties.
function edit26_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit26 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit27_Callback(hObject, eventdata, handles)
% hObject    handle to edit27 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit27 as text
%        str2double(get(hObject,'String')) returns contents of edit27 as a double


% --- Executes during object creation, after setting all properties.
function edit27_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit27 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit28_Callback(hObject, eventdata, handles)
% hObject    handle to edit28 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit28 as text
%        str2double(get(hObject,'String')) returns contents of edit28 as a double


% --- Executes during object creation, after setting all properties.
function edit28_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit28 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit29_Callback(hObject, eventdata, handles)
% hObject    handle to edit29 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit29 as text
%        str2double(get(hObject,'String')) returns contents of edit29 as a double


% --- Executes during object creation, after setting all properties.
function edit29_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit29 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit30_Callback(hObject, eventdata, handles)
% hObject    handle to edit30 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit30 as text
%        str2double(get(hObject,'String')) returns contents of edit30 as a double


% --- Executes during object creation, after setting all properties.
function edit30_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit30 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit31_Callback(hObject, eventdata, handles)
% hObject    handle to edit31 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit31 as text
%        str2double(get(hObject,'String')) returns contents of edit31 as a double


% --- Executes during object creation, after setting all properties.
function edit31_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit31 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit32_Callback(hObject, eventdata, handles)
% hObject    handle to edit32 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit32 as text
%        str2double(get(hObject,'String')) returns contents of edit32 as a double


% --- Executes during object creation, after setting all properties.
function edit32_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit32 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit33_Callback(hObject, eventdata, handles)
% hObject    handle to edit33 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit33 as text
%        str2double(get(hObject,'String')) returns contents of edit33 as a double


% --- Executes during object creation, after setting all properties.
function edit33_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit33 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit34_Callback(hObject, eventdata, handles)
% hObject    handle to edit34 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit34 as text
%        str2double(get(hObject,'String')) returns contents of edit34 as a double


% --- Executes during object creation, after setting all properties.
function edit34_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit34 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit35_Callback(hObject, eventdata, handles)
% hObject    handle to edit35 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit35 as text
%        str2double(get(hObject,'String')) returns contents of edit35 as a double


% --- Executes during object creation, after setting all properties.
function edit35_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit35 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit36_Callback(hObject, eventdata, handles)
% hObject    handle to edit36 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit36 as text
%        str2double(get(hObject,'String')) returns contents of edit36 as a double


% --- Executes during object creation, after setting all properties.
function edit36_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit36 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit37_Callback(hObject, eventdata, handles)
% hObject    handle to edit37 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit37 as text
%        str2double(get(hObject,'String')) returns contents of edit37 as a double


% --- Executes during object creation, after setting all properties.
function edit37_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit37 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in pushbutton41.
function pushbutton41_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton41 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in Stop.
function Stop_Callback(hObject, eventdata, handles)
% hObject    handle to Stop (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in checkbox25.
function checkbox25_Callback(hObject, eventdata, handles)
% hObject    handle to checkbox25 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of checkbox25



function edit38_Callback(hObject, eventdata, handles)
% hObject    handle to edit38 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit38 as text
%        str2double(get(hObject,'String')) returns contents of edit38 as a double


% --- Executes during object creation, after setting all properties.
function edit38_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit38 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in checkbox26.
function checkbox26_Callback(hObject, eventdata, handles)
% hObject    handle to checkbox26 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of checkbox26



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


% --- Executes on button press in checkbox27.
function checkbox27_Callback(hObject, eventdata, handles)
% hObject    handle to checkbox27 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of checkbox27



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


% --- Executes on button press in checkbox28.
function checkbox28_Callback(hObject, eventdata, handles)
% hObject    handle to checkbox28 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of checkbox28



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


% --- Executes on button press in pushbutton43.
function pushbutton43_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton43 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in checkbox29.
function checkbox29_Callback(hObject, eventdata, handles)
% hObject    handle to checkbox29 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of checkbox29


% --- Executes on button press in checkbox30.
function checkbox30_Callback(hObject, eventdata, handles)
% hObject    handle to checkbox30 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of checkbox30


% --- Executes on button press in checkbox31.
function checkbox31_Callback(hObject, eventdata, handles)
% hObject    handle to checkbox31 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of checkbox31


% --- Executes on button press in checkbox32.
function checkbox32_Callback(hObject, eventdata, handles)
% hObject    handle to checkbox32 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of checkbox32


% --- Executes on button press in pushbutton44.
function pushbutton44_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton44 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)



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


% --- Executes on button press in pushbutton45.
function pushbutton45_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton45 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in pushbutton46.
function pushbutton46_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton46 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in pushbutton47.
function pushbutton47_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton47 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in checkbox33.
function checkbox33_Callback(hObject, eventdata, handles)
% hObject    handle to checkbox33 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of checkbox33


% --- Executes on button press in checkbox34.
function checkbox34_Callback(hObject, eventdata, handles)
% hObject    handle to checkbox34 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of checkbox34


% --- Executes on button press in pushbutton48.
function pushbutton48_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton48 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in pushbutton49.
function pushbutton49_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton49 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in pushbutton50.
function pushbutton50_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton50 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in pushbutton51.
function pushbutton51_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton51 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in pushbutton52.
function pushbutton52_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton52 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in pushbutton53.
function pushbutton53_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton53 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in pushbutton54.
function pushbutton54_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton54 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in pushbutton55.
function pushbutton55_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton55 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in pushbutton56.
function pushbutton56_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton56 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in pushbutton57.
function pushbutton57_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton57 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in pushbutton58.
function pushbutton58_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton58 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in checkbox35.
function checkbox35_Callback(hObject, eventdata, handles)
% hObject    handle to checkbox35 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of checkbox35


% --- Executes on button press in checkbox36.
function checkbox36_Callback(hObject, eventdata, handles)
% hObject    handle to checkbox36 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of checkbox36


% --- Executes on selection change in popupmenu2.
function popupmenu2_Callback(hObject, eventdata, handles)
% hObject    handle to popupmenu2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns popupmenu2 contents as cell array
%        contents{get(hObject,'Value')} returns selected item from popupmenu2


% --- Executes during object creation, after setting all properties.
function popupmenu2_CreateFcn(hObject, eventdata, handles)
% hObject    handle to popupmenu2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in checkbox37.
function checkbox37_Callback(hObject, eventdata, handles)
% hObject    handle to checkbox37 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of checkbox37


% --- Executes on button press in checkbox43.
function checkbox43_Callback(hObject, eventdata, handles)
% hObject    handle to checkbox43 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of checkbox43



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


% --- Executes on button press in pushbutton59.
function pushbutton59_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton59 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)



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


% --- Executes on button press in checkbox38.
function checkbox38_Callback(hObject, eventdata, handles)
% hObject    handle to checkbox38 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of checkbox38


% --- Executes on button press in checkbox39.
function checkbox39_Callback(hObject, eventdata, handles)
% hObject    handle to checkbox39 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of checkbox39



function edit47_Callback(hObject, eventdata, handles)
% hObject    handle to edit47 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit47 as text
%        str2double(get(hObject,'String')) returns contents of edit47 as a double


% --- Executes during object creation, after setting all properties.
function edit47_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit47 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
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


% --- Executes on button press in pushbutton60.
function pushbutton60_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton60 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in pushbutton61.
function pushbutton61_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton61 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in pushbutton62.
function pushbutton62_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton62 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in pushbutton63.
function pushbutton63_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton63 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in pushbutton64.
function pushbutton64_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton64 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)



function edit49_Callback(hObject, eventdata, handles)
% hObject    handle to edit49 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit49 as text
%        str2double(get(hObject,'String')) returns contents of edit49 as a double


% --- Executes during object creation, after setting all properties.
function edit49_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit49 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in pushbutton65.
function pushbutton65_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton65 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in pushbutton66.
function pushbutton66_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton66 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in checkbox40.
function checkbox40_Callback(hObject, eventdata, handles)
% hObject    handle to checkbox40 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of checkbox40


% --- Executes on button press in checkbox41.
function checkbox41_Callback(hObject, eventdata, handles)
% hObject    handle to checkbox41 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of checkbox41


% --- Executes on button press in pushbutton67.
function pushbutton67_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton67 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in checkbox42.
function checkbox42_Callback(hObject, eventdata, handles)
% hObject    handle to checkbox42 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of checkbox42



function edit50_Callback(hObject, eventdata, handles)
% hObject    handle to edit50 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit50 as text
%        str2double(get(hObject,'String')) returns contents of edit50 as a double


% --- Executes during object creation, after setting all properties.
function edit50_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit50 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in pushbutton68.
function pushbutton68_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton68 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in pushbutton69.
function pushbutton69_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton69 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in pushbutton70.
function pushbutton70_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton70 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in pushbutton71.
function pushbutton71_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton71 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes during object creation, after setting all properties.
function axes2_CreateFcn(hObject, eventdata, handles)
% hObject    handle to axes2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: place code in OpeningFcn to populate axes2


% --- Executes on key press with focus on Stop and none of its controls.
function Stop_KeyPressFcn(hObject, eventdata, handles)
% hObject    handle to Stop (see GCBO)
% eventdata  structure with the following fields (see UICONTROL)
%	Key: name of the key that was pressed, in lower case
%	Character: character interpretation of the key(s) that was pressed
%	Modifier: name(s) of the modifier key(s) (i.e., control, shift) pressed
% handles    structure with handles and user data (see GUIDATA)


% --- If Enable == 'on', executes on mouse press in 5 pixel border.
% --- Otherwise, executes on mouse press in 5 pixel border or over edit43.
function edit43_ButtonDownFcn(hObject, eventdata, handles)
% hObject    handle to edit43 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes during object creation, after setting all properties.
function axes1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to axes1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: place code in OpeningFcn to populate axes1


% --- Executes on button press in bFastScan.
function bFastScan_Callback(hObject, eventdata, handles)
% hObject    handle to bFastScan (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of bFastScan


% --- Executes on button press in ShutterON.
function ShutterON_Callback(hObject, eventdata, handles)
% hObject    handle to ShutterON (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
awg = gpib('ni',0,6);
fopen(awg);
fprintf(awg,'SOURce1:FUNCtion DC'); % turn on arb function
%fprintf(awg,'SOURCE1:VOLT 0'); % set max waveform amplitude to 3 Vpp
fprintf(awg,'SOURCE1:VOLT:OFFSET 2'); % set offset to 0 V
fprintf(awg,'OUTPUT1:LOAD 50'); % set output load to 50 ohms
%fprintf(awg,'SOURCE1:FUNCtion:ARB:SRATe 10000000'); % set sample rate
%Enable Output for channel 1
fprintf(awg,'OUTPUT1 ON');
fclose(awg);
delete(awg);
clear awg;

% --- Executes on button press in ShutterOFF.
function ShutterOFF_Callback(hObject, eventdata, handles)
% hObject    handle to ShutterOFF (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
awg = gpib('ni',0,6);
fopen(awg);
fprintf(awg,'OUTPUT1 Off');
fclose(awg);
delete(awg);
clear awg;

function FilterWheelControl(what)
s = serial('COM3'); % filter wheel switch
set(s,'BaudRate',115200)
set(s,'DataBits',8)
set(s,'StopBits',1)
set(s,'Parity','none')
set(s,'FlowControl','none')
set(s,'Terminator','CR')
fopen(s);

fprintf(s,'%s\n','pcount=6')
fprintf(s,'%s\n','speed=1')
% 
% fprintf(s,'pos?');
% pos = fscanf(s);

fprintf(s,'%s\n','pos?');
fscanf(s);
pos = fscanf(s);

switch what
    case 'green_notch'
        fprintf(s,'%s\n','pos=1')
    case 'wide_GFP'
        fprintf(s,'%s\n','pos=4')
    case 'longpass_650'
        fprintf(s,'%s\n','pos=5')
    case 'visible'
        fprintf(s,'%s\n','pos=3')
    otherwise
end

fclose(s);
delete(s);
clear s;


% --- Executes on button press in bTrackPlot.
function bTrackPlot_Callback(hObject, eventdata, handles)
% hObject    handle to bTrackPlot (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of bTrackPlot


% --- Executes on button press in bExtPlot.
function bExtPlot_Callback(hObject, eventdata, handles)
% hObject    handle to bExtPlot (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of bExtPlot


% --- Executes on button press in track_all_nvs.
function track_all_nvs_Callback(hObject, eventdata, handles)
% hObject    handle to track_all_nvs (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
ShutterControl(1);
MultipleNVs('Track_all_NVs',hObject,eventdata,handles);
ShutterControl(0);


function nv_nr_Callback(hObject, eventdata, handles)
% hObject    handle to nv_nr (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of nv_nr as text
%        str2double(get(hObject,'String')) returns contents of nv_nr as a double


% --- Executes during object creation, after setting all properties.
function nv_nr_CreateFcn(hObject, eventdata, handles)
% hObject    handle to nv_nr (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in pushbutton78.
function pushbutton78_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton78 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
MultipleNVs('Clear_NVs',hObject,eventdata,handles);

% --- Executes on button press in save_nv_pos.
function save_nv_pos_Callback(hObject, eventdata, handles)
% hObject    handle to save_nv_pos (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
MultipleNVs('Save_NV_position',hObject,eventdata,handles);

% --- Executes on button press in pushbutton80.
function pushbutton80_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton80 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
MultipleNVs('Goto_NV',hObject,eventdata,handles);



function TrackTimes_Callback(hObject, eventdata, handles)
% hObject    handle to TrackTimes (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of TrackTimes as text
%        str2double(get(hObject,'String')) returns contents of TrackTimes as a double


% --- Executes during object creation, after setting all properties.
function TrackTimes_CreateFcn(hObject, eventdata, handles)
% hObject    handle to TrackTimes (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in pushbutton86.
function pushbutton86_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton86 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)



function bluemA_Callback(hObject, eventdata, handles)
% hObject    handle to bluemA (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of bluemA as text
%        str2double(get(hObject,'String')) returns contents of bluemA as a double


% --- Executes during object creation, after setting all properties.
function bluemA_CreateFcn(hObject, eventdata, handles)
% hObject    handle to bluemA (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function infraredPow_Callback(hObject, eventdata, handles)
% hObject    handle to infraredPow (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of infraredPow as text
%        str2double(get(hObject,'String')) returns contents of infraredPow as a double


% --- Executes during object creation, after setting all properties.
function infraredPow_CreateFcn(hObject, eventdata, handles)
% hObject    handle to infraredPow (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in bGFP.
function bGFP_Callback(hObject, eventdata, handles)
% hObject    handle to bGFP (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of bGFP


% --- Executes on button press in LaserON.
function LaserON_Callback(hObject, eventdata, handles)
% hObject    handle to LaserON (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in LaserOFF.
function LaserOFF_Callback(hObject, eventdata, handles)
% hObject    handle to LaserOFF (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in pushbutton89.
function pushbutton89_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton89 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global sg;
sg = gpib('ni',0,19); % Blue
LDCControl(1,sg,eval(get(handles.bluemA,'String'))*1e-3);

% --- Executes on button press in pushbutton91.
function pushbutton91_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton91 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

X = linspace(100,500,9)'; % LD current
Y = [2.6 4.6 6.6 8.7 10.8 12.8 14.6 16.2 18]'; % measured power
fg = fittype('a*x+b');
Yfit = fit(X,Y,fg,'StartPoint',[1 1],'TolFun',10e-6);

% figure(1000)
% plot(X,Y,'.','markers',20)
% hold on
% plot(X,Yfit(X),'r-','linewidth',1.5)
% set(gca,'fontsize',15)
% xlabel('LD current [mA]')
% ylabel('Power [mW]')
% title('1550 nm power measured before objective lens')

global sg;
sg = gpib('ni',0,18); % Infrared

Pow = eval(get(handles.infraredPow,'String'));
LDcurrent = round((Pow - Yfit.b)/Yfit.a);
if LDcurrent > 500 || LDcurrent < 0
    disp(['error, LD current (your input: ' num2str(LDcurrent) ') should not be larger (smaller) than 500 (0) mA']);
else
    LDCControl(1,sg,LDcurrent*1e-3);
end
    
% --- Executes on button press in bGreenOpen.
function bGreenOpen_Callback(hObject, eventdata, handles)
% hObject    handle to bGreenOpen (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of bGreenOpen


% --- Executes on button press in pushbutton94.
function pushbutton94_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton94 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global sg;
fclose(sg);
delete(sg);
clear sg;

% --- Executes on button press in pushbutton95.
function pushbutton95_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton95 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global sg;
fclose(sg);
delete(sg);
clear sg;



% --- Executes on button press in bScanEvery.
function bScanEvery_Callback(hObject, eventdata, handles)
% hObject    handle to bScanEvery (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of bScanEvery



function ScanMinutes_Callback(hObject, eventdata, handles)
% hObject    handle to ScanMinutes (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of ScanMinutes as text
%        str2double(get(hObject,'String')) returns contents of ScanMinutes as a double


% --- Executes during object creation, after setting all properties.
function ScanMinutes_CreateFcn(hObject, eventdata, handles)
% hObject    handle to ScanMinutes (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function numZstacks_Callback(hObject, eventdata, handles)
% hObject    handle to numZstacks (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of numZstacks as text
%        str2double(get(hObject,'String')) returns contents of numZstacks as a double


% --- Executes during object creation, after setting all properties.
function numZstacks_CreateFcn(hObject, eventdata, handles)
% hObject    handle to numZstacks (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in bScanStop.
function bScanStop_Callback(hObject, eventdata, handles)
% hObject    handle to bScanStop (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of bScanStop


% --- Executes on button press in InfraredPosCorr.
function InfraredPosCorr_Callback(hObject, eventdata, handles)
% hObject    handle to InfraredPosCorr (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% first fix the current NV position and store its information in txt file
ImageFunctionPool('Fix',hObject, eventdata, handles);

% and then, load the information in order to correct the infrared position
temp_filename = 'CurrentNV_Position.txt';
temp_path = 'C:\jmaze\matlab\Experiment\Sets\';
fid = fopen([temp_path temp_filename],'r');
NV_Pos = fscanf(fid,'%f',[3,1]);
fclose(fid);

% load the pre-determined calibration factors
temp_filename = 'Green_Infrared_Calibration.txt';
temp_path = 'C:\jmaze\matlab\Experiment\Sets\';
fid = fopen([temp_path temp_filename],'r');
Transf_factors = fscanf(fid,'%f',[4,1]);
fclose(fid);

Ang = Transf_factors(1);
Scale = Transf_factors(2);
Off_Vx = Transf_factors(3);
Off_Vy = Transf_factors(4);
APDx = NV_Pos(1);
APDy = NV_Pos(2);
APDz = NV_Pos(3);

% input coordinate in APD
Pos_APD = [APDx; APDy];
Ang = Ang/180*pi;
R = [cos(Ang) -sin(Ang); sin(Ang) cos(Ang)]*Scale;
D = [Off_Vx; Off_Vy];

% X = - R*(P-D) --> P = -inv(R)*X + D;
Pos_PD = -inv(R)*Pos_APD + D;

% update the positions for infrared (heating laser)
global gScan2 gConfocal2;
gScan2.FixVx = Pos_PD(1);
gScan2.FixVy = Pos_PD(2);
gScan2.FixVz = APDz;

WriteVoltageTelecom('Dev1/ao2',gScan2.FixVx + gConfocal2.XOffSet);
WriteVoltageTelecom('Dev1/ao3',gScan2.FixVy + gConfocal2.YOffSet);
WriteVoltageTelecom('Obj_Piezo',gScan2.FixVz);
disp(['Galvo 2 Position (X, Y, Z) = (' num2str(gScan2.FixVx +gConfocal2.XOffSet) ', ' num2str(gScan2.FixVy + gConfocal2.YOffSet) ', ' num2str(gScan2.FixVz) ')'])

function task = WriteVoltageTelecom(what,Voltage)
    DAQmx_Val_Volts= 10348; % measure volts

    switch what
        case {1,'Dev1/ao2'}
            Device = 'Dev1/ao2';
        case {2,'Dev1/ao3'}
            Device = 'Dev1/ao3';
        case {3,'Obj_Piezo'}
            % Device = 'Dev1/ao2'; #PI
            % #EO
            global EO_handle;
            if Voltage > 100
                Voltage = 100;
            elseif Voltage < 0
                Voltage = 0;
            end
            calllib('EO-Drive','EO_Move', EO_handle, Voltage); 
            % #EO
            return;
        case 4
            return;
%         case {5,'Dev1/ao2'} 
%             Device = 'Dev1/ao2';
%         case {6,'Dev1/ao3'} 
%             Device = 'Dev1/ao3';
        otherwise
            disp('Error in Write Voltage: I dont get it!');
    end

    [ status, TaskName, task ] = DAQmxCreateTask([]);
    status = status + DAQmxCreateAOVoltageChan(task,Device,-10,10,DAQmx_Val_Volts);
    status = status + DAQmxWriteAnalogScalarF64(task,1,0,Voltage);
    if status ~= 0
        disp(['Error in writing voltage in Device ' Device]);
    end
    DAQmxClearTask(task);

    
% --- Executes on button press in green_notch.
function green_notch_Callback(hObject, eventdata, handles)
% hObject    handle to green_notch (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
FilterWheelControl('green_notch')

% --- Executes on button press in wideGFP.
function wideGFP_Callback(hObject, eventdata, handles)
% hObject    handle to wideGFP (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
FilterWheelControl('wide_GFP')

% --- Executes on button press in longpass_650.
function longpass_650_Callback(hObject, eventdata, handles)
% hObject    handle to longpass_650 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
FilterWheelControl('longpass_650')

% --- Executes on button press in visible.
function visible_Callback(hObject, eventdata, handles)
% hObject    handle to visible (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
FilterWheelControl('visible')



% --- Executes on button press in bSwitch.
function bSwitch_Callback(hObject, eventdata, handles)
% hObject    handle to bSwitch (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of bSwitch


% --- Executes on button press in bFixInfra.
function bFixInfra_Callback(hObject, eventdata, handles)
% hObject    handle to bFixInfra (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of bFixInfra


% --- Executes on button press in SaveImage.
function save_Callback(hObject, eventdata, handles)
% hObject    handle to SaveImage (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
ImageFunctionPool('Save',hObject, eventdata, handles);


% --- Executes on button press in bScreenCap.
function bScreenCap_Callback(hObject, eventdata, handles)
% hObject    handle to bScreenCap (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
ImageFunctionPool('ScreenCap',hObject, eventdata, handles);



function LaserAWGVoltage_Callback(hObject, eventdata, handles)
% hObject    handle to LaserAWGVoltage (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of LaserAWGVoltage as text
%        str2double(get(hObject,'String')) returns contents of LaserAWGVoltage as a double


% --- Executes during object creation, after setting all properties.
function LaserAWGVoltage_CreateFcn(hObject, eventdata, handles)
% hObject    handle to LaserAWGVoltage (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in UpdateVoltage.
function UpdateVoltage_Callback(hObject, eventdata, handles)
% hObject    handle to UpdateVoltage (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

ImageFunctionPool('UpdateVoltage',hObject, eventdata, handles);


% --- Executes on button press in TrackZ.
function TrackZ_Callback(hObject, eventdata, handles)
% hObject    handle to TrackZ (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
ImageFunctionPool('TrackZ',hObject, eventdata, handles);



% --- Executes on button press in pushbutton106.
function pushbutton106_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton106 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
ImageFunctionPool('TrackZContin',hObject, eventdata, handles);


% --- Executes during object deletion, before destroying properties.
function ImageNVCGUI_DeleteFcn(hObject, eventdata, handles)
% hObject    handle to ImageNVCGUI (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
%global gPiezo
%disp("Deleting the piezo controller.")
% gPiezo.Controller.Destroy;
% clear gPiezo.Controller;
% clear gPiezo.PIdevice;
