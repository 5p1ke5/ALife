/// @description Initializes character-specific variables
//Random character.

var _faceIndex = 3;
var _hairIndex = 4;
var _shirtIndex = 2;
var _pantsIndex = 0;
var _skinColor = c_black3;
var _hairColor = c_yellow;
var _shirtColor = c_brunette;
var _pantsColor = c_black3;

doll_initialize(5, 5, 3, 3, factions.player, _faceIndex, _hairIndex, _shirtIndex, _pantsIndex, _skinColor, _hairColor, _shirtColor, _pantsColor);


var _item = new ITEM_SWORD;
inventory_add(inventory, _item);

//an array of states.

var _commands = 
[
	new NPCCommandAwaitTarget(global.player), 
	new NPCCommandTalkTo(global.player, ["I want to see the world beyond this village. Will you take me with you?", "You can add me to your party by right-clicking me and selecting 'Recruit.'"]),
	new NPCCommandMove(new Point2(x, y))
];
	

npc_initialize("Kai", ["I've always dreamed of being an adventurer."], 100, _commands);