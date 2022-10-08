% Function that calculates the Signal-to-Noise Power Ratio
% ALONZO & SOLIS | CEDISP2 S11

function [SNRdb] = SNR(original, quantized)

    % initialize numerator and denominator 
    SNRn = 0;
    SNRd = 0;
    
    % SNR formula - numerator
    for n = 1:length(original)
        SNRn = SNRn + original(n)^2;
    end
    
    % SNR formula - denominator
    for n = 1:length(original)
        SNRd = SNRd + (quantized(n) - original(n))^2;
    end
    
    SNR = SNRn/SNRd;
    
    % Final estimation of SNR for a speech data sequence x(n) of 
    % N data points
    SNRdb = 10*log10(SNR);
   
end