%filename: lung.m (main program)
clear all
clf
global Pstar cstar n maxcount M Q camax RT cI;
betalist = [0.1 0.25 0.5 0.75 0.9];

for i=1:5
    beta=betalist(i);
setup_lung
cvsolve
outchecklung

PIlist(i) = PI;
Palist(i)=Pabar;
PAlist(i)=PAbar;
Pvlist(i)=Pv;
end

figure('NumberTitle', 'off', 'Name', 'Beta vs Pressure');
plot(betalist, PIlist);
hold on
plot(betalist, Palist);
plot(betalist, PAlist);
plot(betalist, Pvlist); 
legend('PI','Pa','PA','Pv')
xlabel('beta')
ylabel('Partial pressure of O2 (mmHg)')
title('beta vs partial pressure of O2')
