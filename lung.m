%filename: lung.m (main program)
clear all
clf
global Pstar cstar n maxcount M Q camax RT cI;

betalist = [0.1 0.25 0.5 0.75 0.9];
beta=betalist(5);

for M = 0:0.001:5
setup_lung
cvsolve
outchecklung
end

