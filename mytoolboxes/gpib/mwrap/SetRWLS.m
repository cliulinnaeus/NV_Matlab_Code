function retval = SetRWLS(boardID, addrlist)
% retval = SetRWLS(boardID, addrlist)
% No documentation is available yet.
  retval = gpib53(23, boardID, addrlist);
