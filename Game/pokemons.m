classdef pokemons
    %UNTITLED2 Summary of this class goes here
    %   Detailed explanation goes here
    
    properties
        sprite_number = 1; % number of the sprite - corresponds to pokemon
        hp = 1;
        atk = 1;
        spatk = 1;
        def = 1;
        spdef = 1;
        speed = 1;
    end
    
    methods
        function obj = pokemons(sprite_number, lvl, hp, atk, spatk, def, spdef, speed, moves)
            %UNTITLED2 Construct an instance of this class
            %   Detailed explanation goes here
            obj.sprite_number = sprite_number;
            obj.lvl = lvl;
            obj.hp = (((2 * hp) * lvl)/100) + lvl + 10 ;
            obj.atk = atk;
            obj.spatk = spatk;
            obj.def = def;
            obj.spdef = spdef;
            obj.speed = speed;
            obj.moves = moves;
        end
        
        %Create a damage function which takes 
        function damage()
        end
        
        %To do with this class
        %Create functions that will either divide or multiply stats by a 
        %Certain number
        
        function outputArg = method1(obj,inputArg)
            %METHOD1 Summary of this method goes here
            %   Detailed explanation goes here
            outputArg = obj.Property1 + inputArg;
        end
    end
end

