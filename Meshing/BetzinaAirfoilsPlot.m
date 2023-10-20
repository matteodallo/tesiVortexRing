clear all
close all
clc
%--------------------------------------------------------------------------
addpath(genpath('Airfoils Betzina'))
addpath(genpath('Airfoils NACA 6 series'))

% Blade data
%------------ n   r/R [-]  beta [deg]  c [in]    t/c [-] ------------------
BladeData =  [1   0.1550   26.7000     4.0900    0.4660
              2   0.2060   23.2000     4.0500    0.4070
              3   0.3060   17.8000     4.0200    0.3350
              4   0.4050   11.1000     3.9000    0.2690
              5   0.5060    8.2000     3.7700    0.2110
              6   0.6060    3.8000     3.6000    0.1910
              7   0.7070    2.2000     3.3900    0.1620
              8   0.7560         0     3.2500    0.1470
              9   0.8050   -0.8000     3.0900    0.1380
              10  0.8560   -2.6000     2.9500    0.1250
              11  0.9060   -3.9000     2.7800    0.1200
              12  0.9590   -4.6000     2.5400    0.1070];

% Airfoils data
%------------ u, l: column1 = x/c column2 = y/c ---------------------------
rR155u = readmatrix('rR155.xlsx','Range','A2:B34');
rR155l = readmatrix('rR155.xlsx','Range','C2:D33');

rR206u = readmatrix('rR206.xlsx','Range','A2:B32');
rR206l = readmatrix('rR206.xlsx','Range','C2:D32');

rR306u = readmatrix('rR306.xlsx','Range','A2:B32');
rR306l = readmatrix('rR306.xlsx','Range','C2:D31');

rR405u = readmatrix('rR405.xlsx','Range','A2:B31');
rR405l = readmatrix('rR405.xlsx','Range','C2:D30');

rR506u = readmatrix('rR506.xlsx','Range','A2:B28');
rR506l = readmatrix('rR506.xlsx','Range','C2:D28');

rR606u = readmatrix('rR606.xlsx','Range','A2:B28');
rR606l = readmatrix('rR606.xlsx','Range','C2:D28');

rR707u = readmatrix('rR707.xlsx','Range','A2:B30');
rR707l = readmatrix('rR707.xlsx','Range','C2:D29');

rR756u = readmatrix('rR707.xlsx','Range','A2:B31');
rR756l = readmatrix('rR707.xlsx','Range','C2:D30');

rR805u = readmatrix('rR805.xlsx','Range','A2:B29');
rR805l = readmatrix('rR805.xlsx','Range','C2:D28');

rR856u = readmatrix('rR856.xlsx','Range','A2:B28');
rR856l = readmatrix('rR856.xlsx','Range','C2:D28');

rR906u = readmatrix('rR906.xlsx','Range','A2:B28');
rR906l = readmatrix('rR906.xlsx','Range','C2:D28');

rR959u = readmatrix('rR959.xlsx','Range','A2:B25');
rR959l = readmatrix('rR959.xlsx','Range','C2:D25');

% NACA 6 series
% --------------- generated with OpenVSP ----------------------------------
naca64528 = readmatrix("naca64528.dat");
naca64528_a03 = readmatrix("naca64528_a03.dat");
naca64935 = readmatrix("naca64935.dat");
naca64935_a03 = readmatrix("naca64935_a03.dat");

% Plots
%----------------
figure()
plot(naca64528_a03(:,1),naca64528_a03(:,2),'k',LineWidth=1.5)
hold on
title('Betzina blade airfoils','interpreter','latex')
xlabel('x/c [-]','interpreter','latex')
ylabel('y/c [-]','interpreter','latex')
xlim([-0.1 1.1])
axis equal
% plot(naca64935(:,1),naca64935(:,2),'k',LineWidth=1.5)
% plot(naca64935_a03(:,1),naca64935_a03(:,2),'b',LineWidth=1.5)
plot(rR155u(:,1),rR155u(:,2),'bo-',rR155l(:,1),rR155l(:,2),'bo-')
plot(rR206u(:,1),rR206u(:,2),'co-',rR206l(:,1),rR206l(:,2),'co-')
% plot(rR306u(:,1),rR306u(:,2),'mo-',rR306l(:,1),rR306l(:,2),'mo-')
% plot(rR405u(:,1),rR405u(:,2),'ro-',rR405l(:,1),rR405l(:,2),'ro-')
plot(rR906u(:,1),rR906u(:,2),'ro-',rR906l(:,1),rR906l(:,2),'ro-')
plot(rR756u(:,1),rR756u(:,2),'bo-',rR756l(:,1),rR756l(:,2),'bo-')
legend('NACA 64-528')
% legend('NACA 64-528','NACA 64-935','NACA 64-935 a=0.3')





