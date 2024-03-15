function param = loadNIcns(filename);

if nargin==0
    [filename,pathname] = uigetfile('nidaqcns.h','Please find nidaqcns.h');
    filename = [pathname filename];
end;
filename
% filename = 'D:\Applications\National Instruments\NI-DAQ\Include\nidaqcns.h';
fid = fopen(filename,'r');
fid

%Read in the file
nlines = 0;
L = {};     %The lines
while 1
    fline = fgetl(fid);
    
    if ~ischar(fline), break, end
    if strncmp(fline,'#define ND',10)
        nlines = nlines+1;
        L{nlines} = fline;
    end;
end;
fclose(fid);

%Now, define the variables.  Store them all in a structure

for ii=1:nlines
    %I catch all the longs.  enum's are skipped
    try
        [name,val] = strread(L{ii},'#define %s     %dL');
        param.(name{1}) = val;
    catch
    end;
    
end;

