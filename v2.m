% ALONZO & SOLIS | CEDISP2 S11 | PROBLEM 3
% Script that that simulates the operation of the digital μ-Law companding 
% (12-to-8-bits)

[orig, Fs] = audioread("gutom.wav");
ogmax = round(max(orig));

y = [];
% mu-law Companding
for n = 1:length(orig)
    num = log(1 + 255*abs(orig(n))/ogmax);
    y(n) = SIGN(orig(n)) * num/log(1+255);
    y(n) = floor(y(n))/128;
end



subplot(3,1,1)
title('Original Speech')
plot(1:length(orig), orig);

subplot(3,1,2)
title('Compressed Signal')
plot(1:length(orig), comped);

% subplot(3,1,2)
% title('Expanded Signal')
% plot(1:length(orig), exped);

function s = SIGN(n)
    if n < 0
        s = -1;
    else
        s = 1;
    end
end