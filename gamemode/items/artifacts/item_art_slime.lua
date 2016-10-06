local BASH = BASH;
local ITEM = {};
ITEM.ID =				"art_slime";
ITEM.Name =				"Slime";
ITEM.Description =		"It's certain that this artifact is created by the Fruit Punch anomaly. When carried on the belt, the user's wounds bleed less, although their body becomes vulnerable to various burns.";
ITEM.FlavorText =		"";
ITEM.WorldModel =		Model("models/srp/items/art_slime.mdl");
ITEM.Tier =             2;
ITEM.Weight =			0.5;
ITEM.DefaultStock = 	0;
ITEM.DefaultPrice = 	9000;

ITEM.IsArtifact =       true;
ITEM.ArmorBoost =       10;
ITEM.BurnResist =       -10;
ITEM.RadsPerMin =       10;
BASH:ProcessItem(ITEM);
