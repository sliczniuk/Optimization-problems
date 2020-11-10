function Res = SeriesOfReactors(x)
%%    
    n  = 2.5;
    k  = 0.00625;
    q  = 71;
    c4 = 0.3961;

%%
    V1 = x(1);
    V2 = x(2);
    V3 = x(3);
    V4 = x(4);
    
%%
    c3 = c4 + (V4/q)*k*c4^n;
    c2 = c3 + (V3/q)*k*c3^n;
    c1 = c2 + (V2/q)*k*c2^n;
    c0 = c1 + (V1/q)*k*c1^n;
    
%%
    Res = [c0 c1 c2 c3 c4];
    
end