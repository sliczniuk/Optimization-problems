clc, clear all

T = 300;
P = 1;
x0 = [T P];
options = optimset('MaxFunEvals',100000,'MaxIter',100000) ;
x = fminsearch(@fun,x0,options);

Vspan = [0 2]; % Range for the volume of the reactor 
y0 = [1; 1; 0; 0]; % Initial values for the dependent variables i.e Fa,Fb,and Fc, Fd
[v_opt, y_opt] =ode15s(@(v,y) Designequation(v,y,x(1),x(2)),Vspan,y0);
plot(v_opt,y_opt')

function obj = fun(x,y0)
  T = x(1);
  P = x(2);
  Vspan = [0 2]; % Range for the volume of the reactor 
  y0 = [1; 1; 0; 0]; % Initial values for the dependent variables i.e Fa,Fb,and Fc, Fd
  [v, y] =ode15s(@(v,y) Designequation(v,y,T,P),Vspan,y0);
  obj = y(end,3);
    
end
function dYdV = Designequation(v,y,T,P) 
  Fa = y(1); 
  Fb = y(2); 
  Fc = y(3);
  Fd = y(4);
  
  % Explicit equations
  Cto = P / (8.314 * 10^-5) / T; 
  E1 = 15000; 
  E2 = 17500;
  Ft = Fa + Fb + Fc + Fd; 
  Ca = Cto * Fa / Ft;
  Cb = Cto * Fb/Ft;
  Cc = Cto * Fc/Ft;
  Cd = Cto * Fd/Ft;
  k1 = 0.075 * exp(E1 /1.987 * (1/300 - (1/T)));
  k2 = 0.0015 * exp(E2 / 1.987 * (1 / 300 - (1 / T))); 
  Fao = 50;  
  ra = -k1*Ca*Cb;
  rb = -k2*Cb*Cc;
  
  % Differential equations
  dFadV = ra; 
  dFbdV = (2*ra)+rb; 
  dFcdV = rb-ra;
  dFddV = -rb;
  dYdV = [dFadV; dFbdV; dFcdV; dFddV];
  
end