clc
clear
close all

%
%
%OUTLINE
%
%



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
%
%When a move is selected, the bottom row will be cleared and the hp bar
%will change based on the amount of damage taken
%
%The HP bar will have about 4 different sprites according to the
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
%
%Current plan, sprite basic text and then for the moves only sprite numbers
%Use msgbox command to display the move information 
%
%Moves text file layout
%
%Name Target Type Power Accuracy Status Phys/Special
%Name Target Type Modifier Stat Accuracy NA
%
%Pokemon File Layout
%
%Name, HP, Atk, Def, SP. Atk, Sp Def, Speed

%Moves
%1 - 4 Flareon
%5 - 8 Porygon
%9 - 12 Omastar
%13 - 16 Kabutops
%17 - 20 Aerodactyl
%21 - 24 Snorlax
%25 - 28 Articuno
%29 - 32 Zapdos
%33 - 36 Moltres
%37 - 40 Dragonite
%41 - 44 Mewtwo

%Sprite indexes
%P2 - (Front facing)
%Flareon - 1
%Porygon - 3
%Omastar - 7
%Kabutops - 11
%Aerodactyl - 13
%Snorlax - 15
%Articuno - 17
%Zapdos - 19
%Moltres - 21
%Dragonite - 27
%Mewtwo - 29
%Blank sprite - 31

%P1 (Back turned to P1)
%Flareon - 32
%Porygon - 34
%Omastar - 38
%Kabutops - 42
%Aerodactyl - 44
%Snorlax - 46
%Articuno - 48
%Zapdos - 50
%Moltres - 52
%Dragonite - 58
%Mewtwo - 60
%Blank sprite - 62

%63, 64, 65, 66, 67 (It's super effective not)
%68, 69, 70, 71 (1, 2, 3, 4)
%72, 73 (Gray HP Bar and Green HP Bar)
%74, 75, 76, 77, 78, 79, HP, PSN, BRN, PAR, SLP, FRZ
%80, Explosion
%81, 82, Arrow up, Arrow down
%83 FAILED

%
%
%BEGIN GAME CODE
%
%

%Pokemon Names WRT table row index
% 1 = Mewtwo
% 2 = Moltres
% 3 = Zapdos
% 4 = Articuno
% 5 Dragonite
% 6 Snorlax
% 7 Aerodactyl
% 8 Kabutops
% 9 Omastar
% 10 Porygon
% 11 Flareon
pnames = {'Mewtwo'; 'Moltres'; 'Zapdos'; 'Articuno'; 'Dragonite'; 'Snorlax'; 'Aerodactyl'; 'Kabutops'; 'Omastar'; 'Porygon'; 'Flareon'};

%Initializes pokemon and move data
myDialogue
delimiterIn = ' ';
moves = load('moves.mat').moves;
pokemon = load('pokemoninfo.mat').pokemoninfo;

%Drafts 3 random pokemon for each player
pokelist = [];
for i=1:height(pokemon)
    pokelist(i) = i;
end

player1mons = [];
player1monn = {};
player2mons = [];
player2monn = {};

for i=1:3
    random = randi(12-i);
    player1mons(i, 1:7) = pokemon{random, :};
    %player1monn(i) = pokemon{random, 'Mewtwo'};
    player1monn(i) = pnames(random);
    pnames(random) = [];
    pokemon([random],:) = [];
end

for i=1:3
    random = randi(9-i);
    player2mons(i, 1:7) = pokemon{random, :};
    player2monn(i) = pnames(random);
    pnames(random) = [];
    pokemon([random],:) = [];
end

%CPU or player choice
pchoice = choosedialog;

%Initialize scene
scene = simpleGameEngine('cropped sprites.png', 62, 62);
blank_tile = 31;
board_display = 31 * ones(5, 5);
drawScene(scene, board_display)



%h = msgbox({'Your first move is X';'Your Second Move is x'});
%board_display = [62, 62, 62, 62, 62;62, 62, 62, 62, 62;62, 62, 62, 62, 62;62, 62, 62, 62, 62;63, 64, 65, 66, 67];
background = 496;
drawScene(scene, board_display)

