function Ya = YbPropToYa(Yb, L, H, f, rho0, c0)

    k  = 2*pi*f/c0;
    Z0 = rho0*c0;

    [M ~] = size(Yb);

    for m = 0 : M-1
        kxm(m+1) = Kx(f, m, H, c0);
    end
    
    Yc  = diag(kxm)/k/Z0;
    D2I = diag( -1i./sin(L*kxm) );
    D3I = diag( -1i./tan(L*kxm) );

    Ya  = D3I*Yc - D2I*Yc*inv(Yb + Yc*D3I)*Yc*D2I;  
end