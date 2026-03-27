draw_clear(c_black);

var cx = room_width / 2;
var cy = room_height / 2;
draw_set_halign(fa_center);
draw_set_valign(fa_middle);
draw_set_font(fnt_main);

// -------------------------------------------------------
// Pick which sprite to show for each step + state
// Steps: 0=Pour Dry Mix, 1=Crack Egg, 2=Pour Milk,
//        3=Mix Batter, 4=Pour onto Pan, 5=Flip, 6=Stack
// -------------------------------------------------------
var ui_sprite = -1;
var ui_img    = 0;

switch (step_index) {
    case 0: // Pour Dry Mix
        ui_sprite = spr_step_mix;
        ui_img    = 0;
        break;
    case 1: // Crack the Egg
        if (state == "feedback" && result == "success") {
            ui_sprite = spr_step_egg_2;
        } else {
            ui_sprite = spr_step_egg_1;
        }
        ui_img = 0;
        break;
    case 2: // Pour the Milk
        ui_sprite = spr_step_milk;
        ui_img    = 0;
        break;
    case 3: // Mix the Batter
    if (state == "action") {
        // Create a visual tick that updates continuously
        var visual_tick = floor(tick_count + (current_time mod 300) / 300);

        if (visual_tick mod 2 == 0) {
            ui_sprite = spr_step_whisk_1;
        } else {
            ui_sprite = spr_step_whisk_2;
        }
    } 
    else if (state == "feedback" && result == "success") {
        ui_sprite = spr_step_whisk_2;
    } 
    else {
        ui_sprite = spr_step_whisk_1;
    }
    ui_img = 0;
    break;
    case 4: // Pour onto Pan
        if (state == "instruction") {
            ui_sprite = spr_step_pan_1;
        } else {
            ui_sprite = spr_step_pan_2;
        }
        ui_img = 0;
        break;
    case 5: // Flip the Pancake
        ui_sprite = spr_step_pan_3;
        ui_img    = 0;
        break;
    case 6: // Stack and Serve
        if (state == "feedback" && result == "success") {
            ui_sprite = spr_step_plate_done;
        } else if (state == "action") {
            ui_sprite = spr_step_plate_2;
        } else {
            ui_sprite = spr_step_plate_1;
        }
        ui_img = 0;
        break;
}

if (ui_sprite != -1) {
    var sw = sprite_get_width(ui_sprite);
    var sh = sprite_get_height(ui_sprite);

    var scale_cover = max(room_width / sw, room_height / sh);
    var scale = scale_cover * 0.8; // zoom out a bit

    var draw_w = sw * scale;
    var draw_h = sh * scale;

    var draw_x = cx - draw_w / 2;
    var draw_y = cy - draw_h / 2;

    draw_sprite_ext(ui_sprite, ui_img,
        draw_x, draw_y,
        scale, scale,
        0, c_white, 1);
}

// -------------------------------------------------------
// Step counter
// -------------------------------------------------------
draw_set_font(fnt_main);
draw_set_halign(fa_center);
draw_set_valign(fa_middle);
draw_set_color(c_gray);
draw_text_transformed(cx, 40, "Step " + string(step_index + 1) + " of " + string(total_steps), 1, 1, 0);

// Step title
draw_set_color(c_white);
draw_text_transformed(cx, cy - 120, steps[step_index][0], 1.8, 1.8, 0);

// -------------------------------------------------------
if (state == "instruction") {
    draw_set_color(c_ltgray);
    draw_text_ext_transformed(cx, cy, steps[step_index][1], 36, room_width - 100, 1, 1, 0);
    if (show_prompt) {
        draw_set_color(c_yellow);
        draw_text_transformed(cx, room_height - 60, "Press SPACE when ready", 1, 1, 0);
    }
}

// -------------------------------------------------------
else if (state == "action") {
    var mechanic = steps[step_index][2];

    if (mechanic == "hold") {
        draw_set_color(c_white);
        draw_text_transformed(cx, cy, "Hold SPACE...", 1.2, 1.2, 0);
        draw_set_color(c_yellow);
        draw_text_transformed(cx, cy + 80, "Ticks: " + string(tick_count) + " / " + string(tick_target), 1, 1, 0);
    }

    else if (mechanic == "single") {
        draw_set_color(c_white);
        draw_text_transformed(cx, cy, "Press SPACE!", 1.2, 1.2, 0);
    }

    else if (mechanic == "repeat") {
        draw_set_color(c_white);
        draw_text_transformed(cx, cy, "Keep pressing SPACE...", 1.2, 1.2, 0);
        draw_set_color(c_yellow);
        draw_text_transformed(cx, cy + 80, string(repeat_count) + " / " + string(repeat_target), 1, 1, 0);
    }
}

// -------------------------------------------------------
else if (state == "feedback") {
    if (result == "success") {
        draw_set_color(make_color_rgb(100, 220, 100));
        draw_text_transformed(cx, cy - 20, "Nice job!", 1.5, 1.5, 0);
        if (step_index < total_steps - 1) {
            draw_set_color(c_white);
            draw_text_transformed(cx, cy + 60, "Next: " + steps[step_index + 1][0], 1, 1, 0);
        }
    } else {
        draw_set_color(make_color_rgb(220, 100, 100));
        draw_text_transformed(cx, cy - 20, "That's okay, let's try again!", 1.5, 1.5, 0);
        if (feedback_timer >= feedback_duration && show_prompt) {
            draw_set_color(c_yellow);
            draw_text_transformed(cx, room_height - 60, "Press SPACE to try again", 1, 1, 0);
        }
    }
}

// Reset draw state
draw_set_halign(fa_left);
draw_set_valign(fa_top);
