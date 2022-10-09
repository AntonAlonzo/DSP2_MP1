% Function that gets the segment of a given decimal based on the u-255 encoding table
% ALONZO & SOLIS | CEDISP2 S11 | PROBLEM 3

function seg = SEG(val)
    if val >= 0 && val <= 15 % segment 0 range
        seg = 0;
    elseif val >= 16 && val <= 31 % segment 1 range
        seg = 1;
    elseif val >= 32 && val <= 63 % segment 2 range
        seg = 2;
    elseif val >= 64 && val <= 127 % segment 3 range
        seg = 3;
    elseif val >= 128 && val <= 255 % segment 4 range
        seg = 4;
    elseif val >= 256 && val <= 511 % segment 5 range
        seg = 5;
    elseif val >= 512 && val <= 1022 % segment 6 range
        seg = 6;
    elseif val >= 1023 && val <= 2047 % segment 7 range
        seg = 7;
    end
end