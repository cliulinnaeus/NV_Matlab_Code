%% MATLAB Driver for Lake Shore 336 Heater Controller
% Provide a class that includes all the basic controls and error handling
% of Lake Shore 336 heater controller using serial / USB connection, for
% intance: create and terminate connection, set heater level, get
% temperature readings.
%
% * This script is developed and tested by *Yuanqi Lyu*
% (yuanqilyu@berkeley.edu) at *University of California, Berkeley*. All
% rights reserved.
% * This script is tested to be compatiable with *MATLAB 2020b* in Feb
% 2021.
% * The manual of the heater controller can be downloaded from
% <https://www.lakeshore.com/docs/default-source/product-downloads/336_manual.pdf
% Lake Shore> support website.
% * *Standard disclaimer*: there is no spelling check function for the
% comments.
% * This script and its corresponding project is available on 
% <https://github.com/Yuanqi137/LakeShoreController GitHub>.
%

classdef class_Driver_LS336 < handle
    %%%
    % This is a MATLAB handle class
    % (<https://www.mathworks.com/help/matlab/handle-classes.html 
    % ref>), which provide real time value change in class method 
    % functions.
    %% *PROPERTIES*
    % Properties, values and settings of the heater controller.
    %% Constant properties
       
    properties (Constant)
        %%%
        % Do *NOT* manually edit.
        SerialPort_BaudRate = 57600;
        SerialPort_Conf = struct(...
            'DataBits', 7, ...
            'StopBits', 1, ...
            'Parity', 'odd', ...
            'FlowControl', 'none', ...
            'Timeout', 5);
        %%%
        % *SerialPort_BaudRate* (_double_ - constant):
        % This is the required baud rate for Lake Shore 336 (ref: _Manual_
        % section 6.3.2 [p. 104], same for SerialPort_Conf).
        %
        % *SerialPort_Conf* (_struct_ - constant):
        % This struct contains all parameter of the serial port connection 
        % required by Lake Shore 336.
        
        %%%
        % Adjust by needs.
        Time_Wait = 0.1
        %%%
        % *Time_Wait* (_double_ - constant):
        % Number of second to wait so that the last operation is complete,
        % use between consecutive send_Command() and / or send_Query().
    end
    %% Public Accessible Properties
    
    properties (Access = public)
        ErrCode = zeros(1, 20);
        %%%
        % *ErrCode* (_double (matrix)_):
        % Error code generated when executing the class methods, here:
        %
        % * 1 or -1 stands for serial connection error or instability, 
        % generally the connection will be recreated afterwards.
        % * 2 or -2 stands for communication error, where the intended 
        % parameter for the heater is not set correctly.
        % * 3 or -3 stands for the number of heater / temperature sensor
        % addressed in a command is longer than that of the connected.
        %
        % The last 20 result of error codes is stored.
        
        N_Heater = 1;
        N_TempSensor = 1;
        %%%
        % *N_Heater* and *N_TempSenor* (_double_):
        % Number of heaters and temperature sensors connected to the heater
        % controller. Lake Shore 336 allows maximum of 2 heaters and 4
        % temperature sensor inputs. For sake of simplicity, please connect
        % the heaters and temperature sensors from lower number slots to
        % higher number slots (1 to 2, A to D).
        
        SerialNumber        
        SerialPort
        SerialPort_Name
        %%%
        % *SerialPort* (_serial port object_):
        % The serial connection between the computer and the heater 
        % controller. This property is created when the class in
        % contructed. Deletion of this property will terminate the serial 
        % connection, which happens automatically when a class instance 
        % is deleted.
        %
        % *SerialPort_Name* (_string_):
        % Name of the serial port, e.g. "COM5".
        
        Heater_Percentage
        Heater_Level = 0;
        Heater_Level_Targ = 0;
        Heater_Conf = struct( ...
            'Connected', 1, ...
            'Type', 0, ...
            'Resistance', 2, ...
            'MaxCurrent', 0, ...
            'MaxUserCurrent', 0.000, ...
            'Display', 1);
        %%%
        % *Heater_Level* (_double (matrix)_):
        % Current levels of heaters: 0 = Off, 1 = Low, 2 = Medium, 3 =
        % High.
        %
        % *Heater_Level_Targ* (_double (matrix)_):
        % Target levels of heaters after they were turned on: 
        % 1 = Low, 2 = Medium, 3 = High.
        %
        % *Heater_Conf* (_struct_):
        % This is the configuration for the heaters connected to the
        % controller (ref: _Manual_ section 6.6.1 [p. 132]). Here are 
        % details of each field:
        % 
        % * _Type_: Output type (Output 2 only): 0 = Current, 1 = Voltage.
        % * _Connected_: Connected heater: 1, 2 or [1, 2].
        % * _Resistance_: Heater resistence: 1 = 25 Ohm, 2 = 50 Ohm. If 
        % both heaters are connected, then use a 1-by-2 matrix, e.g. [0, 0]
        % (same for the rest of the fields).
        % * _MaxCurrent_: Maximum heater output current: 0 = User 
        % Specified, 1 = 0.707 A, 2 = 1 A, 3 = 1.141 A, 4 = 1.732 A.
        % * _MaxUserCurrent_: Maximum heater output current specified by
        % user if _MaxCurrent_ is set to be zero. (_three decimal points 
        % signed_)
        % * _Display_: Specifies whether the heater output displays in 
        % current or power (current mode only): 1 = Current, 2 = Power.
        %
        
        Temp
        Temp_Targ
        TempSensor_Conf = struct( ...
            'Connected', 'A', ...
            'Type', 2, ...
            'AutoRange', 0, ...
            'Range', 0, ...
            'Compensation', 0, ...
            'Units', 1);
        %%%
        % *Temp* (_double (matrix)_): 
        % Current temperature readout by the sensors (A, B, C, D or 
        % conbinations determined by connected sensors). Its unit should be
        % in K, unless specified otherwise by TempSensor_Conf.Units.
        %
        % *Temp_Targ* (_double (matrix)_): 
        % Target temperature to be achieved by heaters (1, 2 or both).Its
        % unit should be in K, or specified by TempSensor_Conf.Units.
        %
        % *TempSensor_Conf* (_struct_):
        % This is the configuration for the temperature sensors connected 
        % to the controller (ref: _Manual_ section 6.6.1 [p. 135]). Here
        % are details of each field:
        %
        % * _Connected_ (_char (array)_): Connected temperature sensor:
        % 'A', 'B', 'C', 'D' or combinations like 'AB', 'AC', 'ABCD'.
        % * _Type_: input sensor type: 0 = Disabled, 1 = Diode, 2 = 
        % Platinum RTD, 3 = NTC RTD, 4 = Thermocouple. If both temperature
        % sensors are connected, then use a 1-by-2 matrix, e.g. [2, 2]
        % (same for the rest of the fields).
        % * _AutoRange_: Autorange: 0 = Off, 1 = On.
        % * _Range_: Specifies input range when autorange is off. See table
        % 6-8 (_Manual_ [p. 135]).
        % * _Compensation_: Input compensation: 0 = Off, 1 = On.
        % * _Units_: Unit for sensor readings *AND* control setpoint: 1 = 
        % Kelvin, 2 = Celsius, 3 = Sensor.
        %
        
    end
    %% *METHODS*
    methods
        %% *Fundamental Functions*
        % Essential functions that enable communication between the
        % computer and heater controller with basic error handling.
        %% Class Constructor & Initialization Function
        % Create an class instance and initialize the connection to the 
        % heater controller.
        %
        % *Inputs*
        %
        % * In_SerialPort_Name (_string_): Name of the serial port, e.g.
        % "COM5".
        % * In_N_Heater (_double_): Number of heaters connected to the
        % controller, must be 1 or 2.
        % * In_N_TempSensor (_double_): Number of temperature sensors
        % connected, but be integer between 1 and 4.
        % * vargin (_optional inputs_): If provided, it must be in the
        % shape of name-valued pair: "HeaterConf", Heater_Conf (_struct_
        % that matches *all* the field listed in class property
        % Heater_Conf), "TempSensorConf", TempSensor_Conf (_struct_ that
        % matches *all* the field listed in class property
        % TempSensor_Conf).
        
        function [obj, Out_ErrCode] = class_Driver_LS336( ...
                In_SerialPort_Name, In_N_Heater, In_N_TempSensor, varargin)
            obj.SerialPort_Name = In_SerialPort_Name;
            obj.create_SerialPort();
            
            obj.N_Heater = In_N_Heater;
            obj.N_TempSensor = In_N_TempSensor;
                     
            if ~isempty(varargin)
                In_Conf = struct(varargin{:});
                if isfield(In_Conf, 'HeaterConf')
                     obj.set_HeaterConf(In_Conf.HeaterConf);
                end
                if isfield(In_Conf, 'TempSensorConf')
                    obj.set_TempSensorConf(In_Conf.TempSensorConf);
                end
            end
            %%%
            % If specified in the input, update heater and temperature
            % sensor configurations.
                        
            obj.update_AllProperties();
            %%% 
            % Update all the class properties.
            
            Out_ErrCode = obj.ErrCode(end);            
        end
        
        %% Class Destructor
        % This function is excuted before the instance of the class is
        % destroyed.
        
        function delete(obj)
            if ~isempty(obj.SerialPort)
                obj.terminate_SerialPort();
            end
        end
        
        %% Error Codes Display
        % This function is used to display user friendly information based
        % on the error code encountered during excutions of the class
        % methods. It is applied liberally in all other methods. 
        
        function error_Handling(obj)
            msgboxStyle.Interpreter = 'tex';
            msgboxStyle.WindowStyle = 'modal';
            if any(obj.ErrCode == 1)
                %%%
                % Serial communication instability.

                msgbox({['\fontsize{10}{\bfUnable to establish stable ' ...
                    'serial connection!}'], ...
                    ['The serial port requested may be currently in ' ...
                    'use by other programs!'], ...
                    'Check WARNING!'}, ...
                    'ERROR - Lake Shore 336', 'error', msgboxStyle);
                obj.ErrCode(obj.ErrCode == 1) = - 1;
            elseif any(obj.ErrCode == 2)
                %%%
                % Target settings are different from current settings.

                msgbox({['\fontsize{10}{\bfUnable to complete ' ...
                    'required setting!}'], ...
                    ['Current parameters of the heater may not be ' ...
                    'desired values!'], ...
                    'Check WARNING!'}, ...
                    'ERROR - Lake Shore 336', 'warn', msgboxStyle);
                obj.ErrCode(obj.ErrCode == 2) = - 2;
             elseif any(obj.ErrCode == 3)
                %%%
                % Number of heater / sensor in command is larger than that
                % of connected.

                msgbox({['\fontsize{10}{\bfToo many heater / ', ...
                    'temperature sensor in command!}'], ...
                    sprintf(['There is / are %.0f heater(s) and %.0f ', ...
                    'temperature sensor(s) connected!'], ...
                    obj.N_Heater, obj.N_TempSensor)}, ...
                    'ERROR - Lake Shore 336', 'warn', msgboxStyle);
                obj.ErrCode(obj.ErrCode == 2) = - 3;
            end
            if sum(obj.ErrCode ~= 0) > 3
                %%%
                % Too many errors.
                
                msgbox({['\fontsize{10}{\bfToo many errors! ', ... 
                    'Program halted!}'], ...
                    'Check WARNING!'}, ...
                    'ERROR - Lake Shore 336', 'error', msgboxStyle);
                return
            end
        end
        
        %% Serial Port - Creation
        % This function creates the serial port needed for connection based
        % on class properties SerialPort_Name, SerialPort_BaudRate and
        % SerialPort_Conf.
        
        function [Out_ErrCode, Out_SerialPort] = create_SerialPort(obj)
            serialPort_Conf_Cell = namedargs2cell(obj.SerialPort_Conf);
            %%% 
            % Here we convert obj.SerialPort_Conf to cell so that it can be
            % passed as name-value pairs in the serialport() function.
            
            try
                Out_SerialPort = serialport(...
                    obj.SerialPort_Name, ...
                    obj.SerialPort_BaudRate, ...
                    serialPort_Conf_Cell{:});
                %%%
                % The serialport() function (<https://www.mathworks.com/help/matlab/ref/serialport.html ref>)
                % and related object / object function are the new protocal
                % MATLAB(R) try to push for serial connection after version
                % 2019b.
                
                Out_ErrCode = 0;
            catch errMsg
                Out_SerialPort = [];
                Out_ErrCode = 1;
                warning(errMsg.message)
            end
            obj.SerialPort = Out_SerialPort;
            obj.ErrCode = circshift(obj.ErrCode, - 1);
            obj.ErrCode(end) = Out_ErrCode;
            %%%
            % Circular shift the array of error codes so that there are
            % always 20 of them stored.
            
            obj.error_Handling();          
        end
        
        %% Serial Port - Termination
        % This fucntion terminates the serial connection by deleting the
        % serial port object created as class property.
        
        function Out_ErrCode = terminate_SerialPort(obj)
            delete(obj.SerialPort);
            obj.ErrCode = circshift(obj.ErrCode, - 1);
            obj.ErrCode(end) = 0;
            Out_ErrCode = obj.ErrCode(end);
        end
        
        %% Serial Port - Recreation
        % This function is to improve the robustness of the driver.
        % Generally, if an error happens during some operation, we use this
        % function to recreate the serial port and try again.

        function [Out_ErrCode, Out_SerialPort] = recreate_SerialPort(obj)
            obj.terminate_SerialPort();
            [Out_ErrCode, Out_SerialPort] = obj.create_SerialPort();
        end
        
        %% Serial Port - Send Command
        % This function sends command via the serial port using the
        % .writeline() object function of serialport.
        
        function Out_ErrCode = send_Command(obj, In_Command)
            try
                obj.SerialPort.writeline(In_Command);
                obj.ErrCode = circshift(obj.ErrCode, - 1);
                obj.ErrCode(end) = 0;
            catch errMsg
                %%%
                % Recreate the serial port if encountered any connection
                % issue while writing data and set the error code to 1.
                
                obj.ErrCode = circshift(obj.ErrCode, - 1);
                obj.ErrCode(end) = 1;
                obj.recreate_SerialPort();
                obj.SerialPort.writeline(In_Command);
                warning(errMsg.message)
            end
            Out_ErrCode = obj.ErrCode(end);
            obj.error_Handling();
        end
        
        %% Serial Port - Query
        % This function sends command via the serial port using the
        % .writeline() and .readline() object functions of serialport.
        
        function [Out_ErrCode, Out_Response] = send_Query(obj, In_Query)
            try
                obj.SerialPort.writeline(In_Query);
                Out_Response = obj.SerialPort.readline();
                obj.ErrCode = circshift(obj.ErrCode, - 1);
                obj.ErrCode(end) = 0;
            catch errMsg
                obj.ErrCode = circshift(obj.ErrCode, - 1);
                obj.ErrCode(end) = 1;
                obj.recreate_SerialPort();
                obj.SerialPort.writeline(In_Query);
                Out_Response = obj.SerialPort.readline();
                warning(errMsg.message)
            end
            Out_ErrCode = obj.ErrCode(end);
            obj.error_Handling();
            pause(obj.Time_Wait)
        end
        
        %% *Higher-level Functions*
        % The functions that acutually change the settings and acquire the
        % data from the heater controller. The reference of the serial 
        % commands used in the functions bellow can be found in the manual
        % (ref: _Manual_ section 6.6 [p. 124]).
        %% Get the Serial Number of the Heater Controller
                
        function [Out_ErrCode, Out_SerialNumber] = get_SerialNumber(obj)
            [~, response] = obj.send_Query("*IDN?");
            Out_SerialNumber = extractBetween(response, 15, 21);
            %%%
            % Get part of the return that is the serial number (ref:
            % _Manual_ [p.125]).
            
            obj.ErrCode = circshift(obj.ErrCode, - 1);
            obj.ErrCode(end) = 2 * isempty(Out_SerialNumber);
            %%%
            % obj.ErrCode = 2 if somehow the serail number obtained is 
            % empty, else it is 0.
            
            obj.SerialNumber = Out_SerialNumber;
            %%%
            % Update the relavent class property.
            
            Out_ErrCode = obj.ErrCode(end);
            obj.error_Handling();
        end
        
        %% Obtain Current Heater Configuration
        % This function queries *both* heaters' configurations from the 
        % controller, and stores them in class property Heater_Conf (near 
        % line 75-ish, ref: _Manual_ section 6.6.1 [p. 134]).
        
        function [Out_ErrCode, Out_Heater_Conf] = get_HeaterConf(obj)
            for n = 1 : obj.N_Heater
                [~, response] = obj.send_Query( ...
                    sprintf("HTRSET?%.0f", n));
                Out_Heater_Conf.Connected(n) = n;
                response = str2num(response); %#ok<*ST2NM>
                %%%
                % Ignore the stupid warning about str2num() here! The same
                % applies for the rest of the code. The "%#ok<*ST2NM>" is
                % to supress this warning.
                
                Out_Heater_Conf.Type(n) = response(1);
                Out_Heater_Conf.Resistance(n) = response(2);
                Out_Heater_Conf.MaxCurrent(n) = response(3);
                Out_Heater_Conf.MaxUserCurrent(n) = response(4);
                Out_Heater_Conf.Display(n) = response(5);
            end
            Out_ErrCode = obj.ErrCode(end);
            obj.Heater_Conf = Out_Heater_Conf;
            obj.error_Handling();
        end
                
        %% Set Heater Configuration
        % This function set heater configuration from the input. 
        %
        % *Input*
        % 
        % * In_Heater_Conf (_struct_ that matches *all* the fields
        % listed in class property Heater_Conf defined near line 75-ish, 
        % ref: _Manual_ section 6.6.1 [p. 136]).
        
        function Out_ErrCode = set_HeaterConf(obj, ...
                In_Heater_Conf)
            for n = 1 : length(In_Heater_Conf.Connected)
                command = sprintf("HTRSET%.0f,%.0f,%.0f,%.0f,+%.3f,%.0f", ...
                    In_Heater_Conf.Connected(n), ...
                    In_Heater_Conf.Type(n), ...
                    In_Heater_Conf.Resistance(n), ...
                    In_Heater_Conf.MaxCurrent(n), ...
                    In_Heater_Conf.MaxUserCurrent(n), ...
                    In_Heater_Conf.Display(n));
                obj.send_Command(command);
                pause(obj.Time_Wait)
                %%%
                % Pause a bit so that the setting can be changed on the
                % heater side.
                
                [~, response] = obj.send_Query(sprintf("HTRSET?%.0f", n));
                obj.ErrCode = circshift(obj.ErrCode, - 1);
                obj.ErrCode(end) = 2 * ~isequal( ...
                    str2num(extractBetween(command, 9, 22)), ...
                    str2num(response));
                %%%
                % Compare current setting of the heater with the intended,
                % if the two are not the same, then set the error code to
                % 2.
                
            end
            obj.get_HeaterConf();
            %%%
            % Update the current heater configurations in class properties.
            
            Out_ErrCode = obj.ErrCode(end);
            obj.error_Handling();
        end
        
        %% Set Target Heater Level
        % This function set the target heater level, which only become
        % effective *after* the heater is turned on using 
        % obj.set_HeaterONOFF() class function.
        %
        % *Inputs*
        %
        % * In_Heater_Level_Targ (_double (matrix)_): Target heater levels,
        % 0 = Off, 1 = Low, 2 = Medium, 3 = High. If only have one value,
        % e.g. 1, then it only applies to heater 1 (low); if there are two
        % values arranged in a 2-by-1 matrix, e.g. [2, 1], then it applies
        % to both heaters (heater 1: medium, heater 2: low).
        %
        
        function Out_ErrCode = set_HeaterLevelTarg(obj, ...
                In_Heater_Level_Targ)
            if length(In_Heater_Level_Targ) > obj.N_Heater
                obj.ErrCode = circshift(obj.ErrCode, - 1);
                obj.ErrCode(end) = 3;
                obj.error_Handling();
                In_Heater_Level_Targ = In_Heater_Level_Targ( ...
                    1 : obj.N_Heater);
            end
            %%%
            % Trim the extra commands when there are more heaters in
            % command than connected.
            
            obj.Heater_Level_Targ = In_Heater_Level_Targ;            
            Out_ErrCode = obj.ErrCode(end);
        end
        
        %% Get Current Heater Levels
        % This function querys current heater levels on *both* heater 
        % outputs.
        
        function [Out_ErrCode, Out_Heater_Level] = get_HeaterLevel(obj)
            Out_Heater_Level = zeros(1, obj.N_Heater);
            for n = 1 : obj.N_Heater
                [~, response] = obj.send_Query( ...
                    sprintf('RANGE?%.0f', n));
                Out_Heater_Level(n) = str2double(response);
            end
            obj.Heater_Level = Out_Heater_Level;
            Out_ErrCode = obj.ErrCode(end);
        end
        
        %% Get Current Heater Percentages
        % This function querys current heater percentages on *both* heater 
        % outputs.
        
        function [Out_ErrCode, Out_Heater_Percentage] ...
                = get_HeaterPercentage(obj)
            Out_Heater_Percentage = zeros(1, obj.N_Heater);
            for n = 1 : obj.N_Heater
                [~, response] = obj.send_Query( ...
                    sprintf('HTR?%.0f', n));
                Out_Heater_Percentage(n) = str2double(response);
            end
            obj.Heater_Percentage = Out_Heater_Percentage;
            Out_ErrCode = obj.ErrCode(end);
        end
                
        %% Turn ON/OFF the Heaters
        % This function turn on/off the heater and set them to the target
        % heater levels defined as class property of Heater_Level.
        %
        % *Inputs*
        %
        % * In_Heater_ONOFF (_double (matrix)_): 1 = On, 0 = Off, if the
        % input is a single number, then only heater 1 is turned ON/OFF;
        % else if the input is a 2-by-1 matrix, e.g. [0, 1], both heaters
        % are addressed (here heater 1: OFF, heater 2: ON).
        %
        
        function [Out_ErrCode, Out_Heater_Level] = set_HeaterONOFF(obj, ...
                In_Heater_ONOFF)
            if length(In_Heater_ONOFF) > obj.N_Heater
                obj.ErrCode = circshift(obj.ErrCode, - 1);
                obj.ErrCode(end) = 3;
                obj.error_Handling();
                In_Heater_ONOFF = In_Heater_ONOFF( ...
                    1 : obj.N_Heater);
            end
            for n = 1 : length(In_Heater_ONOFF)
                obj.send_Command( ...
                    sprintf('RANGE%.0f,%.0f', ...
                    n, In_Heater_ONOFF * obj.Heater_Level_Targ(n)));
            end
            pause(obj.Time_Wait)
            [~, Out_Heater_Level] = obj.get_HeaterLevel();
            Out_Heater_Level ...
                = Out_Heater_Level(1 : length(In_Heater_ONOFF));
            obj.ErrCode = circshift(obj.ErrCode, - 1);
            obj.ErrCode(end) = 2 * ~isequal(...
                    In_Heater_ONOFF * obj.Heater_Level_Targ( ...
                        1 : length(In_Heater_ONOFF)), ...
                    Out_Heater_Level);
                %%%
            % Check if the current heater levels set on the heater are the
            % target values. If not then set the error code to 2 and
            % display a warning.
            Out_ErrCode = obj.ErrCode(end);
            obj.error_Handling();
        end
        
        %% Set Maximum User Current Output of the Heaters
        % This function sets the maximum heater output current. (ref:
        % _Manual_ [p. 133]).
        %
        % *Inputs*
        %
        % * In_MaxUserCurrent (_double (matrix)_): If the input is a single
        % number, then only heater 1 is configured, else if the input is a 
        % 2-by-1 matrix, e.g. [1.2, 1.3], then both heaters are configured
        % (here heater 1: 1.2 A, heater 2: 1.3 A).
        %
        
        function Out_ErrCode = set_MaxUserCurrent(obj, In_MaxUserCurrent)
            obj.get_HeaterConf();
            if length(In_MaxUserCurrent) > obj.N_Heater
                obj.ErrCode = circshift(obj.ErrCode, - 1);
                obj.ErrCode(end) = 3;
                obj.error_Handling();
                In_MaxUserCurrent = In_MaxUserCurrent( ...
                    1 : obj.N_Heater);
            end
            for n = 1 : length(In_MaxUserCurrent)
                obj.Heater_Conf.MaxCurrent(n) = 0; 
                %%%
                % Set mode of maximum output current to user defined.
                
                obj.Heater_Conf.MaxUserCurrent = In_MaxUserCurrent(n);
            end
            obj.set_HeaterConf(obj.Heater_Conf);
            Out_ErrCode = obj.ErrCode(end);
            obj.error_Handling();
        end
        
        %% Get Current Temperature Sensor Configuration
        % This function queries *all* temperature sensors' configurations 
        % from the controller, and stores them in class property 
        % TempSensor_Conf (near line 110-ish, ref: _Manual_ section 6.6.1 
        % [p. 136]).
        
        function [Out_ErrCode, Out_TempSensor_Conf] ...
                = get_TempSensorConf(obj)
            for n = 1 : obj.N_TempSensor
                [~, response] = obj.send_Query( ...
                    sprintf("INTYPE?%s", char(64 + n)));
                %%%
                % char(64 + n) returns the n-th capital letter in the
                % alphabet.
                
                Out_TempSensor_Conf.Connected(n) = char(64 + n);
                Out_TempSensor_Conf.Type(n) = str2double( ...
                    extractBetween(response, 1, 1));
                Out_TempSensor_Conf.AutoRange(n) = str2double( ...
                    extractBetween(response, 3, 3));
                Out_TempSensor_Conf.Range(n) = str2double( ...
                    extractBetween(response, 5, 5));
                Out_TempSensor_Conf.Compensation(n) = str2double( ...
                    extractBetween(response, 7, 7));
                Out_TempSensor_Conf.Units(n) = str2double( ...
                    extractBetween(response, 9, 9));
            end
            Out_ErrCode = obj.ErrCode(end);
            obj.TempSensor_Conf = Out_TempSensor_Conf;
        end
                
        %% Set Temperature Sensor Configuration
        % This function set temperature sensor configuration from the 
        % input. 
        %
        % *Input*
        % 
        % * In_TempSensor_Conf (_struct_ that matches *all* the fields 
        % listed in class property TempSensor_Conf defined near line 
        % 110-ish, ref: _Manual_ section 6.6.1 [p. 136]).
        %
        
        function Out_ErrCode = set_TempSensorConf(obj, ...
                In_TempSensor_Conf)
            if length(In_TempSensor_Conf.Connected) > obj.N_TempSensor
                obj.ErrCode = circshift(obj.ErrCode, - 1);
                obj.ErrCode(end) = 3;
                obj.error_Handling();
                In_TempSensor_Conf.Connected ...
                    = In_TempSensor_Conf.Connected(1 : obj.N_TempSensor);
            end
            for n = 1 : length(In_TempSensor_Conf.Connected)
                command = sprintf("INTYPE%s,%.0f,%.0f,%.0f,%.0f,%.0f", ...
                    In_TempSensor_Conf.Connected(n), ...
                    In_TempSensor_Conf.Type(n), ...
                    In_TempSensor_Conf.AutoRange(n), ...
                    In_TempSensor_Conf.Range(n), ...
                    In_TempSensor_Conf.Compensation(n), ...
                    In_TempSensor_Conf.Units(n));
                obj.send_Command(command);
                pause(obj.Time_Wait)
                [~, response] = obj.send_Query( ...
                    sprintf("INTYPE?%s", In_TempSensor_Conf.Connected(n)));
                obj.ErrCode = circshift(obj.ErrCode, - 1);
                obj.ErrCode(end) = 2 * ~isequal( ...
                    str2num(extractBetween(command, 9, 17)), ...
                    str2num(response));
            end
            obj.get_TempSensorConf();
            Out_ErrCode = obj.ErrCode(end);
            obj.error_Handling();
        end
        
        %% Get Current Target Temperature Level
        % This function quries the target temperature levels on *all* 4
        % temperature sensors. The unit is by default K, unless otherwise
        % speficied in class property TempSensor_Conf.Units (near line
        % 110-ish, ref: _Manual_ Section 6.6.1 [p. 134]).
        
        function [Out_ErrCode, Out_Temp_Targ] = get_TempTarg(obj)
            Out_Temp_Targ = zeros(1, obj.N_TempSensor);
            for n = 1 : obj.N_TempSensor
                [~, response] = obj.send_Query( ...
                    sprintf("SETP?%.0f", n));
                Out_Temp_Targ(n) = str2double(response);
            end
            obj.Temp_Targ = Out_Temp_Targ;
            Out_ErrCode = obj.ErrCode(end);
        end
        
        %% Set Target Temperature Level
        % This function set the target temperature levels.
        %
        % *Inputs*
        %
        % * In_Temp_Targ (_double (matrix)_): Target temperature values in
        % K. If the input is n-by-1 matrix, then the first n of the 4
        % temperature sensors are configured.
        %
        
        function Out_ErrCode = set_TempTarg(obj, In_Temp_Targ)
            if length(In_Temp_Targ) > obj.N_TempSensor
                obj.ErrCode = circshift(obj.ErrCode, - 1);
                obj.ErrCode(end) = 3;
                obj.error_Handling();
                In_Temp_Targ = In_Temp_Targ(1 : obj.N_TempSensor);
            end
            for n = 1 : length(In_Temp_Targ)
                obj.send_Command( ...
                    sprintf("SETP%.0f,%.1f", n, In_Temp_Targ(n)));
            end
            pause(obj.Time_Wait)
            [~, temp_Targ] = obj.get_TempTarg();
            obj.ErrCode = circshift(obj.ErrCode, - 1);
            obj.ErrCode(end) = 2 * ~isequal( ...
                temp_Targ(1 : length(In_Temp_Targ)), In_Temp_Targ);
            Out_ErrCode = obj.ErrCode(end);
            obj.error_Handling();
        end
        
        %% Get Current Temperature Readings
        % This function queries current temperature readings on the sensors
        % selected by input. Unit in K. (ref: _Manual_ Section 6.6.1 [p.
        % 137])
        %
        % *Inputs*
        %
        % * In_Sensor_Select (_char (array)_): Selection of temperature
        % sensors, e.g. 'A', 'B', 'AB', 'AC' or 'ABCD'. If empty, then all
        % temperature readings will be queried.
        %
        
        function [Out_ErrCode, Out_Temp] = get_Temp(obj, varargin)
            if isempty(varargin)
                In_Sensor_Select = char(64 + (1 : obj.N_TempSensor));
            else
                In_Sensor_Select = varargin{:};
            end
            if length(In_Sensor_Select) > obj.N_TempSensor
                obj.ErrCode = circshift(obj.ErrCode, - 1);
                obj.ErrCode(end) = 3;
                obj.error_Handling();
                In_Sensor_Select = In_Sensor_Select(1 : obj.N_TempSensor);
            end
            [~, response] = obj.send_Query("KRDG?");
            %%%
            % The function will always queries temperature readings on
            % *all* sensors and update the result in class property Temp.
            
            obj.Temp = str2num(response);
            Out_Temp = obj.Temp(double(In_Sensor_Select) - 64);
            %%%
            % double() - 64 returns the corresponding sequence numbers of 
            % letters in alphabet (capital), e.g. double('A') - 64 = 1, 
            % double('ACD') - 64 = [1 3 4].
            
            Out_ErrCode = obj.ErrCode(end);
        end
        
        %% Update All Class Properties
        % This function updates all class properties.
        
        function Out_ErrCode = update_AllProperties(obj)
            obj.get_SerialNumber();
            obj.get_HeaterConf();
            obj.get_HeaterLevel();
            obj.get_HeaterPercentage();
            obj.get_TempSensorConf();
            obj.get_TempTarg();
            obj.get_Temp();
            Out_ErrCode = obj.ErrCode(end);           
        end
    end
end