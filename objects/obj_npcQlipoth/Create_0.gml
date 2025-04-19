/// @description Initializes character-specific variables
//Random character.

var _faceIndex = 6;
var _hairIndex = 8;
var _shirtIndex = 1;
var _pantsIndex = 0;
var _skinColor = c_hispanic2;
var _hairColor = c_white;
var _shirtColor = c_black;
var _pantsColor = c_dkgray;

doll_initialize(5, 5, 3, 3, factions.player, _faceIndex, _hairIndex, _shirtIndex, _pantsIndex, _skinColor, _hairColor, _shirtColor, _pantsColor);


var _item = new ITEM_SWORD;
inventory_add(inventory, _item);

//an array of states.

var _subCommands =
[
	new NPCCommandMove(new Point2(2100, 2600), 5 * game_get_speed(gamespeed_fps)),
	new NPCCommandMove(new Point2(2200, 2650), 5 * game_get_speed(gamespeed_fps)),
	new NPCCommandMove(new Point2(2000, 2500), 5 * game_get_speed(gamespeed_fps)),
	new NPCCommandMove(new Point2(2100, 2600), 5 * game_get_speed(gamespeed_fps)),
	new NPCCommandMove(new Point2(2100, 2600), 5 * game_get_speed(gamespeed_fps)),
	new NPCCommandMove(new Point2(2200, 2650), 5 * game_get_speed(gamespeed_fps)),
	new NPCCommandMove(new Point2(2000, 2500), 5 * game_get_speed(gamespeed_fps)),
	new NPCCommandMove(new Point2(2100, 2600), 5 * game_get_speed(gamespeed_fps))
];

var _commands = 
[
	new NPCCommandAwaitTarget(global.player),
	new NPCCommandTalkTo(global.player),
	new NPCCommandMovePath(new Point2(2000, 2600), 3 * game_get_speed(gamespeed_fps)),
	new NPCCommandSetCommands(_subCommands)
];

npc_initialize("Qlipoth", ["I'm about to head out for the woods. You can come with me if you like."], 100, _commands);