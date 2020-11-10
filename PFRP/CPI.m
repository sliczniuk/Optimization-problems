function value = CPI(T)
% takes in temperature and gives the specific heat capacity value of inerts
    value = 15 + 0.05 * T + 5E-5 * T*T;
end