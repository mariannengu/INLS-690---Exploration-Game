// FUNCTIONS (must be defined first)
function start_step() {
    step_timer  = 0;
    hold_frames = 0;
    mash_count  = 0;
    game_state  = "active";
    feedback_text = "";
}


function pass_step(message) {
    score++;
    feedback_text  = message;
    feedback_timer = 90;
    game_state     = "success";
    alarm[0]       = 60;
}

function fail_step(message) {
    feedback_text  = message;
    feedback_timer = 90;
    game_state     = "fail";
    alarm[0]       = 90;
}

// STEP DATA
step_names  = ["Pour Dry Mix", "Crack Egg", "Pour Milk", "Mix Batter", "Pour Batter", "Flip Pancake", "Stack & Serve"];
step_inputs = ["press", "press", "hold", "mash", "press", "press", "press"];
step_durations = [120, 90, 180, 150, 120, 90, 90];
step_prompts   = [
    "Press SPACE to pour the dry mix!",
    "Press SPACE to crack the egg!",
    "Hold SPACE to pour the milk...",
    "Mash SPACE to mix the batter!",
    "Press SPACE to pour the batter!",
    "Hit SPACE before it burns — listen for the bell!",
    "Press SPACE to stack and serve!"
];

// STATE VARIABLES
current_step    = 0;
total_steps     = array_length(step_names);
game_state      = "waiting";
timer           = 0;
step_timer      = 0;
hold_frames     = 0;
mash_count      = 0;
mash_required   = 8;
score           = 0;
feedback_text   = "";
feedback_timer  = 0;

// START THE GAME
// INTRO
intro_lines = [
    "Today we'll be making pancakes for breakfast!",
    "Follow the audio cues and press SPACE at the right time.",
    "Let's get cooking!",
    "Press SPACE to begin..."
];
intro_index = 0;
game_state  = "intro";