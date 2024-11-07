function [pf, beta] = ExampleClass_nonlinear_FORM
clc;
close all;
clear all;

% Statistical properties of the random variables
mu1 = 10;
sigma1 = 3;
lambda = 1; % Rate parameter for exponential distribution

% Start in origin (initial guess in U-space)
u0 = [0; 0];
u = u0;
uall = u';

% Vectors of distribution parameters
s = [sigma1; lambda];
m = [mu1; 0]; % For exponential, we use 0 as it's not needed in transformation

% Finding the MPP (Most Probable Point)
for i = 1:100
    g = grad_g2(u, s, m); % Gradient of g2
    gtg = g' * g;
    gtu = g' * u;
    f = limitState_g2(u, s, m); % Limit state function g2
    lambda_step = (f - gtu) / gtg;
    v = g * (-lambda_step) - u;
    u = u + v;
    uall = [uall; u'];
    beta = sqrt(u' * u); % Reliability index
    
    % Check for convergence
    if norm(v) < 1e-6
        break;
    end
end

fprintf('\n\n******* Results FORM - HLRF *********');
fprintf('\nSafety Index beta = %f ', beta);
fprintf('\nProbability of failure pf = %e \n', normcdf(-beta));

% Backtransformation into original space:
x1s = sigma1 * u(1) + mu1;
x2s = -log(1 - normcdf(u(2))) / lambda;

fprintf('\nDesign Point in original space (x1*, x2*) = (%f, %f) ', x1s, x2s);
fprintf('\nLimit State Condition g(x1*, x2*) = %f \n', x1s^2 - x2s^3 + 23);

% Plot the limit state function in U-space
figure
[U1, U2] = meshgrid(linspace(-4, 4, 100), linspace(-4, 4, 100));
X1 = sigma1 * U1 + mu1;
X2 = -log(1 - normcdf(U2)) / lambda;
G = X1.^2 - X2.^3 + 23;

contour(U1, U2, G, [0 0], 'r', 'LineWidth', 2, 'DisplayName', 'Limit State Function')
hold on
plot([0 u(1)], [0 u(2)], 'g-', 'LineWidth', 1.5, 'DisplayName', 'Iteration Path');
plot(uall(:, 1), uall(:, 2), 'b.-', 'MarkerSize', 10, 'DisplayName', 'MPP Iterations');
plot(u(1), u(2), 'ro', 'MarkerSize', 10, 'LineWidth', 2, 'DisplayName', 'Final MPP');

% Set figure properties
set(gcf, 'Units', 'centimeters');
set(gcf, 'paperpositionmode', 'auto', 'PaperUnits', 'centimeters')
set(gcf, 'PaperSize', [29.7 / 2.0 23.0 / 2]);
set(gca, 'FontSize', 8);
xlabel('u1');
ylabel('u2');
title('Rackwitz-Fiessler Iteration for g2');
legend('show');


hold off

% X-space design point (already computed)
fprintf('\nMost Probable Failure Point (X-space) = (%f, %f)\n', x1s, x2s);
% U-space design point (after final iteration)
fprintf('\nMost Probable Failure Point (U-space) = (%f, %f)\n', u(1), u(2));

end

% Gradient of limit-state function
function grad_g2 = grad_g2(u, s, m)
    x1 = s(1) * u(1) + m(1);
    x2 = -log(1 - normcdf(u(2))) / s(2);
    
    dg_dx1 = 2 * x1;
    dg_dx2 = -3 * x2^2;
    
    dx1_du1 = s(1);
    dx2_du2 = 1 / (s(2) * normpdf(u(2)));
    
    grad_g2 = [dg_dx1 * dx1_du1; dg_dx2 * dx2_du2];
end

% Limit-state function g2 = X1^2 − X2^3 + 23
function ls_g2 = limitState_g2(u, s, m)
    x1 = s(1) * u(1) + m(1); % Transform from U-space to X-space
    x2 = -log(1 - normcdf(u(2))) / s(2); % Inverse CDF of exponential distribution
    ls_g2 = x1^2 - x2^3 + 23;
end