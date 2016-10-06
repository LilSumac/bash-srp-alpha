local BASH = BASH;
local ITEM = {};
ITEM.ID =				"suit_jacket";
ITEM.Name =				"Suit Jacket";
ITEM.Description =		"A beautiful Italian suit jacket that would go /perfectly/ with some slacks.";
ITEM.FlavorText =		"";
ITEM.WorldModel =		Model("models/props_junk/garbage_bag001a.mdl");
ITEM.ModelColor =       Color(0, 0, 0);
ITEM.Weight =           2;
ITEM.DefaultStock = 	1;
ITEM.DefaultPrice = 	1000;

ITEM.IsClothing =		true;
ITEM.BodyPos =          "Torso";
BASH:ProcessItem(ITEM);
