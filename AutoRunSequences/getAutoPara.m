function seq = getAutoPara()

%seq1
seq{1}.name = 'f_DEER_XY8';
seq{1}.interval = '32';
seq{1}.FROM1 = '0';
seq{1}.TO1 = '5';
seq{1}.SweepNPoints= '6';

seq{numel(seq)+1}.name = 'f_DEER_XY8';
seq{numel(seq)}.interval = '28';
seq{numel(seq)}.FROM1 = '0';
seq{numel(seq)}.TO1 = '6';
seq{numel(seq)}.SweepNPoints= '7';

seq{numel(seq)+1}.name = 'f_DEER_XY8';
seq{numel(seq)}.interval = '24';
seq{numel(seq)}.FROM1 = '0';
seq{numel(seq)}.TO1 = '7';
seq{numel(seq)}.SweepNPoints= '8';

seq{numel(seq)+1}.name = 'f_DEER_XY8';
seq{numel(seq)}.interval = '20';
seq{numel(seq)}.FROM1 = '0';
seq{numel(seq)}.TO1 = '8';
seq{numel(seq)}.SweepNPoints= '9';

seq{numel(seq)+1}.name = 'f_DEER_XY8';
seq{numel(seq)}.interval = '16';
seq{numel(seq)}.FROM1 = '0';
seq{numel(seq)}.TO1 = '9';
seq{numel(seq)}.SweepNPoints= '10';

seq{numel(seq)+1}.name = 'f_DEER_XY8';
seq{numel(seq)}.interval = '12';
seq{numel(seq)}.FROM1 = '0';
seq{numel(seq)}.TO1 = '10';
seq{numel(seq)}.SweepNPoints= '11';


end

