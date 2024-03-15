% THINGS TO DO: 
% 1. Read output from the AWG
% 2. Send Multiple commands
% 3. ...

function chaseFunctionPool(varargin)
% chaseFunctionPool('createWaveform',waveform,sampleRate,length)
%   will create a wave and save it to sweep.txt in the waveform folder path
% chaseFunctionPool('createWaveform',waveform,sampleRate,length,name)
%   will create a wave and save it to a given filename in the waveform
%   folder path
% chaseFunctionPool('endChase)
%   will stop running the Wavepond program in the background
% chaseFunctionPool('loadChase')
%   will start running the Wavepond program in the background and startup
%   the AWG
% chaseFunctionPool('loadWaveform')
%   will load sweep.txt to the AWG
% chaseFunctionPool('loadWaveform',name)
%   will load the waveform with given filename to the AWG
% chaseFunctionPool('PWR_DWN')
%   will power down the AWG (many commands takes in a cardNumber which is 1
%   by default). In future, if there is more than one waveform connected to
%   the computer then there might be a need to change this.
% chaseFunctionPool('PWR_UP')
%   will power up the AWG if it is connected and powered down. The wavefrom
%   program has to be running in the background. This will not connect to
%   the AWG
% chaseFunctionPool('runChase')
%   will start running the AWG output
% chaseFunctionPool('senSingleCommand',command)
%   will send one commnad to the AWG. The commnad is a string and has to
%   have the correct syntax
% chaseFunctionPool('setClkRate',clkRate)
%   will set the clock rate for the AWG
% chaseFunctionPool('stopChase')
%   will stop the AWG output

global daxDir % directory in which the dax_CMDRunning.txt file is locted the 
              % tmpCmd.txt file should be copied to this directory
              % Please make sure that any changes done to daxDir are made
              % within the scope of this current function!
              % if daxDir= [] then the AWG program is NOT running.
global waveformPath % directory where the waveforms will be saved to
waveformPath= 'C:\MATLAB_Code\mytoolboxes\AWG\Wave_Form';
%daxDir = "C:\MATLAB_Code\mytoolboxes\AWG\Win7_64_bit";
    switch varargin{1}
        % all case statements are in alphabetical order
        case 'createWaveform'
            if length(varargin)<4
                disp('Input arguments invalid!');
                return
            end
            if length(varargin)==4
                filename= fullfile(waveformPath,'sweep.txt');
            elseif length(varargin)==5
                filename= fullfile(waveformPath,varargin{5});
            end
            wave= Wave_generator_Chase(varargin{2},varargin{3},varargin{4});
            fid= fopen(filename,'w');
            fprintf(fid,'%4g\r\n',wave);
            fclose(fid);
            % fprintf('Waveform saved to:\n %s \n',filename);
        case 'createSegStruct'
            if mod(length(varargin)-2,4)~=0
                disp('Input arguments invalid!');
                return
            end
            filename= fullfile(waveformPath,varargin{2});
            fid= fopen(filename,'w');
            for zz = 1:(length(varargin)-2)/4
                if varargin{4*(zz-1)+5} > 65535
                    warning('Loop number exceed the limit 65536.');
                end
                fprintf(fid,'%s %i %i %i\r\n',fullfile(waveformPath,varargin{4*(zz-1)+3}), varargin{4*(zz-1)+4},varargin{4*(zz-1)+5},varargin{4*(zz-1)+6});
            end
            fclose(fid);
        case 'endChase'
            endChase();
            delete('C:\MATLAB_Code\mytoolboxes\AWG\tmpCmd.txt');
            clearvars -global daxDir;
        case 'loadChase'
            daxDir= pwd;
            loadChase();
        case 'loadWaveform'
            if length(varargin)<2
                filename= fullfile(waveformPath,'sweep.txt');
            else
                filename= fullfile(waveformPath,varargin{2});
            end
            loadWaveform(filename);
        case 'PWR_DWN'
            PWR_DWN(varargin{2});
        case 'PWR_UP'
            PWR_UP(varargin{2});
        case 'runChase'
            if length(varargin)<3
                trigger= 'true';
            else
                trigger= varargin{3};
            end
            runChase(varargin{2},trigger);
        case 'sendSingleCommand'
            sendSingleCommand(varargin{2});
        case 'setClkRate'
            if length(varargin)~=3
                clkRate= 1e9;
            else
                clkRate= varargin{3};
            end
            setClkRate(varargin{2},clkRate);
        case 'stopChase'
            stopChase(varargin{2});
        case 'SelExtTrig'
            if length(varargin)~=3
                disp('Input argument invalid');
            else
                trigger = varargin{3};
                SelExtTrig(varargin{2}, trigger);
            end
        case 'CreateSingleSegment'
            if length(varargin)~=9
                disp('Input argument invalid');
            else
               filename= fullfile(waveformPath,varargin{8});
               CreateSingleSegment(varargin{2}, varargin{3}, varargin{4}, varargin{5}, ...
                   varargin{6}, varargin{7},filename, varargin{9})
            end
        case 'CreateSegments'
            if length(varargin)~=8
                disp('Input argument invalid');
            else
                filename= fullfile(waveformPath,varargin{7});
                CreateSegments(varargin{2}, varargin{3}, varargin{4}, varargin{5}, ...
                varargin{6}, filename, varargin{8})
            end
        case 'Initialize'
            if length(varargin)~=2
                disp('Input argument invalid')
            else
                InitializeChase(varargin{2});
            end
        case 'ExtClk10MHzChase'
            if length(varargin)~=3
                disp('Input argument invalid')
            else
                ExtClk10MHzChase(varargin{2},varargin{3});
            end
        case 'SoftTrigger'
            if length(varargin)~=2
                disp('Input argument invalid')
            else
                SoftTrigger(varargin{2});
            end
            
            
        otherwise
            disp('Request Unknown!');
    end
end

function endChase() % have to remember to stop it first
    % Stops the API program running in the back ground and effectively
    % disconnects the device
    global daxDir
    % Kills the session with dax22000 by effectively calling end task
    !Taskkill /im dax22000_GUI_64.exe /f /t 
    % Deletes the file dax_cmd.txt created during the session
    delete(fullfile(daxDir,'DAx_CMD_Running.txt'));
end

function loadChase()
    % NOTE: Only thing you need to edit in the program is where the
    % dax22000_GUI_64.exe file is located!
    % Starts the script API program
    try
        !start "" "C:\MATLAB_Code\mytoolboxes\AWG\Win7_64_bit\dax22000_GUI_64.exe" load_api
        disp('SUCCESS: Connected to Wavepond DAx22000');
    catch ME
        disp('ERROR: Cannot connect to Wavepond');
        rethrow(ME);
    end
end

function loadWaveform(filename)
    global daxDir
    try
        fileID= fopen('C:\MATLAB_Code\mytoolboxes\AWG\tmpCmd.txt','w');
        fprintf(fileID,'%s %s','load',filename);
        fclose(fileID);
        copyfile('C:\MATLAB_Code\mytoolboxes\AWG\tmpCmd.txt',fullfile(daxDir,'dax_cmd.txt'));
    catch ME
        rethrow(ME);
    end
end

function PWR_DWN(cardNum)
    % Powers down the device. A good way to test if you can communicate
    % with the AWG
    global daxDir
    try
        fileID= fopen('C:\MATLAB_Code\mytoolboxes\AWG\tmpCmd.txt','w');
        fprintf(fileID,'%s %i','PWR_DWN',cardNum);
        fclose(fileID);
        copyfile('C:\MATLAB_Code\mytoolboxes\AWG\tmpCmd.txt',fullfile(daxDir,'dax_cmd.txt'));
    catch ME
        rethrow(ME);
    end
end

function PWR_UP(cardNum)
    % Note: this does not power up the device if it is not loaded. This is
    % intentional to enforce a protocol when communicate with the device!
    global daxDir
    if daxDir
        PWR_DWN(cardNum);
        endChase();
        loadChase();
    else
        disp('Device not loaded');
    end
end

function runChase(cardNum,trigger)
    % runs output
    global daxDir
    try
        fileID= fopen('C:\MATLAB_Code\mytoolboxes\AWG\tmpCmd.txt','w');
        fprintf(fileID,'%s %i %s','Run',cardNum,trigger);
        fclose(fileID);
        copyfile('C:\MATLAB_Code\mytoolboxes\AWG\tmpCmd.txt',fullfile(daxDir,'dax_cmd.txt'));
    catch ME
        rethrow(ME);
    end
end

function sendSingleCommand(command)
    % Writes a single command to the AWG
    global daxDir
    try
        fileID= fopen('C:\MATLAB_Code\mytoolboxes\AWG\tmpCmd.txt','w');
        fprintf(fileID,'%s',command);
        fclose(fileID);
        copyfile('C:\MATLAB_Code\mytoolboxes\AWG\tmpCmd.txt',fullfile(daxDir,'dax_cmd.txt'));
    catch ME
        rethrow(ME);
    end
end

function setClkRate(cardNum, clkRate)
    global daxDir
    try
        fileID= fopen('C:\MATLAB_Code\mytoolboxes\AWG\tmpCmd.txt','w');
        fprintf(fileID,'%s %i %g','SetClkRate',cardNum,clkRate);
        fclose(fileID);
        copyfile('C:\MATLAB_Code\mytoolboxes\AWG\tmpCmd.txt',fullfile(daxDir,'dax_cmd.txt'));
    catch ME
        rethrow(ME);
    end
end

function stopChase(cardNum)
    % stops output
    global daxDir
    try
        fileID= fopen('C:\MATLAB_Code\mytoolboxes\AWG\tmpCmd.txt','w');
        fprintf(fileID,'%s %i','Stop',cardNum);
        fclose(fileID);
        pause(0.1);
        copyfile('C:\MATLAB_Code\mytoolboxes\AWG\tmpCmd.txt',fullfile(daxDir,'dax_cmd.txt'));
        pause(0.1);
    catch ME
        rethrow(ME);
    end
end

function SelExtTrig(cardNum, Trigger)
    % stops output
    global daxDir
    try
        fileID= fopen('C:\MATLAB_Code\mytoolboxes\AWG\tmpCmd.txt','w');
        fprintf(fileID,'%s %i %s','SelExtTrig',cardNum, Trigger);
        fclose(fileID);
        copyfile('C:\MATLAB_Code\mytoolboxes\AWG\tmpCmd.txt',fullfile(daxDir,'dax_cmd.txt'));
    catch ME
        rethrow(ME);
    end
end

function CreateSingleSegment(cardNum, ChanNum, NumPoints, NumLoops, PAD_Val_Beg, PAD_Val_End, pUserArrayWORD, Triggered)
    % stops output
    global daxDir
    try
        fileID= fopen('C:\MATLAB_Code\mytoolboxes\AWG\tmpCmd.txt','w');
        fprintf(fileID,'%s %i %i %i %i %i %i %s %i','CreateSingleSegment', cardNum, ChanNum, NumPoints, NumLoops, ...
            PAD_Val_Beg, PAD_Val_End, pUserArrayWORD, Triggered);
        fclose(fileID);
        copyfile('C:\MATLAB_Code\mytoolboxes\AWG\tmpCmd.txt',fullfile(daxDir,'dax_cmd.txt'));
    catch ME
        rethrow(ME);
    end
end

function CreateSegments(cardNum, ChanNum, SegNum, PAD_Val_Beg, PAD_Val_End, pUserArrayWORD, loop)
    % stops output
    global daxDir
    try
        fileID= fopen('C:\MATLAB_Code\mytoolboxes\AWG\tmpCmd.txt','w');
        fprintf(fileID,'%s %i %i %i %i %i %s %s','CreateSegments', cardNum, ChanNum, SegNum, ...
            PAD_Val_Beg, PAD_Val_End, pUserArrayWORD, loop);
        fclose(fileID);
        copyfile('C:\MATLAB_Code\mytoolboxes\AWG\tmpCmd.txt',fullfile(daxDir,'dax_cmd.txt'));
    catch ME
        rethrow(ME);
    end
end

function InitializeChase(cardNum)
    % Initialize AWG
    global daxDir
    try
        fileID= fopen('C:\MATLAB_Code\mytoolboxes\AWG\tmpCmd.txt','w');
        fprintf(fileID,'%s %i','Initialize',cardNum);
        fclose(fileID);
        copyfile('C:\MATLAB_Code\mytoolboxes\AWG\tmpCmd.txt',fullfile(daxDir,'dax_cmd.txt'));
    catch ME
        rethrow(ME);
    end
end

function ExtClk10MHzChase(cardNum, Enable)
    % enable/disable (1/0) external 10MHz clock
    global daxDir
    try
        fileID= fopen('C:\MATLAB_Code\mytoolboxes\AWG\tmpCmd.txt','w');
        fprintf(fileID,'%s %i %i','Ext10MHz',cardNum, Enable);
        fclose(fileID);
        copyfile('C:\MATLAB_Code\mytoolboxes\AWG\tmpCmd.txt',fullfile(daxDir,'dax_cmd.txt'));
    catch ME
        rethrow(ME);
    end
end

function SoftTrigger(cardNum)
% Apply a soft trigger.
    global daxDir
    try
        fileID = fopen('C:\MATLAB_Code\mytoolboxes\AWG\tmpCmd.txt', 'w');
        fprintf(fileID,'%s %i', 'SoftTrigger', cardNum);
        fclose(fileID);
        copyfile('C:\MATLAB_Code\mytoolboxes\AWG\tmpCmd.txt', fullfile(daxDir, 'dax_cmd.txt'));
    catch ME
        rethrow(ME);
    end
end