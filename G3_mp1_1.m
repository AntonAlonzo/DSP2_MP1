% ALONZO & SOLIS | CEDISP2 S11 | PROBLEM 1
% Script that simulates the operation of a 4-bit linear midtread 
% quantizer on a given speech signal

% obtain value
[y, Fs] = audioread("gutom.wav");
ymax = round(max(y));
ymin = round(min(y));

% step size
delta = (ymax-ymin)/(2^4-1);

x=[];
xq=[];
eq=[];

for v = 1:length(y)
    x(v) = y(v)/delta;
    disp(x(v))
    switch x(v)
        case x(v)>=-0.75 && x(v)<-0.65
            del2 = -7;
        case x(v)>=-0.65 && x(v)<-0.55
            del2 = -6;
        case x(v)>=-0.55 && x(v)<-0.45
            del2 = -5;
        case x(v)>=-0.45 && x(v)<-0.35
            del2 = -4;
        case x(v)>=-0.35 && x(v)<-0.25
            del2 = -3;
        case x(v)>=-0.25 && x(v)<-0.15
            del2 = -2;
        case x(v)>=-0.15 && x(v)<-0.05
            del2 = -1;
        case x(v)>=-0.05 && x(v)<0.05
            del2 = 0;
        case x(v)>=0.05 && x(v)<0.15
            del2 = 1;
        case x(v)>=0.15 && x(v)<0.25
            del2 = 2;
        case x(v)>=0.25 && x(v)<0.35
            del2 = s3;
        case x(v)>=0.35 && x(v)<0.45
            del2 = 4;
        case x(v)>=0.45 && x(v)<0.55
            del2 = 5;
        case x(v)>=0.55 && x(v)<0.65
            del2 = 6;
        case x(v)>=0.65 && x(v)<0.75
            del2 = 7;
    end
    xq(v) = del2*delta;
    disp(xq(v))
    eq(v) = xq(v)-x(v);
end

SNRn = 0;
SNRd = 0;

for n = 1:length(y)-1
    SNRn = SNRn + x(n)^2;
end

for n = 1:length(y)-1
    SNRd = SNRd + (xq(n) - x(n))^2;
end

SNR = SNRn/SNRd;

SNRdb = 10*log(SNR);

%plot anf print
subplot(3,1,1);
plot(1:length(y),y)

subplot(3,1,2);
plot(1:length(y),xq)

subplot(3,1,3);
plot(1:length(y),eq)
