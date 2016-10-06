local BASH = BASH;
local ITEM = {};
ITEM.ID =				"baseballcap_black";
ITEM.Name =				"Black Baseball Cap";
ITEM.Description =		"A simple black baseball cap, to be worn forwards, backwards, or any which way.";
ITEM.FlavorText =		"";
ITEM.WorldModel =		Model("models/props/cs_office/Snowman_hat.mdl");
ITEM.ModelColor =       Color(0, 0, 0);
ITEM.Weight =			0.5;
ITEM.DefaultStock = 	5;
ITEM.DefaultPrice = 	50;
ITEM.FabricYield =		2;

ITEM.IsClothing =		true;
ITEM.BodyPos =          "Head";
BASH:ProcessItem(ITEM);
