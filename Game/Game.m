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

fflareon = 1;
fporygon = 3;
fomastar = 7;
fkabutops = 11;
faerodactyl = 13;
fsnorlax = 15;
farticuno = 17;
fzapdos = 19;
fmoltres = 21;
fdragonite = 27;
fmewtwo = 29;

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

bflareon = 32;
bporygon = 34;
bomastar = 38;
bkabutops = 42;
baerodactyl = 44;
bsnorlax = 46;
barticuno = 48;
bzapdos = 50;
bmoltres = 52;
bdragonite = 58;
bmewtwo = 60;

%63, 64, 65, 66, 67 (It's super effective not)
%68, 69, 70, 71 (1, 2, 3, 4)
%72, 73 (Gray HP Bar and Green HP Bar)
grayhp = 72;
greenhp = 73;
%74, 75, 76, 77, 78, 79, HP, PSN, BRN, PAR, SLP, FRZ
hp = 74;
psn = 75;
brn = 76;
par = 77;
slp = 78;
frz = 79;

%80, Explosion
explosion = 80;
%81, 82, Arrow up, Arrow down
arrowup = 81;
arrowdown = 82;
%83 FAILED
failed = 83;

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
%array of sprite values so i can remove the ones chosen during random
%draft
frontsprites = [fmewtwo; fmoltres; fzapdos; farticuno; fdragonite; fsnorlax; faerodactyl; fkabutops; fomastar; fporygon; fflareon];
backsprites = [bmewtwo; bmoltres; bzapdos; barticuno; bdragonite; bsnorlax; baerodactyl; bkabutops; bomastar; bporygon; bflareon];

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
p1monsprite = [];

player2mons = [];
player2monn = {};
p2monsprite = [];
for i=1:3
    random = randi(12-i);
    player1mons(i, 1:7) = pokemon{random, :};
    %player1monn(i) = pokemon{random, 'Mewtwo'}; %table funky stuff doesn't
    %work for some reason
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
number1 = 68;
number2 = 69;
number3 = 70;
number4 = 71;

%Blank canvas
board_display = 31 * ones(5, 5);
%Bottom row w/ 1-4
board_display(5, 2:5) = [number1, number2, number3, number4]; 
%HP Display for player
board_display(4, 1:5) = [hp, greenhp, greenhp, greenhp, greenhp];
%HP DIsplay for enemy
board_display(1, 1:5) = [hp, greenhp, greenhp, greenhp, greenhp];


%Initialize p1 pokemon on board

drawScene(scene, board_display)


%h = msgbox({'Your first move is X';'Your Second Move is x'});
%board_display = [62, 62, 62, 62, 62;62, 62, 62, 62, 62;62, 62, 62, 62, 62;62, 62, 62, 62, 62;63, 64, 65, 66, 67];
background = 496;

%Fake code for video
%Show articuno for p1 and porygon for p2
board_display(2, 4) = fporygon;
board_display(3, 2) = barticuno;

drawScene(scene, board_display)

msgbox({'Choose a move'; '1: Ice Beam, Type: Ice, Power: 90, Accuracy: 1';'2: Roost, Type: Flying, Power: NA, Accuracy: 0.9';'3: Blizzard, Type: Ice, Power: 110, Accuracy: 0.7';'4: Steelwing, Type: Steel, Power: 70, Accuracy: 0.9'});
%Mouse works where r is row, c is column, b is button where 1 is left
%click and 3 is right click
pause(2)
[r,c,b] = getMouseInput(scene)

msgbox({'Articuno used IceBeam!'; 'Porygon used TriAttack!'})

board_display(2, 4) = explosion;
board_display(1, 5) = grayhp;
drawScene(scene, board_display);

pause(2)
board_display(2, 4) = fporygon;
drawScene(scene, board_display);

pause(2)
board_display(3, 2) = explosion;
board_display(4, 5) = grayhp;
drawScene(scene, board_display);

pause(2)
board_display(3, 2) = barticuno;
drawScene(scene, board_display);

msgbox({'Choose a move'; '1: Ice Beam, Type: Ice, Power: 90, Accuracy: 1';'2: Roost, Type: Flying, Power: NA, Accuracy: 0.9';'3: Blizzard, Type: Ice, Power: 110, Accuracy: 0.7';'4: Steelwing, Type: Steel, Power: 70, Accuracy: 0.9'});
pause(2)
[r,c,b] = getMouseInput(scene)

msgbox({'Articuno used Blizzard!'; 'Porygon used TriAttack!'})

board_display(2, 4) = explosion;
board_display(1, 3:4) = [grayhp, grayhp];
drawScene(scene, board_display);

pause(2)
board_display(2, 4) = fporygon;
drawScene(scene, board_display);

pause(2)
board_display(3, 2) = explosion;
board_display(4, 4) = grayhp;
drawScene(scene, board_display);

pause(2)
board_display(3, 2) = barticuno;
drawScene(scene, board_display);

msgbox({'Choose a move'; '1: Ice Beam, Type: Ice, Power: 90, Accuracy: 1';'2: Roost, Type: Flying, Power: NA, Accuracy: 0.9';'3: Blizzard, Type: Ice, Power: 110, Accuracy: 0.7';'4: Steelwing, Type: Steel, Power: 70, Accuracy: 0.9'});
pause(2)
[r,c,b] = getMouseInput(scene)

msgbox({'Articuno used IceBeam!'; 'Porygon used TriAttack!'})

board_display(2, 4) = explosion;
board_display(1, 2) = grayhp;
drawScene(scene, board_display);

pause(2)
board_display(2, 4) = blank_tile;
drawScene(scene, board_display);

msgbox({'Porygon Fained!'})
pause(2)
msgbox({'Go, Flareon!'})
pause(2)

board_display(2, 4) = fflareon;
board_display(1, 1:5) = [hp, greenhp, greenhp, greenhp, greenhp];
drawScene(scene, board_display);

msgbox({'Choose a move'; '1: Ice Beam, Type: Ice, Power: 90, Accuracy: 1';'2: Roost, Type: Flying, Power: NA, Accuracy: 0.9';'3: Blizzard, Type: Ice, Power: 110, Accuracy: 0.7';'4: Steelwing, Type: Steel, Power: 70, Accuracy: 0.9'});
pause(2)
[r,c,b] = getMouseInput(scene)

msgbox({'Flareon used FireFang!'; 'Articuno used Ice Beam!'})
board_display(3, 2) = explosion;
board_display(5, 2:5) = [63, 64, 65, 66];
board_display(4, 2:3) = [grayhp, grayhp];
drawScene(scene, board_display);

pause(2)
board_display(3, 2) = blank_tile;
drawScene(scene, board_display);

msgbox({'Articuno Fainted!'})
pause(2)
msgbox({'Go, Omastar!'})
pause(2)
board_display(3, 2) = [bomastar];
board_display(5, 2:5) = [number1, number2, number3, number4]; 
board_display(4, 1:5) = [hp, greenhp, greenhp, greenhp, greenhp];
drawScene(scene, board_display);

msgbox({'Choose a move'; '1: Scald, Type: Water, Power: 80, Accuracy: 1';'2: HydroPump, Type: Water, Power: 150, Accuracy: 0.7';'3: RockTomb, Type: Rock, Power: 60, Accuracy: 1';'4: AquaTail, Type: Steel, Power: 90, Accuracy: 0.9'});
pause(2)
[r,c,b] = getMouseInput(scene)

msgbox({'Omastar used Scald!'; 'Flareon used TakeDown!'})

board_display(2, 4) = explosion;
board_display(1, 3:5) = [grayhp, grayhp, grayhp];
board_display(5, 2:5) = [63, 64, 65, 66];
drawScene(scene, board_display);

pause(2)
board_display(2, 4) = fflareon;
board_display(1, 1) = brn;
drawScene(scene, board_display);

pause(2)
board_display(3, 2) = explosion;
board_display(4, 5) = grayhp;
drawScene(scene, board_display);
board_display(5, 2:5) = [63, 67, 65, 66];
drawScene(scene, board_display);

pause(2)
board_display(3, 2) = bomastar;
drawScene(scene, board_display);

pause(2)
board_display(5, 2:5) = [number1, number2, number3, number4]; 
drawScene(scene, board_display);
msgbox({'Choose a move'; '1: Scald, Type: Water, Power: 80, Accuracy: 1';'2: HydroPump, Type: Water, Power: 150, Accuracy: 0.7';'3: RockTomb, Type: Rock, Power: 60, Accuracy: 1';'4: AquaTail, Type: Steel, Power: 90, Accuracy: 0.9'});
pause(2)
[r,c,b] = getMouseInput(scene)

pause(2)
msgbox({'Omastar used Scald!'; 'Flareon used FireFang!'})

board_display(2, 4) = explosion;
board_display(1, 2) = grayhp;
drawScene(scene, board_display);

pause(2)
board_display(2, 4) = blank_tile;
drawScene(scene, board_display);

msgbox({'Flareon Fained!'})
pause(2)
msgbox({'You win!'})
