function [inst_addr] = pb_inst_pbonly(flags,inst,inst_data,length)
%[inst_addr] = pb_inst_pbonly(flags,inst,inst_data,length)
%DESCRIPTION:
%This is the instruction programming function for boards without a DDS.
%(for example PulseBlaster and PulseBlasterESR boards)
%INPUTS:
%flags - determines state of each TTL output bit.
%inst - determines which type of instruction is to be executed.
%inst_data - data to be used with the previous inst field.
%length - duration of this pulse program instruction, specified in nanoseconds (ns).
%OUTPUTS:
%inst_addr - the address of the instruction, can be used for branch instructions.

global SPINAPI_DLL_NAME;

if(isnumeric(flags))
    num_flags = flags;
else
    num_flags = hex2dec(flags);
end

if(isa(inst,'char'))
    inst = upper(inst);
end

switch inst
	case {'CONTINUE',0}
		op_code = 0;
	case {'STOP',1}
		op_code = 1;
	case {'LOOP',2}
		op_code = 2;
	case {'END_LOOP',3}
		op_code = 3;
	case {'JSR',4}
		op_code = 4;
	case {'RTS',5}
		op_code = 5;
	case {'BRANCH',6}
		op_code = 6;
	case {'LONG_DELAY',7}
		op_code = 7;
	case {'WAIT',8}
		op_code = 8;
end

inst_addr = calllib(SPINAPI_DLL_NAME,'pb_inst_pbonly',num_flags,op_code,inst_data,length);



		
