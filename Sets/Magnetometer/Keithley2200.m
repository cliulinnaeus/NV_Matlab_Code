classdef Keithley2200 < handle
    % Keithley2200 is a class to create a virtual reference to the
    % instrument in the Matlab enviornment with basic commands
    % TO BE IMPROVED OVER TIME
    
    properties
        ni_ref;  % ni VISA reference address of the object   
        visa;    % reference to the visa object created to talk to the instrument
        voltageOut; % value of the voltage being output by the instrument
        voltageSet; % value of the desired voltage
        currentOut; % value of the current being output by the instrument
        currentSet; % value of the desired current
        state;   % output state of the instruement (can be 1 for ON or 0 for OFF)
        mode;    % output mode of the power supply (Constant Voltage or Constant Current)
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
        end
        
        function err= open(obj,callingFcn)
            % fopens the object if it is closed
            switch obj.visa.Status
                case 'open'
                    err= 1;
                    warning('Device open. %s will not execute.',callingFcn);
                case 'closed'
                    fopen(obj.visa);
                    err= 0;
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
                    return;
            end
        end
        
        function IDN(obj)
            % just a test command to query the device on startup to make
            % sure everyhting is working fine
            if obj.open('IDN')
                return;
            end
            msg= query(obj.visa,'*IDN?');
            if isempty(msg)
                warning('Unable to query Keithley at port %s',obj.visa.Name);
            else
                disp(msg);
            end
            obj.close();
        end
        
        function value= getCurrentOut(obj)
            % Returns the current being output by the device
            if obj.open('getCurrentOut')
                return;
            end
            try
                value= str2double(query(obj.visa,'MEAS:CURR?'));
                obj.close();
            catch ME
                obj.close();
                rethrow(ME);
            end
        end
        function value= getCurrentSet(obj)
            % Returns the desired current
            if obj.open('getCurrentSet')
                return;
            end
            try
                value= str2double(query(obj.visa,'SOUR:CURR?'));
                obj.close();
            catch ME
                obj.close();
                rethrow(ME);
            end
        end        
        function value= getVoltageOut(obj)
            % Returns the voltage being output by the device
            if obj.open('getVoltageOut')
                return;
            end
            try
                value= str2double(query(obj.visa,'MEAS:VOLT?'));
                obj.close();
            catch ME
                obj.close();
                rethrow(ME);
            end                
        end
        function value= getVoltageSet(obj)
            % Returns the desired voltage
            if obj.open('getVoltageSet')
                return;
            end
            try
                value= str2double(query(obj.visa,'SOUR:VOLT?'));
                obj.close();
            catch ME
                obj.close();
                rethrow(ME);
            end                
        end
        function value= getOutputState(obj)
            % Returns 0 if Output is OFF and 1 if the Output is ON
            if obj.open('getOutputState')
                return;
            end
            try
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
                return;
            end
            if obj.open('OCRStatus')
                return;
            end
            try
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
            obj.currentOut=obj.getCurrentOut();
            obj.voltageOut=obj.getVoltageOut();
            obj.currentSet=obj.getCurrentSet();
            obj.voltageSet=obj.getVoltageSet();
            obj.state= obj.getOutputState();
            obj.OCRStatus();
        end
        
        function VSet(obj,value)
            if or(value<0,value>30)
                error('Voltage should be between 0 and 30 V');
            else
                if obj.open('VSet')
                    return;
                end
                try
                    fprintf(obj.visa,sprintf('VOLT %d%s',value,'V'));
                    obj.close();
                    obj.Query(); 
                catch ME
                    obj.close();
                    obj.Query();
                    rethrow(ME)
                end
            end
        end
        
        function ISet(obj,value)
            if or(value<0,value>5)
                error('Current should be between 0 and 5 A');
            else
                if obj.open('ISet')
                    return;
                end
                try
                    fprintf(obj.visa,sprintf('CURR %d%s',value,'A'));
                    obj.close();
                    obj.Query();
                catch ME
                    obj.close();
                    obj.Query();
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
                if obj.open('ToggleOnOff')
                    return;
                end
                fprintf(obj.visa,sprintf('OUTPUT %s',value));
                obj.close();
                obj.Query();
            catch ME
                obj.close();
                obj.Query();
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

