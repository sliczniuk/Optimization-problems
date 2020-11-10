function value = delH1(T,Tref,delH1ref)
    value = delH1ref + (CPB(T)-CPA(T))*(T-Tref);
end