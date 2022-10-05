% ALONZO & SOLIS | CEDISP2 S11 | PROBLEM 1
% Script that simulates the operation of a 4-bit linear midtread 
% quantizer on a given speech signal

% obtain value
[y, Fs] = audioread("gutom.wav");
x = 0:length(y)-1;
ymax = round(max(y));
ymin = round(min(y));

% step size
%delta = 
plot(x,y)
