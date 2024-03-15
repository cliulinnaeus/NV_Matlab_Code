function result = DAQmxSet(task, what, channel, SetTo)

switch what
    case 'CIPulseWidth.DigFltrTimebaseSrc'
        [s] = calllib('mynidaqmx','DAQmxSetCIPulseWidthDigFltrTimebaseSrc', task,channel, SetTo);
    case 'CI.CtrTimebaseSrc'
        [s] = calllib('mynidaqmx','DAQmxSetCICtrTimebaseSrc', task,channel, SetTo);
    case 'CI.DupCountPrevent'
        [s] = calllib('mynidaqmx','DAQmxSetCIDupCountPrevent', task, channel, SetTo  );
    case 'CI.PulseWidthTerm'
        [s] = calllib('mynidaqmx','DAQmxSetCIPulseWidthTerm', task, channel, SetTo  );
    case 'Something'
    otherwise
end

if s<0
    DAQmxErr(s);
end