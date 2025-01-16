classdef FPGA_ABS_Client < handle
    properties (Constant)
        buffer_size = 4096; % Buffer size for sending/receiving data
    end
    
    properties
        client_socket % TCP client object
        host          % Server IP address
        port          % Server port
    end
    
    methods
        function obj = FPGA_ABS_Client()
            obj.host = ''; % Default host can be set here
            obj.port = 0;  % Default port can be set here
        end
        
        % Connect to the server
        function msg = connect(obj, host, port)
            try
                obj.client_socket = tcpclient(host, port, 'Timeout', 30);
                obj.client_socket.ByteOrder = "big-endian";
                obj.host = host;
                obj.port = port;
                msg = sprintf('Connected to server %s on port %d\n', host, port);
                fprintf('Connected to server %s on port %d\n', host, port);
            catch ME
                msg = sprintf('Error connecting to server: %s\n', ME.message); 
                fprintf('Error connecting to server: %s\n', ME.message);
            end
        end
        
        % Properly disconnect from the server
        function msg = disconnect(obj)
            if ~isempty(obj.client_socket)
                delete(obj.client_socket); % Explicitly delete the tcpclient object
                obj.client_socket = [];
                msg = sprintf('Disconnected from server at %s on port %d\n', obj.host, obj.port);
                fprintf('Disconnected from server at %s on port %d\n', obj.host, obj.port);
            end
        end
        
        % Get the length of a UTF-8 encoded string
        function len = utf8len(~, s)
            len = length(unicode2native(s, 'UTF-8'));
        end
        
        % Send an integer to the server
        function send_int(obj, n)
            try
                % Convert the integer to 4-byte big-endian format
                val = typecast(uint32(n), 'uint8');
                val = swapbytes(val); % Convert to big-endian if needed
                %disp(fliplr(val))
                write(obj.client_socket, fliplr(val));
            catch ME
                fprintf('Error sending integer: %s\n', ME.message);
            end
        end
        
        % Send a string to the server
        function send_string(obj, s)
            if isempty(obj.client_socket)
                error('Client not connected.');
            end
            try
                obj.send_int(obj.utf8len(s)); % Send the length of the string
                write(obj.client_socket, unicode2native(s, 'UTF-8'));
            catch ME
                fprintf('Error sending string: %s\n', ME.message);
            end
        end
        
        % Send a file to the server
        function send_file(obj, filename)
            if isempty(obj.client_socket)
                error('Client not connected.');
            end
            try
                file_info = dir(filename);
                file_size = file_info.bytes;
                
                obj.send_int(file_size); % Send the size of the file
                obj.send_string(filename); % Send the filename
                
                fileID = fopen(filename, 'rb');
                while ~feof(fileID)
                    bytes_read = fread(fileID, obj.buffer_size, 'uint8=>uint8');
                    write(obj.client_socket, bytes_read);
                end
                fclose(fileID);
                fprintf('File has been sent.\n');
            catch ME
                fprintf('Error sending file: %s\n', ME.message);
            end
        end
        
        % Receive an integer from the server (blocking mode)
        function num = receive_int(obj)
            try
                num = obj.read_nonblocking(4); % Read 4 bytes for an integer
                if isempty(num)
                    num = [];
                    return;
                end
                num = typecast(uint8(num), 'uint32');
                num = swapbytes(num); % Convert to host byte order if needed
            catch ME
                fprintf('Error receiving integer: %s\n', ME.message);
                num = [];
            end
        end
        
        % Receive a string from the server (blocking mode)
        function str = receive_string(obj)
            try
                string_size = obj.receive_int();
                if isempty(string_size)
                    str = [];
                    return;
                end
                
                buf = uint8([]);
                while length(buf) < string_size
                    new_data = obj.read_nonblocking(min(obj.buffer_size, string_size - length(buf)));
                    if isempty(new_data)
                        str = [];
                        return;
                    end
                    buf = [buf; new_data];
                end
                str = native2unicode(buf, 'UTF-8');
            catch ME
                fprintf('Error receiving string: %s\n', ME.message);
                str = [];
            end
        end
        
        % Helper function to perform blocking read
        function data = read_nonblocking(obj, numBytes)
             data = read(obj.client_socket, numBytes, 'uint8');
        end
        
        % Receive acknowledgment from the server
        function ack = receive_server_ack(obj)
            ack = obj.receive_string();
            fprintf('%s\n', ack);
        end
    end
end

