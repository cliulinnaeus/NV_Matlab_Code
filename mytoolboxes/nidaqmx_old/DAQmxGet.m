function result = DAQmxGet(task, what, channel)

strData = '123456789012345678901234567890'; strDataSize = 30;
intData = 0;
bData = false;
switch what
    case 'CIPulseWidth.DigFltrTimebaseSrc'
        [s, channel, result] = calllib('mynidaqmx','DAQmxGetCIPulseWidthDigFltrTimebaseSrc', task,channel, strData, strDataSize);
    case 'CICountEdges.CtrTimebaseSrc'
        [s, channel, result] = calllib('mynidaqmx','DAQmxGetCICountEdgesCountDirDigFltrTimebaseSrc', task,channel, strData, strDataSize);
    case 'CI.CtrTimebaseSrc'
        [s, channel, result] = calllib('mynidaqmx','DAQmxGetCICtrTimebaseSrc', task,channel, strData, strDataSize);
    case 'CI.PulseWidthTerm'
        [s, channel, result] = calllib('mynidaqmx','DAQmxGetCIPulseWidthTerm', task,channel, strData, strDataSize);
    case 'Something'
    case 'ChanType'
        [s, channel, result] = calllib('mynidaqmx','DAQmxGetChanType', task,channel, intData);
    case 'ChanDescr'
        [s, channel, result] = calllib('mynidaqmx','DAQmxGetChanDescr', task,channel, strData, strDataSize);
    case 'CI.DupCountPrevent'
        [s, channel, result] = calllib('mynidaqmx','DAQmxGetCIDupCountPrevent', task, channel, bData);
    otherwise
end

if s<0
    DAQmxErr(s);
end