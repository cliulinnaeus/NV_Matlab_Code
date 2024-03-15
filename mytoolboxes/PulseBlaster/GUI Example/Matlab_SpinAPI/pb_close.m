function [neg_on_err] = pb_close()
%[neg_on_err] = pb_stop_programming()
%DESCRIPTION: End communication with the board. This is generally called as
%the last line in a program. Once this is called, no further communication 
%can take place with the board unless the board is reinitialized with 
%pb_init(). However, any pulse program that is loaded and running at the 
%time of calling this function will continue to run indefinitely.
%INPUTS:
%
%OUTPUTS:
% neg_on_err - A negative number is returned on failure, and spinerr is set
%               to a description of the error. 0 is returned on success. 

global SPINAPI_DLL_NAME;

neg_on_err = calllib(SPINAPI_DLL_NAME,'pb_close');