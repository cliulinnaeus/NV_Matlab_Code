function [status] = pb_read_status()
%[neg_on_err] = pb_stop_programming()
%DESCRIPTION: Read status from the board. Not all boards support this, see your manual.
%Each bit of the returned integer indicates whether the board is in that state.
%Bit 0 is the least significant bit.
%
%    1 (bit0 high) - Stopped
%    2 (bit1 high) - Reset
%    4 (bit2 high) - Running
%    8 (bit3 high) - Waiting
%    16 (bit4 high) - Scanning (RadioProcessor boards only)
%
%Note on Bit 1: Bit 1 will be high, '1', as soon as the board is initialized.
%It will remain high until a hardware or software reset occurs. At that 
%point, it will stay low, '0', until the board is triggered again.
%Bits 5-31 are reserved for future use. It should not be assumed that these will be set to 0. 
%INPUTS:
%
%OUTPUTS:
% status - Number (bit word) that indicates the state of the current board as described above.   

global SPINAPI_DLL_NAME;

status = calllib(SPINAPI_DLL_NAME,'pb_read_status');