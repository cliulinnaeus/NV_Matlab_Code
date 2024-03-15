function [neg_on_err] = pb_start_programming(device)
%[neg_on_err] = pb_start_programming(device)
%DESCRIPTION:
%This function tells the board to start programming one of the onboard
%devices.
%INPUT:
% device - Specifies which device to start programming. Input as String
%    Valid devices are:
%    PULSE_PROGRAM - The pulse program will be programmed using one of the pb_inst* instructions.
%    FREQ_REGS - The frequency registers will be programmed using the pb_set_freq() function. (DDS and RadioProcessor boards only)
%    TX_PHASE_REGS - The phase registers for the TX channel will be programmed using pb_set_phase() (DDS and RadioProcessor boards only)
%    RX_PHASE_REGS - The phase registers for the RX channel will be programmed using pb_set_phase() (DDS enabled boards only)
%    COS_PHASE_REGS - The phase registers for the cos (real) channel (RadioProcessor boards only)
%    SIN_PHASE_REGS - The phase registers for the sine (imaginary) channel (RadioProcessor boards only)
%OUTPUT:
% neg_on_err - A negative number is returned on failure, and spinerr is set
%               to a description of the error. 0 is returned on success. 

global SPINAPI_DLL_NAME;

if(isa(device,'char'))
    device = upper(device);
else
    error([device,'is not an acceptable input']);
end

switch device
	case {'PULSE_PROGRAM','pulse_program'}
		op_code = 0;
	case {'FREQ_REGS','freq_regs'}
		op_code = 1;
	case {'TX_PHASE_REGS','tx_phase_regs'}
		op_code = 2;
	case {'RX_PHASE_REGS','rx_phase_regs'}
		op_code = 3;
	case {'COS_PHASE_REGS','cos_phase_regs'}
		op_code = 51;
	case {'SIN_PHASE_REGS','sin_phase_regs'}
		op_code = 50;
end

neg_on_err = calllib(SPINAPI_DLL_NAME,'pb_start_programming',op_code);