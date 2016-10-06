local BASH = BASH;
local ITEM = {};
ITEM.ID =				"earmuffs_rangemaster";
ITEM.Name =				"Rangemaster's Earmuffs";
ITEM.Description =		"A pair of faded-orange, high-grade earmuffs, usually worn by a rangemaster or range patron.";
ITEM.FlavorText =		"";
ITEM.WorldModel =		Model("models/props/cs_office/phone_p2.mdl");
ITEM.ModelColor =       Color(255, 69, 0);
ITEM.Weight =			0.25;
ITEM.DefaultStock = 	10;
ITEM.DefaultPrice = 	150;
ITEM.MetalYield =		1;

ITEM.IsClothing =		true;
ITEM.BodyPos =          "Ears";
BASH:ProcessItem(ITEM);
