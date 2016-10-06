local BASH = BASH;
local ITEM = {};
ITEM.ID =				"art_jellyfish";
ITEM.Name =				"Jellyfish";
ITEM.Description =		"This artifact is formed in the Springboard. Forms a weak protective field whose side effect is a slight radiation. The artifact is widespread and notvery valuable.";
ITEM.FlavorText =		"";
ITEM.WorldModel =		Model("models/kali/miscstuff/stalker/artifacts/jellyfish.mdl");
ITEM.Tier =             1;
ITEM.Weight =			0.5;
ITEM.DefaultStock = 	0;
ITEM.DefaultPrice = 	3000;

ITEM.IsArtifact =       true;
ITEM.ArmorBoost =       5;
ITEM.RadsPerMin =       10;
BASH:ProcessItem(ITEM);
