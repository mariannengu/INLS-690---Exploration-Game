function start_step(){
	function start_step() {
    step_timer  = 0;
    hold_frames = 0;
    mash_count  = 0;
    game_state  = "active";
    feedback_text = "";

    // Play the instruction audio cue for this step
    // audio_play_sound(asset_get_index(step_audio[current_step]), 1, false);
    // ^ Uncomment once you've added your sounds as assets
    
    show_debug_message("Starting step: " + step_names[current_step]);
}

}