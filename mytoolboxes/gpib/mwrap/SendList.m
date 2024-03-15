function retval = SendList(boardID, addrlist, databuf, datacnt, eotMode)
% retval = SendList(boardID, addrlist, databuf, datacnt, eotMode)
% No documentation is available yet.
  retval = gpib53(21, boardID, addrlist, databuf, datacnt, eotMode);
