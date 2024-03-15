function [retval, results] = FindLstn(boardID, addrlist, limit)
% [retval, results] = FindLstn(boardID, addrlist, limit)
% No documentation is available yet.
  [retval, results] = gpib53(5, boardID, addrlist, limit);
