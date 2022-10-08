% Function that references the midtread quantization level table
% ALONZO & SOLIS | CEDISP2 S11

function [quantized] = MTQ(original, delta)

    % intialization
    x = [];
    quantized = [];
    
    for v = 1:length(original)
    
        x(v) = original(v)/delta; 
        
        % 4-BIT LINEAR MIDTREAD QUANTIZATION LEVEL TABLE
        % input signal subranges and their respective quantization levels
        if x(v)>=-7.5 && x(v)<-6.5
            qlvl = -7;
        elseif x(v)>=-6.5 && x(v)<-5.5
            qlvl = -6;
        elseif x(v)>=-5.5 && x(v)<-4.5
            qlvl = -5;
        elseif x(v)>=-4.5 && x(v)<-3.5
            qlvl = -4;
        elseif x(v)>=-3.5 && x(v)<-2.5
            qlvl = -3;
        elseif x(v)>=-2.5 && x(v)<-1.5
            qlvl = -2;
        elseif x(v)>=-1.5 && x(v)<-0.5
            qlvl = -1;
        elseif x(v)>=-0.5 && x(v)<0.5
            qlvl = 0;
        elseif x(v)>=0.5 && x(v)<1.5
            qlvl = 1;
        elseif x(v)>=1.5 && x(v)<2.5
            qlvl = 2;
        elseif x(v)>=2.5 && x(v)<3.5
            qlvl = 3;
        elseif x(v)>=3.5 && x(v)<4.5
            qlvl = 4;
        elseif x(v)>=4.5 && x(v)<5.5
            qlvl = 5;
        elseif x(v)>=5.5 && x(v)<6.5
            qlvl = 6;
        elseif x(v)>=6.5 && x(v)<7.5
            qlvl = 7;
        end
    
        % recovered voltage
        quantized(v) = qlvl*delta;
    end

end