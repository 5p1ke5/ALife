/// @description draws self, text
draw_self();
draw_set_font(fnt_button);
draw_text_color(x, y, text, textColor, textColor, textColor, textColor, 1);
draw_rectangle_color(bbox_left, bbox_top, bbox_right, bbox_bottom, lineColor, lineColor, lineColor, lineColor, true)
draw_set_font(fnt_default);