function value = CPC(T)
% takes in temperature and gives the specific heat capacity value of C
    value = 5 + 0.02 * T + 2E-5 * T*T;
end