function varargout = DAQmxFunctionPool(varargin)

switch varargin{1}
    case 'GetCounts'
        %[meanCounts, stdCOunts] = GetCounts(SamplingFreq,Samples);
        [varargout{1},varargout{2}] = GetCounts(varargin{2},varargin{3});
    case 'WriteVoltage'
        %[varargout{1}] = WriteVoltage(Device,Voltage);
        [varargout{1}] = WriteVoltage(varargin{2},varargin{3});
    case 'WriteVoltages'
        [varargout{1}] = WriteVoltages(varargin{2},varargin{3});
    case 'CreateAIChannel'
        [varargout{1},varargout{2}] = CreateAIChannel(varargin{2},varargin{3},varargin{4});
    case 'ReadVoltageScalar'
        [varargout{1}] = ReadVoltageScalar(varargin{2});
    case 'WriteDigitalChannel'
        WriteDigitalChannel(varargin{2},varargin{3});
    case 'ReadDigitalChannel'
        ReadDigitalChannel(varargin{2});
    case 'SetGatedCounter'
        SetGatedCounter(varargin{2},varargin{3},varargin{4},varargin{5});
    case 'SetGatedNCounter'
        [varargout{1},varargout{2}] = SetGatedNCounter(varargin{2});
    case 'ReadCounterScalar'
        [varargout{1},varargout{2}] = ReadCounterScalar(varargin{2});
    case 'WriteAnalogVoltage'
        [varargout{1},varargout{2}] = WriteAnalogVoltage(varargin{2},varargin{3},varargin{4},varargin{5});
    case 'ReadAnalogVoltage'
        [varargout{1},varargout{2}] = ReadAnalogVoltage(varargin{2},varargin{3},varargin{4});
    case 'SetCounter'
        [varargout{1},varargout{2}] = SetCounter(varargin{2});
    otherwise
        disp('DAQmxFunctionPool - I dont get it!');
end

function ReadDigitalChannel(Device,Data)
DAQmx_Val_ChanPerLine =0; % One Channel For Each Line
DAQmx_Val_ChanForAllLines =1; % One Channel For All Lines
DAQmx_Val_GroupByChannel = 0; % Group per channel

data = [0 0 0 0 0 0 0 0];
read = [0 0 0 0 0 0 0 0];
bytesPerSamp = 0;
% DAQmx Configure Code
[ status, ~, task ] = DAQmxCreateTask([]);
DAQmxErr(status);
DAQmxErr(DAQmxCreateDIChan(task,'Dev2/port0/line0:7','',DAQmx_Val_ChanForAllLines));
% DAQmx Start Code
DAQmxErr(DAQmxStartTask(task));
% DAQmx Read Code
DAQmxErr(DAQmxReadDigitalLines(task,1,10.0,DAQmx_Val_GroupByChannel,data,100,read,bytesPerSamp));
% DAQmx Stop Code
DAQmxStopTask(task);
DAQmxClearTask(task);


function WriteDigitalChannel(Device,Data)
DAQmx_Val_ChanPerLine =0; % One Channel For Each Line
DAQmx_Val_ChanForAllLines =1; % One Channel For All Lines
DAQmx_Val_GroupByChannel = 0; % Group per channel

sampsPerChanWritten = 0;

% DAQmx Configure Code
[ status, TaskName, task ] = DAQmxCreateTask([]);
DAQmxErr(status);
DAQmxErr(DAQmxCreateDOChan(task,Device,'',DAQmx_Val_ChanForAllLines));
% DAQmx Start Code
DAQmxErr(DAQmxStartTask(task));
% DAQmx Write Code
DAQmxErr(DAQmxWriteDigitalLines(task,1,1,10.0,DAQmx_Val_GroupByChannel,Data,sampsPerChanWritten));
% DAQmx Stop Code
DAQmxStopTask(task);
DAQmxClearTask(task);



function [Answer] = ReadVoltageScalar(Device)
%This does not work
DAQmx_Val_Volts= 10348; % measure volts
[ status, TaskName, task ] = DAQmxCreateTask([]);
status = DAQmxCreateAOVoltageChan(task,Device,-10,10,DAQmx_Val_Volts);
[status, output] = DAQmxReadAnalogScalarF64(task);
if status ~= 0
    disp(['Error while reading voltage in Device ' Device]);
    DAQmxErr(status);
end
DAQmxClearTask(task);

Answer.status = status;
Answer.Voltage = output;

function [meanCounts, stdCounts] = GetCounts(SamplingFreq,Samples)

TimeOut = 1.1*Samples/SamplingFreq;
hCounter = SetCounter( Samples+1 );
[status, hPulse] = DigPulseTrainCont(SamplingFreq,0.5,Samples);

% DupCount = DAQmxGet(hCounter, 'CI.DupCountPrevent', 'Dev2/ctr0');
% DAQmxSet(hCounter, 'CI.DupCountPrevent', 'Dev2/ctr0',1);

status = DAQmxStartTask(hCounter);
if status ~= 0,
    disp(['NI: Start Counter        :' num2str(status)])
end
status = DAQmxStartTask(hPulse);    
if status ~= 0,
    disp(['NI: Start Pulse          :' num2str(status)])
end

A = ReadCounter( hCounter, Samples , TimeOut);

DAQmxStopTask(hPulse);
DAQmxStopTask(hCounter);
DAQmxClearTask(hPulse);
DAQmxClearTask(hCounter);

A = diff(A);
meanCounts = mean(A);
stdCounts = std(A);


function [status, task] = SetCounter(N)
DAQmx_Val_Volts= 10348; % measure volts
DAQmx_Val_Rising = 10280; % Rising
DAQmx_Val_FiniteSamps = 10178; % Finite Samples
DAQmx_Val_CountUp = 10128; % Count Up
DAQmx_Val_CountDown = 10124; % Count Down
DAQmx_Val_GroupByChannel = 0; % Group per channel
DAQmx_Val_ContSamps =10123; % Continuous Samples

[ status, TaskName, task ] = DAQmxCreateTask([]);
DAQmxErr(status);

status = DAQmxCreateCICountEdgesChan(task,PortMap('Ctr in'),'',...
    DAQmx_Val_Rising , 0, DAQmx_Val_CountUp);
DAQmxErr(status);

status = calllib('mynidaqmx','DAQmxSetCICountEdgesTerm',...
    task, PortMap('Ctr in'), PortMap('SPCM')); 
DAQmxErr(status);

status = DAQmxCfgSampClkTiming(task,PortMap('Ctr Trig'),1.0,...
    DAQmx_Val_Rising,DAQmx_Val_FiniteSamps ,N);
DAQmxErr(status);

function [status, task] = DigPulseTrainCont(Freq,DutyCycle,Samps)

DAQmx_Val_Volts= 10348; % measure volts
DAQmx_Val_Rising = 10280; % Rising
DAQmx_Val_FiniteSamps = 10178; % Finite Samples
DAQmx_Val_CountUp = 10128; % Count Up
DAQmx_Val_CountDown = 10124; % Count Down
DAQmx_Val_GroupByChannel = 0; % Group per channel
DAQmx_Val_ContSamps =10123; % Continuous Samples
DAQmx_Val_Hz = 10373; % Hz
DAQmx_Val_Low =10214; % Low

[~,~,task] = DAQmxCreateTask('');
status = DAQmxCreateCOPulseChanFreq(task,PortMap('Ctr out'),'',DAQmx_Val_Hz,DAQmx_Val_Low,0.0,Freq, DutyCycle);
DAQmxErr(status);
status = DAQmxCfgImplicitTiming(task,DAQmx_Val_ContSamps,Samps);
DAQmxErr(status);

function readArray = ReadCounter(task,N,TimeOut)
numSampsPerChan = N;
%readArray = libpointer('int64Ptr',zeros(1,N));
readArray = zeros(1,N);
arraySizeInSamps = N;
sampsPerChanRead = libpointer('int32Ptr',0);

[status, readArray]= DAQmxReadCounterF64(task, numSampsPerChan,...
    TimeOut, readArray, arraySizeInSamps, sampsPerChanRead );


function status = WriteVoltages(Devices,Voltages)
DAQmx_Val_Volts= 10348; % measure volts
status = -1;
for k=1:length(Devices),
    switch Devices{k}
        case {PortMap('Galvo x'),PortMap('Galvo y')}
            if abs(Voltages(k)) > 0.8
                disp('Error in WriteVoltage (Voltage exceeds 0.8 volts)');
                return;
            end
    end
    [ status, TaskName, task ] = DAQmxCreateTask([]);
    status = status + DAQmxCreateAOVoltageChan(task,Devices{k},-10,10,DAQmx_Val_Volts);
    status = status + DAQmxWriteAnalogScalarF64(task,1,0,Voltages(k));
    if status ~= 0
        disp(['Error in writing voltage in Device ' Devices{k}]);
    end
    DAQmxClearTask(task);
end

function status = WriteVoltage(Device,Voltage)
DAQmx_Val_Volts= 10348; % measure volts
status = -1;
switch Device
    case {PortMap('Galvo x'),PortMap('Galvo y')}
        if abs(Voltage) > 0.8
            disp('Error in WriteVoltage (Voltage exceeds 0.8 volts)');
            return;
        end
end

[ status, TaskName, task ] = DAQmxCreateTask([]);
status = status + DAQmxCreateAOVoltageChan(task,Device,-10,10,DAQmx_Val_Volts);
status = status + DAQmxWriteAnalogScalarF64(task,1,0,Voltage);
if status ~= 0
    disp(['Error in writing voltage in Device ' Device]);
end
DAQmxClearTask(task);


function status = SetGatedCounter(task,counter,src,gate)
% added by Satcher 10/19/2016
DAQmx_Val_Rising = 10280;
DAQmx_Val_CountUp = 10128;
DAQmx_Val_DigLvl = 10152;
DAQmx_Val_Low=10214;

status = DAQmxCreateCICountEdgesChan(task,counter,'',...
    DAQmx_Val_Rising , 0, DAQmx_Val_CountUp);

DAQmxErr(status);

status = status + calllib('mynidaqmx','DAQmxSetCICountEdgesTerm',...
    task, counter, src); 
status = status + calllib('mynidaqmx','DAQmxSetPauseTrigType',...
    task,DAQmx_Val_DigLvl); 
status = status + calllib('mynidaqmx','DAQmxSetDigLvlPauseTrigSrc',...
    task, gate); 
status = status + calllib('mynidaqmx','DAQmxSetDigLvlPauseTrigWhen',...
    task, DAQmx_Val_Low);

function [status, task] = SetGatedNCounter(N)
%added by Satcher 12/2/2016
DAQmx_Val_Volts= 10348; % measure volts
DAQmx_Val_Rising = 10280; % Rising
DAQmx_Val_Falling =10171; % Falling
DAQmx_Val_FiniteSamps = 10178; % Finite Samples
DAQmx_Val_CountUp = 10128; % Count Up
DAQmx_Val_CountDown = 10124; % Count Down
DAQmx_Val_GroupByChannel = 0; % Group per channel
DAQmx_Val_ContSamps =10123; % Continuous Samples
DAQmx_Val_SampClkPeriods = 10286; % Sample Clock Periods
DAQmx_Val_Seconds =10364; % Seconds
DAQmx_Val_Ticks =10304; % Ticks
DAQmx_Val_DigLvl = 10152;
DAQmx_Val_Low=10214;

[ status, ~, task ] = DAQmxCreateTask([]);
DAQmxErr(status);
status = DAQmxCreateCICountEdgesChan(task,PortMap('Ctr in'),'',...
    DAQmx_Val_Rising , 0, DAQmx_Val_CountUp);
DAQmxErr(status);
status = calllib('mynidaqmx','DAQmxSetCICountEdgesTerm',...
    task, PortMap('Ctr in'), PortMap('Ctr src')); 
DAQmxErr(status);

status = calllib('mynidaqmx','DAQmxSetPauseTrigType',...
    task,DAQmx_Val_DigLvl); 
DAQmxErr(status);

status = calllib('mynidaqmx','DAQmxSetDigLvlPauseTrigSrc',...
    task, PortMap('Ctr Gate')); 
DAQmxErr(status);

status = calllib('mynidaqmx','DAQmxSetDigLvlPauseTrigWhen',...
    task, DAQmx_Val_Low);
DAQmxErr(status);

max_freq=1e7;

status = DAQmxCfgSampClkTiming(task,PortMap('Ctr Gate'),max_freq,...
    DAQmx_Val_Rising,DAQmx_Val_ContSamps ,N);
DAQmxErr(status);


% DAQmx_Val_Volts= 10348; % measure volts
% DAQmx_Val_Rising = 10280; % Rising
% DAQmx_Val_Falling =10171; % Falling
% DAQmx_Val_FiniteSamps = 10178; % Finite Samples
% DAQmx_Val_CountUp = 10128; % Count Up
% DAQmx_Val_CountDown = 10124; % Count Down
% DAQmx_Val_GroupByChannel = 0; % Group per channel
% DAQmx_Val_ContSamps =10123; % Continuous Samples
% DAQmx_Val_SampClkPeriods = 10286; % Sample Clock Periods
% DAQmx_Val_Seconds =10364; % Seconds
% DAQmx_Val_Ticks =10304; % Ticks
% 
% 
% status = DAQmxCreateCIPulseWidthChan(task,'Dev2/ctr0','',...
%     0.000000100,18.38860750,DAQmx_Val_Seconds,DAQmx_Val_Rising,'');
% DAQmxErr(status);
% 
% %N has to be the number of samples to read (this is important)
% status = DAQmxCfgImplicitTiming(task, DAQmx_Val_FiniteSamps ,N);
% DAQmxErr(status);
% 
% %status = calllib('mynidaqmx','DAQmxSetCIPulseWidthTerm',...
%      %task, 'Dev2/ctr0', '/Dev2/PFI8');
%  
% result = DAQmxGet(task, 'CI.CtrTimebaseSrc', 'Dev2/ctr0');
% DAQmxSet(task, 'CI.CtrTimebaseSrc', 'Dev2/ctr0', '/Dev2/PFI8');
% 
% DupCount = DAQmxGet(task, 'CI.DupCountPrevent', 'Dev2/ctr0');
% DAQmxSet(task, 'CI.DupCountPrevent', 'Dev2/ctr0',1);

function [data, status] = ReadCounterScalar(task)
% added by Satcher 10/19/2016
global gTimeOut
data=0;
timeout=gTimeOut;
[status, data] = calllib('mynidaqmx','DAQmxReadCounterScalarU32',...
task, timeout,data,[]); 
DAQmxErr(status);
DAQmxStopTask(task);
%DAQmxClearTask(task);

function [status, hScan] = WriteAnalogVoltage(chan,vec, samps, freq)
DAQmx_Val_Volts= 10348; % measure volts
DAQmx_Val_Rising = 10280; % Rising
% DAQmx_Val_Falling = 10171; % Falling
DAQmx_Val_FiniteSamps = 10178; % Finite Samples
DAQmx_Val_GroupByChannel = 0; % Group per channel

[ status, ~, hScan ] = DAQmxCreateTask([]);
DAQmxErr(status);
status = DAQmxCreateAOVoltageChan(hScan,chan,-5,5,DAQmx_Val_Volts);
DAQmxErr(status);
status = DAQmxCfgSampClkTiming(hScan,PortMap('Ctr Trig'),freq,...
    DAQmx_Val_Rising,DAQmx_Val_FiniteSamps,samps);
DAQmxErr(status);
zero_ptr = libpointer('int32Ptr',zeros(1,samps));
status = DAQmxWriteAnalogF64(hScan, samps, 0, 10,...
    DAQmx_Val_GroupByChannel, vec, zero_ptr);
DAQmxErr(status);


function [status, hRead] = CreateAIChannel(trig, samps, freq)
DAQmx_Val_diff=10106;
DAQmx_Val_Volts= 10348; % measure volts
DAQmx_Val_Rising = 10280; % Rising
%DAQmx_Val_Falling = 10171; % Falling
DAQmx_Val_FiniteSamps = 10178; % Finite Samples

[ status, ~, hRead ] = DAQmxCreateTask([]);

DAQmxErr(status);

status = DAQmxCreateAIVoltageChan(hRead,PortMap('APD in'),'',...
    DAQmx_Val_diff, -5,5, DAQmx_Val_Volts,[]);

DAQmxErr(status);
status = DAQmxCfgSampClkTiming(hRead,trig,freq,DAQmx_Val_Rising,DAQmx_Val_FiniteSamps,samps); %ctr1 out
DAQmxErr(status);

function [status, RawData] = ReadAnalogVoltage(task, samps, timeout)
DAQmx_Val_GroupByChannel = 0; % Group per channel
sampsPerChanRead = libpointer('int32Ptr',0);
RawData = zeros(1,samps);
[status, RawData]=DAQmxReadAnalogF64(task,samps,timeout,DAQmx_Val_GroupByChannel,RawData,samps,sampsPerChanRead,[]);
DAQmxErr(status);