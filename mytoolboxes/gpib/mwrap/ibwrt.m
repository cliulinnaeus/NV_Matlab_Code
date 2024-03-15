function retval = ibwrt(ud, buf, cnt)
% retval = ibwrt(ud, buf, cnt)
% No documentation is available yet.
  retval = gpib53(69, ud, buf, cnt);
