function [status] = DAQmxSetSampClkRate(taskHandle, data)

[status]=calllib('mynidaqmx','DAQmxSetSampClkRate', taskHandle, data);

