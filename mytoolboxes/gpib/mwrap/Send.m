function retval = Send(boardID, addr, databuf, datacnt, eotMode)
% retval = Send(boardID, addr, databuf, datacnt, eotMode)
% No documentation is available yet.
  retval = gpib53(16, boardID, addr, databuf, datacnt, eotMode);
