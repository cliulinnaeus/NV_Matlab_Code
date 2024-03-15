function LoadPBESR

if ~libisloaded('mypbesr')
    disp('Matlab: Load spinapi.dll')
    warning('off')
    loadlibrary('spinapi64.dll',PortMap('spinapi'),...
        'addheader',PortMap('pulseblaster'),...
        'addheader',PortMap('dds'),'alias','mypbesr');
    warning('on')
end
