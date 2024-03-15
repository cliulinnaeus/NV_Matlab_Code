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