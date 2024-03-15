function SEQ = GetPulseSequence(file)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%% Written by Jeronimo Maze, July 2007 %%%%%%%%%%%%%%%%%%
%%%%%%%%%% Harvard University, Cambridge, USA  %%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%%
% modified 22 July 2008, jhodges
% added Phases to Rises

fid = fopen(file,'r');
SEQ.file = file;
go = true; ichn = 0;
while go
    out = fscanf(fid,'PB%d\t%d');
    %if strcmp('',out) | ichn | isempty(out) > 100
    if isempty(out) | ichn  > 100
        go = false;
    else
        ichn = ichn + 1;
        CHN.PBN = out(1);
        CHN.NRise = out(2);
        CHN.T = zeros(1,CHN.NRise);
        CHN.DT = zeros(1,CHN.NRise);
        CHN.Phase = zeros(1,CHN.NRise);
        out = fscanf(fid,'%f',[1 CHN.NRise]);
        CHN.T = out;
        out = fscanf(fid,'%f',[1 CHN.NRise]);
        CHN.DT = out;
        out = fscanf(fid,'%d',[1 CHN.NRise]);
        % check to see if parser found a phase, if not just add zeros
        if ~isempty(out),
            CHN.Phase = out;
        else
            CHN.Phase = zeros(1,CHN.NRise);
        end
        
        for i=1:CHN.NRise
            out2{i} = fscanf(fid,'%s[\t]',[1 1]);
        end
        CHN.Type = out2;
        clear out2;
        CHN.Delays = fscanf(fid,'%f',[1 2]);
        SEQ.CHN(ichn) = CHN;
        fgetl(fid);
    end
end
