local BASH = BASH;

//	The intro screen background color.
BASH.IntroBG = Color(44, 62, 80);
//	The intro screen foreground color.
BASH.IntroFG = Color(255, 255, 255, 153);

//	Quiz question struct.
BASH.QuizQuestions = {
	{
		Text = "What universe is this roleplay set in?",
		Answers = {"Real life.", "The S.T.A.L.K.E.R. universe.", "The Half-Life universe."},
		Answer = 2
	},
	{
		Text = "What does OOC stand for?",
		Answers = {"Out-Of-Context", "Out-Of-Cereal", "Out-Of-Character"},
		Answer = 3
	},
	{
		Text = "What does IC stand for?",
		Answers = {"Indecisive-Crabs", "In-Character", "In-Context"},
		Answer = 2
	},
	{
		Text = "Weapons, items, and other script features are REQUIRED to roleplay.",
		Answers = {"True.", "False."},
		Answer = 2
	},
	{
		Text = "Do you understand the basic concepts of roleplay?",
		Answers = {"Yes!", "No."},
		Answer = 1
	},
	{
		Text = "Do you agree to follow and comply to the rules and respect the staff?",
		Answers = {"Yes!", "No."},
		Answer = 1
	},
	{
		Text = "The use of any and all client-side/third party hacks will result in a permanent ban.",
		Answers = {"Understood.", "Unacceptable!"},
		Answer = 1
	}
};

//	The introduction animation text. '*' characters denote a newline.
BASH.IntroMessages = {
	"lowry@LabConsole:~$ cat ~/NOTES/arrival.txt**I've only just arrived in Ukraine, but I'm already uncomfortable.*I'll be damned if I let fourteen years of excruciating research go to waste, yet...*I cannot stop yearning for my old apartment.*Hopefully this will pass with time.**Luckily, my colleagues are as interesting as I had anticipated.*I can already sense my childhood interests in the cosmos being rekindled."
};

//	Random messages that will appear when a player is hungry.
BASH.HungerMessages = {
	"I could really use a meal...",
	"Christ, I'm famished.",
	"Something to settle my stomach would be nice.",
	"When did I eat last?",
	"Have I got any food left?",
	"Was that my stomach?",
	"God, I'm starving.",
	"This hunger is really weighing me down..."
};
//	Random messages that will appear when a player is thirsty.
BASH.ThirstMessages = {
	"So much water, if only it weren't irradiated...",
	"A drink would be nice.",
	"Just a water bottle or something would hit the spot.",
	"My tongue's like sandpaper!",
	"I wonder if I've got anything left to drink..."
};
//	Random messages that will appear when a player wants a cigarette.
BASH.SmokeMessages = {
	"I need a smoke soon.",
	"I wonder if anyone else has a cig?"
};
