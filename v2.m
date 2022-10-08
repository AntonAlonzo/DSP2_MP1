% ALONZO & SOLIS | CEDISP2 S11 | PROBLEM 3
% Script that that simulates the operation of the digital μ-Law companding 
% (12-to-8-bits)

[orig, Fs] = audioread("gutom.wav");
ogmax = round(max(orig));

comped = [];
% mu-law Companding
for n = 1:length(orig)
    num = log(1 + 255*abs(orig(n))/ogmax);
    comped(n) = SIGN(orig(n)) * num/log(1+255);
end

exped = [];

% mu-law Expander
for n = 1:length(comped)
    exped(n) = ogmax*SIGN(comped(n))*((1+255)^abs(comped(n))-1)/255;
end

% quantization error
eq = exped' - orig;

% Signl-to-Noise Power Ratio
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
    if n < 0
        s = -1;
    else
        s = 1;
    end
end