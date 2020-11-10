function obj = objectiveFun(x)

    Res = SeriesOfReactors(x);
    obj = abs(20-Res(1));

end