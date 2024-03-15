function retval = ibpoke(ud, option, v)
% retval = ibpoke(ud, option, v)
% No documentation is available yet.
  retval = gpib53(53, ud, option, v);
