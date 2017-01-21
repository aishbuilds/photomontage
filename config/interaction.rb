require 'colorize'
module Interaction
	WELCOME = "Hi there! Welcome to Photomontage!!\nSimply provide 10 or less words, and get a collage of pictures representing your words, in seconds!\n".green + "Type".green + " 'exit' ".red + "anytime to stop providing words \n".green
	IN_PROGRESS = "\nHold on...While we make your collage...\n".green
	FILE_NAME = "\n\nGreat! Your photo collage is ready! What would you like to name it? \n".yellow + "* Do not provide file extension.".red
	COMPLETE = "\n\nDone! Type".green + " 'open images/FILE_NAME.jpg' ".magenta + "to view your image now! \n*If you using ruby interactive shell, exit from the shell.".green
end