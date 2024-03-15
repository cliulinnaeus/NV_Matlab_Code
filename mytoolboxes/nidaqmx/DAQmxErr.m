function DAQmxErr(errorCode)
if errorCode == 0
    return;
end

bufferSize = 500;
errorString = char(ones(1,bufferSize));
[status,errorString]=calllib('mynidaqmx','DAQmxGetErrorString', ...
    errorCode, errorString, bufferSize);

if ~isempty(errorString)
    error(['Error ' num2str(errorCode) ': ' errorString]);
end
    