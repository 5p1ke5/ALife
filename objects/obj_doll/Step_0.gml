
event_inherited();

doll_animate();

//If the doll is a player allows for control.
if (global.player == id)
{
	player_control();
}
//Otherwise decides how the NPC is going to move, sets state.
else
{
	npc_behavior();
}

