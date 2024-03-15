function [err_str] = pb_get_error()
%[neg_on_err] = pb_stop_programming()
%DESCRIPTION: Return the most recent error string. Anytime a function (such
%as pb_init(), pb_start_programming(), etc.) encounters an error, this 
%function will return a description of what went wrong.
%INPUTS:
%
%OUTPUTS:
% err_str - A string describing the last error is returned. A string containing
%           "No Error" is returned if the last function call was successfull. 

global SPINAPI_DLL_NAME;

err_str = calllib(SPINAPI_DLL_NAME,'pb_get_error');