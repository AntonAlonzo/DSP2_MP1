% ALONZO & SOLIS | CEDISP2 S11 | PROBLEM 2
% Script that simulates the operation of analog μ-Law companding that 
% employs the linear or uniform 4-bit midtread quantizer that you used 
% in problem 1
[orig, Fs] = audioread("gutom.wav");
ogmax = round(max(orig));
ogmin = round(min(orig));

y = [];

% mu-law Companding
for n = 1:length(orig)
    num = log(1 + 255*abs(orig(n))/abs(max(orig)));
    y(n) = SIGN(orig(n)) * num/log(1+255);
end

% step size
delta = (ogmax-ogmin)/(2^4-1);

x=[];
yq=[];

% solution
for v = 1:length(y)
    x(v) = y(v)/delta;

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

    % recovered volage
    yq(v) = del2*delta;
end

xq = [];
eq=[];

% mu-law Expander
for n = 1:length(yq)
    xq(n) = abs(max(orig))*SIGN(yq(n))*((1+255)^abs(yq(n))-1)/255;
    
    % quantization error
    eq(n) = xq(n)-orig(n);
end

% Signl-to-Noise Power Ratio
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

%plot anf print
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

fprintf("SNR dB: %f\n", SNRdb)

audiowrite("G3_mp1_2.wav", xq, Fs)

function i = SIGN(x)
    i = sign(x);
    if i == 0
        i = 1;
    end
end