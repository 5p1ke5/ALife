/// @description Makes the npc the dropdown belonged to follow the player.
if (instance_exists(owner))
{
	if (instance_exists(owner.creator))
	{
		with (owner.creator)
		{
			_newCommand = new NPCCommandFollow(global.player);
				
			npcCommands = array_create(1, _newCommand);
		}
				
	}
}

event_inherited();