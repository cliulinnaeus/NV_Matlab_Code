function MagnetSolver
% The goal of this function is to generate the mapping from (electrical
% current) to (vector magnetic field). To be more precise, we generally
% write the magnetic field as B_n=\sum_{mn} a_{mn} i_{m} where n indexes
% the orthogonal directions \{x,y,z\} in some frame, m indexes the three
% coils in our 3D coil geometry, a defines the coefficient relating applied
% eiectric current to magnetic field, and i is the applied electric
% current. The goal of this function can therefore be cast as solving for
% a_{mn}. Note that, a priori, we do not assume that the three coil
% directions are orthogonal.
%
% The user inputs are three instances of the vector i_m, ideally in
% such a way that all four axes (eight lines) of NV centers are visible
% (roughly nondegenerate).
%---------------------------DEFINTIONS------------------------------------%
global gSolver gMag
gSolver.Sx = 1/sqrt(2)*[0 1 0;1 0 1;0 1 0];
gSolver.Sy = 1/(1i*sqrt(2))*[0 1 0;-1 0 1;0 -1 0];
gSolver.Sz = [1 0 0;0 0 0;0 0 -1];
gSolver.Delta = 2870.3;
gSolver.gamma_e = 2.8035;
gSolver.width=1; %linewidth for plotting
gSolver.contrast=0.05; %contrast for plotting

%---------------------------USER INPUT------------------------------------%

% the current you applied for three instances (amps). For stability of this
% algorithm, please ensure that the currents applied do not flip polarity;
% i.e., do not flip the signal and ground wires between instances.

i=[1.1932 2.4 3.1];
i=[i; 1.1932 2.4 2.5];
i=[i; 1.7 2.4 3.2];  
i=[i; 1.1932 2 2.5];

% Transition energies from your ODMR spectra (MHz). Each line must be in
% the order: ms=-1 (111), ms=+1 (111), ...
target(1,:)=[2923600000 3218330000 2981680000 3235900000 3088970000 3173460000 2862830000 3345060000];
target(2,:)=[2951530000 3188580000 2968130000 3239020000 3091960000 3163050000 2873580000 3331030000];
target(3,:)=[2920020000 3222240000 2966200000 3248540000 3058760000 3200170000 2878750000 3334640000];
target(4,:)=[2944370000 3181430000 2984160000 3212140000 3073380000 3163440000 2907460000 3294640000];
target=target/10^6;

%---------------------------ALGORITHM-------------------------------------%
% Given the three ODMR spectra, we need to determine the three
% corresponding magnetic fields that produce them. Our solution space
% corresponds to |B|, theta, and phi (different for each input spectrum), and four D parameters (same for each input spectrum). To narrow this space,
% we begin by solving the Hamiltonian for B up to linear order (plus some clever tricks at next order). This
% approximately linearizes the problem and provides an initial guess.
permutations=6;
iter=size(target,1); % minimum number of spectra needed to calibrate a_mn
%and D's = 4
Binit=zeros(iter,size(target,2)/2); % contains our linear guess encoded as Bz's along each NV axis
B=zeros(permutations,iter,3);
Dinit=Binit;
B0init=Binit; thetainit=Binit; phiinit=Binit; % same info as Binit encoded as [mag theta phi]
bestres=NaN([1 permutations]);
success=0;

for k=6:6%permutations
	% The nonlinear solver is extremely reliant on the initial guess. To
	% exhaust all possible guesses, we permute all three non-111 axes in every
	% possible configuration (six).
    targetNew=PermuteNon111(target,k);
	
    for j=1:iter
        % index 1 is spectrum number; index 2 is Bz along each NV axis for
        % Binit, coefficient of Sz^2 for Del (4 total)
        [Binit(j,:), Dinit(j,:)]=LinearProjection(targetNew(j,:)); 
		
        % index 1 is spectrum number; index 2 is solution for (4 choose 3)
        % NV axes, four possibilities        
		[B0init(j,:), thetainit(j,:), phiinit(j,:)]=LinearSolveB(Binit(j,:)); 
    end
    
    % vector of length four. This gives you an upper bound on the
    % coefficient of Sz^2.
	Dinit=min(Dinit); 
	disp(['Solving permutation ',num2str(k),' of ', num2str(permutations),'...']);
	for m=1:4
		for n=1:4
			for o=1:4
				for p=1:4
					Bguess(1,:)=[B0init(1,m) thetainit(1,m) phiinit(1,m)];
					Bguess(2,:)=[B0init(2,n) thetainit(2,n) phiinit(2,n)];
					Bguess(3,:)=[B0init(3,o) thetainit(3,o) phiinit(3,o)];
					Bguess(4,:)=[B0init(4,p) thetainit(4,p) phiinit(4,p)];
					[Bout(m,n,o,p,:),res(m,n,o,p)]=ExactBfield(targetNew,Bguess, Dinit);
				end
			end
		end
    end
    [bestres(k),I]=min(res(:));
    [I1,I2,I3,I4] = ind2sub(size(res),I);
    bestB(k,:)=squeeze(Bout(I1,I2,I3,I4,:));
end
%[bestbestres,I]=min(bestres);
%bestbestB=bestB(I,:)'; % row of length 16

origFormat = get(0, 'format');
format('shortEng');
disp(bestres);
set(0,'format', origFormat);


    chooserow=input('Please choose the permutation: ');

    bestbestB=bestB(chooserow,:)';
    targetNew=PermuteNon111(target,chooserow);
%    bestbestB(2)=bestbestB(2)+pi;
    bestbestB(11)=bestbestB(11)+pi;
    
    
    for q=1:4
        bestbestB((3*q)-1)=mod(bestbestB((3*q)-1),2*pi);
        bestbestB((3*q))=mod(bestbestB((3*q)),2*pi);
    end
    
    PlotResults(targetNew,bestbestB);

    figure
    [hAtom]=MagnetHiLevelFunctionPool('PlotInit',gca);
    colors={'r','b','w','k'};
    for j=1:iter
        spec=j*3-2;
        MagnetHiLevelFunctionPool('PlotMag',bestbestB(spec:spec+2),gca,hAtom,string(colors{j}));
    end



% Finally, we insert the three calculated magnetic fields into our linear
% system of equations to back out a_{mn}.

a_mn=structfun(@double,SolveA(i,bestbestB));
gMag.a_mn=reshape(a_mn,[3 3])';
gMag.D=bestbestB(13:16);

%----------------------------HELPER FUNCTIONS-----------------------------%

function [B,Del] = LinearProjection(energy)
% ENERGY is a vector of ODMR transition energies. The algorithm outputs
% the magnetic field projection along each NV axis that you provide.
global gSolver

B=(energy(2:2:end)-energy(1:2:end))/(2*gSolver.gamma_e);
Del=(energy(2:2:end)+energy(1:2:end))/2;

function [solB0, soltheta, solphi] = LinearSolveB(Binit)
% Assuming only leading order dependence on B, the four NV axes
% overdetermine the applied B field. Therefore, we produce solutions to any
% three axes chosen from the four axes.
syms B0 theta phi
eqns = [B0*abs(1/sqrt(3)*(sin(theta)*cos(phi)+sin(theta)*sin(phi)+cos(theta))) == Binit(1),... 
    B0*abs(1/sqrt(3)*(sin(theta)*cos(phi)-sin(theta)*sin(phi)+cos(theta))) == Binit(2),...
    B0*abs(1/sqrt(3)*(sin(theta)*cos(phi)+sin(theta)*sin(phi)-cos(theta))) == Binit(3),...
    B0*abs(1/sqrt(3)*(-sin(theta)*cos(phi)+sin(theta)*sin(phi)+cos(theta))) == Binit(4);];
vars = [B0 theta phi];
range=[0 200; 0 pi; 0 2*pi];
eqns3=combnk(eqns,3);

solB0=zeros(1,4);soltheta=zeros(1,4);solphi=zeros(1,4);
for j=1:4
    [solB0(j), soltheta(j), solphi(j)] = vpasolve(eqns3(j,:), vars, range);
end


function S = SolveA(i, B)

eqns=sym('x_%d',[1 3]);

syms a11 a12 a13 a21 a22 a23 a31 a32 a33
for j=1:3
    spec=j*3-2;
    eqns(j,1)= a11*i(j,1)+a21*i(j,2)+a31*i(j,3)==B(spec)*sin(B(spec+1))*cos(B(spec+2));
    eqns(j,2)= a12*i(j,1)+a22*i(j,2)+a32*i(j,3)==B(spec)*sin(B(spec+1))*sin(B(spec+2));
    eqns(j,3)= a13*i(j,1)+a23*i(j,2)+a33*i(j,3)==B(spec)*cos(B(spec+1));
end
vars=[a11 a12 a13 a21 a22 a23 a31 a32 a33];
S =vpasolve(eqns,vars);

function targetNew=PermuteNon111(target,permN)
targetNew=zeros(size(target));
for j=1:size(target,1)
   Pm=perms(target(j,3:2:end));
   Pp=perms(target(j,4:2:end));
   Pfinal=[Pm(permN,:) Pp(permN,:)];
   Pfinal=intrlv(Pfinal,[1 4 2 5 3 6]);
   targetNew(j,:)=[target(j,1:2) Pfinal];
end

function [B,resnorm]=ExactBfield(energies,Bguess, Dinit)
global gSolver
 % number of spectra
for i=1:size(energies,1)
    gSolver.wm(i,:)=energies(i,1:2:end);
    gSolver.wp(i,:)=energies(i,2:2:end);
end

typX=ones(12,1)/gSolver.gamma_e;
typX=[typX; ones(4,1)];
typX=4*typX;

opts1=  optimset('display','off','MaxFunEvals',16000,'MaxIter',4000,'TypicalX',typX,'TolX',1e-6,'TolFun',1e-6);
%options = optimoptions('lsqnonlin','Display','iter');
%opts1.Algorithm = 'levenberg-marquardt';
opts1.Algorithm = 'trust-region-reflective';

lb=[10 -Inf -Inf];
lb=repmat(lb,[1,4]);
for i=1:length(Dinit)
	lb=[lb,min(gSolver.Delta,Dinit(i))];
end

ub=[200 Inf Inf];
ub=repmat(ub,[1,4]);
for i=1:length(Dinit)
	ub=[ub,max(gSolver.Delta,Dinit(i))];
end

xguess=[reshape(Bguess,[1 12]), Dinit];

[B,resnorm] = lsqnonlin(@BfieldEqn,xguess,lb,ub,opts1); 

function [out]= BfieldEqn(x0)
% this function accepts transition energies from four spectra and tries to
% determine the corresponding B and D ("x0"). Each spectrum has a
% corresponding set of [mag theta phi] and all four spectra share four D.
% Therefore "x0" has 16 elements in that order.
global gSolver
wm=gSolver.wm;
wp=gSolver.wp;
% Delta=gSolver.Delta;
gamma=gSolver.gamma_e;

% The following equations are taken from the supp. info. IIa Eq. 2 of
% arXiv1611.00673 (which in turn was taken from supp. info. Eq. 40 of
% Nature Communications volume 6, Article number: 7886 (2015)). These
% should be exact. The first index of Bpar and Bperp is the spectrum
% number; the second is the NV axis. x0(13:16) refer to the D parameters.
for i=1:size(wm,1) % number of spectra
	Bparsq(i,:)=-(x0(13:16)+wp(i,:)-2*wm(i,:)).*(x0(13:16)+wm(i,:)...
        -2*wp(i,:)).*(x0(13:16)+wm(i,:)+wp(i,:))./(3^2*gamma^2*3*x0(13:16));
	Bperpsq(i,:)=-(2*x0(13:16)-wp(i,:)-wm(i,:)).*(2*x0(13:16)+2*wm(i,:)...
        -wp(i,:)).*(2*x0(13:16)-wm(i,:)+2*wp(i,:))./(3^2*gamma^2*3*x0(13:16));
	
	% the second index of Bz and Bx correspond to each NV axis.
	im=3*i-2;
	it=3*i-1;
	ip=3*i;
	Bz(i,1) = x0(im)*abs(1/sqrt(3)*(sin(x0(it))*cos(x0(ip))+sin(x0(it))*sin(x0(ip))+cos(x0(it))));
	Bz(i,2) = x0(im)*abs(1/sqrt(3)*(sin(x0(it))*cos(x0(ip))-sin(x0(it))*sin(x0(ip))+cos(x0(it))));
	Bz(i,3) = x0(im)*abs(1/sqrt(3)*(sin(x0(it))*cos(x0(ip))+sin(x0(it))*sin(x0(ip))-cos(x0(it))));
	Bz(i,4) = x0(im)*abs(1/sqrt(3)*(-sin(x0(it))*cos(x0(ip))+sin(x0(it))*sin(x0(ip))+cos(x0(it))));
	
	Bxsq(i,1) = x0(im)^2-Bz(i,1)^2;
	Bxsq(i,2) = x0(im)^2-Bz(i,2)^2;
	Bxsq(i,3) = x0(im)^2-Bz(i,3)^2;
	Bxsq(i,4) = x0(im)^2-Bz(i,4)^2;
end
Bz=Bz.^2;
% optimize B and Delta to minimize k1 and k2
k1=Bz-Bparsq;
k2=Bxsq-Bperpsq;
out=[k1 k2];

function PlotResults(target,B)
figure
for j=1:4
    subplot(2,2,j);
    spec=j*3-2;
    D=B(13:16);
    [calc,zz]=MakePlotBCalc(B(spec:spec+2),D);
    exp=MakePlotTarget(target(j,:),zz);
    plot(zz,exp,'o');
    hold on
    plot(zz,calc,'LineWidth',2);
    h=title(['$$B_0$$ = ', num2str(B(spec)),' G, $$\theta = $$ ',num2str(B(spec+1)),', $$\phi = $$ ',num2str(B(spec+2))]);
    set(h,'Interpreter','latex','fontsize',12)
end
xlabel('Frequency (MHz)')
legend('Experiment','Best fit B-field');

function f=MakePlotTarget(target,zz)
global gSolver
width = gSolver.width; % Width
Contrast = gSolver.contrast;

f=1;
contrastvar=Contrast*[1 1 2 2 3 3 4 4];
for j=1:length(target)
    f=f-(contrastvar(j)*width^2)./((zz-target(j)).^2+width^2);
end

function [f,zz]=MakePlotBCalc(B,D)
global gSolver
width = gSolver.width; % Width
Contrast = gSolver.contrast;
%Delta=gSolver.Delta;
gamma_e=gSolver.gamma_e;
Sz=gSolver.Sz;
Sx=gSolver.Sx;


Bz(1) = B(1)*abs(1/sqrt(3)*(sin(B(2))*cos(B(3))+sin(B(2))*sin(B(3))+cos(B(2))));
Bz(2) = B(1)*abs(1/sqrt(3)*(sin(B(2))*cos(B(3))-sin(B(2))*sin(B(3))+cos(B(2))));
Bz(3) = B(1)*abs(1/sqrt(3)*(sin(B(2))*cos(B(3))+sin(B(2))*sin(B(3))-cos(B(2))));
Bz(4) = B(1)*abs(1/sqrt(3)*(-sin(B(2))*cos(B(3))+sin(B(2))*sin(B(3))+cos(B(2))));

Bx(1) = sqrt(B(1)^2-Bz(1)^2);
Bx(2) = sqrt(B(1)^2-Bz(2)^2);
Bx(3) = sqrt(B(1)^2-Bz(3)^2);
Bx(4) = sqrt(B(1)^2-Bz(4)^2);

energies=[];
for j=1:4
    H=D(j)*Sz^2+gamma_e*(Bx(j)*Sx+Bz(j)*Sz);
    V=eig(H);
    energies=[energies V(2)-V(1) V(3)-V(1)];
end
Start_freq = round(min(energies))-50;
End_freq = round(max(energies)) + 50;

zz = Start_freq:.1:End_freq;
f=1;
contrastvar=Contrast*[1 1 2 2 3 3 4 4];
for j=1:length(energies)
    f=f-(contrastvar(j)*width^2)./((zz-energies(j)).^2+width^2);
end

function [thetanew, phinew]= RotateAbout111(thetaold,phiold,rot)
% This function rotates a unit vector, characterized by thetaold and
% phiold, about the 111 axis by angle rot. It is based on the notation
% presented at: http://paulbourke.net/geometry/rotate/.

theta=54.7356/180*pi;
phi=45/180*pi;
U = [sin(theta)*cos(phi), sin(theta)*sin(phi), cos(theta)]; % unit vector along rotation axis (111)
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
%%%%%%%%%%%%%%%%%%%%%%%%%%%FUNCTION GRAVEYARD%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% function [B0, theta, phi]=CrudeMonteCarlo(B0,theta,phi,target)
% E=ProjectBField(B0,theta,phi);
% error=sum(abs(target - E));
% disp(['Initial guess gives an error of ' num2str(error) ' MHz']);
% j=0;
% tic
% while error>50
%     j=j+1;
%     B0new=max(0,B0+0.01*randi([-1 1]));
%     thetanew=min(max(0, theta+0.01*randi([-1 1])),pi);
%     phinew=min(max(0, phi+0.01*randi([-1 1])),2*pi);
%     
%     E=ProjectBField(B0new,thetanew,phinew);
%     errornew=sum(abs(target - E));
%     if errornew<error
%         B0=B0new;
%         theta=thetanew;
%         phi=phinew;
%         error=errornew;
%     end
%     if j>50000000
%         break
%     end
% end
% disp(['Intermediate guess gives an error of ' num2str(error) ' MHz']);
% while error>5
%     j=j+1;
%     B0new=max(0,B0+0.0005*randi([-1 1]));
%     thetanew=min(max(0, theta+0.0005*randi([-1 1])),pi);
%     phinew=min(max(0, phi+0.0005*randi([-1 1])),2*pi);
%     
%     E=ProjectBField(B0new,thetanew,phinew);
%     errornew=sum(abs(target - E));
%     if errornew<error
%         B0=B0new;
%         theta=thetanew;
%         phi=phinew;
%         error=errornew;
%     end
%     if j>100000000
%         break
%     end
% end
% toc
% if j>1
%     disp(['Final guess gives an error of ' num2str(error) ' MHz']);
% end
% 
% function [E] = ProjectBField(B0,theta,phi)
% Bz(1) = B0*abs(1/sqrt(3)*(sin(theta)*cos(phi)+sin(theta)*sin(phi)+cos(theta)));
% Bz(2) = B0*abs(1/sqrt(3)*(sin(theta)*cos(phi)-sin(theta)*sin(phi)+cos(theta)));
% Bz(3) = B0*abs(1/sqrt(3)*(sin(theta)*cos(phi)+sin(theta)*sin(phi)-cos(theta)));
% Bz(4) = B0*abs(1/sqrt(3)*(-sin(theta)*cos(phi)+sin(theta)*sin(phi)+cos(theta)));
% 
% Bx(1) = sqrt(B0^2-Bz(1)^2);
% Bx(2) = sqrt(B0^2-Bz(2)^2);
% Bx(3) = sqrt(B0^2-Bz(3)^2);
% Bx(4) = sqrt(B0^2-Bz(4)^2);
% 
% E=[];
% for j=1:4
%     E = [E Energy([Bx(j) 0 Bz(j)])];
% end
% 
% function energies=Energy(B)
% % B is a vector corresponding to the magnetic field in Cartesian
% % coordinates defined by the given NV axis. ENERGIES gives the transition
% % energies ms=0 to -1 and 0 to +1.
% global gSolver
% Delta=gSolver.Delta;
% gamma_e=gSolver.gamma_e;
% Sx=gSolver.Sx;
% Sy=gSolver.Sy;
% Sz=gSolver.Sz;
% 
% H=Delta*Sz^2+gamma_e*(B(1)*Sx+B(2)*Sy+B(3)*Sz);
% V=eig(H);
% energies=[V(2)-V(1) V(3)-V(1)];

%function [B,bestRes]=ExactBfield(energies,Bguess, Dinit)
%global gSolver
%for i=1:size(energies,1)
%    gSolver.wm(i,:)=energies(1:2:end);
%    gSolver.wp(i,:)=energies(2:2:end);
%end


%opts1=  optimset('display','off');
%opts1.Algorithm = 'trust-region-reflective';
%for j=1:size(Bguess,2) % four different ways to choose three spectra from four
%    [Btemp(j,:),resnorm(j)] = lsqnonlin(@Projections,[Bguess(:,j), Dinit],[0 -Inf -Inf gSolver.Delta*ones(1,4)],[200 Inf Inf Dinit],opts1);
%end
%[bestRes,bestInd]=min(resnorm);
%B=Btemp(bestInd,:);





