global gSc;
%% Create file 
now = clock;
date = [num2str(now(1)),'-',num2str(now(2)),'-',num2str(round(now(3)))];
fullPath=fullfile('D:\Data\',date,'\');
if ~exist(fullPath,'dir')
    mkdir(fullPath);
end
path = fullPath;

file = ['ScopeMWCali_' date '.txt'];

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
final = fullfile(path, file);


% Find a serial port object.
ScopeFunctionPool('Init'); 

while true
    ScopeFunctionPool('Single'); 

    stopMsg = char([83, 84, 79, 80, 10]);
    fopen(gSc.serial);
    while ~strcmp(query(gSc.serial,':RSTate?'), stopMsg)
    end
    fclose(gSc.serial);

    [~, waveform] = ScopeFunctionPool('ReadWaveform');
    threshold = 0.04;
    from = find(waveform.YData> threshold, 1);
    to = find(waveform.YData> threshold, 1, 'last');
    mid = floor((from + to)/2); 

    bSucess = (to-from) > 1200; % Label for success capture

%     plot(waveform.XData(from:to),waveform.YData(from:to));
%     title('Oscilloscope Data');
%     % set(gca,'XTick',(min(waveform.XData):waveform.SecPerDiv:max(waveform.XData)))
%     xlabel(['Time (' waveform.xunit ')']);
%     ylabel(['Voltage (' waveform.yunit ')']);
%     grid on;
    
    if bSucess
        interval = 50;
        data = waveform.YData(mid:mid + interval*floor((to-mid)/interval)-1);
        data = reshape(data, [floor((to-mid)/interval), interval]);
        maxval = max(data, [], 2);
        minval = min(data, [], 2);
        amp = (mean(maxval) - mean(minval))/2; % Calculate the average
        disp(['The size of the data is ', num2str(size(maxval, 1)), ', the amplitude is ', num2str(amp), '.'])
        fid = fopen(string(final),'at'); % a means add data, w means new data
        fprintf(fid,'%s', datestr(datetime(clock)));
        fprintf(fid,' %f\n', amp);
        fclose(fid);
    end
    pause(2);
end


