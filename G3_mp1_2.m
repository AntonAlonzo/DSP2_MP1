% ALONZO & SOLIS | CEDISP2 S11 | PROBLEM 2
% Script that simulates the operation of analog μ-Law companding that 
% employs the linear or uniform 4-bit midtread quantizer that you used 
% in problem 1
[orig, Fs] = audioread("gutom.wav");
ogmax = round(max(orig));
ogmin = round(min(orig));

y = [];

for n = 1:length(orig)
    if orig(n)>=0
        sign = 1;
    else
        sign = -1;
    end

    y(n) = sign * log(1 + 255*abs(orig(n))/abs(max(orig(n)))) / log(1+255);
end

% step size
delta = (ogmax-ogmin)/(2^4-1);

x=[];
yq=[];
eq=[];

for v = 1:length(y)
    x(v) = y(v)/delta;

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
    yq(v) = del2*delta;
    eq(v) = yq(v)-y(v);
end

SNRn = 0;
SNRd = 0;

for n = 1:length(orig)-1
    SNRn = SNRn + y(n)^2;
end

for n = 1:length(orig)-1
    SNRd = SNRd + (xq(n) - y(n))^2;
end

SNR = SNRn/SNRd;

SNRdb = 10*log(SNR);


xq = [];

for n = 1:length(yq)
    if yq(n)>=0
        sign = 1;
    else
        sign = -1;
    end

    xq(n)=abs(max(orig(n)))*sign*((1+255)^abs(yq(n))-1)/255;
end

%plot anf print
subplot(5,1,1);
title("Original Speech");
plot(1:length(orig),orig)

subplot(5,1,2);
title("mu-law Compressor");
plot(1:length(orig),y)

subplot(5,1,3);
title("Uniform Quantizer");
plot(1:length(orig),yq)

subplot(5,1,4);
title("mu-law Expander");
plot(1:length(orig),xq)

subplot(5,1,5);
title("Quantized Error");
plot(1:length(orig),eq)

fprintf("SNR dB: %f\n", SNRdb)

audiowrite("G3_mp1_1.wav", xq, Fs)