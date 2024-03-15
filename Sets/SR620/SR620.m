classdef SR620 < handle
    % Universal time interval counter, model SR620
    
    properties
        % Instrumental
        ni_ref; % NI VISA reference address of this object
        visa; % Reference to visa object created to talk to instrument
        
        % Experiment run
        numSample; % Number of samples to be taken
        g2Go; % Boolean for whether or not a measurement is being taken
        %cabletest; % Boolean, true if it's a cable test
        countsMeasure; % Boolean, true if want to measure counts instead of intervals
        lastFile; % String of the last filename saved by g2Measure
        currentFile; % Filename of last file in which measurements have been stored
        
        % Tracking parameters
        measureAtOnce; % How many measurements are taken at a time, if numSample exceeds this
        minTime; % If done taking a group of measurements and exceed this time, do a track
        minTrack; % If took this many measurements since last track, do a track
        
        % Plot settings and attributes
        minInterval; % For histogram, minimum of plot
        maxInterval; % For histogram, maximum of plot
        binSize; % For histogram, bin width
        edges; % For histogram, histogram edges
        currentData; % For histogram, stores the data it's plotting in case plot needs updating
    end
    
    methods     
        function obj = SR620(ref)
            % Instance initializing method
            obj.ni_ref = ref;
            obj.visa = instrfind({'Type','ModelCode'},{'visa-usb','0x2200'});
            if isempty(obj.visa)
                obj.visa = visa('ni',ref);
            else
                fclose(obj.visa);
                obj.visa = visa('ni',ref);
            end
            
            % Show IDN and set clock
            obj.IDN();
            obj.setClock();
            
            % Set default values
            obj.numSample = 1E4; % Default samples for a measurement
            obj.g2Go = false; % At start-up, not taking a measurement
            %obj.cabletest = false; % By default, it's not a cable test
            obj.countsMeasure = false; % By default, not measuring counts
            obj.minInterval = -50; % For histogram, minimum of plot (ns)
            obj.maxInterval = 50; % For histogram, maximum of plot (ns)
            obj.binSize = 1; % For histogram, bin width (ns)
            obj.edges = obj.minInterval:obj.binSize:obj.maxInterval-obj.binSize;
            obj.measureAtOnce = 2E4;
            obj.minTime = 60;
            obj.minTrack = 1E5;
            
            % Create figure
            %obj.fig = figure();
            %obj.ax = axes(obj.fig);
            
            % Set default instrumental settings
            obj.open();
            fprintf(obj.visa, 'TSLP 1,0; TSLP 2,0');
            fprintf(obj.visa, 'LEVL 1,3.3; LEVL 2,3.3');
            obj.close();
            
            % Setup tracking
            %global gmSEQ
        end
        
        function IDN(obj)
            % Identify device
            if obj.open('IDN')
                return;
            end
            msg= query(obj.visa, '*IDN?');
            if isempty(msg)
                warning('Unable to query at port %s', obj.visa.Name);
            else
                disp(msg);
            end
            obj.close();
        end
        
        % Send a command to instrument
        function write(obj, command)
            fprintf(obj.visa, command);
        end
        
        % Sets the clock source for the SR620.
        function setClock(obj)
            % Set clock to internal
            if obj.open('setClock')
                return;
            end
            fprintf(obj.visa, 'CLCK 0');
            clck = query(obj.visa, 'CLCK?');
            disp('Clock setting is now:')
            disp(clck)
            obj.close()
        end
        
        function err = open(obj,callingFcn)
            % fopens object if closed
            % Does not fopen object if open to avoid disrupting active call
            switch obj.visa.Status
                case 'open'
                    err = 1;
                    warning('Device open. %s will not execute.',callingFcn);
                case 'closed'
                    fopen(obj.visa);
                    err = 0;
            end
        end
        
        function close(obj)
            % fclose if object is open, do nothing otherwise
            switch obj.visa.Status
                case 'open'
                    fclose(obj.visa);
                case 'closed'
                    return;
            end
        end
        
        function set_numSamples(obj,entry)
            % Set number of samples to be taken
            invalid = isnan(str2double(entry));
            
            if invalid
                % If a number is not provided put 10000 as a default value.
                entry = '1E4';
                disp('Invalid sample number given. 10000 samples chosen by default.')
            end
            
            %samples = str2double(entry);
            obj.numSample = str2double(entry);
            disp('Number of samples to be taken:')
            disp(entry)
        end
        
        function g2Measure(obj, samples)%, test)
            % Function to measure g2
            % samples is the number of samples to be taken
            % test is true if you're doing a cable test. If true, do
            % ARMM 1 instead of ARMM 0
            obj.open();
            
            % Set measurement variable to true for duration of measurement
            obj.g2Go = true;
            
            % Set up tracking
            global gmSEQ
            gmSEQ.bTrack=1;
            % If counts tickbox is checked, measure counts instead
            %if obj.countsMeasure
            %    fprintf(obj.visa, 'MODE 6');
            %else
            %    fprintf(obj.visa, 'MODE 0');
            %end

            % Set SR620 to time mode and set channels START=A, STOP=B
            fprintf(obj.visa, 'SRCE 0');

            % Check if user specified this was a cable test and act
            % accordingly
            %if test
            %    fprintf(obj.visa, 'ARMM 1');
            %else
            %    fprintf(obj.visa, 'ARMM 0');
            %end
            
            % Wait until these commands have been executed before
            % proceeding
            fprintf(obj.visa,'*WAI');
            
            % Set sample number
            obj.set_numSamples(samples);
            
            % Start measurements
            tic
            disp('== Starting measurements ==')
            
            collected = 0;
            collectedSinceTrack = 0;
            % The first call to ImageFunctionPool is different than the
            % others
            firstRun = true;
            if obj.numSample > obj.measureAtOnce
                filename = '';
                
                % Alter timeout and input buffer size
                obj.close();
                obj.visa.Timeout = 60;
                obj.visa.InputBufferSize = 8 * obj.measureAtOnce + 1;
                itNum = 1;
                obj.open();
                
                % Measure
                while obj.g2Go && obj.numSample > 0
                    % Data is collected obj.measureAtOnce points at a time to reduce
                    % the probability of timeouts
                    if obj.numSample > obj.measureAtOnce
                        fprintf(obj.visa, 'BDMP%d', obj.measureAtOnce);
                        % BDMP is run with obj.measureAtOnce but we collect twice that
                        % because half of output is EOIs
                        raw = fread(obj.visa, 2 * obj.measureAtOnce, 'int');
                    else
                        fprintf(obj.visa, 'BDMP%d', obj.numSample);
                        raw = fread(obj.visa, 2 * obj.numSample, 'int');
                    end
                
                    % Convert raw to data
                    data = obj.convertData(raw);
                    
                    msg = ['Iteration ', num2str(itNum), ': Collected 20000 data points'];
                    disp(msg)

                    %if ~strcmp(filename, '') && addToPrevious
                    %    % Append g2 data to file if not
                    %    obj.g2Append(data, obj.lastFile);
                    %elseif addToPrevious
                    %    warning('No previous filename detected. Writing new data file.')
                    %    addToPrevious = false;
                    %    obj.lastFile = obj.g2Store(data, obj.numSample);
                    %else
                        
                    % Create new data file for storing first batch of data
                    if strcmp(filename, '')
                        filename = obj.g2Store(data, obj.numSample);
                    else
                        obj.g2Append(data, filename);
                    end

                    % Decrease number of samples, since we have just taken
                    % 20000 of them
                    obj.numSample = obj.numSample - obj.measureAtOnce;
                    collected = collected + obj.measureAtOnce;
                    collectedSinceTrack = collectedSinceTrack + obj.measureAtOnce;
                    itNum = itNum + 1;

                    if ~obj.g2Go
                        warning('g2 measurement halted.')
                        break;
                    end
                    
                    if (collectedSinceTrack > obj.minTrack) || (toc > obj.minTime)
                        toc
                        if firstRun
                            gmSEQ.refCounts = obj.Track('Init');
                            firstRun = false;
                        else
                           gmSEQ.refCounts = obj.Track('Run'); 
                        end
                        disp('Stop here. This is where you track.')
                        collectedSinceTrack = 0;
                        tic
                    end
                end
            else                
                % Alter timeout and input buffer size
                obj.close();
                obj.visa.Timeout = 60;
                obj.visa.InputBufferSize = 8 * obj.numSample + 1;
                obj.open();
                
                % Measure
                fprintf(obj.visa, 'BDMP%d', obj.numSample);
                
                % Binary dump mode is supposed to send 8 byte two's complement integers.
                % fread should be able to preserve the sign of the time intervals
                raw = fread(obj.visa, 2 * obj.numSample, 'int');
                
                data = obj.convertData(raw);

                obj.g2Store(data, obj.numSample);
            end
            %fprintf(obj.visa, 'MODE 0');
            obj.close()
            toc
        end
        
        function g2Stop(obj)
            obj.g2Go = false;
            disp('Stop button pressed.')
        end
        
        % =================================================================
        % Plotting functions
        % =================================================================
        function hist = g2Calculate(obj)
            % Function to generate a histogram of the data
            % (prompts user for a file)
            now = clock;
            date = [num2str(now(1)), '-', num2str(now(2)), '-', num2str(round(now(3)))];
            fullPath = fullfile('C:\Data\', date, '\');
            if ~exist(fullPath, 'dir')
                mkdir(fullPath);
            end
            [baseName,folder] = uigetfile([fullPath, '*.*']);
            filename = fullfile(folder, baseName);
            
            fid = fopen(filename,'r');
            obj.currentData = fscanf(fid,'%f');
            fclose(fid);
            
            hist = obj.g2Hist(obj.currentData);
        end
        
        function hist = g2Hist(obj, data)
            % Produces a histogram (called in g2Calculate)
            %cla(obj.ax)
            
            if isnan(obj.edges)
                hist = histogram(data / 1e-9);
                xlabel('Time (ns)');
                ylabel('Counts');
            else
                hist = histogram(data / 1e-9, obj.edges);
                xlabel('Time (ns)');
                ylabel('Counts');
            end
        end
        
        function getBinEdges(obj)
            % Generates bin edges
            obj.edges = obj.minInterval:obj.binSize:obj.maxInterval-obj.binSize;
        end
        
        function data = convertData(obj, raw)
            % Necessary conversion factor given on page 34 of SR620m manual
            if obj.countsMeasure
                timeFactor = 1 / 256;
            else
                timeFactor = 2.712673611111111E-12 / 256;
            end
            
            % Remove EOIs
            filtered = raw(1:2:end);
            data = filtered * timeFactor;
        end
        

        
        
        
        
        
        
        
        
        
        
    end
    
    methods(Static)
        
        function g2Append(data, file)
            fid = fopen(file,'at+');
            fprintf(fid,'%e\n',data);
            fclose(fid);
        end
       
        function file = g2Store(data, samples)
            now = clock;
            date = [num2str(now(1)), '-', num2str(now(2)), '-', num2str(round(now(3)))];
            
            fullPath=fullfile('C:\Data\', date, '\');
            if ~exist(fullPath, 'dir')
                mkdir(fullPath);
            end
            
            %Create a filename for text file where g2 data will be stored.
            time = datestr(datetime);
            filename = strcat('g2_', time, '_', num2str(samples), '_samples','.txt');
            
            %Remove whitespace and colons that cause problems in the file name
            filename = strrep(filename, ' ', '_');
            filename = strrep(filename, ':', '_');

            file = strcat(fullPath, filename);
            fid = fopen(file, 'wt+');
            fprintf(fid, '%e\n', data);
            fclose(fid);
        end
       
        function refCounts = Track(what)
            global gmSEQ gScan
            if gmSEQ.bTrack
                 % get the handle of Gui1
                 h = findobj('Tag','ImageNVCGUI');

                 % if exists (not empty)
                 if ~isempty(h)
                    % get handles and other user-defined data associated to Gui1
                    handles_ImageNVC = guidata(h);
                 end

                PBFunctionPool('PBON',2^SequencePool('PBDictionary','AOM'));
                currentCounts = ImageFunctionPool('RunCPSOnce',0, 0, handles_ImageNVC);
            else
                refCounts=0;
                return
            end
            switch what
                case 'Init'
                    refCounts=currentCounts;
                    gmSEQ.trackCoords=[];
                    return
                case 'Run'
                    if currentCounts<.9*gmSEQ.refCounts
                        PBFunctionPool('PBON',2^SequencePool('PBDictionary','AOM'));
                        for i=1:2
                            currentCounts = ImageFunctionPool('NewTrackFast',0, 0, handles_ImageNVC);
                            drawnow;
                            if gmSEQ.bGo==0
                                refCounts=currentCounts;
                                return
                            end
                        end
                        %if ~isfield(gmSEQ,'bLiO')
                        %    ExperimentFunctionPool('PBOFF',0, 0, handles_ImageNVC);
                        %end
                        if currentCounts<.7*gmSEQ.refCounts
                            % end code, close all devices
                            error('Tracking failed! Aborting...')
                        end
                        refCounts=currentCounts;
                    else
                        refCounts=gmSEQ.refCounts;
                        gmSEQ.trackCoords=[gmSEQ.trackCoords; gScan.FixVx gScan.FixVy gScan.FixVz];
                    end
            end
        end
        
    end
end

