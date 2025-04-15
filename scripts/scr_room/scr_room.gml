/// @function room_initialize()
/// @description Initializes room variables.
function room_initialize()
{
	global.mpGrid = mp_grid_create(0, 0, room_width/GRID_CELL_WIDTH, room_height/GRID_CELL_HEIGHT, GRID_CELL_WIDTH, GRID_CELL_HEIGHT);
	mp_grid_add_instances(global.mpGrid, obj_block, false);
}