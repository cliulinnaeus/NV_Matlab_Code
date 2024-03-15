function retval = PPollUnconfig(boardID, addrlist)
% retval = PPollUnconfig(boardID, addrlist)
% No documentation is available yet.
  retval = gpib53(9, boardID, addrlist);
