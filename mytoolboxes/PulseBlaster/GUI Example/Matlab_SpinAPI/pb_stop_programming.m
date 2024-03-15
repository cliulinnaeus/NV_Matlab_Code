function [neg_on_err] = pb_stop_programming()
%[neg_on_err] = pb_stop_programming()
%DESCRIPTION: Finishes the programming for a specific onboard devices which
%was started by pb_start_programming().
%select which board to initialize.
%INPUTS:
%
%OUTPUTS:
% neg_on_err - A negative number is returned on failure, and spinerr is set
%               to a description of the error. 0 is returned on success. 

global SPINAPI_DLL_NAME;

neg_on_err = calllib(SPINAPI_DLL_NAME,'pb_stop_programming');