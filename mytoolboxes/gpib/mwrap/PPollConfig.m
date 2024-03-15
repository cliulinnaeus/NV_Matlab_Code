function retval = PPollConfig(boardID, addr, dataLine, lineSense)
% retval = PPollConfig(boardID, addr, dataLine, lineSense)
% No documentation is available yet.
  retval = gpib53(8, boardID, addr, dataLine, lineSense);
