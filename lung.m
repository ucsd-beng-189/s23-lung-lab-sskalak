%filename: lung.m (main program)
%clear all
close all
clf
global Pstar cstar n maxcount M Q camax RT cI;

%After running setup_lung once I commented out lines 60-74 on setup_lung.
%This is so there is no random initiaization and I use constant ventilation
%vs perfursion for the tasks now to better compare changes

cstarlist =  0.0082:-0.0002:0.0002;
betalist = [0.1 0.25 0.5 0.75 0.9];

for j=1:length(betalist)
    beta = betalist(j);
for i= 1:length(cstarlist)

cstar = cstarlist(i);

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

for k=1:length(cvlist)
cvlistbetas(j,k) = cvlist(k);
end
end


for i=1:5
    plot(cstarlist, cvlistbetas(i,:))
    hold on;
end
legend('beta=0.1','beta=0.25','beta=0.5','beta=0.75','beta=0.9')
xlabel('concentration of hemoglobin in blood (moles/liter)')
set(gca, 'XTickLabel',get(gca,'XTick')) 
set ( gca, 'xdir', 'reverse' )
ylabel('Concentrations of O2 (moles/Liter)')
title('cstar vs conc of O2')
%{
%plotting cstarlist vs mean partial pressures
figure('NumberTitle', 'off', 'Name', 'cstarlist vs O2 Pressure');
plot(cstarlist, Palist);
hold on
plot(cstarlist, PAlist);
plot(cstarlist, Pvlist); 
legend('mean arterial O2 partial pressure','mean alveolar O2 partial pressure','O2 partial pressure in venous blood','Location', 'southwest')
xlabel('concentration of hemoglobin in blood (moles/liter)')
set(gca, 'XTickLabel',get(gca,'XTick')) 
set ( gca, 'xdir', 'reverse' )
ylabel('Partial pressures of O2 (mmHg)')
title('cstar vs partial pressure of O2')

%plotting cstarlist vs mean o2 concentrations
figure('NumberTitle', 'off', 'Name', 'cstar vs O2 Conc');
plot(cstarlist, cvlist);
hold on
plot(cstarlist, cabarList);
plot(cstarlist, cAbarlist); 
legend('O2 conc in venous blood','mean arterial O2 conc','mean alveolar O2 conc','Location', 'southwest')
xlabel('concentration of hemoglobin in blood (moles/liter)')
ylabel('Concentrations of O2 (moles/Liter)')
set(gca, 'XTickLabel',get(gca,'XTick')) 
set ( gca, 'xdir', 'reverse' )
title('cstar vs conc of O2')
%}