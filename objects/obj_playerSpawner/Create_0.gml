/// @description Spawns an doll and designates them as player.
//TODO: Make it actually import stats (eg appearance etc)
var _player = instance_create_layer(x, y, layer, DOLL);

var _faceIndex = global.playerFaceIndex;
var _hairIndex = global.playerHairIndex;
var _shirtIndex = global.playerShirtIndex;
var _pantsIndex = global.playerPantsIndex;

var _skinColor = global.playerSkinColor;
var _hairColor = global.playerHairColor;
var _shirtColor = global.playerShirtColor;
var _pantsColor = global.playerPantsColor;

with (_player)
{
	doll_initialize(global.playerMaxHP, global.playerHP, global.playerMaxPP, global.playerPP, factions.player, _faceIndex, _hairIndex, _shirtIndex, _pantsIndex, _skinColor, _hairColor, _shirtColor, _pantsColor);	
}


party_add(_player);
global.player = _player;

serializeInstance(_player);