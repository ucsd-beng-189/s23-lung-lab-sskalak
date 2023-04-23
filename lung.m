%filename: lung.m (main program)
%clear all
close all
clf
global Pstar cstar n maxcount M Q camax RT cI;

%After running setup_lung once I commented out lines 60-74 on setup_lung.
%This is so there is no random initiaization and I use constant ventilation
%vs perfursion for the tasks now to better compare someone used to sealevel
%or altitude without the randomness affecting my numbers

%using percent O2 at various altitudes 
O2percents = [20.9 20.1 19.4 18.6 17.9 17.3 16.6 16.0 15.4 14.8 14.3 13.7 13.2 12.7 12.3 11.8 11.4 11.0 10.5 10.1 9.7 9.4 9.0 8.7 8.4 8.1 7.8 7.5 7.2 6.9]/100;
altitude = 0:1000:29000;

%set cstar to half cref to simulate anemic conditions
cstar = 0.0041;

for i=1:length(O2percents)

%vary ci by changing the percent O2 in the air with the list above    
cI = O2percents(i)/(22.4*(310/273));

setup_lung
cvsolve
outchecklung
PIlist(i)=PI;
Palist(i)=Pabar;
PAlist(i)=PAbar;
Pvlist(i)=Pv;

%oxygen concentration in (systemic) venous blood:
cvlist(i) = cv;
%mean arterial oxygen concentration:
cabarList(i)= cabar;
%mean alveolar oxygen concentration:
cAbarlist(i) = cAbar;
%oxygen concentration is the inspired air:
cIlist(i) = cI
end

%plotting altitude vs mean partial pressures
figure('NumberTitle', 'off', 'Name', 'altitude vs O2 Pressure');
plot(altitude, Palist);
hold on
plot(altitude, PAlist);
plot(altitude, Pvlist); 
legend('mean arterial O2 partial pressure','mean alveolar O2 partial pressure','O2 partial pressure in venous blood')
xlabel('altitude (feet)')
set(gca, 'XTickLabel',get(gca,'XTick')) 
ylabel('Partial pressures of O2 (mmHg)')
title('altitude vs partial pressure of O2')

%plotting altitude vs mean o2 concentrations
figure('NumberTitle', 'off', 'Name', 'altitude vs O2 Conc');
plot(altitude, cvlist);
hold on
plot(altitude, cabarList);
plot(altitude, cAbarlist); 
legend('O2 conc in venous blood','mean arterial O2 conc','mean alveolar O2 conc','Location', 'southwest')
xlabel('altitude (feet)')
ylabel('Concentrations of O2 (moles/Liter)')
set(gca, 'XTickLabel',get(gca,'XTick')) 
title('altitude vs conc of O2')