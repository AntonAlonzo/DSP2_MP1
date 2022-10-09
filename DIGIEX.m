% Function that converts 8-bit compressed code to 12-bit linear code (already in decimal form)
% ALONZO & SOLIS | CEDISP2 S11 | PROBLEM 3

function LC = DIGIEX(CC)

    CCb = dec2bin(CC, 8); % convert to binary code
    segid = bin2dec(CCb(:,2:4)); % get the 3-bit segment identifier in decimal
    abcdq = CCb(:,5:8); % 4-bit quantization level
   
    if segid == 0 % segment 0
        LC = bin2dec(strrep(['00000000' abcdq], ' ', '')); % 00000000ABCD
    elseif segid == 1 % segment 1
        LC = bin2dec(strrep(['00000001' abcdq], ' ', '')); % 00000001ABCD
    elseif segid == 2 % segment 2
        LC = bin2dec(strrep(['0000001' abcdq '1'], ' ', '')); % 0000001ABCD1
    elseif segid == 3 % segment 3
        LC = bin2dec(strrep(['000001' abcdq '10'], ' ', '')); % 000001ABCD10
    elseif segid == 4 % segment 4
        LC = bin2dec(strrep(['00001' abcdq '100'], ' ', '')); % 00001ABCD100
    elseif segid == 5 % segment 5
        LC = bin2dec(strrep(['0001' abcdq '1000'], ' ', '')); % 0001ABCD1000
    elseif segid == 6 % segment 6
        LC = bin2dec(strrep(['001' abcdq '10000'], ' ', '')); % 001ABCD10000
    elseif segid == 7 % segment 7
        LC = bin2dec(strrep(['01' abcdq '100000'], ' ', '')); % 01ABCD100000
    end
     
end