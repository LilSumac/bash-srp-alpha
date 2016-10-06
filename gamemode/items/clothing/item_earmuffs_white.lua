local BASH = BASH;
local ITEM = {};
ITEM.ID =				"earmuffs_white";
ITEM.Name =				"White Earmuffs";
ITEM.Description =		"A pair of fuzzy white earmuffs, perfect for keeping your ears warm in the Zone.";
ITEM.FlavorText =		"";
ITEM.WorldModel =		Model("models/props/cs_office/phone_p2.mdl");
ITEM.ModelColor =       Color(255, 255, 255);
ITEM.Weight =			0.25;
ITEM.DefaultStock = 	50;
ITEM.DefaultPrice = 	50;
ITEM.MetalYield =		1;

ITEM.IsClothing =		true;
ITEM.BodyPos =          "Ears";
BASH:ProcessItem(ITEM);
