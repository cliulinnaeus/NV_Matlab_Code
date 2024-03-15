function OpenSequence(hObject, eventdata, handles)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%% Written by Jeronimo Maze, July 2007 %%%%%%%%%%%%%%%%%%
%%%%%%%%%% Harvard University, Cambridge, USA  %%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

global gSEQ hAxes1;

file = 'C:\MATLAB_Code\Sets\Sequences\';
[file, path, filterindex] = uigetfile('Sequence*.*', 'Open Sequence',file);

SEQ = GetPulseSequence([path file]);

gSEQ = SEQ;

DrawSequence(SEQ, hObject, eventdata, handles);

set(handles.Sequence,'String',file);

hAxes1 = handles.axes1;