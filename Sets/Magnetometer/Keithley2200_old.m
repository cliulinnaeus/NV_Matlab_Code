classdef Keithley2200 < handle
    % Keithley2200 is a class to create a virtual reference to the
    % instrument in the Matlab enviornment with basic commands
    % TO BE IMPROVED OVER TIME
    
    properties
        ni_ref;  % ni VISA reference address of the object   
        visa;    % reference to the visa object created to talk to the instrument
        voltage; % value of the voltage being output by the instrument
        current; % value of the current being output by the instrument
        state;   % output state of the instruement (can be 1 for ON or 0 for OFF)
        mode;    % output mode of the power supply (Constant Voltage or Constant Current) 
        busy;    % true if any of the functions are being called
    end
    
    methods
        function obj= Keithley2200(ref)
            obj.ni_ref= ref;
            obj.visa= instrfind({'Type','ModelCode'},{'visa-usb','0x2200'});
            if isempty(obj.visa)
                obj.visa= visa('ni',ref);
            else
                fclose(obj.visa);
                obj.visa= visa('ni',ref);
            end
            obj.IDN();
            obj.Query();
            fclose(obj.visa);   
        end
        
        function open(obj)
            % fopens the object if it is closed
            % if the object is already open this method doesn't do
            % anything
            % Writing a separate method to open the object to prevent it
            % from being opened multiple times
            switch obj.visa.Status
                case 'open'
                    return
                case 'closed'
                    fopen(obj.visa);
            end
        end
        
        function close(obj)
            % fcloses the object if it is open. If it closed this method
            % does not do anything.
            % Writing a separate method to close the object in just to keep
            % the code consistent and pretty
            switch obj.visa.Status
                case 'open'
                    fclose(obj.visa);
                case 'closed'
                    return
            end
        end
        
        function IDN(obj)
            % just a test command to query the device on startup to make
            % sure everyhting is working fine
            obj.open();
            msg= query(obj.visa,'*IDN?');
            if isempty(msg)
                warning('Unable to query Keithley at port %s',obj.visa.Name);
            else
                disp(msg);
            end
            obj.close();
        end
        
        function value= getCurrent(obj)
            try
                obj.open();
                value= str2double(query(obj.visa,'MEAS:CURR?'));
                obj.close();
            catch ME
                obj.close();
                rethrow(ME);
            end
        end
        
        function value= getVoltage(obj)
            try
                obj.open();
                value= str2double(query(obj.visa,'MEAS:VOLT?'));
                obj.close();
            catch ME
                obj.close();
                rethrow(ME);
            end                
        end
        
        function value= getOutputState(obj)
            try
                obj.open();
                value= str2double(query(obj.visa,'OUTPUT?'));
                obj.close();
            catch ME
                obj.close();
                rethrow(ME);
            end
        end
        
        function OCRStatus(obj)
            % Queries the value of the OCR (Operation Condition Register)
            % to set the value of the Mode of the power supply
            if obj.state==0
                obj.mode= [];
                return
            end
            try
                obj.open();
                OCR=str2double(query(obj.visa,'STAT:OPER:COND?'));
                obj.close();
            catch ME
                obj.close();
                rethrow(ME);
            end
            OCR=dec2bin(OCR,8);
            CC=str2double(OCR(5));
            CV=str2double(OCR(6));
            if CC
                obj.mode='CC';
            end
            if CV
                obj.mode='CV';
            end
        end
        
        function Query(obj)
            % Sets the properties of the object
            obj.current=obj.getCurrent();
            obj.voltage=obj.getVoltage();
            obj.state= obj.getOutputState();
            obj.OCRStatus();
        end
        
        function VSet(obj,value)
            if or(value<0,value>30)
                error('Voltage should be between 0 and 30V');
            else
                try
                    obj.open();
                    fprintf(obj.visa,sprintf('VOLT %d%s',value,'V'));
                    obj.close();
                catch ME
                    obj.close();
                    rethrow(ME)
                end
            end
        end
        
        function ISet(obj,value)
            if or(value<0,value>5)
                error('Current shoudl be between 0 and 5A');
            else
                try
                    obj.open();
                    fprintf(obj.visa,sprintf('CURR %d%s',value,'A'));
                    obj.close();
                catch ME
                    obj.close();
                    rethrow(ME);
                end
            end
        end
        
        function OutputOnOff(obj,varargin)
            if isempty(varargin)
                ToggleOnOff(obj)
            else
                SwitchOnOff(obj,varargin{1})
            end
        end
        
        function ToggleOnOff(obj)
            switch not(obj.state)
                case 1
                    value= 'ON';
                case 0
                    value= 'OFF';
            end
            try
                obj.open();
                fprintf(obj.visa,sprintf('OUTPUT %s',value));
                obj.close();
            catch ME
                obj.close();
                rethrow(ME);
            end
        end
    
        function SwitchOnOff(obj,state)
            if not(state==0 || state==1)
                error('State can be either 0 (for off) or 1 (for on)');
            end
            if obj.state==state
                return
            else
                obj.ToggleOnOff();
            end
        end
        
        function EndSession(obj)
            % deletes visa object from memory
            % please call this at the end of your session to prevent
            % problems during open new sessions
            obj.OutputOnOff(0);
            obj.VSet(0);
            obj.ISet(0);
            delete(obj.visa);
        end
    end
    
end

