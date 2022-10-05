% ALONZO & SOLIS | CEDISP2 S11 | PROBLEM 3
% Script that that simulates the operation of the digital μ-Law companding 
% (12-to-8-bits)

[orig, Fs] = audioread("gutom.wav");

% 12 bit to 8 bit compressor algorithm in decimal
comped = [];
for i = 1:length(orig)
   %record the sign of the current value of the original signal
   if orig >= 0
       sign = 1;
   else
       sign = -1;
   end

   if abs(orig(i)) >= 0 && abs(orig(i)) <= 31
       comped(i) = orig(i);
   elseif abs(orig(i)) >= 32 && abs(orig(i)) <= 47
       comped(i) = floor(orig(i)/2)*2*sign;
   elseif abs(orig(i)) >= 48 && abs(orig(i)) <= 63
       comped(i) = floor(orig(i)/4)*4*sign;
   elseif abs(orig(i)) >= 64 && abs(orig(i)) <= 79
       comped(i) = floor(orig(i)/8)*8*sign;
   elseif abs(orig(i)) >= 80 && abs(orig(i)) <= 95
       comped(i) = floor(orig(i)/16)*16*sign;
   elseif abs(orig(i)) >= 96 && abs(orig(i)) <= 111
       comped(i) = floor(orig(i)/32)*32*sign;
   elseif abs(orig(i)) >= 112 && abs(orig(i)) <= 127
       comped(i) = floor(orig(i)/64)*32*sign;
   end
end

% 8-bit to 12-bit expander algorithm in decimal
subplot(3,1,1)
title('Original Speech')
plot(1:length(orig), orig);

subplot(3,1,2)
title('Compressed Signal')
plot(1:length(orig), comped);