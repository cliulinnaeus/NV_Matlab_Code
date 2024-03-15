function status = PBesrStartProgramming()

PULSE_PROGRAM  = 0;
FREQ_REGS      = 1;

PHASE_REGS     = 2;
TX_PHASE_REGS  = 2;
PHASE_REGS_1   = 2;

RX_PHASE_REGS  = 3;
PHASE_REGS_0   = 3;

status = calllib('mypbesr','pb_start_programming',PULSE_PROGRAM);