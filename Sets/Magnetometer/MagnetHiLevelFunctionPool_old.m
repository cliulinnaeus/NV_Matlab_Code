function varargout=MagnetHiLevelFunctionPool(varargin)

switch varargin{1}
    case 'Init'
        Init(varargin{2});
    case 'CalculateCurrent'
        varargout{1}=CalculateCurrent(varargin{2});
    case 'PlotInit'
        [varargout{1}]=PlotInit(varargin{2});
    case 'CalculateB'
        varargout{1}=CalculateB(varargin{2});
    case 'PlotMag'
         varargout{1}=PlotMag(varargin{2:(nargin)});
    case 'PresetAxis'
        [varargout{1},varargout{2}]=PresetAxis(varargin{2});
    case 'RotateArb'
        [varargout{1},varargout{2}]=RotateArb(varargin{2:6});
    otherwise
        disp('No matches found in Magnet Function Pool!')
end

function Init(app)
global gMag
PlotInit(app);
% % Populate the dropdowns
vals{1}='111';
vals{2}='1-1-1';
vals{3}='-1-11';
vals{4}='-11-1';
% color{1}=[1 1 0];
% color{2}=[1 0 1];
% color{3}=[0 1 1];
% color{4}=[0 1 0];
set(app.AxisDropDown,'String',vals);
% set(h,'Interpreter','latex','fontsize',12)
gMag.B=[1 0 0];

function Bnew=Antipodal(B)
Bnew=B;
Bnew(1)=-Bnew(1);

function B=CalculateB(i)
global gMag
a_mn=gMag.a_mn;
Bx=a_mn(1,1)*i(1)+a_mn(2,1)*i(2)+a_mn(3,1)*i(3);
By=a_mn(1,2)*i(1)+a_mn(2,2)*i(2)+a_mn(3,2)*i(3);
Bz=a_mn(1,3)*i(1)+a_mn(2,3)*i(2)+a_mn(3,3)*i(3);
B0=sqrt(Bx^2+By^2+Bz^2);
theta=acos(Bz/B0);
phi=atan(By/Bx);
B=[B0 theta phi];

function i = CalculateCurrent(B)
global gMag
a_mn=gMag.a_mn;

eqns=sym('x_%d',[1 3]);
i=sym('i_%d',[1 3]);
eqns(1)= a_mn(1,1)*i(1)+a_mn(2,1)*i(2)+a_mn(3,1)*i(3)==B(1)*sin(B(2))*cos(B(3));
eqns(2)= a_mn(1,2)*i(1)+a_mn(2,2)*i(2)+a_mn(3,2)*i(3)==B(1)*sin(B(2))*sin(B(3));
eqns(3)= a_mn(1,3)*i(1)+a_mn(2,3)*i(2)+a_mn(3,3)*i(3)==B(1)*cos(B(2));

[A,B] = equationsToMatrix(eqns, i);
i =double(linsolve(A,B));

function [theta, phi] = PresetAxis(what)
switch what
    case '111'
        theta=54.7356/180*pi;
        phi=45/180*pi;
    case '-11-1'
        theta=125.2644/180*pi;
        phi=135/180*pi;
    case '-1-11'
        theta=54.7356/180*pi;
        phi=225/180*pi;

    case '1-1-1'
        theta=125.2644/180*pi;
        phi=315/180*pi;
end

function [hAtom] = PlotInit(axes)
% Four crystallographic axes of diamond
theta=zeros(1,4); phi=zeros(1,4);
theta(1)=54.7356/180*pi;
phi(1)=45/180*pi;
theta(3)=125.2644/180*pi;
phi(3)=135/180*pi;
theta(2)=54.7356/180*pi;
phi(2)=225/180*pi;
theta(4)=125.2644/180*pi;
phi(4)=315/180*pi;
color{1}=[1 1 0];
color{2}=[1 0 1];
color{3}=[0 1 1];
color{4}=[0 1 0];
x0=sin(theta).*cos(phi); y0=sin(theta).*sin(phi); z0=cos(theta);

c=1/10; %scale the size of the spheres
[x,y,z] = sphere; 
hAtom(1)=surf(axes,c*x,c*y,c*z);
hold(axes,'on')
set(hAtom(1),'FaceColor',[0 0 0], ...
'FaceAlpha',1,'FaceLighting','gouraud','EdgeColor','none')


for j=1:length(x0)
    % Plot the bonds
    hBond(j)=plot3t([0 x0(j)],[0 y0(j)], [0 z0(j)],.02, 'k',axes); 
    hold(axes, 'on')
    % Shade the line
    set(hBond(j), 'FaceLighting','phong','SpecularColorReflectance', 0, 'SpecularExponent', 50, 'DiffuseStrength', 1);

    % Plot the atoms
    hAtom(j)=surf(axes,c*x+x0(j),c*y+y0(j),c*z+z0(j),'DisplayName',['test']);
    hold(axes, 'on')
    set(hAtom(j),'FaceColor',color{j}, ...
    'FaceAlpha',1,'FaceLighting','gouraud','EdgeColor','none')
end

xlabel(axes,'X')
ylabel(axes,'Y')
zlabel(axes,'Z')
h=legend(axes,hAtom,{'111','$$\overline{1}\overline{1}1$$','$$\overline{1}1\overline{1}$$','$$1\overline{1}\overline{1}$$'});
set(h,'Interpreter','latex','fontsize',12)
axis(axes,[-1 1 -1 1 -1 1]);
view(axes,3);
daspect(axes,[1 1 1]);
% Set the material to shiny and enable light
material(axes, 'shiny'); camlight(axes);
rotate3d(axes,'on');

function hMag=PlotMag(varargin)
B=varargin{1};
axes=varargin{2};
hAtom=varargin{3};

if nargin>3
    hMag=varargin{4};
    delete(hMag);
end

% Plot the magnetic field direction
hMag=plot3t([0 sin(B(2))*cos(B(3))],...
    [0 sin(B(2))*sin(B(3))], [0 cos(B(2))],.02, 'r',axes); 
hold(axes, 'on')
set(hMag, 'FaceLighting','phong','SpecularColorReflectance', 0, 'SpecularExponent', 50, 'DiffuseStrength', 1);
h=legend(axes,[hAtom hMag],{'111','$$\overline{1}\overline{1}1$$','$$\overline{1}1\overline{1}$$','$$1\overline{1}\overline{1}$$', 'Magnet'});
set(h,'Interpreter','latex','fontsize',12)

function hiso=plot3t(varargin)
% PLOT3T Plots a (cylindrical) 3D line with a certain thickness.
%
%   h = plot3t(x,y,z,r,'color',n);
%
%   PLOT3T(x,y,z), where x, y and z are three vectors of the same length,
%   plots a line in 3-space through the points whose coordinates are the
%   elements of x, y and z. With a radius of one and face color blue.
%
%   x,y,z: The line coordinates. If the first line point equals the
%      last point, the line will be closed.
%
%   r: The radius of the line (0.5x the thickness). Can be defined
%       as a single value (default 1), or as vector for every line 
%       coordinate.
%
%   'color': The color string, 'r','g','b','c','m','y','k' or 'w'
%
%
%   n: The number of vertex coordinates used to define the circle/cylinder
%      around the line (default 12). Choosing 2 will give a flat 3D line,
%      3 a triangulair line, 4 a squared line.
%       
%   h: The handle output of the patch element displaying the line. Can be 
%      used to shade the 3D line, see doc Patch Properties
%
%   Example:
%      % Create a figure window
%       figure, hold on;
%      % x,y,z line coordinates
%       x=60*sind(0:20:360); y=60*cosd(0:20:360); z=60*cosd((0:20:360)*2); 
%      % plot the first line
%       h=plot3t(x,y,z,5);
%      % Shade the line
%       set(h, 'FaceLighting','phong','SpecularColorReflectance', 0, 'SpecularExponent', 50, 'DiffuseStrength', 1);
%      % Set figure rotation
%       view(3); axis equal;
%      % Set the material to shiny and enable light
%       material shiny; camlight;
%      % Plot triangular line 
%       h=plot3t(y*0.5,x*0.5,z*0.5,3,'r',3);
%       set(h,'EdgeColor', [0 0 0]);
%      % varying radius of line
%       r=[4 8 4 8 4 8 4 8 4 8 4 8 4 8 4 8 4 8 4];
%      % Plot a flat 3D line
%       plot3t(y*1.2,z*1.2,x*1.2,r,'c',2);
%
% This function is written by D.Kroon University of Twente (August 2008)

% Check Input Arguments
if(length(varargin)<3), error('Not enough input arguments'), end

% Process input : line coordinates
linex=varargin{1}; liney=varargin{2}; linez=varargin{3};
if(~(sum((size(linex)==size(liney))&(size(linex)==size(linez)))==2)),
    error('Input variables x,y,z are not equal in length or no vectors'), end
if(size(linex,1)>1), linex=linex'; end
if(size(liney,1)>1), liney=liney'; end
if(size(linez,1)>1), linez=linez'; end
line=[linex;liney;linez]';

% Process input : radius of plotted line
if(length(varargin)>3), 
    radius=varargin{4}; 
    if(length(radius)==1), radius=ones(size(linex))*radius; end
else
    radius=ones(size(linex));
end

% Process input : color string
if(length(varargin)>4), 
    switch(varargin{5})
        case {'r'}, icolor=[1 0 0];
        case {'g'}, icolor=[0 1 0];
        case {'b'}, icolor=[0 0 1];
        case {'c'}, icolor=[0 1 1];
        case {'m'}, icolor=[1 0 1];
        case {'y'}, icolor=[1 1 0];
        case {'k'}, icolor=[.5 .5 .5];
        case {'w'}, icolor=[1 1 1];
    otherwise
        error('Invalid color string');
    end
else
    icolor=[0 0 1];
end


vertex_num=12;

% Calculate vertex points of 2D circle
angles=0:(360/vertex_num):359.999;

% (smooth cylinder) Buffer distance between two line pieces.
bufdist=max(radius);
linel=sqrt((line(2:end,1)-line(1:end-1,1)).^2+(line(2:end,2)-line(1:end-1,2)).^2+(line(2:end,3)-line(1:end-1,3)).^2);
if((min(linel)/2.2)<bufdist), bufdist=min(linel)/2.2; end

% Check if the plotted line is closed
lclosed=line(1,1)==line(end,1)&&line(1,2)==line(end,2)&&line(1,3)==line(end,3);

% Calculate normal vectors on every line point
if(lclosed)
    normal=[line(2:end,:)-line(1:end-1,:);line(2,:)-line(1,:)];
else
    normal=[line(2:end,:)-line(1:end-1,:);line(end,:)-line(end-1,:)];
end
normal=normal./(sqrt(normal(:,1).^2+normal(:,2).^2+normal(:,3).^2)*ones(1,3));

% Create a list to store vertex points
FV.vertices=zeros(vertex_num*length(linex),3);

% In plane rotation of 2d circle coordinates
jm=0;

% Number of triangelized cylinder elements added to plot the 3D line
n_cylinders=0; 

% Calculate the 3D circle coordinates of the first circle/cylinder
[a,b]=getab(normal(1,:));
circm=normal_circle(angles,jm,a,b);

% If not a closed line, add a half sphere made by 5 cylinders add the line start.
if(~lclosed)
    for j=5:-0.5:1
        % Translate the circle on it's position on the line
        r=sqrt(1-(j/5)^2); 
        circmp=r*radius(1)*circm+ones(vertex_num,1)*(line(1,:)-(j/5)*bufdist*normal(1,:));
        % Create vertex list
        n_cylinders=n_cylinders+1;
        FV.vertices(((n_cylinders-1)*vertex_num+1):(n_cylinders*vertex_num),:)=[circmp(:,1) circmp(:,2) circmp(:,3)];
    end
end

% Make a 3 point circle for rotation alignment with the next circle
circmo=normal_circle([0 120 240],0,a,b);  

% Loop through all line pieces.
for i=1:length(linex)-1,
% Create main cylinder between two line points which consists of two connect
% circles.
  
    pnormal1=normal(i,:); pline1=line(i,:);
    
    % Calculate the 3D circle coordinates
    [a,b]=getab(pnormal1);
    circm=normal_circle(angles,jm,a,b);
    
    % Translate the circle on it's position on the line
    circmp=circm*radius(i)+ones(vertex_num,1)*(pline1+bufdist*pnormal1);

    % Create vertex list
    n_cylinders=n_cylinders+1;
    FV.vertices(((n_cylinders-1)*vertex_num+1):(n_cylinders*vertex_num),:)=[circmp(:,1) circmp(:,2) circmp(:,3)];
  
    pnormal2=normal(i+1,:); pline2=line(i+1,:);
       
    % Translate the circle on it's position on the line
    circmp=circm*radius(i+1)+ones(vertex_num,1)*(pline2-bufdist*pnormal1);

    % Create vertex list
    n_cylinders=n_cylinders+1;
    FV.vertices(((n_cylinders-1)*vertex_num+1):(n_cylinders*vertex_num),:)=[circmp(:,1) circmp(:,2) circmp(:,3)];

% Create in between circle to smoothly connect line pieces.

    pnormal12=pnormal1+pnormal2; pnormal12=pnormal12./sqrt(sum(pnormal12.^2));
    pline12=0.5858*pline2+0.4142*(0.5*((pline2+bufdist*pnormal2)+(pline2-bufdist*pnormal1)));  
  
    % Rotate circle coordinates in plane to align with the previous circle
    % by minimizing distance between the coordinates of two circles with 3 coordinates.
    [a,b]=getab(pnormal12);
    jm = fminsearch(@(j)minimize_rot([0 120 240],circmo,j,a,b),jm);              
    
    % Keep a 3 point circle for rotation alignment with the next circle
    [a,b]=getab(pnormal12);
    circmo=normal_circle([0 120 240],jm,a,b);   
    
    % Calculate the 3D circle coordinates
    circm=normal_circle(angles,jm,a,b);
    
    % Translate the circle on it's position on the line
    circmp=circm*radius(i+1)+ones(vertex_num,1)*(pline12);

    % Create vertex list
    n_cylinders=n_cylinders+1;
    FV.vertices(((n_cylinders-1)*vertex_num+1):(n_cylinders*vertex_num),:)=[circmp(:,1) circmp(:,2) circmp(:,3)];

    % Rotate circle coordinates in plane to align with the previous circle
    % by minimizing distance between the coordinates of two circles with 3 coordinates.
    [a,b]=getab(pnormal2);
    jm = fminsearch(@(j)minimize_rot([0 120 240],circmo,j,a,b),jm);              
    
    % Keep a 3 point circle for rotation alignment with the next circle
    circmo=normal_circle([0 120 240],jm,a,b);    
end

% If not a closed line, add a half sphere made by 5 cylinders add the
% line end. Otherwise add the starting circle to the line end.
if(~lclosed)
    for j=1:0.5:5
        % Translate the circle on it's position on the line
        r=sqrt(1-(j/5)^2);
        circmp=r*radius(i+1)*circm+ones(vertex_num,1)*(line(i+1,:)+(j/5)*bufdist*normal(i+1,:));
        % Create vertex list
        n_cylinders=n_cylinders+1;
        FV.vertices(((n_cylinders-1)*vertex_num+1):(n_cylinders*vertex_num),:)=[circmp(:,1) circmp(:,2) circmp(:,3)];
    end
else
    i=i+1;
    pnormal1=normal(i,:); pline1=line(i,:);
    
    % Calculate the 3D circle coordinates
    [a,b]=getab(pnormal1);
    circm=normal_circle(angles,jm,a,b);
    
    % Translate the circle on it's position on the line
    circmp=circm*radius(1)+ones(vertex_num,1)*(pline1+bufdist*pnormal1);

    % Create vertex list
    n_cylinders=n_cylinders+1;
    FV.vertices(((n_cylinders-1)*vertex_num+1):(n_cylinders*vertex_num),:)=[circmp(:,1) circmp(:,2) circmp(:,3)];   
end

% Faces of one meshed line-part (cylinder)
Fb=[[1:vertex_num (1:vertex_num)+1];[(1:vertex_num)+vertex_num (1:vertex_num)];[(1:vertex_num)+vertex_num+1 (1:vertex_num)+vertex_num+1]]'; 
Fb(vertex_num,3)=1+vertex_num; Fb(vertex_num*2,1)=1; Fb(vertex_num*2,3)=1+vertex_num;

% Create TRI face list
FV.faces=zeros(vertex_num*2*(n_cylinders-1),3);
for i=1:n_cylinders-1,
    FV.faces(((i-1)*vertex_num*2+1):((i)*vertex_num*2),1:3)=(Fb+(i-1)*vertex_num);
end

% Display the polygon patch
hiso=patch(varargin{6},FV,'Facecolor', icolor, 'EdgeColor', 'none');

function [err,circm]=minimize_rot(angles,circmo,angleoffset,a,b)
    % This function calculates a distance "error", between the same
    % coordinates in two circles on a line. 
    [circm]=normal_circle(angles,angleoffset,a,b);
    dist=(circm-circmo).^2;
    err=sum(dist(:));

function [a,b]=getab(normal)
    % A normal vector only defines two rotations not the in plane rotation.
    % Thus a (random) vector is needed which is not orthogonal with 
    % the normal vector.
    randomv=[0.57745 0.5774 0.57735]; 

    % This line is needed to prevent the case of normal vector orthogonal with
    % the random vector. But is now disabled for speed...
    % if(sum(abs(cross(randomv,normal)))<0.001), randomv=[0.58 0.5774 0.56]; end
    
    % Calculate 2D to 3D transform parameters
    a=normal-randomv/(randomv*normal'); a=a/sqrt(a*a');     
    b=cross(normal,a); b=b/sqrt(b*b');
    
function [X,a,b]=normal_circle(angles,angleoffset,a,b)
    % This function rotates a 2D circle in 3D to be orthogonal 
    % with a normal vector.

    % 2D circle coordinates.
    circle_cor=[cosd(angles+angleoffset);sind(angles+angleoffset)]';
    
    X = [circle_cor(:,1).*a(1) circle_cor(:,1).*a(2) circle_cor(:,1).*a(3)]+...
         [circle_cor(:,2).*b(1) circle_cor(:,2).*b(2) circle_cor(:,2).*b(3)]; 
     
function [thetanew, phinew]= RotateArb(thetaold,phiold,axistheta,axisphi,rot)
% This function rotates a unit vector, characterized by thetaold and
% phiold, about an arbitrary axis by angle rot. It is based on the notation
% presented at: http://paulbourke.net/geometry/rotate/.

U = [sin(axistheta)*cos(axisphi), sin(axistheta)*sin(axisphi), cos(axistheta)]; % unit vector along rotation axis
a=U(1); b=U(2); c=U(3);
d=sqrt(b^2+c^2);

Rx=[1,0,0;0,c/d,-b/d;0,b/d,c/d];
Ry=[d,0,-a;0,1,0;a,0,d];
Rz=[cos(rot),-sin(rot),0;sin(rot),cos(rot),0;0,0,1];

vectorotate=[sin(thetaold)*cos(phiold), sin(thetaold)*sin(phiold), cos(thetaold)];

vec=Rx'*Ry'*Rz*Ry*Rx*vectorotate';

x=vec(1); y=vec(2); z=vec(3);
thetanew=acos(z);
phinew=atan2(y,x);