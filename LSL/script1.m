thisfig = ancestor(hObject,'figure');
handles.t1_5 = timer('TimerFcn',@(hObject, eventdata)blinkled1(hObject, eventdata,guidata(thisfig)), ...  % timer function, has to specific the handle to the GUI,
          'ExecutionMode','fixedRate', ...
          'BusyMode','queue',...
           'Period',0.4);
       
handles.t1_10 = timer('TimerFcn',@(hObject, eventdata)blinkled1(hObject, eventdata,guidata(thisfig)), ...  % timer function, has to specific the handle to the GUI,
          'ExecutionMode','fixedRate', ... 
          'BusyMode','queue',...
           'Period',0.2);

handles.t1_15 = timer('TimerFcn',@(hObject, eventdata)blinkled1(hObject, eventdata,guidata(thisfig)), ...  % timer function, has to specific the handle to the GUI,
              'ExecutionMode','fixedRate', ... 
              'BusyMode','queue',...
               'Period',0.12);
handles.t1_20 = timer('TimerFcn',@(hObject, eventdata)blinkled1(hObject, eventdata,guidata(thisfig)), ...  % timer function, has to specific the handle to the GUI,
              'ExecutionMode','fixedRate', ... 
              'BusyMode','queue',...
               'Period',0.1);
       
handles.t2_5 = timer('TimerFcn',@(hObject, eventdata)blinkled2(hObject, eventdata,guidata(thisfig)), ...  % timer function, has to specific the handle to the GUI,
          'ExecutionMode','fixedRate', ... 
          'BusyMode','queue',...
           'Period',0.4);
handles.t2_10 = timer('TimerFcn',@(hObject, eventdata)blinkled2(hObject, eventdata,guidata(thisfig)), ...  % timer function, has to specific the handle to the GUI,
          'ExecutionMode','fixedRate', ... 
          'BusyMode','queue',...
           'Period',0.2);
handles.t2_15 = timer('TimerFcn',@(hObject, eventdata)blinkled2(hObject, eventdata,guidata(thisfig)), ...  % timer function, has to specific the handle to the GUI,
          'ExecutionMode','fixedRate', ... 
          'BusyMode','queue',...
           'Period',0.12);
handles.t2_20 = timer('TimerFcn',@(hObject, eventdata)blinkled2(hObject, eventdata,guidata(thisfig)), ...  % timer function, has to specific the handle to the GUI,
          'ExecutionMode','fixedRate', ... 
          'BusyMode','queue',...
           'Period',0.1);       