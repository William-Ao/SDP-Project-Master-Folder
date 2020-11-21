clc
clear
close all

%Initialize scene
scene = simpleGameEngine('cropped sprites.png', 64, 64);
blank_tile = 50;
%Current plan for board display: 
% - - - - - 
% S H - E - 
% - - - - - 
% - P - S H
% T T T T T
%
% H is health bar (of the player or enemy)
% E is the enemy sprite
% P is the player sprite
% T is the text menu with all of the moves
% - is a blank tile
% S is a status effect (of the player or enemy)
%
%Current to do's: Create text sprites for moves and individual enemy
%Pokemon
%
%What needs to be sprited: The left text sprite will be say "What will you
%do?"
%The other four will be each of the Pokemon's move
%
%When a move is selected, the bottom row will be cleared and the hp bar
%will change based on the amount of damage taken
%
%The HP bar will have about 10 different sprites according to the
%percentage of health left. It will not be animated. 
%
%Attacking will overlay a explosion sprite over the enemy character
%Using a buff will overlay an arrow over the friendly character
%
%This means moves probably have to have a target property based on whether
%they're hitting 1 (the player) or 2 (the enemy)
%
%Might need to create a play class which I can assign pokemon to
%This way we can simply execute methods on player1 or player2
%
%The CPU will try and prioritize their moves like this:
%Status Effect > Super Effective Move > Highest Power Move OR Debuff
%The choice between the highest power move or debuff will be done by coin
%flip
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
%
%Both players choose their moves at the same time, but the order they move
%is based on the Pokemon's speed, so a getSpeed method is required 
board_display = blank_tile * ones(5, 5);
background = 496;
drawScene(scene, board_display)