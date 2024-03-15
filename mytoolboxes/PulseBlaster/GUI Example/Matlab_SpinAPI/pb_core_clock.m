function pb_core_clock(clock_freq)
%
%pb_core_clock(clock_freq)
%DESCRIPTION: Tell the library what clock frequency the board uses. This should
%be called at the beginning of each program, right after you initialize the
%board with pb_init(). Note that this does not actually set the clock frequency,
%it simply tells the driver what frequency the board is using, since this 
%cannot (currently) be autodetected.
%Also note that this frequency refers to the speed at which the PulseBlaster
%core itself runs. On many boards, this is different than the value printed
%on the oscillator. On RadioProcessor devices, the A/D converter and the 
%PulseBlaster core operate at the same clock frequency. 
%
%INPUTS:
%clock_freq - Frequency of the clock in MHz. 
%OUTPUTS:
%

global SPINAPI_DLL_NAME;

calllib(SPINAPI_DLL_NAME,'pb_core_clock',clock_freq);