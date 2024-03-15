% RegisterFourierMellin

% This code is the result of my messing around with Matlab investigating 
% various image registration techniques.  I came across the excellent 
% (although perhaps a little messy and buggy) fm_gui_v2 from Adam Wilmer
% here:

% http://www.mathworks.com/matlabcentral/fileexchange/loadFile.do?objectId=3000&objectType=file

% Because my needs are essentially the algorithm itself in a neat and tidy
% format to enable an easier conversion to C++, I've extracted what I think
% is the essence of the Fourier Mellin method into this file.  Obviously
% I haven't included a GUI.  In order to test it, you need to set the first
% two statements to load in 2 image files of the same size, in 8 bit grayscale.
% I took lena and then used Gimp to rotate/shift/crop at various angles.
% It isn't sub-pixel accurate, although I'm aware of methods to achieve
% this by extracting the peaks around the peak of the phase correlation and
% finding the maxima (least squares perhaps).  

% The methods towards the end of the program are cribbed directly from
% Adam's version.  I'm new to Matlab (been playing with it for less than
% a fortnight), so I wasn't able to get my head around his log polar transform
% or the final "blending" of the two images together.

% I'd like to thank Adam for publishing his version.  Without it I'd never
% have known I had to take the log polar transform of the magnitude of the
% FFT, rather than the log polar transform of the original image!

function RegisterFourierMellin()

    % The procedure is as follows (note this does not compute scale)

    % (1)   Read in I1 - the image to register against
    % (2)   Read in I2 - the image to register
    % (3)   Take the FFT of I1, shifting it to center on zero frequency
    % (4)   Take the FFT of I2, shifting it to center on zero frequency
    % (5)   Convolve the magnitude of (3) with a high pass filter
    % (6)   Convolve the magnitude of (4) with a high pass filter
    % (7)   Transform (5) into log polar space
    % (8)   Transform (6) into log polar space
    % (9)   Take the FFT of (7)
    % (10)  Take the FFT of (8)
    % (11)  Compute phase correlation of (9) and (10)
    % (12)  Find the location (x,y) in (11) of the peak of the phase correlation
    % (13)  Compute angle (360 / Image Y Size) * y from (12)
    % (14)  Rotate the image from (2) by - angle from (13)
    % (15)  Rotate the image from (2) by - angle + 180 from (13)
    % (16)  Take the FFT of (14)
    % (17)  Take the FFT of (15)
    % (18)  Compute phase correlation of (3) and (16)
    % (19)  Compute phase correlation of (3) and (17)
    % (20)  Find the location (x,y) in (18) of the peak of the phase correlation
    % (21)  Find the location (x,y) in (19) of the peak of the phase correlation
    % (22)  If phase peak in (20) > phase peak in (21), (y,x) from (20) is the translation
    % (23a) Else (y,x) from (21) is the translation and also:
    % (23b) If the angle from (13) < 180, add 180 to it, else subtract 180 from it.
    % (24)  Tada!

    % Requires (ouch):

    % 6 x FFT
    % 4 x FFT Shift
    % 3 x IFFT
    % 2 x Log Polar
    % 3 x Phase Correlations
    % 2 x High Pass Filter
    % 2 x Image Rotation

    % ---------------------------------------------------------------------
   
    
    
    % Load first image (I1)
    I1=rgb2gray(imread('BC1.jpg'));
    I2=rgb2gray(imread('BS2.jpg'));
    [I1,I2] = imPad(I1,I2);
%     I1 = imread('Im1.bmp');
% 
%     
%     
% 
%     % Load second image (I2)
% 
%     I2 = imread('Im2.bmp');

    
    
    % ---------------------------------------------------------------------
   
    
    
    
    % Convert both to FFT, centering on zero frequency component
    
    SizeX = size(I1, 1);
    SizeY = size(I1, 2);
    
    FA = fftshift(fft2(I1)); %fft2 is 2D FT. fftshift shifts zero-frequency component of FT to center of spectrum for ease of viewing
    FB = fftshift(fft2(I2));
    
    % Output (FA, FB)
    
    
    
    
    % ---------------------------------------------------------------------
   
    
    
    
    % Convolve the magnitude of the FFT with a high pass filter)
    
    IA = hipass_filter(size(I1, 1),size(I1,2)).*abs(FA);  
    IB = hipass_filter(size(I2, 1),size(I2,2)).*abs(FB);  
        
    
    
        
    % Transform the high passed FFT phase to Log Polar space
    
    L1 = transformImage(IA, SizeX, SizeY, SizeX, SizeY, 'nearest', size(IA) / 2, 'valid');
    L2 = transformImage(IB, SizeX, SizeY, SizeX, SizeY, 'nearest', size(IB) / 2, 'valid');
        
    
        
    
    % Convert log polar magnitude spectrum to FFT
    
    THETA_F1 = fft2(L1);
    THETA_F2 = fft2(L2);
    
    
    
    
    % Compute cross power spectrum of F1 and F2
    
    a1 = angle(THETA_F1);
    a2 = angle(THETA_F2);

    THETA_CROSS = exp(i * (a1 - a2));
    THETA_PHASE = real(ifft2(THETA_CROSS));

    
           
    % Find the peak of the phase correlation

    THETA_SORTED = sort(THETA_PHASE(:));  % TODO speed-up, we surely don't need to sort
    
    SI = length(THETA_SORTED):-1:(length(THETA_SORTED));

    [THETA_X, THETA_Y] = find(THETA_PHASE == THETA_SORTED(SI));
    
    
    
    % Compute angle of rotation
    
    DPP = 360 / size(THETA_PHASE, 2);

    Theta = DPP * (THETA_Y - 1);
    
    % Output (Theta)
    
    
    
    
    
    % ---------------------------------------------------------------------
   
    
        
    
    % Rotate image back by theta and theta + 180
    
    R1 = imrotate(I2, -Theta, 'nearest', 'crop');  
    R2 = imrotate(I2,-(Theta + 180), 'nearest', 'crop');
    
      % Output (R1, R2)
    
    
	% ---------------------------------------------------------------------
   
     
    
    
    % Take FFT of R1
     
    R1_F2 = fftshift(fft2(R1));
     
     
     
    % Compute cross power spectrum of R1_F2 and F2
    
    a1 = angle(FA);
    a2 = angle(R1_F2);

    R1_F2_CROSS = exp(i * (a1 - a2));
    R1_F2_PHASE = real(ifft2(R1_F2_CROSS));

    % Output (R1_F2_PHASE)
     
     
    
    
    % ---------------------------------------------------------------------
   
     
    
    % Take FFT of R2
     
    R2_F2 = fftshift(fft2(R2));
     
     
     
    % Compute cross power spectrum of R2_F2 and F2
    
    a1 = angle(FA);
    a2 = angle(R2_F2);

    R2_F2_CROSS = exp(i * (a1 - a2));
    R2_F2_PHASE = real(ifft2(R2_F2_CROSS));

    % Output (R2_F2_PHASE)
    
  
    
    % ---------------------------------------------------------------------
   
    
    
    
    % Decide whether to flip 180 or -180 depending on which was the closest

    MAX_R1_F2 = max(max(R1_F2_PHASE));
    MAX_R2_F2 = max(max(R2_F2_PHASE));
    
    if (MAX_R1_F2 > MAX_R2_F2)
        
        [y, x] = find(R1_F2_PHASE == max(max(R1_F2_PHASE)));
        
        R = R1;
        
    else
        
        [y, x] = find(R2_F2_PHASE == max(max(R2_F2_PHASE)));
        
        if (Theta < 180)
            Theta = Theta + 180;
        else
            Theta = Theta - 180;
        end
        
        R = R2;
    end
    
    % Output (R, x, y)
    

    
    %%%Edit Thomas Mittiga 10/28/2016
    FB = fftshift(fft2(R));
    IB = hipass_filter(size(I2, 1),size(I2,2)).*abs(FB);  
    L2 = transformImage(IB, SizeX, SizeY, SizeX, SizeY, 'nearest', size(IB) / 2, 'valid');
    %%%End Edit  
    
    % ---------------------------------------------------------------------
   
    
    
    
    % Ensure correct translation by taking from correct edge
    
    Tx = x - 1;
    Ty = y - 1;
    
    if (x > (size(I1, 1) / 2))
        Tx = Tx - size(I1, 2);
    end
    
    if (y > (size(I1, 2) / 2))
        Ty = Ty - size(I1, 1);
    end
       
    % Output (Sx, Sy)
    
        

    
       
    % ---------------------------------------------------------------------   
    % FOLLOWING CODE TAKEN DIRECTLY FROM fm_gui_v2
    
    % Combine original and registered images
    
    input2_rectified = R; move_ht = Ty; move_wd = Tx;

    total_height = max(size(I1,1),(abs(move_ht)+size(input2_rectified,1)));
    total_width =  max(size(I1,2),(abs(move_wd)+size(input2_rectified,2)));
    combImage = zeros(total_height,total_width); registered1 = zeros(total_height,total_width); registered2 = zeros(total_height,total_width);

    % if move_ht and move_wd are both POSITIVE
    if((move_ht>=0)&&(move_wd>=0))
        registered1(1:size(I1,1),1:size(I1,2)) = I1;
        registered2((1+move_ht):(move_ht+size(input2_rectified,1)),(1+move_wd):(move_wd+size(input2_rectified,2))) = input2_rectified; 
    elseif ((move_ht<0)&&(move_wd<0))   % if translations are both NEGATIVE
        registered2(1:size(input2_rectified,1),1:size(input2_rectified,2)) = input2_rectified;
        registered1((1+abs(move_ht)):(abs(move_ht)+size(I1,1)),(1+abs(move_wd)):(abs(move_wd)+size(I1,2))) = I1;
    elseif ((move_ht>=0)&&(move_wd<0))
        registered2((move_ht+1):(move_ht+size(input2_rectified,1)),1:size(input2_rectified,2)) = input2_rectified;
        registered1(1:size(I1,1),(abs(move_wd)+1):(abs(move_wd)+size(I1,2))) = I1;
    elseif ((move_ht<0)&&(move_wd>=0))
        registered1((abs(move_ht)+1):(abs(move_ht)+size(I1,1)),1:size(I1,2)) = I1;
        registered2(1:size(input2_rectified,1),(move_wd+1):(move_wd+size(input2_rectified,2))) = input2_rectified;    
    end

    if sum(sum(registered1==0)) > sum(sum(registered2==0))   % find the image with the greater number of zeros - we shall plant that one and then bleed in the other for the combined image
        plant = registered1;    bleed = registered2;
    else
        plant = registered2;    bleed = registered1;
    end

    combImage = plant;
    for p=1:total_height
        for q=1:total_width
            if (combImage(p,q)==0)
                combImage(p,q) = bleed(p,q);
            end
        end
    end
        
    
    
    
    % Show final image
    
    imshow(combImage, [0 255]);

    
    
    
% ---------------------------------------------------------------------
% Performs Log Polar Transform

function [r,g,b] = transformImage(A, Ar, Ac, Nrho, Ntheta, Method, Center, Shape)

% Inputs:   A       the input image
%           Nrho    the desired number of rows of transformed image
%           Ntheta  the desired number of columns of transformed image
%           Method  interpolation method (nearest,bilinear,bicubic)
%           Center  origin of input image
%           Shape   output size (full,valid)
%           Class   storage class of A

global rho;

theta = linspace(0,2*pi,Ntheta+1); theta(end) = [];

switch Shape
case 'full'
    corners = [1 1;Ar 1;Ar Ac;1 Ac];
    d = max(sqrt(sum((repmat(Center(:)',4,1)-corners).^2,2)));
case 'valid'
    d = min([Ac-Center(1) Center(1)-1 Ar-Center(2) Center(2)-1]);
end
minScale = 1;
rho = logspace(log10(minScale),log10(d),Nrho)';  % default 'base 10' logspace - play with d to change the scale of the log axis

% convert polar coordinates to cartesian coordinates and center
xx = rho*cos(theta) + Center(1);
yy = rho*sin(theta) + Center(2);

if nargout==3
  if strcmp(Method,'nearest'), % Nearest neighbor interpolation
    r=interp2(A(:,:,1),xx,yy,'nearest');
    g=interp2(A(:,:,2),xx,yy,'nearest');
    b=interp2(A(:,:,3),xx,yy,'nearest');
  elseif strcmp(Method,'bilinear'), % Linear interpolation
    r=interp2(A(:,:,1),xx,yy,'linear');
    g=interp2(A(:,:,2),xx,yy,'linear');
    b=interp2(A(:,:,3),xx,yy,'linear');
  elseif strcmp(Method,'bicubic'), % Cubic interpolation
    r=interp2(A(:,:,1),xx,yy,'cubic');
    g=interp2(A(:,:,2),xx,yy,'cubic');
    b=interp2(A(:,:,3),xx,yy,'cubic');
  else
    error(['Unknown interpolation method: ',method]);
  end
  % any pixels outside , pad with black
  mask= (xx>Ac) | (xx<1) | (yy>Ar) | (yy<1);
  r(mask)=0;
  g(mask)=0;
  b(mask)=0;
else
  if strcmp(Method,'nearest'), % Nearest neighbor interpolation
    r=interp2(A,xx,yy,'nearest');
  elseif strcmp(Method,'bilinear'), % Linear interpolation
    r=interp2(A,xx,yy,'linear');
  elseif strcmp(Method,'bicubic'), % Cubic interpolation
    r=interp2(A,xx,yy,'cubic');
  else
    error(['Unknown interpolation method: ',method]);
  end
  % any pixels outside warp, pad with black
  mask= (xx>Ac) | (xx<1) | (yy>Ar) | (yy<1);
  r(mask)=0;
end  

% ---------------------------------------------------------------------
% Returns high-pass filter

function H = hipass_filter(ht,wd)
% hi-pass filter function
% ...designed for use with Fourier-Mellin stuff
res_ht = 1 / (ht-1);
res_wd = 1 / (wd-1);

eta = cos(pi*(-0.5:res_ht:0.5));
neta = cos(pi*(-0.5:res_wd:0.5));
X = eta'*neta;

H=(1.0-X).*(2.0-X);

% ---------------------------------------------------------------------
% Pads image with black pixels
function [Imd1,Imd2] = imPad(Im1,Im2)
% Pads the smaller image with black pixels to make it the same size as the
% larger

Imd1=Im1;
Imd2=Im2;

sz1=size(Imd1);
sz2=size(Imd2);

if sz1(1)>sz2(1)
    Imd2(end+1:end+sz1(1)-sz2(1),:)=0;
elseif sz2(1)>sz1(1)
    Imd1(end+1:end+sz2(1)-sz1(1),:)=0;
end

if sz1(2)>sz2(2)
    Imd2(:,end+1:end+sz1(2)-sz2(2))=0;
elseif sz2(1)>sz1(1)
    Imd1(:,end+1:end+sz2(2)-sz1(2))=0;
end