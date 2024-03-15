function status = DAQmxStopTask(task)

[status]=calllib('mynidaqmx','DAQmxStopTask',task);
