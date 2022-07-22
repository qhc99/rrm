classdef TimeLine < handle
    %TIMELINE Summary of this class goes here
    %   Detailed explanation goes here
    
    properties
        task_indices = [];
        delay_cost = 0;
        time = 0;
    end
    
    methods
        function obj = TimeLine()
            %TIMELINE Construct an instance of this class
            %   Detailed explanation goes here

        end

        function [] = addTask(obj,task_idx, tasks)
            obj.task_indices(end+1) = task_idx;
            task = tasks(:,task_idx);
            execution_time = max(task(1),obj.time);
            obj.time = execution_time + task(3);
            obj.delay_cost = obj.delay_cost + (execution_time-task(1))*task(4);
        end
        
        function new = deepcopy(obj)
            new = TimeLine();
            new.task_indices = obj.task_indices;
            new.delay_cost = obj.delay_cost;
            new.time = obj.time;
        end
    end
end

