step_index = 0;
steps = [
    ["Good Morning, Chef!", "Today we'll be making delicious pancakes for breakfast.\nAre you ready?\nPress SPACE to start!"],
    ["How to Play", "In this game, you will cook pancakes by listening carefully.\nRead or listen to each instruction, then press SPACE\nto perform the action at the right moment."],
    ["Audio Cues", "The game uses sounds to guide you.\nFor pouring, you will hear ticks — stop at the third tick.\nFor flipping, listen for the sizzle and wait for the bell."],
    ["Let's Cook!", "You will go through each step of making pancakes:\npouring, cracking, mixing, flipping, and stacking.\nGood luck, chef! Press SPACE to begin!"]
];
total_steps = array_length(steps);
flash_timer = 0;
show_prompt = true;