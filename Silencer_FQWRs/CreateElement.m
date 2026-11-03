function f = CreateElement(h, w, l, wn, s, d, N1, rho0, c0)

    h0 = h+w+s;
    h1 = h;
    h2 = w;

    N0 = ceil(N1*h0/h1);
    N2 = ceil(N1*h2/h1);
    
    QN1N0 = zeros(N1, N0);
    for n1=0 : N1-1
        for n0=0 : N0-1
            QN1N0(n1+1,n0+1) = FillQNM(n1, n0, 0, h1, h0);
        end
    end
    QN0N1  = QN1N0';

    QN2N0 = zeros(N2, N0);
    for n2=0 : N2-1
        for n0=0 : N0-1
            QN2N0(n2+1,n0+1) = FillQNM(n2, n0, h1+s, h2, h0);
        end
    end
    QN0N2  = QN2N0';

    % admittance at the end of the folded sidebranch
    YN2N2end = zeros(N2);

    f = @evaluate;
    function YN1N1in = evaluate(f, YN1N1out)
       
        % position (x=x2+)
        if (l-w > 0)
            YN2N2 = YbPropToYa(YN2N2end, l-w, h2, f, rho0, c0);
            YN1N1 = YbPropToYa(YN1N1out,  l-w, h1, f, rho0, c0);
        else
            YN2N2 = YN2N2end;
            YN1N1 = YN1N1out;
            fprintf("\nWarning: l-w <= 0!\n");
        end
    
        % position (x=x2-)
        YN0N0a  = (h1/h0)*QN0N1*YN1N1*QN1N0 + (h2/h0)*QN0N2*YN2N2*QN2N0;
        
        % position (x=x1+)
        ZN0N0b  = YbPropToZa(YN0N0a, w, h0, f, rho0, c0);

        % impedance recalculated to the waveguide
        % position (x=x1-)
        ZN1N1 = (h1/h0)*QN1N0*ZN0N0b*QN0N1;

        % admittance recalculated to the beginning of the sidebranch
        % position (x=x0)
        YN1N1in = ZbPropToYa(ZN1N1, d, h1, f, rho0, c0);
    end

end