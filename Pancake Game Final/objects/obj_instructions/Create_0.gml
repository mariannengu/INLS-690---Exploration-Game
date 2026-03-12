step_index = 0;
steps = [
    ["Good Morning, Chef!", "Today we'll be making delicious pancakes for breakfast.\nAre you ready?\nPress SPACE to start!"],
    ["How to Play", "Listen to each instruction before pressing SPACE.\nTime your SPACE press to the rhythm and audio cues.\nLet's get cooking!"]
];
total_steps = array_length(steps);
flash_timer = 0;
show_prompt = true;