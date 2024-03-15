function [status, readArray] = DAQmxReadAnalogF64(taskHandle, numSampsPerChan, timeout, fillmode, readArray, arraySizeInSamps, sampsPerChanRead, reserved)

[status,readArray] = calllib('mynidaqmx','DAQmxReadAnalogF64',taskHandle, ...
    numSampsPerChan, timeout, fillmode, readArray, arraySizeInSamps, sampsPerChanRead, []);