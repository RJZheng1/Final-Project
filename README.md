Final-Project

make roguelike game
Top-down tile-based turn-based RPG with randomly generated maps and perma-death.
The goal is to find the stairs to go down the dungeon to find the treasure.

Controls:
7 8 9    Use the numpad to move or attack.
 \:/     Use 5 to wait a turn.
4-5-6
 /:\
1 2 3
If you are on a tile with loot on it, press the letter corresponding to each item to equip that item
and drop your current item onto the floor.

History:

	Post Winter Break:
		allowed for player to move a (@) across their screen (the player will be randomly placed on an empty square)
		the player cannot walk through walls (#)
		implemented algorithm to generate cave-like maps the edges of the screen are walls
		processing will draw the map and everything each time the player moves
		the game will spawn monsters, which can be attacked by the player
		algorithm for map generation found here: http://www.roguebasin.com/index.php?title=Cellular_Automata_Method_for_Generating_Random_Cave-Like_Levels
		
	1/7/15:
		added field of view and line of sight. the game will only display the area that the player can see (algorithm can be optimized)
		ladder is generated ( with no function ) 
		player and monster spawn all moved into map generation
		monsters can be seen
	1/8/15:
		resized map so that space for text is made
		started the text display
		created attack 
		made move and movehelper return a String for text display
	1/9/15:
		the tile will display a . when the monster on it dies instead of displaying nothing
		the tile the player spawns on will change to a . as soon as the player moves off it
	1/11/15:
		attempted to make the monsters move on their own, randomly if not in player's fov and towards the player if in the player's fov 
		but bugs appeared:
		    1. the monsters won't walk towards the player now that they can't walk through walls
		    2. the monsters are appearing in the black space again...
		    3. cant kill monsters either
	1/12/15:
		worked some more on monster movement
	1/13/15:
		Text display will show damage you do and damage you get taken.
		In-progress ladder. Crashes game. DO NOT PRESS Y YET.
	1/14/15:
		Ladders work. Will generate new map.
		Announces what level you are on.
		Speed thingy done. Monsters all currently move 0.5 speed. Player is 1.0.
	1/15/15:
		Added weapons and armor. They amount of damage you do depends on your weapon. Your armor reduces the amount of damage every attack does to you.
		Ladder won't spawn. Bug: must fix.
		Added final level.
		Will display items and show what they do.
	1/16/15:
		Fixed bug with ladder not spawning.
		Final level not created properly. Must fix.
	1/18/15:
		Added win/fail states. Game will show a victory/failure screen and the player can restart by pressing any button.
		Player can gain EXP and level up.
	1/19/15:
		Monsters drop items. Items on the tile you stand on will be displayed.
		Can pick up items from the ground.
		Flood-fill so that the map generation never makes open spaces.
	1/20/15:
		Added combat rolls to decide hit/miss.

To-Do List:
Make speed better able to handle numbers over 1.0 (Monsters currently cannot move faster than the player). If player is over 1.0, monster's speed is decreased accordingly.
Make FOV more efficient.
Make Monsters smarter?
Find a theme.
Add prefixes/suffixes, enchantments or whatever to the items (basically give them random stats/effects)
Maybe add consumables
Stats?
Scaling loot/monsters to go up with dungeon? (can hard-code it)
Ranged combat?
Maybe add tomes/manuals/whatever that will allow the player to gain skills (maybe allow them to get them by leveling up as well)

