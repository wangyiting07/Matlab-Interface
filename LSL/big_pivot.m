function varargout = try1(varargin)
% TRY1 MATLAB code for try1.fig
%      TRY1, by itself, creates a new TRY1 or raises the existing
%      singleton*.
%
%      H = TRY1 returns the handle to a new TRY1 or the handle to
%      the existing singleton*.
%
%      TRY1('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in TRY1.M with the given input arguments.
%
%      TRY1('Property','Value',...) creates a new TRY1 or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before try1_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to try1_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help try1

% Last Modified by GUIDE v2.5 30-Apr-2018 15:23:50

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @try1_OpeningFcn, ...
                   'gui_OutputFcn',  @try1_OutputFcn, ...
                   'gui_LayoutFcn',  [], ...
                   'gui_Callback',   []);
if nargin && ischar(varargin{1})
    gui_State.gui_Callback = str2func(varargin{1});
end

if nargout
    [varargout{1:nargout}] = gui_mainfcn(gui_State, varargin{:});
else
    gui_mainfcn(gui_State, varargin{:});
end
end
% End initialization code - DO NOT EDIT

% --- Executes just before try1 is made visible.
function try1_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to try1 (see VARARGIN)

% Choose default command line output for try1
handles.output = hObject;

% The slider for changing frequency
set(handles.slider3, 'Min', 0);
set(handles.slider3, 'Max', 20);
set(handles.slider3, 'Value', 0);
set(handles.slider3, 'SliderStep',[5/20,5/20]);

set(handles.slider4, 'Min', 0);
set(handles.slider4, 'Max', 20);
set(handles.slider4, 'Value', 0);
set(handles.slider4, 'SliderStep',[5/20,5/20]);

% Global variables, may be optimized by pushed into handles.
global TIME;
global lib;
global result;
global inlet;
global blinking1;
global blinking2;
blinking1 = true;
blinking2 = true;

lib = lsl_loadlib();
result = {};

handles.follow1 = false;
handles.control1 = false;
handles.follow2 = false;
handles.control2 = false;
% UIWAIT makes try1 wait for user response (see UIRESUME)
% uiwait(handles.figure1);

%define the pin array;
handles.pin1 = {'D11','D10','D9'};
handles.pin2 = {'D6','D5','D3'};

% Update handles structure
guidata(hObject, handles);

%setup the timer
% thisfig = ancestor(hObject,'figure');
% handles.t1_5 = timer('TimerFcn',@(hObject, eventdata)blinkled1(hObject, eventdata,guidata(thisfig)), ...  % timer function, has to specific the handle to the GUI,
%           'ExecutionMode','fixedRate', ...
%           'BusyMode','queue',...
%            'Period',0.4);
%        
% handles.t1_10 = timer('TimerFcn',@(hObject, eventdata)blinkled1(hObject, eventdata,guidata(thisfig)), ...  % timer function, has to specific the handle to the GUI,
%           'ExecutionMode','fixedRate', ... 
%           'BusyMode','queue',...
%            'Period',0.2);
% 
% handles.t1_15 = timer('TimerFcn',@(hObject, eventdata)blinkled1(hObject, eventdata,guidata(thisfig)), ...  % timer function, has to specific the handle to the GUI,
%               'ExecutionMode','fixedRate', ... 
%               'BusyMode','queue',...
%                'Period',0.12);
% handles.t1_20 = timer('TimerFcn',@(hObject, eventdata)blinkled1(hObject, eventdata,guidata(thisfig)), ...  % timer function, has to specific the handle to the GUI,
%               'ExecutionMode','fixedRate', ... 
%               'BusyMode','queue',...
%                'Period',0.1);
%        
% handles.t2_5 = timer('TimerFcn',@(hObject, eventdata)blinkled2(hObject, eventdata,guidata(thisfig)), ...  % timer function, has to specific the handle to the GUI,
%           'ExecutionMode','fixedRate', ... 
%           'BusyMode','queue',...
%            'Period',0.4);
% handles.t2_10 = timer('TimerFcn',@(hObject, eventdata)blinkled2(hObject, eventdata,guidata(thisfig)), ...  % timer function, has to specific the handle to the GUI,
%           'ExecutionMode','fixedRate', ... 
%           'BusyMode','queue',...
%            'Period',0.2);
% handles.t2_15 = timer('TimerFcn',@(hObject, eventdata)blinkled2(hObject, eventdata,guidata(thisfig)), ...  % timer function, has to specific the handle to the GUI,
%           'ExecutionMode','fixedRate', ... 
%           'BusyMode','queue',...
%            'Period',0.12);
% handles.t2_20 = timer('TimerFcn',@(hObject, eventdata)blinkled2(hObject, eventdata,guidata(thisfig)), ...  % timer function, has to specific the handle to the GUI,
%           'ExecutionMode','fixedRate', ... 
%           'BusyMode','queue',...
%            'Period',0.1);       
%arduino

clear arduino;
if ~isempty(instrfind)
     fclose(instrfind);
      delete(instrfind);
end
% if ~isempty(seriallist)
clear handles.a;
handles.a = arduino('COM4','Uno');
guidata(hObject, handles);
% else
%     disp('Please check Arduino connection');
% end

end

function blinkled1(hObject, eventdata,handles)
    global blinking1;
    for idx = 1:3
        writeDigitalPin(handles.a,handles.pin1{idx},0);
    end
    if(blinking1 == true)
        writeDigitalPin(handles.a,handles.prepin1,1);
        blinking1 = false;
        
    end
    if(blinking1 == false)
        writeDigitalPin(handles.a,handles.prepin1,0);
        blinking1 = true;
        
    end
end

function blinkled2(hObject, eventdata,handles)
    global blinking2;
    for idx = 1:3
        writeDigitalPin(handles.a,handles.pin2{idx},0);
    end
    if(blinking2 == true)
        writeDigitalPin(handles.a,handles.prepin2,1);
        blinking2 = false;
    end
    if(blinking2 == false)
        writeDigitalPin(handles.a,handles.prepin2,0);
        blinking2 = true;
    end
end



% --- Outputs from this function are returned to the command line.
function varargout = try1_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;
end



% --- Executes on selection change in popupmenu2.
function popupmenu2_Callback(hObject, eventdata, handles)
% hObject    handle to popupmenu2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns popupmenu2 contents as cell array
%        contents{get(hObject,'Value')} returns selected item from popupmenu2
str = get(hObject, 'String');
val = get(hObject, 'Value');
switch str{val}
    case 'Follow Heart Beats'
        handles.follow1 = true;
        handles.control1 = false;
        for idx = 1:3
            writeDigitalPin(handles.a,handles.pin1{idx},0);
        end
        disp('Follow subject1 heart beats...');
        guidata(hObject, handles);
    case 'Control LEDs'
        handles.control1 = true;
        handles.follow1 = false;
        disp('Control subject1 LEDs...');
        guidata(hObject, handles);
end
end


% --- Executes during object creation, after setting all properties.
function popupmenu2_CreateFcn(hObject, eventdata, handles)
% hObject    handle to popupmenu2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
end


% --- Executes on slider movement. first person's frequency 
function slider3_Callback(hObject, eventdata, handles)
% hObject    handle to slider3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)\
% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider
sliderValue=get(handles.slider3, 'Value');
herz = num2str(sliderValue) ;
set(handles.text6,'String',herz);
if (handles.control1 == true)
    if(sliderValue >= 0 && sliderValue < 5)
        stop(handles.t1_5);
        stop(handles.t1_10);
        stop(handles.t1_15);
        stop(handles.t1_20);
    end

    if(sliderValue >= 5 && sliderValue < 10)
        stop(handles.t1_10);
        stop(handles.t1_15);
        stop(handles.t1_20);
        start(handles.t1_5);
    end

    if(sliderValue >= 10 && sliderValue < 15)
        stop(handles.t1_5);
        stop(handles.t1_15);
        stop(handles.t1_20);
        start(handles.t1_10);
    end

    if(sliderValue >= 15 && sliderValue < 20)
        stop(handles.t1_5);
        stop(handles.t1_10);
        stop(handles.t1_20);
        start(handles.t1_15);

    end

    if(sliderValue == 20 )
        stop(handles.t1_5);
        stop(handles.t1_10);
        stop(handles.t1_15);
        start(handles.t1_20);

    end
end
end

% --- Executes during object creation, after setting all properties.
function slider3_CreateFcn(hObject, eventdata, handles)
% hObject    handle to slider3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end
end



% --- Executes on button press in pushbutton4. person 1 red
function pushbutton4_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
for idx = 1:3
    writeDigitalPin(handles.a,handles.pin1{idx},0);
end
writeDigitalPin(handles.a,handles.pin1{1},1);
handles.prepin1 = handles.pin1{1};
guidata(hObject, handles);
end

% --- Executes on button press in pushbutton5.person 1 blue
function pushbutton5_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton5 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

for idx = 1:3
    writeDigitalPin(handles.a,handles.pin1{idx},0);
end
writeDigitalPin(handles.a,handles.pin1{3},1);
handles.prepin1 = handles.pin1{3};
guidata(hObject, handles);
end

% --- Executes on button press in pushbutton6.person 1 green
function pushbutton6_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton6 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

for idx = 1:3
    writeDigitalPin(handles.a,handles.pin1{idx},0);
end
writeDigitalPin(handles.a,handles.pin1{2},1);
handles.prepin1 = handles.pin1{2};
guidata(hObject, handles);
end

% --- Executes during object creation, after setting all properties.
function text6_CreateFcn(hObject, eventdata, handles)
% hObject    handle to text6 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called
end

% --- Executes during object creation, after setting all properties.
function text7_CreateFcn(hObject, eventdata, handles)
% hObject    handle to text7 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called
%set(handles.text7,'String','00:00:000');
end


% --- Executes on button press in pushbutton7.
% --- Contains the real-time drawing of heart beat and peak detection.
function pushbutton7_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton7 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Global variables, can be optimazed by pushed into handles in the future.
global lib;
global result;
global inlet;
global TIME;
TIME = 60.0;
str = formatTimeFcn(TIME);
set(handles.text7,'String',str);
% Axes handles, used for drawing in axes of GUI.
axesHandle1 = handles.axes1;
axesHandle3 = handles.axes3;
handles.cameraCleared = 0;
guidata(hObject, handles);


% LSL connection, more details of LSL please google LSL-matlab.
while isempty(result)
    result = lsl_resolve_byprop(lib, 'type', 'EEG');
end
inlet = lsl_inlet(result{1});

% Variables used for computing the peak, may be optimazed in the future.
time_elap = 0:1/400:5;
time_total = 0:1/400:60;
low = zeros(2, length(time_total));
high = zeros(2, length(time_total));
diff = zeros(2, length(time_total));
square = zeros(2, length(time_total));
threshold = zeros(2, length(time_total));
hb_disp = zeros(2, length(time_elap));
hb_total = zeros(2, length(time_total));
lh1 = plot(axesHandle1, time_elap, hb_disp(1, :));
lh2 = plot(axesHandle3, time_elap, hb_disp(2, :));
t = 1;
count = 1;
while TIME > 0
    % Tiny pause needed for responding to stop callback 
    pause(0.0001);
    handles = guidata(hObject);
    set(axesHandle1, 'YLim', [-400 400]);
    set(axesHandle3, 'YLim', [-400 400]);
    
    % Check whether stopped
    if handles.cameraCleared == 1
        break;
    end
    
    % The sample data at each iteration from Ganglion
    v = inlet.pull_sample();
    
    % Wipe out the noise
    if (abs(v(1)) > 20)
        hb_total(1, count) = v(1);
    else
        hb_total(1, count) = 0;
    end
    if (abs(v(2)) > 20)
        hb_total(2, count) = v(2);
    else
        hb_total(2, count) = 0;
    end
    
    % Pan-Tompkins Algorithm for peak extraction
    if ((handles.follow1 == true || handles.follow2) == true && count >= 4)
        low(:, count) = 0.0279*hb_total(:, count)+0.0557*hb_total(:, count-1)...
            +0.0279*hb_total(:, count-2)+1.4755*low(:, count-1)-0.5869*low(:, count-2);
        high(:, count)=0.9846*low(:, count)-1.9691*low(:, count-1)+0.9846*low(:, count-2)...
            +1.9689*high(:, count-1)-0.9694*high(:, count-2);
        diff(:, count)=0.25*high(:, count)+0.125*high(:, count-1)-0.125*high(:, count-2)...
            -0.25*high(:, count-3);
        square(:, count) = diff(:, count).^2;
        threshold(:, count) = max(square(:, count-3),square(:, count))/3;
        real_thresh = [max(threshold(1, :)), max(threshold(2, :))];
        if (handles.follow1 == true)
            if (square(1, count)<=real_thresh(1))&&(square(1, count-1)>=real_thresh(1))
                writeDigitalPin(handles.a,'D9',1);
                disp('follow first heart');
                pause(0.01);
                writeDigitalPin(handles.a,'D9',0);
           
            end
        end
        if (handles.follow2 == true)
            if (square(2, count)<=real_thresh(2))&&(square(2, count-1)>=real_thresh(2))
                writeDigitalPin(handles.a,'D3',1);
                pause(0.01);
                writeDigitalPin(handles.a,'D3',0);
            
            end
        end
    end
    
    % Display on the axes
    hb = hb_total(:, t: t + 2000);
    set(lh1, 'ydata', hb(1, :));
    set(lh2, 'ydata', hb(2, :));
    count = count + 1;
    if count > 2001
        t = t + 1;
    end
    
    % Display time
    TIME = TIME - 0.002;
    str = formatTimeFcn(TIME);
    set(handles.text7,'String',str);
end

handles.subject1Data = hb_total(1, :);
handles.subject2Data = hb_total(2, :);
guidata(hObject, handles);

end

% --- Executes on button press in pushbutton8.
function pushbutton8_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton8 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global TIME;
handles.cameraCleared = 1;
guidata(hObject, handles);
disp('stop');

TIME = 60.0;
set(handles.text7,'String','00:00:00.000');
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

function figure1_CloseRequestFcn(hObject, eventdata, handles)

% if ~isempty(seriallist)
%     fclose(handles.arduino);
% end
delete(handles.t1_5);
delete(handles.t1_10);
delete(handles.t2_5);
delete(hObject);
end

% --- Executes on button press in pushbutton9.person 2 red 
function pushbutton9_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton9 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
for idx = 1:3
    writeDigitalPin(handles.a,handles.pin2{idx},0);
end
writeDigitalPin(handles.a,handles.pin2{1},1);
handles.prepin2 = handles.pin2{1};
guidata(hObject, handles);
end


% --- Executes on button press in pushbutton10.person 2 blue
function pushbutton10_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton10 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
for idx = 1:3
    writeDigitalPin(handles.a,handles.pin2{idx},0);
end
writeDigitalPin(handles.a,handles.pin2{3},1);
handles.prepin2 = handles.pin2{3};
guidata(hObject, handles);
end

% --- Executes on button press in pushbutton11.person 2 green
function pushbutton11_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton11 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
for idx = 1:3
    writeDigitalPin(handles.a,handles.pin2{idx},0);
end
writeDigitalPin(handles.a,handles.pin2{2},1);
handles.prepin2 = handles.pin2{2};
guidata(hObject, handles);
end

% --- Executes on  movement.
function slider4_Callback(hObject, eventdata, handles)
% hObject    handle to slider4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider
sliderValue=get(handles.slider4, 'Value');
herz = num2str(sliderValue) ;
set(handles.text14,'String',herz);
if (handles.control2 == true)
    if(sliderValue >= 0 && sliderValue < 5)
        stop(handles.t2_5);
        stop(handles.t2_10);
        stop(handles.t2_15);
        stop(handles.t2_20);
    end

    if(sliderValue >= 5 && sliderValue < 10)
        stop(handles.t2_10);
        stop(handles.t2_15);
        stop(handles.t2_20);
        start(handles.t2_5);
    end

    if(sliderValue >= 10 && sliderValue < 15)
        stop(handles.t2_5);
        stop(handles.t2_15);
        stop(handles.t2_20);
        start(handles.t2_10);
    end

    if(sliderValue >= 15 && sliderValue < 20)
        stop(handles.t2_5);
        stop(handles.t2_10);
        stop(handles.t2_20);
        start(handles.t2_15);

    end

    if(sliderValue == 20 )
        stop(handles.t2_5);
        stop(handles.t2_10);
        stop(handles.t2_15);
        start(handles.t2_20);

    end
end
end

% --- Executes during object creation, after setting all properties.
function slider4_CreateFcn(hObject, eventdata, handles)
% hObject    handle to slider4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end
end

% --- Executes on selection change in popupmenu3.
function popupmenu3_Callback(hObject, eventdata, handles)
% hObject    handle to popupmenu3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns popupmenu3 contents as cell array
%        contents{get(hObject,'Value')} returns selected item from popupmenu3
str = get(hObject, 'String');
val = get(hObject, 'Value');
switch str{val}
    case 'Follow Heart Beats'
        handles.follow2 = true;
        handles.control2 = false;
        disp('Follow subject2 heart beats...');
        for idx = 1:3
            writeDigitalPin(handles.a,handles.pin2{idx},0);
        end
        guidata(hObjects,handles);
    case 'Control LEDs'
        handles.control2 = true;
        handles.follow2 = false;
        disp('Control subject2 LEDs...');
        guidata(hObject,handles);
end
end

% --- Executes during object creation, after setting all properties.
function popupmenu3_CreateFcn(hObject, eventdata, handles)
% hObject    handle to popupmenu3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
end


% --- Executes on button press in pushbutton12.
function pushbutton12_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton12 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

for idx = 1:3
    writeDigitalPin(handles.a,handles.pin1{idx},0);
    writeDigitalPin(handles.a,handles.pin2{idx},0);
end
guidata(hObject, handles);
end


% --- Executes on button press in pushbutton13.
function pushbutton13_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton13 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
filename = uiputfile('Subject1.csv');
if (filename ~= 0)
    data = handles.subject1Data;
    csvwrite(filename, data);
    disp('CSV files saved in local folder.');
else
    disp('Saving cancelled');
end
end


% --- Executes on button press in pushbutton14.
function pushbutton14_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton14 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
filename = uiputfile('Subject2.csv');
if (filename ~= 0)
    data = handles.subject2Data;
    csvwrite(filename, data);
    disp('CSV files saved in local folder.');
else
    disp('Saving cancelled');
end
end
