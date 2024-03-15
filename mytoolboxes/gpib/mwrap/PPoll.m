function [retval, result] = PPoll(boardID)
% [retval, result] = PPoll(boardID)
% No documentation is available yet.
  [retval, result] = gpib53(7, boardID);
