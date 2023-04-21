%when M is too big while running my lung.m code and breaks cvsolve.m I note down the M value below.
close all;
betalist = [0.1 0.25 0.5 0.75 0.9];
Mlist = [0.03 0.0290 0.0240 0.0230 0.0170]

plot(betalist, Mlist, '-*');
xlabel('beta')
ylabel('M-Max (moles/minute)');
title('beta vs M-Max (maximum sustainable rate of O2 consumption')