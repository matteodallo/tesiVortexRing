% GENERIC AIRFOIL .geo FILE CREATOR FOR 2D GMSH MESH GENERATION
% Author: Matteo Dall'Ora
% NOTE: Airfoil coordinates must be 300. Coordinate file must consist of
% two columns (column 1: x, column 2: y) without any internal title
%--------------------------------------------------------------------------

%% OPTIONS
% 0. Data and airfoil
    R = 120;     % farfield dimension 
    h = 0.0006;  % element size close to airfoil (later diminished close to LE and TE) 
    airfoil = readmatrix('rR906_final.dat'); 

% 1. Boundary Layer Flag (Euler vs RANS)
    % BL=1 --> YES
    % BL=0 --> NO
    BL = 1;
    FAN = 0; % Trailing edge fan (1=YES, 0=NO)
    % First cell size -> may need TUNING according to Y+ = 1 criterium
    ss = (1e-5).*(h./0.0005);  % tuned for Re approximately 500 000
%--------------------------------------------------------------------------

% 2. Domain independence <-> Grid independence
    % 1 = Domain independence (tuned for h=0.002)
    % 2 = Grid independence (tuned for R=60) --> Default choice (updated)
    II = 2; 
%--------------------------------------------------------------------------

% 3. Fixed h <-> Variable h
    % 1 = Fixed
    % 2 = Variable (linear variation)
    hh = 1;
%--------------------------------------------------------------------------

% 4. TE fan number of elements
    % Baseline is 40
    % For low h, can be increased to 80/100
    ff = floor(36*(0.0025/h));
%--------------------------------------------------------------------------

%% C-Grid data are given as INPUT to the function

    % For GRID INDEPENDENCE and DOMAIN INDEPENDENCE ONLY! 
    if II == 1
    H = R./15;             % Dimension at farfield for domain ind.
    elseif II == 2
    H = (R/10).*1200.*h;    % Dimension at farfield for grid ind.
    end

    % Other data
    Href   = 480.*h;           % Dimension at refinement box boundary
    Rref   = 4;                % C-grid refinement box dimension
    Href2   = 80.*h;           % Dimension at refinement box boundary
    Rref2   = 0.8;             % C-grid refinement box dimension
%--------------------------------------------------------------------------

%% Airfoil points
n = size(airfoil,1);
h_factor = linspace(0.1, 1, n/4);    
h_u = [h_factor flip(h_factor)]; 
h_l = h_u;
h_vect = h.*[h_u h_l];   % h multiplication factor (h goes to 10% at LE and TE)
A = zeros(n, 5);
if hh == 1
    for i=1:n
       A(i,1)=i; 
       A(i,2)=airfoil(i,1);   
       A(i,3)=airfoil(i,2);         
       A(i,4)=0;        % z=0 (2D mesh)
       A(i,5)=h;
    end
elseif hh == 2
    for i=1:n
       A(i,1)=i; 
       A(i,2)=airfoil(i,1);   
       A(i,3)=airfoil(i,2);         
       A(i,4)=0;        % z=0 (2D mesh)
       A(i,5)=h_vect(i);
    end
end
%--------------------------------------------------------------------------

%% C-Grid points
A(301,:) = [301, 2*R, -R, 0, H/1.5];    % basso dx
A(302,:) = [302, 2*R, R, 0, H/1.5];     % alto dx
A(303,:) = [303, 0.25, R, 0, H];        % alto sx
A(304,:) = [304, 0.25, 0, 0, H];        % centro cerchio
A(305,:) = [305, 0.25, -R, 0, H];       % basso dx
%--------------------------------------------------------------------------

%% Refinement C-Grid points
A(306,:) = [306, 1.2*R, -R/3, 0, H/3.5];         % basso dx
A(307,:) = [307, 1.2*R, R/3, 0, H/3.5];          % alto dx
A(308,:) = [308, 0, Rref, 0, Href];            % alto sx
A(309,:) = [309, 0, 0, 0, Href];               % centro cerchio
A(310,:) = [310, 0, -Rref, 0, Href];           % basso sx

%% Refinement C-Grid points
A(311,:) = [311, 2.5*Rref2, -Rref2, 0, Href2/1.5];          % basso dx
A(312,:) = [312, 2.5*Rref2, Rref2, 0, Href2/1.5];         % alto dx
A(313,:) = [313, 0, Rref2, 0, Href2];                % alto sx
A(314,:) = [314, 0, 0, 0, Href2];                    % centro cerchio
A(315,:) = [315, 0, -Rref2, 0, Href2];               % basso sx



%% Refinement for Shock points
% A(311,:) = [311, 0.07, 0.034, 0, Href/20];    % basso sx
% A(312,:) = [312, 0.23, 0.0343, 0, Href/20];      % basso dx
% A(313,:) = [313, 0.23, 0.327, 0, Href/20];     % alto dx
% A(314,:) = [314, 0.07, 0.327, 0, Href/20];       % alto sx

%% Printing
% GMSH geometry file is stored as .geo file
fileID = fopen("mesh.geo",'w');

% Scrittura di tutti i punti airfoil + C-grid
for i=1:size(A,1)
fprintf(fileID,'Point(%d)={%d,%d,%d,%d};\n',A(i,:));
end

% Scrittura delle spline che definiscono l'airfoil
fprintf(fileID,'BSpline(1)={290,291,292,293,294,295,296,297,298,299,300,1,2,3,4,5,6,7,8,9,10};\n');
fprintf(fileID,'BSpline(2)={10:290};\n');

% Scrittura delle linee e del semicerchio della C-Grid di farfield
fprintf(fileID,'Line(5)={301,302};\n');
fprintf(fileID,'Line(6)={302,303};\n');
fprintf(fileID,'Circle(7)={303,304,305};\n');
fprintf(fileID,'Line(8)={305,301};\n');

% Scrittura delle linee e del semicerchio della C-Grid a ventaglio (Ref. Box)
fprintf(fileID,'Line(15)={306,307};\n');
fprintf(fileID,'Line(16)={307,308};\n');
fprintf(fileID,'Circle(17)={308,309,310};\n');
fprintf(fileID,'Line(18)={310,306};\n');
% Scrittura delle linee e del semicerchio della C-Grid a ventaglio (Ref. Box)
fprintf(fileID,'Line(19)={311,312};\n');
fprintf(fileID,'Line(20)={312,313};\n');
fprintf(fileID,'Circle(21)={313,314,315};\n');
fprintf(fileID,'Line(22)={315,311};\n');


% % Scrittura delle linee della refbox per la shock (Ref. Box)
% fprintf(fileID,'Line(19)={311,312};\n');
% fprintf(fileID,'Line(20)={312,313};\n');
% fprintf(fileID,'Line(21)={313,314};\n');
% fprintf(fileID,'Line(22)={314,311};\n');

% Scrittura dei loop
% Interno (Airfoil)
fprintf(fileID,'Line Loop(101)={1,2};\n');
% Ref. Box. (C-grid a ventaglio)
fprintf(fileID,'Line Loop(103)={15,16,17,18};\n');
% Ref. Box. (C-grid a ventaglio 2)
fprintf(fileID,'Line Loop(102)={19,20,21,22};\n');
% Farfield (C-grid)
fprintf(fileID,'Line Loop(104)={5,6,7,8};\n');
% Ref. Box. (shock)
% fprintf(fileID,'Line Loop(4)={19,20,21,22};\n');

if BL == 1
fprintf(fileID,'Field[1]=BoundaryLayer;\n');
fprintf(fileID,'Field[1].CurvesList={1,2};\n');
fprintf(fileID,'Field[1].Quads=1;\n');
fprintf(fileID,'Field[1].Ratio=1.15;\n');
fprintf(fileID,'Field[1].Size=%d;\n',ss);
fprintf(fileID,'Field[1].Thickness=0.005;\n'); 
if FAN == 1
fprintf(fileID,'Field[1].FanPointsList={1};\n');
fprintf(fileID,'Field[1].FanPointsSizesList={%d};\n',ff);
end
fprintf(fileID,'BoundaryLayer Field = 1;\n');
end

% Scrittura della superficie da meshare
fprintf(fileID,'Plane Surface(1) = {101,102};\n');
fprintf(fileID,'Plane Surface(2) = {102,103};\n');
fprintf(fileID,'Plane Surface(3) = {103,104};\n');
% fprintf(fileID,'Plane Surface(3) = {4,1};\n');
fprintf(fileID,'Physical Surface(1) = {1};\n');
fprintf(fileID,'Physical Surface(2) = {2};\n');
fprintf(fileID,'Physical Surface(3) = {3};\n');
% fprintf(fileID,'Physical Surface(3) = {3};\n');

% Scrittura delle linee di inlet, outlet e airfoil
fprintf(fileID,'Physical Line("AIRFOIL") = {1,2};\n');
fprintf(fileID,'Physical Line("FARFIELD") = {5,6,7,8};\n');

% Scrittura dell'algoritmo di meshing
fprintf(fileID,'Mesh.Algorithm = 5;\n');

fclose(fileID);