
%  chan /dev1/ctr0
%  gate /dev1/PFI4
%  source /Dev1/20MHzTimebase
DAQmx_Val_RSE=10083;
DAQmx_Val_Volts= 10348; % measure volts
DAQmx_Val_Rising = 10280; % Rising
DAQmx_Val_FiniteSamps = 10178; % Finite Samples
DAQmx_Val_CountUp = 10128; % Count Up
DAQmx_Val_CountDown = 10124; % Count Down
DAQmx_Val_GroupByChannel = 0; % Group per channel
DAQmx_Val_ContSamps =10123; % Continuous Samples
DAQmx_Val_DigLvl = 10152;
DAQmx_Val_Low=10214;
data=5;
data2=5;

LoadNIDAQmx;
try
    [ status, TaskName, task ] = DAQmxCreateTask([]);

    if status
    disp(['NI: Create Task  :' num2str(status)]);
    end

    status = DAQmxCreateAIVoltageChan(task,'Dev1/ai0','',...
        DAQmx_Val_RSE, -5,5, DAQmx_Val_Volts,[]);

    if status
    disp(['NI: Create Counter       :' num2str(status)]);
    end

    % status = calllib('mynidaqmx','DAQmxSetPauseTrigType',...
    %     task,DAQmx_Val_DigLvl); 
    % DAQmxErr(status);
    % status = calllib('mynidaqmx','DAQmxSetDigLvlPauseTrigSrc',...
    %     task, '/Dev1/PFI9'); 
    % DAQmxErr(status);
    % status = calllib('mynidaqmx','DAQmxSetDigLvlPauseTrigWhen',...
    %     task, DAQmx_Val_Low);
    % DAQmxErr(status);
    frequency=500000; %this is probably something like 1/(tmax/gmSEQ.ctrN/1e9)?? or maybe this defines the integration time, in which case you would want min(500000, 1/(gmSEQ.CtrDur/1e9)).
    samples=10000;
    timeout=3;
    status = DAQmxCfgSampClkTiming(task,'/Dev1/PFI9',frequency,DAQmx_Val_Rising,DAQmx_Val_FiniteSamps,samples); % ctr0 gate
    DAQmxErr(status);
    status = DAQmxStartTask(task);  DAQmxErr(status);
    sampsPerChanRead = libpointer('int32Ptr',0);
    readArray = zeros(1,samples);
    [status, readArray]=DAQmxReadAnalogF64(task,samples,timeout,DAQmx_Val_GroupByChannel,readArray,samples,sampsPerChanRead,[]);
    DAQmxErr(status);
catch ME
    DAQmxStopTask(task);
    DAQmxClearTask(task);
    rethrow(ME);
end
DAQmxStopTask(task);
DAQmxClearTask(task);
plot(readArray(1:1000))