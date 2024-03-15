function retval = PassControl(boardID, addr)
% retval = PassControl(boardID, addr)
% No documentation is available yet.
  retval = gpib53(10, boardID, addr);
