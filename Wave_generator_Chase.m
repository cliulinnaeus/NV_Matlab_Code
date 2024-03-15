function A = Wave_generator_Chase (Waveform, Sample_rate, Length)

% Sample_rate in GHz
% Length in ns

% Converts from human-readable waveform, to AWG-readable waveform

%Inputs to Wave_generator must be written in the form
% For Analog
%[t1,t2,freq1,phase1,amp1;...
% t3,t4,freq2,phase2,amp2;...
%...]
%
% For Digital
%[t1,t2,value1;...
%t3,t4,value2;...
%...]

% units in form
% t in ns
% Sample_rate in GHz
% Freq in GHz

% In Chase AWG, the vertical resolution is 2^12 = 4096
% 2048 = 0V
% The sum of Amplitude at each point must be < 1
% This program will automatically convert Amplitude to 2^12=4096 vertical resolution


i = 0;
Total = Length*Sample_rate; % Convert to program each points
% Totoal must be an integer number of 16
Total = ceil(Total/16)*16;

% result = 0;
A = zeros(1,Total,'single');
% A = [];
[dimx,dimy] = size(Waveform);  % dimy == 3 Digital waveform, dimy == 5 Analog wave
if (dimy == 5) 
    while (i < dimx)
        i = i+1;
        % How many points do we have
        if Waveform(i,5) > 1 
            error("Amplitude is out of bound.")
        end
        B = round(Waveform(i,1)*Sample_rate):(round(Waveform(i,2)*Sample_rate)-1);
        C = ceil(2047+...
            Waveform(i,5)*2047*sin(2 * pi * Waveform(i,3) / Sample_rate * B + Waveform(i,4)));
        if (i < dimx)
            Delay = ceil(2047*ones(1,round((Waveform(i+1,1)-Waveform(i,2))*Sample_rate)));
        elseif (i == dimx)
            Delay = ceil(2047*ones(1,Total-round(Waveform(i,2)*Sample_rate)));
        end
        StartPoint = 1+round(Waveform(i,1)*Sample_rate);
        EndPoint = StartPoint+length(C)+length(Delay)-1;
        
        A(StartPoint:EndPoint) = [C Delay];
    end
    
elseif (dimy == 6) % Gaussian pulse
    while (i < dimx)
        i = i+1;
        % How many points do we have
        B = round(Waveform(i,1)*Sample_rate):(round(Waveform(i,2)*Sample_rate)-1);
        Mid = (Waveform(i,1)+Waveform(i,2))*Sample_rate/2;
        Sigma = (Waveform(i,2)-Waveform(i,1))*Sample_rate/(2*Waveform(i,6));
        C = ceil(2047+2047*Waveform(i,5)*exp(-(B-Mid).^2/(2*Sigma^2)).*...
            sin(2 * pi * Waveform(i,3) / Sample_rate * B + Waveform(i,4)));
        if (i < dimx)
            Delay = ceil(2047*ones(1,round((Waveform(i+1,1)-Waveform(i,2))*Sample_rate)));
        elseif (i == dimx)
            Delay = ceil(2047*ones(1,Total-round(Waveform(i,2)*Sample_rate)));
        end
        StartPoint = 1+round(Waveform(i,1)*Sample_rate);
        EndPoint = StartPoint+length(C)+length(Delay)-1;
        
        A(StartPoint:EndPoint) = [C Delay];
    end
    
     
elseif (dimy == 8) % Adding of 2 frequencies
    while (i < dimx)
        i = i+1;
        if Waveform(i,5) + Waveform(i,8) > 1 
            error("Amplitude is out of bound.")
        end
        B = round(Waveform(i,1)*Sample_rate):(round(Waveform(i,2)*Sample_rate)-1);
        C = ceil(2047+...
            2047*Waveform(i,5)*sin(2 * pi * Waveform(i,3) / Sample_rate * B + Waveform(i,4)) +  2047*Waveform(i,8)*sin(2 * pi * Waveform(i,6) / Sample_rate * B + Waveform(i,7)));
        if (i < dimx)
            Delay = ceil(2047*ones(1,round((Waveform(i+1,1)-Waveform(i,2))*Sample_rate)));
        elseif (i == dimx)
            Delay = ceil(2047*ones(1,Total-round(Waveform(i,2)*Sample_rate)));
        end
        StartPoint = 1+round(Waveform(i,1)*Sample_rate);
        EndPoint = StartPoint+length(C)+length(Delay)-1;
        
        A(StartPoint:EndPoint) = [C Delay];
    end

    
elseif (dimy == 3) % dimy == 3 Digital waveform, dimy == 5,6,8,9 Analog wave
    
    while (i <dimx)
        i = i+1;
        C = ceil(2047 ...
            + 2047 * Waveform(i,3) * ones(1,round(Waveform(i,2)*Sample_rate) - round(Waveform(i,1)*Sample_rate)));
        if (i < dimx)
            Delay = ceil(2047*ones(1,round((Waveform(i+1,1)-Waveform(i,2))*Sample_rate)));
            % Delay =
            % zeros(1,round((Waveform(i+1,1)-Waveform(i,2))*Sample_rate));
            % Seem to be Wrong
        elseif (i == dimx)
            Delay = ceil(2047*ones(1,Total-round(Waveform(i,2)*Sample_rate)));
        end
        
        A = [A, C, Delay];
    end
end

A = single(A);


end