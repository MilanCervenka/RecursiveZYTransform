function Za = ZbPropToZa(Zb, L, H, f, rho0, c0)

    k  = 2*pi*f/c0;
    Z0 = rho0*c0;

    [M ~] = size(Yb);

    for m = 0 : M-1
        kxm(m+1) = Kx(f, m, H, c0);
    end
    
    Zc  = diag(k*Z0./kxm);
    D2I = diag( -1i./sin(L*kxm) );
    D3I = diag( -1i./tan(L*kxm) );

    Za  = D3I*Zc - D2I*Zc*inv(Zb + Zc*D3I)*Zc*D2I;  
end