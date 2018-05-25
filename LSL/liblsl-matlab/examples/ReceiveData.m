
clear all;
clc;
%%arduino=serial('COM11','BaudRate',9600);
%%fopen(arduino);
time=0:0.0013:30;
%pks=zeros(1,length(time));
%locs=zeros(1,length(time));
val=zeros(1,length(time));
val_fil_low=zeros(1,length(time));
val_fil_high=zeros(1,length(time));
val_fil_diff=zeros(1,length(time));
val_square=zeros(1,length(time));
threshold=zeros(1,length(time));

disp('Loading the library...');
lib = lsl_loadlib();

% resolve a stream...
disp('Resolving an EEG stream...');
result = {};
while isempty(result)
    result = lsl_resolve_byprop(lib,'type','EEG'); end

% create a new inlet
disp('Opening an inlet...');
inlet = lsl_inlet(result{1});

disp('Now receiving data...');
%data_set=[];
%time_set=[];

for t=4:length(time)
    val(t)=inlet.pull_sample();
    val_fil_low(t)=0.0279*val(t)+0.0557*val(t-1)+0.0279*val(t-2)+1.4755*val_fil_low(t-1)-0.5869*val_fil_low(t-2);
    val_fil_high(t)=0.9846*val_fil_low(t)-1.9691*val_fil_low(t-1)+0.9846*val_fil_low(t-2)+1.9689*val_fil_high(t-1)-0.9694*val_fil_high(t-2);
    val_fil_diff(t)=0.25*val_fil_high(t)+0.125*val_fil_high(t-1)-0.125*val_fil_high(t-2)-0.25*val_fil_high(t-3);
    val_square(t)=val_fil_diff(t).^2;
    threshold(t)=max(val_square(t-3),val_square(t))/3;
    real_thresh=max(threshold);
    %%fprintf('%.2f\n',val_square(t));
    if (val_square(t)<=real_thresh)&&(val_square(t-1)>=real_thresh)
        answer=1;
        fprintf("peak");
    else
        answer=0;
        fprintf('%.2f\n',answer);
    end
    %sample=real_val(t);
    %v=get(lh,'ydata');
    %v(t)=sample;
    %set(lh,'ydata',v);
    %dot=get(th,'string');
    %set(th,'string',dot);
    %drawnow
    
end

%%fclose(arduino);
