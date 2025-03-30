/// @description Removes the doll from the party and selected lists.
if (instance_exists(owner))
{
	if (instance_exists(owner.creator))
	{
		global.selectedUnit = owner.creator;
	}
}

event_inherited();