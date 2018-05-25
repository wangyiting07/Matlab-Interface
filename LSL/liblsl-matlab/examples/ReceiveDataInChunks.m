addpath(genpath('E:\matlab\LSL\liblsl-matlab\examples'))

% instantiate the library
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
tiny_timer=0;
disp('Now receiving chunked data...');
while true
    % get chunk from the inlet
    [ves,time] = inlet.pull_sample();
     %for s=1:length(stamps)
         % and display it
    fprintf('%.2f\t',ves);
    fprintf('%.5f\n',time);
    
    
    %end
%    if ~isempty(chunk)
%    plot(chunk(1,:));
%    ylim([-20 120]);
%    else
%    pause(0.01);
end