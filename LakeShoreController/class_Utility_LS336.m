%% Utility Functions for Lake Shore 336 Heater Controller
% Provide a class that includes all the utility functions, i.e. the
% functions that use the driver (class_Driver_LS336) to complete the
% operations required by the GUI.
%
% * This script is developed and tested by *Yuanqi Lyu*
% (yuanqilyu@berkeley.edu) at *University of California, Berkeley*. All
% rights reserved.
% * This script is tested to be compatiable with *MATLAB 2020b* in Feb
% 2021.
% * *Standard disclaimer*: there is no spelling check function for the
% comments.
% * This script and its corresponding project is available on 
% <https://github.com/Yuanqi137/LakeShoreController GitHub>.
%

classdef class_Utility_LS336 < handle
    %%%
    % This is a MATLAB handle class
    % (<https://www.mathworks.com/help/matlab/handle-classes.html 
    % ref>), which provide real time value change in class method 
    % functions.
    %% *PROPERTIES*
    properties (Constant)
        N_Buffer = 100;
        %%%
        % *N_Buffer* (_double_):
        % The number of temperature reading to collect between each writing
        % to the file.
        
    end
    properties (Access = public)
        Conf = struct( ...
            'SerialPort_Name', 'COM5', ...
            'N_Heater', 2, ...
            'N_TempSensor', 2, ...
            'Log_Path', 'Data',...
            'Temp_LimLower', 0, ...
            'Temp_LimUpper', 370);
        %%%
        % *Conf* (_struct_):
        % The configurtion of the app. It is saved between opening and
        % closing of the app.
        % 
        % * _SerialPort_Name_ (_string_):
        % Name of the serial port.
        % * _N_Heater_ and _N_TempSensor_ (_double_):
        % Number of heaters and temperature sensors connected to the heater
        % controller.
        % * _Log_Path_ (_string_):
        % File path of the log file.
        %
        
        Driver
        %%%
        % *Driver* (_class_):
        % The class_Driver_LS336 instance, created when connected to the
        % heater controller and destoried at disconnect.
        
        CtrlGUI
        %%%
        % *CtrlGUI* (_MATLAB app_):
        % The GUI itself, so that we can manipulate its values and controls
        % at our will.
        
        Timer
        %%%
        % *Timer* (_timer_):
        % An instance of timer that continuously obtains temperature and
        % heater percentage readings.
        % (<https://www.mathworks.com/help/matlab/matlab_prog/use-a-matlab-timer-object.html
        % ref>)
        
        Data = struct( ...
            'Heater_Percentage_Plot', [], ...
            'Heater_Percentage_Buffer', [], ...
            'Temp_Plot', [], ...
            'Temp_Buffer', [], ...
            'Time_Plot', [], ...
            'Time_Buffer', []);
        
        %%%
        % *Data* (_struct_):
        % Data temporarily stored in the class instance.
        %
        % * _Heater_Percentage_Plot_, _Temp_Plot_ (_double (matrix)_):
        % Matrix of heater percentages and temperatures to be plotted.
        % * _Heater_Percentage_Buffer_, _Temp_Buffer_ (_double (matrix)_):
        % Matrix of heater percentages and temperatures to be stored once
        % property N_Counter reaches a multiple of property N_Buffer.
        % * _Time_Buffer_, _Time_Plots_ (_double (matrix)_):
        % Matrix of time values (i.e. the output of now() function, the
        % number of seconds since Jan/01/1970 00:00 UTC) for buffer and
        % plots.
        %
        
        Flag = struct( ...
            'Clear_Plot', 0, ...
            'Log_On', 0, ...
            'Log_Stopped', 0 );
        %%%
        % *Flag* (_struct_):
        % Logical flags for to determine whether to activate functions.
        %
        % * _Clear_Plot_ (_logic_):
        % Logical flag set when the Clear Plot button is pushed.
        % * _Log_On_ and _Log_Stopped_ (_logic_):
        % Logical flags set when data logging is on or stopped by user
        % control.
        %
        
    end
    %% *METHODS*
    methods
        %% *Utility Functions*
        %% Class Constructor & Initialization Function
        % Create an class instance and initialize the GUI.
        
        function obj = class_Utility_LS336(In_CtrlGUI)
            obj.CtrlGUI = In_CtrlGUI;
            obj.load_Conf();
            
            if obj.Conf.N_Heater == 1
                obj.CtrlGUI.Heater2LevelDropDown.Visible = 'off';
                obj.CtrlGUI.Heater2LevelDropDownLabel.Visible = 'off';
                obj.CtrlGUI.Heater2Lamp.Visible = 'off';
                obj.CtrlGUI.Heater2LampLabel.Visible = 'off';
                obj.CtrlGUI.HeaterPercentageEditFieldLabel.Visible = 'off';
            end
            if obj.Conf.N_TempSensor == 1
                obj.CtrlGUI.TempCurrentEditFieldLabel.Visible = 'off';
            end
            %%%
            % Hide extra heater settings if there is only one heater
            % connected.
            if ismac()
                obj.CtrlGUI.LogFileFolderEditField.Value = "~/Documents";
                obj.CtrlGUI.GoToFolderButton.Visible = 'off';
                obj.CtrlGUI.FileMenu.Visible = 'off';
            end
            %%%
            % Hide all go-to-folder functionalities if run on Mac, as it
            % requires a PC to run.
            
            obj.Timer = timer( ...
                    'Period', obj.CtrlGUI.RefreshIntervalsSpinner.Value, ...
                    'ExecutionMode', 'fixedRate');
            obj.Timer.TimerFcn = @obj.timerFunc;
            obj.Timer.ErrorFcn = @obj.timerErrFunc;
                
            obj.disable_Controls();
            %%%
            % Disable controls before connection.
        end
        
        %% Class Destructor
        % This function is excuted before the instance of the class is
        % destroyed.
        
        function delete(obj)
            if ~isempty(obj.Driver)
                obj.disconnect_Controller();
            end
            delete(obj.Timer);
            obj.save_Conf();
        end
        
        %% Enable All App Controls
        % This function enables all app controls.
        
        function enable_Controls(obj)
            control_names = fieldnames(obj.CtrlGUI);
            for n = 1 : length(control_names)
                if isprop(obj.CtrlGUI.(control_names{n}), 'Enable')
                    obj.CtrlGUI.(control_names{n}).Enable = 'on';
                end
            end
        end
        
        %% Disable All App Controls
        % This function disables all app controls when there is nothing
        % connected to the computer.
        
        function disable_Controls(obj)
            control_names = fieldnames(obj.CtrlGUI);
            for n = 1 : length(control_names)
                if isprop(obj.CtrlGUI.(control_names{n}), 'Enable')
                    obj.CtrlGUI.(control_names{n}).Enable = 'off';
                end
            end
                      
            obj.CtrlGUI.LeftPanel.Enable = 'on';
            obj.CtrlGUI.UserInputsPanel.Enable = 'on';            
            
            obj.CtrlGUI.SerialPortEditField.Enable = 'on';
            obj.CtrlGUI.SerialPortEditFieldLabel.Enable = 'on';
            obj.CtrlGUI.ConnectionOnOffSwitch.Enable = 'on';
            obj.CtrlGUI.ConnectionOnOffSwitchLabel.Enable = 'on';
            
            obj.CtrlGUI.ConnectionOnOffSwitch.Value = 'Off';
            obj.CtrlGUI.LoggingOnOffSwitch.Value = 'Off';
            %%%
            % Re-enable the pannels, swtiches and edit fields for 
            % connections.
            %
            % Set both Connection ON/OFF and Logging ON/OFF buttons to 
            % 'Off' state ('Off''s first letter must be capitalized --- I 
            % know it is dumb, but one has to match exactly.)
            % 
            
        end
        
        %% Connect Heater Controller
        % This function connects the heater controller by creating an
        % instance of class_Driver_LS336 class.
        
        function connect_Controller(obj)
            obj.Conf.SerialPort_Name ...
                = obj.CtrlGUI.SerialPortEditField.Value;
            try
                obj.Driver = class_Driver_LS336( ...
                    obj.Conf.SerialPort_Name, ...
                    obj.Conf.N_Heater, obj.Conf.N_TempSensor);
                if all(obj.Driver.ErrCode == 0)
                    obj.update_CurrentSettingsPanel();
                    obj.update_UserInputsPanel();
                    obj.enable_Controls();
                    %%%
                    % Update User Input, Current Heater Settings and
                    % Current Status panels.

                    obj.Timer.start();
                    %%%
                    % Create the timer to plot / store the data.
                else
                    obj.disable_Controls();
                end
            catch errMsg
                obj.CtrlGUI.ConnectionOnOffSwitch.Value = 'Off';
                delete(obj.Driver)
                warning(errMsg.message)
            end
            
        end
        
        %% Disonnect Heater Controller
        % This function disconnects the heater controller by first
        % terminating the timer and serial connection, then delete the 
        % Driver class instance all together.
        
        function disconnect_Controller(obj)
            obj.Timer.stop();
            if obj.Flag.Log_On || obj.Flag.Log_Stopped
                obj.log_Data();
                obj.CtrlGUI.LoggingOnOffSwitch.Value = 'Off';
                obj.Flag.Log_On = 0;
                obj.Flag.Log_Stopped = 0;
            end
            
            delete(obj.CtrlGUI.SubGUI);
            obj.Driver.terminate_SerialPort();
            obj.Driver.delete();
            obj.disable_Controls();
        end
        
        %% Load App Configurations
        % This function loads app configurations from "Config.txt" in the
        % same folder of the app.
        
        function load_Conf(obj)
            if exist('Config.txt', 'file')
                cell = readcell('Config.txt');
                obj.Conf = cell2struct(cell(:, 2), cell(:, 1));
            end
            obj.CtrlGUI.SerialPortEditField.Value ...
                = obj.Conf.SerialPort_Name;
            obj.CtrlGUI.LogFileFolderEditField.Value ...
                = obj.Conf.Log_Path;
            
            temp_limits = sort( ...
                [obj.Conf.Temp_LimLower, obj.Conf.Temp_LimUpper]);
            temp_value = mean(temp_limits);
            obj.CtrlGUI.TargetTempKSpinner.Limits = temp_limits;
            obj.CtrlGUI.TargetTempKSpinner.Value = temp_value;
            obj.CtrlGUI.CurrentTempGauge.Limits = temp_limits;
            %%%
            % Set the limits of temperature gauge and target teperature
            % spinner to user specified values.
        end
        
        %% Load App Configurations
        % This function loads app configurations from "Config.txt" in the
        % same folder of the app.
        
        function save_Conf(obj)
            writecell([fieldnames(obj.Conf), struct2cell(obj.Conf)], ...
                'Config.txt', ...
                'Delimiter', 'tab');
        end
        
        %% Send Settings to Heater Controller
        % This function send up-to-date settings to the heater controller
        % when the user changes the value of controls in User Inputs
        % pannel.
        
        function send_Settings(obj, In_Event)
            switch In_Event.Source.Tag
                %%%
                % Here we use the tag of event to distinguish which values
                % got changed.
                
                case "MaxCurrent_Set"
                    obj.Driver.set_MaxUserCurrent( ...
                        In_Event.Value * ones(1, obj.Driver.N_Heater));
                case "Heater1Level_Set"
                    obj.Driver.set_HeaterLevelTarg( ...
                        obj.text2HeaterLevel(In_Event.Value));
                    switch obj.CtrlGUI.HeaterOnOffSwitch.Value
                        case 'On'
                            heater_ONOFF = ones(1, obj.Driver.N_Heater);
                        case 'Off'
                            heater_ONOFF = zeros(1, obj.Driver.N_Heater);
                    end
                    obj.Driver.set_HeaterONOFF(heater_ONOFF);
                case "Heater2Level_Set"
                    obj.Driver.set_HeaterLevelTarg( ...
                        [obj.text2HeaterLevel( ...
                        obj.CtrlGUI.Heater1LevelDropDown.Value), ...
                        obj.text2HeaterLevel( ...
                        obj.CtrlGUI.Heater2LevelDropDown.Value)]);
                    switch obj.CtrlGUI.HeaterOnOffSwitch.Value
                        case 'On'
                            heater_ONOFF = ones(1, obj.Driver.N_Heater);
                        case 'Off'
                            heater_ONOFF = zeros(1, obj.Driver.N_Heater);
                    end
                    obj.Driver.set_HeaterONOFF(heater_ONOFF);
                case "HeaterONOFF_Set"
                    switch In_Event.Value
                        case 'On'
                            heater_ONOFF = ones(1, obj.Driver.N_Heater);
                        case 'Off'
                            heater_ONOFF = zeros(1, obj.Driver.N_Heater);
                    end
                    obj.Driver.set_HeaterONOFF(heater_ONOFF);
                case "TempTarg_Set"
                    obj.Driver.set_TempTarg( ...
                        In_Event.Value * ones(1, obj.Driver.N_TempSensor));
            end
            obj.update_CurrentSettingsPanel();
        end
        
        %% Update Panel of Current Heater Settings
        % This function updates all values in the Current Heater Settings
        % pannel to match that currently on the heater controller. This
        % function is run each time the settings are sent to the heater
        % controller.
        
        function update_CurrentSettingsPanel(obj)
            obj.Driver.update_AllProperties();
            %%%
            % Query all parameters from the heater controller.
            heater_MaxUserCurrent = zeros(obj.Conf.N_Heater, 1);
            for n = 1 : obj.Conf.N_Heater
                if obj.Driver.Heater_Conf.MaxCurrent(n) == 0
                    heater_MaxUserCurrent(n) ...
                        = obj.Driver.Heater_Conf.MaxUserCurrent(n);
                else
                    switch obj.Driver.Heater_Conf.MaxCurrent(n)
                        case 1
                            heater_MaxUserCurrent(n) = 0.707;
                        case 2
                            heater_MaxUserCurrent(n) = 1;
                        case 3
                            heater_MaxUserCurrent(n) = 1.414;
                        case 4
                            heater_MaxUserCurrent(n) = 1.732;
                    end
                end            
            end
            %%%
            % Max. Current - gets non-zero user defined maximum output
            % currents or predefined currents.
            
            if any(heater_MaxUserCurrent ~= max(heater_MaxUserCurrent))
                warning(['Multiple different values of Max. Currents ', ...
                    'are set to the heater controller!', ...
                    'The displayed value in GUI is the maximum among ', ...
                    'them!'])
            end
            heater_MaxUserCurrent = max(heater_MaxUserCurrent);
            obj.CtrlGUI.MaxCurrentAEditField.Value = heater_MaxUserCurrent;
            
            heater_Lamp_Color = obj.heaterLevel2Color( ...
                obj.Driver.Heater_Level);
            obj.CtrlGUI.Heater1Lamp.Color = heater_Lamp_Color(1, :);
            obj.CtrlGUI.Heater2Lamp.Color = heater_Lamp_Color(2, :);
            
            temp_Targ = obj.Driver.Temp_Targ(obj.Driver.Temp_Targ > 0);
            %%%
            % Max. Current - gets non-zero user defined maximum output
            % currents.
            
            if any(temp_Targ ~= max(temp_Targ))
                warning(['Multiple different values of Target ', ...
                    'Temperature are set to the heater controller!', ...
                    'The displayed value in GUI is the maximum among ', ...
                    'them!'])
            end
            temp_Targ = max(temp_Targ);
            obj.CtrlGUI.TargetTempKEditField.Value = temp_Targ;
            
            obj.CtrlGUI.SerialNumberLabel.Text = obj.Driver.SerialNumber;
            obj.CtrlGUI.ErrorStatLamp.Color = [1.00, 1.00, 1.00] ...
                - [0.00, 1.00, 1.00] * any(obj.Driver.ErrCode > 0);
            %%%
            % Set Error Stat. lamp to red if there is a error, and white if
            % normal.
            
        end
        
        %% Update Panel of User Inputs
        % This function updates all values in the user inputs pannel to 
        % match that currently on the heater controller. This function is 
        % run only when connection is established. Class function 
        % update_CurrentSettingsPanel() should be run pior to this
        % function.
        
        function update_UserInputsPanel(obj)
            obj.CtrlGUI.MaxCurrentASpinner.Value ...
                = obj.CtrlGUI.MaxCurrentAEditField.Value;
            obj.CtrlGUI.TargetTempKSpinner.Value ...
                = obj.CtrlGUI.TargetTempKEditField.Value;
            %%%
            % Copy Max. Current and Target Temperature from corresponding
            % fields in the Current Heater Settings panel.
            
            obj.Driver.Heater_Level_Targ = obj.Driver.Heater_Level;
            heater_Level_Targ_Text = obj.heaterLevel2Text( ...
                obj.Driver.Heater_Level_Targ);
            obj.CtrlGUI.Heater1LevelDropDown.Value ...
                = heater_Level_Targ_Text(1);
            obj.CtrlGUI.Heater2LevelDropDown.Value ...
                = heater_Level_Targ_Text(2);
            if any(obj.Driver.Heater_Level)
                obj.CtrlGUI.HeaterOnOffSwitch.Value = "On";
            else
                obj.CtrlGUI.HeaterOnOffSwitch.Value = "Off";
            end
        end
        
        %% Timer Function
        % This function plots and stores temperature and heater percentage
        % readings when timer is activated.
        
        function timerFunc(obj, ~, ~)
            %%%
            % There has to be two inputs for timer function, even not used.
            
            plot_Length = obj.CtrlGUI.MaxPlottingPointsSpinner.Value;
            try
                [~, heater_Percentage] = obj.Driver.get_HeaterPercentage();
                [~, temp] = obj.Driver.get_Temp( ...
                    char(64 + (1 : obj.Driver.N_TempSensor)));
            catch errMsg
                msgboxStyle.Interpreter = 'tex';
                msgboxStyle.WindowStyle = 'modal';
                msgbox({'\fontsize{10}{\bfFailed to fetch data!}', ... 
                    'Retrying now!'}, ...
                    'ERROR - Lake Shore 336', 'warn', msgboxStyle);
                warning(errMsg.message)
                try 
                    [~, heater_Percentage] ...
                        = obj.Driver.get_HeaterPercentage();
                    [~, temp] = obj.Driver.get_Temp( ...
                    char(64 + (1 : obj.Driver.N_TempSensor)));
                catch errMsg
                    msgbox({'\fontsize{10}{\bfFailed to fetch data!}', ... 
                    'Please reconnect the controller manually!'}, ...
                    'ERROR - Lake Shore 336', 'warn', msgboxStyle);
                    obj.timerErrFunc();
                    rethrow(errMsg);                    
                end
            end
            %%%
            % Just try a few times to obtain the current temperatures and
            % heater percentages before giving up due to error.
            
            obj.CtrlGUI.HeaterPercentageEditField.Value ...
                = mean(heater_Percentage);
            obj.CtrlGUI.HeaterPercentageGauge.Value ...
                = mean(heater_Percentage);
            obj.CtrlGUI.TempCurrentEditField.Value = mean(temp);
            obj.CtrlGUI.CurrentTempGauge.Value = mean(temp);            
            %%%
            % Set values to the gauges and text fields in GUI.
            
            obj.Data.Time_Buffer = [obj.Data.Time_Buffer; now];
            obj.Data.Heater_Percentage_Buffer ...
                = [obj.Data.Heater_Percentage_Buffer; heater_Percentage];
            obj.Data.Temp_Buffer = [obj.Data.Temp_Buffer; temp];
            
            if (obj.Flag.Log_On ...
                    && (length(obj.Data.Time_Buffer) >= obj.N_Buffer)) ...
                    || obj.Flag.Log_Stopped
                obj.log_Data();
            elseif length(obj.Data.Time_Buffer) > obj.N_Buffer
                obj.Data.Time_Buffer ...
                    = obj.Data.Time_Buffer(end + 1 - obj.N_Buffer : end);
                obj.Data.Heater_Percentage_Buffer ...
                    = obj.Data.Heater_Percentage_Buffer( ...
                    end + 1 - obj.N_Buffer : end, :);
                obj.Data.Temp_Buffer ...
                    = obj.Data.Temp_Buffer(end + 1 - obj.N_Buffer : end);
            end
            %%%
            % Log the data if: 
            %
            % # Logging ON/OFF switch is set to "On" (i.e. flag Log_On = 
            % 1) and the buffer is full; OR:
            % # One just returned Logging ON/OFF switch to "Off" and we
            % need to save the last bits of the data (i.e. flag Log_Stopped
            % = 1).
            %
            % The buffer will be cleared after data logging.
            %
            % Else, trim the data if it is longer than N_Buffer so that
            % there are always N_Buffer lines left.
            
            obj.Data.Time_Plot = [obj.Data.Time_Plot; now];
            obj.Data.Heater_Percentage_Plot ...
                = [obj.Data.Heater_Percentage_Plot; heater_Percentage];
            obj.Data.Temp_Plot = [obj.Data.Temp_Plot; temp];
            
            if length(obj.Data.Time_Plot) > plot_Length
                obj.Data.Time_Plot ...
                    = obj.Data.Time_Plot(end + 1 - plot_Length : end);
                obj.Data.Heater_Percentage_Plot ...
                    = obj.Data.Heater_Percentage_Plot( ...
                    end + 1 - plot_Length : end, :);
                obj.Data.Temp_Plot ...
                    = obj.Data.Temp_Plot(end + 1 - plot_Length : end, :);
            end
            %%%
            % Trim the data to be plotted to match the length specified in
            % GUI.
            if obj.Flag.Clear_Plot == 1
                cla(obj.CtrlGUI.HeaterPercentageUIAxes);
                cla(obj.CtrlGUI.TempCurrentUIAxes);
                %%%
                % Clear the axes.
                
                obj.Data.Time_Plot = [];
                obj.Data.Heater_Percentage_Plot = [];
                obj.Data.Temp_Plot = [];
                obj.Flag.Clear_Plot = 0;
                %%%
                % Reset the flag.
            end
            %%%
            % Clear the plot if the flag Clear_Plot is set.
            
            if length(obj.Data.Time_Plot) > 1
                obj.plot_Format(obj.CtrlGUI.HeaterPercentageUIAxes, ...
                    obj.Data.Time_Plot, ...
                    obj.Data.Heater_Percentage_Plot, ...
                    'HeaterPercentage');
                obj.plot_Format(obj.CtrlGUI.TempCurrentUIAxes, ...
                    obj.Data.Time_Plot, obj.Data.Temp_Plot, ...
                    'Temp');
            end
            %%%
            % Plot the data in GUI.
            
            if sum(obj.Driver.ErrCode ~= 0) > 2
                obj.timerErrFunc();
            end
            %%%
            % If there is too much errors on the driver side, stop the
            % timer and save the data.
        end
        
        %% Timer Error Function
        % This function is caller automatically when there is an unresolved
        % error happens when evaluating the timer function obj.timerFunc(),
        % or it is explicitly inside timer function following other
        % criteria.
        
        function timerErrFunc(obj, ~, ~)
            obj.disconnect_Controller()
            obj.CtrlGUI.ErrorStatLamp.Color = [1.00, 0.00, 0.00];
            
            %%%
            % Set Error Stat. lamp to red, and try to disconnect the heater
            % controller for protection.
            
        end
        
        %% Change Refresh Inteval
        % Change the interval that the system upates temperature and heater
        % percentage data.
        
        function change_RefreshInteval(obj, In_Event)
            if ~isempty(obj.Timer)
                if strcmp(obj.Timer.Running, 'on')
                    obj.Timer.stop();
                    obj.Timer.Period = In_Event.Value;
                    obj.Timer.start();
                else
                    obj.Timer.Period = In_Event.Value;
                end
            end
        end
        
        %% Update Logging Status
        % Set corresponding flags when Logging ON/OFF switch is changed by
        % user.
        
        function update_LogStatus(obj, In_Event)
            switch In_Event.Value
                case 'On'
                    obj.Flag.Log_On = 1;
                case 'Off'
                    obj.Flag.Log_Stopped = 1;
                    obj.Flag.Log_On = 0;
            end
        end
        
        %% Create Log File Foler
        % This function creates the folder for log file using path
        % specified in LogFileFolderEditFieldif it does not already exist.
        
        function create_Folder(obj)
            obj.Conf.Log_Path = obj.CtrlGUI.LogFileFolderEditField.Value;
            if ~isfolder(obj.Conf.Log_Path)
                msgboxStyle.Interpreter = 'tex';
                msgboxStyle.WindowStyle = 'modal';
                msgbox({'\fontsize{10}{\bfFolder does not exist!}', ... 
                    'Creating the folder now!'}, ...
                    'ERROR - Lake Shore 336', 'warn', msgboxStyle);
                try 
                    mkdir(obj.Conf.Log_Path)
                catch errMsg
                    obj.Conf.Log_Path = pwd;
                    obj.CtrlGUI.LogFileFolderEditField.Value ...
                        = obj.Conf.Log_Path;
                    msgbox({['\fontsize{10}{\bfFolder cannot be! ', ... 
                        'created!}'], ...
                        'Data will be stored in current folder'}, ...
                        'ERROR - Lake Shore 336', 'error', msgboxStyle);
                    warning(errMsg.message)
                end
            end
        end
        
        %% Create Blank Log File
        % This function creates a blank log file named in today's date if
        % it is not already exist.
        
        function create_LogFile(obj)
            obj.create_Folder();
            path = fullfile(obj.Conf.Log_Path, ...
                [datestr(now, 'yyyy-mm-dd'), '.txt']);
            if ~isfile(path)
                head = ['DateTime', ...
                    string( ...
                    char(64 + transpose(1 : obj.Conf.N_TempSensor)))', ...
                    string(1 : obj.Conf.N_Heater)];
                writematrix(head, path, 'Delimiter', 'tab');
                %%%
                % Create the file and write the head line.
                
            end
        end
        
        %% Log Data
        % Log data and clear the Log_Stopped flag.
        
        function log_Data(obj)
            obj.create_LogFile();
            
            path = fullfile(obj.Conf.Log_Path, ...
                [datestr(now, 'yyyy-mm-dd'), '.txt']);
            data = [datestr(obj.Data.Time_Buffer), ...
                string(obj.Data.Temp_Buffer), ...
                string(obj.Data.Heater_Percentage_Buffer)];
            try
                writematrix(data, path, ...
                    'Delimiter', 'tab', 'WriteMode', 'append');
                %%%
                % Just in case the date changes in the middle of excuting
                % this function, thus the path does not actually exist.
            catch errMsg
                obj.create_LogFile();
                warning(errMsg.message)
                writematrix(data, path, ...
                    'Delimiter', 'tab', 'WriteMode', 'append');
            end
            
            obj.Data.Time_Buffer = [];
            obj.Data.Temp_Buffer = [];
            obj.Data.Heater_Percentage_Buffer = [];
            %%%
            % Write data and clear buffers.
            
            obj.Flag.Log_Stopped = 0;
            %%%
            % Reset the Log_Stopped flag.
        end
        
        %% Goto Log File Foler
        % This function opens the path of log file folder when button /
        % menu is clicked.
        
        function goto_Folder(obj)
            obj.create_Folder();
            if ispc()
                winopen(obj.Conf.Log_Path)
            else
                msgboxStyle.Interpreter = 'tex';
                msgboxStyle.WindowStyle = 'modal';
                msgbox({'\fontsize{10}{\bfWindows only function!}', ...
                    'This function is only available on Windows.'}, ...
                    'ERROR - Lake Shore 336', 'warn', msgboxStyle);
            end
        end
        
        %% Goto Log File
        % This function opens the log file folder when the menu is
        % selected.
        
        function goto_LogFile(obj)
            obj.create_LogFile();
            path = fullfile(obj.Conf.Log_Path, ...
                [datestr(now, 'yyyy-mm-dd'), '.txt']);
            if ispc()
                try
                    winopen(path)
                catch errMsg
                    obj.create_LogFile();
                    winopen(path)
                    warning(errMsg.message)
                end
            else
                msgboxStyle.Interpreter = 'tex';
                msgboxStyle.WindowStyle = 'modal';
                msgbox({'\fontsize{10}{\bfWindows only function!}', ...
                    'This function is only available on Windows.'}, ...
                    'ERROR - Lake Shore 336', 'warn', msgboxStyle);
            end
        end
        
        %% Clear Plots
        % Clear the plots when Clear Plot button is pushed.
        
        function clear_Plot(obj)
            obj.Flag.Clear_Plot = 1;
            %%%
            % Set the flag.            
        end
        
        %% *Auxiliary Functions*
        % These functions do not need other class properties and methods to
        % work.        
        %% Convert Heater Levels to Lamp Colors
        % This function covert heater level to corresponding lamp colors in
        % GUI.
        
        function Out_Heater_Lamp_Color ...
                = heaterLevel2Color(~, In_Heater_Level)
            Out_Heater_Lamp_Color = zeros(2, 3);
            for n = 1 : length(In_Heater_Level)
                switch In_Heater_Level
                    case 0
                        Out_Heater_Lamp_Color(n, :) = [1.00, 1.00, 1.00];
                    case 1
                        Out_Heater_Lamp_Color(n, :) = [1.00, 1.00, 0.07];
                    case 2
                        Out_Heater_Lamp_Color(n, :) = [1.00, 0.41, 0.16];
                    case 3
                        Out_Heater_Lamp_Color(n, :) = [1.00, 0.00, 0.00];
                end
                %%%
                % 0 = White = Off, 1 = Yellow = Low, 2 = Orange = Medium, 
                % 3 = Red = High.
                
            end
        end
        
        %% Convert Heater Levels to Text Labels
        % This function covert heater level to corresponding text labels in
        % User Inputs panel of the GUI.
        
        function Out_Heater_Level_Text ...
                = heaterLevel2Text(~, In_Heater_Level)
            Out_Heater_Level_Text = ["Off", "Off"];
            for n = 1 : length(In_Heater_Level)
                switch In_Heater_Level
                    case 0
                        Out_Heater_Level_Text(n) = "Off";
                    case 1
                        Out_Heater_Level_Text(n) = "Low";
                    case 2
                        Out_Heater_Level_Text(n) = "Medium";
                    case 3
                        Out_Heater_Level_Text(n) = "High";
                end
                %%%
                % 0 = Off, 1 = Low, 2 = Medium, 3 = High.
                
            end
        end
        
        %% Convert Text Labels to Heater Levels
        % This function covert text labels to corresponding heater levels.
        
        function Out_Heater_Level ...
                = text2HeaterLevel(~, In_Heater_Level_Text)
            switch In_Heater_Level_Text
                case "Off"
                    Out_Heater_Level = 0;
                case "Low"
                    Out_Heater_Level = 1;
                case "Medium"
                    Out_Heater_Level = 2;
                case "High"
                    Out_Heater_Level = 3;
            end
            %%%
            % 0 = Off, 1 = Low, 2 = Medium, 3 = High.
                
        end
        
        %% Format Plots
        % Format the plots such that the ticks and labels are always
        % suitable for current data.
        
        function plot_Format(~, In_Axes, In_Time, In_Data, In_Type)
            plot(In_Axes, In_Time, In_Data, 'LineWidth', 1.5)
            
            switch In_Type
                case 'Temp'
                    labels = cellstr( ...
                        char(64 + transpose(1 : size(In_Data, 2))))';
                case 'HeaterPercentage'
                    labels = cellstr(string(1 : size(In_Data, 2)));
            end
            plot_Legend = legend(In_Axes, labels);
            plot_Legend.Box = 'off';
            plot_Legend.FontSize = 9;
            
            In_Axes.XLim = [min(In_Time), max(In_Time)];
            In_Axes.YLim = [min(In_Data, [], 'all'), ...
                max(In_Data, [], 'all') + 0.01];
            %%%
            % Just in case all the data are the same causing y-axis limit
            % to freak out, we add 0.01.
            
            In_Axes.XTickMode = 'auto';
            In_Axes.XTickLabelMode = 'auto';
            In_Axes.YTickMode = 'auto';
            In_Axes.YTickLabelMode = 'auto';
            In_Axes.XAxis.TickLabelRotation = 60;
            
            if range(In_Time) < 1 / 24
                %%%
                % If less than an hour, label plot use minutes and seconds
                % only.
                
                datetick(In_Axes, 'x', 'MM:SS')
                In_Axes.XLabel.String = "Time (MM:SS)";
            elseif range(In_Time) < 1
                datetick(In_Axes, 'x', 'HH:MM')
                In_Axes.XLabel.String = "Time (HH:MM)";
            else
                datetick(In_Axes, 'x', 'mm/dd')
                In_Axes.XLabel.String = "Date (mm/dd)";
            end
        end
    end

end