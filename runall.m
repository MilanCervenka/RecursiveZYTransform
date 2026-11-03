
% Silencers with QWRs
cd ./Silencer_QWRs;
M_QWRs_250_500 = Silencer_250_500();
C_QWRs_250_500 = load("Tcoef_COMSOL_250_500.txt");
M_QWRs_500_750 = Silencer_500_750();
C_QWRs_500_750 = load("Tcoef_COMSOL_500_750.txt");
cd ..

figure(1);
plot(M_QWRs_250_500(:,1), -20*log10(M_QWRs_250_500(:,2)), 'b-', 'LineWidth', 1.0);
hold on;
plot(C_QWRs_250_500(:,1), -20*log10(C_QWRs_250_500(:,2)), 'b--', 'LineWidth', 1.5);
plot(M_QWRs_500_750(:,1), -20*log10(M_QWRs_500_750(:,2)), 'r-', 'LineWidth', 1.0);
plot(C_QWRs_500_750(:,1), -20*log10(C_QWRs_500_750(:,2)), 'r--', 'LineWidth', 1.5);
hold off;
xlabel 'f (Hz)';
ylabel 'TL (dB)';
title 'Reactive silencer with 6 QWRs (Fig. 9 in the manuscript)';
axis([0 1000 0 70]);
legend("MATLAB: \Delta f = 250-500 Hz", "COMSOL: \Delta f = 250-500 Hz", ...
       "MATLAB: \Delta f = 500-750 Hz", "COMSOL: \Delta f = 500-750 Hz", ...
       "location", "northwest");


% Silencers with FQWRs
cd ./Silencer_FQWRs;
M_FQWRs_250_500 = Silencer_250_500();
C_FQWRs_250_500 = load("Tcoef_COMSOL_250_500.txt");
M_FQWRs_500_750 = Silencer_500_750();
C_FQWRs_500_750 = load("Tcoef_COMSOL_500_750.txt");
cd ..

figure(2);
plot(M_FQWRs_250_500(:,1), -20*log10(M_FQWRs_250_500(:,2)), 'b-', 'LineWidth', 1.0);
hold on;
plot(C_FQWRs_250_500(:,1), -20*log10(C_FQWRs_250_500(:,2)), 'b--', 'LineWidth', 1.5);
plot(M_FQWRs_500_750(:,1), -20*log10(M_FQWRs_500_750(:,2)), 'r-', 'LineWidth', 1.0);
plot(C_FQWRs_500_750(:,1), -20*log10(C_FQWRs_500_750(:,2)), 'r--', 'LineWidth', 1.5);
hold off;
xlabel 'f (Hz)';
ylabel 'TL (dB)';
title 'Reactive silencer with 6 FQWRs (Fig. 12 in the manuscript)';
axis([0 1000 0 70]);
legend("MATLAB: \Delta f = 250-500 Hz", "COMSOL: \Delta f = 250-500 Hz", ...
       "MATLAB: \Delta f = 500-750 Hz", "COMSOL: \Delta f = 500-750 Hz", ...
       "location", "northwest");


% Silencers with HRs
cd ./Silencer_HRs;
M_HRs_250_500 = Silencer_250_500();
C_HRs_250_500 = load("Tcoef_COMSOL_250_500.txt");
M_HRs_500_750 = Silencer_500_750();
C_HRs_500_750 = load("Tcoef_COMSOL_500_750.txt");
cd ..

figure(3);
plot(M_HRs_250_500(:,1), -20*log10(M_HRs_250_500(:,2)), 'b-', 'LineWidth', 1.0);
hold on;
plot(C_HRs_250_500(:,1), -20*log10(C_HRs_250_500(:,2)), 'b--', 'LineWidth', 1.5);
plot(M_HRs_500_750(:,1), -20*log10(M_HRs_500_750(:,2)), 'r-', 'LineWidth', 1.0);
plot(C_HRs_500_750(:,1), -20*log10(C_HRs_500_750(:,2)), 'r--', 'LineWidth', 1.5);
hold off;
xlabel 'f (Hz)';
ylabel 'TL (dB)';
title 'Reactive silencer with 6 HRs (Fig. 15 in the manuscript)';
axis([0 1000 0 60]);
legend("MATLAB: \Delta f = 250-500 Hz", "COMSOL: \Delta f = 250-500 Hz", ...
       "MATLAB: \Delta f = 500-750 Hz", "COMSOL: \Delta f = 500-750 Hz", ...
       "location", "northwest");