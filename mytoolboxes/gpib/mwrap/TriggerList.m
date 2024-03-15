function retval = TriggerList(boardID, addrlist)
% retval = TriggerList(boardID, addrlist)
% No documentation is available yet.
  retval = gpib53(31, boardID, addrlist);
