/// @description Initializes character-specific variables
//Random character.

var _faceIndex = 9;
var _hairIndex = 8;
var _shirtIndex = 2;
var _pantsIndex = 0;
var _skinColor = c_black3;
var _hairColor = c_dkgray;
var _shirtColor = c_olive;
var _pantsColor = c_green;

doll_initialize(5, 5, 3, 3, factions.player, _faceIndex, _hairIndex, _shirtIndex, _pantsIndex, _skinColor, _hairColor, _shirtColor, _pantsColor);


var _item = new ITEM_SWORD;
inventory_add(inventory, _item);


if (global.storyTalkedToElder)
{
	var _commands = 
	[
		new NPCCommandIdle()
	];
	npc_initialize("Elder Irene", ["Good luck. The bandit's base is in the mountains to the east, inside the ruins."], 100, _commands);
}
else
{
	var _commands = 
	[
		new NPCCommandAwaitTarget(global.player),
		new NPCCommandSetGlobalVar("storyTalkedToElder", true),
		new NPCCommandTalkTo(global.player, ["Bandits have been coming in from the wilderness to the east and attacking our town. Our only warrior, Atticus, is busy defending the town.", "I will give you the authority to recruit a follower from among the villagers to aid you. Right-click and select 'Recruit' to make a villager follow you.", "In exchange, go to the mountains in the east. The bandits have made their base in the ruins there. Kill their leader and you will be rewarded handsomely."]),
		new NPCCommandMove(new Point2(x, y))
	];	
	npc_initialize("Elder Irene", ["Watch out, it's dangerous in the wilderness.", "There are outlaws living in the forest."], 100, _commands);
}