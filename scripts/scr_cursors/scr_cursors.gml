///@function cursor_state_set(_cursor)
///@description sets the cursor's sprite and state. See scr_globals.
///@param _cursor Cursor enum. see scr_macros.
function cursor_state_set(_cursor)
{
	global.cursorState = _cursor;
	cursor_sprite = global.cursors[_cursor];
}