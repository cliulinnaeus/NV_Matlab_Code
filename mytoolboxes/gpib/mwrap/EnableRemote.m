function retval = EnableRemote(boardID, addrlist)
% retval = EnableRemote(boardID, addrlist)
% No documentation is available yet.
  retval = gpib53(4, boardID, addrlist);
