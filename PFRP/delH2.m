function value = delH2(T,Tref,delH2ref)
    value = delH2ref+ (2*CPC(T)-CPB(T))*(T-Tref);
end