%Simple analog diaplay
figure(2); clf;
clear all
%trash any existing analog i/o objects
delete(daqfind);

%define the input
adaptor = 'nidaq';
adaptorData = daqhwinfo(adaptor);
%get the adaptor id, 
%but note that the brackets are curly {}
%because the struct is an cellarray
id = adaptorData.InstalledBoardIds{1} ;
% Create an analog input object with one channel.
ai = analoginput(adaptor, id);
ch = addchannel(ai, [0]);

dt = 0.1;
maxt = 10;
time = 0:dt:maxt;
%build a plot with zero data
lh = plot(time, zeros(1,length(time)));
set(gca, 'YLim', [-5 5]);
%build a text string on the plot
th = text(0.5,4,'');
%and draw it 
drawnow

%step through time getting samples and plotting them
for index=1:length(time)
    %using getsample does not require that you start the ai object
    %EXCEPT on winsound
    sample = getsample(ai);
    %drop the new sample into the existing plot
    v = get(lh, 'ydata');
    v(index) = sample;
    set(lh, 'ydata', v)
    %update a time-counter
    set(th,'string',num2str(index*dt-dt));
    drawnow
    %delay to make dt the actual time step 
    pause(dt);  
end
%trash the input object
delete(ai);




