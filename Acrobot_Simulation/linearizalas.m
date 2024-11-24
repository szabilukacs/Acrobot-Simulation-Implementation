function [A, B] = linearizalas(m1, m2, l1, l2, lc1, lc2, J1, J2)
% This function performs the linearization of the acrobot system
% around the upright equilibrium position.

% Constants
g = 9.81; % Gravitational acceleration

% Coefficients for inertia and coupling terms
c1 = m1 * lc1^2 + m2 * l1^2 + J1;  % Inertia term for the first link
c2 = m2 * lc2^2 + J2;              % Inertia term for the second link
c3 = m2 * l1 * lc2;                % Coupling term between links

% Gravity-related terms
k1 = (m1 * lc1 + m2 * l1) * g;     % Torque due to gravity on the first link
k2 = m2 * lc2 * g;                 % Torque due to gravity on the second link

% Inertia matrix inverse
Seged = inv([c1 + c2 + 2 * c3, c2 + c3;
             c2 + c3,          c2]);

% Extract terms from the inverse matrix
a11 = Seged(1, 1);
a12 = Seged(1, 2);
a21 = Seged(2, 1);
a22 = Seged(2, 2);

% Linearized dynamics coefficients
A1 = a11 * (k1 + k2) + a12 * k2;
A2 = (a11 + a12) * k2;
A3 = a12 * (k1 + k2) + a22 * k2;
A4 = (a12 + a22) * k2;

% State-space representation matrix A
A_dyn = [A1, A2;
         A3, A4];
A = [zeros(2), eye(2);  % Includes angular positions and velocities
     A_dyn, zeros(2)];

% State-space representation matrix B
B = [0;
     0;
     a12;
     a22];
end
