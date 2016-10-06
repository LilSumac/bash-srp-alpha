local BASH = BASH;
local ITEM = {};
ITEM.ID =				"ushanka";
ITEM.Name =				"Ushanka";
ITEM.Description =		"A classic Russian fur cap, perfect for the chilly temperatures of the Zone.";
ITEM.FlavorText =		"";
ITEM.WorldModel =		Model("models/props/cs_office/Snowman_hat.mdl");
ITEM.ModelColor =       Color(0, 0, 0);
ITEM.Weight =			0.5;
ITEM.DefaultStock = 	100;
ITEM.DefaultPrice = 	30;
ITEM.FabricYield =		2;

ITEM.IsClothing =		true;
ITEM.BodyPos =          "Head";
BASH:ProcessItem(ITEM);
