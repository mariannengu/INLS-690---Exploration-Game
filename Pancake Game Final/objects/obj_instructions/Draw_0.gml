draw_clear(c_black);
var cx = room_width / 2;
var cy = room_height / 2;

// Draw instructions background sprite (scaled to fit room)
var sw = sprite_get_width(spr_game_instructions);
var sh = sprite_get_height(spr_game_instructions);
var scale_fit = min(room_width / sw, room_height / sh);
var draw_x = cx - (sw * scale_fit) / 2;
var draw_y = cy - (sh * scale_fit) / 2;
draw_sprite_ext(spr_game_instructions, 0, draw_x, draw_y, scale_fit, scale_fit, 0, c_white, 1);

draw_set_halign(fa_center);
draw_set_valign(fa_middle);
draw_set_font(fnt_main);
draw_set_color(c_white);
draw_text_transformed(cx, cy - 100, steps[step_index][0], 1.5, 1.5, 0);
draw_set_color(c_ltgray);
draw_text_ext_transformed(cx, cy + 20, steps[step_index][1], 36, room_width - 100, 1, 1, 0);
if (show_prompt) {
    draw_set_color(c_yellow);
    draw_text_transformed(cx, room_height - 60, "Press SPACE to continue", 1, 1, 0);
}
draw_set_halign(fa_left);
draw_set_valign(fa_top);
