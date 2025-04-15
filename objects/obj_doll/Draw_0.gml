/// @description Draws path if relevent.
// Inherit the parent event
event_inherited();

var _state = array_first(npcStates)

if (instanceof(_state) == "NPCStateMove")
{
	var _path = _state.mpPath;
	draw_path(_path, x, y, true);	
	for (var _i = 0; _i < path_get_number(_path); _i++) 
	{
	    show_debug_message("Point {0} - {1}, {2}", _i, path_get_point_x(_path, _i), path_get_point_y(_path, _i))
	}
}