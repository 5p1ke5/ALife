/// @description Makes the NPC that owns the dropdown talk to the target.
if (instance_exists(owner))
{
	if (instance_exists(owner.creator))
	{
		with (owner.creator)
		{
			//Won't talk if already talking.
			if (instanceof(npcStates[0]) != "NPCStateTalkTo")
			{
				array_insert(npcStates, 0, new NPCStateTalkTo(global.player));	
			}
		}
	}
}

event_inherited();