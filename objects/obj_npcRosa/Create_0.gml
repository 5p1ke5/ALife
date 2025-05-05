/// @description Initializes character-specific variables
//Random character.

var _faceIndex = 5;
var _hairIndex = 12;
var _shirtIndex = 5;
var _pantsIndex = 0;
var _skinColor = c_hispanic3;
var _hairColor = c_darkBrunette;
var _shirtColor = make_color_rgb(255, 0, 250);
var _pantsColor =  c_blue;

doll_initialize(5, 5, 3, 3, factions.player, _faceIndex, _hairIndex, _shirtIndex, _pantsIndex, _skinColor, _hairColor, _shirtColor, _pantsColor);


var _item = new ITEM_KNIFE;
inventory_add(inventory, _item);

//arrays of commands.
	
//Dialogue for after initial story intro.
var _choice1 = new NPCCommandSetDialogue("Looks like you're in good health. Perfect!");
var _choice2 = new NPCCommandSetDialogue("Oh, you're hurt. Let me help you.");

var _loop = new NPCCommandLoop([
	new NPCCommandAwaitTarget(global.player, RANGE_MELEE),
	new NPCCommandCheckInstanceVar(global.player, "hp", _choice1, _choice2, 3, compare.greaterThanOrEqual),
	new NPCCommandTalkTo(global.player),
	new NPCCommandSetInstanceVar(global.player, "hp", global.player.maxHP),
	new NPCCommandMovePath(new Point2(x, y))
]);

var _commands2 = [_loop];

//Dialogue for story intro.
var _commands1 = [
		new NPCCommandAwaitTarget(global.player, RANGE_CLOSE),
		new NPCCommandSetGlobalVar("storyTalkedToRosa", true),
		new NPCCommandTalkTo(global.player, ["Good morning! Glad to see you awake. You can use WASD to move. Right click on people to interact with them.", "We found you passed out in the forest. Did you get attacked?", "Atticus, our guardsman is outside. He's a nice guy, he'll help you get your bearings if you need it."]),
		new NPCCommandMovePath(new Point2(360, 360)),
		new NPCCommandSetCommands(_commands2)
	];
	

var _commands = global.storyTalkedToRosa ? _commands2 : _commands1;

npc_initialize("Rosa", ["Looks like you're in good health. Perfect!"], 100, _commands);


	
//var _loop = new NPCCommandLoop(_commands);	

//npc_initialize("Serafina", ["Looks like you're in good health. Perfect!"], 100, _loop);