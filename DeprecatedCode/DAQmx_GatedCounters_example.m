% Here's an example of using two gated counters.
wait=3; %the integration time

[ status, ~, signal ] = DAQmxCreateTask([]);

if status
disp(['NI: Create Counter Task  :' num2str(status)]);
end

[ status, ~, reference ] = DAQmxCreateTask([]);

if status
disp(['NI: Create Counter Task  :' num2str(status)]);
end

DAQmxFunctionPool('SetTwoGatedCounters',signal,reference,wait); 
% the function assumes that you are using the following configuration:
% counter input on ctr0 src, signal gate on ctr0 gate, reference gate on
% ctr1 gate. This can be reconfigured by using the mapping found here:
% http://zone.ni.com/reference/en-XX/help/370466W-01/mxdevconsid/xseriesphychannels/


sigDatum=DAQmxFunctionPool('ReadCounterScalar',signal); % outputs a single point

refDatum=DAQmxFunctionPool('ReadCounterScalar',reference);

