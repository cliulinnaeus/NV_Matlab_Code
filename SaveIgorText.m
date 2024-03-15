
function SaveIgorText(handles)
global gSaveData gmSEQ  gSG
%global gScan
now = clock;
date = [num2str(now(1)),'-',num2str(now(2)),'-',num2str(round(now(3)))];
fullPath=fullfile('C:\Data\',date,'\');
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
if gmSEQ.bGo
    file = strrep(file,'.txt', '_averaging.txt');
else
    file = strrep(file,'.txt',sprintf('_%03d.txt',ImgN));
end
final= fullfile(gSaveData.path, file);
%Save File as Data
fnSEQ=fieldnames(gmSEQ);
fnSG=fieldnames(gSG);

organized = [gmSEQ.SweepParam(~isnan(gmSEQ.signal(1,:)))];
for i = 1:gmSEQ.dataN
    organized = [organized; gmSEQ.signal(i, ~isnan(gmSEQ.signal(i,:)))];
end

fid = fopen(string(final),'wt');
fprintf(fid,'IGOR\nWAVES/D/O sweep,sig(%d) \nBEGIN\n', gmSEQ.dataN);
fprintf(fid, [repmat('%d ', [1, gmSEQ.dataN + 1]), '\n'], organized);
fprintf(fid, '\nEND\n');

% if gmSEQ.ctrN==3
%     fprintf(fid, 'END\nX Duplicate/O sig, data; data=(sig-ref2)/(ref-ref2)\nX Display data vs sweep; ModifyGraph width=200, height=100\nX ModifyGraph rgb(data)=(0,65535,0)\nX Display sig vs sweep; AppendToGraph ref vs sweep; ModifyGraph width=200, height=100\nX ModifyGraph rgb(ref)=(0,0,65535);\n');
%     fprintf(fid, 'X AppendToGraph ref2 vs sweep; ModifyGraph rgb(ref2)=(65535,0,65535)\n');
% elseif gmSEQ.ctrN==4
%     fprintf(fid, 'END\nX Duplicate/O sig, data; data=(sig-ref2)/(ref-ref2)\nX Display data vs sweep; ModifyGraph width=200, height=100\nX ModifyGraph rgb(data)=(0,65535,0)\nX Display sig vs sweep; AppendToGraph ref vs sweep; ModifyGraph width=200, height=100\nX ModifyGraph rgb(ref)=(0,0,65535);\n');
%     fprintf(fid, 'X AppendToGraph ref2 vs sweep; ModifyGraph rgb(ref2)=(65535,0,65535)\n');
% elseif gmSEQ.ctrN==2
%     fprintf(fid, 'END\nX Duplicate/O sig, data; data=sig/ref\nX Display data vs sweep; ModifyGraph width=200, height=100\nX ModifyGraph rgb(data)=(0,65535,0)\nX Display sig vs sweep; AppendToGraph ref vs sweep; ModifyGraph width=200, height=100\nX ModifyGraph rgb(ref)=(0,0,65535);\n');
% else
%     fprintf(fid, 'END\nX Display sig vs sweep; ModifyGraph width=200, height=100\nX ModifyGraph rgb(ref)=(0,0,65535);\n');
% end
fprintf(fid,comment('SEQUENCE PARAMETERS'));

for i=1:length(fnSEQ)
    st=fnSEQ(i);
    if ~strcmp(st,'CHN') &&~strcmp(st,'SweepParam')&&~strcmp(st,'reference')&&~strcmp(st,'signal')&&~strcmp(st,'reference2')&&~strcmp(st,'reference3')&&~strcmp(st,'signal_2')&&~strcmp(st,'reference_2')&&~strcmp(st,'reference2_2')&&~strcmp(st,'reference3_2')...
            &&~strcmp(st,'reference_Ave')&&~strcmp(st,'signal_Ave')&&~strcmp(st,'reference2_Ave')&&~strcmp(st,'reference3_Ave')&&~strcmp(st,'signal_2_Ave')&&~strcmp(st,'reference_2_Ave')&&~strcmp(st,'reference2_2_Ave')&&~strcmp(st,'reference3_2_Ave')&&...
            ~strcmp(st,'signal_3')&&~strcmp(st,'reference_3')&&~strcmp(st,'reference2_3')&&~strcmp(st,'reference3_3')&&~strcmp(st,'signal_3_Ave')&&~strcmp(st,'reference_3_Ave')&&~strcmp(st,'reference2_3_Ave')&&~strcmp(st,'reference3_3_Ave')&&~strcmp(st,'TotalSig')&&~strcmp(st,'TotalSig_Ave')...
            &&~strcmp(st,'ScaleStr')&&~strcmp(st,'ScaleT')
        fprintf(fid,comment(string(st)));
        
        fprintf(fid,comment(string(gmSEQ.(char(st)))));
    end
end

fprintf(fid,comment('SIGNAL GENERATOR PARAMETERS'));

for i=1:length(fnSG)
    st=fnSG(i);
    if ~strcmp(st,'serial')&&~strcmp(st,'qErr')
        fprintf(fid,comment(string(st)));
        fprintf(fid,comment(string(gSG.(char(st)))));
    end
end

fclose(fid);

handles.textFileName.String = file;

function outStr = comment(inStr)
outStr=strcat('X// ',inStr,'\n');