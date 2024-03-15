function [retval, results] = TestSys(boardID, addrlist)
% [retval, results] = TestSys(boardID, addrlist)
% No documentation is available yet.
  [retval, results] = gpib53(25, boardID, addrlist);
