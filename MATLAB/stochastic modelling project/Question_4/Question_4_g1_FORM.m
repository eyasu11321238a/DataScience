function [pf, beta] = ExampleClass_linear_FORM
clc;
close all;
clear all;


% Statistical properties of the random variables
mu1 = 12;
sigma1 = 5;
mu2 = 10;
sigma2 = 9;

% Start in origin (initial guess in U-space)
u0 = [0; 0];
u = u0;
uall = u';

% Vectors of standard deviation and mean values
s = [sigma1; sigma2];
m = [mu1; mu2];

% Finding the MPP (Most Probable Point)
for i = 1:15
    g = grad_g1(u, s, m); % Gradient of g1
    gtg = g' * g;
    gtu = g' * u;
    f = limitState_g1(u, s, m); % Limit state function g1
    lambda = (f - gtu) / gtg;
    v = g * (-lambda) - u;
    u = u + v;
    uall = [uall; u'];
    beta = sqrt(u' * u); % Reliability index
end

fprintf('\n\n******* Results FORM - HLRF *********');
fprintf('\nSafety Index beta = %f ', beta);
fprintf('\nProbability of failure pf = %f \n', normcdf(-beta));

% Backtransformation into original space:
x1s = sigma1 * u(1) + mu1;
x2s = sigma2 * u(2) + mu2;

fprintf('\nDesign Point in original space (x1*, x2*) = (%f, %f) ', x1s, x2s);
fprintf('\nLimit State Condition g(x1*, x2*) = %f \n', 3 * x1s - 2 * x2s + 18);

% Plot the limit state function in U-space
figure
x1 = linspace(-3, 10, 100);
x2 = (3/2) * x1 + 9; % Limit state function line in original space
u1 = (x1 - mu1) / sigma1;
u2 = (x2 - mu2) / sigma2;
plot(u1, u2, 'r', 'DisplayName', 'Limit State Function')
hold on
plot([0 u(1)], [0 u(2)], 'g', 'DisplayName', 'Iteration Path');
plot(uall(:, 1), uall(:, 2), '-');
plot(uall(:, 1), uall(:, 2), '.', 'DisplayName', 'MPP Iterations');

% Set figure properties
set(gcf, 'Units', 'centimeters');
set(gcf, 'paperpositionmode', 'auto', 'PaperUnits', 'centimeters')
set(gcf, 'PaperSize', [29.7 / 2.0 23.0 / 2]);
set(gca, 'FontSize', 8);

xlabel('u1');
ylabel('u2');
title('Rackwitz-Fiessler Iteration');
legend('show');

% Add labels for safe and unsafe regions
txtar_safe = annotation('textbox', [0.55 0.4 0.1 0.1], 'String', 'Safe Region', 'FontSize', 12, 'LineStyle', 'none', 'Color', 'b');
txtar_unsafe = annotation('textbox', [0.3 0.6 0.1 0.1], 'String', 'Unsafe Region', 'FontSize', 12, 'LineStyle', 'none', 'Color', 'r');
txtar = annotation('textbox', [0.75 0.55 0.1 0.1], 'String', '\beta', 'FontSize', 14, 'LineStyle', 'none');
hold off

% X-space design point (already computed)
fprintf('\nMost Probable Failure Point (X-space) = (%f, %f)\n', x1s, x2s);

% U-space design point (after final iteration)
fprintf('\nMost Probable Failure Point (U-space) = (%f, %f)\n', u(1), u(2));

end

% Gradient of limit-state function
function grad_g1 = grad_g1(u, s, m)
    % Gradient of g1 = 3*X1 - 2*X2 + 18 w.r.t. X1 and X2
    grad_g1 = [3 * s(1); -2 * s(2)];
end

% Limit-state function g1 = 3*X1 - 2*X2 + 18
function ls_g1 = limitState_g1(u, s, m)
    x1 = s(1) * u(1) + m(1); % Transform from U-space to X-space
    x2 = s(2) * u(2) + m(2);
    ls_g1 = 3 * x1 - 2 * x2 + 18;
end

