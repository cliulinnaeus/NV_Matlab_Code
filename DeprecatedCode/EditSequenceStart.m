function EditSequenceStart(hObject, eventdata, handles, varargin)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%% Written by Jeronimo Maze, July 2007 %%%%%%%%%%%%%%%%%%
%%%%%%%%%% Harvard University, Cambridge, USA  %%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

global gSEQ gEditSEQ ztmin ztmax;

ztmin = [];
ztmax = [];

SEQ = gSEQ;
gEditSEQ = gSEQ;
DrawSequence(SEQ,hObject, eventdata, handles)

FillUpPopUps(hObject, eventdata, handles, varargin);

RefreshEditSeqForm('All',hObject, eventdata, handles, varargin);