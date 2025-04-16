/// @description Recruits the NPC that owns the dropdown
if (instance_exists(owner))
{
	if (instance_exists(owner.creator))
	{
		with (owner.creator)
		{
			//Resets npcCommands array and has them just follow the player.
			_newState = new NPCCommandFollow(global.player);
				
			npcCommands = array_create(1, _newState);
		}
				
		if (ds_list_find_index(global.party, owner.creator) == -1)
		{
			ds_list_add(global.party, owner.creator)
		}
				
		if (ds_list_find_index(global.selected, owner.creator) == -1)
		{
			ds_list_add(global.selected, owner.creator)
		} 
				
	}
}

event_inherited();