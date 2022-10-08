% ALONZO & SOLIS | CEDISP2 S11 | PROBLEM 3
% Script that that simulates the operation of the digital μ-Law companding 
% (12-to-8-bits)

[orig, Fs] = audioread("gutom.wav");

% 12 bit to 8 bit compressor algorithm in decimal
comped = [];
for i = 1:length(orig)

   mag = abs(orig(i));
   s = SIGN(orig(i));

   if mag >= 0 && mag <= 2/8 % segments 0 & 1
       comped(i) = orig(i); % no compression
   elseif mag > 2/8 && mag <= 3/8 % segment 2
       comped(i) = floor(mag/2)*s; % 2:1 compression
   elseif mag > 3/8  && mag <= 4/8 % segment 3
       comped(i) = floor(mag/4)*s; % 4:1 compression
   elseif mag > 4/8 && mag <= 5/8 % segment 4
       comped(i) = floor(mag/8)*s; % 8:1 compression
   elseif mag > 5/8 && mag <= 6/8 % segment 5
       comped(i) = floor(mag/16)*s; % 16:1 compression
   elseif mag > 6/8 && mag <= 7/8 % segment 6
       comped(i) = floor(mag/32)*s; % 32:1 compression
   elseif mag > 7/8 && mag <= 1 % segment 7
       comped(i) = floor(mag/64)*s; % 64:1 compression
   end
end

% 8-bit to 12-bit expander algorithm in decimal
exped = [];
for i = 1:length(comped)

   mag = abs(comped(i));
   s = sign(comped(i));

   if mag >= 0 && mag <= 2/8 % segments 0 & 1
       exped(i) = orig(i);
   elseif mag > 2/8 && mag <= 3/8 % segment 2
       exped(i) = mag*2*s; % 2:1 compression
   elseif mag > 3/8  && mag <= 4/8 % segment 3
       exped(i) = mag*4*s; % 4:1 compression
   elseif mag > 4/8 && mag <= 5/8 % segment 4
       exped(i) = mag*8*s; % 8:1 compression
   elseif mag > 5/8 && mag <= 6/8 % segment 5
       exped(i) = mag*16*s; % 16:1 compression
   elseif mag > 6/8 && mag <= 7/8 % segment 6
       exped(i) = mag*32*s; % 32:1 compression
   elseif mag > 7/8 && mag <= 1 % segment 7
       exped(i) = mag*64*s; % 64:1 compression
   end
end

eq = exped' - orig;

SNRdb = SNR(orig, exped);

subplot(4,1,1)
title('Original Speech')
plot(1:length(orig), orig);

subplot(4,1,2)
title('Compressed Signal')
plot(1:length(orig), comped);

subplot(4,1,3)
title('Expanded Signal')
plot(1:length(orig), exped);

subplot(4,1,4)
title('Quantization Error')
plot(1:length(orig), eq);

fprintf("\nSNR dB: %f\n\n", SNRdb)

audiowrite("G3_mp1_3.wav", exped, Fs)

function s = SIGN(n)
    s = sign(n);
    if s == 0
        s = 1;
    end
end