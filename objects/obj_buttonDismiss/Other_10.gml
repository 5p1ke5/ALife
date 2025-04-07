/// @description Removes the doll from the party and selected lists.
if (instance_exists(owner))
{
	if (instance_exists(owner.creator))
	{
		with (owner.creator)
		{
			_newState = new NPCStateIdle(noone);
				
			npcStates = array_create(1, _newState);
		}
		
		if (ds_list_find_index(global.party, owner.creator) != -1)
		{
			ds_list_delete(global.party, ds_list_find_index(global.party, owner.creator))
		}
				
		if (ds_list_find_index(global.selected, owner.creator) != -1)
		{
			ds_list_delete(global.selected, ds_list_find_index(global.selected, owner.creator))
		} 
	}
}

event_inherited();