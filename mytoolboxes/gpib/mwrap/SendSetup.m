function retval = SendSetup(boardID, addrlist)
% retval = SendSetup(boardID, addrlist)
% No documentation is available yet.
  retval = gpib53(22, boardID, addrlist);
