/// @description Draws path if relevant.
// Inherit the parent event
event_inherited();

var _state = array_first(npcStates)

if (instanceof(_state) == "NPCStateMovePath")
{
	var _path = _state.mpPath;
	draw_path(_path, x, y, true);
}