function retval = EnableLocal(boardID, addrlist)
% retval = EnableLocal(boardID, addrlist)
% No documentation is available yet.
  retval = gpib53(3, boardID, addrlist);
