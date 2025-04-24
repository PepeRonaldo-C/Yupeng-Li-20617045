%Yupeng Li 20617045
%ssyyl72@nottingham.edu.cn

%% PRELIMINARY TASK - ARDUINO AND GIT INSTALLATION [10 MARKS]
%c 
a = arduino('COM13','Uno');
for n = 1:5;
    writeDigitalPin(a,"D7",1);
    pause(1);
    writeDigitalPin(a,"D7",0);
    pause(1);
end


clear

%%Task1 READ TEMPERATURE DATA,PLOT,AND WTITE A LOG FILE
%a shown in the photo sumbited
%b
a = arduino('COM13','Uno');
AnA = 'A2';%The chosen Arduino analogue channel for the temperature is A.
duration = 600;%With the unit of second.
V_0 = 0.5;%With the unit of V
T_c = 0.01;%With the unit of V/°
voltage_recored = zeros(1,duration);%With the unit of V
temperature_true = zeros(1,duration);%With the unit of °(Celsius)
for n = 1:duration;
    voltage_read = readVoltage(a,'A2');%With the unit of V
    voltage_recored(n) = voltage_read;%With the unit of V
    temperature_calculated = (voltage_read-V_0)/T_c;%With the unit of °(Celsius)
    temperature_true(n) = temperature_calculated;%With the unit of °(Celsius)
    pause(1);
end

maxmium_temperature = max(temperature_true);
avarge_temperature = mean(temperature_true);
minimun_temperature = min(temperature_true);

%c
time = zeros(1,duration);
for n = 1:duration;
    time(n) = n;
end
figure 
plot(time,temperature_true);
grid on;
xlabel('Time with the unit of S');
ylabel('Temperature with the unit of Celsius');
title('Temperature vs Time under the duration of 600s');

%d
location = ('UNNC New library 3F');date = ('14/4/2025');
fprintf('Data logging initiated - %s\n',date);
fprintf('Location - %s\n',location);
for g = 0:10;%g was used to recored time  with the unit of minute
    fprintf('Minute\t\t\t%d\n',g);
    fprintf('Temperature\t%7.2f C\n\n',minimun_temperature);
end

fprintf('Max temp\t%7.2f C\n',maxmium_temperature);
fprintf('Min temp\t%7.2f C\n',minimun_temperature);
fprintf('Average temp\t%7.2f C\n\n',avarge_temperature);

fprintf('Data logging terminated');

%e
cwfile = fopen('cabin_temperature.txt','w');%was used to create the function
fprintf(cwfile,'Data logging initiated - %s\n',date);
fprintf(cwfile,'Location - %s\n',location);
for g = 0:10
    fprintf(cwfile,'Minute\t\t\t%d',g);
    fprintf(cwfile,'Temperature\t%7.2f C\n\n',minimun_temperature);
end
fprintf(cwfile,'Max temp\t%7.2f C',maxmium_temperature);
fprintf(cwfile,'Min temp\t%7.2f C',minimun_temperature);
fprintf(cwfile,'Average temp\t%7.2f C\n\n',avarge_temperature);

fprintf(cwfile,'Data logging terminated');

fclose(cwfile);

clear

%% TASK 2 – LED TEMPERATURE MONITORING DEVICE IMPLEMENTATION [25 MARKS]
%a shown in the photo
%b shown in the flowchart 
%It is important to note that because the while true function used in the
%question c, the plot of question d may not display in this document.Please
%open the document 'temp_monitor' to see the plot.Thank you for taking the 
%extra time to check my question c and d in the document 'temp_monitor'.
%Details for question c,d,e,f,g,and h shown in the document
%'temp_monitor.m'.Please run the code in this document by inputing
%temp_monitor in this matlab code commond window and check the details in
%the document 'temp_monitor.m'.
temp_monitor;
clear

%%Task 3 ALGORITHMS – TEMPERATURE PREDICTION [25 MARKS]
%a shown in the photo and the flowchart 
temp_prediction;
clear
%Details of question e shown in the document temp_prediction.Please run the code in this document by inputing
%temp_perdiction in this matlab code commond window and check the details in
%the document 'temp_prediction.m'.

%%Task 4 Reflective statement 
%First of all,the biggest challengne of my aero1005 cw2 is that I was not
%familiar with the use of arduino and some electrical equipment such as
%thermistor and breadboards.The smaller challenge is that understand the
%requirement of differnet tasks and write the corresponding code.

%As for strengths for the task.Personlly, the use of arduino and some
%electrical equipment because in all tasks I accurately measured the 
% temperature of the environment with the use of electrical equipment.
%2.Although my matlab code can not fully meet the requirement of all
%tasks,all my matlab code run correctly and successfully,and basically
%meets the requirements of the topic.

%As for limition.
%1.In the task 1 question c the plot was not  updated in real time,the plot
%was drawn after all data has been collected.And the data recored in the
%document cabin_temperature was not and not in the correct format and I do
%not know why.
%In the task2,because I can not choose appropriate loop functions the plot
%of question d can not display in this document.This means that my matlab
%code can not execute the code for both question c and question d at the
%same time.
%In the task3,for question b my method to reduce the error in temperature
%may not suitable because it hard to read many measured results at the same
%time.For question c and question d because of the inappropriate loops used
%Sometimes the LED lights don't show constant light, they just flash.

%Future improvement
%Because aero1005 has the content on both electric and matlab code,in the
%next year, I think for coursework of this course can connect the knowledge
%for electric and matlab more closly.

%2.Because in the year 2 autumn semster we do not have final exam and in
%the year 2 spring semster we have 6 course final exam,I think put more
%coursework in the autumn semster,which makes us more relaxed.

%Finally, thanks for Dr.Amin,Dr.Long and the phd student from EEE who
%helped us during this coursework.(Sorry I didn't hear his name in class
%clearly), his name maybe hanwen).You are professional and patient
%You make me feel studying in Aero1005 is a happy period.


