global gSc tmax gmSEQ
% Find a serial port object.
gSc.serial = instrfind('Type', 'visa-usb', 'RsrcName', PortMap('Scope_TekDPO2024'), 'Tag', '');

% Create the serial port object if it does not exist
% otherwise use the object that was found.
% if isempty(gSc.serial)
%     gSc.serial = visa('KEYSIGHT', PortMap('Scope_TekDPO2024'));
% else
%     fclose(gSc.serial);
%     gSc.serial = gSc.serial(1);
% end
% % Set the timeout value
% gSc.serial.Timeout = 15;
% % Set the Byte order
% gSc.serial.ByteOrder = 'littleEndian';
% % gSc.serial.Timeout = 20;
% gSc.serial.InputBufferSize = 2500000;
% gSc.qErr=zeros(1,2);
% 
% [~, waveform] = ScopeFunctionPool('ReadWaveform');
% ScopeFunctionPool('GetImage', waveform);


% %% Test Code
% tmax = 16500; % ns
% gmSEQ.ctrN = 3;
% gmSEQ.Repeat = 1000;
% gmSEQ.CHN(1).T = [0.0890, 0.1130, 0.1550] * 1e-4; % s
% gmSEQ.CHN(1).DT = [1, 1, 1] * 1e-6; % s
% gmSEQ.meas = 'Scope';
% [sigDatum, refDatum] = ProcessData(waveform(1));

global gSc
ScopeFunctionPool('Init');
ScopeFunctionPool('Run');
%[~, waveform] = ScopeFunctionPool('ReadWaveform');
%ScopeFunctionPool('GetImage', waveform);

