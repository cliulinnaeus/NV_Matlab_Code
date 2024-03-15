function status = DAQmxSetAnlgEdgeStartTrigHyst(taskHandle, hysteresis)

[status]=calllib('mynidaqmx','DAQmxSetAnlgEdgeStartTrigHyst',taskHandle, hysteresis);



