/// @description Checks if the doll object is a player. If so, destroys self, adds item to inventory, creates message telling player that happened.

var _isPlayer = false;

with (other)
{
	_isPlayer = (global.player == id);
}

if (_isPlayer)
{
	instance_destroy();
	inventory_add(other.inventory, item);
}