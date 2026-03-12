if (keyboard_check_pressed(vk_space)) {
    step_index++;
    if (step_index >= total_steps) {
        room_goto(rm_game);
    }
}
flash_timer++;
if (flash_timer >= 30) {
    flash_timer = 0;
    show_prompt = !show_prompt;
}