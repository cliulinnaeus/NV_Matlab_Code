function inst_num = PBesrInstruction(flag, flag_option, inst, inst_arg, length)
%added by Sungkun
%input arguments
%flag : flag of set of channels to be on
%flag_option : options to be associated with flag. string type. 
%inst : specific instruction including loop, branch, etc.. string type.
%inst_arg : instruction specific arguments. usually integer.
%length : length of pulse in nanosecond.

%output argument : number of instruction. 


%flag_option map. string-to-bits
ALL_FLAGS_ON	= hex2dec('1FFFFF');
ONE_PERIOD		= hex2dec('200000');
TWO_PERIOD		= hex2dec('400000');
THREE_PERIOD	= hex2dec('600000');
FOUR_PERIOD		= hex2dec('800000');
FIVE_PERIOD		= hex2dec('A00000');
SIX_PERIOD      = hex2dec('C00000');
ON				= hex2dec('E00000');

%instruction map. string-to-bits
CONTINUE = 0;
STOP = 1;
LOOP = 2;
END_LOOP = 3;
JSR = 4;
RTS = 5;
BRANCH = 6;
LONG_DELAY = 7;
WAIT = 8;

switch flag_option
    case 'ON'
        flag = bitor(flag, ON);     
    case 'ONE_PERIOD'
        flag = bitor(flag, ONE_PERIOD);
    case 'TWO_PERIOD'
        flag = bitor(flag, TWO_PERIOD);
    case 'THREE_PERIOD'
        flag = bitor(flag, THREE_PERIOD);
    case 'FOUR_PERIOD'
        flag = bitor(flag, FOUR_PERIOD);
    case 'FIVE_PERIOD'
        flag = bitor(flag, FIVE_PERIOD);  
    case 'SIX_PERIOD'
        flag = bitor(flag, SIX_PERIOD);         
    case 'ALL_FLAGS_ON'
        flag = ALL_FLAGS_ON;        
    otherwise
end

switch inst
    case 'CONTINUE'
        inst = CONTINUE;     
    case 'STOP'
        inst = STOP;     
    case 'LOOP'
        inst = LOOP;     
    case 'END_LOOP'
        inst = END_LOOP;     
    case 'JSR'
        inst = JSR;     
    case 'RTS'
        inst = RTS;     
    case 'BRANCH'
        inst = BRANCH;     
    case 'LONG_DELAY'
        inst = LONG_DELAY;     
    case 'WAIT'
        inst = WAIT;     
    otherwise
end

inst_num = calllib('mypbesr','pb_inst_pbonly',flag, inst, inst_arg, length);

