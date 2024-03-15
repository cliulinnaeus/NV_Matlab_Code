function SaveIgorText_Average(handles)
global gSaveDataAve gmSEQ
%global gScan

%name=regexprep(gmSEQ.name,'\W',''); % rewrite the sequence name without spaces/weird characters
%File name and prompt
B=fullfile(gSaveDataAve.path, gSaveDataAve.file);
%file = strcat(name, gSaveDataAve.file);

%Prevent overwriting
mfile = strrep(B,'.txt','*');
mfilename = strrep(gSaveDataAve.file,'.txt','');

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
file = strrep(gSaveDataAve.file,'.txt',sprintf('_%03d.txt',ImgN));
final= fullfile(gSaveDataAve.path, file);
%Save File as Data

organized = [gmSEQ.SweepParam(~isnan(gmSEQ.signal(1,:)))];
for i = 1:gmSEQ.dataN
    organized = [organized; gmSEQ.signal_Ave(i, ~isnan(gmSEQ.signal(i,:)))];
end

fid = fopen(string(final),'wt');
fprintf(fid,'IGOR\nWAVES/D/O sweep,sig(%d) \nBEGIN\n', gmSEQ.dataN);
fprintf(fid, [repmat('%d ', [1, gmSEQ.dataN + 1]), '\n'], organized);
fprintf(fid, '\nEND\n');
fclose(fid);

handles.textFileNameAve.String = file;
