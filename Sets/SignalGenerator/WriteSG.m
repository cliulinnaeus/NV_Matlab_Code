function WriteSG(obj, on, freq, dBm)

if on~=1 && on~=0
    error('Wrong syntax!');
end

switch nargin
    case 2
        fprintf(obj,strcat('ENBR ',num2str(on)));
    otherwise
        if ~on
            fprintf(obj,'ENBR 0');
            return
        else
            if or(freq<950000,freq>4000000000) % hardware limit of this output
                error('Microwave frequency is out of bounds');
            end
%             if dBm>-5
%                 error('Microwave amplitude is probably too large')
%             end
            fprintf(obj,strcat('FREQ ',num2str(freq)));
            fprintf(obj,strcat('AMPR ', num2str(dBm)));
            fprintf(obj,strcat('ENBR 1'));
        end        
end
