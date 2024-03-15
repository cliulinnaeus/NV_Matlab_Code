function ExperimentFunctionPool(what,hObject, eventdata, handles, varargin)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%% Written by Jeronimo Maze, July 2007 %%%%%%%%%%%%%%%%%%
%%%%%%%%%% Harvard University, Cambridge, USA  %%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
global gmSEQ

switch what
    case 'PBON'
        PBON(hObject, eventdata, handles);
    case 'PBOFF'
        PBOFF(hObject, eventdata, handles);
    case 'Initialize'
        Initialize(hObject, eventdata, handles);
    case 'LoadSEQ'
        LoadSEQ(hObject, eventdata, handles, varargin{1});
    case 'Run'
        LoadUserInputs(hObject,eventdata,handles);
        RunSequence(hObject, eventdata, handles);
        % SaveIgorText(handles); % move to RunSequence
    case 'PlotExtRaw'
        PlotExtRaw(hObject,eventdata,handles);
    case 'PlotExt'
        PlotExt(hObject,eventdata,handles);
    case 'SaveData'
        SaveIgorText(handles);
        %SaveData(handles);
    case 'RunFirstPoint'
        LoadSEQ(hObject, eventdata, handles,handles.axes1);
        RunFirstPoint(hObject, eventdata, handles);
    case 'AutoCalibration'
        AutoCalibration(hObject, eventdata, handles, varargin{1});
    case 'RabiTrack'
        RabiTrack(hObject, eventdata, handles);
    otherwise
        disp('No Matches found in Pool Function');
end
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function PBON(hObject, eventdata, handles)

LioPB.PBN(1) = 0;
LioPB.OnOff(1) = (get(handles.LioPB0,'Value'));

LioPB.PBN(2) = 1;
LioPB.OnOff(2) = (get(handles.LioPB1,'Value'));

LioPB.PBN(3) = 2;
LioPB.OnOff(3) = (get(handles.LioPB2,'Value'));

LioPB.PBN(4) = 3;
LioPB.OnOff(4) = (get(handles.LioPB3,'Value'));

LioPB.PBN(5) = 4;
LioPB.OnOff(5) = (get(handles.LioPB4,'Value'));

LioPB.PBN(6) = 5;
LioPB.OnOff(6) = (get(handles.LioPB5,'Value'));

LioPB.PBN(7) = 6;
LioPB.OnOff(7) = (get(handles.LioPB6,'Value'));

LioPB.PBN(8) = 7;
LioPB.OnOff(8) = (get(handles.LioPB7,'Value'));

%Binary number
OutPuts = 0;
for ipbn = 1:8
    OutPuts = OutPuts + LioPB.OnOff(ipbn)*2^(LioPB.PBN(ipbn));
end

PBFunctionPool('PBON',OutPuts);
%Jero 2008-07-10

function PBOFF(hObject, eventdata, handles)
OutPuts = 0;
PBFunctionPool('PBON',OutPuts);

function Initialize(hObject, eventdata, handles)
global gmSEQ gSG gSG2 gSG3
StrL = SequencePool('PopulateSeq');
set(handles.sequence,'String',StrL);
clear StrL;

set(handles.axes1,'FontSize',8);
set(handles.axes2,'FontSize',8);
set(handles.axes3,'FontSize',8);

gmSEQ.bGo=0;
gmSEQ.bExp = 0;
gmSEQ.bTomo = false;

% load PulseBlaster DLL
LoadPBESR;
% load NI-DAQ MX DLL
% LoadNIDAQmx;

% load SRS SG386 DLL
SignalGeneratorFunctionPool('Init',PortMap('SG com'));
gSG.bMod='IQ';
gSG.bModSrc='External';
SignalGeneratorFunctionPool('SetMod');


% gSG2.bMod='IQ';
% gSG2.bModSrc='External';
% SignalGeneratorFunctionPool2('SetMod');
% 
% gSG3.bMod='IQ';
% gSG3.bModSrc='External';
% SignalGeneratorFunctionPool3('SetMod');

% gmSEQ.meas='APD';

function LoadSEQ(hObject, eventdata, handles,ax)
global gmSEQ

StrL = SequencePool('PopulateSeq');
set(handles.sequence,'String',StrL);
clear StrL;

% SignalGeneratorFunctionPool('Init',PortMap('SG com'));

LoadUserInputs(hObject,eventdata,handles);
SequencePool(string(gmSEQ.name));
DrawSequence(gmSEQ, hObject, eventdata, ax);

debug = false;
if debug
    disp("Debugging...")
    for k=1:numel(gmSEQ.CHN)
        gmSEQ.CHN(k).T=gmSEQ.CHN(k).T/1e9;
        gmSEQ.CHN(k).DT=gmSEQ.CHN(k).DT/1e9;
        gmSEQ.CHN(k).Delays=gmSEQ.CHN(k).Delays/1e9;
    end
    PBFunctionPool('PreprocessPBSequence',gmSEQ); % todo: account for ns
    disp("Debugging ending...")
end


% Customized input option
% added by Weijie 06/11/2021

switch gmSEQ.name{1}
    case 'Rabi'
%         set(handles.FROM1,'string',num2str(20));
%         set(handles.TO1,'string',num2str(30));
%         set(handles.SweepNPoints,'string',num2str(21));        
%         % set(handles.fixPow,'string',num2str(7));
%         set(handles.Repeat,'string',num2str(60000));
%         set(handles.bSweep2,'Value',0);
%         set(handles.bTrack,'Value',0);
%         set(handles.Alternate,'Value',0);
%         set(handles.Ref,'Value',0);        
    case 'ODMR'
%         set(handles.FROM1,'string',num2str(2.36));
%         set(handles.TO1,'string',num2str(2.38));
%         set(handles.SweepNPoints,'string',num2str(21));        
%         set(handles.fixPow,'string',num2str(-30)); 
%         set(handles.pi,'string',num2str(1000));
%         set(handles.Repeat,'string',num2str(60000));
%         set(handles.bSweep2,'Value',0);       
%         set(handles.bTrack,'Value',0);
%         set(handles.Alternate,'Value',0);
%         set(handles.Ref,'Value',0);
    case 'Special Cooling'
        set(handles.pi,'string',num2str(24));        
        set(handles.FROM1,'string',num2str(0));
        set(handles.TO1,'string',num2str(400));
        set(handles.SweepNPoints,'string',num2str(3));        
        set(handles.FROM2,'string',num2str(2000));
        set(handles.TO2,'string',num2str(30000));
        set(handles.SweepNPoints2,'string',num2str(8));        
        set(handles.FROM3,'string',num2str(40000));
        set(handles.TO3,'string',num2str(90000));
        set(handles.SweepNPoints3,'string',num2str(6));
        set(handles.bSweep2,'Value',1);
        set(handles.bTrack,'Value',1);
        set(handles.Repeat,'string',num2str(500));
        set(handles.Alternate,'Value',1);
        set(handles.Ref,'Value',1);
        % Set power
        amp = str2double(get(handles.AWGAmp, 'String'));
        if amp ~= 1
            set(handles.SAmp1,'string',num2str(amp));
            set(handles.SAmp2,'string',num2str(amp));
            set(handles.SAmp1_M,'string',num2str(amp));
            set(handles.SAmp2_M,'string',num2str(amp));
            set(handles.AWGAmp,'string',num2str(1));      
        end
end


function LoadUserInputs(hObject,eventdata,handles)
global gmSEQ gSG gSG2 gSG3
% gmSEQ.MWAWG = 1; % cardNum
% gmSEQ.P1AWG = 2; % cardNum

str=get(handles.sequence, 'String');
val=get(handles.sequence, 'Value');
gmSEQ.name= str(val);
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

% edit by Chong on 3/1/2017
% gmSEQ.PulseNum = str2double(get(handles.PulseNum, 'String'));
% gmSEQ.tP1Polar = str2double(get(handles.tP1Polar, 'String'));
% gmSEQ.tP1PolarStep = str2double(get(handles.tP1PolarStep, 'String'));
% gmSEQ.tP1AfterPolarWait = str2double(get(handles.tP1AfterPolarWait, 'String'));

gmSEQ.pi= str2double(get(handles.pi, 'String'));
gmSEQ.halfpi= str2double(get(handles.halfpi, 'String'));
gmSEQ.interval= str2double(get(handles.interval, 'String'));
gmSEQ.readout= str2double(get(handles.readout, 'String'));
gmSEQ.misc= str2double(get(handles.misc, 'String'));
gmSEQ.CtrGateDur=str2double(get(handles.CtrGateDur,'String'));
gmSEQ.bWarmUpAOM=get(handles.bWarmUpAOM,'Value');
gmSEQ.bTrack=get(handles.bTrack,'Value');
gSG.Pow = str2double(get(handles.fixPow, 'String'));
gSG.Freq = str2double(get(handles.fixFreq, 'String'))*1e9;
gSG.ACmodAWG = get(handles.ACmodAWG,'Value'); % AC modulation of two SG is controlled by a single button
gSG2.ACmodAWG = get(handles.ACmodAWG,'Value');
gSG3.ACmodAWG = get(handles.ACmodAWG,'Value');

gSG.AWGFreq = str2double(get(handles.AWGFreq, 'String'));
gSG.AWGAmp = str2double(get(handles.AWGAmp, 'String'));
gmSEQ.P1Pulse = str2double(get(handles.P1Pulse, 'String'));

% Point number for next tracking
gmSEQ.TrackPointN = str2double(get(handles.TrackPointN, 'String'));

% Second SG (for DEER etc)
gSG2.Freq = str2double(get(handles.fixFreq2, 'String'))*1e9;
gSG2.Pow = str2double(get(handles.fixPow2, 'String'));
gSG2.AWGFreq = str2double(get(handles.AWGFreq2, 'String'));
gSG2.AWGAmp = str2double(get(handles.AWGAmp2, 'String'));

% Third SG (for double quantum basis etc)
gSG3.Freq = str2double(get(handles.fixFreq3, 'String'))*1e9;
gSG3.Pow = str2double(get(handles.fixPow3, 'String'));
gSG3.AWGFreq = str2double(get(handles.AWGFreq3, 'String'));
gSG3.AWGAmp = str2double(get(handles.AWGAmp3, 'String'));

% check the ACmodAWG mode, add by Chong on 10/6/2020
% if not using ACmodAWG, this must be unchecked, else gSG.Freq = gSG.Freq -
% AWG set freq
if gSG.ACmodAWG
    gSG.Freq = gSG.Freq-str2double(get(handles.AWGFreq, 'String'))*1e9;
end

if gSG2.ACmodAWG
    gSG2.Freq = gSG2.Freq-str2double(get(handles.AWGFreq2, 'String'))*1e9;
end

if gSG3.ACmodAWG
    gSG3.Freq = gSG3.Freq-str2double(get(handles.AWGFreq3, 'String'))*1e9;
end

gmSEQ.DEERpi = str2double(get(handles.DEERpi, 'String'));
gmSEQ.DEERt = str2double(get(handles.DEERt, 'String'));

% For AWG, added by Chong 9/29/2020
%gSG.IQVoltage1 = 1; % 1 is approximate 0.4 V in AWG output. Yuanqi

% Adding by Chong on 10/5/2020 for many-body cooling
gmSEQ.SAmp1 = str2double(get(handles.SAmp1, 'String'));
gmSEQ.SAmp2 = str2double(get(handles.SAmp2, 'String'));
gmSEQ.SLockT1 = str2double(get(handles.SLockT1, 'String'));
gmSEQ.SLockT2 = str2double(get(handles.SLockT2, 'String'));
gmSEQ.LockN0 = str2double(get(handles.LockN0, 'String'));
gmSEQ.SAmp1_M = str2double(get(handles.SAmp1_M, 'String'));
gmSEQ.SAmp2_M = str2double(get(handles.SAmp2_M, 'String'));
gmSEQ.SLockT1_M = str2double(get(handles.SLockT1_M, 'String'));
gmSEQ.SLockT2_M = str2double(get(handles.SLockT2_M, 'String'));
gmSEQ.CoolCycle = str2double(get(handles.CoolCycle, 'String'));
gmSEQ.CoolSwitch = str2double(get(handles.CoolSwitch, 'String'));
gmSEQ.CoolWait = str2double(get(handles.CoolWait, 'String'));
gmSEQ.Alternate = get(handles.Alternate,'Value'); % Alternate between cooling and heating.
gmSEQ.SweepDelta = get(handles.SweepDelta,'Value');
gmSEQ.Ref = get(handles.Ref,'Value');
gmSEQ.bCali = get(handles.bCali,'Value');
gmSEQ.CaliN = str2double(get(handles.CaliN, 'String'));
gmSEQ.LaserCooling = str2double(get(handles.LaserCooling, 'String'));
gmSEQ.LaserDet = str2double(get(handles.LaserDet, 'String'));

% % for spin diffusion measurement, add by Chong 3/28/2017
% gmSEQ.Diffwait = str2double(get(handles.Diffwait, 'String'));
% gmSEQ.Repolarize = str2double(get(handles.Repolarize, 'String'));

% % for MREV8
% gmSEQ.MREVN = str2double(get(handles.MREVN, 'String'));
% gmSEQ.MREVtau = str2double(get(handles.MREVtau, 'String'));

gmSEQ.bAAR=get(handles.bAAR,'Value');
gmSEQ.Repeat=str2double(get(handles.Repeat,'String'));

if get(handles.bAverage,'Value')
    gmSEQ.Average=str2double(get(handles.Average,'String'));
else
    gmSEQ.Average=1;
end



function PlotExtRaw(hObject,eventdata,handles)
global gmSEQ ScaleT ScaleStr
figure;


% set(cla,'FontSize',8);        %todo: figure out how to make this work...
plot(single(gmSEQ.SweepParam).*ScaleT,single(gmSEQ.reference),'-b','LineStyle','--')

hold('on')

plot(single(gmSEQ.SweepParam).*ScaleT,single(gmSEQ.signal),'-r') 
if gmSEQ.ctrN>2
    hold('on')
    plot(single(gmSEQ.SweepParam)*ScaleT,single(gmSEQ.reference2),'-m','LineStyle','--')
end
ylabel('Fluorescence counts');
xlabel(ScaleStr);
hold('off')



function PlotExt(hObject,eventdata,handles)
global gmSEQ ScaleT ScaleStr
figure;

if ~isfield(gmSEQ,'bLiO')&&gmSEQ.ctrN~=1 % Do not plot ESR
    % Remove NaN (empty data)
    for i = 1:gmSEQ.dataN
        signal(i,:) = gmSEQ.signal(i, ~isnan(gmSEQ.signal(i,:)));
    end
    data_err = zeros(1, size(signal, 1));
    
    if gmSEQ.bTomo
        if gmSEQ.Ntomo == 3 % For DD sequence
            % Only account for gmSEQ.ctrN == 4 case for now
            % Implement error bar later
            ref_Bz = signal(1,:); ref_Dz = signal(3,:); sig_Bz = signal(2,:); sig_Dz = signal(4,:);
            ref_Bx = signal(5,:); ref_Dx = signal(7,:); sig_Bx = signal(6,:); sig_Dx = signal(8,:);
            ref_By = signal(9,:); ref_Dy = signal(11,:); sig_By = signal(10,:); sig_Dy = signal(12,:);
            dataz = 2*(sig_Bz - sig_Dz)./(ref_Bz + ref_Dz);
            datax = 2*(sig_Bx - sig_Dx)./(ref_Bx + ref_Dx);
            datay = 2*(sig_By - sig_Dy)./(ref_By + ref_Dy);
            data = sqrt(dataz.^2 + datax.^2 + datay.^2);
            plot(gmSEQ.SweepParam(1:length(data)).*ScaleT, dataz, '-r')
            hold on
            plot(gmSEQ.SweepParam(1:length(data)).*ScaleT, datax, '-g')
            plot(gmSEQ.SweepParam(1:length(data)).*ScaleT, datay, '-b')
            plot(gmSEQ.SweepParam(1:length(data)).*ScaleT, data, '-k')
            hold off
        elseif gmSEQ.Ntomo == 2 % For polarizing P1
            ref_B1 = signal(1,:); ref_D1 = signal(3,:); sig_B1 = signal(2,:); sig_D1 = signal(4,:);
            ref_B2 = signal(5,:); ref_D2 = signal(7,:); sig_B2 = signal(6,:); sig_D2 = signal(8,:);
            [data1, data_err1] = ContrastDiff(ref_B1, ref_D1, sig_B1, sig_D1, gmSEQ.iAverage);
            [data2, data_err2] = ContrastDiff(ref_B2, ref_D2, sig_B2, sig_D2, gmSEQ.iAverage);
            errorbar(gmSEQ.SweepParam(1:length(data1)).*ScaleT, data1, data_err1, '-r')
            hold on
            errorbar(gmSEQ.SweepParam(1:length(data2)).*ScaleT, data2, data_err2, '-b')
            hold off
        end
    else
        if gmSEQ.ctrN==3
            if strcmp(gmSEQ.name,'T1JC')
                data=signal(1,:)-signal(2,:)./signal(3,:);
            else
                data=signal(1,:)-signal(3,:)./(signal(2,:)-signal(4,:));
            end
        elseif gmSEQ.ctrN==2
            sig = signal(2,:);
            ref = signal(1,:);
            data = sig./ref;
            ref_err = 1./sqrt(gmSEQ.iAverage * ref); % Relative error of reference
            sig_err = 1./sqrt(gmSEQ.iAverage * sig); % Relative error of signal
            rel_err = sqrt(ref_err.^2 + sig_err.^2);
            data_err = rel_err .* data;
        elseif gmSEQ.ctrN==4
            if strcmp(gmSEQ.name,'Test_NV_Polarization') || strcmp(gmSEQ.name,'Special Cooling') || strcmp(gmSEQ.name,'Special Cooling_2') || strcmp(gmSEQ.name,'Special Cooling_P1_2_DurMeas')
                data = (signal(1,:)-signal(3,:))./(signal(2,:)+signal(4,:))*2;
            elseif strcmp(gmSEQ.name,'CtrDur') && gmSEQ.meas == "SPCM"
                data = -(signal(2,:)-signal(4,:))./sqrt((signal(1,:)+signal(3,:))/2);
                data_err = data .* 0;
            else
                % data = (gmSEQ.reference(~isnan(gmSEQ.reference))-gmSEQ.reference3(~isnan(gmSEQ.reference3)))./(gmSEQ.signal(~isnan(gmSEQ.signal))+gmSEQ.reference2(~isnan(gmSEQ.reference2)))*2;
                ref_B = signal(1,:);
                ref_D = signal(3,:);
                sig_B = signal(2,:);
                sig_D = signal(4,:);
                [data, data_err] = ContrastDiff(ref_B, ref_D,sig_B, sig_D, gmSEQ.iAverage);
            end
        end
        errorbar(gmSEQ.SweepParam(1:length(data)).*ScaleT, data, data_err,'-g')
    end
    grid on;
    set(gca, 'FontSize',8);
    ylabel('Fluorescence contrast');
    xlabel(ScaleStr);
    xlim([gmSEQ.SweepParam(1)*ScaleT gmSEQ.SweepParam(gmSEQ.NSweepParam)*ScaleT]);

end

function [data, data_err] = ContrastDiff(ref_B, ref_D,sig_B, sig_D, N)
data = 2*(sig_B - sig_D)./(ref_B + ref_D);
ref_B_err = 1./sqrt(N * ref_B); % Relative error of bright reference
ref_D_err = 1./sqrt(N * ref_D); % Relative error of dark reference
sig_B_err = 1./sqrt(N * sig_B); % Relative error of bright signal
sig_D_err = 1./sqrt(N * sig_D); % Relative error of dark signal
ref_err = sqrt((ref_B_err .* ref_B).^2 + (ref_D_err .* ref_D).^2)./(ref_B + ref_D);
sig_err = sqrt((sig_B_err .* sig_B).^2 + (sig_D_err .* sig_D).^2)./(sig_B - sig_D);
rel_err = sqrt(ref_err.^2 + sig_err.^2);
data_err = rel_err .* data;


function SaveData(handles)
global gSaveData gmSEQ  gSG
%global gScan
now = clock;
date = [num2str(now(1)),'-',num2str(now(2)),'-',num2str(round(now(3)))];
fullPath=fullfile('D:\Data\',date,'\');
if ~exist(fullPath,'dir')
    mkdir(fullPath);
end
gSaveData.path = fullPath;


gSaveData.file = ['_' date '.txt'];
name=regexprep(gmSEQ.name,'\W',''); % rewrite the sequence name without spaces/weird characters
%File name and prompt
B=fullfile(gSaveData.path, strcat(name, gSaveData.file));
file = strcat(name, gSaveData.file);

%Prevent overwriting
mfile = strrep(B,'.txt','*');
mfilename = strrep(gSaveData.file,'.txt','');

A = ls(char(mfile));
ImgN = 0;
for f = 1:size(A,1)
    sImgN = sscanf(A(f,:),strcat(name, string(mfilename), '_%d.txt'));
    if ~isempty(sImgN)
        if sImgN > ImgN
            ImgN = sImgN;
        end
    end
end
ImgN = ImgN + 1;
file = strrep(file,'.txt',sprintf('_%03d.txt',ImgN));
final= fullfile(gSaveData.path, file);
%Save File as Data
fnSEQ=fieldnames(gmSEQ);
fnSG=fieldnames(gSG);

fid = fopen(string(final),'wt');
fprintf(fid,'Sweep vector\n');
fprintf(fid,'%d\t',gmSEQ.SweepParam);
fprintf(fid, '\n');
fprintf(fid, '\n');

fprintf(fid,'Signal vector\n');
fprintf(fid,'%d\t',gmSEQ.signal);
fprintf(fid, '\n');
fprintf(fid, '\n');

fprintf(fid,'Reference vector\n');
fprintf(fid,'%d\t',gmSEQ.reference);
fprintf(fid, '\n');
fprintf(fid, '\n');

%fprintf(fid, 'Galvo Position: Vx = %.4f Vy = %.4f Vz = %.4f\n',[gScan.FixVx gScan.FixVy gScan.FixVz]);

fprintf(fid,'SEQUENCE PARAMETERS');
fprintf(fid, '\n'); 
fprintf(fid, '\n'); 

for i=1:length(fnSEQ)
    st=fnSEQ(i);
    if ~strcmp(st,'CHN') &&~strcmp(st,'SweepParam')&&~strcmp(st,'reference')&&~strcmp(st,'signal')
        fprintf(fid,string(st));
        fprintf(fid, '\n');      
        fprintf(fid,string(gmSEQ.(char(st))));
        fprintf(fid, '\n');        
        fprintf(fid, '\n'); 
    end
end

fprintf(fid,'SIGNAL GENERATOR PARAMETERS');
fprintf(fid, '\n'); 
fprintf(fid, '\n'); 

for i=1:length(fnSG)
    st=fnSG(i);
    if ~strcmp(st,'serial')&&~strcmp(st,'qErr')
        fprintf(fid,string(st));
        fprintf(fid, '\n');      
        fprintf(fid,string(gSG.(char(st))));
        fprintf(fid, '\n');        
        fprintf(fid, '\n'); 
    end
end

fclose(fid);

handles.textFileName.String = file;

function RunFirstPoint(hObject, eventdata, handles)
global gSG gmSEQ
gmSEQ.bGo=1;
SignalGeneratorFunctionPool('SetIQ');
if isfield(gmSEQ,'bLiO')   
    PBFunctionPool('PBON',2^SequencePool('PBDictionary','AOM'));
    SignalGeneratorFunctionPool('WritePow');
    gSG.bOn=1; SignalGeneratorFunctionPool('RFOnOff');
    gSG.Freq=gmSEQ.m;
    SignalGeneratorFunctionPool('WriteFreq');
    while gmSEQ.bGo
        pause(.1);
        drawnow;
    end
else
    %if gSG.bfixedPow && gSG.bfixedFreq
    SignalGeneratorFunctionPool('WritePow');
    SignalGeneratorFunctionPool('WriteFreq');
    gSG.bOn=1; SignalGeneratorFunctionPool('RFOnOff');
    for k=1:numel(gmSEQ.CHN)
        gmSEQ.CHN(k).T=gmSEQ.CHN(k).T/1e9;
        gmSEQ.CHN(k).DT=gmSEQ.CHN(k).DT/1e9;
        gmSEQ.CHN(k).Delays=gmSEQ.CHN(k).Delays/1e9;
    end
    gmSEQ.Repeat=1e6;
    while gmSEQ.bGo
        PBFunctionPool('PreprocessPBSequence',gmSEQ);
        Run_PB_Sequence;
        for i=1:50
            pause(.1); drawnow;
            if ~gmSEQ.bGo
                break
            end
        end
    end
end
    gSG.bOn=0; SignalGeneratorFunctionPool('RFOnOff');
    ExperimentFunctionPool('PBOFF',hObject, eventdata, handles);
%SaveData;

function Run_PB_Sequence
% function RunPBSequence

PBesrInit(); %initialize PBesr
% sets the clock frequency. for PBESR-PRO-400, it's 400MHz
% for PBESR-PRO-333, it's 333.3MHz
PBesrSetClock(500);

PBesrStart(); %start pulsing. it will start pulse sequence which were progammed/loaded to PBESR card before.

PBesrClose(); %close PBesr
%set status to 0, implement in the future
status = 0;

function AutoCalibration(hObject, eventdata, handles, bButton)
global gmSEQ gSG ScaleT
disp('Auto-calibration starts.')
LoadUserInputs(hObject,eventdata,handles);

Pow = gSG.Pow;
%% ODMR calibration
gmSEQ.name= 'ODMR';
gmSEQ.From= 2.35;
gmSEQ.To= 2.40;
gmSEQ.bSweep1log = 0;
gmSEQ.N= 21;
gmSEQ.bSweep2=0;
gmSEQ.bSweep3=0;
gmSEQ.pi= 1000;
gmSEQ.readout= 10000;
gmSEQ.bTrack = 0;
gmSEQ.bCali = 0;
gmSEQ.Repeat = 20000;
gmSEQ.Average = 1;
gmSEQ.m = 0; % Initialization
gSG.Pow = -30;
gSG.ACmodAWG = 1;
gSG.AWGAmp = 1;
Freq = 2.366; 
% Freq = str2double(get(handles.fixFreq, 'String'));

if ~bButton
    gmSEQ.bExp = 0;
end

SequencePool(string(gmSEQ.name));
RunSequence(hObject, eventdata, handles);
data=gmSEQ.signal(~isnan(gmSEQ.signal))./gmSEQ.reference(~isnan(gmSEQ.reference));

ft = fittype( 'LorentzianFit(x, A, B, C, D)');
f = fit(gmSEQ.SweepParam(:)/1e9, data(:), ft, 'StartPoint', [0.015, 0.006, 1.01, 2.366]);
Freq = round(f.D, 3);
disp(['Update MW frequency to ', num2str(Freq)])
if bButton
    set(handles.fixFreq,'string',num2str(Freq));
end
gSG.Freq = Freq*1e9-str2double(get(handles.AWGFreq, 'String'))*1e9;

%% Rabi Calibration
gmSEQ.name= 'Rabi';

% For single cycle
gmSEQ.From= 0;
gmSEQ.To= 100;
gmSEQ.N= 21;

% For multiple cycles
% gmSEQ.From= 0;
% gmSEQ.To= 80;
% gmSEQ.N= 41;

gmSEQ.pi= str2double(get(handles.pi, 'String'));

if bButton
    gSG.Pow = 6.3;  
else
    gSG.Pow = Pow;
end

SequencePool(string(gmSEQ.name));
RunSequence(hObject, eventdata, handles);
data=gmSEQ.signal(~isnan(gmSEQ.signal))./gmSEQ.reference(~isnan(gmSEQ.reference));

ft = fittype( 'TrigonometricDecayFit(x, A, B, C, T)');
f = fit(gmSEQ.SweepParam(:), data(:), ft, 'StartPoint', [0.1, 160, 1, 50]);
hold on 
plot(handles.axes3, gmSEQ.SweepParam(1:length(data)).*ScaleT, f(gmSEQ.SweepParam),'-k')
hold off
% ft = fittype( 'TrigonometricFit(x, A, C, T)');
% f = fit(gmSEQ.SweepParam(:), data(:), ft, 'StartPoint', [0.12, 1, 100]);
marker = 0;
while abs(f.T/2 - gmSEQ.pi) > 0.2
    if f.T/2 > gmSEQ.pi
        gSG.Pow = gSG.Pow + 0.1;
    else
        gSG.Pow = gSG.Pow - 0.1;
    end
    SequencePool(string(gmSEQ.name));
    RunSequence(hObject, eventdata, handles);
    data=gmSEQ.signal(~isnan(gmSEQ.signal))./gmSEQ.reference(~isnan(gmSEQ.reference));
    % ft = fittype( 'TrigonometricFit(x, A, C, T)');
    % f = fit(gmSEQ.SweepParam(:), data(:), ft, 'StartPoint', [0.12, 1, 100]);
    ft = fittype( 'TrigonometricDecayFit(x, A, B, C, T)');
    f = fit(gmSEQ.SweepParam(:), data(:), ft, 'StartPoint', [0.1, 160, 1, 50]);
    disp(f)
    
    hold on 
    plot(handles.axes3, gmSEQ.SweepParam(1:length(data)).*ScaleT, f(gmSEQ.SweepParam),'-k')
    hold off
    
    marker = marker + 1;
    if marker > 8
        break;
    end
end
disp(['MW power is ', num2str(gSG.Pow), '. pi pulse is ', num2str(f.T/2), '.']);
if bButton
    set(handles.fixPow,'string',num2str(round(gSG.Pow, 3)));
end

gmSEQ.From= 0;
gmSEQ.To= 200;
gmSEQ.N= 21;
if bButton
    gSG.AWGAmp = 0.37; % need to get from current data
else
    gSG.AWGAmp = gmSEQ.SAmp1;
end
CoolPi = 49;

RunSequence(hObject, eventdata, handles);
data=gmSEQ.signal(~isnan(gmSEQ.signal))./gmSEQ.reference(~isnan(gmSEQ.reference));

ft = fittype( 'TrigonometricDecayFit(x, A, B, C, T)');
f = fit(gmSEQ.SweepParam(:), data(:), ft, 'StartPoint', [0.05, 300, 1, 100]);
% ft = fittype( 'TrigonometricFit(x, A, C, T)');
% f = fit(gmSEQ.SweepParam(:), data(:), ft, 'StartPoint', [0.12, 1, 200]);
marker = 0;
while abs(f.T/2 - CoolPi) > 0.5
    if f.T/2 > CoolPi
        gSG.AWGAmp = gSG.AWGAmp + 0.01;
    else
        gSG.AWGAmp = gSG.AWGAmp - 0.01;
    end
    SequencePool(string(gmSEQ.name));
    RunSequence(hObject, eventdata, handles);
    data=gmSEQ.signal(~isnan(gmSEQ.signal))./gmSEQ.reference(~isnan(gmSEQ.reference));
    ft = fittype( 'TrigonometricDecayFit(x, A, B, C, T)');
    f = fit(gmSEQ.SweepParam(:), data(:), ft, 'StartPoint', [0.05, 300, 1, 100]);
    disp(f)
%     ft = fittype( 'TrigonometricFit(x, A, C, T)');
%     f = fit(gmSEQ.SweepParam(:), data(:), ft, 'StartPoint', [0.12, 1, 200]);
    marker = marker + 1;
    if marker > 8
        break;
    end
end
disp(['MWAWG amplitude is ', num2str(gSG.AWGAmp), '. pi pulse is ', num2str(f.T/2), '.']);
if bButton
    set(handles.AWGAmp,'string',num2str(round(gSG.AWGAmp, 3)));
end

if ~bButton
    gmSEQ.bExp = 1;
end

function RabiTrack(hObject, eventdata, handles, bButton)
global gmSEQ gSG ScaleT gScan
disp('Rabi tracking starts.')
LoadUserInputs(hObject,eventdata,handles);

bImageCorr = true;

%% Create file 
now = clock;
date = [num2str(now(1)),'-',num2str(now(2)),'-',num2str(round(now(3)))];
fullPath=fullfile('D:\Data\',date,'\');
if ~exist(fullPath,'dir')
    mkdir(fullPath);
end
path = fullPath;

file = ['RabiTrack_' date '.txt'];

%File name and prompt
B=fullfile(path, file);

%Prevent overwriting
mfile = strrep(B,'.txt','*');
mfilename = strrep(file,'.txt','');
A = ls(char(mfile));
ImgN = 0;
for f = 1:size(A,1)
    sImgN = sscanf(A(f,:),strcat(string(mfilename), '_%d.txt'));
    if ~isempty(sImgN)
        if sImgN > ImgN
            ImgN = sImgN;
        end
    end
end
ImgN = ImgN + 1;
file = strrep(file,'.txt',sprintf('_%03d.txt',ImgN));
final_rabi = fullfile(path, file);

if bImageCorr
    file = ['ContinuousTrackZ_' date '.txt'];
    %File name and prompt
    B=fullfile(path, file);

    %Prevent overwriting
    mfile = strrep(B,'.txt','*');
    mfilename = strrep(file,'.txt','');
    A = ls(char(mfile));
    ImgN = 0;
    for f = 1:size(A,1)
        sImgN = sscanf(A(f,:),strcat(string(mfilename), '_%d.txt'));
        if ~isempty(sImgN)
            if sImgN > ImgN
                ImgN = sImgN;
            end
        end
    end
    ImgN = ImgN + 1;
    file = strrep(file,'.txt',sprintf('_%03d.txt',ImgN));
    final_image = fullfile(path, file);
end

%% Rabi
gmSEQ.name= 'Rabi';

% For single cycle
% gmSEQ.From= 10;
% gmSEQ.To= 40;
% gmSEQ.N= 21;

% For multiple cycles
% gmSEQ.From= 0;
% gmSEQ.To= 80;
% gmSEQ.N= 41;

gmSEQ.bSweep1log = 0;
gmSEQ.bSweep2=0;
gmSEQ.bSweep3=0;
gmSEQ.readout= 10000;
gmSEQ.bTrack = 0;
gmSEQ.bCali = 0;
gmSEQ.Average = 1;
gmSEQ.m = 0; % Initialization
gSG.ACmodAWG = 1;
gSG.AWGAmp = 1;
gSG.Freq = str2double(get(handles.fixFreq, 'String'))*1e9-str2double(get(handles.AWGFreq, 'String'))*1e9;
gSG.Pow = str2double(get(handles.fixPow, 'String'));
SequencePool(string(gmSEQ.name));

h = findobj('Tag','ImageNVCGUI');
if ~isempty(h)
    % get handles and other user-defined data associated to Gui1
    handles_ImageNVC = guidata(h);
end

gmSEQ.bCtr = 1;
while gmSEQ.bCtr
    PBFunctionPool('PBON',2^SequencePool('PBDictionary','AOM'));
    if bImageCorr
        ImageFunctionPool('TrackImageCorr',0, 0, handles_ImageNVC);
        ImageFunctionPool('TrackZ',0, 0, handles_ImageNVC);
    end
    
    RunSequence(hObject, eventdata, handles);
    data=gmSEQ.signal(~isnan(gmSEQ.signal))./gmSEQ.reference(~isnan(gmSEQ.reference));
    ft = fittype( 'TrigonometricDecayFit(x, A, B, C, T)');
    try
        f = fit(gmSEQ.SweepParam(:), data(:), ft, 'StartPoint', [0.1, 300, 1, 34]);
        % disp(f)
        hold on
        plot(handles.axes3, gmSEQ.SweepParam.*ScaleT, f(gmSEQ.SweepParam),'-k')
        hold off
        
        fid = fopen(string(final_rabi),'at'); % a means add data, w means new data
        fprintf(fid,'%s', datestr(datetime(clock)));
        fprintf(fid,' %f\n', f.T/2);
        fclose(fid);
        
        if bImageCorr
            fid = fopen(string(final_image),'at'); % a means add data, w means new data
            fprintf(fid,'%s', [datestr(datetime(clock))]);
            fprintf(fid,' %.4f %.4f %3.1f\n', [gScan.FixVx, gScan.FixVy, gScan.FixVz]);
            fclose(fid);
        end
    catch
    end
end


