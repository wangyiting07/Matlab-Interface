function TimerCB(TimerH, EventData, Cmd, a)
switch Cmd
  case 'on'
    writeDigitalPin(a, 'D13', 1);
  case 'off'
    writeDigitalPin(a, 'D13', 0);
end
end

TimerH = timer('TimerFcn', {TimerCB, 'off', a}, ...
               'StartDelay', time, ...   % [EDITED] S -> time
               'ExecutionMode', 'SingleShot', ...
               'StartFcn', {TimerCB, 'on', a});
start(TimerH);


            