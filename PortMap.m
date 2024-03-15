function path=PortMap(what)

switch what
    case 'BackupFile'
        path='C:\MATLAB_Code\Data\TempDataBackup\Temp.mat';
    case 'BackupImageFile'
        path='C:\MATLAB_Code\Data\TempDataBackup\TempImage.mat';
    case 'Ctr Gate'
        path='/Dev2/PFI1';
    case 'SG ext mod'
        path='Dev2/ao2';
    case 'Ctr Trig'
        path='/Dev2/PFI13';
    case 'SG com'
        path='com34';
    case 'SG com 2'
        path='com8';
    case 'SG com 3'
        path='com10';
    case 'meas'
        path='SPCM'; 
    case 'SPCM' 
        path='/Dev2/PFI0';
    case 'gConfocal path'
        path='C:\MATLAB_Code\Sets\';
    case 'APD in'
        path='Dev2/ai0';
    case 'Ctr in'
        path='Dev2/ctr3';
    case 'Ctr out'
        path='Dev2/ctr1';
    case 'Galvo x'
        path='Dev2/ao0';
    case 'Galvo y'
        path='Dev2/ao1';
    case 'Piezo' % added by Weijie 09/21/2021 single-NV
        path='0117068258';
    case 'spinapi'
        path='C:\SpinCore\SpinAPI\include\spinapi.h';
    case 'pulseblaster'
        path='C:\SpinCore\SpinAPI\include\pulseblaster.h';
    case 'dds'
        path='C:\SpinCore\SpinAPI\include\dds.h';
    case 'Data'
        path='C:\Data\';
    case 'Ctr src'  % SPCM 
        path='/Dev2/PFI0';
%         path='/Dev2/PFI2'; %PB4 bit
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
end