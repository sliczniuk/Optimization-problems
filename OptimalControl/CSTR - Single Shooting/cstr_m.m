  function [dx, y] = cstr_m(t, x, u, p)
  
  F   = p(1);
  V   = p(2);
  k_0 = p(3);
  E   = p(4);
  R   = p(5);
  H   = p(6);
  HD  = p(7);
  HA  = p(8);
  
  % Output equations.
  y = [x(1);               ... % Concentration of substance A in the reactor.
       x(2)                ... % Reactor temperature.
      ];

  % State equations.
  dx = [F/V*(u(1)-x(1))-k_0*exp(-E/(R*x(2)))*x(1); ...
        F/V*(u(2)-x(2))-(H/HD)*k_0*exp(-E/(R*x(2)))*x(1)-(HA/(HD*V))*(x(2)-u(3)) ...
       ];
   
  end