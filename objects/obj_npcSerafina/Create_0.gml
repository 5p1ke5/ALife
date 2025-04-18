/// @description Initializes character-specific variables
//Random character.

var _faceIndex = 9;
var _hairIndex = 12;
var _shirtIndex = 12;
var _pantsIndex = 0;
var _skinColor = c_asian2;
var _hairColor = make_color_rgb(252, 30, 162);
var _shirtColor = make_color_rgb(255, 240, 250);
var _pantsColor =  make_color_rgb(255, 240, 250);

doll_initialize(5, 5, 3, 3, factions.player, _faceIndex, _hairIndex, _shirtIndex, _pantsIndex, _skinColor, _hairColor, _shirtColor, _pantsColor);


var _item = new ITEM_SWORD;
inventory_add(inventory, _item);

//an array of states.

var _choice1 = new NPCCommandSetDialogue("Looks like you're in good health. Perfect!")
var _choice2 = new NPCCommandSetDialogue("Oh, you're hurt. Let me help you.")

var _commands = 
[

	new NPCCommandAwaitTarget(global.player),
	new NPCCommandCheckInstanceVar(global.player, "hp", _choice1, _choice2, 3, compare.greaterThanOrEqual),
	new NPCCommandTalkTo(global.player),
	new NPCCommandSetInstanceVar(global.player, "hp", global.player.maxHP),
	new NPCCommandMove(new Point2(x, y))
];
	
var _loop = new NPCCommandLoop(_commands);	

npc_initialize("Serafina", ["Looks like you're in good health. Perfect!"], 100, _loop);