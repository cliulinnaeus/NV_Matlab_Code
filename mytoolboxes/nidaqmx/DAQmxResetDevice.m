function status = DAQmxResetDevice(Device)

status = calllib('mynidaqmx','DAQmxResetDevice',Device);

