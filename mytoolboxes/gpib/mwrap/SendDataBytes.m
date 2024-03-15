function retval = SendDataBytes(boardID, buffer, cnt, eot_mode)
% retval = SendDataBytes(boardID, buffer, cnt, eot_mode)
% No documentation is available yet.
  retval = gpib53(18, boardID, buffer, cnt, eot_mode);
