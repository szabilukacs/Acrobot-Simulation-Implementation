% Get parameters from acrobot simulink

m1 = out.m1.Data(1);
m2 = out.m2.Data(2);
lc1 = l1/2 + out.lc1.Data(2,1,1);
lc2 = l2/2 - out.lc2.Data(2,1,1);
J1 = out.J1matrix.Data(1,1,1);
J2 = out.J2matrix.Data(1,1,1);

t = out.tout;

% valtas_t = 28.13649;
rad_valt = 360/(2*pi);

q1_v = out.q1_v.Data;  % rad
dq1_v = out.dq1_v.Data;
q2_v = out.q2_v.Data;
dq2_v= out.dq2_v.Data;

%q1_m = out.q1_m.Data; % for the encoder
%dq1_m = out.dq1_m.Data; % for the encoder

q1 = rad2deg(q1_v);  % degree
dq1 = rad2deg(dq1_v);
q2 = rad_valt*(q2_v);
dq2 = rad_valt*(dq2_v);

%q1_m = rad2deg(q1_m); % for the encoder
%dq1_m = rad_valt*(dq1_m); % for the encoder

u = out.u.Data;
u_torque = out.u_torque.Data;
noise_ = out.noise.Data;
switch_state = out.switch_controller_state.Data;
E = out.E.Data;

motor_feszultseg = out.motor_feszultseg.Data;
motor_aram = out.motor_aram.Data;
valos_torque = out.valos_torque.Data;




















