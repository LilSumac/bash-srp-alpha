local BASH = BASH;
local ITEM = {};
ITEM.ID =				"necklace_gold";
ITEM.Name =				"20\" Gold Chain";
ITEM.Description =		"A thin, twenty-inch gold chain. A necessity for chavs and thugs alike.";
ITEM.FlavorText =		"Only need one more...";
ITEM.WorldModel =		Model("models/Items/CrossbowRounds.mdl");
ITEM.ModelScale =       0.5;
ITEM.ModelColor =       Color(255, 215, 0);
ITEM.Tier =             2;
ITEM.DefaultStock = 	2;
ITEM.DefaultPrice = 	2500;

ITEM.IsClothing =		true;
ITEM.BodyPos =          "Neck";
BASH:ProcessItem(ITEM);
