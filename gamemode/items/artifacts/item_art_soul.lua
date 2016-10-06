local BASH = BASH;
local ITEM = {};
ITEM.ID =				"art_soul";
ITEM.Name =				"Soul";
ITEM.Description =		"Very rarely found artifact, located near the Whirligig anomaly. Only a very few manage to find this artifact, and few have even seen it. It has a nice shape and an equally nice price.";
ITEM.FlavorText =		"";
ITEM.WorldModel =		Model("models/kali/miscstuff/stalker/artifacts/soul.mdl");
ITEM.Tier =             3;
ITEM.Weight =			0.5;
ITEM.DefaultStock = 	0;
ITEM.DefaultPrice = 	25000;

ITEM.IsArtifact =       true;
ITEM.ArmorBoost =       15;
ITEM.RadsPerMin =       20;
BASH:ProcessItem(ITEM);
