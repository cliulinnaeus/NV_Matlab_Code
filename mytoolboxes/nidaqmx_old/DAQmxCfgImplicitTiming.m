function [status] = DAQmxCfgImplicitTiming(taskHandle, sampleMode, sampsPerChanToAcquire)

[status] = calllib('mynidaqmx','DAQmxCfgImplicitTiming',...
    taskHandle, sampleMode, sampsPerChanToAcquire);
