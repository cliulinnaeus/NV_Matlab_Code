function retval = DevClearList(boardID, addrlist)
% retval = DevClearList(boardID, addrlist)
% No documentation is available yet.
  retval = gpib53(2, boardID, addrlist);
