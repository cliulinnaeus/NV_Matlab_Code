function retval = ReceiveSetup(boardID, addr)
% retval = ReceiveSetup(boardID, addr)
% No documentation is available yet.
  retval = gpib53(14, boardID, addr);
