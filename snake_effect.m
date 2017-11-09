  function [snake_matrix] = snake_effect(modulation_type, SOA_ms)         


%blur_type will define waht kind of modulation to be used in output_vector_modulated
switch modulation_type
    case 1
        modulation_type = 'sine';
    case 2
        modulation_type = 'exponential';
    case 3
        modulation_type = 'linear';
    case 4
        modulation_type = 'gaussian';
    case 5
        modulation_type = 'sine_sq';
    otherwise
        modulation_type = ' ';
end

%otuput_vector_mod corrects time and removes tactor number
stimuli  = output_vector_mod (300, 1690, 1, modulation_type);
                            %(f_1, t(ms),int1, mod_type )


%creating 24-channel matrix
snake_matrix = zeros(3000e2,24);


%determining time variables for each set of stimuli
SOA   = round(SOA_ms*44.379354724); %converting SOA(ms) to SOA in right number of rows
a_on  = 300e2;         a_off = 1050e2-1;
b_on  = 300e2+SOA;     b_off = 1050e2+SOA-1; 
c_on  = 300e2+2*SOA;   c_off = 1050e2+2*SOA-1;
d_on  = 300e2+3*SOA;   d_off = 1050e2+3*SOA-1;
e_on  = 300e2+4*SOA;   e_off = 1050e2+4*SOA-1;
f_on  = 300e2+5*SOA;   f_off = 1050e2+5*SOA-1;

    %a
    for i=a_on:a_off
        snake_matrix(i,1) = stimuli(i- a_on+1);
        snake_matrix(i,2) = stimuli(i- a_on+1);
    end

    %b
    for i=b_on:b_off
        snake_matrix(i,5) = stimuli(i- b_on+1);
        snake_matrix(i,6) = stimuli(i- b_on+1);
    end
    
    %c
    for i=c_on:c_off
        snake_matrix(i,9)  = stimuli(i- c_on+1);
        snake_matrix(i,10) = stimuli(i- c_on+1);
    end
    
    %d
    for i=d_on:d_off
        snake_matrix(i,13) = stimuli(i- d_on+1);
        snake_matrix(i,14) = stimuli(i- d_on+1);
    end
    
    %e
    for i=e_on:e_off
        snake_matrix(i,17) = stimuli(i- e_on+1);
        snake_matrix(i,18) = stimuli(i- e_on+1);
    end
    
    %f
    for i=f_on:f_off
        snake_matrix(i,21) = stimuli(i- f_on+1);
        snake_matrix(i,22) = stimuli(i- f_on+1);
    end

%plotting the signal    
% x_axis = (1:length(snake_matrix(:,1))).*2.73e-5;    
% figure
% plot(x_axis,snake_matrix);
% hold on;
% xlabel('Time [s]', 'fontsize', 15);
% ylabel('Signal amplitude', 'fontsize', 15);
% axis([0 Inf  -Inf Inf]); 
% str = sprintf('Signals in tactors, SOA= %d ms', SOA_ms);
% title(str,'fontsize', 15);
% hold off;

end

