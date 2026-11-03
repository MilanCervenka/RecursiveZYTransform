function kx = Kx(f, m, h, c0)
    k  = 2*pi*f/c0;
    ky = m*pi/h;

    kx = sqrt(k^2 - ky^2);


    kx = conj(kx);
end