classdef Node < handle
    %NODE Summary of this class goes here
    %   Detailed explanation goes here
    
    properties
        T 
        PF
        NS
        DR
    end
    
    methods
        function obj = Node()
            obj.T = TimeLine();
            obj.PF = [];
            obj.NS = [];
            obj.DR = [];
        end

        function [] = init(obj,T, PF,NS,DR)
            obj.T = T;
            obj.PF = PF;
            obj.DR = DR;
            obj.NS = NS;
        end
    end
end

