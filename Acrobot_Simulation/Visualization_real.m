close all;

% Find the time of the switch (transition to linear controller)
for i = 1:length(t)
    if (switch_state(i) ~= 0)
        break;
    end
end
t_valtas = t(i); % Time of the switch

% ---- Figure 1: Angular positions and velocities ----
figure(1);
subplot(2, 1, 1)
title('Acrobot Swing-Up and Balance - Angular Positions')
hold on
plot(t, q1, 'LineWidth', 2);
plot(t, q2, 'LineWidth', 2);
plot(t_valtas, q1(i), 'r*');
plot(t_valtas, q2(i), 'r*');
xlabel('Time [sec]');
ylabel('Angle [degrees]');
legend('q_1', 'q_2', 'Switch to linear controller');

subplot(2, 1, 2)
title('Acrobot Swing-Up and Balance - Angular Velocities')
hold on
plot(t, dq1, 'LineWidth', 2);
plot(t, dq2, 'LineWidth', 2);
plot(t_valtas, dq1(i), 'r*');
plot(t_valtas, dq2(i), 'r*');
xlabel('Time [sec]');
ylabel('Angular velocity [degrees/sec]');
legend('dq_1', 'dq_2', 'Switch to linear controller');

% ---- Figure 2: Energy plot ----
figure(2);
set(gca, 'fontsize', 18);
hold on
title('Energy of the Acrobot')
plot(t, E, 'LineWidth', 2);
line([0, 35], [1.159, 1.159], 'Color', 'red', 'LineStyle', '--'); % Target energy
xlabel('Time [sec]');
ylabel('Energy [Joule]');
legend('E', 'Target energy');

% ---- Figure 3: Phase portrait for q1 and dq1 ----
figure(3);
set(gca, 'fontsize', 18);
hold on
grid on
plot(0, 0, 'square', 'MarkerFaceColor', 'green'); % Stable equilibrium
plot(180, 0, 'ro', 'MarkerFaceColor', 'red');    % Unstable equilibrium
plot(rad2deg(Q0(1)), Q0(3), '*', 'MarkerFaceColor', 'black'); % Initial state
plot(q1, dq1, 'b');
xlabel('q_1 [degrees]');
ylabel('dq_1 [degrees/sec]');
legend('Stable equilibrium', 'Unstable equilibrium', 'Initial state');
title('Phase Portrait - Angle vs Angular Velocity (q_1 - dq_1)');

% ---- Figure 4: Control signal ----
figure(4);
set(gca, 'fontsize', 18);
hold on
grid on
plot(t, u, 'LineWidth', 2);
plot(t_valtas, u(i), 'r*');
xlabel('Time [sec]');
ylabel('Torque [Nm]');
legend('u', 'Switch to linear controller');
title('Control Signal');

% ---- Figure 5: Phase portrait for q1 and q2 ----
figure(5);
set(gca, 'fontsize', 18);
hold on
grid on
plot(0, 0, 'square', 'MarkerFaceColor', 'green'); % Stable equilibrium
plot(180, 0, 'ro', 'MarkerFaceColor', 'red');    % Unstable equilibrium
plot(rad2deg(Q0(1)), Q0(3), '*', 'MarkerFaceColor', 'black'); % Initial state
plot(q1, q2, 'b');
xlabel('q_1 [degrees]');
ylabel('q_2 [degrees]');
legend('Stable equilibrium', 'Unstable equilibrium', 'Initial state');
title('Phase Portrait - q_1 vs q_2');

% ---- Figure 6: Ideal vs motor torque comparison ----
figure(6);
set(gca, 'fontsize', 18);
title('Comparison of Calculated and Actual Torque')
hold on
plot(t, u, 'LineWidth', 2);
plot(t, valos_torque, 'LineWidth', 2);
plot(t_valtas, u(i), 'r*');
xlabel('Time [sec]');
ylabel('Torque [Nm]');
legend('Ideal torque', 'Motor torque', 'Switch to linear controller');

% ---- Figure 7: Motor voltage and current ----
figure(7);
set(gca, 'fontsize', 18);

% Motor voltage subplot
subplot(2, 1, 1);
title('Measured Motor Voltage');
hold on
plot(t, motor_feszultseg, 'LineWidth', 2);
plot(t_valtas, motor_feszultseg(i), 'r*');
xlabel('Time [sec]');
ylabel('Voltage [V]');
legend('Motor voltage', 'Switch to linear controller');

% Motor current subplot
subplot(2, 1, 2);
title('Measured Motor Current');
hold on
motor_aram = reshape(motor_aram, [length(t), 1]);
plot(t, motor_aram, 'LineWidth', 2);
plot(t_valtas, motor_aram(i), 'r*');
xlabel('Time [sec]');
ylabel('Current [A]');
legend('Motor current', 'Switch to linear controller');
