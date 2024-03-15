function [retval, v] = ibask(ud, option)
% [retval, v] = ibask(ud, option)
% No documentation is available yet.
  [retval, v] = gpib53(33, ud, option);
