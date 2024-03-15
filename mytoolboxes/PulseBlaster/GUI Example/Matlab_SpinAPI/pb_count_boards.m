function [num_boards] = pb_count_boards()
%
%[neg_on_err] = pb_count_boards()
%DESCRIPTION: Return the number of SpinCore boards present in your system.
%INPUTS:
%
%OUTPUTS:
%num_boards - The number of boards is returned on success
%             A negative number is returned on failure, and spinerr is set
%             to a description of the error.

global SPINAPI_DLL_NAME;

num_boards = calllib(SPINAPI_DLL_NAME,'pb_count_boards');