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
	new NPCStateTalkTo
	(
		new Point2(500, 2600),  
		["Hi there!", "Welcome to Heimdall village!", "My name is Prinz.", "I hope you like our tiny town."]
	)
	]
	

npc_initialize("Prinz", ["I'm gonna tell all my friends I met you!"], 100, _states);