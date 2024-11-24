function [K] = LQR_function(A, B)
% This function computes the LQR (Linear-Quadratic Regulator) gain matrix K
% for the given state-space matrices A and B.

% Define the output matrix (C) and direct transmission matrix (D)
C = eye(4);  % Full-state feedback (identity matrix)
D = zeros(4, 1);  % No direct feedthrough

% Check controllability
Co = ctrb(A, B);  % Controllability matrix
if rank(Co) < size(A, 1)
    warning('The system is not fully controllable!');
end

% Define the weighting matrices for the LQR design
Q = [1 0 0 0;  % State weighting matrix (penalizes deviations)
     0 1 0 0;
     0 0 1 0;
     0 0 0 1];
R = 100;  % Control input weighting scalar (penalizes large control effort)

% Solve the Algebraic Riccati Equation (ARE)
P = are(A, B * inv(R) * B', Q);  % P is the solution to the ARE

% Compute the LQR gain matrix and closed-loop poles
[K, S, CLP] = lqr(A, B, Q, R);  % K: gain matrix, S: solution to ARE, CLP: closed-loop poles

% Print the closed-loop poles for verification
disp('Closed-loop poles:');
disp(CLP);

% Define the closed-loop system matrices
A_szab = A - B * K;  % Closed-loop state matrix
B_szab = zeros(size(B));  % No input for the closed-loop system (assumed here)

% q1, q2, dq1, dq2 represent the state variables (angles and angular velocities)

end
