function [retval, buffer] = RcvRespMsg(boardID, cnt, Termination)
% [retval, buffer] = RcvRespMsg(boardID, cnt, Termination)
% No documentation is available yet.
  [retval, buffer] = gpib53(11, boardID, cnt, Termination);
