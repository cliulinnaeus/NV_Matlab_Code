function [status,task,chans] = DAQmxCreateAOVoltageChan(task,chans,minVal,maxVal,Units)

name = '';
DAQmx_Val_Volts= 10348; % measure volts
Units = DAQmx_Val_Volts;    
scaleName = '';

[status,task,chans] = calllib('mynidaqmx','DAQmxCreateAOVoltageChan',...
    task,chans,name,minVal,maxVal,Units,scaleName);
