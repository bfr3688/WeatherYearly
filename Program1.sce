clc
clear

dataImportRaw = csvRead("C:\Users\user\Documents\Scilab\Weather-Chino\722899_2010_solar.csv",[],[],'string',[],[]);

dataImportRaw = [dataImportRaw; string(zeros(1, size(dataImportRaw,'c')))];

function [splitMatrix] = splitdate(a)
    b = strsplit(a,"-");
    splitMatrix = b';
endfunction

j=1;

for i = 3:size(dataImportRaw,'r')
    if dataImportRaw(i,1) ~= dataImportRaw(i-1,1) then
        dataStringDaily(j,1) = string(j);
        dataStringDaily(j,2:4) = splitdate(dataImportRaw(i-1,1));
        dayInsolation = string(sum(strtod(dataImportRaw(i-20:i, 16))));
        
        dataStringDaily(j,5) = dayInsolation;

        j=j+1;
    end,
end

for i = 1: size(dataStringDaily,'r')
    
end





plot(strtod(dataStringDaily(1:$,1)),strtod(dataStringDaily(1:$,5)),'.');


