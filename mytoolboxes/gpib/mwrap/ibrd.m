function [retval, buf] = ibrd(ud, cnt)
% [retval, buf] = ibrd(ud, cnt)
% No documentation is available yet.
  [retval, buf] = gpib53(55, ud, cnt);
