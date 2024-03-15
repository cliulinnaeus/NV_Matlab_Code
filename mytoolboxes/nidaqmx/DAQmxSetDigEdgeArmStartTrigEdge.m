function status = DAQmxSetDigEdgeArmStartTrigEdge(taskHandle, data)

status = calllib('mynidaqmx','DAQmxSetDigEdgeArmStartTrigEdge',...
    taskHandle, data);