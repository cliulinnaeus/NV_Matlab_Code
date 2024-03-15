function [retval, result] = TestSRQ(boardID)
% [retval, result] = TestSRQ(boardID)
% No documentation is available yet.
  [retval, result] = gpib53(24, boardID);
