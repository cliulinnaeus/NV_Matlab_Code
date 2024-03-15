function [retval, result] = WaitSRQ(boardID)
% [retval, result] = WaitSRQ(boardID)
% No documentation is available yet.
  [retval, result] = gpib53(32, boardID);
