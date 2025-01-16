classdef FPGA_AWG_Client < FPGA_ABS_Client
    methods
        function obj = FPGA_AWG_Client()
            % Call the superclass constructor
            obj@FPGA_ABS_Client();
        end
        
        % Upload waveform configuration file to the server
        function msg = upload_waveform_cfg(obj, wf_cfg_path, name)
            if isfile(wf_cfg_path)
                obj.send_string("UPLOAD_WAVEFORM_CFG");
                obj.send_string(name);
                obj.send_file(wf_cfg_path);
                msg = obj.receive_server_ack();
            else
                fprintf('%s does not exist!\n', wf_cfg_path);
                msg = sprintf('%s does not exist!\n', wf_cfg_path);
            end
        end
        
        % Upload envelope data file (either i or q data)
        function msg = upload_envelope_data(obj, data_path, name)
            if isfile(data_path)
                obj.send_string("UPLOAD_ENVELOPE_DATA");
                obj.send_string(name);
                obj.send_file(data_path);
                msg = obj.receive_server_ack();
            else
                fprintf('%s does not exist!\n', data_path);
                msg = sprintf('%s does not exist!\n', data_path);
            end
        end
        
        % Upload program configuration file to the server
        function msg = upload_program(obj, prog_cfg_path, name)
            if isfile(prog_cfg_path)
                obj.send_string("UPLOAD_PROGRAM");
                obj.send_string(name);
                obj.send_file(prog_cfg_path);
                msg = obj.receive_server_ack();
            else
                fprintf('%s does not exist!\n', prog_cfg_path);
                msg = sprintf('%s does not exist!\n', prog_cfg_path);
            end
        end
        
        % Delete waveform configuration from the server
        function msg = delete_waveform_cfg(obj, name)
            obj.send_string("DELETE_WAVEFORM_CFG");
            obj.send_string(name);
            msg = obj.receive_server_ack();
        end
        
        % Delete ALL waveform configuration from the server
        function msg = delete_all_waveform_cfg(obj)
            obj.send_string("DELETE_ALL_WAVEFORM_CFG");
            msg = obj.receive_server_ack();
        end
        
        % Delete envelope data from the server
        function msg = delete_envelope_data(obj, name)
            obj.send_string("DELETE_ENVELOPE_DATA");
            obj.send_string(name);
            msg = obj.receive_server_ack();
        end
        
        function msg = delete_all_envelope_data(obj)
            obj.send_string("DELETE_ALL_ENVELOPE_DATA");
            msg = obj.receive_server_ack();
        end
        
        % Delete program from the server
        function msg = delete_program(obj, name)
            obj.send_string("DELETE_PROGRAM");
            obj.send_string(name);
            msg = obj.receive_server_ack();
        end
        
        % Delete program from the server
        function msg = delete_all_programs(obj)
            obj.send_string("DELETE_ALL_PROGRAMS");
            msg = obj.receive_server_ack();
        end
               
        % Retrieve the list of waveforms from the server
        function msg = get_waveform_lst(obj)
            obj.send_string("GET_WAVEFORM_LIST");
            msg = obj.receive_server_ack();
        end
        
        % Retrieve the list of envelope data from the server
        function msg = get_envelope_lst(obj)
            obj.send_string("GET_ENVELOPE_LIST");
            msg= obj.receive_server_ack();
        end
        
        % Retrieve the list of programs from the server
        function msg = get_program_lst(obj)
            obj.send_string("GET_PROGRAM_LIST");
            msg = obj.receive_server_ack();
        end
        
        % Get the state of the server
        function msg = get_state(obj)
            obj.send_string("GET_STATE");
            msg = obj.receive_server_ack();
        end
        
        % Set the trigger mode on the server
        function msg = set_trigger_mode(obj, trig_mode)
            obj.send_string("SET_TRIGGER_MODE");
            obj.send_string(trig_mode);
            msg = obj.receive_server_ack();
        end
        
        % Start a specific program on the server
        function msg = start_program(obj, name)
            obj.send_string("START_PROGRAM");
            obj.send_string(name);
            msg = obj.receive_server_ack();
        end
        
        % Stop the currently running program on the server
        function msg = stop_program(obj)
            obj.send_string("STOP_PROGRAM");
            msg = obj.receive_server_ack();
        end
    end
end
