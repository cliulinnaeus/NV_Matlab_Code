function [neg_on_err] = pb_init()
%[neg_on_err] = pb_count_boards()
%DESCRIPTION: Initializes the board. This must be called before any other
%functions are used which communicate with the board. If you have multiple 
%boards installed in your system, pb_select_board() may be called first to 
%select which board to initialize.
%INPUTS:
%
%OUTPUTS:
% neg_on_err - A negative number is returned on failure, and spinerr is set
%               to a description of the error. 0 is returned on success. 

global SPINAPI_DLL_NAME;

neg_on_err = calllib(SPINAPI_DLL_NAME,'pb_init');