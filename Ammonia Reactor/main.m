clc,clear all

x0 = [326, 515, 515, 250, 2];
A = [];
b = [];
Aeq = [];
beq = [];
lb = [200, 400, 400, 100, 1];
ub = [800, 700, 700, 400, 3];
nonlcon = [];
options = optimoptions('fmincon','Display','iter');
x = fmincon(@(y)objectiveFun(y),x0,A,b,Aeq,beq,lb,ub,nonlcon,options)

hold on
[Z, X]=ode45(@DEdef,[0 x(end)],x(1:4));
plot(Z,X(:,2:3));
[Z_def, X_def]=ode45(@DEdef,[0 x(end)],x0(1:4));
plot(Z_def,X_def(:,2:3)); grid on
hold off

figure()
hold on
plot(Z,X(:,1));
plot(Z_def,X_def(:,1)); grid on
hold off