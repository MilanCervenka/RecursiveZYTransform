function result = Silencer_500_750()

% speed of sound and density
c0   = 343;
rho0 = 1.2;

% width of main waveguide (m)
h = 15e-2;

% length of the neck (m)
s = 1e-2;
% width of the neck (m)
w = 2e-2;
% separation distance between individual resonators (m)
d = 5e-3;

% number of the resonators
Nsb = 6;

% dimensions of the resonators (m)
% optimization result
lhr = [5.511e-02 6.237e-02 7.862e-02 5.110e-02 6.980e-02 6.064e-02];
thr = lhr; 
u = (thr-w)/2; 

% No. of modes in main duct
N1 = 18;              

fcut = c0/2/h;
Z0   = rho0*c0;

% calculation at these frequencies
df = 1;
freqs = 1:df:fcut-1;

% initialize objects with individual resonators
Element = cell(1, Nsb);
for isb=1 : Nsb
    Element{isb} = CreateElement(h, lhr(isb), thr(isb), w, s, u(isb), d, N1, rho0, c0);
end

% calculation of transmission properties
for ind = 1 : length(freqs)
    f = freqs(ind);
    k = 2*pi*f/c0;

    pom = zeros(1, N1);
    for n1 = 0 : N1-1
        pom(n1+1) = Kx(f, n1, h, c0);
    end
    % admittance just behind the last element
    KN1N1   = diag(pom);
    YN1N1out = KN1N1/k/Z0;

    for isb = Nsb : -1 : 1
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
   




