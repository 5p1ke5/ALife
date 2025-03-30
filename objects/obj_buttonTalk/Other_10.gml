/// @description Makes the NPC that owns the dropdown speak.
if (instance_exists(owner))
{
	if (instance_exists(owner.creator))
	{
		with (owner.creator)
		{
			event_user(0);	
		}
	}
}