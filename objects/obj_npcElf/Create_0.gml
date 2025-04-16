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

var _states = 
	[
	//new NPCStateAwaitTarget(global.player),
	//new NPCStateTalkTo
	//	(global.player, 
	//	[
	//	"Help! The bandits kidnapped my brother!",
	//	"Can you save him for me?",
	//	"He's deeper in the forest. Come with me!"
	//	]),
	new NPCStateMovePath(new Point2(800, 2500), 2),
	new NPCStateMovePath(new Point2(800, 2700), 2),
	new NPCStateMovePath(new Point2(2300, 2600), 2)
	]

var _loop = new NPCStateLoop(_states);

npc_initialize("Sasha", ["I'm gonna tell all my friends I met you!"], 100, _loop);