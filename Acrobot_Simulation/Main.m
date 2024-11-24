clear all;
close all;
clc

%% Betolti a valos rendszer parametereit
run('real_parameters.m');

%% Linearizalas a munkapont korul
% q1 q2 dq1 dq2 
[A,B] = linearizalas(m1,m2,l1,l2,lc1,lc2,J1,J2);

%% LQR szamitas
K = LQR_function(A,B);

%% Szimulacio Simulinkben
open_system('Real_Acrobot_Simulation.slx')
Sim_time = 35;
out = sim('Real_Acrobot_Simulation',Sim_time);

% set view convention -> Y up (XY)
% standard views -> Front view

%% Get parameters
run('getParameters.m');

%% Abrak megjelentese
run('Visualization_real.m');