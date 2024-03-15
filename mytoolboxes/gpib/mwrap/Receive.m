function [retval, buffer] = Receive(boardID, addr, cnt, Termination)
% [retval, buffer] = Receive(boardID, addr, cnt, Termination)
% No documentation is available yet.
  [retval, buffer] = gpib53(13, boardID, addr, cnt, Termination);
