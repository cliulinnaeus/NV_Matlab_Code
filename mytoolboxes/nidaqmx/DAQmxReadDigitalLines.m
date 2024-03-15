function [status] = DAQmxReadDigitalLines(taskHandle, numSampsPerChan,...
    timeout, bfillMode, readArray, arraySizeInBytes, sampsPerChanRead, numBytesPerSamp);

[status, param1, param2] = calllib('mynidaqmx','DAQmxReadDigitalLines',taskHandle, numSampsPerChan,...
    timeout, bfillMode, readArray, arraySizeInBytes, sampsPerChanRead, numBytesPerSamp,[]);

status, param1, param2