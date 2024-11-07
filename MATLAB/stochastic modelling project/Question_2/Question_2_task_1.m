clc;
close all;
clear all;

% Example exs_bar2 with Random Field for Young's Modulus
%----------------------------------------------------------------
% PURPOSE 
%    Analysis of a plane truss with random Young's modulus.
%----------------------------------------------------------------

clc;
close all;
clear all;

% Step 1: Define the parameters for the random field
mu_X = 200; % Mean of Young's modulus (GPa)
sigma_X = 10; % Standard deviation of Young's modulus (GPa)
theta = 10; % Correlation length

% Step 2: Discretize the domain
num_points = 50;
x = linspace(0, 3, num_points); % Length of 3 units for the truss

% Step 3: Define the correlation matrix
tau = pdist2(x', x');
C = exp(-2*(tau) / theta); % Markov model

% Step 4: Decompose the correlation matrix using Cholesky decomposition
L = chol(C, 'lower');

% Step 5: Generate the random field
X = randn(num_points, 1);
Y = L * X; % Apply the Cholesky factorization
Z = mu_X + sigma_X * Y; % Random field values for Young's modulus

% Step 6: Assign random material properties to the three bars
E1 = Z(round(num_points/3));
E2 = Z(round(2*num_points/3));
E3 = Z(end);

% Display the randomly assigned Young's modulus values
disp('Random Young''s modulus values (GPa) for each bar:');
disp([E1, E2, E3]);

% Step 7: Set up the finite element model
% Topology matrix Edof
Edof = [1 1 2 5 6;
        2 5 6 7 8;
        3 3 4 5 6];

% Stiffness matrix K and load vector f
K = zeros(8); 
f = zeros(8,1); 
f(6) = -80e3; % Load applied at node 6

%----- Element properties ---------------------------------------
A1 = 6.0e-4; % Cross-sectional area of bar 1
A2 = 3.0e-4; % Cross-sectional area of bar 2
A3 = 10.0e-4; % Cross-sectional area of bar 3
ep1 = [E1*1e9, A1]; % Convert GPa to Pa
ep2 = [E2*1e9, A2];
ep3 = [E3*1e9, A3];

%----- Element coordinates --------------------------------------
ex1 = [0 1.6]; ey1 = [0 0];
ex2 = [1.6 1.6]; ey2 = [0 1.2];
ex3 = [0 1.6]; ey3 = [1.2 0];

%----- Element stiffness matrices  ------------------------------
Ke1 = bar2e(ex1, ey1, ep1);
Ke2 = bar2e(ex2, ey2, ep2);
Ke3 = bar2e(ex3, ey3, ep3);

%----- Assemble Ke into K ---------------------------------------
K = assem(Edof(1,:), K, Ke1);
K = assem(Edof(2,:), K, Ke2);
K = assem(Edof(3,:), K, Ke3);

%----- Solve the system of equations ----------------------------
bc = [1 0; 2 0; 3 0; 4 0; 7 0; 8 0];
[a, r] = solveq(K, f, bc)

%----- Element forces -------------------------------------------
ed1 = extract_ed(Edof(1,:), a);
N1 = bar2s(ex1, ey1, ep1, ed1);
ed2 = extract_ed(Edof(2,:), a);
N2 = bar2s(ex2, ey2, ep2, ed2);
ed3 = extract_ed(Edof(3,:), a);
N3 = bar2s(ex3, ey3, ep3, ed3);

% Display results
disp('Displacements at each node (m):');
disp(a);

disp('Normal forces in each bar (N):');
disp([N1, N2, N3]);

%----- Draw deformed truss ---------------------------------------
figure(1)
plotpar=[2 1 0];
eldraw2(ex1, ey1, plotpar);
eldraw2(ex2, ey2, plotpar);
eldraw2(ex3, ey3, plotpar);
sfac = scalfact2(ex1, ey1, ed1, 0.1);
plotpar = [1 2 1];
eldisp2(ex1, ey1, ed1, plotpar, sfac);
eldisp2(ex2, ey2, ed2, plotpar, sfac);
eldisp2(ex3, ey3, ed3, plotpar, sfac);
axis([-0.4 2.0 -0.4 1.4]);
title('Deformed Truss');

%----- Draw normal force diagram --------------------------------

figure(2)
plotpar = [2 1];
sfac = scalfact2(ex1, ey1, N1(:,1), 0.1);
secforce2(ex1, ey1, N1(:,1), plotpar, sfac);
secforce2(ex2, ey2, N2(:,1), plotpar, sfac);
secforce2(ex3, ey3, N3(:,1), plotpar, sfac);
axis([-0.4 2.0 -0.4 1.4]);
title('Normal Force Diagram');

