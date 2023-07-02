clear 
close
clc
rR155_geo = readmatrix('rR155_geo.xlsx');
h = 0.001;


%% Airfoil points
n = size(rR155_geo,1);
for i=1:n
   A(i,1)=i; 
   A(i,2)=rR155_geo(i,1);   
   A(i,3)=rR155_geo(i,2);         
   A(i,4)=rR155_geo(i,3);        % z=0 (2D mesh)
   A(i,5)=h;
end

% Scrittura di tutti i punti airfoil + C-grid
for i=1:size(A,1)
fprintf('Point(%d)={%d,%d,%d,%d};\n',A(i,:));
end

