local BASH = BASH;
local ITEM = {};
ITEM.ID =				"gasmask";
ITEM.Name =				"Gasmask";
ITEM.Description =		"A full-face gasmask that filters out any noxious substances. Especially useful in the Zone.";
ITEM.FlavorText =		"";
ITEM.WorldModel =		Model("models/stalker/outfit/respirator.mdl");
ITEM.Weight =			2;
ITEM.DefaultStock = 	30;
ITEM.DefaultPrice = 	1500;
ITEM.MetalYield =		1;

ITEM.IsClothing =		true;
ITEM.BodyPos =          "Head";
BASH:ProcessItem(ITEM);
