/// @description Draws title screen.
draw_set_halign(fa_center);

draw_text_transformed(window_get_width()/2, window_get_height() / 4, "Action RPG", 4, 4, 0);

if (time % 10 != 0)
{
	draw_text(window_get_width() / 2, window_get_height() * 3 / 4, "WASD moves, left mouse attack, right mouse parry.\nYou can recruit allies in this game. 3 lets you use the cursor to select allies. \n4 lets your order allies to attack enemies, \n5 lets you order allies to move. 2 lets you pick individual party members to command.\nPress Any Key to Start!");
}

draw_set_halign(fa_left);