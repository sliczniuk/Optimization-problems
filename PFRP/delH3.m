function value = delH3(T,Tref,delH3ref)
    value = delH3ref+ (2*CPC(T)-CPA(T))*(T-Tref);
end