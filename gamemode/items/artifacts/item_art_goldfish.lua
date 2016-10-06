local BASH = BASH;
local ITEM = {};
ITEM.ID =				"art_goldfish";
ITEM.Name =				"Goldfish";
ITEM.Description =		"The result of a superinteraction of gravitational fields, Goldfish produces its own strong directed gravitational field and significantly increases stalkers' load carrying abilities, which explains why it's always in great demand. Emits radiation.";
ITEM.FlavorText =		"";
ITEM.WorldModel =		Model("models/kali/miscstuff/stalker/artifacts/goldfish.mdl");
ITEM.Tier =             3;
ITEM.Weight =			-20;
ITEM.DefaultStock = 	0;
ITEM.DefaultPrice = 	40000;

ITEM.IsArtifact =       true;
ITEM.RadsPerMin =       30;
BASH:ProcessItem(ITEM);
