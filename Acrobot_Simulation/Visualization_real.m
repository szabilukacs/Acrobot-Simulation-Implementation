close all;

% Valos robothoz

%run('getParameters.m');
%load('szimul1_LQR.mat'); % sikeres szabályozás
%load('Servo_motor_swing_up.mat');

% megkeresi, hogy hol valtott a kapcsolo
for i=1:length(t)
    if (switch_state(i)~=0)
        break
    end
end
t_valtas = t(i);

figure(1);
subplot(2,1,1)
title('Acrobot swing-up and balance')
hold on
plot(t,q1,'LineWidth',2);
plot(t,q2,'LineWidth',2);
plot(t_valtas,q1(i),'r*')
plot(t_valtas,q2(i),'r*')
xlabel('Idő [sec]')
ylabel('Szögelfordulás [fok]')
legend('q_1','q_2','Váltás a lineáris szabályzóra')

subplot(2,1,2)
title('Acrobot swing-up and balance')
hold on
plot(t,dq1,'LineWidth',2);
plot(t,dq2,'LineWidth',2);
plot(t_valtas,dq1(i),'r*')
plot(t_valtas,dq2(i),'r*')
xlabel('Idő [sec]')
ylabel('Szögsebesség [fok/sec]')
legend('dq_1','dq_2','Váltás a lineáris szabályzóra')

figure(2);
set(gca,'fontsize', 18) 
hold on
title('Az Acrobot energiája')
plot(t,E,'LineWidth',2);
line([0 35],[1.159 1.159],'Color','red','LineStyle','--')
xlabel('Idő [sec]')
ylabel('Energia [Joule]')
legend('E','Cél energia')


figure(3)
set(gca,'fontsize', 18) 
hold on
grid on
plot(0,0,'square','MarkerFaceColor','green');
plot(180,0,'ro','MarkerFaceColor','red');
plot(rad2deg(Q0(1)),Q0(3),'*','MarkerFaceColor','black');
plot(q1,dq1,'b');
xlabel('q_1 [fok]')
ylabel('dq_1 [fok/sec]')
legend('Stabil egyensúlyi pont', ...
    'Instabil egyensúlyi pont','Kezdőállapot')
title('Szögelfordulás - sebesség fázis portré')

figure(4)
set(gca,'fontsize', 18) 
hold on
grid on
plot(t,u,'LineWidth',2);
plot(t_valtas,u(i),'r*')
xlabel('Idő [s]')
ylabel('Nyomaték [Nm]')
legend('u','Váltás a lineáris szabályzóra')
title('Vezérlőjel')

figure(5)
set(gca,'fontsize', 18) 
hold on
grid on
plot(0,0,'square','MarkerFaceColor','green');
plot(180,0,'ro','MarkerFaceColor','red');
plot(rad2deg(Q0(1)),Q0(3),'*','MarkerFaceColor','black');
plot(q1,q2,'b');
legend('Stabil egyensúlyi pont', ...
    'Instabil egyensúlyi pont','Kezdőállapot')
xlabel('q_1 [fok]')
ylabel('q_2 [fok]')
title('q_1 és q_2 szög fázis portré')

figure(6)
set(gca,'fontsize', 18) 
title('Kiszámított és valós nyomaték összehasonlítása')
hold on
plot(t,u,'LineWidth',2);
plot(t,valos_torque,'LineWidth',2);
plot(t_valtas,u(i),'r*')
xlabel('Idő [sec]')
ylabel('Nyomaték [Nm]')
legend('Ideal torque','motor torque','Váltás a lineáris szabályzóra')


figure(7)
set(gca,'fontsize', 18) 
motor_aram = reshape(motor_aram,[length(t),1]);
subplot(2,1,1)
title('Motoron mért feszültség')
hold on
plot(t,motor_feszultseg,'LineWidth',2);
plot(t_valtas,motor_feszultseg(i),'r*')
xlabel('Idő [sec]')
ylabel('Feszültség [V]')
legend('Motor voltage','Váltás a lineáris szabályzóra')

subplot(2,1,2)
title('Motoron mért áramerősség')
hold on
plot(t,motor_aram,'LineWidth',2);
plot(t_valtas,motor_aram(i),'r*')
xlabel('Idő [sec]')
ylabel('Áramerősség [A]')
legend('Motor current','Váltás a lineáris szabályzóra')



