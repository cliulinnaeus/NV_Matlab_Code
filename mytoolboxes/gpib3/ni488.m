%  ni488 help file
%
%  ni488('SendIFC')                                         Initialization
%  no_of_bytes_sent = ni488('Send', address, textstring)    Send textstring to a device
%  char_array = ni488('Receive', address, no_of_bytes)      Read no_of_bytes, or until EOI
%  ni488('DevClear',address)                                Send the Device Clear
%  ni488('EnableLocal',addrlist)                            Go To Local
%  ni488('EnableRemote', addrlist)                          Remote Enable
%  ni488('SetRWLS', addrlist)                               Remote Enable and Local Lockout
%  status_byte = ni488('ReadStatusByte', address)           Serial Poll
%  SRQ_status = ni488('TestSRQ')                            =0 if SRQ-line is not asserted
%  SRQ_status = ni488('WaitSRQ')                            Waits until SRQ or timeout
%  ni488('Trigger', address)                                Trigger device (GET)
%  ni488('TriggerList', addrlist)                           Trigger several devices
%  ni488('iblines')                                         State of the 8 GPIB control lines
%  ni488('FreeDll')                                         Unload GPIB-32.DLL
%
%  Function keyword is case insensitive
%
%  Uses NI-488.2 direct entry points to GPIB-32.dll driver from National Instruments:
%  http://www.ni.com/gpib/win98_95cr.htm
%  Also needed GPIB.dll for the installed GPIB controller card
%  and GPIB-16.dll from NI if GPIB-dll is a 16-bit dll
%
%  For more info see:
%  http://zone.ni.com/devzone/devzoneweb.nsf/Opendoc?openagent&78450065E48026A386256800005DDFCE
%  or files included in the compat21.zip downloadable from:
%  http://www.ni.com/gpib/win98_95cr.htm
%
%  NI-488.2M Function reference Manual for Win32 can be downloaded from:
%  http://digital.ni.com/manuals.nsf/
%    860a3b8cde095ab9862566410057ca49/5fab665e3d3a092786256660007498b0?OpenDocument
%
%  Coded by Bengt.Lindgren@Fysik.uu.se  Aug.2000/Nov.2001
%
%  Example - read Fluke45 on GPIB-address 7:
%     ni488('SendIFC');                  % Initialize GPIB (only needed once)
%     ni488('EnableRemote')              % Power on        (only needed once)
%     pause(5)                           % Wait for power on
%     nsend=ni488('Send',14,'vac;val?')  % nsend=9 since \n is added.
%     result=ni488('Receive',14,33)      % 33 is safely more than Fluke will return
%     value=str2num(result)              % convert text to number
%  Set frequency 1.234kHz on function generator PM5138 (addr. 17)
%		f=1.234e3;
%		ni488('Send',17,['FREQ ',num2str(f,4)]);



