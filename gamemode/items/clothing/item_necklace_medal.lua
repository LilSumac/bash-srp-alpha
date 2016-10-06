local BASH = BASH;
local ITEM = {};
ITEM.ID =				"necklace_medal";
ITEM.Name =				"Worn Medal";
ITEM.Description =		"An old medal, but the prize and engravings are worn. All you know is, you\'re a winner.";
ITEM.FlavorText =		"";
ITEM.WorldModel =		Model("models/Items/CrossbowRounds.mdl");
ITEM.ModelScale =       0.5;
ITEM.ModelColor =       Color(159, 89, 39);
ITEM.Tier =             2;
ITEM.DefaultStock = 	0;
ITEM.DefaultPrice = 	1000;

ITEM.IsClothing =		true;
ITEM.BodyPos =          "Neck";
BASH:ProcessItem(ITEM);
