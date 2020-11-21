classdef player
    %UNTITLED Summary of this class goes here
    %   Detailed explanation goes here
    
    properties
        pokemon1
        pokemon2
        pokemon3
    end
    
    methods
        function obj = player(pokemon1, pokemon2, pokemon3)
            %UNTITLED Construct an instance of this class
            %   Detailed explanation goes here
            obj.pokemon1 = pokemon1;
            obj.pokemon2 = pokemon2;
            obj.pokemon3 = pokemon3; 
        end
        
        function outputArg = method1(obj,inputArg)
            %METHOD1 Summary of this method goes here
            %   Detailed explanation goes here
            outputArg = obj.Property1 + inputArg;
        end
    end
end

