% Clear the workspace, close all figures, and clear the command window
clear all; 
close all; 
clc;

% Acrobot parameters
m1 = 0.1;           % Mass of the first link (lower segment) in kilograms
m2 = 0.1;           % Mass of the second link (upper segment) in kilograms
l1 = 0.36;          % Length of the first link (lower segment) in meters
l2 = 0.36;          % Length of the second link (upper segment) in meters
lc1 = l1 * 0.5;     % Center of mass of the lower segment (halfway along l1)
lc2 = l2 * 0.5;     % Center of mass of the upper segment (halfway along l2)
g = 9.81;           % Gravitational acceleration in m/s²
J1 = m1 * l1^2;     % Moment of inertia of the lower segment about its center of mass
J2 = m2 * l2^2;     % Moment of inertia of the upper segment about its center of mass

% Initial state of the acrobot
% Q0 contains the initial angles and angular velocities of the links
% Format: [theta1, theta2, dtheta1, dtheta2]
% theta1: Initial angle of the first link (lower segment) in radians
% theta2: Initial angle of the second link (upper segment) in radians
% dtheta1: Initial angular velocity of the first link in rad/s
% dtheta2: Initial angular velocity of the second link in rad/s
Q0 = [pi 0 0 0];    % Starting with first link vertical (pi radians), all velocities zero
