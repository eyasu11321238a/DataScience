clear all
close all
clc

% Monte Carlo Simulation Parameters
N = 1e5; % Number of samples
mu_X = 200e9; % Mean Young's modulus in Pascals
sigma_X = 10e9; % Standard deviation of Young's modulus in Pascals
theta = 10; % Correlation length for random field

% Geometry and Force
L1 = 1.6; L2 = 1.2; % Lengths of truss members (in meters)
P = 80e3; % Load in Newtons

% Displacement threshold for failure
displacement_threshold = 1.2e-3; % 1.2 mm in meters

% Number of points for the random field
num_points = 3;
x = linspace(0, 3, num_points); % Length of 3 units for the truss

% Define the correlation matrix
tau = pdist2(x', x');
C = exp(-2*(tau) / theta); % Markov model

% Decompose the correlation matrix using Cholesky decomposition
L = chol(C, 'lower');

% Initialize counters for failure events
failure_count = 0;

% Store displacement data for histogram
displacements = zeros(N, 1);

% Perform Monte Carlo Simulation and store displacements
for i = 1:N
    % Generate Random Young's Modulus for the three bars
    X = randn(num_points, 1);
    Y = L * X; % Apply the Cholesky factorization
    E_rand = mu_X + sigma_X * Y; % Random field values for Young's modulus
    
    % Element properties for the random Young's modulus values
    A1 = 6.0e-4; A2 = 3.0e-4; A3 = 10.0e-4; % Areas of bars in m^2
    ep1 = [E_rand(1) A1]; 
    ep2 = [E_rand(2) A2];
    ep3 = [E_rand(3) A3];
    
    % Stiffness matrix K and load vector f
    K = zeros(8, 8);
    f = zeros(8, 1); 
    f(6) = -P; % Applied load at node 6
    
    % Element coordinates
    ex1 = [0 1.6]; ey1 = [0 0];
    ex2 = [1.6 1.6]; ey2 = [0 1.2];
    ex3 = [0 1.6]; ey3 = [1.2 0];
    
    % Calculate the element stiffness matrices
    Ke1 = bar2e(ex1, ey1, ep1);
    Ke2 = bar2e(ex2, ey2, ep2);
    Ke3 = bar2e(ex3, ey3, ep3);
    
    % Assemble global stiffness matrix
    Edof = [1 1 2 5 6;
            2 5 6 7 8;
            3 3 4 5 6];
        
    K = assem(Edof(1,:), K, Ke1);
    K = assem(Edof(2,:), K, Ke2);
    K = assem(Edof(3,:), K, Ke3);
    
    % Solve for displacements
    bc = [1 0; 2 0; 3 0; 4 0; 7 0; 8 0];
    [a, ~] = solveq(K, f, bc);
    
    % Store displacement at node 6
    displacements(i) = abs(a(6));
    
    % Check if displacement exceeds the threshold
    if abs(a(6)) > displacement_threshold
        failure_count = failure_count + 1;
    end
end

% Calculate failure probability and reliability index
pf = failure_count / N;
beta = -norminv(pf, 0, 1);

% Output Results
fprintf('Failure Probability pf = %f\n', pf);
fprintf('Reliability Index beta = %f\n', beta);

% Plot Histogram
figure;
hold on;

% Define bins and histogram
edges = linspace(min(displacements), max(displacements), 130);
hist_data = histcounts(displacements, edges);

% Plot histogram bars
bar(edges(1:end-1), hist_data, 'FaceColor', 'b', 'EdgeColor', 'k');

% Add failure threshold line
y_limits = ylim;
plot([displacement_threshold displacement_threshold], [0 y_limits(2)], 'r--', 'LineWidth', 2);

% Highlight failure zone in red
failure_idx = displacements > displacement_threshold;
failure_hist_data = histcounts(displacements(failure_idx), edges);
bar(edges(1:end-1), failure_hist_data, 'FaceColor', 'r', 'EdgeColor', 'k');

xlabel('Displacement (m)');
ylabel('Frequency');
title('Histogram of Displacements with Failure Zone Highlighted');
legend('Safe Zone', 'Failure Threshold', 'Failure Zone');

hold off;
