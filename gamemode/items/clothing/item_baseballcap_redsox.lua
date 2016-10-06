local BASH = BASH;
local ITEM = {};
ITEM.ID =				"baseballcap_redsox";
ITEM.Name =				"Red Sox Baseball Cap";
ITEM.Description =		"A red baseball cap with some American logo on the front, dating back to the 2004 World Series.";
ITEM.FlavorText =		"";
ITEM.WorldModel =		Model("models/props/cs_office/Snowman_hat.mdl");
ITEM.ModelColor =       Color(200, 0, 0);
ITEM.Weight =			0.5;
ITEM.DefaultStock = 	5;
ITEM.DefaultPrice = 	100;
ITEM.FabricYield =		2;

ITEM.IsClothing =		true;
ITEM.BodyPos =          "Head";
BASH:ProcessItem(ITEM);
