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


if gmSEQ.SweepDelta
    organized = [gmSEQ.SweepParam(~isnan(gmSEQ.TotalSig(1,:))); gmSEQ.TotalSig_Ave];
    fid = fopen(string(final),'wt');
    fprintf(fid,'IGOR\nWAVES/D/O sweep,sig,ref,ref2,ref3\nBEGIN\n');
    for zzz = 1:gmSEQ.SweepDeltaDataSize+1
        if zzz == 1
            StringFormat = ['%d'];
        else
            StringFormat = [StringFormat, ' %d'];
        end
    end
    StringFormat = [StringFormat,'\n'];
    
    fprintf(fid,StringFormat,organized);
    fprintf(fid, '\n');
    
elseif gmSEQ.Alternate
    organized=[gmSEQ.SweepParam(~isnan(gmSEQ.signal_Ave)); gmSEQ.signal_Ave(~isnan(gmSEQ.signal_Ave)); gmSEQ.reference_Ave(~isnan(gmSEQ.reference_Ave));...
        gmSEQ.reference2_Ave(~isnan(gmSEQ.reference2_Ave)); gmSEQ.reference3_Ave(~isnan(gmSEQ.reference3_Ave)); ...
         gmSEQ.signal_2_Ave(~isnan(gmSEQ.signal_2_Ave)); gmSEQ.reference_2_Ave(~isnan(gmSEQ.reference_2_Ave));...
        gmSEQ.reference2_2_Ave(~isnan(gmSEQ.reference2_2_Ave)); gmSEQ.reference3_2_Ave(~isnan(gmSEQ.reference3_2_Ave))];
    if gmSEQ.Ref 
       organized = [organized; gmSEQ.signal_3_Ave(~isnan(gmSEQ.signal_3_Ave)); gmSEQ.reference_3_Ave(~isnan(gmSEQ.reference_3_Ave));...
        gmSEQ.reference2_3_Ave(~isnan(gmSEQ.reference2_3_Ave)); gmSEQ.reference3_3_Ave(~isnan(gmSEQ.reference3_3_Ave))]; 
    end
    fid = fopen(string(final),'wt');
    fprintf(fid,'IGOR\nWAVES/D/O sweep,sig,ref,ref2,ref3\nBEGIN\n');
    if gmSEQ.Ref
        fprintf(fid,'%d %d %d %d %d %d %d %d %d %d %d %d %d\n',organized);
    else
        fprintf(fid,'%d %d %d %d %d %d %d %d %d\n',organized);
    end
    fprintf(fid, '\n');
else
    
    organized=[gmSEQ.SweepParam(~isnan(gmSEQ.signal_Ave)); gmSEQ.signal_Ave(~isnan(gmSEQ.signal_Ave)); gmSEQ.reference_Ave(~isnan(gmSEQ.reference_Ave))];

    if gmSEQ.ctrN==3
        organized=[organized;  gmSEQ.reference2_Ave(~isnan(gmSEQ.reference2_Ave))];
    end
    if gmSEQ.ctrN==4
        organized=[organized;  gmSEQ.reference2_Ave(~isnan(gmSEQ.reference2_Ave)); gmSEQ.reference3_Ave(~isnan(gmSEQ.reference3_Ave))];
    end
    

    fid = fopen(string(final),'wt');
    if gmSEQ.ctrN==3
        fprintf(fid,'IGOR\nWAVES/D/O sweep,sig,ref,ref2\nBEGIN\n');
    elseif gmSEQ.ctrN==4
        fprintf(fid,'IGOR\nWAVES/D/O sweep,sig,ref,ref2,ref3\nBEGIN\n');
    elseif gmSEQ.ctrN==2
        fprintf(fid,'IGOR\nWAVES/D/O sweep,sig,ref\nBEGIN\n');
    elseif gmSEQ.ctrN==1
        fprintf(fid,'IGOR\nWAVES/D/O sweep,sig\nBEGIN\n');
    end

    if gmSEQ.ctrN==3
        fprintf(fid,'%d %d %d %d\n',organized);
        fprintf(fid, '\n');
    elseif gmSEQ.ctrN==4
        fprintf(fid,'%d %d %d %d %d\n',organized);
        fprintf(fid, '\n');
    elseif gmSEQ.ctrN==2
        fprintf(fid,'%d %d %d\n',organized);
        fprintf(fid, '\n');
    elseif gmSEQ.ctrN==1
        fprintf(fid,'%d %d\n',organized);
        fprintf(fid, '\n');
    end
end

fclose(fid);

handles.textFileNameAve.String = file;
