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
gSolver.width=3; %linewidth for plotting
gSolver.contrast=0.05; %contrast for plotting

%---------------------------USER INPUT------------------------------------%

% the current you applied for three instances (amps). For stability of this
% algorithm, please ensure that the currents applied do not flip polarity;
% i.e., do not flip the signal and ground wires between instances.
i=[-2.4 -.5 2.4];
i=[i; -2.4 -1 2.4];
i=[i; -.5 -2.4 3];

% Transition energies from your ODMR spectra (MHz). Each line must be in
% the order: ms=-1 (111), ms=+1 (111), ...
target=[2.61947 3.17361 2.70725 3.12832 2.84077 3.01981 2.76736 3.0784];
target=[target; 2.57286 3.20127 2.7415 3.10849 2.90188 2.96854 2.76697 3.08122];
target=[target; 2.66241 3.16528 2.77138 3.10118 2.7056 3.13849 2.72438 3.1233];
target=target*10^3;

%---------------------------ALGORITHM-------------------------------------%
% Given the three ODMR spectra, we need to determine the three
% corresponding magnetic fields that produce them. Our solution space
% corresponds to |B|, theta, and phi (three times). To narrow this space,
% we begin by solving the Hamiltonian for B up to linear order only. This
% completely linearizes the problem and provides an initial guess.
permutations=6;
iter=size(target,1);
Binit=zeros(iter,size(target,2)/2);
B=zeros(permutations,iter,3);
residual=NaN(permutations,iter);
success=0;
% The nonlinear solver is extremely reliant on the initial guess. To
% exhaust all possible guesses, we permute all three non-111 axes in every
% possible configuration (six).
for k=1:permutations
    targetNew=PermuteNon111(target,k);
    for j=1:iter
        Binit(j,:)=InitialGuess(targetNew(j,:));
        [B0init, thetainit, phiinit]=SolveB(Binit(j,:));
        [B(k,j,:), residual(k,j)]=ExactBfield(targetNew(j,:),[B0init; thetainit; phiinit]);
    end
    if sum(residual(k,:))<0.02*3
        success=1;
        break
    end
end

if ~success
    [bestrow,~]=find(residual<0.02);
    % indices to unique values
    [~, ind] = unique(bestrow);
    % duplicate indices
    duplicate_ind = setdiff(1:length(bestrow), ind);
    % duplicate values
    duplicate_value = bestrow(duplicate_ind);
    if ~isempty(duplicate_ind)
        for l=1:length(duplicate_ind)
            targetNew=PermuteNon111(target,duplicate_value(l));
            for m=1:iter
                if residual(duplicate_value(l),m)>0.02
                    for n=1:permutations
                        for o=1:3
                            [thetatemp, phitemp]=RotateAbout111(B(n,m,2),B(n,m,3),o*120/180*pi);
                            temp=[B(n,m,1) thetatemp phitemp];
                            [Btemp, residualtemp]=ExactBfield(targetNew(j,:),temp');
                            if residual(duplicate_value(l),m)>residualtemp
                                residual(duplicate_value(l),m)=residualtemp;
                                B(duplicate_value(l),m,:)=Btemp;
                                success=1;
                            end
                        end
                        
                    end
                end
            end
        end
    else 
        error('Could not converge upon the right solution')
    end
end
if ~success
    error('Could not converge upon the right solution')
end 

disp(residual);
chooserow=input('Please choose the permutation: ');

Bfinal=squeeze(B(chooserow,:,:));
targetNew=PermuteNon111(target,chooserow);
%Bfinal(1,2)=Bfinal(1,2)+pi; %first index is iteration; second is [mag theta phi]
PlotResults(targetNew,Bfinal);

figure
[hAtom]=MagnetHiLevelFunctionPool('PlotInit',gca);
for j=1:iter
    MagnetHiLevelFunctionPool('PlotMag',Bfinal(j,:),gca,hAtom);
end

% Now that we have an initial guess, we can use it to calculate an
% approximation for the eigenenergies. We then vary the initial guess to
% converge to the measured eigenenergies.


% Finally, we insert the three calculated magnetic fields into our linear
% system of equations to back out a_{mn}.

a_mn=structfun(@double,SolveA(i,Bfinal));
gMag.a_mn=reshape(a_mn,[3 3])';

%----------------------------HELPER FUNCTIONS-----------------------------%

function B = InitialGuess(energy)
% ENERGY is a vector of ODMR transition energies. The algorithm outputs
% the magnetic field projection along each NV axis that you provide.
global gSolver

B=(energy(2:2:end)-energy(1:2:end))/(2*gSolver.gamma_e);

function [solB0, soltheta, solphi] = SolveB(Binit)
syms B0 theta phi
eqns = [B0*abs(1/sqrt(3)*(sin(theta)*cos(phi)+sin(theta)*sin(phi)+cos(theta))) == Binit(1),... 
    B0*abs(1/sqrt(3)*(sin(theta)*cos(phi)-sin(theta)*sin(phi)+cos(theta))) == Binit(2),...
    B0*abs(1/sqrt(3)*(sin(theta)*cos(phi)+sin(theta)*sin(phi)-cos(theta))) == Binit(3),...
    B0*abs(1/sqrt(3)*(-sin(theta)*cos(phi)+sin(theta)*sin(phi)+cos(theta))) == Binit(4);];
vars = [B0 theta phi];
range=[0 100; 0 pi; 0 2*pi];
eqns3=combnk(eqns,3);

solB0=zeros(1,4);soltheta=zeros(1,4);solphi=zeros(1,4);
for j=1:4
    [solB0(j), soltheta(j), solphi(j)] = vpasolve(eqns3(j,:), vars, range);
end


function S = SolveA(i, B)

eqns=sym('x_%d',[1 3]);

syms a11 a12 a13 a21 a22 a23 a31 a32 a33
for j=1:3
    eqns(j,1)= a11*i(j,1)+a21*i(j,2)+a31*i(j,3)==B(j,1)*sin(B(j,2))*cos(B(j,3));
    eqns(j,2)= a12*i(j,1)+a22*i(j,2)+a32*i(j,3)==B(j,1)*sin(B(j,2))*sin(B(j,3));
    eqns(j,3)= a13*i(j,1)+a23*i(j,2)+a33*i(j,3)==B(j,1)*cos(B(j,2));
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

function [B,bestRes]=ExactBfield(energies,guess)
global gSolver

gSolver.wm=energies(1:2:end);
gSolver.wp=energies(2:2:end);

opts1=  optimset('display','off');
%options = optimoptions('lsqnonlin','Display','iter');
%opts1.Algorithm = 'levenberg-marquardt';
opts1.Algorithm = 'trust-region-reflective';
for j=1:size(guess,2)
    [Btemp(j,:),resnorm(j)] = lsqnonlin(@Projections,guess(:,j),[],[],opts1);
end
[bestRes,best]=min(resnorm);
B=Btemp(best,:);



function[Bz, Bx]= Projections(B)
global gSolver
wm=gSolver.wm;
wp=gSolver.wp;
Delta=gSolver.Delta;
gamma=gSolver.gamma_e;

% The following equations are taken from the supp. info. IIa Eq. 2 of
% arXiv1611.00673. These should be exact.
Bpar=sqrt(-(Delta+wp-2*wm).*(Delta+wm-2*wp).*(Delta+wm+wp))/(3*gamma*sqrt(3*Delta));
Bperp=sqrt(-(2*Delta-wp-wm).*(2*Delta+2*wm-wp).*(2*Delta-wm+2*wp))/(3*gamma*sqrt(3*Delta));

Bz(1) = B(1)*abs(1/sqrt(3)*(sin(B(2))*cos(B(3))+sin(B(2))*sin(B(3))+cos(B(2))));
Bz(2) = B(1)*abs(1/sqrt(3)*(sin(B(2))*cos(B(3))-sin(B(2))*sin(B(3))+cos(B(2))));
Bz(3) = B(1)*abs(1/sqrt(3)*(sin(B(2))*cos(B(3))+sin(B(2))*sin(B(3))-cos(B(2))));
Bz(4) = B(1)*abs(1/sqrt(3)*(-sin(B(2))*cos(B(3))+sin(B(2))*sin(B(3))+cos(B(2))));

Bx(1) = sqrt(B(1)^2-Bz(1)^2);
Bx(2) = sqrt(B(1)^2-Bz(2)^2);
Bx(3) = sqrt(B(1)^2-Bz(3)^2);
Bx(4) = sqrt(B(1)^2-Bz(4)^2);
Bz=Bz-Bpar;
Bx=Bx-Bperp;

function PlotResults(target,B)
figure
for j=1:3
    subplot(3,1,j);
    [calc,zz]=MakePlotBCalc(B(j,:));
    exp=MakePlotTarget(target(j,:),zz);
    plot(zz,exp,'o');
    hold on
    plot(zz,calc,'LineWidth',2);
    h=title(['$$B_0$$ = ', num2str(B(j,1)),' G, $$\theta = $$ ',num2str(B(j,2)),', $$\phi = $$ ',num2str(B(j,3))]);
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

function [f,zz]=MakePlotBCalc(B)
global gSolver
width = gSolver.width; % Width
Contrast = gSolver.contrast;
Delta=gSolver.Delta;
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
    H=Delta*Sz^2+gamma_e*(Bx(j)*Sx+Bz(j)*Sz);
    V=eig(H);
    energies=[energies V(2)-V(1) V(3)-V(1)];
end
Start_freq = round(min(energies))-50;
End_freq = round(max(energies)) + 50;

zz = Start_freq:End_freq;
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






