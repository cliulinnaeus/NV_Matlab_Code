function path=PortMap(what)

switch what
    case 'BackupFile'
        path='C:\MATLAB_Code\Data\TempDataBackup\Temp.mat';
    case 'BackupImageFile'
        path='C:\MATLAB_Code\Data\TempDataBackup\TempImage.mat';
    case 'Ctr Gate'
        path='/Dev1/PFI1';
    case 'PD Gate'
        path='/Dev1/PFI3';
    case 'SG ext mod'
        path='Dev1/ao2';
    case 'Ctr Trig'
        path='/Dev1/PFI13';
    case 'SG ip'
        path = '169.254.215.80';
    case 'SG com'
        path='com7';
    case 'SG com 2'
        path='com8';
    case 'SG com 3'
        path='com10';
    case 'meas'
        path='SPCM';
        %path='APD';
    case 'meas2'
        path='PD0 not connected';      
    case 'meas3'
        path='PD1 not connected';
    case 'SPCM'
        path='/Dev1/PFI0';
    case 'gConfocal path'
        path='C:\MATLAB_Code\Sets\';
    case 'APD in'
        path='Dev1/ai2';
    case 'PD0 in'
        path='Dev1/ai0';
    case 'PD1 in'
        path='Dev1/ai1';
    case 'Ctr in'
        path='Dev1/ctr0';
    case 'Ctr in 1'
        path='Dev1/ctr1';
    case 'Ctr in 2'
        path='Dev1/ctr2';
    case 'Ctr in 3'
        path='Dev1/ctr3';
    case 'Ctr out'
        path='Dev1/ctr1';
    case 'Galvo x'
        path='Dev1/ao0';
    case 'Galvo y'
        path='Dev1/ao1';
    case 'Piezo' % added by Weijie 09/21/2021 single-NV
        path='44281634';
    case 'spinapi'
        path='C:\Program Files\SpinAPI\include\spinapi.h';
    case 'pulseblaster'
        path='C:\Program Files\SpinAPI\include\pulseblaster.h';
    case 'dds'
        path='C:\Program Files\SpinAPI\include\dds.h';
    case 'Data'
        path='D:\Data\';
    case 'Ctr src'  % SPCM0
        path='/Dev1/PFI0';
    case 'Ctr src 1'  % SPCM1
        path='/Dev1/PFI4';
    case 'Ctr src 2'  % SPCM2
        path='/Dev1/PFI5';
    case 'Ctr src 3'  % SPCM3
        path='/Dev1/PFI6';
    case 'LF save'
        path='C:\Users\rt2\Documents\LightField\';
    case 'Scope'
        path='USB0::0x0957::0x9005::MY51260103::0::INSTR';
    case 'keithleyX'
        path='USB0::0x05E6::0x2200::9208214::INSTR';
    case 'keithleyY'
        path='USB0::0x05E6::0x2200::9201316::INSTR';
    case 'keithleyZ'
        path='USB0::0x05E6::0x2200::9201315::INSTR';
    case 'FPGA Host'
        path = '192.168.0.234';
    case 'FPGA Port'
        path = 8080;
end