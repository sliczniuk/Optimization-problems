function value = CPB(T)
% takes in temperature and gives the specific heat capacity value of B
    value = 10 + 0.06 * T + 6E-5 * T*T;
end