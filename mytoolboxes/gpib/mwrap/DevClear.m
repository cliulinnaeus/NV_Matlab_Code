function retval = DevClear(boardID, addr)
% retval = DevClear(boardID, addr)
% No documentation is available yet.
  retval = gpib53(1, boardID, addr);
