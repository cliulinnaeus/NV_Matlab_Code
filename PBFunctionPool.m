function PBFunctionPool(varargin)
%Created by JM
%Modified by Jeronimo Maze 2008-07-10
%Heavily modified by JHODGES 2008-07-15

switch varargin{1}
    case 'PBON'
        PBON(varargin{2});
    case 'CallPBON'
        CallPBON(varargin{2});
    case 'PreprocessPBSequence'
        PreprocessPBSequence(varargin{2});
    case 'RunPBSequence'
        RunPBSequence();
    case 'RunCMD'
        RunCMD(varargin{2},varargin{3});
    case 'CMD2PBI'
        CMD2PBI(varargin{2});
    otherwise
end

function [status] = PreprocessPBSequence(SEQ)
global gmSEQ
% function PreprocessPBSequence
% Given a SEQ structure, this function computes the delay times for all PB
% channels and sends the instructions directly to the PulseBlaster Board
% using spinapi.dll commands from matlab
%
%
%Comments:the maximum delay if FF*(clock time)= 637.5ns (for 400MHz) and
%850ns (for 300MHz).

% jhodges, 13 July 2008
% According to the PB-ESR Pro Manual (version 10-8-2007), the maximum
% duration of type "CONTINUE" is 8-bits of the ClockTime (see Table 3 of
% Appendix I).

ClockTime = 1/500e6;
MinDelay = ClockTime*(2^32);
% MinDelay in ns is:
MinDelay = 1e9*MinDelay;

LONG_DELAY = {'LONG_DELAY'};
CONTINUE = {'CONTINUE'};
LOOP = {'LOOP'};
END_LOOP = {'END_LOOP'};

% set the total number of events to zero
NEvents = 0;

% loop through all the channels and count the total number of events for
% the sequence
for ichn=1:numel(SEQ.CHN)
    NEvents = NEvents + SEQ.CHN(ichn).NRise;
end
    
% define EventM, this stores the PB Pin Number, the Start Rise, and the End
% Rise Times
EventM = zeros(NEvents,3);
event = 1;
for ichn=1:numel(SEQ.CHN)
    for irise = 1:SEQ.CHN(ichn).NRise
        EventM(event,1) = 2^SEQ.CHN(ichn).PBN;
        
        % added in Delays of events
        % jhodges, 30 July 2008
        EventM(event,2) = SEQ.CHN(ichn).T(irise) - SEQ.CHN(ichn).Delays(1);
        EventM(event,3) = SEQ.CHN(ichn).T(irise) + SEQ.CHN(ichn).DT(irise) - SEQ.CHN(ichn).Delays(2);

        %EventM(event,4) = 0;
        event = event + 1;
    end
end

%Convert to nanoseconds
EventM(:,2) = round(1e9*EventM(:,2));
EventM(:,3) = round(1e9*EventM(:,3));

% Convert the EventsM to a 
Events(1:NEvents,1) = EventM(1:NEvents,1);
Events(1:NEvents,2) = EventM(1:NEvents,2);
Events(1+NEvents:2*NEvents,1) = - EventM(1:NEvents,1);
Events(1+NEvents:2*NEvents,2) = EventM(1:NEvents,3);
%Sort events
Events = sortrows(Events,2);

Events(:,2) = Events(:,2) - Events(1,2); %Shift starting point to zero

%Calculate the exact number of pulse blaster events from the time
%coincidence of rise and falls
pb=1;
PBEvents(pb,:) = Events(1,:);

% go through all 2*NEvents items in the Events Matrix
for e=2:2*NEvents
    
    % if the current pulse blaster event time coinicdes with the 'e'-th
    % event, then add that PB output flag to the flags for the current
    % pulse blaster event.  Since the Events are pre-sorted, this has the
    % effect of picking off the same time-coinicidence events
    if PBEvents(pb,2) == Events(e,2)
        PBEvents(pb,1) = PBEvents(pb,1) + Events(e,1);
    
    % if the next Event occurs after the time of the current pulse blaster
    % event, create a new event by incrementing pb.  Since off-times have
    % the pb channel stored as a negative number, we add the channels of
    % the new PB event to the old pb event.  Thus if the newest event turns
    % a channel on, we add that flag.  If the newest event turns the
    % channel off, we effectively subtract the flag.
    else
        pb = pb + 1;
        PBEvents(pb,1) = PBEvents(pb-1,1) + Events(e,1);
        PBEvents(pb,2) = Events(e,2);
    end
end

NPB = pb;

% now, loop through all pulse blaster events.  Since the time first stored
% is absolute, we subtract the current event time from the next event time
% to get the relative duration of each PB event
warn=0;
for pb=1:NPB-1
    timeAfterEvent = PBEvents(pb+1,2)-PBEvents(pb,2);
    if timeAfterEvent < 12 &&timeAfterEvent >0  % && gmSEQ.iAverage==1 && warn==0
        warning(strcat('m=',num2str(SEQ.m),' between  ', num2str(PBEvents(pb,2)), ...
        ' and  ', num2str(PBEvents(pb+1,2)),  ... 
        ' ns includes Pulse Blaster commands less than 12 ns in length. Pulses may not be correct at this data point.'));
        warn=1;
    end
    PBEvents(pb,2) = timeAfterEvent;
end
PB = PBEvents(1:NPB-1,:);
NPB = NPB - 1;

% c is the counter for the CMDs given to the pulseblaster
c=0;

% Now, we loop over the pulse blaster events and decide if the events are
% of the type "CONTINUE" or "LONG DELAY"

for pb=1:NPB
    Six = 2^23+2^22;
    %Output = {dec2hex(PB(pb,1))};
    Output = (PB(pb,1));
    c = c + 1;

    % determine if the PB event is a CONTINUE or a LONG_DELAY
    if PB(pb,2)>MinDelay  %LONG_DELAY
        Inst = LONG_DELAY;
        
        % get the integer number of  MinDelays
        Inst_Data = floor(PB(pb,2)/MinDelay);
        Delay = MinDelay;
        CMD(c,:) = [Output,Inst,Inst_Data,Delay];
        Delay = mod(PB(pb,2),MinDelay);
        
        % add any leftover time as a short delay
        if Delay >= ClockTime
            c = c + 1;
            Inst = CONTINUE;
            Inst_Data = 0;
            CMD(c,:) = [Output,Inst,Inst_Data,Delay];
        end
        
    % if the PB Event is not a LONG_DELAY, it's just a CONTINUE
    else
        Inst = CONTINUE;
        Inst_Data = 0;
        Delay = PB(pb,2);
        CMD(c,:) = [Output,Inst,Inst_Data,Delay];
    end
end

% Validate the CMD by removing erroneously short instruction times due to
% matlab round errors
%
% Validate also checks for short delays, and warns if any problems are found

CMD = ValidateCMD(CMD,ClockTime);
S=CMD2PBI(CMD);
NCMD = size(CMD,1);


% for k=1:NCMD
%     CMD{k,4}=round(CMD{k,4});
% end

%% Short Delays not implemented
% Until we implement the logic for short delays, check to see if all the PB
% instructions are less than 5 clock cycles


%%


% this next block of code takes the basic pulse sequence and repeats it for
% SEQ.Repeat using the LOOP command of the PB code.
a=1;
if strcmp(CMD(1,2),CONTINUE)
    % fixed this error, jhodges, 9 Oct 2008
    %% Old Code
    %%AuxCMD(a,:) = CMD{1,:};
    %%AuxCMD(a,1) = LOOP;
    
    % if first command in sequence is a contiune, change it to a LOOP
    AuxCMD(a,:) = [CMD{1,1},LOOP,SEQ.Repeat,CMD{1,4},CMD{1,5}];
elseif strcmp(CMD(1,2),LONG_DELAY)
    AuxCMD(a,:) = [CMD{1,1},LOOP,SEQ.Repeat,MinDelay,CMD{1,5}];
    a = a +1;
    aux= CMD{1,3};
    AuxCMD(a,:) = [CMD{1,1},LONG_DELAY,CMD{1,3}-1,CMD{1,4},CMD{1,5}];
end    
for c=2:NCMD-1
    a = a + 1;
    AuxCMD(a,:) = CMD(c,:);
end
a = a + 1;
if strcmp(CMD(NCMD,2),CONTINUE)
    AuxCMD(a,:) = CMD(NCMD,:);
    AuxCMD(a,2) = END_LOOP;
elseif strcmp(CMD(NCMD,2),LONG_DELAY)
    AuxCMD(a,:) = [CMD{NCMD,1},LONG_DELAY,CMD{NCMD,3}-1,CMD{NCMD,4},CMD{NCMD,5}];
    a = a + 1;
    AuxCMD(a,:) = [CMD(NCMD,1),END_LOOP,0,MinDelay,CMD{NCMD,5}];
end    
CMD = AuxCMD;
Ncmd= a;
tInSec = lengthSequence(CMD);
global gTimeOut
if tInSec > 10 
    gTimeOut = tInSec + 5;
else 
    gTimeOut = 1.2 * tInSec;
end 
s = CMD2PBI(CMD);
Ncmd = size(CMD,1);

% Changed from TXT file and PB.EXE code to pure matlab functions
% JMazejhodges July 11, 2008
% fid = fopen('pb_seq.txt','wt');
% for cmd = 1:Ncmd
%     fprintf(fid,'flags:%.0f\tinst:%.0f\tinst_data:%.0f\tdelay:%.0f\n',...
%         Six + CMD{cmd,1},ValueCte(CMD{cmd,2}),CMD{cmd,3},CMD{cmd,4});
% end
% fclose(fid);
PBesrInit(); %initialize PBesr
% sets the clock frequency. for PBESR-PRO-400, it's 400MHz
% for PBESR-PRO-333, it's 333.3MHz
PBesrSetClock(500);

PBesrStartProgramming(); % enter the programming mode


% Loop over all commands
for cmd = 1:Ncmd
    %flag = Six + CMD{cmd,1};  % Adding the Six option no longer necessary
    flag = CMD{cmd,1};
    flag_option = CMD{cmd,5};
    inst = char(CMD{cmd,2});
    inst_arg = CMD{cmd,3};
    length = CMD{cmd,4};
    % give the instruction to the PB
    PBstatus = PBesrInstruction(flag, flag_option, inst, inst_arg, length);
    if PBstatus < 0
        warning('Invalid PulseBlaster Instruction (Line %d)\nCMD = [%d]\t[%s]\t[%d]\t[%g]\t[%s]',cmd,flag,inst,inst_arg,length,flag_option);
    end
end

% Last command is to stop the outputs
flag = 0; % set all lines low
PBesrInstruction(flag, flag_option, 'CONTINUE', 0, 100);
PBesrInstruction(flag, flag_option, 'STOP', 0, 100);

PBesrStopProgramming(); % exit the programming mode

%PBesrStart(); %start pulsing. it will start pulse sequence which were progammed/loaded to PBESR card before.

PBesrClose(); %close PBesr
%set status to 0, implement in the future
status = 0;

function PBON(OutPuts)
PBesrInit();%initialize PBesr
% sets the clock frequency. for PBESR-PRO-400, it's 400MHz
% for PBESR-PRO-333, it's 333.3MHz
PBesrSetClock(500); 

PBesrStartProgramming(); % enter the programming mode

label = PBesrInstruction(OutPuts,'ON', 'CONTINUE', 0, 100);
PBesrInstruction(OutPuts,'ON', 'BRANCH', label, 100);

PBesrStopProgramming(); % exit the programming mode

PBesrStart(); %start pulsing. it will start pulse sequence which were progammed/loaded to PBESR card before.

%PBesrStop(); %stop pulsing
PBesrClose(); %close PBesr


function CallPBON(OutPuts)
%This Function receives a Binary number

%Outputs file
WriteOutPuts(OutPuts);

%Executable file
path = '';
file = 'PB_ON.exe';

status = dos([path file]);

function [status] = RunPBSequence()
% function RunPBSequence

PBesrInit(); %initialize PBesr
% sets the clock frequency. for PBESR-PRO-400, it's 400MHz
% for PBESR-PRO-333, it's 333.3MHz
%PBesrSetClock(400);


PBesrStart(); %start pulsing. it will start pulse sequence which were progammed/loaded to PBESR card before.

%GEORG, added
%PBesrStop(); %stop pulsing


PBesrClose(); %close PBesr
%set status to 0, implement in the future
status = 0;

function [] = RunCMD(CMD,pValidate)

if pValidate
    CMD = ValidateCMD(CMD,1/100e6);
end
Ncmd = size(CMD,1);
Six = 2^23+2^22;

PBesrInit(); %initialize PBesr
% sets the clock frequency. for PBESR-PRO-400, it's 400MHz
% for PBESR-PRO-333, it's 333.3MHz
PBesrSetClock(500);

PBesrStartProgramming(); % enter the programming mode


% Loop over all commands
for cmd = 1:Ncmd
    %flag = Six + CMD{cmd,1};  % Adding the Six option no longer necessary
    flag = CMD{cmd,1};
    flag_option = CMD{cmd,5};
    inst = char(CMD{cmd,2});
    inst_arg = CMD{cmd,3};
    length = CMD{cmd,4};
    % give the instruction to the PB
    PBstatus = PBesrInstruction(flag, flag_option, inst, inst_arg, length);
    if PBstatus < 0,
        warning('Invalid PulseBlaster Instruction (Line %d)\nCMD = [%d]\t[%s]\t[%d]\t[%g]\t[%s]',cmd,flag,inst,inst_arg,length,flag_option);
    end
end
CMD
% Last command is to stop the outputs
flag = 0; % set all lines low
PBesrInstruction(flag, flag_option, 'CONTINUE', 0, 100);
PBesrInstruction(flag, flag_option, 'STOP', 0, 100);

PBesrStopProgramming(); % exit the programming mode

PBesrStart(); %start pulsing. it will start pulse sequence which were progammed/loaded to PBESR card before.

PBesrClose(); %close PBesr


function [ValidCMD] = ValidateCMD(CMD,ClockTime)
% checks the CMD structure for erroneously short instruction delays due to
% rounding errors in building the pulse sequence via matlab
a = 1;
for k=1:size(CMD,1)
    if CMD{k,4} > 1 %1 ns is the minimum time
 
        if CMD{k,4} < (1e9*5*ClockTime) % if we find a short delay, we must implement it
            %warning('Pulse Blaster Sequence specified needs short delays.  This is not yet implemented!');
            
            % SHORT DELAY PRIMER
            % jhodges, 18 July 2008
            %
            % By setting bits 21-23 on the pulse blaster we can invoke
            % delays that are shorter than the minimum instruction time for
            % a CONTINUE command (5 clock cycles)
            %
            % SHORT Delays only work for the 4 BNC lines on the output of
            % the pulse blaster.  These correspond to PB0 - PB3, or bits
            % 0 - 3.  You cannot specify which of the 4 BNCs drive high.
            
            % Note that the flags should be set such that bits 21-23 are
            % only set high when the BNCs are in use and should be set to
            % 000 = 0xE00000 when the lines are not in use
            %
            % The following code, which will run in the Spin Core Pulse Interpreter,\
            % has these possible behaviors:
            % 0xFFFFFF, 500ns, LOOP, 100000 //start loop
            % 0x*00000, 100ns //all lines low
            % 0x600008, 20ns // Bit3 short pulse, 3 clock cycles
            % 0x000008, 100ns //all lines low again
            % 0x000000, 100ns, END_LOOP
            % 0x000000, 100ns
            % 0x000000, 100ns, STOP
            %
            % If *=E, that is setting all bits high, then the instruction
            % on the third line does not produce only 3 clock cycles on bit
            % 3, but produces and extra pulse
            %
            % If *=0, the pulse program works as expected with a short, 3
            % cycle pulse on bit3

                       
            % Short delays should already be CONTINUE commands from the
            % preceeding logic
            Delay = CMD{k,4};
            ClockPeriods = round(Delay/ClockTime/1e9);
            % find the binary representation of ClockPeriods
            CPBinary = dec2bin(ClockPeriods,3);
            CPBinary = CPBinary(length(CPBinary)-2:end);
            ShortBitFlag = 2^21*str2num(CPBinary(3)) + ...
                            2^22*str2num(CPBinary(2)) + ...
                            2^23*str2num(CPBinary(1));
            
            % now we bit-wise or the ShortBitFlags with the original
            % instruction
            CMD{k,1} = bitor(CMD{k,1},ShortBitFlag);
            CMD{k,2} = 'CONTINUE';
            CMD{k,4} = 6*1e9*ClockTime;
            CMD{k,5} = ' '; %flag option should be null
        else,
            CMD{k,5} = 'ON'; % ON sets bits 21-23 high
        end
        
        %%
        % Due to a peculiarity in the PB to CMD logic, we can end up
        % having LONG_DELAY types with only 1 multiplier.  These should be
        % made into continue delays
        if strcmp(CMD{k,2},'LONG_DELAY') & CMD{k,3} == 1,
            CMD{k,2} = 'CONTINUE';
            CMD{k,3} = 0;
        end
        
        % Update the ValidCMD with this CMD
        for kk=1:size(CMD,2),
            ValidCMD{a,kk} = CMD{k,kk};
        end
        a = a+1;
     end
end


function s = CMD2PBI(CMD)
% converts a CMD structure to pulse blaster interpreter code for debugging
s = '';
for k=1:size(CMD,1),
    flags = dec2hex(CMD{k,1},6);
    delay = CMD{k,4};
    inst = CMD{k,2};
    inst_opt = CMD{k,3};
    flag_opt = CMD{k,5};
    
    if strcmp(flag_opt,'ON'),
        ON = hex2dec('E00000');
        flags = bitor(ON,CMD{k,1});
        flags = dec2hex(flags);
    end
    
    s = [s,sprintf('0x%s,\t%0.3fns,\t%s,\t%d\n',flags,delay,inst,inst_opt)];
end

function tInSec = lengthSequence(CMD)

LoopFactor = 1; 
dt = 0; 
t = []; 
for kk = (1:size(CMD,1))
    switch cell2mat(CMD(kk,2))
        case 'LOOP'
            LoopFactor = [LoopFactor, cell2mat(CMD(kk,3))]; 
            dt = prod(LoopFactor) * cell2mat(CMD(kk,4)); 
        case 'CONTINUE'
            dt = prod(LoopFactor) * cell2mat(CMD(kk,4)); 
        case 'LONG_DELAY'
            nLongDelay = cell2mat(CMD(kk,3)); 
            dt = prod(LoopFactor) * nLongDelay * 640; 
        case 'END_LOOP'
            dt = prod(LoopFactor) * cell2mat(CMD(kk,4)); 
            LoopFactor(end) = []; 
        otherwise
    end
    t = [t, dt]; 
end

tInSec = LoopFactor * sum(t) * 10^-9;


