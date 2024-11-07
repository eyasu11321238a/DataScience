clear all;
close all;
clc;

% Number of Monte Carlo simulations
N = 1e5;

% Preallocate vectors to store heat flows and temperatures
q1_all = zeros(N, 1);
q2_all = zeros(N, 1);
q3_all = zeros(N, 1);
q4_all = zeros(N, 1);
q5_all = zeros(N, 1);
T_all = zeros(N, 6); % Assuming 6 nodes

% Parameters for the random field
m = 30; % Mean
s = 3; % Standard deviation
num_points = 50;
theta = 1.5;
x = linspace(0, 5, num_points);
tau = pdist2(x', x');
C = exp(-2*(tau) / theta); % Markov model
L = chol(C, 'lower');

% Topology matrix Edof
Edof = [1 1 2;
        2 2 3;
        3 3 4;
        4 4 5;
        5 5 6];

% Boundary conditions
bc = [1 -25; 6 24]; % Updated boundary conditions

% Monte Carlo Simulation Loop
for i = 1:N
    % Generate Random Field
    X = randn(num_points, 1);
    Y = L * X; % Apply the Cholesky factorization
    Z = m + s * Y;
    
    % Extract five values for the material properties
    random_k = Z(round(linspace(1, num_points, 5)));
    
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
    [a, r] = solveq(K, f, bc);

    % Store temperatures
    T_all(i, :) = a'; % Ensure 'a' is a row vector

    % Element flows
    ed1 = extract_ed(Edof(1,:), a);
    ed2 = extract_ed(Edof(2,:), a);
    ed3 = extract_ed(Edof(3,:), a);
    ed4 = extract_ed(Edof(4,:), a);
    ed5 = extract_ed(Edof(5,:), a);

    q1_all(i) = spring1s(ep1, ed1);
    q2_all(i) = spring1s(ep2, ed2);
    q3_all(i) = spring1s(ep3, ed3);
    q4_all(i) = spring1s(ep4, ed4);
    q5_all(i) = spring1s(ep5, ed5);
end

% Compute means and standard deviations
mean_q1 = mean(q1_all);
mean_q2 = mean(q2_all);
mean_q3 = mean(q3_all);
mean_q4 = mean(q4_all);
mean_q5 = mean(q5_all);

std_q1 = std(q1_all);
std_q2 = std(q2_all);
std_q3 = std(q3_all);
std_q4 = std(q4_all);
std_q5 = std(q5_all);

% Compute temperature statistics
mean_T = mean(T_all);
std_T = std(T_all);

% Display results to the console
disp('The Monte Carlo simulation yielded the following results:');

% Heat Flow
disp('Mean Heat Flows for Each Section (W/m²):');
fprintf('q1 = %.4f, q2 = %.4f, q3 = %.4f, q4 = %.4f, q5 = %.4f\n', ...
        mean_q1, mean_q2, mean_q3, mean_q4, mean_q5);

disp('Standard Deviation of Heat Flows for Each Section (W/m²):');
fprintf('σ_{q1} = %.4f, σ_{q2} = %.4f, σ_{q3} = %.4f, σ_{q4} = %.4f, σ_{q5} = %.4f\n', ...
        std_q1, std_q2, std_q3, std_q4, std_q5);

% Temperatures
disp('Mean Temperatures at Each Node (°C):');
fprintf('T_1 = %.4f, T_2 = %.4f, T_3 = %.4f, T_4 = %.4f, T_5 = %.4f, T_6 = %.4f\n', ...
        mean_T(1), mean_T(2), mean_T(3), mean_T(4), mean_T(5), mean_T(6));

disp('Standard Deviation of Temperatures at Each Node (°C):');
fprintf('σ_{T_1} = %.4f, σ_{T_2} = %.4f, σ_{T_3} = %.4f, σ_{T_4} = %.4f, σ_{T_5} = %.4f, σ_{T_6} = %.4f\n', ...
        std_T(1), std_T(2), std_T(3), std_T(4), std_T(5), std_T(6));

% Plotting histograms for heat flows in separate figures
figure;
histogram(q1_all, 'Normalization', 'pdf');
title('Heat Flow q_1');

figure;
histogram(q2_all, 'Normalization', 'pdf');
title('Heat Flow q_2');

figure;
histogram(q3_all, 'Normalization', 'pdf');
title('Heat Flow q_3');

figure;
histogram(q4_all, 'Normalization', 'pdf');
title('Heat Flow q_4');

figure;
histogram(q5_all, 'Normalization', 'pdf');
title('Heat Flow q_5');
