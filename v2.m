% ALONZO & SOLIS | CEDISP2 S11 | PROBLEM 3
% Script that that simulates the operation of the digital μ-Law companding 
% (12-to-8-bits)

[orig, Fs] = audioread("gutom.wav");
ogmax = round(max(orig));

comped = [];
% mu-law Companding
for n = 1:length(orig)
    num = log(1 + 255*abs(orig(n)*128)/ogmax);
    comped(n) = SIGN(orig(n)) * num/log(1+255);
end

exped = [];
eq=[];

% mu-law Expander
for n = 1:length(comped)
    
    exped(n) = ogmax*SIGN(comped(n))*((1+255)^abs(comped(n))-1)/255;
    exped(n) = exped(n)/128;
    
    % quantization error
    eq(n) = exped(n)-orig(n);
end

% Signl-to-Noise Power Ratio
SNRn = 0;
SNRd = 0;

% SNR formula numerator
for n = 1:length(orig)
    SNRn = SNRn + orig(n)^2;
end

% SNR formula denominator
for n = 1:length(orig)
    SNRd = SNRd + eq(n)^2;
end

SNR = SNRn/SNRd;

SNRdb = 10*log10(SNR);

subplot(3,1,1)
title('Original Speech')
plot(1:length(orig), orig);

subplot(3,1,2)
title('Compressed Signal')
plot(1:length(orig), comped);

subplot(3,1,3)
title('Expanded Signal')
plot(1:length(orig), exped);

function s = SIGN(n)
    if n < 0
        s = -1;
    else
        s = 1;
    end
end