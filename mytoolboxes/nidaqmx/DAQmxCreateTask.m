function [status, taskname, taskhandle] = DAQmxCreateTask(taskname)

[status,taskname,taskhandle] = calllib('mynidaqmx','DAQmxCreateTask',taskname,uint32(1));
