function retval = ResetSys(boardID, addrlist)
% retval = ResetSys(boardID, addrlist)
% No documentation is available yet.
  retval = gpib53(15, boardID, addrlist);
