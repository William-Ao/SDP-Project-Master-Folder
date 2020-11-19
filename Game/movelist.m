classdef movelist
    %UNTITLED3 Summary of this class goes here
    %   Detailed explanation goes here
    
    properties
        power = 0;
        pp = 0;
        %Numbers for each type
        % 1 - Normal
        % 2 - Fighting
        % 3 - Fire
        % 4 - Water
        % 5 - Poison
        % 6 - Grass
        % 7 - Electric
        % 8 - Ground 
        % 9 - Psychic
        % 10 - Rock
        % 11 - Ice
        % 12 - Bug
        % 13 - Dragon
        % 14 - Ghost
        % 15 - Dark
        % 16 - Steel
        % 17 - Flying
        type = 1;
        %move = [type, power, pp];
        moves = {};
    end
    
    methods
        function obj = movelist(move1, move2, move3, move4)
           obj.moves = [move1, move2, move3, move4];
        end
        
        function outputArg = method1(obj,inputArg)
            %METHOD1 Summary of this method goes here
            %   Detailed explanation goes here
            outputArg = obj.Property1 + inputArg;
        end
    end
end

