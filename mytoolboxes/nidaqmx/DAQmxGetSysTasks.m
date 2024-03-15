function [ status, tasks ] = DAQmxGetSysTasks

tasks = num2str(zeros(1,1000,'uint32'));
[status, tasks] = calllib('mynidaqmx','DAQmxGetSysTasks',tasks,1000);



