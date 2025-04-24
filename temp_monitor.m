%c
function temp_monitor
pepe = arduino('COM13','Uno');
redled = 'D4'; greenled = 'D7';yellowled = 'D2';%Assign different colors of LED light to different pins.
writeDigitalPin(pepe,redled,0);%Close all the led at first.
writeDigitalPin(pepe,greenled,0);%Close all the led at first.
writeDigitalPin(pepe,yellowled,0);%Close all the led at first.
temp_a = readVoltage(pepe,'A1');%temp_a was the value in the thermistor and temp_a with the unit of v
V_0 = 0.5;%With the unit of V
T_c = 0.01;%With the unit of V/°C
temp_b = (temp_a-V_0)/T_c%temp_b was the true temperature around the true enviroment(UNNC library) with the unit of °C(Celsius).
while true
if temp_b < 18
    writeDigitalPin(pepe,redled,0);%Close other leds to avoid the distrubtion of other leds.
    writeDigitalPin(pepe,greenled,0);%Close other leds to avoid the distrubtion of other leds.
    writeDigitalPin(pepe,yellowled,1);
    pause(0.5);%Used to control the yellow light to flash for 0.5s
    writeDigitalPin(pepe,yellowled,0);
    pause(0.5);%Used to control the yellow light to flash for 0.5s
elseif temp_b > 24
    writeDigitalPin(pepe,yellowled,0);%Close other leds to avoid the distrubtion of other leds.
    writeDigitalPin(pepe,greenled,0);%Close other leds to avoid the distrubtion of other leds.
    writeDigitalPin(pepe,redled,1);
    pause(0.25);%Used to control the red light to flash for 0.25s
    writeDigitalPin(pepe,redled,0);
    pause(0.25);%Used to control the red light to flash for 0.25s
else 
    writeDigitalPin(pepe,redled,0);%Close other leds to avoid the distrubtion of other leds.
    writeDigitalPin(pepe,yellowled,0);%Close other leds to avoid the distrubtion of other leds.
    writeDigitalPin(pepe,greenled,1);%Used to control the greenled show a constant light.
end
end

%d
pepe = arduino('COM13','Uno');
V_0 = 0.5;%With the unit of V
T_c = 0.01;%With the unit of V/°C
temp_loop = [];%Was used to store history temperature.
time_loop = [];%Was used to store history time.
figure
xlabel('Time(s)');
ylabel('Temperature(°C)');
title('Time vs Temperature');
hold on;
grid on;
tic;%Was used to recored time and tic means that the matlab code begin to record time.
while true %Loop can be stop by entering Ctrl +C
    temp_c = readVoltage(pepe,'A1');%temp_a was the value in the thermistor and temp_a with the unit of V
    temp_d = (temp_c-V_0)/T_c;%temp_b was the true temperature around the true enviroment(UNNC library) with the unit of °C(Celsius).
    nowtime = toc;%Was used to recored time and tic means that the matlab code ends recording time.
    temp_loop = [temp_loop,temp_d];
    time_loop = [time_loop,nowtime];
    xlim([max(0,nowtime-60),nowtime]);
    ymin = min(temp_loop);ymax = max(temp_loop);
    ylim([ymin-1e-3,ymax]);
    plot(time_loop,temp_loop);
    pause(0.2);
    drawnow;%Was used to update the plot.
end


%e
%It is important to note that the matlab code which used to control the led
%based on the temperature is the same as matlab code of this task 
%question c .Due to this, please check my code by run the matlab code of
%question c or write commond in the commond window.

%f
%It is important to note that with the aim of making code easy to read and
%check.I define the measured temperature with different name in this task
%question b and question c.So If you want to verify the consistency of the
%LED switch with the LIVE diagram update,please delete the 'clear'in the
%end of question c and change the name of variable of measured temperature.

%g 
%The function of temp_monitor.m was used to measure the temperature and
%demonstrate whether the temperature is above or below the critical 
%temperature by turn on different leds.The function can also plot the live 
% photo of time vs temperature.

%h
%shown in the flow chart.
end






