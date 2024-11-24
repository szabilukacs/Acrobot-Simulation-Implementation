% These are the real parameters.
clear all;
close all;
clc;

% Mass of the lower segment (wooden block)
m_weight = 0.086; 

% Gravitational acceleration
g = 9.81;

% System parameters
m1 = 0.1012;      % Mass of the first link
m2 = 0.1203;      % Mass of the second link
l1 = 0.4;         % Length of the first link
l2 = 0.425;       % Length of the second link
lc1 = 0.2885;     % Center of mass of the first link
lc2 = 0.34;       % Center of mass of the second link
J1 = 0.0015;      % Inertia of the first link
J2 = 0.0018;      % Inertia of the second link

% Initial state
% Variables: q1 (angle 1), dq1 (angular velocity 1), q2 (angle 2), dq2 (angular velocity 2)
Q0 = [0.1 0 0 0];
