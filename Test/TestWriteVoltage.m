function task = TestWriteVoltage(what,Voltage)
DAQmx_Val_Volts= 10348; % measure volts

switch what
    case {1,'Dev1/ao0'}
        Device = 'Dev1/ao0';
    case {2,'Dev1/ao1'}
        Device = 'Dev1/ao1';
    case {3,'Obj_Piezo'}
        % Device = 'Dev1/ao2'; #PI
        
        % #EO
        global EO_handle;

        if Voltage > 100
            Voltage = 100;
        end
        if Voltage < 0
            Voltage = 0;
        end

        calllib('EO-Drive','EO_Move', EO_handle, Voltage); 
        % #EO
       
        
        return;
        
    case 4
        return;
%     case 'ao_2' 
%         Device = 'Dev1/ao2';
%     case 'ao_3'
%         Device = 'Dev1/ao3';
    otherwise
        disp('Error in Write Voltage: I dont get it!');
end
LoadNIDAQmx;
[ status, TaskName, task ] = DAQmxCreateTask([]);
status = status + DAQmxCreateAOVoltageChan(task,Device,-10,10,DAQmx_Val_Volts);
status = status + DAQmxWriteAnalogScalarF64(task,1,0,Voltage);
if status ~= 0
    disp(['Error in writing voltage in Device ' Device]);
end
DAQmxClearTask(task);