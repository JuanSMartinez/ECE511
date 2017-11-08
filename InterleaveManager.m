classdef InterleaveManager<handle
    %INTERLEAVEMANAGER manages the interleaved methods
    %   Performs the experiment with two interleaved 1U1D and an SOA as
    %   parameter for each one
    
    properties(SetAccess=private)
        adaptive_methods;
        signal_intensities;
        signal_duration;
        signal_modulation;
    end
    
    methods
        function obj=InterleaveManager(sig_intensities, sig_duration, initialSOA_1, initialSOA_2, modulation, initial_step, step, final_reversals_per_method)
            method_1=OneUpOneDown(initial_step, 0, step, final_reversals_per_method, initialSOA_1);
            method_2=OneUpOneDown(initial_step, 1, step, final_reversals_per_method, initialSOA_2);
            obj.adaptive_methods = cell(1,2);
            obj.adaptive_methods{1} = method_1;
            obj.adaptive_methods{2} = method_2;
            obj.signal_intensities = sig_intensities;
            obj.signal_duration = sig_duration;
            obj.signal_modulation = modulation;
        end
        
        function performed = perform_trial(obj,user_answer)
           % Get a random method to perform
           if(~obj.experiment_finished())
               num = randi(2,1,1);
               method = obj.adaptive_methods{num};
               while(method.finished() && ~obj.experiment_finished())
                   num = randi(2,1,1);
                   method = obj.adaptive_methods{num};
               end
               method.perform_trial(user_answer);
               SOA = method.parameter;
               %% Call the snake
               % snake_matrix = snake(obj.modulation, SOA, obj.signal_duration)
               % snake = adjust_snake(snake_matrix, obj.signal_intensities)
               % playrec('play', snake)
               % playrec('block')
               
               %dummy snake
               snake = eye(21168,24);
               snake_final = adjust_snake(snake, obj.signal_intensities);
               playrec('play', snake_final, 1:1:24);
               playrec('block')
               performed = 1;
           else
               performed = 0;
           end
        end
        
        function stop = experiment_finished(obj)
           stop = obj.adaptive_methods{1}.finished() && obj.adaptive_methods{2}.finished();
        end
        
        function estimate = calculate_result(obj)
           estimate = (obj.adaptive_methods{1}.calculate_final_estimate()+obj.adaptive_methods{2}.calculate_final_estimate())/2;
        end
        
        function method_progress = get_methods_progress(obj)
           method_progress = [obj.adaptive_methods{1}.parameter, obj.adaptive_methods{2}.parameter];
        end
    end
    
end

