function retval = SendIFC(boardID)
% retval = SendIFC(boardID)
% No documentation is available yet.
  retval = gpib53(19, boardID);
