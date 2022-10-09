% Function that gets the 4-bit quantization interval from the given decimal
% ALONZO & SOLIS | CEDISP2 S11 | PROBLEM 3

function abcdq = ABCD(val, seg)
    
    valInB = dec2bin(val,12); % get 12 bit linear code

    if seg == 0 || seg == 1 % segments 0 and 1
        abcdq = valInB(:,9:12);
    elseif seg == 2 % segment 2
        abcdq = valInB(:,8:11);
    elseif seg == 3 % segment 3
        abcdq = valInB(:,7:10);
    elseif seg == 4 % segment 4
        abcdq = valInB(:,6:9);
    elseif seg == 5 % segment 5
        abcdq = valInB(:,5:8);
    elseif seg == 6 % segment 6
        abcdq = valInB(:,4:7);
    elseif seg == 7 % segment 7
        abcdq = valInB(:,3:6);
    end
end