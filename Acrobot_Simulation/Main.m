% This is the main program for simulating an acrobot.
clear all;
close all;
clc

%% Load the parameters of the real system
run('real_parameters.m');

%% Linearization around the operating point
% Variables: q1, q2, dq1, dq2
[A,B] = linearizalas(m1, m2, l1, l2, lc1, lc2, J1, J2);

%% LQR calculation
K = LQR_function(A, B);

%% Simulation in Simulink
open_system('Real_Acrobot_Simulation.slx')
Sim_time = 35;
out = sim('Real_Acrobot_Simulation', Sim_time);

% Set view convention -> Y-axis up (XY)
% Standard views -> Front view

%% Get parameters
run('getParameters.m');

%% Display the plots
run('Visualization_real.m');