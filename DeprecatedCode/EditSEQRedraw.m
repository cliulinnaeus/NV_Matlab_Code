function EditSEQRedraw(what,hObject, eventdata, handles)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%% Written by Jeronimo Maze, July 2007 %%%%%%%%%%%%%%%%%%
%%%%%%%%%% Harvard University, Cambridge, USA  %%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

global gEditSEQ bShowTypes bShowTimes;


switch what
    case 'ShowTypes'
        bShowTypes = get(handles.ShowTypes,'Value');
    case 'ShowTimes'
        bShowTimes = get(handles.ShowTimes,'Value');
    otherwise
end
        
DrawSequence(gEditSEQ, hObject, eventdata, handles);