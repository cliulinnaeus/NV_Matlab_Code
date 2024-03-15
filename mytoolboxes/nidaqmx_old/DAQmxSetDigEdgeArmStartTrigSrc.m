function status = DAQmxSetDigEdgeArmStartTrigSrc(taskHandle, data)

status = calllib('mynidaqmx','DAQmxSetDigEdgeArmStartTrigSrc',...
    taskHandle, data);