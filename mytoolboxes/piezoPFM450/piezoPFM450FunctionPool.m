function pos=piezoPFM450FunctionPool(varargin)

    global gPiezo;

    % Initialize Device List
    %Thorlabs.MotionControl.DeviceManagerCLI.DeviceManagerCLI.BuildDeviceList();  % Build device list
    %serialNumbersNet    = Thorlabs.MotionControl.DeviceManagerCLI.DeviceManagerCLI.GetDeviceList();  % Get device list
    %serialNumbers       = cell(ToArray(serialNumbersNet));       % Convert serial numbers to cell array

    %% serial_no can be manually changed
    %gPiezo.serial_no           = serialNumbers{1};  % shows correct serial number

    switch varargin{1}
        case 'connect'
            connectpfm(PortMap('Piezo'));
        case 'disconnect'
            close_checkpfm();
        case 'getposition'
            pos = getposition();
        case 'setposition'
            if length(varargin)~=2
                disp('Input argument invalid');
            else
                setposition(varargin{2});
            end
            
            
        otherwise
            disp('Request Unknown!');
        
        
    end
    
    
    
    % global config info maxvol maxposition;
    % global deviceNET;
    % global chan;
    % global currentvol controlmode position jogsteps;

    %% example use:
    %connectpfm(serial_no);
    %setposition(0);
    %pause(0.3)
    %getposition();
    %closepfm();
    %a = position


end

function connectpfm(serial_no)
    MOTORPATHDEFAULT = 'C:\Program Files\Thorlabs\Kinesis\';
    DEVICEMANAGERDLL='Thorlabs.MotionControl.DeviceManagerCLI.dll';
    GENERICMOTORDLL='Thorlabs.MotionControl.GenericMotorCLI.dll';
    PRECISIONPIEZOMOTORDLL='Thorlabs.MotionControl.Benchtop.PrecisionPiezoCLI.dll';
    asm_dev = NET.addAssembly([MOTORPATHDEFAULT, DEVICEMANAGERDLL]);
    asm_gen = NET.addAssembly([MOTORPATHDEFAULT, GENERICMOTORDLL]);
    asmInfo = NET.addAssembly([MOTORPATHDEFAULT, PRECISIONPIEZOMOTORDLL]);
    import Thorlabs.MotionControl.DeviceManagerCLI.*;
    import Thorlabs.MotionControl.GenericMotorCLI.*
    import Thorlabs.MotionControl.Benchtop.PrecisionPiezoCLI.*
    import Thorlabs.MotionControl.PrivateInternal.dll.*
    import Thorlabs.MotionControl.Tools.Common.dll.*
    import Thorlabs.MotionControl.GenericPiezoCLI.dll.*
    
    Thorlabs.MotionControl.DeviceManagerCLI.DeviceManagerCLI.BuildDeviceList();  % Build device list

    global gPiezo;
    try 
        gPiezo.deviceNET = Thorlabs.MotionControl.Benchtop.PrecisionPiezoCLI.BenchtopPrecisionPiezo.CreateBenchtopPiezo(serial_no);
        gPiezo.deviceNET.Connect(serial_no);
        gPiezo.isconnected = 1;

    catch
    gPiezo.isconnected = 0;
    error('Device is not properly connected.')
    end
    try
        gPiezo.chan = gPiezo.deviceNET.GetChannel(1);
        gPiezo.chan.WaitForSettingsInitialized(5000);
        gPiezo.chan.StartPolling(250); %getting the voltage only works if you poll!
        pause(0.250)
        gPiezo.chan.EnableDevice();
        pause(0.250)
        gPiezo.config = gPiezo.chan.GetPiezoConfiguration(gPiezo.chan.DeviceID);
        gPiezo.info = gPiezo.chan.GetDeviceInfo();
        gPiezo.maxvol = gPiezo.chan.GetMaxOutputVoltage().ToString();
        gPiezo.maxvol = str2double(char(gPiezo.maxvol));
        gPiezo.maxposition = gPiezo.chan.GetMaxTravel().ToString();
        gPiezo.maxposition = str2double(char(gPiezo.maxposition));
        gPiezo.minposition = 0; 
    catch
        closepfm();
        error('Failed to take initial data')
    end
end

function getcontrolmode()
    global gPiezo;
    gPiezo.controlmode = gPiezo.chan.GetPositionControlMode();
end

% function setcontrolmode()
%     global deviceNET chan;
%     try
%         chan.SetPositionControlMode(chan.PiezoControlModeTypes.OpenLoop);
%     catch
%         deviceNET.ShutDown();
%     end
% end

function pos=getposition()
    global gPiezo;
    try 
        pos = gPiezo.chan.GetPosition().ToString();
        pos = str2double(char(pos));
    catch
        gPiezo.deviceNET.ShutDown();
    end
end

function setposition(position)
    global gPiezo;
    try
        gPiezo.chan.SetPosition(position);    
    catch
        gPiezo.deviceNET.ShutDown();
    end
end

% function getjogsteps()
%     global chan;
%     global jogsteps;
%     jogsteps = chan.GetJogSteps();
% end

function getvol()
    global gPiezo;
    try
        gPiezo.currentvol = gPiezo.chan.GetOutputVoltage().ToString();
    catch
        gPiezo.deviceNET.ShutDown();
    end
end

function setvol(vol)
    global gPiezo;
%     global maxvol;
%     if (0 <= vol) && (vol<= maxvol)
%         chan.SetOutputVoltage(System.Decimal(vol));
%     elseif vol < 0
%         warning('Voltage ill-defined')
%     elseif vol > maxvol
%         warning('Voltage exceeeds maximum')
%     end
    try
        gPiezo.chan.SetOutputVoltage(System.Decimal(vol));
    catch
        gPiezo.deviceNET.ShutDown();
    end
end

function closepfm()
    global gPiezo;
    gPiezo.chan.StopPolling();
    gPiezo.deviceNET.Disconnect;
        gPiezo.isconnected = 0;
end

function close_checkpfm()
    global gPiezo;
    try 
        gPiezo.isconnected = 0;
        gPiezo.chan.StopPolling();
        gPiezo.deviceNET.Disconnect;
        gPiezo.isconnected = 0;
    catch
        warning('Device is not properly disconnected.')
    end
end