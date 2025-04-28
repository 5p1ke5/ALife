/// @description Initializes character-specific variables
//Random character.

var _faceIndex = 9;
var _hairIndex = 8;
var _shirtIndex = 2;
var _pantsIndex = 0;
var _skinColor = c_black3;
var _hairColor = c_dkgray;
var _shirtColor = c_olive;
var _pantsColor = c_green;

doll_initialize(5, 5, 3, 3, factions.player, _faceIndex, _hairIndex, _shirtIndex, _pantsIndex, _skinColor, _hairColor, _shirtColor, _pantsColor);


var _item = new ITEM_SWORD;
inventory_add(inventory, _item);

//an array of states.

var _commands = 
[
	new NPCCommandMove(new Point2(x, y))
];
	

npc_initialize("Elder Irene", ["Watch out, it's dangerous in the wilderness.", "There are outlaws living in the forest."], 100, _commands);