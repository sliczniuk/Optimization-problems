function [xout, uout] = singleShooting(OCP, x0, yd)

import casadi.*

OCP_solver = casadi.Opti();
%OCP_solver.solver('ipopt')

% http://www.diva-portal.se/smash/get/diva2:956377/FULLTEXT01.pdf
nlp_opts = struct;
nlp_opts.ipopt.max_iter = 100;
%nlp_opts.ipopt.acceptable_iter = 50;
%nlp_opts.ipopt.acceptable_tol = 1e-6;
%nlp_opts.ipopt.tol = 1e-7;
ocp_opts = {'nlp_opts', nlp_opts};

OCP_solver.solver('ipopt',nlp_opts)

U = OCP_solver.variable(OCP.Nu,OCP.N);
X = [MX(x0) zeros(OCP.Nx,OCP.N)];
J = 0;
for j=1:OCP.N
    J=J+OCP.L(U(:,j));
    X(:,j+1)=OCP.F(X(:,j),U(:,j));
end
J = J + OCP.Lf(X(:,end),yd);

% for nx=1:OCP.Nx
%     OCP_solver.subject_to(OCP.x_lu(nx,1)<=X(nx,:)<= OCP.x_lu(nx,2));
% end

for nu=1:OCP.Nu
    OCP_solver.subject_to(OCP.u_lu(nu,1)<=U(nu,:)<= OCP.u_lu(nu,2));
end

OCP_solver.minimize(J);
OCP_solver.set_initial(U,repmat([0; 300; 300],1,OCP.N) );

% https://github.com/casadi/casadi/issues/2138 or CasADi doc 9.3
try
    sol = OCP_solver.solve();
    uout = sol.value(U);
catch
    uout = OCP_solver.debug.value(U);
end

xout = 1;
end