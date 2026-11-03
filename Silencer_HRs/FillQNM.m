function qnm = FillQNM(n, m, yn, hn, H)
    
    eps = 1e-8;

    if (n==0)&&(m==0)
        qnm = 1;
    elseif (n>0)&&(m==0)
        qnm = 0;
    elseif (n==0)&&(m>0)
        pom = sin(m*pi*(yn+hn)/H) - sin(m*pi*yn/H);
        qnm = sqrt(2)*H*pom/(m*pi*hn);
    else
        jmen = pi*((m*hn)^2-(n*H)^2);
        if abs(jmen) > eps
            pom = ((-1)^n)*sin(m*pi*(yn+hn)/H) - sin(m*pi*yn/H);
            qnm = 2*m*H*hn*pom/jmen;
        else
            pom = 2*pi*m*hn*cos(m*pi*yn/H) ...
                + H*sin(m*pi*(2*hn+yn)/H) ...
                - H*sin(m*pi*yn/H);
            qnm = pom/(2*pi*m*hn);
        end
    end
end