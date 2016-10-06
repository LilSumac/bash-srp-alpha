local BASH = BASH;
local ITEM = {};
ITEM.ID =				"art_stone_blood";
ITEM.Name =				"Stone Blood";
ITEM.Description =		"You can find this artifact near the anomaly Whirligig. It is quite an ugly reddish object made out of pressed together and curiously bent polymerized remnants of plants, soil, and bones. Quite widespread and not very effective.";
ITEM.FlavorText =		"";
ITEM.WorldModel =		Model("models/kali/miscstuff/stalker/artifacts/stone blood.mdl");
ITEM.Tier =             1;
ITEM.Weight =			0.5;
ITEM.DefaultStock = 	0;
ITEM.DefaultPrice = 	4000;

ITEM.IsArtifact =       true;
ITEM.ArmorBoost =       5;
ITEM.RadsPerMin =       10;
BASH:ProcessItem(ITEM);
