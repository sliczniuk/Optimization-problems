% Fairly complex problem, has exothermic reaction,cooling coils, multiple
% reactions, pressure drop, variable specific heat capacity, variable
% viscosity...
% Author S. Ramanathan, (C) 2014
%


% Reactions are A --> B , B --> 2C and A --> 2C
% rate constants are k1, k2 and k3.
% heat of reactions are delH1, delH2 and delH3

% specific heat capacities are CPA(T), CPB(T) and CPC(T) and CPI(T),
% where A, B and C are species related to the reactions and I is
% an inert.
clear all;
close all;

global R ;

R = 8.314; %universal gas constant

Ftin = 20; % total molar flow rate in gmol/s
Pin = 10^6; %Pa, inlet pressure
Tin = 400; %K, inlet temperature


% mole fractions of A, B, C and inerts at the inlet are given below.

MFAin = 0.50;
MFBin = 0.25;
MFCin = 0;
MFIin = 0.25;



MWA = 60; %moleculare weight of A , in g/gmol
MWB = 60; %moleculare weight of B , in g/gmol
MWC = 30; %moleculare weight of C , in g/gmol
MWI = 28; %moleculare weight of inerts , in g/gmol

Tref = 300; %K This is the temperature at which heats of reactions are specified.

delH1ref = -1000; %J/mol
delH2ref = -12000; %J/mol
delH3ref = -13000; %J/mol

% kinetic parameters

k10 = 1E3;
EbyR1 =4000;
k20 = 1e5;
EbyR2 = 5500;
k30 = 5e1;
EbyR3 = 3500;


U = 2E2; % W/m2/K
A = 2; %m2, area of the coil
Dbed = 0.2; %m, packed bed diameter
Lbed = 6; %m , packed bed length
Tc = 300; % K, temperature of cooling fluid, assumed to be roughly a constant.

Dp = 0.003; %m, particle dia, in the packed bed.
phi = 0.4; % void fraction


NumPoints = 20;% Number of intermediate points in the integration and plotting

%%% Input ends here



Vbed = pi * Dbed * Dbed / 4 * Lbed;
AbyV = A/Vbed;

Vinterval = Vbed/NumPoints;
Vset = 0:Vinterval:Vbed;


% molar flow rates of each species at the inlet
FAin = MFAin * Ftin;
FBin = MFBin * Ftin;
FCin = MFCin * Ftin;
FIin = MFIin * Ftin;

% Average molecular weight at the inlet
MWAv = MWA * MFAin + MWB * MFBin + MWC * MFCin + MWI * MFIin;


Qin = Ftin*R*Tin/Pin;

disp(['At the inlet, the volumetric flow rate is ' num2str(Qin) ' m^3/s']);
Rhoin = Ftin*MWAv/Qin/1000; % 1000 convers gmol to kg mol
 disp(['At the inlet, the gas density is ' num2str(Rhoin) ' kg/m^3']);
 
 AreaBed = pi * Dbed * Dbed / 4;
 Vsin = Qin/AreaBed;

 Pnewin = Pin/1e5;
 
 % Parameters to be given to the derivative function
 
 % rate constants
p(1) = k10     ;
p(2) = EbyR1   ; 
p(3) =  k20    ; 
p(4) =  EbyR2  ;
p(5) =  k30    ; 
p(6) = EbyR3   ;

% delHref values,along with ref temperature
p(7) = delH1ref   ;
p(8) = delH2ref   ;
p(9) = delH3ref   ;

p(10) = Tref    ; 

% number of moles of inert flowing.
p(11) =    FIin      ;

%cooling coil properties, and cooling fludi temperature
p(12) = U       ;
p(13) = AbyV    ;
p(14) = Tc      ;

% packed bed partcle dia,void fraction, bed diameter,
% and rho-in with Vs-in
p(15) = Dp      ;
p(16) = phi     ;
p(17) = Dbed    ;
p(18) = Rhoin   ;
p(19) = Vsin    ;


% Initial conditions
y_init = [FAin;FBin;FCin;Tin;Pnewin];

options = odeset('RelTol',1e-3,'AbsTol', 1e-3);
[Vsetnew,Ysetnew]=ode45(@(x,y)dYComplexPFRProblem(x,y,p),Vset,y_init,options);


Faset = Ysetnew(:,1);
Fbset = Ysetnew(:,2);
Fcset = Ysetnew(:,3);
Tempset = Ysetnew(:,4);
Pressureset = Ysetnew(:,5);

                newfig1 = figure; set(gcf,'color','w');
                plot(Vsetnew,Faset,'-ob');hold on;
                plot(Vsetnew,Fbset,'--sr');
                plot(Vsetnew,Fcset,'-^k');
                xlabel('Volume m^3');
                ylabel('Molar Flow Rate (mol/s)');
                
                title('Molar flow rate vs Reactor Volume (m^3)');
                legend('F_A','F_B','F_C');
                newfig2 = figure;set(gcf,'color','w');
                plot(Vsetnew, Tempset,'-bo');
                title('Temperature (K) vs Reactor Volume (m^3)');
                xlabel('Volume m^3');
                ylabel('Temperature (K)');
                
                newfig3 = figure;set(gcf,'color','w');
                plot(Vsetnew, Pressureset,'-bo');
                title('Presssure(atm) vs Reactor Volume (m^3)');
                    xlabel('Volume m^3');
                ylabel('Pressure (atm)');
                
