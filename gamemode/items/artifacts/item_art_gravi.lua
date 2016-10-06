local BASH = BASH;
local ITEM = {};
ITEM.ID =				"art_gravi";
ITEM.Name =				"Gravi";
ITEM.Description =		"Gravi is formed from metallic substances exposed to prolonged gravitation. This makes it capable of sustaining an antigravitational field, helping many stalkers carry greater loads. Emits radiation.";
ITEM.FlavorText =		"";
ITEM.WorldModel =		Model("models/kali/miscstuff/stalker/artifacts/gravi.mdl");
ITEM.Tier =             3;
ITEM.Weight =			-10;
ITEM.DefaultStock = 	0;
ITEM.DefaultPrice = 	30000;

ITEM.IsArtifact =       true;
ITEM.RadsPerMin =       20;
BASH:ProcessItem(ITEM);
