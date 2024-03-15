function [retval, results] = AllSpoll(boardID, addrlist)
% [retval, results] = AllSpoll(boardID, addrlist)
% No documentation is available yet.
  [retval, results] = gpib53(0, boardID, addrlist);
