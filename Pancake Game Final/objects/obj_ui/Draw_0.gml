// Draw intro screen
if (obj_game.game_state == "intro") {
    draw_set_color(c_black);
    draw_rectangle(0, 0, room_width, room_height, false);
    draw_set_halign(fa_center);
    draw_set_color(c_white);
    draw_text(room_width/2, room_height/2 - 40, obj_game.intro_lines[obj_game.intro_index]);
    draw_set_color(c_yellow);
    draw_text(room_width/2, room_height/2 + 40, "Press SPACE to continue...");
    exit; // stops the rest of the UI from drawing during intro
}
// Background
draw_set_color(c_black);
draw_rectangle(0, 0, room_width, room_height, false);

var g = obj_game;

// Step name
draw_set_color(c_white);
draw_set_halign(fa_center);
draw_text(room_width/2, 80, "Step " + string(g.current_step + 1) + ": " + g.step_names[g.current_step]);

// Instruction prompt
draw_set_color(c_yellow);
draw_text(room_width/2, 160, g.step_prompts[g.current_step]);

// Timing bar
var bar_w = 400;
var bar_h = 30;
var bar_x = room_width/2 - bar_w/2;
var bar_y = 250;
var pct   = 1 - (g.step_timer / g.step_durations[g.current_step]);
pct       = clamp(pct, 0, 1);

draw_set_color(c_dkgray);
draw_rectangle(bar_x, bar_y, bar_x + bar_w, bar_y + bar_h, false);
draw_set_color(pct > 0.4 ? c_green : c_red);
draw_rectangle(bar_x, bar_y, bar_x + bar_w * pct, bar_y + bar_h, false);

// Feedback text
if (g.feedback_timer > 0) {
    draw_set_color(g.game_state == "success" ? c_lime : c_red);
    draw_text(room_width/2, 320, g.feedback_text);
}

// Score
draw_set_color(c_white);
draw_set_halign(fa_right);
draw_text(room_width - 20, 20, "Score: " + string(g.score) + "/" + string(g.total_steps));

// Mash counter
if (g.step_inputs[g.current_step] == "mash") {
    draw_set_halign(fa_center);
    draw_set_color(c_aqua);
    draw_text(room_width/2, 370, "Stirs: " + string(g.mash_count) + "/" + string(g.mash_required));
}