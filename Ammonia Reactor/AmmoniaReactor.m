function xdot = AmmoniaReactor(x,y)

    Tf   = y(1);
    Tg   = y(2);
    N_N2 = y(3);

    %% parameters
    U     = 500;       % kcal/h*m2*K
    S1    = 10;        % m2 surf area of cat tubes per unit length
    S2    = 0.78;      % m2 cross-section of cat zone
    dH    = -26000;    % kcal/kg mol N2
    f     = 1.0;       % [-] cat activity
    Cp_f  = 0.707;     % kcal/Kg*K
    Cp_g  = 0.719;     % kcal/Kg*K
    R     = 1.987;     % kcal/kg/mol*K
    W     = 26400;     % kg/h
    N_N02 = W*0.2175;
    
    %% kinetics
    K1    = 1.78954*10^(4)*exp(-20800/(R*Tg));
    K2    = 2.5714*10^(16)*exp(-47400/(R*Tg));
    
    %% partial pressure
    p_N2  = 286*( N_N2/(1-2*(N_N02 - N_N2)) );
    p_H2  = 286*( 3*N_N2/(1-2*(N_N02 - N_N2)) );
    p_NH3 = 286*( 2*(N_N02 - N_N2)/(1-2*(N_N02 - N_N2)) );
    
    %% Model
    dTfdx = -U*S1/(W*Cp_f)*(Tg-Tf);
    dTgdx =  U*S1/(W*Cp_g)*(Tg-Tf) + (-dH)*S2/(W*Cp_g)*f*( K1*(1.5)*p_N2*p_H2/p_NH3 -K2*p_NH3/(1.5*p_H2) );
    dN2dx = -f*( K1*(1.5)*p_N2*p_H2/p_NH3 -K2*p_NH3/(1.5*p_H2) );
    
    xdot = [dTfdx; dTgdx; dN2dx];
    
end