% ALONZO & SOLIS | CEDISP2 S11 | PROBLEM 1
% Script that simulates the operation of a 4-bit linear midtread 
% quantizer on a given speech signal

% obtain value
[orig, Fs] = audioread("gutom.wav");
ogmax = round(max(orig));
ogmin = round(min(orig));

% step size
delta = (ogmax-ogmin)/(2^4-1);

x=[];
xq=[];
eq=[];

% solution
for v = 1:length(orig)
    x(v) = orig(v)/delta;

    % input signal subrange
    if x(v)>=-7.5 && x(v)<-6.5
        del2 = -7;      % quantization level
    elseif x(v)>=-6.5 && x(v)<-5.5
        del2 = -6;
    elseif x(v)>=-5.5 && x(v)<-4.5
        del2 = -5;
    elseif x(v)>=-4.5 && x(v)<-3.5
        del2 = -4;
    elseif x(v)>=-3.5 && x(v)<-2.5
        del2 = -3;
    elseif x(v)>=-2.5 && x(v)<-1.5
        del2 = -2;
    elseif x(v)>=-1.5 && x(v)<-0.5
        del2 = -1;
    elseif x(v)>=-0.5 && x(v)<0.5
        del2 = 0;
    elseif x(v)>=0.5 && x(v)<1.5
        del2 = 1;
    elseif x(v)>=1.5 && x(v)<2.5
        del2 = 2;
    elseif x(v)>=2.5 && x(v)<3.5
        del2 = 3;
    elseif x(v)>=3.5 && x(v)<4.5
        del2 = 4;
    elseif x(v)>=4.5 && x(v)<5.5
        del2 = 5;
    elseif x(v)>=5.5 && x(v)<6.5
        del2 = 6;
    elseif x(v)>=6.5 && x(v)<7.5
        del2 = 7;
    end

    % recovered voltage
    xq(v) = del2*delta;

    % quantization error
    eq(v) = xq(v)-orig(v);
end

% Signal-to-Noise Power Ratio
SNRn = 0;
SNRd = 0;

% SNR formula numerator
for n = 1:length(orig)-1
    SNRn = SNRn + orig(n)^2;
end

% SNR formula denominator
for n = 1:length(orig)-1
    SNRd = SNRd + (xq(n) - orig(n))^2;
end

SNR = SNRn/SNRd;

SNRdb = 10*log10(SNR);

%plot and print
subplot(3,1,1);
plot(1:length(orig),orig)
title("Original Speech");

subplot(3,1,2);
plot(1:length(orig),xq)
title("Quantized Speech");

subplot(3,1,3);
plot(1:length(orig),eq)
title("Quantized Error");

fprintf("SNR dB: %f\n", SNRdb)

audiowrite("G3_mp1_1.wav", xq, Fs)