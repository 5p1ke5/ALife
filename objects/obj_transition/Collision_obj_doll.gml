/// @description Checks if the colliding doll is a player. If so, transitions to the defined room.
if (global.player == other.id)
{
	global.partySerialized = party_serialize();
	transition_goto();	
}