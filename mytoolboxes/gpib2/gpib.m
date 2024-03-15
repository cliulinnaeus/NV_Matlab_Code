%GPIB	Interface to National Intruments GPIB controller
%	GPIB allows MATLAB access to the National Instruments GPIB
%	interface board using NI-488M functions; no NI-488.2M 
%	functions are supported. See National Instruments 
%	"NI-488.2M Software Reference Manual" for detailed 
%	documentation of NI-488M calls.
%
%	All NI-488M functions are invoked with the NI-488M routine
%	name (but without the initial 'ib') as the first argument 
%	to GPIB. 
%
%	UD = GPIB( FUNC, ARG1, ARG2, ... ) invokes NI-488M functions
%	which open devices (FUNC either 'find' or 'dev'). UD is the 
%	unit descriptor of the opened device; a negative number is 
%	returned if the open fails.
%
%	[VALUE, IBSTA] = GPIB( FUNC, UD, ARG1, ARG2, ... ) invokes
%	NI-488M C library functions which pass pointers for return 
%	values. Optional argument IBSTA returns the NI-488M global 
%	variable ibsta. FUNC can be 'ask', 'lines', 'ln', 'rd', 'rdb'.
%	'rdi', 'rpp' or 'rsp'.
%
%	IBSTA = GPIB( FUNC, UD, ARG1, ARG2, ... ) is used to invoke
%	all other NI-488M functions.
%
%	GPIB also differs from NI-488M C language library calls in
%	the following ways:
%	1. GPIB does not use string length input arguments.
%	2. If the IBSTA output argument is NOT specified and the 
%	   ERR bit of ibsta is set, GPIB prints error info and 
%	   breaks. If the IBSTA output argument IS specified, then  
%	   GPIB just returns (the caller should handle the error). 
%	3. Added two routines to aid development of GPIB m-files:
%          * IBERR = GPIB('error') -- returns global variable iberr.
%          * GPIB('trace',state) -- enables (state~=0) or disables 
%		(trace=0) tracing of gpib calls. Input arguments
%		are also printed if state>1.
%	4. Added two routines to allow reading arbitarily large
%	   blocks of binary data:
%	   * [VALUE, IBSTA] = GPIB( 'rdb', UD, CNT ) -- requests CNT
%		signed bytes be read and stored into column array 
%		VALUE. The length of VALUE is the number of bytes
%		actually read (ibcnt).
%	   * [VALUE, IBSTA] = GPIB( 'rdi', UD, CNT ) -- requests CNT
%		signed shorts (two byte integers) be read and stored 
%		into column array VALUE. The length of VALUE is the 
%		number of shorts actually read (ibcnt/2). If ibcnt
%		is odd, then the length is (ibcnt+1)/2 and the last
%		byte of the short stored in VALUE is zero.



