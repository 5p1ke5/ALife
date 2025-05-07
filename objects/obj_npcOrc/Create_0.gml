/// @description Initializes character-specific variables
//Random character.

var _faceIndex = 12;
var _hairIndex = irandom(sprite_get_number(spr_dollHairs));
var _shirtIndex =irandom(sprite_get_number(spr_dollShirts));
var _pantsIndex = 0;
var _skinColor = choose(c_green, c_red, c_olive, c_lime, c_orange);
var _hairColor = c_black;
var _shirtColor = c_brunette;
var _pantsColor = c_brunette;

doll_initialize(5, 5, 3, 3, factions.neutral, _faceIndex, _hairIndex, _shirtIndex, _pantsIndex, _skinColor, _hairColor, _shirtColor, _pantsColor);


var _item = choose(new ITEM_AXE, new ITEM_HAMMER);
inventory_add(inventory, _item);

var _command = new NPCCommandMove(new Point2(x, y));

npc_initialize("Orc", ["I'll kill you!"], 100, _command);