classdef BNC645 < handle
    % BNC645 is a class to create a virtual reference to the instrument in
    % the Matlab enviornment with basic commands
    
    properties
        ni_ref;  % ni VISA reference address of the object   
        visa;    % reference to the visa object created to talk to the instrument
        func;    % value of the function being output by the instrument
        state;   % output state of the instrument (can be 1 for ON or 0 for OFF)
        voltage; % voltage amplitude in Vpp
        freq;    % frequency in Hz
        offset;  % voltage offset in volts
    end
    
    methods
        function obj= BNC645(ref)
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
            % The idea I have for the program is as follows: If the device
            % is open, then there is some command being sent to the device.
            % In that case the callingFcn should not execute since it might
            % interfere with the active call
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
                warning('Unable to query at port %s',obj.visa.Name);
            else
                disp(msg);
            end
            obj.close();
        end
        
        function value= getFunc(obj)
            % Returns the function shape being output by the device
            if obj.open('getFunc')
                return;
            end
            try
                value= strip(query(obj.visa,'FUNC?'));
                obj.close();
            catch ME
                obj.close();
                rethrow(ME);
            end
        end
        
        function value= getState(obj)
            % Returns the output state of the device
            if obj.open('getState')
                return;
            end
            try
                value= str2double(query(obj.visa,'OUTP?'));
                obj.close();
            catch ME
                obj.close();
                rethrow(ME);
            end
        end
        function value= getVoltage(obj)
            % Returns the voltage amplitude
            if obj.open('getVoltage')
                return;
            end
            try
                value= str2double(query(obj.visa,'VOLT?'));
                obj.close();
            catch ME
                obj.close();
                rethrow(ME);
            end
        end
        function value= getFreq(obj)
            % Returns the frequency in Hz
            if obj.open('getFreq')
                return;
            end
            try
                value= str2double(query(obj.visa,'FREQ?'));
                obj.close();
            catch ME
                obj.close();
                rethrow(ME);
            end
        end
        function value= getOffset(obj)
            % Returns the voltage offset
            if obj.open('getFreq')
                return;
            end
            try
                value= str2double(query(obj.visa,'VOLTage:OFFSet?'));
                obj.close();
            catch ME
                obj.close();
                rethrow(ME);
            end
        end
        function Query(obj)
            % Sets the properties of the object
            obj.func=obj.getFunc();
            obj.state=obj.getState();
            obj.voltage=obj.getVoltage();
            obj.freq=obj.getFreq();
            obj.offset=obj.getOffset();
        end
        
        function VSet(obj,value)
            if or(value<0,value>5)
                error('Voltage should be between 0 and 5 V');
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
        function FreqSet(obj,value)
            if or(value<1e-6,value>50000000)
                error('Frequency should be between 1 uHz and 50 MHz');
            else
                if obj.open('FreqSet')
                    return;
                end
                try
                    fprintf(obj.visa,sprintf('FREQ %d%s',value));
                    obj.close();
                    obj.Query(); 
                catch ME
                    obj.close();
                    obj.Query();
                    rethrow(ME)
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
            % Given the current state, reverse the state
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
                fprintf(obj.visa,sprintf('OUTP %s',value));
                obj.close();
                obj.Query();
            catch ME
                obj.close();
                obj.Query();
                rethrow(ME);
            end
        end
    
        function SwitchOnOff(obj,state)
            % Explicitly set state to input
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
            delete(obj.visa);
        end
    end
    
end

