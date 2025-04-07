/// @description Initializes character-specific variables
//Random character.

var _faceIndex = 1;
var _hairIndex = 1;
var _shirtIndex = 2;
var _pantsIndex = 0;
var _skinColor = c_black3;
var _hairColor = c_blonde;
var _shirtColor = c_green;
var _pantsColor = c_brunette;

doll_initialize(5, 5, 3, 3, factions.player, _faceIndex, _hairIndex, _shirtIndex, _pantsIndex, _skinColor, _hairColor, _shirtColor, _pantsColor);


var _item = new ITEM_SWORD;
inventory_add(inventory, _item);

//an array of states.
var _states = [
	new NPCStateMove( new Point2(800, 2660)),
	new NPCStateMove( new Point2(500, 2660)),
];

var _loop = new NPCStateLoop(_states)

array_push(_states, _loop);

npc_initialize("Atticus", ["Hail, traveller!", "Let me know if there's anything you need."], 100, _states);