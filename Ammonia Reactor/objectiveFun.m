function obj = objectiveFun(y)

    N_N2 = y(1);
    Tf   = y(2);
    Tg   = y(3);
    P    = y(4);
    L    = y(5);

    %% Solving the ODE system
    Length=[0 L];
    x0=[N_N2 Tf Tg P];

    [z, x]=ode45(@DEdef,Length,x0(1:4));
    plot(z,x(:,2:3)');grid on
    
    obj = 11.9877*10^6 - 1.710*10^4*x(1) - 699.3*x(2) + 704.04*x(3) - (3.4566*10^7 + 2.101 * 10^9 *z(end));
    obj = -obj;
    

end