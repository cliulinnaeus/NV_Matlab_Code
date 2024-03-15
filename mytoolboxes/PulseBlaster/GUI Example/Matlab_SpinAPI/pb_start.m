function [neg_on_err] = pb_start()
%[neg_on_err] = pb_stop_programming()
%DESCRIPTION: Send a software trigger to the board. This will start
%execution of a pulse program. It will also trigger a program which is 
%currently paused due to a WAIT instruction. Triggering can also be 
%accomplished through hardware, please see your board's manual for details 
%on how to accomplish this. 
%INPUTS:
%
%OUTPUTS:
% neg_on_err - A negative number is returned on failure, and spinerr is set
%               to a description of the error. 0 is returned on success. 

global SPINAPI_DLL_NAME;

neg_on_err = calllib(SPINAPI_DLL_NAME,'pb_start');