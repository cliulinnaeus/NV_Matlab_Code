function XY8_N_new
global gmSEQ gSG
gSG.bfixedPow=1;
gSG.bfixedFreq=1;
gSG.bMod='IQ';
gSG.bModSrc='External';

[gmSEQ.ScaleT, gmSEQ.ScaleStr] = GetScale(gmSEQ.To);

arr = gmSEQ.SweepParam;
max_index = length(arr);
m = gmSEQ.m;
index_m = find(arr ==m); %find the index of the current t
index_n = 1 + max_index - index_m; %find the index of the differential t
n = arr(index_n); %find the differential t that fixed the duty cycle
n=m; %not doing  fixed duty cycle
% aaa = m;
% m = n;
% n = aaa;


init_dur = gmSEQ.readout;
readout_dur = gmSEQ.CtrGateDur;
post_init_wait = 5000; %wait time after init
post_seqMW_wait = 2000; %wait time between the last pulse and the readout
pre_init_wait = post_init_wait+post_seqMW_wait;
pi_half = gmSEQ.halfpi;
pi_half_diff = pi_half+2; %this is the differential pi/2, the 2ns is accounted for the pulse length error
pi = gmSEQ.pi;
tau = gmSEQ.interval/2; %2tau is interpulse spacing

singleXY8_dur = 16*tau+8*pi; %this time exclude the pi/2 time
T_m = singleXY8_dur*m + pi_half + pi_half; % total MW pulse length (1st half)
T_n = singleXY8_dur*n + pi_half + pi_half_diff; % total MW pulse length (2nd half)
q = 20; %rise time for the iq signal

T_green_1_start = pre_init_wait;
T_green_1_end = pre_init_wait + init_dur;
T_green_2_start = T_green_1_end + post_init_wait + T_m + post_seqMW_wait;
T_green_2_end = T_green_2_start + init_dur;
T_green_3_start = T_green_2_end + pre_init_wait;
T_green_3_end = T_green_3_start + init_dur;
T_green_4_start = T_green_3_end + post_init_wait + T_n + post_seqMW_wait;

if strcmp(gmSEQ.meas,'APD')
    gmSEQ.CtrGateDur = 1000;
end

gmSEQ.CHN(1).PBN=PBDictionary('ctr0');
gmSEQ.CHN(1).NRise=4;
gmSEQ.CHN(1).T=[T_green_1_start,T_green_2_start,T_green_3_start,T_green_4_start]; 
gmSEQ.CHN(1).DT=[readout_dur,readout_dur,readout_dur,readout_dur];    

gmSEQ.CHN(2).PBN=PBDictionary('GreenAOM');
gmSEQ.CHN(2).NRise=4;
gmSEQ.CHN(2).T=[T_green_1_start,T_green_2_start,T_green_3_start,T_green_4_start]; 
gmSEQ.CHN(2).DT=[init_dur,init_dur,init_dur,init_dur];    

gmSEQ.CHN(3).PBN=PBDictionary('MWSwitch');
gmSEQ.CHN(3).NRise=(m+n)*8+5;

%now add the first and last pi/2
[m_T, m_DT] = get_XY8_N_T_and_DT(m, pi, tau);
m_DT = [pi_half, m_DT, pi_half];

[n_T, n_DT] = get_XY8_N_T_and_DT(n, pi ,tau);
n_DT = [pi_half, n_DT, pi_half_diff];

T1 = T_green_1_end+post_init_wait;
T2 = post_seqMW_wait+init_dur*2 + pre_init_wait + post_init_wait;

%add additional pi to for dark reference
T=[post_init_wait, T1 - post_init_wait - pi, m_T, T2, n_T]; %add the T before the 1st pulse and the T between the two differential measurements
DT=[pi, m_DT,n_DT];
ConstructSeq(T,DT)
T_last_pi_hald_diff = sum(T) + sum(DT);

gmSEQ.CHN(4).PBN=PBDictionary('+X');
gmSEQ.CHN(4).NRise=(m+n)*4+4;
[m_X_iq_T, m_X_iq_DT] = get_X_iq_T_and_DT(m, pi, tau, q);
m_X_iq_DT = [pi_half + 2*q, m_X_iq_DT, pi_half + 2*q];

[n_X_iq_T, n_X_iq_DT] = get_X_iq_T_and_DT(n, pi, tau, q);
n_X_iq_T(end) = [];
n_X_iq_DT = [pi_half + 2*q, n_X_iq_DT];

T=[post_init_wait - q, T1 - post_init_wait - pi - 2*q,m_X_iq_T,T2-2*q,n_X_iq_T]; 
DT=[pi + 2*q, m_X_iq_DT,n_X_iq_DT];    
ConstructSeq(T,DT)


gmSEQ.CHN(5).PBN=PBDictionary('+Y');
gmSEQ.CHN(5).NRise=(m+n)*4;
[m_Y_iq_T, m_Y_iq_DT] = get_Y_iq_T_and_DT(m, pi, tau, q);
[n_Y_iq_T, n_Y_iq_DT] = get_Y_iq_T_and_DT(n, pi, tau, q);

T3 = pi_half + pi + 3*tau;
T=[T1 + T3 - q, m_Y_iq_T, T2 + 2*T3 - 2*q, n_Y_iq_T]; 
DT=[m_Y_iq_DT,n_Y_iq_DT];    
ConstructSeq(T,DT)
 
gmSEQ.CHN(6).PBN=PBDictionary('-X');
gmSEQ.CHN(6).NRise=1;
T = [T_last_pi_hald_diff - pi_half_diff - q];
DT=[pi_half_diff+2*q];    
ConstructSeq(T,DT)

gmSEQ.CHN(7).PBN=PBDictionary('dummy1');
gmSEQ.CHN(7).NRise=2;
T=[0,T_green_4_start]; 
DT=[20,20];    
ConstructSeq(T,DT)

    function [m_XY8_T, m_XY8_DT] = get_XY8_N_T_and_DT(m, pi, tau)
        single_XY8_DT = [pi,pi,pi,pi,pi,pi,pi,pi];
        single_XY8_T = [tau, 2*tau, 2*tau, 2*tau, 2*tau, 2*tau, 2*tau, 2*tau, tau];
        m_XY8_T = repmat(single_XY8_T,[1,m]); %this is not correct as between each XY8, there will be [..., tau, tau, ...], we want to convert that to [..., 2*tau, ...]
        m_XY8_DT = repmat(single_XY8_DT,[1,m]);
        if m > 1
            %remove all the [tau] that are incorrect
            index_tau_to_remove = [9*(1:(m-1)) 9*(1:(m-1))+1];
            m_XY8_T(index_tau_to_remove) = [];
            m_XY8_T(end) = [];
            A = m_XY8_T;
            B = [repmat([2*tau],[1,m-1]), tau];
            m_XY8_T = cat(2,A,B); %replace the last [tau] with the correct number of 2tau and tau like [..., 2*tau, 2*tau, tau]      
        end
    end

    function [T, DT] = get_X_iq_T_and_DT(m, pi, tau, q)
        A = tau-2*q; B = 4*tau+pi-2*q; C = 6*tau+2*pi-2*q; D = 2*tau-2*q;
        rep1 = [B,C,B,D];
        rep2 = [pi, pi, pi, pi] + 2*q;
        if m ==1
            T = [A, B, C, B, A];
            DT = rep2;
        else
            T = [A, repmat(rep1,[1,m])];
            T(end) = A;
            DT = repmat(rep2,[1, m]);
        end
    end

    function [T, DT] = get_Y_iq_T_and_DT(m, pi, tau, q)
        B = 2*tau-2*q; A = 4*tau+pi-2*q; C = 6*tau+2*pi-2*q; D = 2*tau-2*q;
        rep1 = [A, B, A, C];
        rep2 = [pi, pi, pi, pi] + 2*q;
        T = repmat(rep1,[1,m]);
        T(end) = [];
        DT = repmat(rep2,[1, m]);
    end

ApplyDelays();
end
