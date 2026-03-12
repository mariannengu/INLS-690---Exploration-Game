draw_clear(c_black);

var cx = room_width / 2;
var cy = room_height / 2;
draw_set_halign(fa_center);
draw_set_valign(fa_middle);
draw_set_font(fnt_main);

// Step counter
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
        // Tick counter
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
        draw_set_color(make_color_rgb(100, 220, 100)); // green
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