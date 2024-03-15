function [neg_on_err] = pb_stop()
%[neg_on_err] = pb_stop_programming()
%DESCRIPTION: Stops output of board. Analog output will return to ground,
%and TTL outputs will either remain in the same state they were in when the
%reset command was received or return to ground. This also resets the 
%PulseBlaster so that the PulseBlaster Core can be run again using 
%pb_start() or a hardware trigger. 
%INPUTS:
%
%OUTPUTS:
% neg_on_err - A negative number is returned on failure, and spinerr is set
%               to a description of the error. 0 is returned on success. 

global SPINAPI_DLL_NAME;

neg_on_err = calllib(SPINAPI_DLL_NAME,'pb_stop');