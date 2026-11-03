function Ya = ZbPropToYa(Zb, L, H, f, rho0, c0)
    
    k  = 2*pi*f/c0;
    Z0 = rho0*c0;

    [M ~] = size(Zb);

    for m = 0 : M-1
        kxm(m+1) = Kx(f, m, H, c0);
    end

    Yc  = diag(kxm)/k/Z0;
    Zc  = diag(k*Z0./kxm);
    D1I = diag( 1./cos(L*kxm) );
    D3 = diag( 1i*tan(L*kxm) );

    Ya  = D3*Yc + D1I*inv(Zb + Zc*D3)*D1I;  

end