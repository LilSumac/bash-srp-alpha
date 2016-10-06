local BASH = BASH;
local ITEM = {};
ITEM.ID =				"art_stone_flower";
ITEM.Name =				"Stone Flower";
ITEM.Description =		"Born in the Springboard anomaly. This artifact is found in only a few areas of the Zone. The bits of metallic compounds create a beautiful light play. It is very calming to study this artifact at night by the fire.";
ITEM.FlavorText =		"";
ITEM.WorldModel =		Model("models/kali/miscstuff/stalker/artifacts/stone flower.mdl");
ITEM.Tier =             1;
ITEM.Weight =			0.5;
ITEM.DefaultStock = 	0;
ITEM.DefaultPrice = 	2000;

ITEM.IsArtifact =       true;
ITEM.ArmorBoost =       2;
ITEM.RadsPerMin =       5;
BASH:ProcessItem(ITEM);
