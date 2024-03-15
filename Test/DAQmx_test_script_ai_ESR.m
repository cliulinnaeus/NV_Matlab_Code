ESRstart=2.77;
ESRstop=2.97;
carrier=(ESRstop+ESRstart)/2;
dev=(ESRstop-ESRstart)/2;
N=121;
ESRupdate=.1; % integration time
timeout=max(ESRupdate*1.1,1);
sweepFreq=60; %hz, don't go above ~1 kHz

SweepTrigVecA=-1:(2/(N-1)):1;
SweepTrigVec=[SweepTrigVecA fliplr(SweepTrigVecA)];

SweepTrigVec=repmat(SweepTrigVec,1,ceil(sweepFreq*ESRupdate/2));
Ntot=length(SweepTrigVec);

%  chan /dev1/ctr0
%  gate /dev1/PFI4
%  source /Dev1/20MHzTimebase
DAQmx_Val_RSE=10083;
DAQmx_Val_Volts= 10348; % measure volts
DAQmx_Val_Rising = 10280; % Rising
DAQmx_Val_Falling = 10171; % Falling
DAQmx_Val_FiniteSamps = 10178; % Finite Samples
DAQmx_Val_CountUp = 10128; % Count Up
DAQmx_Val_CountDown = 10124; % Count Down
DAQmx_Val_GroupByChannel = 0; % Group per channel
DAQmx_Val_ContSamps =10123; % Continuous Samples
DAQmx_Val_DigLvl = 10152;
DAQmx_Val_Low=10214;

LoadNIDAQmx;
try
    %%%%% Pulse Train %%%%%
    [status, hPulse] = DigPulseTrainCont(N*sweepFreq,0.5,Ntot);
    DAQmxErr(status);
    %%%%% Analog write %%%%
    [ status, ~, hScan ] = DAQmxCreateTask([]);
    DAQmxErr(status);
    status = DAQmxCreateAOVoltageChan(hScan,'Dev1/ao2',-5,5,DAQmx_Val_Volts);
    DAQmxErr(status);
    status = DAQmxCfgSampClkTiming(hScan,'/Dev1/PFI13',N*sweepFreq,...
        DAQmx_Val_Rising,DAQmx_Val_FiniteSamps,Ntot);
    DAQmxErr(status);
    zero_ptr = libpointer('int32Ptr',zeros(1,Ntot));
    status = DAQmxWriteAnalogF64(hScan, Ntot, 0, 10,...
        DAQmx_Val_GroupByChannel, SweepTrigVec, zero_ptr);
    DAQmxErr(status);
    %%%%% Analog read %%%%%
    [ status, ~, hRead ] = DAQmxCreateTask([]);

    DAQmxErr(status);

    status = DAQmxCreateAIVoltageChan(hRead,'Dev1/ai0','',...
        DAQmx_Val_RSE, -5,5, DAQmx_Val_Volts,[]);

    DAQmxErr(status);
    status = DAQmxCfgSampClkTiming(hRead,'/Dev1/PFI13',N*sweepFreq,DAQmx_Val_Rising,DAQmx_Val_FiniteSamps,Ntot); %ctr1 out
    DAQmxErr(status);
    
    %%%%% Begin %%%%%
    status = DAQmxStartTask(hRead);  DAQmxErr(status);
    status = DAQmxStartTask(hScan);  DAQmxErr(status);
    status = DAQmxStartTask(hPulse); DAQmxErr(status);
    
    sampsPerChanRead = libpointer('int32Ptr',0);
    RawData = zeros(1,Ntot);
    [status, RawData]=DAQmxReadAnalogF64(hRead,Ntot,timeout,DAQmx_Val_GroupByChannel,RawData,Ntot,sampsPerChanRead,[]);
    DAQmxErr(status);
    
    data=zeros(1,N);
    RawData=reshape(RawData,[N ESRupdate*sweepFreq]);
    RawData(:,2:2:(ESRupdate*sweepFreq))=flipud(RawData(:,2:2:(ESRupdate*sweepFreq)));
    for i=1:N
        data(i)=sum(RawData(i,:))/(ESRupdate*sweepFreq);
    end
    
catch ME
    DAQmxStopTask(hRead);
    DAQmxClearTask(hRead);
    DAQmxStopTask(hScan);
    DAQmxClearTask(hScan);
    DAQmxStopTask(hPulse);
    DAQmxClearTask(hPulse);
    rethrow(ME);
end
DAQmxStopTask(hRead);
DAQmxClearTask(hRead);
DAQmxStopTask(hScan);
DAQmxClearTask(hScan);
DAQmxStopTask(hPulse);
DAQmxClearTask(hPulse);
plot(data)

