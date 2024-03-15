function varargout = PulseBlasterGUI_v1_1(varargin)
%written by William Patterson for SpinCore Technologies Inc. 
%Modified by Song Kui for SpinCore Technologies Inc. 
%Currently compatible with SpinAPI 20170111
%PULSE_BLASTER_GUI M-file for pulse_blaster_gui.fig
%      PULSE_BLASTER_GUI, by itself, creates a new PULSE_BLASTER_GUI or raises the existing
%      singleton*.
%
%      H = PULSE_BLASTER_GUI returns the handle to a new PULSE_BLASTER_GUI or the handle to
%      the existing singleton*.
%
%      PULSE_BLASTER_GUI('Property','Value',...) creates a new PULSE_BLASTER_GUI using the
%      given property value pairs. Unrecognized properties are passed via
%      varargin to pulse_blaster_gui_OpeningFcn.  This calling syntax produces a
%      warning when there is an existing singleton*.
%
%      PULSE_BLASTER_GUI('CALLBACK') and PULSE_BLASTER_GUI('CALLBACK',hObject,...) call the
%      local function named CALLBACK in PULSE_BLASTER_GUI.M with the given input
%      arguments.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES
% Correction History:
% Song Corrected the header file path to be match with the SpinAPI version 20170111

% Edit the above text to modify the response to help pulse_blaster_gui

% Last Modified by GUIDE v2.5 03-Feb-2011 09:10:21


if (exist('./Matlab_SpinAPI', 'dir') == 7)
    addpath('./Matlab_SpinAPI/');
else
    error('Cannot find Matlab_SpinAPI');
end

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @pulse_blaster_gui_OpeningFcn, ...
                   'gui_OutputFcn',  @pulse_blaster_gui_OutputFcn, ...
                   'gui_LayoutFcn',  [], ...
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


% --- Executes just before pulse_blaster_gui is made visible.
function pulse_blaster_gui_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   unrecognized PropertyName/PropertyValue pairs from the
%            command line (see VARARGIN)

global SPINAPI_DLL_NAME;
global SPINAPI_DLL_PATH;

% Check if the GUI is closing
set(handles.figure1,'CloseRequestFcn','closeGUI');
guidata(hObject, handles);

% Choose default command line output for pulse_blaster_gui
handles.output = hObject;
if libisloaded(SPINAPI_DLL_NAME) ~= 1
    loadlibrary(strcat(SPINAPI_DLL_PATH, SPINAPI_DLL_NAME, '.dll'), 'C:\SpinCore\SpinAPI\include\spinapi.h', 'addheader','C:\SpinCore\SpinAPI\include\pulseblaster.h');
else
    error('Cannot find C:\SpinCore\SpinAPI\dll\spinapi.h');
end

setappdata(0,'d_struct',struct('inst_num',{'1','2'},'dur',{100,100},'s_mult',{'ns','ns'},'d_mult',{1,1},'sel_mult',{1,1},'flags',{0,hex2dec('F0F0F')},'inst',{'CONTINUE','BRANCH'},'sel_inst',{1,6},'data',{0,1}));
setappdata(0,'num_s',2);
setappdata(0,'num_count',2);
setappdata(0,'prg_order',0);
setappdata(0,'file_name',0);
setappdata(0,'file_path',0);

set(handles.spinapiversion_text,'String',pb_get_version());
num_boards = pb_count_boards();
if(pb_count_boards() < 0);
    errordlg(pb_get_error())
    set(hObject,'String','board err');
    setappdata(0,'prg_order',-1);
elseif(num_boards == 0)
    set(handles.boardsel_edit,'String','none detected');
    setappdata(0,'prg_order',-1);
elseif(num_boards > 0)
    set(handles.boardsel_edit,'String','0');
    setappdata(0,'prg_order',0);
    if(pb_select_board(0) < 0)
       errordlg(pb_get_error())
    end
    if(pb_init() < 0)
       errordlg(pb_get_error())
    end
end
pb_init();
firm_id = pb_get_firmware_id();
dev_id = bitshift(bitand(firm_id,hex2dec('FF00')),-8);
rev_id = bitand(firm_id,hex2dec('00FF'));
set(handles.firmware_text,'String',sprintf('%d - %d', dev_id, rev_id));
pb_close();
% Update handles structure
guidata(hObject, handles);



% UIWAIT makes pulse_blaster_gui wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = pulse_blaster_gui_OutputFcn(hObject, eventdata, handles)
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;



function boardsel_edit_Callback(hObject, eventdata, handles)
% hObject    handle to boardsel_edit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of boardsel_edit as text
%        str2double(get(hObject,'String')) returns contents of boardsel_edit as a double
input = str2num(get(hObject,'String'));
if (isempty(input))
     set(hObject,'String','not a num');
else
     count = pb_count_boards();
    if(count < 0);
         errordlg(pb_get_error())
         set(hObject,'String','board err');
         setappdata(0,'prg_order',-1);
    elseif(count == 0);
         set(hObject,'String','none detected');
         setappdata(0,'prg_order',-1);
    elseif((input + 1) > count);
         set(hObject,'String','out of bounds');
         setappdata(0,'prg_order',-1);
    else
         if(pb_close() < 0)
             errordlg(pb_get_error());
         end
         if(pb_select_board(input) < 0)
             errordlg(pb_get_error())
         end
         setappdata(0,'prg_order',0);
         pb_init();
         firm_id = pb_get_firmware_id();
         dev_id = bitshift(bitand(firm_id,hex2dec('FF00')),-8);
         rev_id = bitand(firm_id,hex2dec('00FF'));
         set(handles.firmware_text,'String',sprintf('%d - %d', dev_id, rev_id));
         pb_close();
    end
end

% --- Executes during object creation, after setting all properties.
function boardsel_edit_CreateFcn(hObject, eventdata, handles)
% hObject    handle to boardsel_edit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


function clockFreq_Callback(hObject, eventdata, handles)
% hObject    handle to clockFreq (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of boardsel_edit as text
%        str2double(get(hObject,'String')) returns contents of boardsel_edit as a double

global CLOCK_FREQ;

input = str2num(get(hObject,'String'));
if (isempty(input))
     set(hObject,'String','not a num');
else
    CLOCK_FREQ = input;
    set(handles.clockFreq,'String',sprintf('%d', CLOCK_FREQ));
end

% --- Executes during object creation, after setting all properties.
function clockFreq_CreateFcn(hObject, eventdata, handles)
% hObject    handle to clockFreq (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

function duration_edit_Callback(hObject, eventdata, handles)
% hObject    handle to duration_edit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of duration_edit as text
%        str2double(get(hObject,'String')) returns contents of duration_edit as a double
input = str2num(get(hObject,'String'));

%checks to see if input is empty. if so, default input1_editText to zero
if (isempty(input))
     set(hObject,'String','100')
else
    s=getappdata(0,'d_struct');
    s(get(handles.instruction_listbox,'Value')).dur = input;
    setappdata(0,'d_struct',s);
end
update_listbox(gcbo,[],guidata(gcbo));
guidata(hObject, handles);



% --- Executes during object creation, after setting all properties.
function duration_edit_CreateFcn(hObject, eventdata, handles)
% hObject    handle to duration_edit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function hexflags_edit_Callback(hObject, eventdata, handles)
% hObject    handle to hexflags_edit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of hexflags_edit as text
%        str2double(get(hObject,'String')) returns contents of hexflags_edit as a double
input = hex2dec(get(hObject,'String'));

%checks to see if input is empty. if so, default input1_editText to zero
s = getappdata(0,'d_struct');
sel_listbox = get(handles.instruction_listbox,'Value');
if (isempty(input))
     set(hObject,'String',dec2hex(s(sel_listobox).flags))
else
    s(sel_listbox).flags = input;
    setappdata(0,'d_struct',s);
end
update_listbox(gcbo,[],guidata(gcbo));
update_buttons(gcbo,[],guidata(gcbo));
guidata(hObject, handles);

% --- Executes during object creation, after setting all properties.
function hexflags_edit_CreateFcn(hObject, eventdata, handles)
% hObject    handle to hexflags_edit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in duration_popupmenu.
function duration_popupmenu_Callback(hObject, eventdata, handles)
% hObject    handle to duration_popupmenu (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = get(hObject,'String') returns duration_popupmenu contents as cell array
%        contents{get(hObject,'Value')} returns selected item from duration_popupmenu
contents = get(hObject,'String');
s=getappdata(0,'d_struct');
sel_listbox = get(handles.instruction_listbox,'Value');
s(sel_listbox).s_mult = contents{get(hObject,'Value')};
switch contents{get(hObject,'Value')}
    case 'ns'
        val = 1;
    case 'us'
        val = 1000;
    case 'ms'
        val = 1000000;
    case 's'
        val = 1000000000;
    case 'min'
        val = 60000000000;
    case 'hr'
        val = 3600000000000;
end
s(sel_listbox).d_mult = val;
s(sel_listbox).sel_mult = get(hObject,'Value');
setappdata(0,'d_struct',s);
update_listbox(gcbo,[],guidata(gcbo));
guidata(hObject, handles);

% --- Executes during object creation, after setting all properties.
function duration_popupmenu_CreateFcn(hObject, eventdata, handles)
% hObject    handle to duration_popupmenu (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in instruction_popupmenu.
function instruction_popupmenu_Callback(hObject, eventdata, handles)
% hObject    handle to instruction_popupmenu (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = get(hObject,'String') returns instruction_popupmenu contents as cell array
%        contents{get(hObject,'Value')} returns selected item from instruction_popupmenu
contents = get(hObject,'String');
val = get(hObject,'Value');
s=getappdata(0,'d_struct');
sel_listbox = get(handles.instruction_listbox,'Value');
s(sel_listbox).inst = contents{val};
s(sel_listbox).sel_inst = val;
setappdata(0,'d_struct',s);
update_listbox(gcbo,[],guidata(gcbo));
guidata(hObject, handles);

% --- Executes during object creation, after setting all properties.
function instruction_popupmenu_CreateFcn(hObject, eventdata, handles)
% hObject    handle to instruction_popupmenu (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function length_edit_Callback(hObject, eventdata, handles)
% hObject    handle to length_edit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of length_edit as text
%        str2double(get(hObject,'String')) returns contents of length_edit as a double
input = str2num(get(hObject,'String'));

%checks to see if input is empty. if so, default input1_editText to zero
if (isempty(input))
     set(hObject,'String','0')
else
    s=getappdata(0,'d_struct');
    s(get(handles.instruction_listbox,'Value')).data = input;
    setappdata(0,'d_struct',s);
end
update_listbox(gcbo,[],guidata(gcbo));
guidata(hObject, handles);

% --- Executes during object creation, after setting all properties.
function length_edit_CreateFcn(hObject, eventdata, handles)
% hObject    handle to length_edit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in flag23_check.
function flag23_check_Callback(hObject, eventdata, handles)
% hObject    handle to flag23_check (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of flag23_check
val_bit = get(hObject,'Value');
s=getappdata(0,'d_struct');
sel_listbox = get(handles.instruction_listbox,'Value');
s(sel_listbox).flags = bitset(s(sel_listbox).flags,24,val_bit);
setappdata(0,'d_struct',s);
update_listbox(gcbo,[],guidata(gcbo));
update_buttons(gcbo,[],guidata(gcbo));
guidata(hObject, handles);

% --- Executes on button press in flag22_check.
function flag22_check_Callback(hObject, eventdata, handles)
% hObject    handle to flag22_check (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of flag22_check
val_bit = get(hObject,'Value');
s=getappdata(0,'d_struct');
sel_listbox = get(handles.instruction_listbox,'Value');
s(sel_listbox).flags = bitset(s(sel_listbox).flags,23,val_bit);
setappdata(0,'d_struct',s);
update_listbox(gcbo,[],guidata(gcbo));
update_buttons(gcbo,[],guidata(gcbo));
guidata(hObject, handles);

% --- Executes on button press in flag21_check.
function flag21_check_Callback(hObject, eventdata, handles)
% hObject    handle to flag21_check (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of flag21_check
val_bit = get(hObject,'Value');
s=getappdata(0,'d_struct');
sel_listbox = get(handles.instruction_listbox,'Value');
s(sel_listbox).flags = bitset(s(sel_listbox).flags,22,val_bit);
setappdata(0,'d_struct',s);
update_listbox(gcbo,[],guidata(gcbo));
update_buttons(gcbo,[],guidata(gcbo));
guidata(hObject, handles);

% --- Executes on button press in flag20_check.
function flag20_check_Callback(hObject, eventdata, handles)
% hObject    handle to flag20_check (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of flag20_check
val_bit = get(hObject,'Value');
s=getappdata(0,'d_struct');
sel_listbox = get(handles.instruction_listbox,'Value');
s(sel_listbox).flags = bitset(s(sel_listbox).flags,21,val_bit);
setappdata(0,'d_struct',s);
update_listbox(gcbo,[],guidata(gcbo));
update_buttons(gcbo,[],guidata(gcbo));
guidata(hObject, handles);

% --- Executes on button press in flag19_check.
function flag19_check_Callback(hObject, eventdata, handles)
% hObject    handle to flag19_check (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of flag19_check
val_bit = get(hObject,'Value');
s=getappdata(0,'d_struct');
sel_listbox = get(handles.instruction_listbox,'Value');
s(sel_listbox).flags = bitset(s(sel_listbox).flags,20,val_bit);
setappdata(0,'d_struct',s);
update_listbox(gcbo,[],guidata(gcbo));
update_buttons(gcbo,[],guidata(gcbo));
guidata(hObject, handles);

% --- Executes on button press in flag18_check.
function flag18_check_Callback(hObject, eventdata, handles)
% hObject    handle to flag18_check (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of flag18_check
val_bit = get(hObject,'Value');
s=getappdata(0,'d_struct');
sel_listbox = get(handles.instruction_listbox,'Value');
s(sel_listbox).flags = bitset(s(sel_listbox).flags,19,val_bit);
setappdata(0,'d_struct',s);
update_listbox(gcbo,[],guidata(gcbo));
update_buttons(gcbo,[],guidata(gcbo));
guidata(hObject, handles);

% --- Executes on button press in flag17_check.
function flag17_check_Callback(hObject, eventdata, handles)
% hObject    handle to flag17_check (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of flag17_check
val_bit = get(hObject,'Value');
s=getappdata(0,'d_struct');
sel_listbox = get(handles.instruction_listbox,'Value');
s(sel_listbox).flags = bitset(s(sel_listbox).flags,18,val_bit);
setappdata(0,'d_struct',s);
update_listbox(gcbo,[],guidata(gcbo));
update_buttons(gcbo,[],guidata(gcbo));
guidata(hObject, handles);

% --- Executes on button press in flag16_check.
function flag16_check_Callback(hObject, eventdata, handles)
% hObject    handle to flag16_check (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of flag16_check
val_bit = get(hObject,'Value');
s=getappdata(0,'d_struct');
sel_listbox = get(handles.instruction_listbox,'Value');
s(sel_listbox).flags = bitset(s(sel_listbox).flags,17,val_bit);
setappdata(0,'d_struct',s);
update_listbox(gcbo,[],guidata(gcbo));
update_buttons(gcbo,[],guidata(gcbo));
guidata(hObject, handles);

% --- Executes on button press in flag15_check.
function flag15_check_Callback(hObject, eventdata, handles)
% hObject    handle to flag15_check (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of flag15_check
val_bit = get(hObject,'Value');
s=getappdata(0,'d_struct');
sel_listbox = get(handles.instruction_listbox,'Value');
s(sel_listbox).flags = bitset(s(sel_listbox).flags,16,val_bit);
setappdata(0,'d_struct',s);
update_listbox(gcbo,[],guidata(gcbo));
update_buttons(gcbo,[],guidata(gcbo));
guidata(hObject, handles);

% --- Executes on button press in flag14_check.
function flag14_check_Callback(hObject, eventdata, handles)
% hObject    handle to flag14_check (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of flag14_check
val_bit = get(hObject,'Value');
s=getappdata(0,'d_struct');
sel_listbox = get(handles.instruction_listbox,'Value');
s(sel_listbox).flags = bitset(s(sel_listbox).flags,15,val_bit);
setappdata(0,'d_struct',s);
update_listbox(gcbo,[],guidata(gcbo));
update_buttons(gcbo,[],guidata(gcbo));
guidata(hObject, handles);

% --- Executes on button press in flag13_check.
function flag13_check_Callback(hObject, eventdata, handles)
% hObject    handle to flag13_check (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of flag13_check
val_bit = get(hObject,'Value');
s=getappdata(0,'d_struct');
sel_listbox = get(handles.instruction_listbox,'Value');
s(sel_listbox).flags = bitset(s(sel_listbox).flags,14,val_bit);
setappdata(0,'d_struct',s);
update_listbox(gcbo,[],guidata(gcbo));
update_buttons(gcbo,[],guidata(gcbo));
guidata(hObject, handles);

% --- Executes on button press in flag12_check.
function flag12_check_Callback(hObject, eventdata, handles)
% hObject    handle to flag12_check (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of flag12_check
val_bit = get(hObject,'Value');
s=getappdata(0,'d_struct');
sel_listbox = get(handles.instruction_listbox,'Value');
s(sel_listbox).flags = bitset(s(sel_listbox).flags,13,val_bit);
setappdata(0,'d_struct',s);
update_listbox(gcbo,[],guidata(gcbo));
update_buttons(gcbo,[],guidata(gcbo));
guidata(hObject, handles);

% --- Executes on button press in flag11_check.
function flag11_check_Callback(hObject, eventdata, handles)
% hObject    handle to flag11_check (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of flag11_check
val_bit = get(hObject,'Value');
s=getappdata(0,'d_struct');
sel_listbox = get(handles.instruction_listbox,'Value');
s(sel_listbox).flags = bitset(s(sel_listbox).flags,12,val_bit);
setappdata(0,'d_struct',s);
update_listbox(gcbo,[],guidata(gcbo));
update_buttons(gcbo,[],guidata(gcbo));
guidata(hObject, handles);

% --- Executes on button press in flag10_check.
function flag10_check_Callback(hObject, eventdata, handles)
% hObject    handle to flag10_check (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of flag10_check
val_bit = get(hObject,'Value');
s=getappdata(0,'d_struct');
sel_listbox = get(handles.instruction_listbox,'Value');
s(sel_listbox).flags = bitset(s(sel_listbox).flags,11,val_bit);
setappdata(0,'d_struct',s);
update_listbox(gcbo,[],guidata(gcbo));
update_buttons(gcbo,[],guidata(gcbo));
guidata(hObject, handles);


% --- Executes on button press in flag9_check.
function flag9_check_Callback(hObject, eventdata, handles)
% hObject    handle to flag9_check (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of flag9_check
val_bit = get(hObject,'Value');
s=getappdata(0,'d_struct');
sel_listbox = get(handles.instruction_listbox,'Value');
s(sel_listbox).flags = bitset(s(sel_listbox).flags,10,val_bit);
setappdata(0,'d_struct',s);
update_listbox(gcbo,[],guidata(gcbo));
update_buttons(gcbo,[],guidata(gcbo));
guidata(hObject, handles);
% --- Executes on button press in flag8_check.
function flag8_check_Callback(hObject, eventdata, handles)
% hObject    handle to flag8_check (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of flag8_check
val_bit = get(hObject,'Value');
s=getappdata(0,'d_struct');
sel_listbox = get(handles.instruction_listbox,'Value');
s(sel_listbox).flags = bitset(s(sel_listbox).flags,9,val_bit);
setappdata(0,'d_struct',s);
update_listbox(gcbo,[],guidata(gcbo));
update_buttons(gcbo,[],guidata(gcbo));
guidata(hObject, handles);

% --- Executes on button press in flag7_check.
function flag7_check_Callback(hObject, eventdata, handles)
% hObject    handle to flag7_check (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of flag7_check
val_bit = get(hObject,'Value');
s=getappdata(0,'d_struct');
sel_listbox = get(handles.instruction_listbox,'Value');
s(sel_listbox).flags = bitset(s(sel_listbox).flags,8,val_bit);
setappdata(0,'d_struct',s);
update_listbox(gcbo,[],guidata(gcbo));
update_buttons(gcbo,[],guidata(gcbo));
guidata(hObject, handles);

% --- Executes on button press in flag6_check.
function flag6_check_Callback(hObject, eventdata, handles)
% hObject    handle to flag6_check (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of flag6_check
val_bit = get(hObject,'Value');
s=getappdata(0,'d_struct');
sel_listbox = get(handles.instruction_listbox,'Value');
s(sel_listbox).flags = bitset(s(sel_listbox).flags,7,val_bit);
setappdata(0,'d_struct',s);
update_listbox(gcbo,[],guidata(gcbo));
update_buttons(gcbo,[],guidata(gcbo));
guidata(hObject, handles);

% --- Executes on button press in flag5_check.
function flag5_check_Callback(hObject, eventdata, handles)
% hObject    handle to flag5_check (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of flag5_check
val_bit = get(hObject,'Value');
s=getappdata(0,'d_struct');
sel_listbox = get(handles.instruction_listbox,'Value');
s(sel_listbox).flags = bitset(s(sel_listbox).flags,6,val_bit);
setappdata(0,'d_struct',s);
update_listbox(gcbo,[],guidata(gcbo));
update_buttons(gcbo,[],guidata(gcbo));
guidata(hObject, handles);

% --- Executes on button press in flag4_check.
function flag4_check_Callback(hObject, eventdata, handles)
% hObject    handle to flag4_check (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of flag4_check
val_bit = get(hObject,'Value');
s=getappdata(0,'d_struct');
sel_listbox = get(handles.instruction_listbox,'Value');
s(sel_listbox).flags = bitset(s(sel_listbox).flags,5,val_bit);
setappdata(0,'d_struct',s);
update_listbox(gcbo,[],guidata(gcbo));
update_buttons(gcbo,[],guidata(gcbo));
guidata(hObject, handles);

% --- Executes on button press in flag3_check.
function flag3_check_Callback(hObject, eventdata, handles)
% hObject    handle to flag3_check (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of flag3_check
val_bit = get(hObject,'Value');
s=getappdata(0,'d_struct');
sel_listbox = get(handles.instruction_listbox,'Value');
s(sel_listbox).flags = bitset(s(sel_listbox).flags,4,val_bit);
setappdata(0,'d_struct',s);
update_listbox(gcbo,[],guidata(gcbo));
update_buttons(gcbo,[],guidata(gcbo));
guidata(hObject, handles);

% --- Executes on button press in flag2_check.
function flag2_check_Callback(hObject, eventdata, handles)
% hObject    handle to flag2_check (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of flag2_check
val_bit = get(hObject,'Value');
s=getappdata(0,'d_struct');
sel_listbox = get(handles.instruction_listbox,'Value');
s(sel_listbox).flags = bitset(s(sel_listbox).flags,3,val_bit);
setappdata(0,'d_struct',s);
update_listbox(gcbo,[],guidata(gcbo));
update_buttons(gcbo,[],guidata(gcbo));
guidata(hObject, handles);

% --- Executes on button press in flag1_check.
function flag1_check_Callback(hObject, eventdata, handles)
% hObject    handle to flag1_check (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of flag1_check
val_bit = get(hObject,'Value');
s=getappdata(0,'d_struct');
sel_listbox = get(handles.instruction_listbox,'Value');
s(sel_listbox).flags = bitset(s(sel_listbox).flags,2,val_bit);
setappdata(0,'d_struct',s);
update_listbox(gcbo,[],guidata(gcbo));
update_buttons(gcbo,[],guidata(gcbo));
guidata(hObject, handles);

% --- Executes on button press in flag0_check.
function flag0_check_Callback(hObject, eventdata, handles)
% hObject    handle to flag0_check (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of flag0_check
val_bit = get(hObject,'Value');
s=getappdata(0,'d_struct');
sel_listbox = get(handles.instruction_listbox,'Value');
s(sel_listbox).flags = bitset(s(sel_listbox).flags,1,val_bit);
setappdata(0,'d_struct',s);
update_listbox(gcbo,[],guidata(gcbo));
update_buttons(gcbo,[],guidata(gcbo));
guidata(hObject, handles);




% --- Executes on button press in start_pushbutton.
function start_pushbutton_Callback(hObject, eventdata, handles)
% hObject    handle to start_pushbutton (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
pb_init();
prg_order = getappdata(0,'prg_order');
if(prg_order == 0)
    errordlg('Must Load Board First');
elseif(prg_order == 1)
    if(pb_start() < 0)
       errordlg(pb_get_error());
    end
    prg_order = 2;
    setappdata(0,'prg_order',prg_order);
elseif(prg_order == 2)
    errordlg('Board is Running');
end
pb_close();
guidata(hObject, handles);

% --- Executes on button press in stop_pushbutton.
function stop_pushbutton_Callback(hObject, eventdata, handles)
% hObject    handle to stop_pushbutton (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
pb_init();
prg_order = getappdata(0,'prg_order');
if(prg_order == 0)
    errordlg('Must Load Board First');
elseif(prg_order ==1)
    errordlg('Board is Stopped');
elseif(prg_order == 2)
    if(pb_stop() < 0)
        errordlg(pb_get_error())
    end
    prg_order = 1;
    setappdata(0,'prg_order',prg_order);
end
pb_close();
guidata(hObject, handles);

% --- Executes on button press in load_pushbutton.
function load_pushbutton_Callback(hObject, eventdata, handles)
% hObject    handle to load_pushbutton (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global CLOCK_FREQ;
prg_order = getappdata(0,'prg_order');
if(prg_order >= 0)
    pb_init();
    pb_core_clock(CLOCK_FREQ);
    pb_start_programming('PULSE_PROGRAM');
    s = getappdata(0,'d_struct');
    num_s = getappdata(0,'num_s');
    %inst = [];
    for i = 1 : num_s
        if(s(i).data == 0)
            pb_inst_pbonly(s(i).flags, s(i).inst, 0, ((s(i).dur) * (s(i).d_mult)));
        elseif (strcmp(s(i).inst, 'LOOP') == 1)
			pb_inst_pbonly(s(i).flags, s(i).inst, s(i).data, ((s(i).dur) * (s(i).d_mult)));			
        else
            pb_inst_pbonly(s(i).flags, s(i).inst, (s(i).data - 1), ((s(i).dur) * (s(i).d_mult)));
        end
    end
    prg_order = 1;
    setappdata(0,'prg_order',prg_order);
    pb_stop_programming();
    pb_close();
end


% --- Executes on button press in addinst_pushbutton.
function addinst_pushbutton_Callback(hObject, eventdata, handles)
% hObject    handle to addinst_pushbutton (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
s = getappdata(0,'d_struct');
sel_listbox = get(handles.instruction_listbox,'Value');
num_count = 1 + getappdata(0,'num_count');
num_s = getappdata(0,'num_s');
new_inst = struct('inst_num',{num_count},'dur',{100},'s_mult',{'ns'},'d_mult',{1},'sel_mult',{1},'flags',{0},'inst',{'CONTINUE'},'sel_inst',{1},'data',{0});
s = [s(1:sel_listbox),new_inst,s((sel_listbox + 1):num_s)];
num_s = num_s + 1;
setappdata(0,'d_struct',s);
setappdata(0,'num_count',num_count);
setappdata(0,'num_s',num_s);
update_listbox(gcbo,[],guidata(gcbo));
set(handles.instruction_listbox,'Value',sel_listbox+1)
update_buttons(gcbo,[],guidata(gcbo));
guidata(hObject, handles);

% --- Executes on button press in rminst_pushbutton.
function rminst_pushbutton_Callback(hObject, eventdata, handles)
% hObject    handle to rminst_pushbutton (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
num_s = getappdata(0,'num_s');
sel_listbox = get(handles.instruction_listbox,'Value');
if(num_s > 1)
    s = getappdata(0,'d_struct');
    s = [s(1:sel_listbox-1),s(sel_listbox+1:num_s)];
    num_s = num_s - 1;
    if(sel_listbox > num_s)
        set(handles.instruction_listbox,'Value',num_s);
    end
    setappdata(0,'d_struct',s);
    setappdata(0,'num_s',num_s);
    update_listbox(gcbo,[],guidata(gcbo));
    update_buttons(gcbo,[],guidata(gcbo));
end
guidata(hObject, handles);


% --- Executes on selection change in instruction_listbox.
function instruction_listbox_Callback(hObject, eventdata, handles)
% hObject    handle to instruction_listbox (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = get(hObject,'String') returns instruction_listbox contents as cell array
%        contents{get(hObject,'Value')} returns selected item from
%        instruction_listbox
%finds which list number is selected outputs number 1 through num_s
update_buttons(gcbo,[],guidata(gcbo));
guidata(hObject, handles);


% --- Executes during object creation, after setting all properties.
function instruction_listbox_CreateFcn(hObject, eventdata, handles)
% hObject    handle to instruction_listbox (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: listbox controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

function update_listbox(hObject, eventdata, handles)
%This function updates the listbox with new data
s = getappdata(0,'d_struct');
num_s = getappdata(0,'num_s');
if(~(isempty(s)))
    for i = 1 : num_s
        s(i).inst_num = i;
        listbox_text(i,:) = sprintf('%6s %11s %5s         %06X %16s %9s', num2str(s(i).inst_num), num2str(s(i).dur), s(i).s_mult, s(i).flags, s(i).inst, num2str(s(i).data));
    end
    set(handles.instruction_listbox,'String',listbox_text);
end
guidata(hObject, handles);

function update_buttons(hObject, eventdata, handles)
%This function updates the listbox with new data
num_s = getappdata(0,'num_s');
sel_listbox = get(handles.instruction_listbox,'Value');
if(num_s ~= 0)
    val = sel_listbox;        %finds which list number is selected outputs number 1 through num_s
    s = getappdata(0,'d_struct');
    set(handles.duration_edit,'String',num2str(s(val).dur));
    set(handles.hexflags_edit,'String',dec2hex(s(val).flags));
    set(handles.duration_popupmenu,'Value',s(val).sel_mult);
    set(handles.instruction_popupmenu,'Value',s(val).sel_inst);
    set(handles.length_edit,'String',num2str(s(val).data));
    set(handles.flag0_check,'Value',bitget(s(val).flags,1));
    set(handles.flag1_check,'Value',bitget(s(val).flags,2));
    set(handles.flag2_check,'Value',bitget(s(val).flags,3));
    set(handles.flag3_check,'Value',bitget(s(val).flags,4));
    set(handles.flag4_check,'Value',bitget(s(val).flags,5));
    set(handles.flag5_check,'Value',bitget(s(val).flags,6));
    set(handles.flag6_check,'Value',bitget(s(val).flags,7));
    set(handles.flag7_check,'Value',bitget(s(val).flags,8));
    set(handles.flag8_check,'Value',bitget(s(val).flags,9));
    set(handles.flag9_check,'Value',bitget(s(val).flags,10));
    set(handles.flag10_check,'Value',bitget(s(val).flags,11));
    set(handles.flag11_check,'Value',bitget(s(val).flags,12));
    set(handles.flag12_check,'Value',bitget(s(val).flags,13));
    set(handles.flag13_check,'Value',bitget(s(val).flags,14));
    set(handles.flag14_check,'Value',bitget(s(val).flags,15));
    set(handles.flag15_check,'Value',bitget(s(val).flags,16));
    set(handles.flag16_check,'Value',bitget(s(val).flags,17));
    set(handles.flag17_check,'Value',bitget(s(val).flags,18));
    set(handles.flag18_check,'Value',bitget(s(val).flags,19));
    set(handles.flag19_check,'Value',bitget(s(val).flags,20));
    set(handles.flag20_check,'Value',bitget(s(val).flags,21));
    set(handles.flag21_check,'Value',bitget(s(val).flags,22));
    set(handles.flag22_check,'Value',bitget(s(val).flags,23));
    set(handles.flag23_check,'Value',bitget(s(val).flags,24));
end
guidata(hObject, handles);

% --------------------------------------------------------------------
function New_Callback(hObject, eventdata, handles)
% hObject    handle to New (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% Construct a questdlg with three options
choice = questdlg('Would you like to save your file before opening a new document?', ...
	'Save File', ...
	'Yes','No','Cancel','Yes');
% Handle response
switch choice
    case 'Yes'
        Save_Callback(gcbo,[],guidata(gcbo));
        setappdata(0,'d_struct',struct('inst_num',{'1'},'dur',{100},'s_mult',{'ns'},'d_mult',{1},'sel_mult',{1},'flags',{0},'inst',{'CONTINUE'},'sel_inst',{1},'data',{0}));
        setappdata(0,'num_s',1);
        set(handles.instruction_listbox,'Value',1);
        setappdata(0,'num_count',1);
        setappdata(0,'prg_order',0);
        setappdata(0,'file_name',0);
        setappdata(0,'file_path',0);
        update_buttons(gcbo,[],guidata(gcbo));
        update_listbox(gcbo,[],guidata(gcbo));
    case 'No'
        setappdata(0,'d_struct',struct('inst_num',{'1'},'dur',{100},'s_mult',{'ns'},'d_mult',{1},'sel_mult',{1},'flags',{0},'inst',{'CONTINUE'},'sel_inst',{1},'data',{0}));
        setappdata(0,'num_s',1);
        set(handles.instruction_listbox,'Value',1);
        setappdata(0,'num_count',1);
        setappdata(0,'prg_order',0);
        setappdata(0,'file_name',0);
        setappdata(0,'file_path',0);
        update_buttons(gcbo,[],guidata(gcbo));
        update_listbox(gcbo,[],guidata(gcbo));
    case 'Cancel'
        
end


% --------------------------------------------------------------------
function Open_Callback(hObject, eventdata, handles)
% hObject    handle to Open (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
choice = questdlg('Would you like to save your file before opening another file?', ...
	'Save File', ...
	'Yes','No','Cancel','Yes');
% Handle response
switch choice
    case 'Yes'
        Save_Callback(gcbo,[],guidata(gcbo));
        [file_name,file_path] = uigetfile('*.mat','Select the MATLAB code file');
        load([file_path,file_name],'s','num_s');
        setappdata(0,'d_struct',s);
        setappdata(0,'num_s',num_s);
        set(handles.instruction_listbox,'Value',1);
        setappdata(0,'num_count',1);
        setappdata(0,'prg_order',0);
        setappdata(0,'file_name',file_name);
        setappdata(0,'file_path',file_path);
        update_buttons(gcbo,[],guidata(gcbo));
        update_listbox(gcbo,[],guidata(gcbo));
        guidata(hObject, handles);
    case 'No'
        [file_name,file_path] = uigetfile('*.mat','Select the MATLAB code file');
        load([file_path,file_name],'s','num_s');
        setappdata(0,'d_struct',s);
        setappdata(0,'num_s',num_s);
        set(handles.instruction_listbox,'Value',1);
        setappdata(0,'num_count',1);
        setappdata(0,'prg_order',0);
        setappdata(0,'file_name',file_name);
        setappdata(0,'file_path',file_path);
        update_buttons(gcbo,[],guidata(gcbo));
        update_listbox(gcbo,[],guidata(gcbo));
        guidata(hObject, handles);
    case 'Cancel'
        
end

% --------------------------------------------------------------------
function Save_Callback(hObject, eventdata, handles)
% hObject    handle to Untitled_5 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
file_name = getappdata(0,'file_name');
file_path = getappdata(0,'path_name');
if isequal(file_name,0) || isequal(file_path,0)
    Save_As_Callback(gcbo,[],guidata(gcbo));
else
    s = getappdata(0,'d_struct');
    num_s = getappdata(0,'num_s');
    save([file_path,file_name],'s','num_s','-append');
    setappdata(0,'file_name',file_name);
    setappdata(0,'file_path',file_path);
end

% --------------------------------------------------------------------
function Save_As_Callback(hObject, eventdata, handles)
% hObject    handle to Untitled_7 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

[file_name,file_path] = uiputfile({'*.mat';'*.*'},'Save File','pb1');
if isequal(file_name,0) || isequal(file_path,0)
   disp('User selected Cancel')
else
    s = getappdata(0,'d_struct');
    num_s = getappdata(0,'num_s');
    save([file_path,file_name],'s','num_s','-mat');
    setappdata(0,'file_name',file_name);
    setappdata(0,'path_name',file_path);
end

% --------------------------------------------------------------------
function Exit_Callback(hObject, eventdata, handles)
% hObject    handle to Exit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

global SPINAPI_DLL_NAME;

choice = questdlg('Would you like to save your file before opening another file?', ...
	'Save File', ...
	'Yes','No','Cancel','Yes');
% Handle response
switch choice
    case 'Yes'
        Save_Callback(gcbo,[],guidata(gcbo));
        unloadlibrary SPINAPI_DLL_NAME
        delete(gcf)
    case 'No'
        unloadlibrary SPINAPI_DLL_NAME
        delete(gcf)
    case 'Cancel'       
end


% --------------------------------------------------------------------
function Manual_Callback(hObject, eventdata, handles)
% hObject    handle to Manual (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
stat = web('http://www.spincore.com/support/Support_Main.shtml', '-browser');
if(stat == 1)
    errordlg('Browser was not found.\n Go to http://www.spincore.com/support/Support_Main.shtml');
elseif(stat ==2)
    errordlg('Browser was found but could not be launched.\n Go to http://www.spincore.com/support/Support_Main.shtml');
end

% --------------------------------------------------------------------
function About_Callback(hObject, eventdata, handles)
% hObject    handle to About (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
helpdlg(sprintf('PulseBlaster Matlab GUI v1.1\nCopyright SpinCore Technologies, Inc. 2011\nBy William Paterson'));

% --------------------------------------------------------------------
function File_Callback(hObject, eventdata, handles)
% hObject    handle to File (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --------------------------------------------------------------------
function Help_Callback(hObject, eventdata, handles)
% hObject    handle to Help (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

