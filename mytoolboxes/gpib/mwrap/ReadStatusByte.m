function [retval, result] = ReadStatusByte(boardID, addr)
% [retval, result] = ReadStatusByte(boardID, addr)
% No documentation is available yet.
  [retval, result] = gpib53(12, boardID, addr);
