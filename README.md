Final-Project

make roguelike game
Top-down tile-based turn-based RPG with randomly generated maps and perma-death.
The goal is to find the stairs to go down the dungeon to find the treasure.

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

To-Do List:
Flood-fill to make it so that the map cannot have isolated caves (find good algorithm)
Make speed better able to handle numbers over 1.0 (Monsters currently cannot move faster than the player). If player is over 1.0, monster's speed is decreased accordingly.
Make FOV more efficient.
Add Monster AI. Also, they should drop loot on death.
Find a theme.
Add prefixes/suffixes, enchantments or whatever to the items (basically give them random stats/effects)
Maybe add consumables
Stats?
Leveling up?
Scaling loot/monsters to go up with dungeon? (can hard-code it)
Ranged combat?
Maybe add tomes/manuals/whatever that will allow the player to gain skills (maybe allow them to get them by leveling up as well)

