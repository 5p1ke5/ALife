/// @description Draws path if relevent.
// Inherit the parent event
event_inherited();

var _state = array_first(npcStates)

if (instanceof(_state) == "NPCStateMove")
{
	var _path = _state.mpPath;
	draw_path(_path, x, y, true);
}