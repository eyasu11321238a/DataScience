clear all
close all
clc

% Monte Carlo Simulation Parameters
N = 1e5; % Number of samples
mu_X_GPa = 200.0; % Mean Young's modulus in GPa
theta = 10; % Correlation length for random field
beta_target = 3.0; % Target reliability index

% Convert mean Young's modulus to Pascals
mu_X_Pa = mu_X_GPa * 1e9; % Convert GPa to Pascals

% Geometry and Force
L1 = 1.6; L2 = 1.2; % Lengths of truss members (in meters)
P = 80e3; % Load in Newtons

% Displacement threshold for failure
displacement_threshold = 1.2e-3; % 1.2 mm in meters

% Initialize the standard deviation and step size
E_std_GPa = 2.75; % Initial guess
E_std_Pa = E_std_GPa * 1e9; % Convert to Pascals
step_size_GPa = 0.05; % Smaller step size for fine-tuning

% Initialize reliability index
beta = 0;

while abs(beta - beta_target) > 0.01
    failure_count = 0;
    
    % Step 2: Discretize the domain
    num_points = 50;
    x = linspace(0, 3, num_points); % Length of 3 units for the truss
    
    % Step 3: Define the correlation matrix
    tau = pdist2(x', x');
    C = exp(-2*(tau) / theta); % Markov model
    
    % Step 4: Decompose the correlation matrix using Cholesky decomposition
    L = chol(C, 'lower');
    
    % Monte Carlo Simulation
    for i = 1:N
        % Generate Random Young's Modulus for the three bars using the random field
        X = randn(num_points, 1);
        Y = L * X; % Apply the Cholesky factorization
        Z = mu_X_Pa + E_std_Pa * Y; % Random field values for Young's modulus
        
        % Sample Young's modulus values for the three bars
        E_rand = Z(1:3); % Assuming the first three values for simplicity
        
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
        
        % Check if displacement at node 6 exceeds the threshold
        if abs(a(6)) > displacement_threshold
            failure_count = failure_count + 1;
        end
    end
    
    % Calculate failure probability and reliability index
    pf = failure_count / N;
    beta = -norminv(pf, 0, 1);
    
    % Adjust the standard deviation if the target beta is not met
    if beta < beta_target
        E_std_GPa = E_std_GPa - step_size_GPa; % Decrease standard deviation
    else
        E_std_GPa = E_std_GPa + step_size_GPa / 2; % Increase standard deviation
    end
    
    % Update the standard deviation in Pascals
    E_std_Pa = E_std_GPa * 1e9;
    
    % Display current iteration results
    fprintf('Current E_std = %f GPa, Reliability Index beta = %f\n', E_std_GPa, beta);
end

fprintf('\nFinal E_std = %f GPa meets the target beta = %f\n', E_std_GPa, beta);
