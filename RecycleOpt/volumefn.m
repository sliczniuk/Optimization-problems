% Author, S. Ramanathan, (2013) CH5010 CRT example
% Recycle ratio optimization for a particular kinetics

% usage, change the matlab working directory to the 
% current directory, then type 
% fminsearch('volumefn',1)
% Here, 1 is the seed value for the recycle ratio
% 
% 


function value = volumefn(R,p)

xend=p(1);
k1=p(2);
k2=p(3);
Cain=p(4);
Q=p(5)  ;

Fain = Q * Cain;

term1 = -1/(k1 * Cain)*log(1-xend) ...
    + k2 * Cain / k1 * xend ...
    - k2 * Cain * xend*xend/2/k1;

xin = R * xend/(R+1);
term2 = -1/(k1 * Cain) * log(1-xin)...
    + k2 * Cain / k1 * xin ...
    - k2 * Cain * xin * xin / 2/ k1;

value = (R+1)*Fain*(term1-term2);

value;
end