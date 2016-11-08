clc
clear
clf
filename= "722899_2010_solar";

dataImportRaw = csvRead(strcat(["C:\Users\user\Documents\Scilab\Weather-Chino\",filename,".csv"]),[],[],'string',[],[]);

dataImportRaw = [dataImportRaw; string(zeros(1, size(dataImportRaw,'c')))];

function [splitMatrix] = splitdate(a)
    b = strsplit(a,"-");
    splitMatrix = b';
endfunction

j=1;

// starts at 3 since it looks for difference in dates
// first difference in dates is ~ row 26 where Jan 2 occurs
for i = 3:size(dataImportRaw,'r')
    if dataImportRaw(i,1) ~= dataImportRaw(i-1,1) then
        dataStringDaily(j,1) = string(j);
        dataStringDaily(j,2:4) = splitdate(dataImportRaw(i-1,1));
        dayInsolation = string(sum(strtod(dataImportRaw(i-24:i, 16))));
        
        dataStringDaily(j,5) = dayInsolation;

        j=j+1;
    end,
end

i=1;
j=1;
monthlytotal = 0;

//dataImportRaw = [dataImportRaw; string(zeros(1, size(dataImportRaw,'c')))];
dataStringDaily = [dataStringDaily; string(zeros(1, size(dataStringDaily,'c')))];

while i < size(dataStringDaily,'r')
    while dataStringDaily(i,3) == dataStringDaily(i+1,3)
        currentMonth = dataStringDaily(i,3);
        monthlytotal = monthlytotal + strtod(dataStringDaily(i,5));
        i=i+1
    end
    dataStringMonthly(j,1) = currentMonth;
    dataStringMonthly(j,2) = string(monthlytotal);
    i=i+1;
    j=j+1;
    monthlytotal=0;
end


a1 = newaxes(); //make right y-axis
a1.filled = 'off';
a1.axes_visible(1) = 'off';
a1.tight_limits = 'on';
a1.y_location = 'right';
a1.auto_ticks = ['off', 'on', 'on']; //remove ticks on first x-axis
a1.x_ticks.locations = [];

x1 = strtod(dataStringDaily(1:($-1),1));
y1 = strtod(dataStringDaily(1:($-1),5));
x2 = 30*strtod(dataStringMonthly(1:($-1),1));
y2 = strtod(dataStringMonthly(1:($-1),2));

plot(x2, y2); //plot graph 2
ylabel('add label', 'fontsize', 3); //add label to right y-axis

a2 = newaxes(); //make left y-axis
a2.filled = 'off';
a2.tight_limits = 'on';
plot(x1, y1); //plot graph 1
plot(x1, y1); //plot invisible graph 1 with colours of graph 2 (so a legend can be added)
y = gca();

LinE = y.children.children(1);
LinE.visible = 'off';
xlabel('add label', 'fontsize', 3); //add label to x-axis
ylabel('add label', 'fontsize', 3); //add label to left y-axis 

outputNameMatrix = strsplit(filename,"_");
outputName = outputNameMatrix(2);

csvWrite(dataStringDaily, strcat(["C:\Users\user\Documents\Scilab\Weather-Chino\Data\",outputName,"daily.csv"]));
