function retval = SendLLO(boardID)
% retval = SendLLO(boardID)
% No documentation is available yet.
  retval = gpib53(20, boardID);
