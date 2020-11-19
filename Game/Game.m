clc
clear
close all

%Initialize scene
scene = simpleGameEngine('cropped sprites.png', 64, 64);
blank_tile = 50;
%Current plan for board display: 
% - - - - - 
% - H - E - 
% - - - - - 
% - P - - -
% T T T T T
%
% H is enemy stats
% E is the enemy sprite
% P is the player sprite
% T is the text menu with all of the moves
%
%Current to do's: Create text sprites for moves and individual enemy
%Pokemon
%
%Create damage algorithm and probably make a new class for Pokemon
%Damage = (((2*Level)/5 + 2) * Power * Atk/Def (of opponent))/50 + 2)*
%Modifier
%
%Modifier's include Crit, STAB, Type, (if user is) burned
%Crit is 2 for crits otherwise 1
%STAB is 1.5 for same type attack, 1 otherwise
%Type effectiveness is 0 (Ineffective), 0.25 or 0.5 (Not very effective)
%1 (Normal), 2 or 4 (super effective)
%remember 0.25 and 4 are for double type advantage or disadvantage
%Burn is 0.5 atk for the user, otherwise 1
%
%So Modifier = Crit * STAB * Type * Burn
board_display = blank_tile * ones(5, 5);
background = 496;
drawScene(scene, board_display)