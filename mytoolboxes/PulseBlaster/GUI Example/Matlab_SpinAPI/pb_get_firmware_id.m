function [firm_id] = pb_get_firmware_id()
%[neg_on_err] = pb_get_firmware_id()
%DESCRIPTION: Get the firmware version on the board. This is not supported
%on all boards. Must have used pb_init() first.
%INPUTS:
%
%OUTPUTS:
% firm_id - Returns (in an integer) the firmware id as described above.
%A 0 is returned if the firmware id feature is not available on this 
%version of the board.  

global SPINAPI_DLL_NAME;

firm_id = calllib(SPINAPI_DLL_NAME,'pb_get_firmware_id');