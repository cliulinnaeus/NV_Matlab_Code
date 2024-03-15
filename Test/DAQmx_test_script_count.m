
%  chan /dev1/ctr0
%  gate /dev1/PFI4
%  source /Dev1/20MHzTimebase
DAQmx_Val_Volts= 10348; % measure volts
DAQmx_Val_Rising = 10280; % Rising
DAQmx_Val_FiniteSamps = 10178; % Finite Samples
DAQmx_Val_CountUp = 10128; % Count Up
DAQmx_Val_CountDown = 10124; % Count Down
DAQmx_Val_GroupByChannel = 0; % Group per channel
DAQmx_Val_ContSamps =10123; % Continuous Samples
DAQmx_Val_DigLvl = 10152;
DAQmx_Val_Low=10214;
timeout=1;
data=5;
data2=5;

LoadNIDAQmx;
[ status, TaskName, task ] = DAQmxCreateTask([]);
[ status, TaskName, task2 ] = DAQmxCreateTask([]);

if status,
disp(['NI: Create Counter Task  :' num2str(status)]);
end

status = DAQmxCreateCICountEdgesChan(task,'Dev1/ctr0','',...
    DAQmx_Val_Rising , 0, DAQmx_Val_CountUp);
status = DAQmxCreateCICountEdgesChan(task2,'Dev1/ctr1','',...
    DAQmx_Val_Rising , 0, DAQmx_Val_CountUp);

if status,
disp(['NI: Create Counter       :' num2str(status)]);
end

status = calllib('mynidaqmx','DAQmxSetCICountEdgesTerm',...
    task, 'Dev1/ctr0', '/Dev1/PFI8'); 
status = calllib('mynidaqmx','DAQmxSetCICountEdgesTerm',...
    task2, 'Dev1/ctr1', '/Dev1/PFI8'); 
status = calllib('mynidaqmx','DAQmxSetPauseTrigType',...
    task,DAQmx_Val_DigLvl); 
status = calllib('mynidaqmx','DAQmxSetPauseTrigType',...
    task2,DAQmx_Val_DigLvl); 
status = calllib('mynidaqmx','DAQmxSetDigLvlPauseTrigSrc',...
    task, '/Dev1/PFI9'); 
status = calllib('mynidaqmx','DAQmxSetDigLvlPauseTrigSrc',...
    task2, '/Dev1/PFI4'); 
status = calllib('mynidaqmx','DAQmxSetDigLvlPauseTrigWhen',...
    task, DAQmx_Val_Low);
status = calllib('mynidaqmx','DAQmxSetDigLvlPauseTrigWhen',...
    task2, DAQmx_Val_Low); 

status = DAQmxStartTask(task);  DAQmxErr(status);
status = DAQmxStartTask(task2);  DAQmxErr(status);

DAQmxWaitUntilTaskDone(task,3);

[status, data] = calllib('mynidaqmx','DAQmxReadCounterScalarU32',...
task, timeout,data,[]); 
[status, data2] = calllib('mynidaqmx','DAQmxReadCounterScalarU32',...
task2, timeout,data2,[]); 
DAQmxStopTask(task);
DAQmxStopTask(task2);
DAQmxClearTask(task);
DAQmxClearTask(task2);