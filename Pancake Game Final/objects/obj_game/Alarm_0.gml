current_step++;

if (current_step >= total_steps) {
    game_state = "done";
    // room_goto(rm_results); // uncomment once you've made that room
} else {
    start_step();
}