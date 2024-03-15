function CrudeESR(startFreq,stopFreq,points,dBm,dt)
LoadNIDAQmx;
global hCPS gSG;
fopen(gSG.serial);


NRead = 20;
dt=dt/NRead;
TimeOut = dt * NRead * 1.1;
Freq = 1/dt;


hCounter = SetCounter(NRead+1);
[~, hPulse] = DigPulseTrainCont(Freq,0.5,10000);

hCPS.hCounter = hCounter;
hCPS.hPulse = hPulse;

vec=startFreq:(stopFreq-startFreq)/(points-1):stopFreq;
for i=1:points
    WriteSG(gSG.serial,1,vec(i),dBm);
    status = DAQmxStartTask(hCounter);  DAQmxErr(status);
    status = DAQmxStartTask(hPulse);    DAQmxErr(status);

    DAQmxWaitUntilTaskDone(hCounter,TimeOut);

    DAQmxStopTask(hPulse);

    A = ReadCounter(hCounter,NRead+1);
    DAQmxStopTask(hCounter);
    A = diff(A);
    f(i)=sum(A)/(NRead * dt);
end
DAQmxClearTask(hPulse);
DAQmxClearTask(hCounter);
%WriteSG(sg,stopFreq,dBm,0);
fclose(gSG.serial);
figure
plot(vec,f)

function task = SetCounter(N)
DAQmx_Val_Volts= 10348; % measure volts
DAQmx_Val_Rising = 10280; % Rising
DAQmx_Val_FiniteSamps = 10178; % Finite Samples
DAQmx_Val_CountUp = 10128; % Count Up
DAQmx_Val_CountDown = 10124; % Count Down
DAQmx_Val_GroupByChannel = 0; % Group per channel
DAQmx_Val_ContSamps =10123; % Continuous Samples

[ status, TaskName, task ] = DAQmxCreateTask([]);

if status,
disp(['NI: Create Counter Task  :' num2str(status)]);
end
status = DAQmxCreateCICountEdgesChan(task,'Dev1/ctr0','',...
    DAQmx_Val_Rising , 0, DAQmx_Val_CountUp);

if status,
disp(['NI: Create Counter       :' num2str(status)]);
end
status = DAQmxCfgSampClkTiming(task,'/Dev1/PFI13',1.0,...
    DAQmx_Val_Rising,DAQmx_Val_FiniteSamps ,N);
if status,
disp(['NI: Cofigure the Clk     :' num2str(status)]);
end

function readArray = ReadCounter(task,N)
numSampsPerChan = N;
timeout = 0;
%readArray = libpointer('int64Ptr',zeros(1,N));
readArray = zeros(1,N);
arraySizeInSamps = N;
sampsPerChanRead = libpointer('int32Ptr',0);

[status, readArray]= DAQmxReadCounterF64(task, numSampsPerChan,...
    timeout, readArray, arraySizeInSamps, sampsPerChanRead );