clc,clear all

% based on Himmelblau ex 13.5
%     N2 flow, Feed Temperature, Reacting Gas Temperature, Pressure, Reactor length
x0 = [326, 700, 700, 250, 2];
A = [];
b = [];
Aeq = [];
beq = [];
lb = [200, 400, 400, 100, 1];
ub = [3200, 800, 800, 400, 10];
nonlcon = [];
options = optimoptions('fmincon','Display','iter');
x = fmincon(@(y)objectiveFun(y),x0,A,b,Aeq,beq,lb,ub,nonlcon,options)

hold on
[Z, X]=ode45(@AmoniaReactor,[0 x(end)],x(1:4));
plot(Z,X(:,2:3));
[Z_def, X_def]=ode45(@AmoniaReactor,[0 x(end)],x0(1:4));
plot(Z_def,X_def(:,2:3)); grid on; xlabel('Reactor Length'); ylabel('Temperature')
legend( 'Feed Temperature', 'Reacting Gas Temperature', 'Feed Temperature before opt', 'Reacting Gas Temperature before opt')
hold off

figure()
hold on
plot(Z,X(:,1));
plot(Z_def,X_def(:,1)); grid on; xlabel('Reactor Length'); ylabel('Pressure')
hold off