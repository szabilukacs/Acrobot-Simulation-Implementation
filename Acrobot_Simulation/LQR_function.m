function [K] = LQR_function(A,B)

C = eye(4);
D = zeros(4,1);

Co = ctrb(A,B)

Q = [1 0 0 0;
      0 1 0 0;
      0 0 1 0;
      0 0 0 1];

R = 100;

P = are(A,B*inv(R)*B',Q);

[K,S,CLP] = lqr(A,B,Q,R) % CLP closed loop poles

% q1 q2 dq1 dq2 

A_szab = A - B*K; % closed loop
B_szab = zeros(size(B));

%{
%% Szimulalas

% q1 q2 dq1 dq2 
epsz = 0.02;
x0 = [epsz -2*epsz 0 0]; % kis elteresekre

% Nyilt rendszer szimulacioja
t = 0:0.1:1;
u = zeros(size(t)); % zero bemenet bemenetre
figure(1);
[y,t,x] = lsim(ss(A,B,C,D),u,t,x0);
plot(t,x)
legend('q1','q2','dq1','dq2');

% Zart rendszer szimulacioja
t = 0:0.1:10;
u = zeros(size(t)); % zero bemenet
figure(2);
[y,t,x] = lsim(ss(A_szab,B_szab,C,D),u,t,x0);
plot(t,x)
legend('q1','q2','dq1','dq2');

u = -K*x';

figure(3);
plot(t,u);
%}

end