/// @description Dispels the dropdown if the player clicks off it.
if (MOUSE_LEFT_BUTTON_NOT_GUI || MOUSE_RIGHT_BUTTON_PRESSED)
{
	instance_destroy();	
}