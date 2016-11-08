clc
clear

dataString = csvRead("722899_2010_solar.csv",[],[],'string',[],[]);

j=1;

for i = 3:size(dataString,'r')
    if dataString(i,1) ~= dataString(i-1,1) then
        dataStringSummed(j,1) = dataString(i-1,1);
        dayInsolation = sum(strtod(dataString(i-20:i, 16)));   
        dataStringSummed(j,2) = string(j);
        dataStringSummed(j,3) = string(dayInsolation);
        
        dataDoubleSummed(j,1) = j
        dataDoubleSummed(j,2) = dayInsolation
        j=j+1;
    end,
end

plot(dataDoubleSummed(1:$,1),dataDoubleSummed(1:$,2),".");


