/// @description Inherit physics, decrements flicker.

//Invulnerability timer.
if (flicker > 0)
{
	flicker--;	
}

depth = -1;

// Inherit the parent event
event_inherited();

