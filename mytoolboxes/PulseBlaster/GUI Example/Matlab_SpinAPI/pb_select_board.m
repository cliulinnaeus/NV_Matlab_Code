function [neg_on_err] = pb_select_board(board_num)
%[neg_on_err] = pb_count_boards()
%DESCRIPTION: If multiple boards from SpinCore Technologies are present in
%your system, this function allows you to select which board to talk to.
%INPUTS:
%board_num - Specifies which board to select. Counting starts at 0. 
%OUTPUTS:
% neg_on_err - A negative number is returned on failure, and spinerr is set
%               to a description of the error. 0 is returned on success. 

global SPINAPI_DLL_NAME;

neg_on_err = calllib(SPINAPI_DLL_NAME,'pb_select_board',board_num);