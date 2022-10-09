% Script that that simulates the operation of the digital μ-Law companding (12-to-8-bits)
% ALONZO & SOLIS | CEDISP2 S11 | PROBLEM 3

clc;clear;

[orig, Fs] = audioread("gutom.wav");

% 12 bit to 8 bit compressor algorithm in decimal
comped = [];
s8d = [];
for n = 1:length(orig)

    x = floor(abs(orig(n)*2048)); % convert absolute value to 12-bit decimal
    s = SIGN(orig(n));
    segment = SEG(x); % get segment of value
    segid = dec2bin(segment, 3); % 3-bit segment identifier
    qint = ABCD(x, segment); % 4-bit quantization interval
    u8b = strrep([segid qint], ' ', ''); % concatenate bits to form  8-bit compressed code (sign excluded)
    s8d(n) = bin2dec(u8b)*s; % convert to decimal (sign included)
    comped(n) = s8d(n)/128;

end

% 8-bit to 12-bit expander algorithm in decimal
exped = [];
for n = 1:length(comped)

    x = abs(s8d(n)); % get absolute value of 8-bit decimal
    s = SIGN(comped(n));
    s12d = DIGIEX(x)*s; % convert to 12-bit linear code (in decimal form)
    exped(n) = s12d/2048;

end

eq = exped' - orig;

SNRdb = SNR(orig, exped);

subplot(4,1,1),
plot(1:length(orig), orig),
title('Original Speech');

subplot(4,1,2),
plot(1:length(orig), comped),
title('Compressed Signal');

subplot(4,1,3),
plot(1:length(orig), exped),
title('Expanded Signal');

subplot(4,1,4),
plot(1:length(orig), eq),
title('Quantization Error');

fprintf("\nSNR dB: %f\n\n", SNRdb)

audiowrite("G3_mp1_3.wav", exped, Fs)