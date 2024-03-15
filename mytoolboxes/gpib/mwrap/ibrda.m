function [retval, buf] = ibrda(ud, cnt)
% [retval, buf] = ibrda(ud, cnt)
% No documentation is available yet.
  [retval, buf] = gpib53(56, ud, cnt);
