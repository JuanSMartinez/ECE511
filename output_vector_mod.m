function [ signal_tone_vector ] = output_vector_mod( frequency_1, duration_ms, intensity_1, modulation_type )
%this function produces a vector that will be used to build other signals

%adding a correction factor to pa_wavplay, for signal to be played correctly
%duration_ms = duration_ms+300;

sampling_frequency = 44000; %"fs" in test24chan.m -> 44k is the value to procude f=300 Hz when requesting 300 Hz in function
T            = duration_ms*100/2.25333;
time         = (0:T-1)/sampling_frequency; %vector created based in duration(ms);

%producing signal of frequency 1
tone_radians_1 = time*2*pi*frequency_1;  %"x" in test24chan
signal_tone_1  = sin(tone_radians_1);    %"s"  in test24chan

%creating sinusoidal modulator
%tone_modulator = 0:pi/(2*T):pi/2-1/(2*T);
tone_modulator = (0-1/(2*T)):pi/(T):pi-1/(T); %(pi/2-1/(2*T)):-pi/(2*T):0;
sine_modulator = sin(tone_modulator);


%creating exponential modulator
%power_modulator = -5:10/(2*T):0-1/(2*T);
power_modulator = (0-1/(2*T)):(-10/(2*T)):(-5);
exp_modulator   = exp(power_modulator);

%creating linear modulator
%angular_modulator = 0:1/T:1-1/T;
angular_modulator = 0:1/T:(1-1/T); % 1-1/T:-1/T:0;

%creating gaussian modulator
gauss_interval  = 0:1/T:1-1/T;
gauss_modulator = gaussmf(gauss_interval.*(10/gauss_interval(end)), [2.1 5]); %[2 5] 2nd value: translates signal left or right in time. 1st: gaussian gets wider or narrower 

switch modulation_type
    case 'sine'
        signal_tone_vector = intensity_1*sine_modulator.*signal_tone_1;
    case 'exponential'
        signal_tone_vector = intensity_1*exp_modulator.*signal_tone_1;
    case 'linear'
        signal_tone_vector = intensity_1*angular_modulator.*signal_tone_1;
    case 'gaussian'
        signal_tone_vector = intensity_1*gauss_modulator.*signal_tone_1;
    case 'sine_sq'
        signal_tone_vector = intensity_1*sine_modulator.*sine_modulator.*signal_tone_1;
    otherwise 
        signal_tone_vector = intensity_1.*signal_tone_1;
end

% visualizing the parameters
% figure;
% plot(sine_modulator.*signal_tone_1);
% 
% figure;
% plot(exp_modulator.*signal_tone_1);
% 
% figure;
% plot(angular_modulator.*signal_tone_1);
% 
% figure;
% plot(signal_tone_vector);

% %creating matrix for 24 channels
% signal_24_channels      = zeros(T, 24);  % creating 24-channel signal; "sig24" in test24chan
% signal_24_channels(1:T,tactor_number) = signal_tone_vector;

% playrec('play', signal_24_channels, 1:24);
end

