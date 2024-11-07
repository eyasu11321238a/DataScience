clc;
clear all;
close all;
%% Initialize UQLab
uqlab;

%% Define the probabilistic model (INPUT object)
% Define the marginals for X1 and X2
InputOpts.Marginals(1).Type = 'Gaussian';
InputOpts.Marginals(1).Parameters = [10, 3]; % Mean and Std for X1 (Normal distribution)

InputOpts.Marginals(2).Type = 'Exponential';
InputOpts.Marginals(2).Parameters = 1; % Rate parameter for X2 (Exponential distribution)

% Create the INPUT object
myInput = uq_createInput(InputOpts);

%% Define the limit state function (MODEL object)
% Define the limit state function g2 = X1^2 - X2^3 + 23
ModelOpts.mString = 'X(:,1).^2 - X(:,2).^3 + 23'; % MATLAB function for g2
ModelOpts.isVectorized = true; % To handle vectorized operations

% Create the MODEL object
myModel = uq_createModel(ModelOpts);

%% Set up the reliability analysis (ANALYSIS object)
% Monte Carlo Simulation (MCS) setup
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
