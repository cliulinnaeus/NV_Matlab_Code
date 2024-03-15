function EditgEditSEQ(what,hObject, eventdata, handles)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%% Written by Jeronimo Maze, July 2007 %%%%%%%%%%%%%%%%%%
%%%%%%%%%% Harvard University, Cambridge, USA  %%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

global gEditSEQ gTimeStep gPhaseStep;

%gTimeStep = 10/3*1e-9;
% changed gTimeStep for newest PBESR-PRO-400 card
gTimeStep = 10/4*1e-9;
gPhaseStep = 360/(2^6); % 5.6 degrees for six bit phase shifter
SEQ = gEditSEQ;

chn = GetChannel(handles);
switch what
    case 'DelChannel'
        SEQ = DelPBN(SEQ,chn);
        gEditSEQ = SEQ;
        set(handles.Channel,'Value',2);
        RefreshEditSeqForm('CleanFormA',hObject, eventdata, handles);
        RefreshEditSeqForm('All',hObject, eventdata, handles);
    case 'AddChannel',
        [SEQ, chn] = AddPBN(SEQ);
        gEditSEQ = SEQ;
        RefreshEditSeqForm('CleanFormA',hObject, eventdata, handles);
        RefreshEditSeqForm('All',hObject, eventdata, handles);
        set(handles.Channel,'Value',chn+1);
        RefreshEditSeqForm('PBN',hObject, eventdata, handles);
    case 'DeletePBN'
        SEQ = DeletePBN(chn,SEQ);
        gEditSEQ = SEQ;
        RefreshEditSeqForm('CleanFormA',hObject, eventdata, handles)
        RefreshEditSeqForm('All',hObject, eventdata, handles)
    case 'PBN'
        SEQ = ChangePBN(chn,SEQ,hObject, eventdata, handles);
        gEditSEQ = SEQ;
        RefreshEditSeqForm('PBN',hObject, eventdata, handles)
    case 'TimeON'
        SEQ = ChangeTimeON(chn,SEQ,hObject, eventdata, handles); 
        gEditSEQ = SEQ;
        RefreshEditSeqForm('Rise',hObject, eventdata, handles)
    case 'DT'
        SEQ = ChangeDT(chn,SEQ,hObject, eventdata, handles); 
        gEditSEQ = SEQ;
        RefreshEditSeqForm('Rise',hObject, eventdata, handles)
    case 'Phase'
        SEQ = ChangePhase(chn,SEQ,hObject,eventdata,handles)
        gEditSEQ = SEQ;
        RefreshEditSeqForm('Rise',hObject, eventdata, handles)
    case 'Type'
        SEQ = ChangeType(chn,SEQ,hObject, eventdata, handles); 
        gEditSEQ = SEQ;
        RefreshEditSeqForm('Rise',hObject, eventdata, handles);
    case 'AddRise'
        SEQ.CHN(chn)
        SEQ = AddRise(chn,SEQ,hObject, eventdata, handles); 
        SEQ.CHN(chn)
        gEditSEQ = SEQ;
        RefreshEditSeqForm('Rise',hObject, eventdata, handles);
    case 'DelRise'
        SEQ = DelRise(chn,SEQ,hObject, eventdata, handles); 
        gEditSEQ = SEQ;
        RefreshEditSeqForm('Rise',hObject, eventdata, handles);
    case 'DelayON'
        SEQ = DelayON(chn,SEQ,hObject, eventdata, handles); 
        gEditSEQ = SEQ;
        RefreshEditSeqForm('PBN',hObject, eventdata, handles);
    case 'DelayOFF'
        SEQ = DelayOFF(chn,SEQ,hObject, eventdata, handles); 
        gEditSEQ = SEQ;
        RefreshEditSeqForm('PBN',hObject, eventdata, handles);
    otherwise
end

DrawSequence(SEQ,hObject, eventdata, handles);

function SEQ = DelayOFF(chn,SEQ,hObject, eventdata, handles)
global gTimeStep;
Value = eval(get(handles.DelayOFF1,'String'));
Value = round(Value/gTimeStep)*gTimeStep;
set(handles.DelayOFF1,'String',Value);
SEQ.CHN(chn).Delays(2) = Value;


function SEQ = DelayON(chn,SEQ,hObject, eventdata, handles)
global gTimeStep;
Value = eval(get(handles.DelayON1,'String'));
Value = round(Value/gTimeStep)*gTimeStep;
set(handles.DelayON1,'String',Value);
SEQ.CHN(chn).Delays(1) = Value;

function SEQ = DelRise(chn,SEQ,hObject, eventdata, handles)
global tmin tmax;
Rise = GetRise(handles);
SEQ.CHN(chn).T(Rise) = [];
SEQ.CHN(chn).DT(Rise) = [];
SEQ.CHN(chn).Type(Rise) = [];
SEQ.CHN(chn).Phase(Rise) = [];
SEQ.CHN(chn).NRise = SEQ.CHN(chn).NRise - 1;

NRise = SEQ.CHN(chn).NRise;
StrList = cellstr(num2str([0:SEQ.CHN(chn).NRise]'));
StrList{1} ='RN';
set(handles.Rise1,'String',StrList);
if Rise > NRise, Rise = NRise; end
set(handles.Rise1,'Value',Rise+1);


function SEQ = AddRise(chn,SEQ,hObject, eventdata, handles)
global tmin tmax;
Rise = SEQ.CHN(chn).NRise+1;
SEQ.CHN(chn).T(Rise) = tmax;
SEQ.CHN(chn).DT(Rise) = SEQ.CHN(chn).DT(Rise-1);
SEQ.CHN(chn).Type(Rise) = SEQ.CHN(chn).Type(Rise-1);
SEQ.CHN(chn).Phase(Rise) = SEQ.CHN(chn).Phase(Rise-1);
SEQ.CHN(chn).NRise = SEQ.CHN(chn).NRise + 1;

NRise = SEQ.CHN(chn).NRise;
StrList = cellstr(num2str([0:SEQ.CHN(chn).NRise]'));
StrList{1} ='RN';
set(handles.Rise1,'String',StrList);
set(handles.Rise1,'Value',Rise+1);


function SEQ = ChangeType(which,SEQ,hObject, eventdata, handles)
Value = get(handles.Type1,'String')
Rise = GetRise(handles);
PBN = GetPBN(handles);
chn = GetCHN(SEQ,PBN);
SEQ.CHN(chn).Type(Rise) = Value;

function SEQ = ChangeDT(which,SEQ,hObject, eventdata, handles)
global gTimeStep;
Rise = GetRise(handles);
PBN = GetPBN(handles);
chn = GetCHN(SEQ,PBN);
Value = eval(get(handles.DT1,'String'));
Value = round(Value/gTimeStep)*gTimeStep;
set(handles.DT1,'String',Value);

if get(handles.Shift,'Value')
    FromTime = SEQ.CHN(chn).T(Rise) + SEQ.CHN(chn).DT(Rise);
    Shift = Value - SEQ.CHN(chn).DT(Rise);
    T = SEQ.CHN(chn).T;
    T(find(T>=FromTime))=T(find(T>=FromTime)) + Shift;
    SEQ.CHN(chn).T = T;
    SEQ.CHN(chn).DT(Rise) = Value;
elseif get(handles.ShiftAll,'Value')
    FromTime = SEQ.CHN(chn).T(Rise) + SEQ.CHN(chn).DT(Rise);
    Shift = Value - SEQ.CHN(chn).DT(Rise);
    SEQ = ShiftEvents(SEQ,Shift,FromTime);
    SEQ.CHN(chn).DT(Rise) = Value;
else
    SEQ.CHN(chn).DT(Rise) = Value;
end


function SEQ = ChangeTimeON(which,SEQ,hObject, eventdata, handles)
global gTimeStep;
Rise = GetRise(handles);
PBN = GetPBN(handles);
chn = GetCHN(SEQ,PBN);
Value = eval(get(handles.TimeON1,'String'));
Value = round(Value/gTimeStep)*gTimeStep;
set(handles.TimeON1,'String',Value);

if get(handles.Shift,'Value')
    FromTime = SEQ.CHN(chn).T(Rise);
    Shift = Value - FromTime;
    T = SEQ.CHN(chn).T;
    T(find(T>=FromTime))=T(find(T>=FromTime)) + Shift;
    SEQ.CHN(chn).T = T;
    SEQ.CHN(chn).T(Rise) = Value;
elseif get(handles.ShiftAll,'Value')
    FromTime = SEQ.CHN(chn).T(Rise);
    Shift = Value - FromTime;
    SEQ = ShiftEvents(SEQ,Shift,FromTime);
    SEQ.CHN(chn).T(Rise) = Value;
else
    SEQ.CHN(chn).T(Rise) = Value;
end

function SEQ = ChangePhase(which,SEQ,hObject, eventdata, handles)
global gPhaseStep
Rise = GetRise(handles);
PBN = GetPBN(handles);
chn = GetCHN(SEQ,PBN);
Value = eval(get(handles.risePhase,'String'));
Value = round(Value/gPhaseStep)*gPhaseStep;
set(handles.risePhase,'String',Value);
SEQ.CHN(chn).Phase(Rise) = Value;



function SEQ = ShiftEvents(SEQ,Shift,FromTime)
global gTimeStep;
Shift = round(Shift/gTimeStep)*gTimeStep;

fprintf('\nInShift Events');
for chn=1:numel(SEQ.CHN)
    T = SEQ.CHN(chn).T;
    T(find(T>=FromTime))=T(find(T>=FromTime)) + Shift;
    SEQ.CHN(chn).T = T;
end



function SEQ = ChangePBN(which,SEQ,hObject, eventdata, handles)
StrList = get(handles.PBN1,'String');
Value = get(handles.PBN1,'Value');
SEQ.CHN(which).PBN = str2num(StrList{Value});

function SEQ = DeletePBN(chn,SEQ)
SEQ.CHN(chn)=[];

function SEQ = DelPBN(SEQ,chn)
i=0;
for ichn=1:numel(SEQ.CHN)
    if ichn ~= chn, 
        i = i+1;
        mCHN(i) = SEQ.CHN(ichn);
    end
end
SEQ.CHN = mCHN;



function [SEQ, nextC] = AddPBN(SEQ)
% loop over the current SEQ to get the next channel
nextPBN = 0;
for ichn=1:numel(SEQ.CHN),
    if SEQ.CHN(ichn).PBN >= nextPBN,
        nextPBN = SEQ.CHN(ichn).PBN;
    end
end
nextPBN = nextPBN + 1;

nextC = length(SEQ.CHN) + 1;
SEQ.CHN(nextC).PBN = nextPBN;
SEQ.CHN(nextC).NRise = 1;
SEQ.CHN(nextC).T = 0;
SEQ.CHN(nextC).DT = 0;
SEQ.CHN(nextC).Phase = 0;
SEQ.CHN(nextC).Type = {'notype'};
SEQ.CHN(nextC).Delays = [0 0];

function PBN = GetPBN(handles)
StrList = get(handles.PBN1,'String');
Value = get(handles.PBN1,'Value');
PBN =  str2num(StrList{Value});

function Rise = GetRise(handles)
StrList = get(handles.Rise1,'String');
Value = get(handles.Rise1,'Value');
Rise =  str2num(StrList{Value});

function chn = GetCHN(SEQ,PBN)
for ichn=1:numel(SEQ.CHN)
    if SEQ.CHN(ichn).PBN==PBN
        chn=ichn;
        return;
    end
end

function Channel = GetChannel(handles)
Channel = get(handles.Channel,'Value')-1;
