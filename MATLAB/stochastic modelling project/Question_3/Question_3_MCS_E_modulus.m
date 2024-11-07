clc;
clear;
close all;

% Parameters for the random field
muX = 210.0e9;  % Mean Young's Modulus (Pa)
sigmaX = 15.0e9;  % Standard deviation of Young's Modulus (Pa)
theta = 6;  % Correlation length

% Discretization
N = 6;  % Number of segments (each frame element is divided into two)

% Generate the correlation matrix
x = linspace(0, N-1, N);  % Positions of the frame segments
tau = pdist2(x', x');
C = exp(-2 * tau / theta);  % Markov model for the correlation matrix

% Decompose correlation matrix to generate random field
L = chol(C, 'lower');

% Monte Carlo Simulation
num_simulations = 1000;  % Number of Monte Carlo simulations
horizontal_displacements = zeros(num_simulations, 1);

% Initialize an array to store the last simulation's E-modulus
E_last = zeros(N, 1);

for i = 1:num_simulations
    % Generate new random field for each simulation
    X = randn(N, 1);  % Uncorrelated random variables
    Y = L * X;  % Correlated random variables
    random_field = muX + sigmaX * Y;  % Scale and offset
    
    % Assign the random Young's modulus to each segment
    E = random_field;  % Young's modulus for each segment
    
    % Store the E-modulus of the last simulation
    if i == num_simulations
        E_last = E;
    end
    
    % Divide each frame element into two segments
    A1 = 2e-3;  A2 = 6e-3;
    I1 = 1.6e-5; I2 = 5.4e-5;
    
    % Element properties for divided segments
    ep1 = [E(1) A1 I1]; ep2 = [E(2) A1 I1];
    ep3 = [E(3) A2 I2]; ep4 = [E(4) A2 I2];
    ep5 = [E(5) A1 I1]; ep6 = [E(6) A1 I1];
    
    
    ex1 = [0 0];  ey1 = [0 2];  ex2 = [0 0]; ey2 = [2 4];
    ex3 = [6 6];  ey3 = [0 2];  ex4 = [6 6]; ey4 = [2 4];
    ex5 = [0 3];  ey5 = [4 4];  ex6 = [3 6]; ey6 = [4 4];
    
    % Element stiffness matrices
    Ke1 = beam2e(ex1, ey1, ep1); Ke2 = beam2e(ex2, ey2, ep2);
    Ke3 = beam2e(ex3, ey3, ep3); Ke4 = beam2e(ex4, ey4, ep4);
    Ke5 = beam2e(ex5, ey5, ep5); Ke6 = beam2e(ex6, ey6, ep6);
    
    % Topology matrix for divided segments
    Edof = [
        1 1 2 3 4 5 6;
        2 3 4 5 6 7 8;
        3 7 8 9 10 11 12;
        4 9 10 11 12 13 14;
        5 13 14 15 16 17 18;
        6 15 16 17 18 19 20;
    ];
    
    % Initialize global stiffness matrix and load vector
    K = zeros(20, 20);
    f = zeros(20, 1); f(4) = 2e3;  % Apply load at node 4
    
    % Assemble global stiffness matrix
    K = assem(Edof(1,:), K, Ke1);
    K = assem(Edof(2,:), K, Ke2);
    K = assem(Edof(3,:), K, Ke3);
    K = assem(Edof(4,:), K, Ke4);
    K = assem(Edof(5,:), K, Ke5);
    K = assem(Edof(6,:), K, Ke6);
    
    % Boundary conditions
    bc = [1 0; 2 0; 3 0; 18 0; 19 0];  % Fixed at node 1 and node 9
    
    % Solve system of equations
    [a, ~] = solveq(K, f, bc);
    
    % Store horizontal displacement at the top of the frame (node 4)
    horizontal_displacements(i) = a(4);
end

% Plot histogram of the horizontal displacements
figure;
histogram(horizontal_displacements, 30);
title('Histogram of Horizontal Displacements at the Top of the Frame');
xlabel('Horizontal Displacement [m]');
ylabel('Frequency');

% Display the new random E-modulus for the last simulation
disp('Random E-modulus for each new element:');
disp(E_last);

% Plot the new random E-modulus
figure;
plot(1:N, E_last, 'o-');
xlabel('Element Number');
ylabel('E-modulus (Pa)');
title('Random E-modulus for Divided Frame Elements');
grid on;

% Calculate and display the average horizontal displacement
average_displacement = mean(horizontal_displacements);
fprintf('Average Horizontal Displacement at the Top of the Frame: %.4e meters\n', average_displacement);
