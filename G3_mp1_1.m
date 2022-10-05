% ALONZO & SOLIS | CEDISP2 S11 | PROBLEM 1
% Script that simulates the operation of a 4-bit linear midtread 
% quantizer on a given speech signal

% obtain value
[orig, Fs] = audioread("gutom.wav");
ymax = round(max(orig));
ymin = round(min(orig));

% step size
delta = (ymax-ymin)/(2^4-1);

x=[];
xq=[];
eq=[];

for v = 1:length(orig)
    x(v) = orig(v)/delta;

    if x(v)>=-7.5 && x(v)<-6.5
        del2 = -7;
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
    xq(v) = del2*delta;
    eq(v) = xq(v)-orig(v);
end

SNRn = 0;
SNRd = 0;

for n = 1:length(orig)-1
    SNRn = SNRn + x(n)^2;
end

for n = 1:length(orig)-1
    SNRd = SNRd + (xq(n) - x(n))^2;
end

SNR = SNRn/SNRd;

SNRdb = 10*log(SNR);

%plot anf print
subplot(3,1,1);
title("Original Speech");
plot(1:length(orig),orig)

subplot(3,1,2);
title("Quantized Speech");
plot(1:length(orig),xq)

subplot(3,1,3);
title("Quantized Error");
plot(1:length(orig),eq)

fprintf("SNR dB: %f\n", SNRdb)

audiowrite("G3_mp1_1.wav", xq, Fs)