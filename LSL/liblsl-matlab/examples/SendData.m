%% instantiate the library
disp('Loading library...');
lib = lsl_loadlib();

% make a new stream outlet
disp('Creating a new streaminfo...');
info = lsl_streaminfo(lib,'MetricData','METRIC',8,100,'cf_float32','UUID123456');

disp('Opening an outlet...');
outlet = lsl_outlet(info);

% send data into the outlet, sample by sample
disp('Now transmitting data...');
phase = 1:8;
while true
    push_result = sin(2*pi*phase/100);
    disp(push_result);
    outlet.push_sample(push_result);
    phase = phase + 1;
    pause(0.1);
end