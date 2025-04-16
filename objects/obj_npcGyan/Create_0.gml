/// @description Initializes character-specific variables
//Random character.

var _faceIndex = 4;
var _hairIndex = 12;
var _shirtIndex = 6;
var _pantsIndex = 0;
var _skinColor = c_black3;
var _hairColor = c_fuchsia;
var _shirtColor = c_purple;
var _pantsColor = c_dkgray;

doll_initialize(5, 5, 3, 3, factions.player, _faceIndex, _hairIndex, _shirtIndex, _pantsIndex, _skinColor, _hairColor, _shirtColor, _pantsColor);


var _item = new ITEM_SWORD;
inventory_add(inventory, _item);

//an array of states.

var _commands = 
[
	new NPCCommandMove(new Point2(865, 2792), 3 * game_get_speed(gamespeed_fps)),
	new NPCCommandMove(new Point2(1056, 2816), 3 * game_get_speed(gamespeed_fps)),
	new NPCCommandMove(new Point2(900, 2848), 3 * game_get_speed(gamespeed_fps)),
];
	
var _loop = new NPCCommandLoop(_commands);	

npc_initialize("Gyan", ["Watch out, it's dangerous in the wilderness.", "There are outlaws living in the forest."], 100, _loop);