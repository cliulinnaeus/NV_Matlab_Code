function PulseBlasterGUI()
%written by William Patterson for SpinCore Technologies Inc. 
%Modified by Song Kui for SpinCore Technologies Inc to adapt to SpinAPI version 20170111
%this is just a standard nam function that points to PulseBlaster_GUI_vX_X
%PulseBlaster_GUI_vX_X is found in the directory /GUI_Files

if (exist('./GUI_Files', 'dir') == 7)
    addpath('./GUI_Files');
else
    error('Cannot find ./GUI_Files');
end

global SPINAPI_DLL_NAME;
global SPINAPI_DLL_PATH;
global CLOCK_FREQ;

CLOCK_FREQ = 100;

SPINAPI_DLL_PATH = 'C:\SpinCore\SpinAPI\lib\';
SPINAPI_DLL_NAME = 'spinapi64';


PulseBlasterGUI_v1_1();