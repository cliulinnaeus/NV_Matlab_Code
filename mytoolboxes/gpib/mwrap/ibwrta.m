function retval = ibwrta(ud, buf, cnt)
% retval = ibwrta(ud, buf, cnt)
% No documentation is available yet.
  retval = gpib53(70, ud, buf, cnt);
