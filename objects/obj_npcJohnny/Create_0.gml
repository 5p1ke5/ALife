/// @description Initializes character-specific variables
//Random character.

var _faceIndex = 6;
var _hairIndex = 10;
var _shirtIndex = 7;
var _pantsIndex = 0;
var _skinColor = c_white2;
var _hairColor = c_navy;
var _shirtColor = c_purple;
var _pantsColor = c_navy;

doll_initialize(5, 5, 3, 3, factions.player, _faceIndex, _hairIndex, _shirtIndex, _pantsIndex, _skinColor, _hairColor, _shirtColor, _pantsColor);


var _item = new ITEM_SWORD;
inventory_add(inventory, _item);

//an array of states.

var _commands = 
[
	new NPCCommandMove(new Point2(800, 2700), 1 * game_get_speed(gamespeed_fps)),
	new NPCCommandCheckGlobal("storyTalkedToAtticus", new NPCCommandSetDialogue("So you talked to Atticus. He used to be a powerful knight, he knows his stuff."), new NPCCommandSetDialogue("Have you talked to Atticus yet?")),
	new NPCCommandMove(new Point2(1000, 2700), 1 * game_get_speed(gamespeed_fps)),
	new NPCCommandCheckGlobal("storyTalkedToAtticus", new NPCCommandSetDialogue("So you talked to Atticus. He used to be a powerful knight, he knows his stuff."), new NPCCommandSetDialogue("Have you talked to Atticus yet?")),
	new NPCCommandMove(new Point2(900, 2600), 1 * game_get_speed(gamespeed_fps))
];

var _loop = new NPCCommandLoop(_commands);

npc_initialize("Johnny", ["Have you spoken to Atticus yet?"], 100, _loop);