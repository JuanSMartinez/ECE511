classdef OneUpOneDown
    %OneUpOneDown  One up one down adaptive method
    %   Adaptive method for the snake project
    
    properties (SetAccess=private)
        inital_step;
        direction;
        step;
        reversals;
        final_reversals;
    end
    
    methods
        function obj=OneUpOneDown(initial_step, direction, step, final_reversals)
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
            end
          
        end
    end
    
end

