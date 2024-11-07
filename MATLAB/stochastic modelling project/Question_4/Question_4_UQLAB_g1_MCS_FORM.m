%% Initialize UQLab
uqlab;

%% the probabilistic model (INPUT object)
% Define the marginals for X1 and X2
InputOpts.Marginals(1).Type = 'Gaussian';
InputOpts.Marginals(1).Parameters = [12, 5]; % Mean and Std for X1

InputOpts.Marginals(2).Type = 'Gaussian';
InputOpts.Marginals(2).Parameters = [10, 9]; % Mean and Std for X2

% the INPUT object
myInput = uq_createInput(InputOpts);

%% Defining the limit state function (MODEL object)
% Define the limit state function g1 = 3X1 - 2X2 + 18
ModelOpts.mString = '3 * X(:,1) - 2 * X(:,2) + 18'; % MATLAB function for g1
ModelOpts.isVectorized = true; % To handle vectorized operations

% Create the MODEL object
myModel = uq_createModel(ModelOpts);

%% Set up the reliability analysis (ANALYSIS object)
% Choose the method: Monte Carlo Simulation (MCS)
ReliabilityOpts.Type = 'Reliability';
ReliabilityOpts.Method = 'MCS'; % Monte Carlo Simulation
ReliabilityOpts.Simulation.BatchSize = 1e4; % Number of samples per batch
ReliabilityOpts.Simulation.MaxSampleSize = 1e6; % Maximum number of samples

% Assign the limit state function and input
ReliabilityOpts.Model = myModel;
ReliabilityOpts.Input = myInput;

% Run the reliability analysis using MCS
MCSAnalysis = uq_createAnalysis(ReliabilityOpts);

%% Output the MCS results
uq_print(MCSAnalysis);
uq_display(MCSAnalysis);

%% Set up FORM analysis
ReliabilityOpts.Method = 'FORM'; % First Order Reliability Method

% Run the reliability analysis using FORM
FORMAnalysis = uq_createAnalysis(ReliabilityOpts);

%% Output the FORM results
uq_print(FORMAnalysis);
uq_display(FORMAnalysis);
