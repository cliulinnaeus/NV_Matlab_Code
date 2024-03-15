function FillUpPopUps(hObject, eventdata, handles, varargin)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%% Written by Jeronimo Maze, July 2007 %%%%%%%%%%%%%%%%%%
%%%%%%%%%% Harvard University, Cambridge, USA  %%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

StrL{1} = 'N';
for i=2:22
    StrL{i} = num2str(i-2)  ;
end

set(handles.PBN1,'String',StrL);

set(handles.Rise1,'String','RN');

set(handles.Channel,'String','Channel');

