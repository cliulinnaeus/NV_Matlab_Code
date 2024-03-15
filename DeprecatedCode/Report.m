function varargout = Report(varargin)
% REPORT M-fileMenu for Report.figure
%      REPORT, by itself, creates a new REPORT or raises the existing
%      singleton*.
%
%      H = REPORT returns the handle to a new REPORT or the handle to
%      the existing singleton*.
%
%      REPORT('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in REPORT.M with the given input arguments.
%
%      REPORT('Property','Value',...) creates a new REPORT or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before Report_OpeningFunction gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to Report_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help Report

% Last Modified by GUIDE v2.5 12-Sep-2008 17:21:11

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @Report_OpeningFcn, ...
                   'gui_OutputFcn',  @Report_OutputFcn, ...
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


% --- Executes just before Report is made visible.
function Report_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to Report (see VARARGIN)

% Choose default command line output for Report
handles.output = hObject;

% add path for XML writing
addpath('xml_toolbox');

% check to see if the box should be modal
if length(varargin) > 0,
    if varargin{1},
%         set(hObject,'WindowStyle','modal');
    
        % if Report GUI called from Experiment GUI, setup the
        % handles.Experiment variable
        handles.Experiment = ReportFunctionPool('MakeExperimentStructure',...
            hObject, eventdata, handles);

        % update the Pulse Sequence Plot
        ReportFunctionPool('DrawSequence',hObject,eventdata,handles);

        % update the Data plot
        ReportFunctionPool('DefaultPlotData',hObject,eventdata,handles);
        
        % update ListBox UI
        ReportFunctionPool('UpdateDataBoxes',hObject,eventdata,handles);
    end
end


% Update handles structure
guidata(hObject, handles);


    
% UIWAIT makes Report wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = Report_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on button press in LoadReport.
function LoadReport_Callback(hObject, eventdata, handles)
% hObject    handle to LoadReport (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
ReportFunctionPool('LoadReport',hObject,eventdata,handles);

% --- Executes during object creation, after setting all properties.
function strReport_CreateFcn(hObject, eventdata, handles)
% hObject    handle to strReport (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called


% --- Executes on button press in NextReport.
function NextReport_Callback(hObject, eventdata, handles)
% hObject    handle to NextReport (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
ReportFunctionPool('LoadNext',hObject,eventdata,handles);


% --- Executes on button press in PreviousReport.
function PreviousReport_Callback(hObject, eventdata, handles)
% hObject    handle to PreviousReport (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
ReportFunctionPool('LoadPrevious',hObject,eventdata,handles);


% --- Executes on button press in Print.
function Print_Callback(hObject, eventdata, handles)
% hObject    handle to Print (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in Save.
function Save_Callback(hObject, eventdata, handles)
% hObject    handle to Save (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
ReportFunctionPool('Save',hObject, eventdata, handles);



% --- Executes on button press in MakeReport.
function MakeReport_Callback(hObject, eventdata, handles)
% hObject    handle to MakeReport (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
ReportFunctionPool('MakeReport',hObject, eventdata, handles);


% --- Executes on button press in SaveReportAs.
function SaveReportAs_Callback(hObject, eventdata, handles)
% hObject    handle to SaveReportAs (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)




% --------------------------------------------------------------------
function loadMenu_Callback(hObject, eventdata, handles)
% hObject    handle to loadMenu (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --------------------------------------------------------------------
function fileMenu_Callback(hObject, eventdata, handles)
% hObject    handle to fileMenu (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --------------------------------------------------------------------
function Untitled_3_Callback(hObject, eventdata, handles)
% hObject    handle to Untitled_3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --------------------------------------------------------------------
function saveMenu_Callback(hObject, eventdata, handles)
% hObject    handle to saveMenu (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --------------------------------------------------------------------
function saveAsMenu_Callback(hObject, eventdata, handles)
% hObject    handle to saveAsMenu (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --------------------------------------------------------------------
function printMenu_Callback(hObject, eventdata, handles)
% hObject    handle to printMenu (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)




% --- Executes on button press in showTypesCB.
function showTypesCB_Callback(hObject, eventdata, handles)
% hObject    handle to showTypesCB (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of showTypesCB
ReportFunctionPool('DrawSequence',hObject,eventdata,handles);

% --- Executes on button press in showTimesCB.
function showTimesCB_Callback(hObject, eventdata, handles)
% hObject    handle to showTimesCB (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of showTimesCB
ReportFunctionPool('DrawSequence',hObject,eventdata,handles);



% --- Executes on selection change in listbox1.
function listbox1_Callback(hObject, eventdata, handles)
% hObject    handle to listbox1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = get(hObject,'String') returns listbox1 contents as cell array
%        contents{get(hObject,'Value')} returns selected item from listbox1


% --- Executes during object creation, after setting all properties.
function listbox1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to listbox1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: listbox controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in abscissaList.
function abscissaList_Callback(hObject, eventdata, handles)
% hObject    handle to abscissaList (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = get(hObject,'String') returns abscissaList contents as cell array
%        contents{get(hObject,'Value')} returns selected item from abscissaList


% --- Executes during object creation, after setting all properties.
function abscissaList_CreateFcn(hObject, eventdata, handles)
% hObject    handle to abscissaList (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: listbox controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in plotButton.
function plotButton_Callback(hObject, eventdata, handles)
% hObject    handle to plotButton (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
ReportFunctionPool('PlotData',hObject,eventdata,handles);

% --- Executes on selection change in variableList.
function variableList_Callback(hObject, eventdata, handles)
% hObject    handle to variableList (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = get(hObject,'String') returns variableList contents as cell array
%        contents{get(hObject,'Value')} returns selected item from variableList


% --- Executes during object creation, after setting all properties.
function variableList_CreateFcn(hObject, eventdata, handles)
% hObject    handle to variableList (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: listbox controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end




% --- Executes on button press in clearPlotButton.
function clearPlotButton_Callback(hObject, eventdata, handles)
% hObject    handle to clearPlotButton (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
ReportFunctionPool('ClearPlot',hObject,eventdata,handles);

% --- Executes on button press in holdOnCB.
function holdOnCB_Callback(hObject, eventdata, handles)
% hObject    handle to holdOnCB (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of holdOnCB




% --- Executes on button press in noteButton.
function noteButton_Callback(hObject, eventdata, handles)
% hObject    handle to noteButton (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
ReportFunctionPool('AddNoteDlg',hObject,eventdata,handles);




function Abscissa_Callback(hObject, eventdata, handles)
% hObject    handle to Abscissa (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of Abscissa as text
%        str2double(get(hObject,'String')) returns contents of Abscissa as a double


% --- Executes during object creation, after setting all properties.
function Abscissa_CreateFcn(hObject, eventdata, handles)
% hObject    handle to Abscissa (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function Ordinate_Callback(hObject, eventdata, handles)
% hObject    handle to Ordinate (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of Ordinate as text
%        str2double(get(hObject,'String')) returns contents of Ordinate as a double


% --- Executes during object creation, after setting all properties.
function Ordinate_CreateFcn(hObject, eventdata, handles)
% hObject    handle to Ordinate (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in toAbscissa.
function toAbscissa_Callback(hObject, eventdata, handles)
% hObject    handle to toAbscissa (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
ReportFunctionPool('SetAbscissa',hObject,eventdata,handles);


% --- Executes on button press in toOrdinate.
function toOrdinate_Callback(hObject, eventdata, handles)
% hObject    handle to toOrdinate (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
ReportFunctionPool('SetOrdinate',hObject,eventdata,handles);




% --- Executes on button press in bPlotElsewhere.
function bPlotElsewhere_Callback(hObject, eventdata, handles)
% hObject    handle to bPlotElsewhere (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of bPlotElsewhere



function Figure_Callback(hObject, eventdata, handles)
% hObject    handle to Figure (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of Figure as text
%        str2double(get(hObject,'String')) returns contents of Figure as a double


% --- Executes during object creation, after setting all properties.
function Figure_CreateFcn(hObject, eventdata, handles)
% hObject    handle to Figure (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function Subplot_Callback(hObject, eventdata, handles)
% hObject    handle to Subplot (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of Subplot as text
%        str2double(get(hObject,'String')) returns contents of Subplot as a double


% --- Executes during object creation, after setting all properties.
function Subplot_CreateFcn(hObject, eventdata, handles)
% hObject    handle to Subplot (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end





function XLabel_Callback(hObject, eventdata, handles)
% hObject    handle to XLabel (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of XLabel as text
%        str2double(get(hObject,'String')) returns contents of XLabel as a double


% --- Executes during object creation, after setting all properties.
function XLabel_CreateFcn(hObject, eventdata, handles)
% hObject    handle to XLabel (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function YLabel_Callback(hObject, eventdata, handles)
% hObject    handle to YLabel (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of YLabel as text
%        str2double(get(hObject,'String')) returns contents of YLabel as a double


% --- Executes during object creation, after setting all properties.
function YLabel_CreateFcn(hObject, eventdata, handles)
% hObject    handle to YLabel (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function Title_Callback(hObject, eventdata, handles)
% hObject    handle to Title (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of Title as text
%        str2double(get(hObject,'String')) returns contents of Title as a double


% --- Executes during object creation, after setting all properties.
function Title_CreateFcn(hObject, eventdata, handles)
% hObject    handle to Title (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function Format_Callback(hObject, eventdata, handles)
% hObject    handle to Format (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of Format as text
%        str2double(get(hObject,'String')) returns contents of Format as a double


% --- Executes during object creation, after setting all properties.
function Format_CreateFcn(hObject, eventdata, handles)
% hObject    handle to Format (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in SentToGlobal.
function SentToGlobal_Callback(hObject, eventdata, handles)
% hObject    handle to SentToGlobal (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
ReportFunctionPool('SentToGlobal',hObject,eventdata,handles);




% --------------------------------------------------------------------
function sensitivity_Callback(hObject, eventdata, handles)
% hObject    handle to sensitivity (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
ReportFunctionPool('Sensitivity',hObject, eventdata, handles);

% --------------------------------------------------------------------
function analysis_Callback(hObject, eventdata, handles)
% hObject    handle to analysis (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes during object creation, after setting all properties.
function figure1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to figure1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called





function Parameters_Callback(hObject, eventdata, handles)
% hObject    handle to Parameters (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of Parameters as text
%        str2double(get(hObject,'String')) returns contents of Parameters as a double


% --- Executes during object creation, after setting all properties.
function Parameters_CreateFcn(hObject, eventdata, handles)
% hObject    handle to Parameters (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --------------------------------------------------------------------
function menuPrintPlot_Callback(hObject, eventdata, handles)
% hObject    handle to menuPrintPlot (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
ReportFunctionPool('PrintPlot',hObject,eventdata,handles);

