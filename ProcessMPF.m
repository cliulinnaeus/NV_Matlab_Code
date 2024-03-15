function out=ProcessMPF(in,pm)

% IN is a 8x3 matrix. Column 1 is the positions of the resonances; column 2
% is the full width half maximums; column 3 is the area.

pos1=in(1:4,1);
pos2=in(8:-1:5,1);
fwhm=in(:,2);
area=in(:,3);
amp=(2/pi)*area./fwhm;

out=NaN(1,8);

if pm==-1
    [~,sortind]=sort(amp(1:4),'descend');
else
    [~,sortind]=sort(amp(8:-1:5),'descend');
end
for i = 1:4
    out(i*2-1)=pos1(sortind(i));
    out(i*2)=pos2(sortind(i));
end

clipboard('copy',out);