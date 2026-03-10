// INTRO STATE
if (game_state == "intro") {
    if (keyboard_check_pressed(vk_space)
    || gamepad_button_check_pressed(0, gp_face1)) {
        intro_index++;
        if (intro_index >= array_length(intro_lines)) {
            start_step(); // intro done, begin cooking!
        }
    }
}

if (game_state == "active") {
    step_timer++;

    var input_type = step_inputs[current_step];
    var duration   = step_durations[current_step];
    
    // Combined input: keyboard OR controller
    var action_pressed = keyboard_check_pressed(vk_space)
                      || gamepad_button_check_pressed(0, gp_face1);
    var action_held    = keyboard_check(vk_space)
                      || gamepad_button_check(0, gp_face1);

    if (input_type == "press") {
        if (action_pressed) {
            pass_step("Perfect!");
        } else if (step_timer >= duration) {
            fail_step("Too slow!");
        }
    }

    else if (input_type == "hold") {
        if (action_held) {
            hold_frames++;
        }
        if (step_timer >= duration) {
            if (hold_frames >= duration * 0.7) {
                pass_step("Nice pour!");
            } else {
                fail_step("You didn't pour enough!");
            }
        }
    }

    else if (input_type == "mash") {
        if (action_pressed) {
            mash_count++;
        }
        if (step_timer >= duration) {
            if (mash_count >= mash_required) {
                pass_step("Great mixing!");
            } else {
                fail_step("Mix more next time!");
            }
        }
    }

    // Tick down feedback
    if (feedback_timer > 0) {
        feedback_timer--;
    }
}