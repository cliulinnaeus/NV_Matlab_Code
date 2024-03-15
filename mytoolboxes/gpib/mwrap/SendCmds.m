function retval = SendCmds(boardID, buffer, cnt)
% retval = SendCmds(boardID, buffer, cnt)
% No documentation is available yet.
  retval = gpib53(17, boardID, buffer, cnt);
