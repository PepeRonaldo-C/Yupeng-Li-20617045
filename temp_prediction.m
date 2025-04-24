%b
function temp_prediction
cr = arduino('COM13','Uno');
redled = 'D4'; greenled = 'D7';yellowled = 'D2';%Assign different colors of LED light to different pins.
temp_recored = [];%This empty array was used to store the measured temperature.
V_0 = 0.5;%With the unit of V
T_c = 0.01;%With the unit of V/°
time_interval = 0;%Was used to set the appropriate time interval for temperature measurement loop.
while time_interval < 60
    voltage_measured = readVoltage(cr,"A1");%With the unit of V
    now_temperature = (voltage_measured-V_0)/T_c;%With the unit of °C
    temp_recored = [temp_recored,now_temperature];%Was used to store temperature measured to calculate the temperature rate.
    if length(temp_recored) > 4;%Was used to update the latest time.
        temp_recored(1) = [];
    end
    if length(temp_recored) >=2
        time_difference = (length(temp_recored)-1)*0.5;
        temp_difference = temp_recored(end)-temp_recored(1);
        changerate = temp_difference/time_difference;
        fprintf('The rate of temperature is %.3f C per second\n',changerate);%Because the initial period of tempterature measurement may not be correct,print all measured change rate to the screen so that you can check whether the measurement is accurate by looking on the screen.
    else
        disp('There is only temperature so there is no rate');
    end
    time_interval = time_interval + 1;
end
 fprintf('The accurate rate of temperature is %.3f C per second\n',changerate);%After loop the rate of temperature is close to accurate.


%c
temp_predicted =now_temperature + changerate*300;
fprintf('The current temperature is %.3f c and the predicted temperature in 5 minutes is %.3f C',now_temperature,temp_predicted);
%d
writeDigitalPin(cr,redled,0);%Close all the led at first.
writeDigitalPin(cr,greenled,0);%Close all the led at first.
writeDigitalPin(cr,yellowled,0);%Close all the led at first
rate_min = changerate*60;%Convert the unit.
if rate_min < -4
    writeDigitalPin(cr,redled,0);%Close other leds to avoid the distrubtion of other leds.
    writeDigitalPin(cr,greenled,0);%Close other leds to avoid the distrubtion of other leds.
    writeDigitalPin(cr,yellowled,1);
elseif rate_min > 4 
    writeDigitalPin(cr,yellowled,0);%Close other leds to avoid the distrubtion of other leds.
    writeDigitalPin(cr,greenled,0);%Close other leds to avoid the distrubtion of other leds.
    writeDigitalPin(cr,redled,1);
else 
    writeDigitalPin(cr,yellowled,0);%Close other leds to avoid the distrubtion of other leds.
    writeDigitalPin(cr,redled,0);%Close other leds to avoid the distrubtion of other leds.
    writeDigitalPin(cr,greenled,1);
end

end
%e The function of temp_prediction was used to monitor the rate of
%temperature change and predicted temperature in the following time.By
%switching on and off the different LED light, this function can also show whether the temperature change is at a critical value.


