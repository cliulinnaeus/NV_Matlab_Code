function uploadPeriodicPulse(name, freq, amp, phase)
global fpga
s.name = name;
s.style = "const";
s.freq = freq;
s.gain = amp;
s.phase =  phase;
s.length = 10;
s.mode = "periodic";

js = jsonencode(s);
temp_save_path = ['C:\MATLAB_Code\mytoolboxes\ZCU111_AWG\fpga_temp_files\' name '.json'];
fileID = fopen(temp_save_path, 'w');
fwrite(fileID, js, 'char');
fclose(fileID);

%%% fpga upload
fpga.upload_waveform_cfg(temp_save_path, name);
end

