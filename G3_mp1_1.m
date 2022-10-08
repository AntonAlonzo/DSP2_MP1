% Script that simulates the operation of a 4-bit linear midtread quantizer on a given speech signal
% ALONZO & SOLIS | CEDISP2 S11 | PROBLEM 1

% obtain normalized data and bounds
[orig, Fs] = audioread("gutom.wav");
ogmax = round(max(orig));
ogmin = round(min(orig));

% Calculating the step size
delta = (ogmax-ogmin)/(2^4-1);

% Calling the user-made midtread quantization function
xq = MTQ(orig, delta);

% Quantization error
eq = xq' - orig;

% Calling the user-made Signal-to-Noise Power Ratio function
SNRdb = SNR(orig, xq);

% Plot the waveforms and display the final answer
subplot(3,1,1);
plot(1:length(orig),orig)
title("Original Speech");

subplot(3,1,2);
plot(1:length(orig),xq)
title("Quantized Speech");

subplot(3,1,3);
plot(1:length(orig),eq)
title("Quantized Error");

fprintf("\nSNR dB = %f\n\n", SNRdb)

% Generate the new audio file from the quantized waveform
audiowrite("G3_mp1_1.wav", xq, Fs)