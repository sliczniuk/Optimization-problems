function xdot = IdealBatch(t,x,theta)
 
    Ca = x(1);
    Cb = x(2);
    Cc = x(3);
    Cd = x(4);

%% Reaction parameters
    k1 = theta{1};
    k2 = theta{2};
    k3 = theta{3};
    k4 = theta{4};
    
%% Reaction kinetics 
    dCadt = -k1*Ca+k2*Cb;
    dCbdt = +k1*Ca-(k2+k3+k4)*Cb;
    dCcdt = +k3*Cb;
    dCddt = +k4*Cb;

    xdot = [dCadt dCbdt dCcdt dCddt]';
    
end