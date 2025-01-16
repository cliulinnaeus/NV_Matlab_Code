function XY8_N_tomo1
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


pre_init_wait = 10000;
init_dur = gmSEQ.readout;
readout_dur = gmSEQ.CtrGateDur;
post_init_wait = 30000; %wait time after init
post_seqMW_wait = 3000; %wait time between the last pulse and the readout
pi_half = gmSEQ.halfpi;
pi_half_diff = pi_half+2;
pi = gmSEQ.pi;
tau = gmSEQ.interval/2; %2tau is interpulse spacing
XY8_dur = 16*tau+8*pi;
q = 30; %rise time for the iq signal

T_green_1_start = pre_init_wait;
T_green_2_start = T_green_1_start + init_dur + post_init_wait + pi_half*2 + XY8_dur*m + post_seqMW_wait;
T_green_3_start = T_green_2_start + init_dur + pre_init_wait;
T_green_4_start = T_green_3_start + init_dur + post_init_wait + pi_half+pi_half_diff + XY8_dur*n + post_seqMW_wait;

MW_XY8_DT = [pi,pi,pi,pi,pi,pi,pi,pi];

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
gmSEQ.CHN(3).NRise=(m+n)*8+3;

tau7 = repmat(2*tau,1,7);
tau8 = repmat(2*tau,1,8);
%first half of the differential measurement 
MW_m_start = T_green_1_start+init_dur+post_init_wait;
if m == 0
    m_MW_T = [MW_m_start,2*tau];
else
    m_MW_T = [MW_m_start,tau,tau7, repmat(tau8,1,m-1),tau];
end
m_MW_DT = [pi_half,repmat(MW_XY8_DT,1,m),pi];
%second half of the differential measurement 
MW_n_start = post_seqMW_wait+pre_init_wait+init_dur*2+post_init_wait;
if n ==0
    n_MW_T = [MW_n_start,2*tau];
else
    n_MW_T = [MW_n_start,tau,tau7, repmat(tau8,1,n-1),tau];
end
n_MW_DT = [pi_half,repmat(MW_XY8_DT,1,n)];

T=[m_MW_T,n_MW_T]; 
T(end) = [];
DT=[m_MW_DT,n_MW_DT];
ConstructSeq(T,DT)


gmSEQ.CHN(4).PBN=PBDictionary('+X');
gmSEQ.CHN(4).NRise=(m+n)*4+3;
X_iq_rep1 = [4*tau+pi,6*tau+2*pi,4*tau+pi];
X_iq_rep2 = [2*tau, 4*tau+pi,6*tau+2*pi,4*tau+pi];
%first half of the differential measurement 
X_iq_m_start = MW_m_start+q; %this is the first iq start, note another 2*q will be substructed
if m == 0
    m_X_iq_T = [X_iq_m_start,2*tau]-2*q;
else
    m_X_iq_T = [X_iq_m_start,tau,X_iq_rep1, repmat(X_iq_rep2,1,m-1),tau]-2*q;
end
m_X_iq_DT = [pi_half,repmat(pi,1,m*4),pi]+2*q;
%second half of the differential measurement
X_iq_n_start = MW_n_start;
if n == 0
    n_X_iq_T = [X_iq_n_start]-2*q;
else
    n_X_iq_T = [X_iq_n_start,tau,X_iq_rep1, repmat(X_iq_rep2,1,n-1)]-2*q;
end
n_X_iq_DT = [pi_half,repmat(pi,1,n*4)]+2*q;

T=[m_X_iq_T,n_X_iq_T]; 
DT=[m_X_iq_DT,n_X_iq_DT];    
ConstructSeq(T,DT)


%added to handle n/m=0 case
my = m;
ny = n;
if m == 0
    my = 1;
end
if n==0
    ny = 1;
end

gmSEQ.CHN(5).PBN=PBDictionary('+Y');
gmSEQ.CHN(5).NRise=(my+ny)*4;
Y_iq_rep1 = [4*tau+pi,2*tau,4*tau+pi];
Y_iq_rep2 = [6*tau+2*pi,4*tau+pi,2*tau,4*tau+pi];
%first half of the differential measurement 
Y_iq_m_start = MW_m_start+pi_half+tau+pi+2*tau+q; %this is the first iq start, note another 2*q will be substructed
if m == 0
    m_Y_iq_T = [20,20,20,20];%dummy, won't affect anything
    m_Y_iq_DT = [20,20,20,20];%dummy, won't affect anything
else
    m_Y_iq_T = [Y_iq_m_start,Y_iq_rep1, repmat(Y_iq_rep2,1,m-1)]-2*q;
    m_Y_iq_DT = [repmat(pi,1,m*4)]+2*q;
end

%second half of the differential measurement 
Y_iq_n_start = MW_n_start+pi_half+pi+2*pi+6*tau;
if n ==0 
    n_Y_iq_T = [20,20,20,20];%dummy, won't affect anything
    n_Y_iq_DT = [20,20,20,20];%dummy, won't affect anything
else
    n_Y_iq_T = [Y_iq_n_start,Y_iq_rep1, repmat(Y_iq_rep2,1,n-1)]-2*q;
    n_Y_iq_DT = [repmat(pi,1,n*4)]+2*q;
end

T=[m_Y_iq_T,n_Y_iq_T]; 
DT=[m_Y_iq_DT,n_Y_iq_DT];    
ConstructSeq(T,DT)

gmSEQ.CHN(6).PBN=PBDictionary('-X');
gmSEQ.CHN(6).NRise=1;
T=[T_green_4_start-post_seqMW_wait-pi_half_diff-q]; 
DT=[pi+2*q];    
ConstructSeq(T,DT)

gmSEQ.CHN(7).PBN=PBDictionary('dummy1');
gmSEQ.CHN(7).NRise=2;
T=[0,T_green_4_start]; 
DT=[20,20];    
ConstructSeq(T,DT)

ApplyDelays();

