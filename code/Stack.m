classdef Stack < handle
    %STACK Summary of this class goes here
    %   Detailed explanation goes here
    
    properties
        size
        arr 
    end
    
    methods
        function obj = Stack()
            %STACK Construct an instance of this class
            %   Detailed explanation goes here
            obj.size = 0;
            obj.arr = {};
        end
        
        function [] = add(obj, data)
            obj.size = obj.size + 1;
            obj.arr{obj.size} = data;
        end

        function data = remove(obj)
            data = obj.arr{obj.size};
            obj.arr(obj.size) = [];
            obj.size = obj.size - 1;
        end

        function data = top(obj)
            data = obj.arr{obj.size};
        end
    end
end

