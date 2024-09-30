function pbn = PBDictionary(type)
switch type
    case 'ctr0'
        pbn=0;
%     case 'AWGTrig2'
%         pbn=1;
%     case 'AWGTrig' 
%         pbn=0;
    case 'dummy1'
        pbn=8;
    case 'GreenAOM'    % Green AOM
        pbn=1;
    case 'RedAOM' 
        pbn=4;
    case 'MWSwitch'
        pbn=2;
    case '+X'
        pbn=5;
    case '-X'
        pbn=6;        
    case '+Y'
        pbn=7;
    case '-Y'
        pbn=15;
    case 'PD'
        pbn=14;
    case 'OrangeAOM'
        pbn=3;
    case 'TimeTaggerTrig'
        pbn=9;        
end