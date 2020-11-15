clc, clear all

% Basic optimization of steady state binary distilation column
% The model take into account only the mass balances
% max purity of distilate by changing the R D and Vs
% the obj function is the max difference in concentration between top and
% bottom, so the biggest possible separation is achieved

% parameters
dpar.alpha = 1.5; dpar.n = 30; dpar.nf = 15; dpar.F = 1; dpar.zf = 0.5; dpar.q = 1; dpar.Vs = 3.2;
% process variables
dpar.R = 2.7; dpar.D = 0.5; 

x0 = 0.5*ones(1,dpar.n); nv = 1:dpar.n;
x0 = fsolve(@ssdist,x0,[],dpar); % steady-state to be used as initial conditions

for i = 1:length(x0), if x0(i) <= 0, x0(i) = -x0(i); end; end

y0 = [dpar.R dpar.D];

A = [];
b = [];
Aeq = [];
beq = [];
lb = [0.1 0.1];
ub = [5.0 0.9];
nonlcon = [];
options = optimoptions('fmincon','Display','iter');
x = fmincon(@fun,y0,A,b,Aeq,beq,lb,ub,nonlcon,options);

dpar.R = x(1);
dpar.D = x(2);

x1 = 0.5*ones(1,dpar.n); nv = 1:dpar.n;
x1 = fsolve(@ssdist,x1,[],dpar); % steady-state to be used as initial conditions

disp([x0(1), x0(end)])
disp([x1(1), x1(end)])

for i = 1:length(x1), if x1(i) <= 0, x1(i) = -x1(i); end; end
figure(); hold on; plot(x0); plot(x1); hold off; xlabel('N stage');ylabel('Molar frac of A');legend('befor opt','after opt');grid on

%%
function obj = fun(y)

    dpar.R = y(1);
    dpar.D = y(2);
    
    dpar.alpha = 1.5; dpar.n = 30; dpar.nf = 15; dpar.F = 1;
    dpar.zf = 0.5; dpar.q = 1; dpar.Vs = 3.2;
%    dpar.D = 0.5; 
%    dpar.R = 2.7;

    x0 = 0.5*ones(1,dpar.n);
    x = fsolve(@ssdist,x0,[],dpar);
    obj = -x(1)+x(end);

end