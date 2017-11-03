classdef OneUpOneDown<handle
    %OneUpOneDown  One up one down adaptive method
    %   Adaptive method for the snake project
    
    properties (SetAccess=private)
        inital_step;
        direction;
        step;
        reversals;
        final_reversals;
        parameter;
        peak;
        valley;
        estimate;
    end
    
    methods
        function obj=OneUpOneDown(initial_step, direction, step, final_reversals, parameter)
            if(direction ~= 0 && direction ~= 1)
                %0 means decreasing, 1 means increasing
                error('Direction identifier is not valid');
            elseif ( initial_step <= 0)
                error('Initial step size must be positive');
            elseif ( step <= 0)
                error('Step size must be positive');
            elseif ( final_reversals <= 0)
                error('Final_reversals be positive'); 
            else
                obj.inital_step = initial_step;
                obj.direction = direction;
                obj.step = step;
                obj.reversals = 0;
                obj.final_reversals = final_reversals;
                obj.parameter = parameter;
                obj.peak = 0;
                obj.valley = 0;
                obj.estimate = 0;
            end
        end
        
        function stop = finished(obj)
           stop = (obj.reversals-1) == obj.final_reversals; 
        end
        
        function reversal_occured = perform_step(obj, user_answer,step_size)
            %The user answer has to be positive or negative
            if(obj.direction)
               if(user_answer > 0)
                  obj.parameter = obj.parameter + step_size;
               else
                  obj.peak = obj.parameter;
                  obj.parameter = obj.parameter - step_size;
                  obj.reversals = obj.reversals + 1;
                  obj.direction = ~obj.direction;
                  reversal_occured = 1;
               end
            else
               if(user_answer > 0)
                  obj.valley = obj.parameter;
                  obj.parameter = obj.parameter + step_size;
                  obj.reversals = obj.reversals + 1;
                  obj.direction = ~obj.direction;
                  reversal_occured = 0;
               else
                  obj.parameter = obj.parameter - step_size;
               end
            end 
        end
        
        function [] = update_estimate(obj)
           %update the estimate if the reversal is a second run
           if(mod(obj.reversals, 2))
               obj.estimate = obj.estimate + (obj.peak + obj.valley)/2.0;
           end
        end
        
        function X_50 = calculate_final_estimate(obj)
            X_50 = obj.estimate/((obj.reversals-1)/2.0);
        end
        
        function performed = perform_trial(obj, user_answer)
            if(~obj.finished())
                if(obj.reversals == 0)
                   %We haven't found the first reversal, perform a large
                   %step
                   obj.perform_step(user_answer, obj.inital_step);
                else
                   %perform a regular step and update X_50 as necessary
                   reversal_occured = obj.perform_step(user_answer, obj.step);
                   if(reversal_occured)
                      obj.update_estimate(); 
                   end
                end
                performed = 1;
            else
                performed = 0;
            end
        end
        
    end
    
end

