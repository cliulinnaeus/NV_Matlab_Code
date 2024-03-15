function [status, task] = DAQmxWriteAnalogScalarF64(task,bAutoStart,WaitSec,Scalar)

[status,task]=calllib('mynidaqmx','DAQmxWriteAnalogScalarF64',task,bAutoStart,WaitSec,Scalar,[]);
