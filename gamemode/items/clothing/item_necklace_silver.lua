local BASH = BASH;
local ITEM = {};
ITEM.ID =				"necklace_silver";
ITEM.Name =				"Silver Necklace";
ITEM.Description =		"A simple but beautiful thin silver necklace.";
ITEM.FlavorText =		"";
ITEM.WorldModel =		Model("models/Items/CrossbowRounds.mdl");
ITEM.ModelScale =       0.5;
ITEM.ModelColor =       Color(150, 150, 150);
ITEM.Tier =             2;
ITEM.DefaultStock = 	5;
ITEM.DefaultPrice = 	1000;

ITEM.IsClothing =		true;
ITEM.BodyPos =          "Neck";
BASH:ProcessItem(ITEM);
