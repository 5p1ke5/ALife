/// @description Spawns an NPC and designates them as player.
//TODO: Make it actually import stats (eg appearance etc)
var _player = instance_create_layer(x, y, layer, DOLL);

global.player = _player;