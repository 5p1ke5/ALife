//Draws self, allowing for flicker.

if (flicker % 2 == 0)
{
	doll_draw();
	if (angle != -1)
	{
		draw_sprite_ext(spr_dollHand, 0, x, y, 1, 1, angle, image_blend, image_alpha);
	}
	
}
