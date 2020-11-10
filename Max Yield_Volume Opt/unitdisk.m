function [c,ceq] = unitdisk(x)
    Res = SeriesOfReactors(x);
    c = [Res(1), Res(end)];
    ceq = [20, 15];
end