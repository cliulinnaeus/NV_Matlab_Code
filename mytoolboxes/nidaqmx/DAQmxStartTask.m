function status = DAQmxStartTask(task)

status = calllib('mynidaqmx','DAQmxStartTask',task);
