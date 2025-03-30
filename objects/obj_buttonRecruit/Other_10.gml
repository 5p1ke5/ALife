/// @description Recruits the NPC that owns the dropdown
if (instance_exists(owner))
{
	if (instance_exists(owner.creator))
	{
		with (owner.creator)
		{
			_newState = new NPCStateFollow(global.player);
				
			state = _newState;
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