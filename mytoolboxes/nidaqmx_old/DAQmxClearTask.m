function [ status ] = DAQmxClearTask(taskhandle)

[status] = calllib('mynidaqmx','DAQmxClearTask',taskhandle);

