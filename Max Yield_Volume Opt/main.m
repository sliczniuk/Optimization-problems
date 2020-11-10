clc, clear all,

x0 = [1,1,1,1];
A = [];
b = [];
Aeq = [1,1,1,1];
beq = [1e5];
lb = [0,0,0,0];
ub = [];
nonlcon = [];
options = optimoptions('fmincon','Display','iter');
x = fmincon(@(x)objectiveFun(x),x0,A,b,Aeq,beq,lb,ub,nonlcon,options)
SeriesOfReactors(x)