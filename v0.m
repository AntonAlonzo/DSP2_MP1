% ALONZO & SOLIS | CEDISP2 S11 | PROBLEM 3
% Script that that simulates the operation of the digital μ-Law companding 
% (12-to-8-bits)

[orig, Fs] = audioread("gutom.wav");
ogmax = round(max(orig));

% 12 bit to 8 bit compressor algorithm in decimal
comped = [];
comped8b = [];
for n = 1:length(orig)
    num = log(1 + 255*abs(orig(n))/ogmax);
    comped(n) = SIGN(orig(n)) * num/log(1+255);
    comped8b(n) = floor(comped(n)*128); % 8 bit decimal representation
end

% 8-bit to 12-bit expander algorithm in decimal
exped = [];
exped12b = [];
for i = 1:length(comped8b)
    x = comped8b(n)/128;
    exped(n) = ogmax*SIGN(x)*(((1+255)^abs(x)-1)/255);
    exped12b(n) = ceil(exped(n) * 2048);
end

eq = exped' - orig;

SNRdb = SNR(orig, exped);

subplot(4,1,1)
title('Original Speech')
plot(1:length(orig), orig);

subplot(4,1,2)
title('Compressed Signal')
plot(1:length(orig), comped8b);

subplot(4,1,3)
title('Expanded Signal')
plot(1:length(orig), exped12b);

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