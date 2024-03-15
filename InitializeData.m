function InitializeData(handles)

global gmSEQ

gmSEQ.Repeat=str2double(get(handles.Repeat,'String'));


if get(handles.bAverage,'Value')
    gmSEQ.Average=str2double(get(handles.Average,'String'));
else
    gmSEQ.Average=1;
end

gmSEQ.SweepParam=gmSEQ.From:(gmSEQ.To-gmSEQ.From)/(gmSEQ.N-1):gmSEQ.To;
gmSEQ.NSweepParam=length(gmSEQ.SweepParam);


gmSEQ.bGo=1;
gmSEQ.bGoAfterAvg=1;
for i=1:numel(gmSEQ.CHN)
    if gmSEQ.CHN(i).PBN==SequencePool('PBDictionary','ctr0')
        gmSEQ.ctrN=gmSEQ.CHN(i).NRise;
    end
end
gmSEQ.signal=NaN(gmSEQ.NSweepParam,gmSEQ.ctrN);