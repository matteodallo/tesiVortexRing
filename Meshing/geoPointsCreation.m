clear %--------------------------------------------------------------------
close %--------------------------------------------------------------------
clc %----------------------------------------------------------------------
addpath(genpath('Airfoils Betzina')) %-------------------------------------
addpath(genpath('Airfoils NACA 6 series')) %-------------------------------

% Load the appropriate x,y coordinate file and choose h
airfoil = readmatrix('rR756_refined.dat');
h = 0.003;
creation = 1;   % 1 = ACTIVATE THIS FLAG FOR POINT LIST CREATION (otherwise 0 = only plotting)

if creation == 1
% Airfoil points list creation for the geo file --> find them in command
n = size(airfoil,1);
h_factor = linspace(0.2, 1, n/4);
h_u = [h_factor flip(h_factor)]; 
h_l = h_u;
h_vect = h.*[h_u h_l];
for i=1:n
   A(i,1)=i; 
   A(i,2)=airfoil(i,1);   
   A(i,3)=airfoil(i,2);         
   A(i,4)=0;        % z=0 (2D mesh)
   A(i,5)=h_vect(i);
end
% Scrittura di tutti i punti airfoil
for i=1:size(A,1)
fprintf('Point(%d)={%d,%d,%d,%d};\n',A(i,:));
end
end

% Coordinates are plotted here
figure()
plot(airfoil(:,1),airfoil(:,2),'o-')
xlim([-0.1 1.1])
axis equal

figure()
plot(airfoil(:,1), h_vect)