function labtimer(varargin)
%LABTIMER Summary of this function goes here
%   Detailed explanation goes here

start_time = clock;
Stopped = 1;
TIME = 0;

%Figure window
hfig = figure('Name','labtimer',...
    'Numbertitle','off',...
    'Position',[600 500 350 100],...
    'Menubar','none',...
    'Resize','off',...
    'KeyPressFcn',@keyPressFcn,...
    'CloseRequestFcn',@closeRequestFcn);

%Buttons
START = uicontrol(hfig,'Style','PushButton',...
    'Position',[10 10 75 25],...
    'String','START',...
    'Callback',@startFcn);

uicontrol(hfig,'Style','PushButton',...
    'Position',[180 10 75 25],...
    'String','RESET',...
    'Callback',@resetFcn);

%Display time
DISPLAY = uicontrol(hfig,'Style','text',...
    'Position',[10 45 330 55],...
    'BackgroundColor',[0.8 0.8 0.8],...
    'FontSize',35);

set(hfig,'HandleVisibility','off');

str = formatTimeFcn(TIME);
set(DISPLAY,'String',str);

%Start timer
ltimer = timer('TimerFcn',@timerFcn,'Period',0.001,'ExecutionMode','FixedRate');
start(ltimer);

    function timerFcn(varargin)
        if ~Stopped
            elapsed_time = etime(clock, start_time);
            str = formatTimeFcn(TIME+elapsed_time);
            set(DISPLAY,'String',str);
        end
    end

    function keyPressFcn(varargin)
    end

    function startFcn(varargin)
        start_time = clock;
        Stopped = 0;
        set(START,'String','PAUSE','Callback',@pauseFcn);
    end

    function pauseFcn(varargin)
        Stopped = 1;
        elapsed_time = etime(clock,start_time);
        TIME = TIME + elapsed_time;
        str = formatTimeFcn(TIME);
        set(DISPLAY,'String',str);
        set(START,'String','Resume','Callback',@startFcn);
    end
    function resetFcn(varargin)
        Stopped = 1;
        TIME = 0;
        str = formatTimeFcn(TIME);
        set(DISPLAY,'String',str);
        set(START,'String','START','Callback',@startFcn);
    end

    function str = formatTimeFcn(float_time)
        float_time = abs(float_time);
        hrs = floor(float_time/3600);
        mins = floor(float_time/60 - 60*hrs);
        secs = float_time - 60*(mins + 60*hrs);
        h = sprintf('%1.0f:',hrs);
        m = sprintf('%1.0f:',mins);
        s = sprintf('%1.3f',secs);
        if hrs < 10
            h = sprintf('0%1.0f:',hrs);
        end
        if mins < 10
            m = sprintf('0%1.0f:',mins);
        end
        if secs < 9.9995
            s = sprintf('0%1.3f',secs);
        end
        str = [h m s];
    end

    function closeRequestFcn(varargin)
        try
            stop(ltimer)
            delete(ltimer)
        catch errmsg
            rethrow(errmsg);
        end
        closereq;
    end
end

