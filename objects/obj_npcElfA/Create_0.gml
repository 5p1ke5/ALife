/// @description Initializes character-specific variables
//Random character.

var _faceIndex = 3;
var _hairIndex = 3;
var _shirtIndex = 11;
var _pantsIndex = 0;
var _skinColor = make_color_rgb(100, 225, 232);
var _hairColor = make_color_rgb(36, 190, 92);
var _shirtColor = make_color_rgb(136, 200, 136);
var _pantsColor = make_color_rgb(36, 200, 110);

doll_initialize(5, 5, 3, 3, factions.player, _faceIndex, _hairIndex, _shirtIndex, _pantsIndex, _skinColor, _hairColor, _shirtColor, _pantsColor);


var _item = new ITEM_SWORD;
inventory_add(inventory, _item);

//an array of states.

var _commands = 
	[
	new NPCCommandAwaitTarget(global.player),
	new NPCCommandTalkTo
		(new Point2(x, y), 
		[
		"Help! The orcs kidnapped my partner! I think he's going to eat them!"
		])
	]


npc_initialize("Sasha", ["I'm gonna tell all my friends I met you!"], 100, _commands);