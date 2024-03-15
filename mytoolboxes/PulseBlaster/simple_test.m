%Sungkun
%Sample PBesr Programming
%to see whether code works well, disable last two sentences, PBesrStop(),
%and PBesrClose(). 

PBesrInit() %initialize PBesr

% sets the clock frequency. for PBESR-PRO-400, it's 400MHz
% for PBESR-PRO-333, it's 333.3MHz
PBesrSetClock(400) 


PBesrStartProgramming() % enter the programming mode
%-------------------------------------------------------
%--------------- INSTRUCTION ---------------------------
%-------------------------------------------------------

%--------------- LOOP example --------------------------
number_of_loops = 1000000;
%'LOOP' instruction declares where the loop starts. instruction argument.
%instruction argument, number_of_loops, sets how many loops to be run.
loop_line = PBesrInstruction(1,'ON', 'LOOP', number_of_loops, 50)
PBesrInstruction(0,'', 'CONTINUE', 0, 100)
PBesrInstruction(1,'ON', 'CONTINUE', 0, 100)
PBesrInstruction(0,'', 'CONTINUE', 0, 100)
PBesrInstruction(1,'ON', 'CONTINUE', 0, 100)
%'END_LOOP' declares where the loop ends.  
%instruction argument, loop_line, sets where the loop should go back.
PBesrInstruction(0,'', 'END_LOOP', loop_line, 150)
%--------------- LOOP example --------------------------

PBesrInstruction(0,'', 'STOP', 0, 150)

%-------------------------------------------------------
%--------------- INSTRUCTION ---------------------------
%-------------------------------------------------------

PBesrStopProgramming() % exit the programming mode

PBesrStart() %start pulsing. it will start pulse sequence which were progammed/loaded to PBESR card before.

PBesrStop() %stop pulsing
PBesrClose() %close PBesr