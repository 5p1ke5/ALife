/// @description Removes the doll from the party and selected lists.
if (instance_exists(owner))
{
	if (instance_exists(owner.creator))
	{
		global.selectedUnit = owner.creator;
		
		cursor_state_set(cursor.move);
	}
}

event_inherited();