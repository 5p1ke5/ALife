/// @description Initializes character-specific variables
//Random character.

var _faceIndex = 10;
var _hairIndex = 8;
var _shirtIndex = 11;
var _pantsIndex = 0;
var _skinColor = c_white3;
var _hairColor = c_blonde;
var _shirtColor = c_black3;
var _pantsColor = c_black1;

doll_initialize(5, 5, 3, 3, factions.player, _faceIndex, _hairIndex, _shirtIndex, _pantsIndex, _skinColor, _hairColor, _shirtColor, _pantsColor);


var _item = new ITEM_KNIFE;
inventory_add(inventory, _item);

//an array of states.

var _commands = 
[
	new NPCCommandAwaitTarget(global.player, MID_RANGE),
	new NPCCommandFight(global.player)
];

npc_initialize("Carli",  ["I'm gonna kill you and take your stuff!"], 100, _commands);