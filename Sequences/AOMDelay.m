function AOMDelay
global gmSEQ gSG
gSG.bfixedPow=1;
gSG.bfixedFreq=1;
gSG.bMod='lol';
gSG.bModSrc='External';

[gmSEQ.ScaleT, gmSEQ.ScaleStr] = GetScale(gmSEQ.m);


if strcmp(gmSEQ.meas,'APD')
    gmSEQ.CtrGateDur = 1000;
end

gmSEQ.CHN(1).PBN=PBDictionary('ctr0');
gmSEQ.CHN(1).NRise=1;
gmSEQ.CHN(1).T=gmSEQ.CtrGateDur;
gmSEQ.CHN(1).DT=[gmSEQ.readout];

gmSEQ.CHN(2).PBN=PBDictionary('RedAOM');
gmSEQ.CHN(2).NRise=1;
gmSEQ.CHN(2).T=gmSEQ.CtrGateDur;
gmSEQ.CHN(2).DT=[gmSEQ.readout];


gmSEQ.CHN(3).PBN=PBDictionary('dummy1');
gmSEQ.CHN(3).NRise=2;
gmSEQ.CHN(3).T=[0 gmSEQ.CtrGateDur];
gmSEQ.CHN(3).DT=[12 12];

ApplyNoDelays;
