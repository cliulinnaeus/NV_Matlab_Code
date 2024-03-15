function retval = ibcmd(ud, buf, cnt)
% retval = ibcmd(ud, buf, cnt)
% No documentation is available yet.
  retval = gpib53(37, ud, buf, cnt);
