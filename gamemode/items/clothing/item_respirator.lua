local BASH = BASH;
local ITEM = {};
ITEM.ID =				"respirator";
ITEM.Name =				"Respirator";
ITEM.Description =		"A simple respirator worn around the mouth that filters out any noxious substances. Especially useful in the Zone.";
ITEM.FlavorText =		"";
ITEM.WorldModel =		Model("models/stalker/outfit/respirator.mdl");
ITEM.Weight =			1;
ITEM.DefaultStock = 	60;
ITEM.DefaultPrice = 	1000;
ITEM.MetalYield =		1;

ITEM.IsClothing =		true;
ITEM.BodyPos =          "Head";
BASH:ProcessItem(ITEM);
