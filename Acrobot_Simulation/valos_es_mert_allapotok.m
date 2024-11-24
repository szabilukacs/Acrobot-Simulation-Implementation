% Valos es mert allapotok

close all;

run('getParameters')

Ts = 0.0005; % legalabb ennyi legyen

t_diszkret = Ts:Ts:length(q1_m)/2000;

figure(1);
subplot(4,1,1);
hold on;
plot(t,q1_v);
plot(t_diszkret,q1_m);
legend('valos','mert');
subplot(4,1,2);
hold on;
plot(t,dq1_v);
plot(t_diszkret,dq1_m);
subplot(4,1,3);
hold on;
plot(t,q2_v);
plot(t,q2_m);
subplot(4,1,4);
hold on;
%smoothq2 = smoothdata(dq2_v,'sgolay');
plot(t,dq2_v);
plot(t,dq2_m);

%figure(2);
%plot(t,smoothq2);







