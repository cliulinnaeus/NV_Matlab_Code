function Auto_LoadUserInputs(hObject,eventdata,handles)
global gmSEQ gSG 

gmSEQ.From= str2double(get(handles.FROM1, 'String'));
gmSEQ.To= str2double(get(handles.TO1, 'String'));
gmSEQ.bSweep1log = get(handles.bSweep1log,'Value');
gmSEQ.N= str2double(get(handles.SweepNPoints, 'String'));

gmSEQ.From2= str2double(get(handles.FROM2, 'String'));
gmSEQ.bSweep2log = get(handles.bSweep2log,'Value');
gmSEQ.bSweep2=get(handles.bSweep2,'Value');
gmSEQ.To2= str2double(get(handles.TO2, 'String'));
gmSEQ.N2=str2double(get(handles.SweepNPoints2,'String'));

gmSEQ.From3= str2double(get(handles.FROM3, 'String'));
gmSEQ.bSweep3log = get(handles.bSweep3log,'Value');
gmSEQ.bSweep3=get(handles.bSweep3,'Value');
gmSEQ.To3= str2double(get(handles.TO3, 'String'));
gmSEQ.N3=str2double(get(handles.SweepNPoints3,'String'));

gmSEQ.Var = cell2mat(handles.SweepParaTable.Data(:,1));

gmSEQ.pi= str2double(get(handles.pi, 'String'));
gmSEQ.halfpi= str2double(get(handles.halfpi, 'String'));
gmSEQ.interval= str2double(get(handles.interval, 'String'));
gmSEQ.readout= str2double(get(handles.readout, 'String'));
gmSEQ.misc= str2double(get(handles.misc, 'String'));
gmSEQ.CtrGateDur=str2double(get(handles.CtrGateDur,'String'));
gmSEQ.bWarmUpAOM=get(handles.bWarmUpAOM,'Value');
gmSEQ.bTrack=get(handles.bTrack,'Value');
gmSEQ.saveRaw = get(handles.saveRaw,'Value');
gmSEQ.post_init_wait = str2double(get(handles.post_init_wait,'String'));
gmSEQ.post_MW_wait = str2double(get(handles.post_MW_wait,'String'));

gSG.Pow = str2double(get(handles.fixPow, 'String'));
gSG.Freq = str2double(get(handles.fixFreq, 'String'))*1e9;

gmSEQ.P1Pulse = str2double(get(handles.P1Pulse, 'String'));

gSG.FPGAFreq7 = str2double(get(handles.FPGAFreq7, 'String'));
gSG.FPGAGain7 = round(str2double(get(handles.FPGAGain7, 'String'))/100*(2^15-1)); %convert to gain in the fpga awg
gSG.FPGAFreq6 = str2double(get(handles.FPGAFreq6, 'String'));
gSG.FPGAGain6 = round(str2double(get(handles.FPGAGain6, 'String'))/100*(2^15-1)); %convert to gain in the fpga awg
gSG.FPGAFreq5 = str2double(get(handles.FPGAFreq5, 'String'));
gSG.FPGAGain5 = round(str2double(get(handles.FPGAGain5, 'String'))/100*(2^15-1)); %convert to gain in the fpga awg
gSG.FPGAFreq4 = str2double(get(handles.FPGAFreq4, 'String'));
gSG.FPGAGain4 = round(str2double(get(handles.FPGAGain4, 'String'))/100*(2^15-1)); %convert to gain in the fpga awg


% Point number for next tracking
gmSEQ.TrackPointN = str2double(get(handles.TrackPointN, 'String'));

gmSEQ.DEERpi = str2double(get(handles.DEERpi, 'String'));
gmSEQ.DEERt = str2double(get(handles.DEERt, 'String'));

gmSEQ.bAAR=get(handles.bAAR,'Value');
gmSEQ.Repeat=str2double(get(handles.Repeat,'String'));

if get(handles.bAverage,'Value')
    gmSEQ.Average=str2double(get(handles.Average,'String'));
else
    gmSEQ.Average=1;
end

if (gmSEQ.bSweep1log)
    gmSEQ.SweepParam=logspace(log10(gmSEQ.From),log10(gmSEQ.To),gmSEQ.N);
else
    gmSEQ.SweepParam=linspace(gmSEQ.From,gmSEQ.To,gmSEQ.N);
end

if (gmSEQ.bSweep2)
    if (gmSEQ.bSweep2log)
        gmSEQ.SweepParam=[gmSEQ.SweepParam logspace(log10(gmSEQ.From2),log10(gmSEQ.To2),gmSEQ.N2)];
    else
        gmSEQ.SweepParam=[gmSEQ.SweepParam linspace(gmSEQ.From2,gmSEQ.To2,gmSEQ.N2)];
    end
end

if (gmSEQ.bSweep3)
    if (gmSEQ.bSweep3log)
        gmSEQ.SweepParam=[gmSEQ.SweepParam logspace(log10(gmSEQ.From3),log10(gmSEQ.To3),gmSEQ.N3)];
    else
        gmSEQ.SweepParam=[gmSEQ.SweepParam linspace(gmSEQ.From3,gmSEQ.To3,gmSEQ.N3)];
    end
end


gmSEQ.bCust = get(handles.useCustPoints,'Value');
gmSEQ.measPD = get(handles.bSavePDVoltage,'Value');