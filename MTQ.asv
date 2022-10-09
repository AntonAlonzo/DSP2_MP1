% Function that references the midtread quantization level table
% ALONZO & SOLIS | CEDISP2 S11

function [quantized] = MTQ(original, delta)

    % initialization
    quantized = [];
    
    for i = 1:length(original)
    
        x = original(i)/delta; 
        
        % 4-BIT LINEAR MIDTREAD QUANTIZATION LEVEL TABLE
        % input signal subranges and their respective quantization levels
        if x>=-7.5 && x<-6.5
            qlvl = -7;
        elseif x>=-6.5 && x<-5.5
            qlvl = -6;
        elseif x>=-5.5 && x<-4.5
            qlvl = -5;
        elseif x>=-4.5 && x<-3.5
            qlvl = -4;
        elseif x>=-3.5 && x<-2.5
            qlvl = -3;
        elseif x>=-2.5 && x<-1.5
            qlvl = -2;
        elseif x>=-1.5 && x<-0.5
            qlvl = -1;
        elseif x>=-0.5 && x<0.5
            qlvl = 0;
        elseif x>=0.5 && x<1.5
            qlvl = 1;
        elseif x>=1.5 && x<2.5
            qlvl = 2;
        elseif x>=2.5 && x<3.5
            qlvl = 3;
        elseif x>=3.5 && x<4.5
            qlvl = 4;
        elseif x>=4.5 && x<5.5
            qlvl = 5;
        elseif x>=5.5 && x<6.5
            qlvl = 6;
        elseif x>=6.5 && x<7.5
            qlvl = 7;
        end
    
        % recovered voltage
        quantized(i) = qlvl*delta;
    end

end