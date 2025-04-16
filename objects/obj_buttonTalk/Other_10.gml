/// @description Makes the NPC that owns the dropdown talk to the target.
if (instance_exists(owner))
{
	if (instance_exists(owner.creator))
	{
		with (owner.creator)
		{
			//Won't talk if already talking.
			if (instanceof(npcCommands[0]) != "NPCCommandTalkTo")
			{
				array_insert(npcCommands, 0, new NPCCommandTalkTo(global.player));	
			}
		}
	}
}

event_inherited();