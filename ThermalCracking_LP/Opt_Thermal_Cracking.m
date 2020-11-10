clc, clear all

%% Himmelblau Ex 13.3

%% 7 variables in the equations
variables = {'x1','x2','x3','x4','x5','x6','x7'};
N = length(variables); 

%% create variables for indexing 
for v = 1:N 
   eval([variables{v},' = ', num2str(v),';']); 
end

%% lower bound
lb = zeros(size(variables));
lb([x1 x2 x3 x4 x5 x6 x7]) = [zeros(1,N)];

%% upper bound
ub = Inf(size(variables));
ub([]) = [];

%% create the A matrix as a 3-by-7 zero matrix, 
% corresponding to 3 linear inequalities in 16 variables. Create the b vector with three components.
A = zeros(3,N);
A(1,x1) = 1.1;  A(1,x2) = 0.9 ; A(1,x3) = 0.9 ; A(1,x4) = 1.0 ; A(1,x5) = 1.1 ; A(1,x6) = 0.9 ; b(1) = 200000;
A(2,x1) = 0.5;  A(2,x2) = 0.35; A(2,x3) = 0.25; A(2,x4) = 0.25; A(2,x5) = 0.5 ; A(2,x6) = 0.35; b(2) = 50000;
A(3,x1) = 0.01; A(3,x2) = 0.15; A(3,x3) = 0.15; A(3,x4) = 0.18; A(3,x5) = 0.01; A(3,x6) = 0.15; b(3) = 20000;

%% 3 linear equations
Aeq = zeros(3,N); beq = zeros(3,1);
Aeq(1,[x1,x2,x3,x4,x5,x6]) = [0.4, 0.06, 0.04, 0.05, -0.6, 0.06];
Aeq(2,[x2,x3,x4,x6]) = [0.1, 0.01, 0.01, -0.9];
Aeq(3,[x1,x2,x3,x4,x5,x6,x7]) = [-6857.6, 364, 2032, -1145, -6857.6, 364, 21520]; b(3)=20000000;

%% expression as a vector f of multipliers of the x vector
f = zeros(size(variables));
f([x1 x2 x3 x4 x5 x6]) = [2.84 -0.22 -3.33 1.09 9.39 9.51];

%% Solve the Problem
options = optimoptions('linprog','Algorithm','dual-simplex');
[x fval] = linprog(-f,A,b,Aeq,beq,lb,ub,options);
for d = 1:N
  fprintf('%12.2f \t%s\n',x(d),variables{d}) 
end
fval
