function ApplyDelays
global gmSEQ 
green_aom_delay = 640; % 520 nm AOM
orange_aom_delay = 1200;  % 594 nm AOM
red_aom_delay = 100; % 637 nm AOM

if strcmp(gmSEQ.meas,'APD')
    % detector_delay=-1100+610;
    detector_delay=10000;
else
    detector_delay=0;
end

if strcmp(gmSEQ.meas2,'PD')
    % detector_delay=-1100+610;
    photodiode_delay=10000;
end

AWG_Delay = 46; % 2GHz sampling rate
% AWG_Delay = 53/gSG.AWGClockRate+14; % Need further testing

% LaserAWG_Delay = 53/gSG2.LaserAWGClockRate+14; % for 0.1GHz , delay = [(53*(1/SamplingRate)) + 14] ns

MW2_Delay = 26;

for i=1:numel(gmSEQ.CHN)
    if gmSEQ.CHN(i).PBN==PBDictionary('GreenAOM')
        gmSEQ.CHN(i).Delays=ones(1,2)*green_aom_delay;
    elseif gmSEQ.CHN(i).PBN==PBDictionary('OrangeAOM')
        gmSEQ.CHN(i).Delays=ones(1,2)*orange_aom_delay;
    elseif gmSEQ.CHN(i).PBN==PBDictionary('RedAOM')
        gmSEQ.CHN(i).Delays=ones(1,2)*red_aom_delay;
    elseif gmSEQ.CHN(i).PBN==PBDictionary('ctr0')
        gmSEQ.CHN(i).Delays=ones(1,2)*detector_delay;
    elseif gmSEQ.CHN(i).PBN == PBDictionary('PD')
        gmSEQ.CHN(i).Delays = ones(1, 2) * photodiode_delay;
%     elseif gmSEQ.CHN(i).PBN == PBDictionary('AWGTrig2') 
%         gmSEQ.CHN(i).Delays = ones(1, 2) * AWG_Delay;
%     elseif gmSEQ.CHN(i).PBN == PBDictionary('AWGTrig3') 
%         gmSEQ.CHN(i).Delays = ones(1, 2) * (AWG_Delay+MW2_Delay);
%     elseif gmSEQ.CHN(i).PBN == PBDictionary('MWSwitch3') 
%         gmSEQ.CHN(i).Delays = ones(1, 2) * MW2_Delay;
    else
        gmSEQ.CHN(i).Delays=zeros(1,2);
    end
end



