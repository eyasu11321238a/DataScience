clc;
close all;
clear all;

% Define the field and discretize
m = 30; % Mean
s = 3; % Standard deviation

num_points = 50;
x = linspace(0, 5, num_points);

% Define correlation matrix
theta = 1.5;
tau = pdist2(x', x');
C = exp(-2*(tau) / theta); % Markov model

% Decompose correlation matrix
L = chol(C, 'lower'); % Use lower triangular decomposition

% Generate Random Field
numsamps = 1; % We only need one sample for this problem
X = randn(num_points, numsamps);
Y = L * X; % Apply the Cholesky factorization
Z = m + s * Y;

% Extract five values for the material properties
random_k = Z(round(linspace(1, num_points, 5)), :);

% Visualize the random values used for thermal conductivities
disp('Random thermal conductivities (W/K) for each section:');
disp(random_k');

% Topology matrix Edof
Edof = [1 1 2;
        2 2 3;
        3 3 4;
        4 4 5;
        5 5 6];

% Stiffness matrix K and load vector f
K = zeros(6); 
f = zeros(6, 1);   
f(4) = 10; % Heat source inside the wall

% Element properties
ep1 = random_k(1); ep2 = random_k(2);
ep3 = random_k(3); ep4 = random_k(4);
ep5 = random_k(5);

% Element stiffness matrices
Ke1 = spring1e(ep1); Ke2 = spring1e(ep2);
Ke3 = spring1e(ep3); Ke4 = spring1e(ep4);
Ke5 = spring1e(ep5);

% Assemble Ke into K
K = assem(Edof(1,:), K, Ke1);
K = assem(Edof(2,:), K, Ke2);
K = assem(Edof(3,:), K, Ke3);
K = assem(Edof(4,:), K, Ke4);
K = assem(Edof(5,:), K, Ke5);

% Solve the system of equations
bc = [1 -25; 6 24]; % Updated boundary conditions
[a, r] = solveq(K, f, bc);

% Display the temperature results
disp('Temperature distribution (°C) at each node:');
disp(a');

% Element flows
ed1 = extract_ed(Edof(1,:), a);
ed2 = extract_ed(Edof(2,:), a);
ed3 = extract_ed(Edof(3,:), a);
ed4 = extract_ed(Edof(4,:), a);
ed5 = extract_ed(Edof(5,:), a);

q1 = spring1s(ep1, ed1);
q2 = spring1s(ep2, ed2);
q3 = spring1s(ep3, ed3);
q4 = spring1s(ep4, ed4);
q5 = spring1s(ep5, ed5);

% Display the heat flow results
disp('Heat flow (W/m²) for each section:');
disp([q1 q2 q3 q4 q5]);

% End of script
