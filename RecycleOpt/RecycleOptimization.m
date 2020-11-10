% Author S. Ramanathan
% (C) 2013
% CH5010,CRT example

% Usage:  Make matlab working directory the current directory
% and then run this code. This code needs another matlab file
% 'volumefn.m'

clear all;
close all;


% This is recycle ratio optimization for 'unusual kinetics'

% Recycle reactor, kinetics k1CA/(1+K2CA^2);

xend = 0.95; % final conversion desired
k1 = 0.01; % rate constant, s-1
k2 = 30 ; %rate constant, lit^2/mol^2

Cain = 1;% inlet concentration,  mol/lit
Q = 10; %volumetric flow rate, lit/s

p(1)=xend;
p(2)=k1;
p(3)=k2;
p(4)=Cain;
p(5) = Q;

OptimalR = fminsearch(@(x)volumefn(x,p),1);

disp('Optimal Recycle ratio is ');
disp(OptimalR);