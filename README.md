Final-Project

make roguelike game
Top-down tile-based turn-based RPG with randomly generated maps and perma-death.
The goal is to find the stairs to go down the dungeon to find the treasure and then to escape.

Version 1 (Post Winter Break)- Will generate and display the map (generator creates cave-like maps). The player can move around their character ('@') around the map and can attack monsters on the map.
Version 2 (1/7/15) - Finally implemented line of sight and field of view.

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

To-Do List:
Add Monster AI. Also, they should drop loot on death.
Find a theme.
Add equipment (weapons,armor,etc.).
Add prefixes/suffixes, enchantments or whatever to the items (basically give them random stats/effects)
Maybe add consumables
Stats?
Leveling up (both character's level and going up the dungeon)
Scaling loot/monsters to go up with dungeon? (can hard-code it)
Add tomes/manuals/whatever that will allow the player to gain skills (maybe allow them to get them by leveling up as well)


