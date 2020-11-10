% to be used with ComplexPFRProblem.m

function dY= dYComplexPFRProblem(x,y,p)
global R;

% rate constants
k10     =   p(1);
EbyR1   =   p(2);
k20     =   p(3);
EbyR2   =   p(4);
k30     =   p(5);
EbyR3   =   p(6);

% delHref values,along with ref temperature
delH1ref   =   p(7);
delH2ref   =   p(8);
delH3ref   =   p(9);

Tref    =   p(10);

% number of moles of inert flowing.
FI      =   p(11);

%cooling coil properties, and cooling fludi temperature
U       =   p(12);
AbyV    =   p(13);
Tc      =   p(14);

% packed bed partcle dia,void fraction, bed diameter,
% and rho-in with Vs-in
Dp      =   p(15);
phi     =   p(16);
Dbed    =   p(17);
Rhoin   =   p(18);
Vsin    =   p(19);



FA = y(1);
FB = y(2);
FC = y(3);
T  = y(4);
Pnew = y(5);

% calculate pressure
P = Pnew * 10^5;

% Total number of moles
Ft = FA + FB+FC+FI;

% Volumetric flow rate
Q = Ft *R*T/P;

% Concentration of each species
CA = FA/Q; CB = FB/Q; CC = FC/Q;




% rate constants
k1 = k10*exp(-EbyR1/T);
k2 = k20*exp(-EbyR2/T);
k3 = k30*exp(-EbyR3/T);

% rate of each reaction
rate1 = k1 * CA;
rate2 = k2 * CB;
rate3 = k3 * CA * CA; % second order


% rate of formation of each species
rateA = -(rate1+rate3);
rateB = rate1 - rate2;
rateC = 2*(rate1 + rate3);


dY = zeros(5,1);

dY(1) = rateA;
dY(2) = rateB;
dY(3) = rateC;


% Next is heat balance, note that teh function is given in uppercase
% letters while the value is a mixture of upper and lower cases
% i.e. CpA vs CPA(T). I know that this is not good, but right now this
% works as an interim measure


CpA = CPA(T);
CpB = CPB(T);
CpC = CPC(T);
CpI = CPI(T);

delH1 = del_H1(T,Tref,delH1ref);
delH2 = del_H2(T,Tref,delH2ref);
delH3 = del_H3(T,Tref,delH3ref);


SumFCp = FA * CpA + FB * CpB + FC * CpC + FI * CpI;

term1=(rate1 * -delH1 + rate2 * -delH2 + rate3 * -delH3);
term2 = (U * AbyV * (T-Tc));
term3 = SumFCp;

dY(4) =  (term1 - term2) / term3;


% finally pressure balance

AreaBed = pi * Dbed * Dbed /4;
Vs = Q/AreaBed;
Grp = Dp * Rhoin * Vsin / (1-phi)/mu(T);

dpbydz = -(150/Grp + 1.75) * Rhoin * Vsin * Vs  * (1-phi)/Dp/phi^3;

dY(5) = dpbydz/10^5;        % convert P to Pnew

dY;
end

% to be used with ComplexPFRProblem.m

% Many oneline functions are given here.

% delH functions
% specific heat capacites
% viscosity

% delH functions

function value = del_H1(T,Tref,delH1ref)


value = delH1ref + (CPB(T)-CPA(T))*(T-Tref);
end

function value = del_H2(T,Tref,delH2ref)


value = delH2ref+ (2*CPC(T)-CPB(T))*(T-Tref);
end


function value = del_H3(T,Tref,delH3ref)


value = delH3ref+ (2*CPC(T)-CPA(T))*(T-Tref);
end


% specific heat capacities functions
function value = CPA(T)
% takes in temperature and gives the specific heat capacity value of A

value = 10 + 0.06 * T + 6E-5 * T*T;
end


function value = CPB(T)
% takes in temperature and gives the specific heat capacity value of B

value = 10 + 0.06 * T + 6E-5 * T*T;
end


function value = CPC(T)
% takes in temperature and gives the specific heat capacity value of C

value = 5 + 0.02 * T + 2E-5 * T*T;
end


function value = CPI(T)
% takes in temperature and gives the specific heat capacity value of inerts

value = 15 + 0.05 * T + 5E-5 * T*T;
end


% viscosity functions

function value = mu(T)
% takes in temperature and gives the viscosity of the gas

value = 1.5E-6 * T^1.5 / (T+100);
end





