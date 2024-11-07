clear all
close all
clc

% Limit state function: g2 = X1^2 - X2^3 + 23

%% MCS Method
N = 1e6; % Number of samples

% Statistical properties for X1 and X2
mu_X1 = 10;
sigma_X1 = 3;
lambda_X2 = 1; % Parameter for exponential distribution

% Generate normally distributed random variables for X1
X1 = random('Normal', mu_X1, sigma_X1, N, 1);

% Generate exponentially distributed random variables for X2
X2 = random('Exponential', lambda_X2, N, 1);

% Limit state function
g = X1.^2 - X2.^3 + 23;

% Identify safe and failure indices
safeIdx = g >= 0;
failIdx = g < 0;

% Monte Carlo Simulation for failure probability
pf_MCS = sum(g < 0) / N;
beta_MCS = norminv(1 - pf_MCS);

fprintf('\n\n******* Results MCS *********');
fprintf('\nMCS: Failure Probability pf = %f', pf_MCS);
fprintf('\nMCS: Safety Index beta = %f\n', beta_MCS);

%% FOSM Method
% Mean values of the limit state function
mu_g = mu_X1^2 - (2 / lambda_X2^3) + 23;

% Partial derivatives of g with respect to X1 and X2
dg_dX1 = 2 * mu_X1; % dg/dX1 = 2*X1
dg_dX2 = -3 * (2 / lambda_X2^2); % dg/dX2 = -3*X2^2

% Variance of the limit state function
sigma_g = sqrt((dg_dX1 * sigma_X1)^2 + (dg_dX2 * lambda_X2^2)^2);

% Reliability index beta for FOSM method
beta_FOSM = mu_g / sigma_g;

% Probability of failure using FOSM method
pf_FOSM = normcdf(-beta_FOSM);

fprintf('\n\n******* Results FOSM *********');
fprintf('\nFOSM: Failure Probability pf = %f', pf_FOSM);
fprintf('\nFOSM: Safety Index beta = %f\n', beta_FOSM);

%% Plot the limit state function and the results with MCS in X-space
figure
hold on

% Plot safe and failure points
plot(X1(safeIdx), X2(safeIdx), 'b.', 'MarkerSize', 10)
plot(X1(failIdx), X2(failIdx), 'r.', 'MarkerSize', 10)

% Get current axis limits
xLim = xlim;
yLim = ylim;

% Define grid for contour plot
[x1Grid, x2Grid] = meshgrid(linspace(xLim(1), xLim(2), 100), linspace(yLim(1), yLim(2), 100));
gGrid = x1Grid.^2 - x2Grid.^3 + 23;

% Plot contour for limit state function g = 0
contour(x1Grid, x2Grid, gGrid, [0 0], 'g', 'LineWidth', 2)

% Plot mean values
plot([mu_X1 mu_X1], yLim, 'k--')
plot(xLim, [1/lambda_X2 1/lambda_X2], 'k--')

hold off

xlabel('X_1')
ylabel('X_2')
title('Limit State Function and Results with MCS in X-space')
legend('Safe', 'Failure', 'Limit State', 'Mean X_1', 'Mean X_2', 'Location', 'best')

% Adjust axis for better visualization
axis([0 max(xlim) 0 max(ylim)])

%% Plot the limit state function and the results with MCS in U-space
% Transform variables to standard normal space
U1 = (X1 - mu_X1) / sigma_X1;
U2 = norminv(1 - exp(-X2 * lambda_X2));

figure
hold on

% Plot safe and failure points in U-space
plot(U1(safeIdx), U2(safeIdx), 'b.', 'MarkerSize', 10)
plot(U1(failIdx), U2(failIdx), 'r.', 'MarkerSize', 10)

% Get current axis limits
xLim = xlim;
yLim = ylim;

% Define grid for contour plot in U-space
[u1Grid, u2Grid] = meshgrid(linspace(xLim(1), xLim(2), 100), linspace(yLim(1), yLim(2), 100));
x1Grid = u1Grid * sigma_X1 + mu_X1;
x2Grid = -log(1 - normcdf(u2Grid)) / lambda_X2;
gGrid = x1Grid.^2 - x2Grid.^3 + 23;

% Plot contour for limit state function g = 0 in U-space
contour(u1Grid, u2Grid, gGrid, [0 0], 'g', 'LineWidth', 2)

% Plot origin (mean in U-space)
plot([0 0], yLim, 'k--')
plot(xLim, [0 0], 'k--')

hold off

xlabel('U_1')
ylabel('U_2')
title('Limit State Function and Results with MCS in U-space')
legend('Safe', 'Failure', 'Limit State', 'U_1 = 0', 'U_2 = 0', 'Location', 'best')

% Adjust axis for better visualization
axis equal
xlim([-4 4])
ylim([-4 4])