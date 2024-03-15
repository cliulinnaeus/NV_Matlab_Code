function status = DAQmxWaitUntilTaskDone(taskHandle, timeToWait)

[status]=calllib('mynidaqmx','DAQmxWaitUntilTaskDone',taskHandle, timeToWait);



