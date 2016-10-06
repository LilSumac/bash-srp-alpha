local BASH = BASH;
local ITEM = {};
ITEM.ID =				"art_kolobok";
ITEM.Name =				"Kolobok";
ITEM.Description =		"A relatively rare and expensive artifact, which forms in chemically active areas. Highly valued for its ability to increase the body's overall well-being. Emits radiation.";
ITEM.FlavorText =		"";
ITEM.WorldModel =		Model("models/kali/miscstuff/stalker/artifacts/kolobok.mdl");
ITEM.Tier =             4;
ITEM.Weight =			0.5;
ITEM.DefaultStock = 	0;
ITEM.DefaultPrice = 	40000;

ITEM.IsArtifact =       true;
ITEM.ArmorBoost =       15;
ITEM.RadsPerMin =       20;
BASH:ProcessItem(ITEM);
