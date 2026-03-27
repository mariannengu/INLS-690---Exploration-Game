// Step definitions: [title, instruction, mechanic]
// mechanic: "hold", "single", "repeat"
step_index = 0;
steps = [
    ["Pour Dry Mix",     "Pour the pancake mix into the bowl.\nHold SPACE and stop at the third tick.",  "hold"],
    ["Crack the Egg",    "Crack the egg into the bowl.\nPress SPACE!",                                   "single"],
    ["Pour the Milk",    "Pour the milk into the bowl.\nHold SPACE and stop at the third tick.",         "hold"],
    ["Mix the Batter",   "Stir the batter three times.\nPress SPACE three times!",                      "repeat"],
    ["Pour onto Pan",    "Pour the batter onto the hot pan.\nHold SPACE and stop at the third tick.",    "hold"],
    ["Flip the Pancake", "Listen for the sizzle...\nWhen you hear the bell, press SPACE to flip!",      "single"],
    ["Stack and Serve",  "Press SPACE to stack each pancake\nwhen the audio is at its loudest.",         "single"]
];
total_steps = array_length(steps);

// State machine
// States: "instruction", "action", "success", "fail"
state = "instruction";

// Hold mechanic
hold_ticks     = 0;
tick_target    = 3;
tick_count     = 0;
tick_interval  = 60; // frames between ticks
last_tick_frame = 0;

// Repeat mechanic
repeat_count   = 0;
repeat_target  = 3;

// Feedback timer (how long to show success/fail message)
feedback_timer = 0;
feedback_duration = 120; // 2 seconds

// Result of last action
result = ""; // "success" or "fail"

// Flash prompt
flash_timer = 0;
show_prompt = true;

