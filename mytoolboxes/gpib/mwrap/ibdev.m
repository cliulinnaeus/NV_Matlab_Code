function retval = ibdev(ud, pad, sad, tmo, eot, eos)
% retval = ibdev(ud, pad, sad, tmo, eot, eos)
% No documentation is available yet.
  retval = gpib53(40, ud, pad, sad, tmo, eot, eos);
