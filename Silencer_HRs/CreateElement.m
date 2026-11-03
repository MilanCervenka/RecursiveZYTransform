function f = CreateElement(h, l, t, w, s, u, d, N1, rho0, c0)

    h0 = h+s+l;
    h1 = h;
    h2 = l;

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

    % admittance at the left and right side of HR
    YN2N2end = zeros(N2);

    IN2N2  = eye(N2);

    f = @evaluate;
    function YN1N1in = evaluate(f, YN1N1out)
       
        % transformation from x3 yo x2+
        YN2N2   = YbPropToYa(YN2N2end, u, h2, f, rho0, c0);
        YN1N1   = YbPropToYa(YN1N1out, u, h1, f, rho0, c0);
    
        % Position x2-
        YN0N0b  = (h1/h0)*QN0N1*YN1N1*QN1N0 + (h2/h0)*QN0N2*YN2N2*QN2N0;
        
        % Position x1+
        ZN0N0a  = YbPropToZa(YN0N0b, w, h0, f, rho0, c0);
        lpom   = t-u-w;
        Y2N2N2 = YbPropToYa(YN2N2end, -lpom, h2, f, rho0, c0);

        % Position x1-
        Z0N1N1 = QN1N0 * ZN0N0a * QN0N1;
        Z0N1N2 = QN1N0 * ZN0N0a * QN0N2;
        Z0N2N1 = QN2N0 * ZN0N0a * QN0N1;
        Z0N2N2 = QN2N0 * ZN0N0a * QN0N2;

        M1 = (h1/h0)* Z0N1N1;
        M2 = (h2/h0)* Z0N1N2;
        M3 = IN2N2 - (h2/h0)*Y2N2N2*Z0N2N2;
        M4 = (h1/h0)*Y2N2N2*Z0N2N1;
        ZN1N1 = M1 + M2*inv(M3)*M4;

        % Position x0: admittance recalculated to the beginning of the sidebranch
        YN1N1in = ZbPropToYa(ZN1N1, lpom+d, h1, f, rho0, c0);
    end

end