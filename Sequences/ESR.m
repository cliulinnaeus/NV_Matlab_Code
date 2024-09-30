function ESR
global gSG gmSEQ
gSG.bfixedPow=1;
gSG.bfixedFreq=0;
gSG.bMod='Sweep';
gSG.bModSrc='External';
gSG.sweepRate=4;
gmSEQ.bLiO=1;
gmSEQ.ctrN=1;

gmSEQ.ScaleT = 1e-9;
gmSEQ.ScaleStr = "GHz";

% dummy sequence for DrawSequence
gmSEQ.CHN(1).PBN=PBDictionary('GreenAOM');
gmSEQ.CHN(1).NRise=1;
gmSEQ.CHN(1).T=0;
gmSEQ.CHN(1).DT=1;

gmSEQ.CHN(2).PBN=PBDictionary('MWSwitch');
gmSEQ.CHN(2).NRise=1;
gmSEQ.CHN(2).T=0;
gmSEQ.CHN(2).DT=1;

ApplyNoDelays
