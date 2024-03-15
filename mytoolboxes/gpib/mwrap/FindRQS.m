function [retval, dev_stat] = FindRQS(boardID, addrlist)
% [retval, dev_stat] = FindRQS(boardID, addrlist)
% No documentation is available yet.
  [retval, dev_stat] = gpib53(6, boardID, addrlist);
