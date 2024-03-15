function status = DAQmxCfgAnlgEdgeStartTrig(taskHandle, triggerSource, triggerSlope, triggerLevel )

status = calllib('mynidaqmx','DAQmxCfgAnlgEdgeStartTrig',...
    taskHandle, triggerSource, triggerSlope, triggerLevel);
