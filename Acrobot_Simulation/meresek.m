% Meresek

clear all;
close all;
clc
% megcsinalni meg for-ba
file = fopen('Meresek/meresuj16.txt','r');

formatSpec = '%f,%f,%f';
sizeA = [3 Inf];

fileData = fscanf(file,formatSpec,sizeA);

fileData = fileData';
fclose(file);

q1 = fileData(:,1); % usec
dq1 = fileData(:,2);
u = fileData(:,3);

%q1 = fileData(400:4800,1); % usec
%dq1 = fileData(:,2);
%u = fileData(400:4800,3);

figure(1);
grid on
plot(q1,'LineWidth',2);
legend('q_1');
ylabel('fok');
xlabel('Mérési minták');
title('1. Csukló szögelfordulás')

figure(2);
grid on
plot(u,'LineWidth',2);
legend('u');
ylabel('fok');
xlabel('Mérési minták');
title('Vezérlőjel')


return

figure(1);
subplot(3,1,1);
grid on
plot(q1);
legend('q_1');
ylabel('fok');
xlabel('Mérési minták');

subplot(3,1,2);
plot(dq1);
legend('dq_1');
ylabel('fok/sec');
xlabel('Mérési minták');

subplot(3,1,3);
plot(u);
grid on;
legend('u')
ylabel('fok');
xlabel('Mérési minták');






