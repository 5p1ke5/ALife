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

doll_initialize(5, 5, 3, 3, factions.player, _faceIndex, _hairIndex, _shirtIndex, _pantsIndex, _skinColor, _hairColor, _shirtColor, _pantsColor);


var _item = new ITEM_SWORD;
inventory_add(inventory, _item);

//an array of states.
var _states = 
[
	new NPCStateTalkTo(global.player,  ["Hail, traveller! Welcome to Harrowgate Village. Use WASD to move.", "You can interact with people by right-clicking on them.", "Talk to me if you need help!"]),
	new NPCStateSetDialogue(["I used to be a soldier in the king's army. But that was long ago.", "Now I'm just a guardsman in a comfy little village."]),
	new NPCStateMove(new Point2(480, 2656))
];

npc_initialize("Atticus", ["Good seeing you."], 100, _states);