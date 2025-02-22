/// @description Inherit physics + timers. Executes NPC or player behavior,

event_inherited();

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

