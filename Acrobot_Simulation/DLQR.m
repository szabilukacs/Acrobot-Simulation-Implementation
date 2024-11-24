%DLQR

%% Acrobot linearized LQR Control

close all;
clc;

run('real_parameters.m');

% q1 q2 dq1 dq2 
[A,B] = linearizalas(m1,m2,l1,l2,lc1,lc2,J1,J2)
C = eye(4);
D = zeros(4,1);

Ts = 0.04; % 40 ms-al mintavetelezve
%u = zeros(length(t),2); % B ha 0 akkor mindegy
sys = ss(A,B,C,D);
sys_d = c2d(sys,Ts,'zoh')

A_d = sys_d.A;
B_d = sys_d.B;
C_d = sys_d.C;
D_d = sys_d.D;


Co = ctrb(A_d,B_d)


Q = [1 0 0 0;
      0 1 0 0;
      0 0 1 0;
      0 0 0 1];

R = 100;

%{
Q = 100*[10 -5 0 0;
        -5 10 0 0;
        0 0 10 -5;
        0 0 -5 10];

R = 1000;
%}

%P = dare(A_d,B_d,Q,R);

P = D_schur_modszer(A_d,B_d,R,Q)

[K,S,CLP] = dlqr(A_d,B_d,Q,R) % CLP closed loop poles

K = inv(R+B_d'*P*B_d)*B_d'*P*A_d

% q1 q2 dq1 dq2 

A_szab = (A_d - B_d*K); % closed loop
B_szab = zeros(size(B_d));

sys_zart = ss(A_szab,B_szab,C_d,D_d,Ts);



%% Szimulalas

% q1 q2 dq1 dq2 
epsz = 0.02;
x0 = [epsz -2*epsz 0 0]; % kis elteresekre

% Nyilt rendszer szimulacioja
t = 0:Ts:2;
u = zeros(size(t)); % zero bemenet bemenetre
figure(1);
[y,x] = dlsim(A_d,B_d,C_d,D_d,u,x0);
plot(t,x)
legend('q1','q2','dq1','dq2');

% Zart rendszer szimulacioja

% szimulacio a szabalyozott rendszerre
figure(2);

[y_szab,x_szab] = dlsim(A_szab,B_szab,C_d,D_d,u,x0);

plot(t,y_szab);
title('Szimuláció szabalyzóval')
legend('q1','q2','dq1','dq2')
xlabel('Idő [sec]')


u = -K*x_szab';

figure(3);
plot(t,u);

figure(4)
pzplot(sys_d)
title('Nyílt rendszer pólusai')
figure(5)
pzplot(sys_zart)
title('Zárt rendszer pólusai')







