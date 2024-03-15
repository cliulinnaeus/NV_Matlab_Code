function EditOpenSequence(hObject, eventdata, handles)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%% Written by Jeronimo Maze, July 2007 %%%%%%%%%%%%%%%%%%
%%%%%%%%%% Harvard University, Cambridge, USA  %%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

global gSEQ;

file = 'Sequences/';
[file, path, filterindex] = uigetfile('Sequence*', 'Open Sequence',file);

SEQ = GetPulseSequence([path file]);

gSEQ = SEQ;

DrawSequence(SEQ,handles.axes2)