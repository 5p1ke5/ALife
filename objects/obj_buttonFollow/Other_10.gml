/// @description Makes the npc the dropdown belonged to follow the player.
if (instance_exists(owner))
{
	if (instance_exists(owner.creator))
	{
		with (owner.creator)
		{
			_newState = new NPCStateFollow(global.player);
				
			state = _newState;
		}
				
	}
}

event_inherited();