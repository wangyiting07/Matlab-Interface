clear all;
clear a;
a = arduino('COM4','Uno');
arduino=serial('COM4','BaudRate', 9600);
fopen(arduino);
pin = {'D11','D10','D9'};
while(answer)
    writeDigitalPin(a,pin{3},1);
    pause(1);
    writeDigitalPin(a,pin{3},0);
    pause(1);
    fprintf(arduino,'%s',answer);
    answer=input('Enter led value 1 or 2 or 0: ');
    pause(1);
end
fclose(arduino);