local BASH = BASH;
local ITEM = {};
ITEM.ID =				"baseballcap_yankees";
ITEM.Name =				"Yankees Baseball Cap";
ITEM.Description =		"A blue baseball cap with some American logo on the front, dating back to the 1999 World Series.";
ITEM.FlavorText =		"";
ITEM.WorldModel =		Model("models/props/cs_office/Snowman_hat.mdl");
ITEM.ModelColor =       Color(0, 0, 200);
ITEM.Weight =			0.5;
ITEM.DefaultStock = 	5;
ITEM.DefaultPrice = 	100;
ITEM.FabricYield =		2;

ITEM.IsClothing =		true;
ITEM.BodyPos =          "Head";
BASH:ProcessItem(ITEM);
