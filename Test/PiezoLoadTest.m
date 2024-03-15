controllerSerialNumber = '0121026985'; % Use "devicesUsb = Controller.EnumerateUSB('')" to get all PI controller connected to your PC. Or look at the label of the case of your controller
axis = '1';
%% Load PI MATLAB Driver GCS2
isWindows   = any (strcmp (mexext, {'mexw32', 'mexw64'}));

if(~isdeployed) % Determine whether code is running in deployed or MATLAB mode
    if (isWindows)
        addpath (getenv ('PI_MATLAB_DRIVER'));
    else
        addpath ( '/usr/local/PI/pi_matlab_driver_gcs2' );
    end
end

% Load PI_GCS_Controller if not already loaded
if(~exist('Controller','var'))
    Controller = PI_GCS_Controller();
end
if(~isa(Controller,'PI_GCS_Controller'))
    Controller = PI_GCS_Controller();
end

%% Start connection
% (if not already connected)
try
    boolPIdeviceConnected = false; 
    if ( exist ( 'PIdevice', 'var' ) ), if ( PIdevice.IsConnected ), boolPIdeviceConnected = true; end; end
    if ( ~(boolPIdeviceConnected ) )            
            PIdevice = Controller.ConnectUSB ( controllerSerialNumber );
    end

    % query controller identification string
    connectedControllerName = PIdevice.qIDN();

    % initialize PIdevice object for use in MATLAB
    PIdevice = PIdevice.InitializeController ();


    %% Startup stage
    % switch servo on for axis
    switchOn    = 1;
    PIdevice.SVO ( axis, switchOn );

    %% Get min/max position limits 
    % determine the allowed travel range of the stage
    minimumPosition = PIdevice.qTMN ( axis );
    maximumPosition = PIdevice.qTMX ( axis );
    travelRange = ( maximumPosition - minimumPosition );

    %% Do absolute motions
    targetPosition = minimumPosition + (travelRange * 0.1);

    PIdevice.MOV ( axis, targetPosition );
    disp ( 'Stage is moving')
    % wait for motion to stop
    while(0 ~= PIdevice.IsMoving () )
        pause ( 0.1 );
        fprintf('.');
    end
    fprintf('Successfully moved near minimum position limit, to %f\n',PIdevice.qPOS(axis));

    targetPosition = maximumPosition - (travelRange * 0.1);

    PIdevice.MOV ( axis, targetPosition );
    disp ( 'Stage is moving')
    % wait for motion to stop
    while(0 ~= PIdevice.IsMoving () )
        pause ( 0.1 );
        fprintf('.');
    end
    fprintf('Successfully moved near maximum position limit, to %f\n',PIdevice.qPOS(axis));

    %% Do relative motions
    targetPosition = maximumPosition * 0.5 * -1;
    PIdevice.MVR (axis, targetPosition);

    disp ( 'Stage is moving')
    % wait for motion to stop
    while(0 ~= PIdevice.IsMoving () )
        pause ( 0.1 );
        fprintf('.');
    end
    fprintf('Successfully did relative move back for %f units\n', PIdevice.qPOS(axis));


    targetPosition = targetPosition * -1;
    PIdevice.MVR (axis, targetPosition);

    disp ( 'Stage is moving')
    % wait for motion to stop
    while(0 ~= PIdevice.IsMoving () )
        pause ( 0.1 );
        fprintf('.');
    end
    fprintf('Successfully did relative move forward for %f units\n', PIdevice.qPOS(axis));

    %% switch servo off
    switchOff    = 0;
    PIdevice.SVO ( axis, switchOff );

    %% If you want to close the connection
    PIdevice.CloseConnection ();

    %% If you want to unload the dll and destroy the class object
    Controller.Destroy ();
    clear Controller;
    clear PIdevice;
catch
    Controller.Destroy;
    clear Controller;
    clear PIdevice;
    rethrow(lasterror);
end