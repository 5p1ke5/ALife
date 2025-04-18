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
	new NPCCommandMove(new Point2(x + 100, y), 1 * game_get_speed(gamespeed_fps)),
	new NPCCommandMove(new Point2(x, y), 1 * game_get_speed(gamespeed_fps)),
	new NPCCommandMove(new Point2(x - 100, y + 100), 1 * game_get_speed(gamespeed_fps))
];

var _loop = new NPCCommandLoop(_commands);

if (!global.storyTalkedToAtticus)
{
	npc_initialize("Johnny", ["Have you spoken to Atticus yet?"], 100, _loop);
}
else
{
	npc_initialize("Johnny",  ["So you talked to Atticus? Good.", "He used to be known as the greatest swordsman in the kingdom of Cydonia.", "He knows his stuff."], 100, _loop);
}