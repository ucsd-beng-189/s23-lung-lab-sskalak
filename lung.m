%filename: lung.m (main program)
clear all
close all
clf
global Pstar cstar n maxcount M Q camax RT cI;

%using percent O2 at various altitudes to then do task 6 next easily 
O2percents = [20.9 20.1 19.4 18.6 17.9 17.3 16.6 16.0 15.4 14.8 14.3 13.7 13.2 12.7 12.3 11.8 11.4 11.0 10.5 10.1 9.7 9.4 9.0 ]/100;

for i=1:length(O2percents)

%vary ci by changing the percent O2 in the air with the list above    
cI = O2percents(i)/(22.4*(310/273));

setup_lung
cvsolve
outchecklung

PIlist(i) = PI;
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

%plotting PI vs mean partial pressures
figure('NumberTitle', 'off', 'Name', 'cI vs O2 Pressure');
plot(cIlist, Palist);
hold on
plot(cIlist, PAlist);
plot(cIlist, Pvlist); 
set ( gca, 'xdir', 'reverse' )
legend('mean arterial O2 partial pressure','mean alveolar O2 partial pressure','O2 partial pressure in venous blood')
xlabel('cI: conc of O2 in inspired air (moles/Liter')
ylabel('Partial pressures of O2 (mmHg)')
title('cI vs partial pressure of O2')

%plotting PI vs mean o2 concentrations
figure('NumberTitle', 'off', 'Name', 'cI vs O2 Conc');
plot(cIlist, cvlist);
hold on
plot(cIlist, cabarList);
plot(cIlist, cAbarlist); 
set ( gca, 'xdir', 'reverse' )
legend('O2 conc in venous blood','mean arterial O2 conc','mean alveolar O2 conc','Location', 'southwest')
xlabel('cI: conc of O2 in inspired air (moles/Liter)')
ylabel('Concentrations of O2 (moles/Liter)')
title('cI vs partial pressure of O2')