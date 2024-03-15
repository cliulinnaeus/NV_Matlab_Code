function LoadNIDAQmx

if ~libisloaded('mynidaqmx')
    disp('Matlab: Load nicaiu.dll')
    % Added by Jero
    warning('off','MATLAB:loadlibrary:TypeNotFound')
    %loadlibrary('nicaiu.dll','nidaqmx.h','alias','mynidaqmx');
    loadlibrary('nicaiu.dll','nidaqmx.h','alias','mynidaqmx');
    warning('on','MATLAB:loadlibrary:TypeNotFound')
end