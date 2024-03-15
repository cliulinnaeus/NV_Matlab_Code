function [status, rate] = DAQmxGetSampClkRate(taskHandle)

data = 1;
[status, rate]=calllib('mynidaqmx','DAQmxGetSampClkRate', taskHandle, data);

