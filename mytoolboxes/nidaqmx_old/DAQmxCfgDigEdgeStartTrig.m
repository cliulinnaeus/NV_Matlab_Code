function status = DAQmxCfgDigEdgeStartTrig(taskHandle, triggerSource, triggerEdge )

status = calllib('mynidaqmx','DAQmxCfgDigEdgeStartTrig',...
    taskHandle, triggerSource, triggerEdge);
