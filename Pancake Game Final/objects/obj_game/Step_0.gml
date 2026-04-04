flash_timer++;
if (flash_timer >= 30) {
    flash_timer = 0;
    show_prompt = !show_prompt;
}

var mechanic = steps[step_index][2];

// -------------------------------------------------------
if (state == "instruction") {
    if (keyboard_check_pressed(vk_space)) {
        state = "action";
        hold_ticks    = 0;
        tick_count    = 0;
        repeat_count  = 0;
        last_tick_frame = current_time;

        // Set repeat_target per step
        if (step_index == 3) repeat_target = 3; // Mix Batter
        if (step_index == 6) repeat_target = 5; // Stack and Serve
    }
}

// -------------------------------------------------------
else if (state == "action") {

    // --- HOLD mechanic ---
    if (mechanic == "hold") {
        if (keyboard_check(vk_space)) {
            hold_ticks++;
            if (hold_ticks mod tick_interval == 0) {
                tick_count++;
            }
            if (tick_count == tick_target) {
                result = "success";
                state = "feedback";
                feedback_timer = 0;
            }
        }
        if (keyboard_check_released(vk_space)) {
            if (state != "feedback") {
                result = "fail";
                state = "feedback";
                feedback_timer = 0;
            }
        }
    }

    // --- SINGLE PRESS mechanic ---
    else if (mechanic == "single") {
        if (keyboard_check_pressed(vk_space)) {
            result = "success";
            state = "feedback";
            feedback_timer = 0;
        }
    }

    // --- REPEAT PRESS mechanic ---
    else if (mechanic == "repeat") {
        if (keyboard_check_pressed(vk_space)) {
            repeat_count++;
        }
        if (repeat_count >= repeat_target) {
            result = "success";
            state = "feedback";
            feedback_timer = 0;
        }
    }
}

// -------------------------------------------------------
else if (state == "feedback") {
    feedback_timer++;
    if (feedback_timer >= feedback_duration) {
        if (result == "fail") {
            if (keyboard_check_pressed(vk_space)) {
                state = "action";
                hold_ticks   = 0;
                tick_count   = 0;
                repeat_count = 0;
            }
        } else {
            step_index++;
            if (step_index >= total_steps) {
                room_goto(rm_gameover);
            } else {
                state = "instruction";
            }
        }
    }
}
