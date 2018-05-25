clear all;
clc;
val=importdata('E:\matlab\08730_01m.mat');
real_val=val(1,:)-val(2,:);
%arduino=serial('COM11','BaudRate',9600);
%fopen(arduino);

time=0:0.005:25;
lh=plot(time,zeros(1,length(time)));
%th=line(time,zeros(1,length(time)));
%set(gca,'Ylim',[-400,400]);

%com_array=zeros(1,240);
%index=1;
val_fil_low=zeros(1,length(time));
val_fil_high=zeros(1,length(time));
val_fil_diff=zeros(1,length(time));
val_square=zeros(1,length(time));
threshold=zeros(1,length(time));
drawnow
tiny_timer=0;
t=1;
while true
    if t<4
        sample=real_val(t);
        v=get(lh,'ydata');
        v(t)=sample;
        set(lh,'ydata',v);
        drawnow
        t=t+1;
        while tiny_timer<7800
            tiny_timer=tiny_timer+1;
        end
        tiny_timer=0;
    else
        val_fil_low(t)=0.0279*real_val(t)+0.0557*real_val(t-1)+0.0279*real_val(t-2)+1.4755*val_fil_low(t-1)-0.5869*val_fil_low(t-2);
        val_fil_high(t)=0.9846*val_fil_low(t)-1.9691*val_fil_low(t-1)+0.9846*val_fil_low(t-2)+1.9689*val_fil_high(t-1)-0.9694*val_fil_high(t-2);
        val_fil_diff(t)=0.25*val_fil_high(t)+0.125*val_fil_high(t-1)-0.125*val_fil_high(t-2)-0.25*val_fil_high(t-3);
        val_square(t)=val_fil_diff(t).^2;
        threshold(t)=max(val_square(t-3),val_square(t))/3;
        real_thresh=max(threshold);
        if (val_square(t)<=real_thresh)&&(val_square(t-1)>=real_thresh)
            fprintf('peakfound\n');
        %locs=t;
        %pks=real_val(t);
        %th = text(locs,pks,'\bullet');
        end
        sample=real_val(t);
        v=get(lh,'ydata');
        v(t)=sample;
        set(lh,'ydata',v);
        drawnow
        t=t+1;
        while tiny_timer<7800
            tiny_timer=tiny_timer+1;
        end
        tiny_timer=0;
    end
    if t==5001
        break
    end
end
%plot(time,val_square);
