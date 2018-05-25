% instantiate the library
disp('Loading the library...');
lib_eye_blink = lsl_loadlib();
lib_bad_channel = lsl_loadlib();

% resolve a stream...
disp('Resolving a Markers stream...');
result_eye_blink = {};
result_bad_channel = {};
while isempty(result_eye_blink)
    result_eye_blink = lsl_resolve_byprop(lib_eye_blink,'name','EyeBlink');
end
while isempty(result_bad_channel)
    result_bad_channel = lsl_resolve_byprop(lib_bad_channel,'name','BadChannel');
end

% create a new inlet
disp('Opening an inlet...');
inlet_eye_blink = lsl_inlet(result_eye_blink{1});
inlet_bad_channel = lsl_inlet(result_bad_channel{1});

disp('Now receiving data...');
while true
    % get data from the inlet
    [mrks_eye_blink,ts_eye_blink] = inlet_eye_blink.pull_sample();
    % and display it
    fprintf('eyeblink %s at time %.5f\n',mrks_eye_blink{1},ts_eye_blink);
    
    [mrks_bad_channel,ts_bad_channel] = inlet_bad_channel.pull_sample();
    % and display it
    fprintf('badchannel %s at time %.5f\n',mrks_bad_channel{1},ts_bad_channel);
end
