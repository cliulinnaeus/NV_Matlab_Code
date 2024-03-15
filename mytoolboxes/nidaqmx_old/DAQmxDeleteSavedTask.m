function DAQmxDeleteSavedTask(taskname)

[status] = calllib('mynidaqmx','DAQmxDeleteSavedTask',taskname);

