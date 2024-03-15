function [retval, listen] = ibln(ud, pad, sad)
% [retval, listen] = ibln(ud, pad, sad)
% No documentation is available yet.
  [retval, listen] = gpib53(48, ud, pad, sad);
