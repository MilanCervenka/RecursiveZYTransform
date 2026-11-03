function f = CreateElement(h, w, l, d, N1, rho0, c0)

    h0 = h + l;
    h1 = h;
    N0 = ceil(N1*h0/h1);

    QN1N0 = zeros(N1, N0);
    for n1=0 : N1-1
        for n0=0 : N0-1
            QN1N0(n1+1,n0+1) = FillQNM(n1, n0, h1, h0);
        end
    end
    QN0N1  = QN1N0';

    f = @evaluate;
    function YN1N1in = evaluate(f, YN1N1out)
       
        % (x2-): admittance recalculated to the end of the sidebranch
        YN0N0 = (h1/h0)*QN0N1*YN1N1out*QN1N0;

        % (x1+): admittance recalculated to the beginning of the sidebranch
        ZN0N0 = YbPropToZa(YN0N0, w, h0, f, rho0, c0);
        
        % (x1-): admittance recalculated to the waveguide
        ZN1N1 = (h1/h0)*QN1N0*ZN0N0*QN0N1;

        % (x0): admittance recalculated to the beginning of the sidebranch
        YN1N1in = ZbPropToYa(ZN1N1, d, h1, f, rho0, c0);
    end

end