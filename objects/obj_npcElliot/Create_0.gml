/// @description Initializes character-specific variables
//Random character.

var _faceIndex = 3;
var _hairIndex = 4;
var _shirtIndex = 1;
var _pantsIndex = 0;
var _skinColor = c_black3;
var _hairColor = c_blue;
var _shirtColor = c_purple;
var _pantsColor = c_brunette;

doll_initialize(5, 5, 3, 3, factions.player, _faceIndex, _hairIndex, _shirtIndex, _pantsIndex, _skinColor, _hairColor, _shirtColor, _pantsColor);


var _item = new ITEM_SWORD;
inventory_add(inventory, _item);

//an array of states.

var _states = [
	new NPCStateMove(global.player),
	new NPCStateMove(new Point2(800, 2800))
	]
	
var _loop = new NPCStateLoop(_states);

npc_initialize("Elliot", ["Oh my god its the player character!! I'm your biggest fan!"], 100, _loop);