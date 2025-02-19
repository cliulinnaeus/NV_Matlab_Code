function ExperimentYaoFunctionPool(what,hObject, eventdata, handles)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%% Written by Thomas Mittiga, May 2016 %%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%% UC Berkeley, Berkeley , USA  %%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

switch what
    case 'Start'
        StartUp(hObject, eventdata, handles) 
    case 'Rabi' 
        Rabi(hObject, eventdata, handles) 
    case 'UserWave'
        %UserWave(hObject, eventdata, handles)
        AWG_Measure_User(hObject, eventdata, handles)
    case 'DC_Offsets'
        DC_Offsets(hObject, eventdata, handles)
    otherwise
end
end

function StartUp(hObject, eventdata, handles) 

global Sent Seq samples len Readout DC_off

% Define Sent to track what has been sent to AWG and assume nothing was 
%sent to the AWG today
Sent.Rabi = 0 ;
Sent.Deer = 0 ; 
Sent.User = 0 ;

% Define Seq to track which sequence is loaded and assume the AWG's current 
%sequence is empty
Seq.Rabi = 0 ;
Sent.Deer = 0 ;
Seq.User = 0 ;

samples = 1000 % 1000MHz sample rate of AWG
len.rabi = 1 ; %length of waveform in us

Readout = 'SPCM';

DC_off.I=0.01 %V
DC_off.Q=0.01 %V
end

function Rabi(hObject, eventdata, handles)

global SentRabi Seq samples len DC_off 

DC=[DC_off.I DC_off.Q,0,0]; %Offsets of Ch1 2 3 4
Amp=[0.5,0.5,0,0]; %Amp of Ch1 2 3 4

% 
% if ~Sent.Rabi % If current version of Rabi hasn't been sent to the AWG
%     disp(' ')
%     disp('--- Sending Rabi to AWG')
%     [Ch1, Ch2, Ch3, Ch4, Mk1, Mk2, Mk3, Mk4, Mk5, Mk6, Mk7, Mk8] = AWG_Measure_Rabi();
%     SendWF2AWG(len.rabi, Ch1, Ch2, Ch3, Ch4, Mk1, Mk2, Mk3, Mk4, Mk5, Mk6, Mk7, Mk8,'Rabi');
%     Sent.Rabi = 1
% end
% 
% if ~Seq.Rabi % If Rabi is not the current sequence
%     disp(' ')
%     disp('--- Setting AWG sequence to Rabi')
%     CreateSeq(20,5000,1,'Rabi',DC,Amp);
%     %Mark that Rabi is currently loaded on AWG
%     Seq.Rabi = 1 % Redundant with the following function
%     Loop_Remaining_Structure('Rabi', Seq); 
% end

% On the first run, we have to send and load all channels of the Rabi
% sequence
MWlength=0;
disp(' ')
disp('--- Sending Rabi to AWG')
[Ch1, Ch2, Ch3, Ch4, Mk1, Mk2, Mk3, Mk4, Mk5, Mk6, Mk7, Mk8] = AWG_Measure_Rabi(MWLength);
SendWF2AWG(len.rabi, Ch1, Ch2, Ch3, Ch4, Mk1, Mk2, Mk3, Mk4, Mk5, Mk6, Mk7, Mk8,'Rabi');
SentRabi.Ch1 = 1;
SentRabi.Ch2 = 1;
SentRabi.Ch3 = 1;
SentRabi.Ch4 = 1;
SentRabi.Mk1 = 1;
SentRabi.Mk2 = 1;
SentRabi.Mk3 = 1;
SentRabi.Mk4 = 1;
SentRabi.Mk5 = 1;
SentRabi.Mk6 = 1;
SentRabi.Mk7 = 1;
SentRabi.Mk8 = 1;
% Note that these channels were sent

disp(' ')
disp('--- Setting AWG sequence to Rabi')
CreateSeq(20,5000,1,'Rabi',DC,Amp);
%Mark that Rabi is currently loaded on AWG
Seq.Rabi = 1 % Redundant with the following function
Loop_Remaining_Structure('Rabi', Seq);

fwrite(Detector, uint8(hex2dec(['00','01'])));
OutputAWG(1,1,1,0,0);


while MWLength = 5:5:1000
    disp(' ')
    disp('--- Sending Rabi to AWG')
    [Ch1, Ch2, Ch3, Ch4, Mk1, Mk2, Mk3, Mk4, Mk5, Mk6, Mk7, Mk8] = AWG_Measure_Rabi(MWLength);
    SendWF2AWG(len.rabi, Ch1, Ch2, Ch3, Ch4, Mk1, Mk2, Mk3, Mk4, Mk5, Mk6, Mk7, Mk8,'Rabi');
    Sent.Rabi = 1

    disp(' ')
    disp('--- Setting AWG sequence to Rabi')
    CreateSeq(20,5000,1,'Rabi',DC,Amp);
    %Mark that Rabi is currently loaded on AWG
    Seq.Rabi = 1 % Redundant with the following function
    Loop_Remaining_Structure('Rabi', Seq); 
    
    fwrite(Detector, uint8(hex2dec(['00','01'])));
    OutputAWG(1,1,1,0,0);
    
    %%%Got to here----
end

Plot_AWG_Sequence()


% Put FPGA into sequence Mode (See Chong's powerpoint)


end


function UserWave(hObject, eventdata, handles)

global Sent Seq


if ~Sent.User % If current version of User's Wave hasn't been sent to the AWG
    disp(' ')
    disp('--- Sending User Wave to AWG')
    [Ch1 Ch2 Mk1 Mk2 Mk3 Mk4] = AWG_Measure_User(sweeptime,gr_toff,gr_ton);
    SendWF2AWG(samples,len, wave1,wave2,wave3, wave4, m1,m2,m3,m4,m5,m6,m7,m8,'User');
end

if ~Seq.User % If User's wave is not the current sequence
    disp(' ')
    disp('--- Setting AWG sequence to User Wave')
    CreateSeq(loop_standard,loop_count,elem_ind,'User');
    %Mark that Rabi is currently loaded on AWG
    Loop_Remaining_Structure('User', Seq); 
end

Plot_AWG_Sequence()

ReadyRead();
OutputAWG(1);

end

function NewStruct=Loop_Remaining_Structure(unchanged_fieldnames, structure, val)
%Takes a cell of structure elements as an input, and sets all other 
%elements of that structure to val

%Rather than learn matlab, I'm just gonna store the original value in a
%temporary variable
i=0;
for str=unchanged_fieldnames
    i=i+1;
    temp(i) = structure.(char(str));
end

fn = fieldnames(structure);

%Set all elements of structure to specified value
for str = fn'
    structure.(char(str)) = val;
end

%Set unchanged elements of structure back to original value
i=0;
for str=unchanged_fieldnames
    i=i+1;
    structure.(char(str)) = temp(i);    
end

NewStruct=structure;


end

% Stored Rabi Sequence before Wave_Generator processing
function [Ch1, Ch2, Ch3, Ch4, Mk1, Mk2, Mk3, Mk4, Mk5, Mk6, Mk7, Mk8] = AWG_Measure_Rabi(MWLength) 

global Readout Rabi
% t2pi=24;
% tpi2=12;

   %Inputs to Wave_generator must be written in the form
   % For Analog
   %[t1,t2,freq1,phase1,amp1;...
   % t3,t4,freq2,phase2,amp2;...
   %...]
   %
   % For Digital
   %[t1,t2,value1;...
   %t3,t4,value2;...
   %...]

   %%% README: These are inputs for waveFORMS. Waveforms are normalized and
   %%% have no offset. If you want to add an offset or amplitude, you must do it with
   %%% CreateSeq
   
   %%% 10% duty cycle for a 10us sequence is 1us
   
   %%% Delays are not applied in this sequence
   
%%%%%% Mixer control: I %%%%%% 
Rabi.Ch1 = [3050,3051+MWLength,0,pi/2,1]; 
        % Wait for Laser to polarize and 50ns
         %Apply MW
%Wave_generator creates sine, so need pi/2 when DC
%Switch is ~3ns before I and Q
%I and Q turn off 3ns before switch

% [100;... %% Rabi 
%        sweeptime;...
%        1];   

%%%%%% Mixer control: Q %%%%%% 
Rabi.Ch2 = [3050,3051+MWLength,0,pi/2,1]; 
        % Wait for Laser to polarize and 50ns
         %Apply MW
   
%%%%%% Switch %%%%%% 
Rabi.Mk1 = [3047,3054+MWLength,0,pi/2,1]; 
     % Wait for Laser to polarize and turn off
     %turn on and off
%Switch is on 3ns before I and Q and off 3ns after

%%%%%% Laser %%%%%% 
Rabi.Mk2 = [0,3000,1;... %Polarize for 3us
    3001,4101,0;... %wait for: 50ns, max MW duration, 50ns
    4102,7102,1];  %detection for 3us

%%%%%% FPGA Signal %%%%%% 
Rabi.Mk3 = [4102,4402,1]; 
%300ns detection window when laser turns on

%%%%%% FPGA Reference %%%%%% 
Rabi.Mk4 = [6802,7102,1];
%300ns detection window for last 300ns of laser detection pulse

%%%%%% Trigger %%%%%% 
Rabi.Mk5 = [0,500,1];  %Trigger for observation on Oscope 

%%%%%% Unused %%%%%
Rabi.Mk6 = [0,0,0];  
Rabi.Mk7 = [0,0,0];  
Rabi.Mk8 = [0,0,0];  
  
%adjust for readout and MW delay
[Ch1, Ch2, Ch3, Ch4, Mk1, Mk2, Mk3, Mk4, Mk5, Mk6, Mk7, Mk8] = delays(Readout, Ch1, Ch2, Ch3, Ch4, Mk1, Mk2, Mk3, Mk4, Mk5, Mk6, Mk7, Mk8)

end 

function AWG_Measure_User(hObject, eventdata, handles)
% Takes info from textbox and turns it into array for each channel
%get(handles.Ch1,'String')
end

function Plot_AWG_Sequence()

global Inputs  
SamplingRate = Inputs.SamplingRate; 

clf(figure(124))
figure(124)
hold on 

for mm=1:length(Inputs.Seq_Cell)

xoff=0;
for u=1:mm-1
    seq_mat=Inputs.Seq_Cell{u};
    xoff = xoff+sum(seq_mat(:,1))*Inputs.Loops(u);
end

AWGseq = Inputs.Seq_Cell{mm};
baretime=sum(AWGseq(:,1));
AWG_subseq=AWGseq;
for v=2:Inputs.Loops(mm)
AWGseq=[AWGseq;AWG_subseq];
end

t = 0; 
SumAWGseq = [zeros(size(AWGseq)); zeros(size(AWGseq))];


for kk = 1:size(AWGseq,1)-1 
     
    t = t + AWGseq(kk,1); 
    
    SumAWGseq(2*kk-1,1) = t;
    SumAWGseq(2*kk,1) = t; 
    
    SumAWGseq(2*kk-1,2:end) = AWGseq(kk,2:end); 
    SumAWGseq(2*kk,2:end) = AWGseq(kk+1,2:end); 
    
end 

%account for steps before first defined point
SumAWGseq=[[0 AWGseq(1,2:end)];SumAWGseq];

% SumAWGseq(end-1:end,:) = []; 
t = t + AWGseq(end,1);
SumAWGseq(end-1,1) = t;
SumAWGseq(end,1) = t;
SumAWGseq(end-1,2:end) = AWGseq(end,2:end); 
SumAWGseq(end,2:end) = AWGseq(end,2:end);

SumAWGseq(:,1) = SumAWGseq(:,1) / SamplingRate; %% Convert back from clock cycles to ns 

%plot loop counter
nLoops=Inputs.Loops(mm);
if nLoops>1
    if mod(mm,2) == 0
        plot(xoff+SumAWGseq(:,1),SumAWGseq(:,1)*0+6.8,'-k') 
        text(xoff,7,[num2str(baretime) 'ns x ' num2str(nLoops)])
    else
        plot(xoff+SumAWGseq(:,1),SumAWGseq(:,1)*0+7,'-k')        
        text(xoff,7.2,[num2str(baretime) 'ns x ' num2str(nLoops)])
    end
end


%figure(124) 
area(xoff+SumAWGseq(:,1), SumAWGseq(:,2), 'EdgeColor','r', 'FaceColor','r', 'BaseValue',0)
%hold on 
area(xoff+SumAWGseq(:,1), SumAWGseq(:,3)+1.1, 'EdgeColor','g', 'FaceColor','g','BaseValue',1.1) 
area(xoff+SumAWGseq(:,1), SumAWGseq(:,4)+2.2, 'EdgeColor','b', 'FaceColor','b','BaseValue',2.2) 
area(xoff+SumAWGseq(:,1), SumAWGseq(:,5)+3.3, 'EdgeColor','m', 'FaceColor','m','BaseValue',3.3) 
area(xoff+SumAWGseq(:,1), SumAWGseq(:,6)+4.4, 'EdgeColor','c', 'FaceColor','c','BaseValue',4.4) 
area(xoff+SumAWGseq(:,1), SumAWGseq(:,7)+5.5, 'EdgeColor','k', 'FaceColor','k','BaseValue',5.5) 

plot(xoff+SumAWGseq(:,1), SumAWGseq(:,2), '-r') 
plot(xoff+SumAWGseq(:,1), SumAWGseq(:,3)+1.1, '-g') 
plot(xoff+SumAWGseq(:,1), SumAWGseq(:,4)+2.2, '-b') 
plot(xoff+SumAWGseq(:,1), SumAWGseq(:,5)+3.3, '-m') 
plot(xoff+SumAWGseq(:,1), SumAWGseq(:,6)+4.4,'-c') 
plot(xoff+SumAWGseq(:,1), SumAWGseq(:,7)+5.5, '-k') 
%hold off 

if mod(mm,50)==0
disp(['calculating plot: ' num2str(mm) '/' num2str(length(Inputs.Seq_Cell))])
end

end
disp('calculating plot: done')

ylim([-1.1 7.5])
figure(124)
set(gca,'YTickLabel',[]);
set(gca,'YTick',[]);
hold off 

end 

function [Ch1, Ch2, Ch3, Ch4, Mk1, Mk2, Mk3, Mk4, Mk5, Mk6, Mk7, Mk8] = delays(Readout, Ch1, Ch2, Ch3, Ch4, Mk1, Mk2, Mk3, Mk4, Mk5, Mk6, Mk7, Mk8)

Readout

AWG2I = 50;
AWg2Q = 50;
AWG2Switch = 47; 
AWG2AOM = 100;
AWG2Count = 80;
AWG2FPGA = 80;

if strcmp(Readout,'SPCM')
    Ch1(:,1:2)=Ch1(:,1:2)+AWG2I; %adjust all time stamps
    Ch1=cat(1,[0,0,0,0,0],Ch1); %Wave_generator interprets prepended 0 as 0s until the first explicitly specified time
    %Also, it indicates to Wave_generator to fill 0s from the last
    %specified time to the specified length of the waveform.
    Ch2(:,1:2)=Ch2(:,1:2)+AWG2Q;
    Ch2=cat(1,[0,0,0,0,0],Ch2);
    Ch3(:,1:2)=Ch3(:,1:2)+0;
    Ch3=cat(1,[0,0,0,0,0],Ch3);
    Ch4(:,1:2)=Ch4(:,1:2)+850;
    Ch4=cat(1,[0,0,0,0,0],Ch4);
    Mk1(:,1:2)=Mk1(:,1:2)+AWG2Switch;
    Mk1=cat(1,[0,0,0,0,0],Mk1);
    Mk2(:,1:2)=Mk2(:,1:2)+AWG2AOM;
    Mk2=cat(1,[0,0,0,0,0],Mk2);
    Mk3(:,1:2)=Mk3(:,1:2)+AWG2Count;
    Mk3=cat(1,[0,0,0,0,0],Mk3);
    Mk4(:,1:2)=Mk4(:,1:2)+AWG2FPGA;
    Mk4=cat(1,[0,0,0,0,0],Mk4);
    Mk5(:,1:2)=Mk5(:,1:2)+0;
    Mk5=cat(1,[0,0,0,0,0],Mk5);
    Mk6(:,1:2)=Mk6(:,1:2)+0;
    Mk6=cat(1,[0,0,0,0,0],Mk6);
    Mk7(:,1:2)=Mk7(:,1:2)+0;
    Mk7=cat(1,[0,0,0,0,0],Mk7);
    Mk8(:,1:2)=Mk8(:,1:2)+0;
    Mk8=cat(1,[0,0,0,0,0],Mk8);

elseif strcmp(Readout,'Jim')
    Ch1(:,1:2)=Ch1(:,1:2)+AWG2I; %adjust all time stamps
    Ch1=cat(1,[0,0,0,0,0],Ch1); %Wave_generator interprets prepended 0 as 0 until the first explicitly specified time
    Ch2(:,1:2)=Ch2(:,1:2)+AWG2Q;
    Ch2=cat(1,[0,0,0,0,0],Ch2);
    Ch3(:,1:2)=Ch3(:,1:2)+0;
    Ch3=cat(1,[0,0,0,0,0],Ch3);
    Ch4(:,1:2)=Ch4(:,1:2)+850;
    Ch4=cat(1,[0,0,0,0,0],Ch4);
    Mk1(:,1:2)=Mk1(:,1:2)+AWG2Switch;
    Mk1=cat(1,[0,0,0,0,0],Mk1);
    Mk2(:,1:2)=Mk2(:,1:2)+AWG2AOM;
    Mk2=cat(1,[0,0,0,0,0],Mk2);
    Mk3(:,1:2)=Mk3(:,1:2)+AWG2Count;
    Mk3=cat(1,[0,0,0,0,0],Mk3);
    Mk4(:,1:2)=Mk4(:,1:2)+AWG2FPGA;
    Mk4=cat(1,[0,0,0,0,0],Mk4);
    Mk5(:,1:2)=Mk5(:,1:2)+0;
    Mk5=cat(1,[0,0,0,0,0],Mk5);
    Mk6(:,1:2)=Mk6(:,1:2)+0;
    Mk6=cat(1,[0,0,0,0,0],Mk6);
    Mk7(:,1:2)=Mk7(:,1:2)+0;
    Mk7=cat(1,[0,0,0,0,0],Mk7);
    Mk8(:,1:2)=Mk8(:,1:2)+0;
    Mk8=cat(1,[0,0,0,0,0],Mk8);
else
    disp('error: delay is ill-defined')
end

end

%Note, this function outputs single form numbers to be compatible with AWG
function A = Wave_generator (Waveform, Sample_rate, Length)
   %Inputs to Wave_generator must be written in the form
   % For Analog
   %[t1,t2,freq1,phase1,amp1;...
   % t3,t4,freq2,phase2,amp2;...
   %...]
   %
   % For Digital
   %[t1,t2,value1;...
   %t3,t4,value2;...
   %...]

   %%% README: This function produces waveFORMS. Waveforms are normalized and
   %%% have no offset. If you want to add an offset or amplitude, you must do it with
   %%% CreateSeq
   %%% Wave_generator interprets prepended 0 as 0 until the first explicitly specified time
   %%% Also, it indicates to Wave_generator to fill 0s from the last
   %%% specified time to the specified length of the waveform.
   
% tic
% Sample_rate = 1000; %MHz
% Length = 1; %us
i = 0;
Total = Length*Sample_rate;
% result = 0;
A = [];
[dimx,dimy] = size(Waveform);  % dimy == 3 Digital waveform, dimy == 5 Analog wave
if ( (dimy == 5) || (dimy == 6))
    while (i < dimx)
        i = i+1;
        B = round( Waveform(i,1)):round((Waveform(i,2)-1));
        C = Waveform(i,5)*sin(2 * pi * Waveform(i,3) / Sample_rate * B + Waveform(i,4));
        if (dimy == 6)
            Delay = zeros(1,Waveform(i,6));
        elseif (dimy == 5)
            if (i < dimx)
                Delay = zeros(1,Waveform(i+1,1)-Waveform(i,2));
            elseif (i == dimx)
                Delay = zeros(1,Total-Waveform(i,2));
            end
        end
        A = [A, C, Delay];
    end
    
elseif ((dimy == 9) || (dimy == 8)) % Adding of 2 frequencies
    while (i < dimx)
        i = i+1;
        B = round(Waveform(i,1)):round((Waveform(i,2)-1));
        C = Waveform(i,5)*sin(2 * pi * Waveform(i,3) / Sample_rate * B + Waveform(i,4)) +  Waveform(i,8)*sin(2 * pi * Waveform(i,6) / Sample_rate * B + Waveform(i,7));
        if (dimy == 9)
            Delay = zeros(1,Waveform(i,9));
        elseif (dimy == 8)
            if (i < dimx)
                Delay = zeros(1,Waveform(i+1,1)-Waveform(i,2));
            elseif (i == dimx)
                Delay = zeros(1,Total-Waveform(i,2));
            end
        end
        A = [A, C, Delay];
    end
    
elseif (dimy == 3) % dimy == 3 Digital waveform, dimy == 5,6,8,9 Analog wave

    while (i <dimx)
        i = i+1;
            C = Waveform(i,3) * ones(1,round(Waveform(i,2)) - round(Waveform(i,1)));
            if (i < dimx)
                Delay = zeros(1,Waveform(i+1,1)-Waveform(i,2));
            elseif (i == dimx)
                Delay = zeros(1,Total-Waveform(i,2));
            end

            A = [A, C, Delay];
    end
elseif (dimy == 2) % Digital with only amp=1 element    
   while (i <dimx)
        i = i+1;
        C = ones(1,round(Waveform(i,2)) - round(Waveform(i,1)));
        if (i < dimx)
            Delay = zeros(1,Waveform(i+1,1)-Waveform(i,2));
        elseif (i == dimx)
            Delay = zeros(1,Total-Waveform(i,2));
        end
        A = [A, C, Delay];
   end
end

A = single(A);

end

function SendWF2AWG(len, wave1,wave2,wave3, wave4, m1,m2,m3,m4,m5,m6,m7,m8,name) 
%% AWG MATLAB ICT Send Waveform 3
% Date 10-9-2009
% by Carl https://forum.tek.com/viewtopic.php?f=580&t=133570
% ==================
% Send a waveform to the AWG using the Real format
% 
%
% ==================

%% Preprocessing
global samples 

%%%%%% Generate Waves %%%%%%
wave11 = Wave_generator(wave1,samples,len);
wave22 = Wave_generator(wave2,samples,len);
wave33 = Wave_generator(wave3,samples,len);
wave44 = Wave_generator(wave4,samples,len);
m11 = Wave_generator(m1,samples,len);
m22 = Wave_generator(m2,samples,len);
m33 = Wave_generator(m3,samples,len);
m44 = Wave_generator(m4,samples,len);
m55 = Wave_generator(m5,samples,len);
m66 = Wave_generator(m6,samples,len);
m77 = Wave_generator(m7,samples,len);
m88 = Wave_generator(m8,samples,len);

for kk=1:length(wave)
    
end

% encode marker 1 bits to bit 6
m11 = bitshift(uint8(logical(m11)),6); %check dec2bin(m1(2),8)
% encode marker 2 bits to bit 7
m22 = bitshift(uint8(logical(m22)),7); %check dec2bin(m2(2),8)
% As above for  remaining
m33 = bitshift(uint8(logical(m33)),6); %check dec2bin(m1(2),8)
m44 = bitshift(uint8(logical(m44)),7); %check dec2bin(m2(2),8)
m55 = bitshift(uint8(logical(m55)),6); %check dec2bin(m1(2),8)
m66 = bitshift(uint8(logical(m66)),7); %check dec2bin(m2(2),8)
m77 = bitshift(uint8(logical(m77)),6); %check dec2bin(m1(2),8)
m88 = bitshift(uint8(logical(m88)),7); %check dec2bin(m2(2),8)

%%%%%% merge markers %%%%%% 
m12 = m11 + m22; %check dec2bin(m(2),8)
m34 = m33 + m44; %check dec2bin(m(2),8)
m56 = m55 + m66; %check dec2bin(m(2),8)
m78 = m77 + m88; %check dec2bin(m(2),8)

%%%%%% stitch wave data with marker data as per progammer manual %%%%%% 
binblock1 = zeros(1,samples*5,'uint8'); % real uses 5 bytes per sample
for k=1:samples
    binblock1((k-1)*5+1:(k-1)*5+5) = [typecast(wave11(k),'uint8') m12(k)];
%     binblock1((k-1)*5+1:(k-1)*5+5) = [typecast(y(k),'uint8') m12(k)];
end
binblock2 = zeros(1,samples*5,'uint8'); % real uses 5 bytes per sample
for k=1:samples
    binblock2((k-1)*5+1:(k-1)*5+5) = [typecast(wave22(k),'uint8') m34(k)];
end
binblock3 = zeros(1,samples*5,'uint8'); % real uses 5 bytes per sample
for k=1:samples
    binblock3((k-1)*5+1:(k-1)*5+5) = [typecast(wave33(k),'uint8') m56(k)];
%     binblock1((k-1)*5+1:(k-1)*5+5) = [typecast(y(k),'uint8') m12(k)];
end
binblock4 = zeros(1,samples*5,'uint8'); % real uses 5 bytes per sample
for k=1:samples
    binblock4((k-1)*5+1:(k-1)*5+5) = [typecast(wave44(k),'uint8') m78(k)];
end
clear wave1 wave2 wave3 wave4 m1 m2 m3 m4 m5 m6 m7 m8;

%%%%%% build binblock header %%%%%% 
bytes = num2str(length(binblock1)); %All binblocks are the same length
header = ['#' num2str(length(bytes)) bytes]; %This is IEEE standard

%% Transfer to Instrument

%%%%%% Initialize Instrument %%%%%%
awg = visa(visa_vendor,visa_address,'InputBufferSize',buffer, ...
    'OutputBufferSize',buffer); %Default buffer size is 512. AWG can do more
fopen(awg);

%%%%%% clear waveform %%%%%% 
fwrite(awg,['wlis:wav:del "' name 'ch1"']) 
fwrite(awg,['wlis:wav:del "' name 'ch2"'])
%fwrite(awg, 'WLIST:SIZE? '); 
%check=fscanf(awg,'%s'); % Check size of waveform list
%If all deleted, should return 25

%%%%%% write ch 1 %%%%%% 
%Create an empty waveform with name and datasize
fwrite(awg,[':wlist:waveform:new "' name 'ch1",' num2str(samples) ',real;']);
%The Command for transfering data from an external controller to awg. The
%syntax used here is WLIST:WAVEFORM:DATA <wfm_name>,<bloack_data>
cmd1 = [':wlist:waveform:data "' name 'ch1",' header binblock1 ';'];
%fwrite(awg,'sour1:wav "isoya_sm_ch1_s1"')

%%%%%% write ch 2 %%%%%% 
fwrite(awg,[':wlist:waveform:new "' name 'ch2",' num2str(samples) ',real;']);
cmd2 = [':wlist:waveform:data "' name 'ch2",' header binblock2 ';'];
%fwrite(awg,'sour2:wav "isoya_sm_ch2_s1"')

%%%%%% write ch 3 %%%%%% 
fwrite(awg,[':wlist:waveform:new "' name 'ch3",' num2str(samples) ',real;']);
cmd2 = [':wlist:waveform:data "' name 'ch3",' header binblock3 ';'];
%fwrite(awg,'sour2:wav "isoya_sm_ch2_s1"')

%%%%%% write ch 4 %%%%%% 
fwrite(awg,[':wlist:waveform:new "' name 'ch4",' num2str(samples) ',real;']);
cmd2 = [':wlist:waveform:data "' name 'ch4",' header binblock4 ';'];
%fwrite(awg,'sour2:wav "isoya_sm_ch2_s1"')

bytes = length(cmd1); % EOIMode applies only to visa objects
if buffer >= bytes 
    fwrite(awg,cmd1);
    fwrite(awg,cmd2);
    fwrite(awg,cmd3);
    fwrite(awg,cmd4);
else %Send waveform in buffer-sized chunks if too big
    awg.EOIMode = 'off';
    for i = 1:buffer:bytes-buffer
        %length(cmd(i:i+buffer-1))
        fwrite(awg,cmd1(i:i+buffer-1))
        fwrite(awg,cmd2(i:i+buffer-1))
        fwrite(awg,cmd3(i:i+buffer-1))
        fwrite(awg,cmd4(i:i+buffer-1))
    end
    awg.EOIMode = 'on';
    i=i+buffer;
    %length(cmd(i:end))
    fwrite(awg,cmd1(i:end))
    fwrite(awg,cmd2(i:end))
    fwrite(awg,cmd3(i:end))
    fwrite(awg,cmd4(i:end))
end

fprintf(awg,['%s\n',':wlist:waveform:data? "' name 'ch1"']); 
ch1=fscanf(awg,'%s');
fprintf(awg,['%s\n',':wlist:waveform:data? "' name 'ch2"']); 
ch2=fread(awg,'uint8');
fprintf(awg,['%s\n',':wlist:waveform:data? "' name 'ch3"']); 
ch3=fscanf(awg,'%s');
fprintf(awg,['%s\n',':wlist:waveform:data? "' name 'ch4"']); 
ch4=fread(awg,'uint8');


if isempty(ch1)
    'Ch1 Did not load successfully'
else
    'Ch1 Likely Loaded Successfully'    
end

if isempty(ch2)
    'Ch2 Did not load successfully'
else
    'Ch2 Likely Loaded Successfully'    
end

if isempty(ch3)
    'Ch3 Did not load successfully'
else
    'Ch3 Likely Loaded Successfully'    
end

if isempty(ch4)
    'Ch4 Did not load successfully'
else
    'Ch4 Likely Loaded Successfully'    
end
    

% Gracefully disconnect
fclose(awg);
delete(awg);    %delete instrument object
clear awg; 

%% Notes
%{
% The real waveform type is not a voltage, but a scaling factor.  Maximum
% value is 1 while minimum value is -1. The resulting output voltage can be
% calculated by the following formula: my_real_wfm(sample) *
% (amplitude_setting/2) + offset_setting = output_voltage
%
% The real waveform type uses 5 bytes per sample while the integer type
% uses 2 bytes.
%
% The integer type allows for the most efficient and precise control of an
% AWG
%
% The real type allows for dynamic scaling of waveform data at run-time.
% This allows for math operations or changing bits of precision (i.e. AWG5k
% (14-bit) to/from AWG7k (8-bit), AWG7k 8-bit mode to/from AWG7k 10-bit
% mode) minimal degradation of sample data.
%}
end

function CreateSeq(loop_standard,loop_count,elem_ind,name,DC,AMP)
global samples buffer

DC_Ch1 = DC(1);
DC_Ch2 = DC(2);
DC_Ch3 = DC(3);
DC_Ch4 = DC(4);
AMPL_Ch1= AMP(1);
AMPL_Ch2= AMP(2);
AMPL_Ch3= AMP(3);
AMPL_Ch4= AMP(4);
    
%%%%%% Initialize Instrument %%%%%%
awg = visa(visa_vendor,visa_address,'InputBufferSize',buffer, ...
    'OutputBufferSize',buffer); %Default buffer size is 512. AWG can do more
fopen(awg);

%go to sequence mode
fprintf(awg, '%s\n', 'AWGC:RMOD SEQ');

%write waveforms into sequence
fprintf(awg, '%s\n',['SEQ:LENG ' num2str(loop_standard)]);
for kk=floor(elem_ind):loop_standard
    %Assign waveform to specific channels for nLoop counts in the sequence
    fprintf(awg, '%s\n',['SEQ:ELEM' num2str(kk) ':WAV1 "' name 'ch1"']); %Test with a predefined waveform
    fprintf(awg, '%s\n',['SEQ:ELEM' num2str(kk) ':WAV2 "' name 'ch2"']); %Test with a predefined waveform
    fprintf(awg, '%s\n',['SEQ:ELEM' num2str(kk) ':WAV3 "' name 'ch3"']); %Test with a predefined waveform
    fprintf(awg, '%s\n',['SEQ:ELEM' num2str(kk) ':WAV4 "' name 'ch4"']); %Test with a predefined waveform
    fprintf(awg, '%s\n',['SEQ:ELEM' num2str(kk) ':LOOP:COUN ' num2str(loop_count)]);
    %Number of times to loop element is max 65536 if you don't hit the
    %waveform memory limit first
    %fwrite(awg,['SEQ:ELEM' num2str(kk) ':GOTO:STAT 0']) %% Turns off the ability of the GoTo:Index to take effect for this element
end

%fwrite(awg,['SEQ:ELEM' num2str(loop_standard) ':GOTO:STAT 1']) %%Turns on the GoTo:Index ability for the last element in the sequence
%fwrite(awg,['SEQ:ELEM' num2str(loop_standard) ':GOTO:IND 1']) %%Goes to the first index (index 1) in the last element of the sequence

%%%%%% DC offset %%%%%% 
fwrite(awg,['sour1:volt:offs ' num2str(DC_Ch1)])
fwrite(awg,['sour2:volt:offs ' num2str(DC_Ch2)])
fwrite(awg,['sour3:volt:offs ' num2str(DC_Ch3)])
fwrite(awg,['sour4:volt:offs ' num2str(DC_Ch4)])

%%%%%% amp %%%%%% 
fwrite(awg,['sour1:volt:ampl ' num2str(AMPL_Ch1)])
fwrite(awg,['sour2:volt:ampl ' num2str(AMPL_Ch2)])
fwrite(awg,['sour3:volt:ampl ' num2str(AMPL_Ch3)])
fwrite(awg,['sour4:volt:ampl ' num2str(AMPL_Ch4)])

s = ['SOURCE1:FREQUENCY' , num2str(samples),'MHz'];
fprintf(awg, '%s\n', s);

% Gracefully disconnect
fclose(awg);
delete(awg);    %delete instrument object
clear awg; 

%% Notes
%{
% The real waveform type is not a voltage, but a scaling factor.  Maximum
% value is 1 while minimum value is -1. The resulting output voltage can be
% calculated by the following formula: my_real_wfm(sample) *
% (amplitude_setting/2) + offset_setting = output_voltage
%
% The real waveform type uses 5 bytes per sample while the integer type
% uses 2 bytes.
%
% The integer type allows for the most efficient and precise control of an
% AWG
%
% The real type allows for dynamic scaling of waveform data at run-time.
% This allows for math operations or changing bits of precision (i.e. AWG5k
% (14-bit) to/from AWG7k (8-bit), AWG7k 8-bit mode to/from AWG7k 10-bit
% mode) minimal degradation of sample data.
%}
end

function OutputAWG(runstate,ch1, ch2, ch3, ch4)

%%%%%% instrument communication %%%%%%
%%%%%% initialize the instrument %%%%%% 
awg = visa(visa_vendor,visa_address);
fopen(awg);

if runstate==1
    %%%%%% switch output on %%%%%% 
    fwrite(awg,['OUTP1 ' num2str(ch1)])
    fwrite(awg,['OUTP2 ' num2str(ch2)])
    fwrite(awg,['OUTP3 ' num2str(ch3)])
    fwrite(awg,['OUTP4 ' num2str(ch4)]) 
    fwrite(awg, 'AWGC:RUN')

else
    %%%%%% switch output off %%%%%% 
    fwrite(awg, 'AWGC:STOP')
    fwrite(awg,'OUTP1 0')
    fwrite(awg,'OUTP2 0')
    fwrite(awg,'OUTP3 0')
    fwrite(awg,'OUTP4 0') 
end

fprintf(awg, '%s\n','AWGCONTROL:RSTATE?');
run=fscanf(awg,'%s');

if run==2
    'Running'
elseif run==1
    'Waiting for Trigger'
else
    'Stopped'
end

fclose(awg);
%%%%%% delete all instrument objects %%%%%% 
delete(instrfindall);
clear awg;
end

function DC_Offsets(hObject, eventdata, handles)
global DC_off

DCI = 0.02;
DCQ = 0.02;
DC_off.I=DCI;
DC_off.Q=DCQ;
    disp(' ')
    disp(['--- I DC Offset =' num2str(DCI)])
    disp(['--- Q DC Offset =' num2str(DCQ)])
end

function Run_ADC_for_DataAcquisition(hObject, eventdata, handles)

    global Inputs 
    
    curr_it=1;
    while get(handles.stop,'Value') == 0
        
        ADC_init(Inputs.nSamples,Inputs.NPulse);
        if curr_it==1
            disp(['Data acquisition takes ' num2str(2*Inputs.seq_timeout*1e-9) ' seconds'])
        end
        pause(2*Inputs.seq_timeout*1e-9)
                
        [data read_time] = ADC_read(Inputs.nSamples,Inputs.NPulse,Inputs.num_samp);
        
        if curr_it==1
            disp(['ADC readout takes '  num2str(read_time) ' seconds'])
        end
        
        data(find(data>1))=0;
        data(find(data<0.02))=0;
        volts=zeros(1,Inputs.NPulse);
        for m=1:Inputs.NPulse
            i_l=(m-1)*Inputs.num_samp+1;
            i_u=m*Inputs.num_samp;
            rel_data=data(i_l:i_u);
            ind = find(rel_data, 1);
            rel_data_pts=rel_data(ind+Inputs.ign_pts:ind+Inputs.ign_pts+Inputs.read_pts-1);
            volts(m)=mean(rel_data_pts);
        end
        
        PlotResults(curr_it, volts, data);
        
        curr_it = curr_it + 1;
    end
end

function ADC_init(NRep,NPuls)

s = serial('COM5');
set(s,'BaudRate',57600);
set(s,'Parity','none');
set(s,'DataBits',8);
set(s,'StopBits',1);
set(s,'FlowControl','none');
fopen(s);

fprintf(s,'%s',['C ' num2str(NPuls) ';']);
fprintf(s,'%s',['G ' num2str(NRep) ';']);

fclose(s)
delete(s)
clear s

end

function [result read_time]=ADC_read(NRep,NPulse,num_samp)

tic

s = serial('COM5');
set(s,'BaudRate',57600);
set(s,'Parity','none');
set(s,'DataBits',8);
set(s,'StopBits',1);
set(s,'FlowControl','none');
fopen(s);

 
fprintf(s,'A118;&p;');
out = fscanf(s);
 
num_it_ac=str2num(out(end-9:end-2));
if num_it_ac~=NRep
    disp(['CAUTION, only ' num2str(num_it_ac) '/' num2str(NRep) ' samples were acquired!'])
end

result=zeros(1,num_samp*NPulse);
for k=1:NPulse
fprintf(s,['r ' num2str(k) ';']);
out = fscanf(s);
result_str=out(4:end-2);
volt_cell=strsplit(result_str,',');
volt_vec=str2double(volt_cell);
result((k-1)*num_samp+1:(k-1)*num_samp+num_samp)=volt_vec;

end
result=result/2^14;

fclose(s)
delete(s)
clear s

read_time=toc;

end