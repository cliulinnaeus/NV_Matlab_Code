function ch = complieCHN(CHN)
N_chn = length(CHN);
prog_save = cell(N_chn);
for i = 1:N_chn
    prog = ['['];
    N_cmd = length(CHN{i});
    for j = 1:N_cmd
        cmd = CHN{i}{j};
        if ~isstring(cmd); cmd = num2str(cmd); end
        prog = [prog cmd ','];
    end
    prog = [prog(1:end-1) ']'];
    prog_save{i} = prog;
end

if N_chn == 1
    ch.ch7 = prog_save{1};
elseif N_chn == 2
    ch.ch7 = prog_save{1};
    ch.ch6 = prog_save{2};
else
    warning('max number of channels is 2')
end
end

