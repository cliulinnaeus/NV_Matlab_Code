function DAQmxErr(errorCode)

bufferSize = 100;
errorString = char(zeros(1,bufferSize));
[status,errorString]=calllib('mynidaqmx','DAQmxGetErrorString', ...
    errorCode, errorString, bufferSize);

if ~isempty(errorString)
    disp(['Error ' num2str(errorCode) ':' errorString]);
end
    