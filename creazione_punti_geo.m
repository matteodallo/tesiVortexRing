clear 
close
clc

h = 0.001;
bet = readmatrix('bet.dat');

figure()
plot(bet(:,1),bet(:,2),'o-')
xlim([-0.1 1.1])
axis equal



%% Airfoil points
n = size(bet,1);
for i=1:n
   A(i,1)=i; 
   A(i,2)=bet(i,1);   
   A(i,3)=bet(i,2);         
   A(i,4)=0;        % z=0 (2D mesh)
   A(i,5)=h;
end

% Scrittura di tutti i punti airfoil
for i=1:size(A,1)
fprintf('Point(%d)={%d,%d,%d,%d};\n',A(i,:));
end

