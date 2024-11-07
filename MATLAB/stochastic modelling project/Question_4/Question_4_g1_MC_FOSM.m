clear all
close all
clc

% Limit state function: g1 = 3X1 − 2X2 + 18

%% Monte Carlo Simulation (MCS)

N = 1e6; % Number of samples

% Statistical properties for X1 and X2
mu_1 = 12;
sigma_1 = 5;
mu_2 = 10;
sigma_2 = 9;

% Generate random variables X1 and X2
X1 = random('Normal', mu_1, sigma_1, N, 1);
X2 = random('Normal', mu_2, sigma_2, N, 1);

% limit state function g1 = 3X1 - 2X2 + 18
g1 = 3*X1 - 2*X2 + 18;

% Identify indices for safe and fail conditions (g >= 0 for safe)
safeIdx = find(g1 >= 0);
failIdx = find(g1 < 0);

% failure probability pf and reliability index beta using MCS
pf_mcs = sum(g1 < 0) / N; % Failure probability estimate
beta_mcs = -norminv(pf_mcs, 0, 1); % Reliability index estimate

fprintf('\n\n******* Results MCS *********');
fprintf('\nMCS: Failure Probability pf = %f', pf_mcs);
fprintf('\nMCS: Reliability Index beta = %f\n', beta_mcs);

%% FOSM Method

% Calculate mean value of g1
mu_g1 = mean(g1);

% Calculate standard deviation of g1 evaluated at mean point
sigma_g1 = std(g1);

% FOSM reliability index
beta_fosm = abs(mu_g1 / sigma_g1);

% FOSM failure probability (approximation for linear limit state)
pf_fosm = normcdf(-beta_fosm);

fprintf('\n\n******* Results FOSM *********');
fprintf('\nFOSM: Failure Probability pf = %f', pf_fosm);
fprintf('\nFOSM: Reliability Index beta = %f', beta_fosm);
fprintf('\n***************************\n');

%% Visualizations

% Plot in original variable space (X1, X2)
figure
hold on
plot(X1(safeIdx), X2(safeIdx), 'b.')
plot(X1(failIdx), X2(failIdx), 'r.')

% Define the limit state equation 3X1 - 2X2 + 18 = 0
% Rearranging it: X2 = (3/2)*X1 + 9
xLim = get(gca, 'xlim');  % Get current X-axis limits
X1_line = linspace(xLim(1), xLim(2), 100); % X1 values for plotting the limit state
X2_line = (3/2)*X1_line + 9; % Corresponding X2 values for the limit state

plot(X1_line, X2_line, 'g', 'linewidth', 2) % Green limit state line
xlabel('X_1')
ylabel('X_2')
legend('Safe', 'Fail', 'Limit State')
hold off

% Plot in standard normal space (U1, U2)
U1 = (X1 - mu_1) / sigma_1;
U2 = (X2 - mu_2) / sigma_2;

figure
hold on
plot(U1(safeIdx), U2(safeIdx), 'b.')
plot(U1(failIdx), U2(failIdx), 'r.')

% Convert the limit state line into standard normal space
U1_line = (X1_line - mu_1) / sigma_1;
U2_line = (X2_line - mu_2) / sigma_2;

plot(U1_line, U2_line, 'g', 'linewidth', 2) % Green limit state line in U-space
xlabel('U_1')
ylabel('U_2')
legend('Safe', 'Fail', 'Limit State')
hold off
