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

% Last Modified by GUIDE v2.5 10-Mar-2018 18:06:42

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


% The timer
handles.timer = timer(...
    'ExecutionMode','FixedRate',...
    'Period', 0.001,...
    'TimerFcn', {@timerFcn,hObject});
handles.follow = false;
handles.control = false;
% UIWAIT makes try1 wait for user response (see UIRESUME)
% uiwait(handles.figure1);

%data that controls arduino 

% Update handles structure



handles.data = '0 a';
guidata(hObject, handles);
%arduino
clear arduino;
if ~isempty(instrfind)
     fclose(instrfind);
      delete(instrfind);
end
handles.arduino=serial('COM4','BaudRate',19200);
fopen(handles.arduino);
%handles.arduino = arduino;
%handles.data = '0 a';
guidata(hObject,handles);
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
        handles.follow = true;
        handles.control = false;
        disp('Follow heart beats...');
        guidata(hObject, handles);
    case 'Control LEDs'
        handles.control = true;
        handles.follow = false;
        disp('Control LEDs...');
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


% --- Executes on slider movement.  (Frequency) 
function slider3_Callback(hObject, eventdata, handles)
% hObject    handle to slider3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)\
% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider

sliderValue=get(handles.slider3, 'Value');
herz = num2str(sliderValue) ;
set(handles.text6,'String',herz);
if(sliderValue >= 0 && sliderValue < 5)
    fre = handles.data;
    fre(3) = 'a';
    handles.data = fre;
    guidata(hObject,handles); 
    fprintf(handles.arduino,'%s',handles.data); % send answer variable content to arduino
end

if(sliderValue >= 5 && sliderValue < 10)
    fre = handles.data;
    fre(3) = 'b';
    handles.data = fre;
    guidata(hObject,handles); 
    fprintf(handles.arduino,'%s',handles.data); 
end

if(sliderValue >= 10 && sliderValue < 15)
    fre = handles.data;
    fre(3) = 'c';
    handles.data = fre;
    guidata(hObject,handles); 
    fprintf(handles.arduino,'%s',handles.data); 
end

if(sliderValue >= 15 && sliderValue < 20)
    fre = handles.data;
    fre(3) = 'd';
    handles.data = fre;
    guidata(hObject,handles); 
    fprintf(handles.arduino,'%s',handles.data); 
    
end

if(sliderValue == 20 )
    fre = handles.data;
    fre(3) = 'e';
    handles.data = fre;
    guidata(hObject,handles); 
    fprintf(handles.arduino,'%s',handles.data); 
   
end
end

% --- Executes during object creation, after setting all properties. (Frequency)
function slider3_CreateFcn(hObject, eventdata, handles)
% hObject    handle to slider3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
% set(handles.slider3, 'Min', 0);
% set(handles.slider3, 'max', 200);
% set(handles.slider3, 'Value', 0);
guidata(hObject,handles); 
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end
end


% --- Executes on button press in pushbutton4. // red
function pushbutton4_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
%handles.answer = 1;
color = handles.data;
color(1) = '1';
handles.data = color;
guidata(hObject,handles); 
fprintf(handles.arduino,'%s',handles.data); % send answer variable content to arduino
end

% --- Executes on button press in pushbutton5. //blue
function pushbutton5_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton5 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

color = handles.data;
color(1) = '2';
handles.data = color;
guidata(hObject,handles); 
fprintf(handles.arduino,'%s',handles.data); 

end

% --- Executes on button press in pushbutton6. //green
function pushbutton6_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton6 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
color = handles.data;
color(1) = '3';
handles.data = color;
guidata(hObject,handles); 
fprintf(handles.arduino,'%s',handles.data);
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
function pushbutton7_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton7 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


end

% --- Executes on button press in pushbutton8.
function pushbutton8_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton8 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

end

function timerFcn(hObject, eventdata, hfigure)
handles = guidata(hfigure);
global GO;
global TIME;
%GO = false;
TIME = 60.0;
stop(handles.timer);
end



% function pauseFcn(varargin, hObject, eventdata, handles)
%     global start_time;
%     global Stopped;
%     global TIME;
%     global str;
%     Stopped = 1;
%     elapsed_time = etime(clock,start_time);
%     TIME = TIME + elapsed_time;
%     str = formatTimeFcn(TIME);
%     set(handles.text7,'String',str);
%     set(handles.pushbutton7,'Callback',@startFcn);
% end

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

if strcmp(get(handles.timer, 'Running'), 'on')
    stop(handles.timer);
end

delete(handles.timer);

delete(hObject);
end


% --- Executes on button press in pushbutton11. Stop button 
function pushbutton11_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton11 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
color = handles.data;
color(1) = '0';
handles.data = color;
guidata(hObject,handles); 
fprintf(handles.arduino,'%s',handles.data);
fclose(arduino);
end
