function uploadSimpleProg(name ,ch)
global fpga
s.name = name;
s.prog_structure = ch;

js = jsonencode(s);
temp_save_path = ['C:\MATLAB_Code\mytoolboxes\ZCU111_AWG\fpga_temp_files\' name '.json'];
fileID = fopen(temp_save_path, 'w');
fwrite(fileID, js, 'char');
fclose(fileID);

%%% upload
fpga.upload_program(temp_save_path, name);
end

