function retval = Trigger(boardID, addr)
% retval = Trigger(boardID, addr)
% No documentation is available yet.
  retval = gpib53(30, boardID, addr);
