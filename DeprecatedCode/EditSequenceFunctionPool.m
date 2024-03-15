function EditSequenceFunctionPool(what,hObject, eventdata, handles)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%% Written by Jeronimo Maze, July 2007 %%%%%%%%%%%%%%%%%%
%%%%%%%%%% Harvard University, Cambridge, USA  %%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


switch what
    case 'OpenAddSequence'
        OpenAddSequence(hObject, eventdata, handles);
    case 'AddSubSeq'
        AddSubSeq(hObject, eventdata, handles);
    case 'ReplaceSequence'
        ReplaceSequence(hObject, eventdata, handles);
    otherwise
        disp('EditSequenceFunctionPool does not get it!');
end

function AddSubSeq(hObject, eventdata, handles)
global gAddSEQ gSEQ gEditSEQ;

SEQ1 = gEditSEQ;
SEQ2 = gAddSEQ;

T0 = GetLastEvent(gEditSEQ);
FE = GetFirstEvent(gAddSEQ);
LE = GetLastEvent(gAddSEQ);
DT = LE - FE;
FE, LE
DT 
NTimes = eval(get(handles.NTimes,'String'));

tchn1 = length(SEQ1.CHN);

for n=1:NTimes
    for ichn2 = 1 :numel(SEQ2.CHN)
        PBN2 = SEQ2.CHN(ichn2).PBN;
        ichn1 = GetCHN(SEQ1,PBN2);
        if ~isempty(ichn1)
            SEQ1.CHN(ichn1).T = [ SEQ1.CHN(ichn1).T  T0 + SEQ2.CHN(ichn2).T - FE];
            SEQ1.CHN(ichn1).DT = [ SEQ1.CHN(ichn1).DT  SEQ2.CHN(ichn2).DT];
            SEQ1.CHN(ichn1).Phase =[ SEQ1.CHN(ichn1).Phase  SEQ2.CHN(ichn2).Phase];
            SEQ1.CHN(ichn1).Type = { SEQ1.CHN(ichn1).Type{:}  SEQ2.CHN(ichn2).Type{:}};
            SEQ1.CHN(ichn1).NRise = length(SEQ1.CHN(ichn1).T);
        else
            ichn1 = tchn1 + 1;
            tchn1 = ichn1;
            SEQ1.CHN(ichn1).T =T0 + SEQ2.CHN(ichn2).T - FE;
            SEQ1.CHN(ichn1).DT =  SEQ2.CHN(ichn2).DT;
            SEQ1.CHN(ichn1).Phase = SEQ2.CHN(ichn2).Phase;
            SEQ1.CHN(ichn1).Type = {SEQ2.CHN(ichn2).Type{:}};
            SEQ1.CHN(ichn1).NRise = length(SEQ1.CHN(ichn1).T);
            SEQ1.CHN(ichn1).PBN = SEQ2.CHN(ichn2).PBN;
            SEQ1.CHN(ichn1).Delays = SEQ2.CHN(ichn2).Delays;
        end
    end
    T0 = T0 + DT;
end

gEditSEQ = SEQ1;
SEQ1.CHN(1)
DrawSequenceAxes(handles.axes1,gEditSEQ, hObject, eventdata, handles);

RefreshEditSeqForm('All',hObject, eventdata, handles, []);

function chn = GetCHN(SEQ,PBN)
chn = [];
for ichn=1:numel(SEQ.CHN)
    if SEQ.CHN(ichn).PBN==PBN
        chn=ichn;
        return;
    end
end

function T = GetLastEvent(SEQ)

T = -Inf;
for ichn = 1 :numel(SEQ.CHN)
    for irise = 1:SEQ.CHN(ichn).NRise %PLOT each rise
        t = SEQ.CHN(ichn).T(irise);
        dt = SEQ.CHN(ichn).DT(irise);
        T = max([T t+dt]);
    end
end

function T = GetFirstEvent(SEQ)

T = Inf;
for ichn = 1 :numel(SEQ.CHN)
    for irise = 1:SEQ.CHN(ichn).NRise %PLOT each rise
        t = SEQ.CHN(ichn).T(irise);
        dt = SEQ.CHN(ichn).DT(irise);
        T = min([T t])
    end
end



function ReplaceSequence(hObject, eventdata, handles)
global gAddSEQ gSEQ gEditSEQ;

gEditSEQ = gAddSEQ;

DrawSequenceAxes(handles.axes1,gEditSEQ, hObject, eventdata, handles);



function OpenAddSequence(hObject, eventdata, handles)

global gAddSEQ hAxes1;

file = 'Sequences/';
[file, path, filterindex] = uigetfile('Sequence*.*', 'Open Sequence',file);

SEQ = GetPulseSequence([path file]);

gAddSEQ = SEQ;

DrawSequenceAxes(handles.axes2,SEQ, hObject, eventdata, handles);

set(handles.AddSequenceFile,'String',file);

hAxes1 = handles.axes2;




function DrawSequenceAxes(hAxes,SEQ, hObject, eventdata, handles)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%% Written by Jeronimo Maze, July 2007 %%%%%%%%%%%%%%%%%%
%%%%%%%%%% Harvard University, Cambridge, USA  %%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

global tmin tmax ScaleT bShowTimes bShowTypes;

if isempty(bShowTypes)
    bShowTypes = false;
end
if isempty(bShowTimes)
    bShowTimes = false;
end


Color = {'g','r','b','k','m','c','y','g','r'};

if numel(SEQ.CHN)== 0 axes(handles.axes1); cla; return; end

for ichn = 1 :numel(SEQ.CHN)
    atmin(ichn) = min(SEQ.CHN(ichn).T);
    atmax(ichn) = max(SEQ.CHN(ichn).T + SEQ.CHN(ichn).DT);
end
tmin = min(atmin);
tmax = max(atmax);

[ScaleT ScaleStr] = GetScale(tmax);

ymin = -0.5;
ymax = (size(SEQ.CHN,2) -1)*1.5 + 1 + 0.5;

axes(hAxes); cla(hAxes);
for ichn = size(SEQ.CHN,2):-1:1
    PlotCHN(hAxes,SEQ,ichn,Color, tmin,tmax,ScaleT,ScaleStr);
end

xlim(hAxes,ScaleT*[tmin tmax]);
ylim(hAxes,[ymin ymax]);

function PlotCHN(hAxes,SEQ,ichn,Color,tmin,tmax,ScaleT, ScaleStr)
global bShowTimes bShowTypes;

yLow = (ichn -1)*1.5;
yHigh = (ichn -1)*1.5 + 1;
s = 0:1/99:1;
one = ones(size(s));
t0 = tmin;
hold on;
for irise = 1:SEQ.CHN(ichn).NRise %PLOT each rise
    t1 = SEQ.CHN(ichn).T(irise);
    dt = SEQ.CHN(ichn).DT(irise);
    t2 = t1 + dt;
    xL = t0 + (t1-t0)*s;
    yL = yLow*one;
    xLH = t1*one;
    yLH = yLow + (yHigh - yLow)*s;
    xH = t1 + (t2-t1)*s;
    yH = yHigh*one;
    xHL = t2*one;
    yHL = yHigh + (yLow - yHigh)*s;
    plot(hAxes,ScaleT*[xL xLH xH xHL],[yL yLH yH yHL],Color{ichn});
    t0 = t2;
    if bShowTimes
        text(ScaleT*xLH,(yL+yH)/2,...
            [' (' NiceNotation(xHL(1)-xLH(1)) ', ' NiceNotation(xLH(1)) ')'],'FontSize',8);
    end
    if bShowTypes
        text(ScaleT*xLH,yH+0.2, SEQ.CHN(ichn).Type(irise),'FontSize',8);
    end
end
xL = t2 + (tmax-t2)*s;
yL = yLow*one;
plot(hAxes,ScaleT*xL,yL,Color{ichn});
hold off;
text(ScaleT*(tmin+0.01*(tmax-tmin)),yLow+0.5,sprintf('PB%.0f',SEQ.CHN(ichn).PBN),'Color',Color{ichn});
xlabel(hAxes,ScaleStr)


function [ScaleT, ScaleStr] = GetScale(tmax)
if tmax > 0 & tmax <= 100e-12
    ScaleT = 1e12;
    ScaleStr = 'ps';
elseif tmax > 100e-12 & tmax <= 100e-9
    ScaleT = 1e9;
    ScaleStr = 'ns';
elseif tmax > 100e-9 & tmax <= 100e-6
    ScaleT = 1e6;
    ScaleStr = '{\mu}s';
elseif tmax > 100e-6 & tmax <= 100e-3
    ScaleT = 1e3;
    ScaleStr = 'ms';
elseif tmax > 100e-3 & tmax <= 100
    ScaleT = 1;
    ScaleStr = 's';
end
