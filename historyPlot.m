clear all
close all
clc
%--------------------------------------------------------------------------
addpath(genpath('Airfoils Betzina'))
addpath(genpath('Airfoils NACA 6 series'))
%--------------------------------------------------------------------------

history = readmatrix('history155_coll10inflow.csv');
iter = history(:,3);
CD = history(:,10);
CL = history(:,11);

figure()
plot(iter,CL,'b',iter,0.*iter,'k')
title('CL convergence history','interpreter','latex')
xlabel('iter','interpreter','latex')
ylabel('CL','interpreter','latex')

figure()
plot(iter,CD,'r',iter,(0.*iter),'k')
title('CD convergence history','interpreter','latex')
xlabel('iter','interpreter','latex')
ylabel('CD','interpreter','latex')
ylim([-0.2 0.2])


