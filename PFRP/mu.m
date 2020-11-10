% viscosity functions

function value = mu(T)
% takes in temperature and gives the viscosity of the gas
    value = 1.5E-6 * T^1.5 / (T+100);
end
