clc, clear all
%% Himmelblay Ex13.1

theta{1} = 2.0;       %[1/h]
theta{2} = 1.0;       %[1/h]
theta{3} = 0.2;       %[1/h]
theta{4} = 0.6;       %[1/h]

%%
x0 = [50 5.0 0 0];
tspan = [0 10];

% Results without optimization
[t,x] = ode45(@(t,x)IdealBatch(t,x,theta),tspan,x0);
%figure();plot(t,x);grid on;legend('Ca','Cb','Cc','Cd')
fprintf('Cb reach max concentration(%g [g/L]) at time %g [h] \n',max(x(:,2)),t(find(x(:,2)==max(x(:,2)))))

%%
