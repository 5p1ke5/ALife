/// @description Initializes character-specific variables
//Random character.

var _faceIndex = 13;
var _hairIndex = 16;
var _shirtIndex = 15;
var _pantsIndex = 0;
var _skinColor = c_red;
var _hairColor = c_red;
var _shirtColor = c_red;
var _pantsColor = c_red;

doll_initialize(5, 5, 3, 3, factions.player, _faceIndex, _hairIndex, _shirtIndex, _pantsIndex, _skinColor, _hairColor, _shirtColor, _pantsColor);


var _item = new ITEM_SWORD;
inventory_add(inventory, _item);

//NPC Commands for choices.
var _npcCommand1 = new NPCCommandSetDialogue($"You've been playing for {global.gameTime} steps. Long time!");
var _npcCommand2 = new NPCCommandSetDialogue($"You've been playing for {global.gameTime} steps. Not a long time.");

//an array of states.
var _commands = 
[
	new NPCCommandAwaitTarget(global.player, CLOSE_RANGE),
	new NPCCommandCheckGlobalVar("gameTime", _npcCommand1, _npcCommand2, 300, compare.greaterThan),
	new NPCCommandTalkTo(global.player)
];

var _loop = new NPCCommandLoop(_commands);

npc_initialize("Thorn", ["Good seeing you."], 100, _loop);