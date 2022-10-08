% Script that simulates the operation of analog μ-Law companding that employs the linear or uniform 4-bit midtread quantizer that was used in Problem 1
% ALONZO & SOLIS | CEDISP2 S11 | PROBLEM 2

% Obtain normalized data and bounds
[orig, Fs] = audioread("gutom.wav");
ogmax = round(max(orig));
ogmin = round(min(orig));

y = [];
% mu-law Companding
for n = 1:length(orig)
    num = log(1 + 255*abs(orig(n))/ogmax);
    y(n) = SIGN(orig(n)) * num/log(1+255);
end

% Calculating the step size
delta = (ogmax-ogmin)/(2^4-1);

% Employing the user-made linear 4-bit mitread quantizer function
yq = MTQ(orig);

xq = [];
% mu-law Expander
for n = 1:length(yq)
    xq(n) = ogmax*SIGN(yq(n))*((1+255)^abs(yq(n))-1)/255;
end

% quantization error
eq = xq - orig;

% Employing the user-made Signl-to-Noise Power Ratio function
SNRdb = SNR(orig, xq);

% Plot the waveforms and display the final answer
subplot(5,1,1);
plot(1:length(orig),orig)
title("Original Speech");

subplot(5,1,2);
plot(1:length(orig),y)
title("mu-law Compressor");

subplot(5,1,3);
plot(1:length(orig),yq)
title("Uniform Quantizer");

subplot(5,1,4);
plot(1:length(orig),xq)
title("mu-law Expander");

subplot(5,1,5);
plot(1:length(orig),eq)
title("Quantized Error");

fprintf("\nSNR dB: %f\n\n", SNRdb)

% Generate new audio file from quantized waveform
audiowrite("G3_mp1_2.wav", xq, Fs)

function i = SIGN(x)
    i = sign(x);
    if i == 0
        i = 1;
    end
end