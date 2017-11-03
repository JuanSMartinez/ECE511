%%Test the one up one down class
clear;
clc;
obj=OneUpOneDown(16, 1, 0.5, 2, 575);

performed = obj.perform_trial(1);
obj.estimate
performed = obj.perform_trial(1);
obj.estimate
performed = obj.perform_trial(1);
obj.estimate
performed = obj.perform_trial(-1);
obj.estimate
performed = obj.perform_trial(-1);
obj.estimate
performed = obj.perform_trial(1);
obj.estimate
performed = obj.perform_trial(1);
obj.estimate
performed = obj.perform_trial(-1);
obj.estimate
performed = obj.perform_trial(-1);
obj.estimate
performed = obj.perform_trial(1);
obj.estimate
performed = obj.perform_trial(1);
obj.estimate
performed = obj.perform_trial(-1);
obj.estimate
performed = obj.perform_trial(-1);
obj.estimate
x_50 = obj.calculate_final_estimate();

