function result = Silencer_250_500()

% speed of sound and density
c0   = 343;
rho0 = 1.2;

% number of resinators
Nsb = 6;

% width of the main waveguide (m)
h   = 15e-2;

% width of the sidebranches (m)
w = h/2;

% lengths of the sidebtanches (m)
% optimization result
lsbs  = [2.748e-01 1.490e-01 3.234e-01 2.470e-01 2.103e-01 1.831e-01];

% separation distance between the centres of the sidebranches (m)
d = 5e-3;

% number of modes in the main waveguide
N1 = 8;

% cut on frequency
fcut = c0/2/h;
% characteristic impedance
Z0   = rho0*c0;

% calculation at these frequencies
df = 1;
freqs = 1:df:fcut-1;

% initialize objects with individual resonators
Element = cell(1, Nsb);
for isb=1 : Nsb
    Element{isb} = CreateElement(h, w, lsbs(isb), d, N1, rho0, c0);
end

% calculation of transmission properties
for ind = 1 : length(freqs)
    f = freqs(ind);
    k = 2*pi*f/c0;

    for n1 = 0 : N1-1
        pom(n1+1) = Kx(f, n1, h, c0);
    end
    % admittance just behind the last element
    % (characteristic modal admittance)
    KN1N1   = diag(pom);
    YN1N1out = KN1N1/k/Z0;

    for isb = Nsb:-1:1

        YN1N1in = Element{isb}(f, YN1N1out);
        YN1N1out  = YN1N1in;

    end

    % calculating the reflection coefficient
    Rn = diag( inv(KN1N1+k*Z0*YN1N1in)*(KN1N1-k*Z0*YN1N1in) );
    Rcoef(ind) = abs( Rn(1) );

    % Transmission coefficient
    Tcoef(ind) = sqrt(1 - Rcoef(ind)^2);

    % Transmission loss
    TL(ind) = -20*log10(Tcoef(ind));
end
     
result =[freqs' Tcoef'];

end % function




