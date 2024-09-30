function KillAllTasks
global hCPS
if isfield(hCPS,'hPulse')
    DAQmxStopTask(hCPS.hPulse);  DAQmxClearTask(hCPS.hPulse);
end
if isfield(hCPS,'hCounter')
    DAQmxStopTask(hCPS.hCounter);
    DAQmxClearTask(hCPS.hCounter);
end
if isfield(hCPS,'hScan')
    DAQmxStopTask(hCPS.hScan);
    DAQmxClearTask(hCPS.hScan);
end
if isfield(hCPS,'hCounterPD0')
    DAQmxStopTask(hCPS.hCounterPD0);
    DAQmxClearTask(hCPS.hCounterPD0);
end
if isfield(hCPS,'hCounterPD1')
    DAQmxStopTask(hCPS.hCounterPD1);
    DAQmxClearTask(hCPS.hCounterPD1);
end