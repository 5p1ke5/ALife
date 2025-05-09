/// @description Initializes character-specific variables
//Random character.

var _faceIndex = 2;
var _hairIndex = 3;
var _shirtIndex = 8;
var _pantsIndex = 0;
var _skinColor = c_black3;
var _hairColor = c_black;
var _shirtColor = c_red;
var _pantsColor = c_dkgray;

doll_initialize(500, 5, 3, 3, factions.player, _faceIndex, _hairIndex, _shirtIndex, _pantsIndex, _skinColor, _hairColor, _shirtColor, _pantsColor);


var _item = new ITEM_SWORD;
inventory_add(inventory, _item);

var _commands2 = 
[
	new NPCCommandTalkTo(global.player, ["Good hit! You have the makings of a fine warrior.", "I've taught you all I can teach you. Why not ask the village elder for work?", "She lives in the building with the green roof."]),
	new NPCCommandMovePath(new Point2(900, 2800), 0.2)
];

var _choice1 = new NPCCommandSetCommands(_commands2);
var _choice2 = new NPCCommandTalkTo(new Point2(x, y), ["Go ahead and hit me. I can take it."]);

var _loop = 
[
	new NPCCommandMovePath(new Point2(900, 2800), 0.2),
	new NPCCommandCheckInstanceVar(id, "hp", _choice1, _choice2, hp, compare.lessThan), //Checks if current hp is less than HP when command was initialized.
];

if (global.storyTalkedToAtticus || global.storyTalkedToElder)
{
	var _commands1 = new NPCCommandIdle();
}
else
{
	var _commands1 =
	[
		new NPCCommandAwaitTarget(global.player),
		new NPCCommandTalkTo(global.player, ["Glad you're feeling better. I'm Atticus, the town guardsman.", "It looked like you got beat up pretty bad. Would you like to learn to fight?", "I can give you some pointers. Come meet me in the commons if you want a swordfighting lesson."]),
		new NPCCommandMovePath(new Point2(900, 2800)),
		new NPCCommandAwaitTarget(global.player),
		new NPCCommandTalkTo(global.player, ["Here, I'll teach you how to fight.", "You can left click to swing your weapon.", "Right-clicking and holding will cau1se you to block. You can only block attacks from one direction at a time.", "Try hitting me. Don't worry, I won't fight back."]),
		new NPCCommandLoop(_loop)
	];	
}



npc_initialize("Atticus", ["Good seeing you."], 100, _commands1);