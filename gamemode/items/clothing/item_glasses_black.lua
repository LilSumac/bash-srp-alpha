local BASH = BASH;
local ITEM = {};
ITEM.ID =				"glasses_black";
ITEM.Name =				"Black Sunglasses";
ITEM.Description =		"A pair of tinted black sunglasses, not to be worn inside!";
ITEM.FlavorText =		"";
ITEM.WorldModel =		Model("models/props/cs_office/phone_p2.mdl");
ITEM.ModelColor =       Color(0, 0, 0);
ITEM.ModelScale =       0.7;
ITEM.Tier =             2;
ITEM.DefaultStock = 	40;
ITEM.DefaultPrice = 	300;

ITEM.IsClothing =		true;
ITEM.BodyPos =          "Eyes";
BASH:ProcessItem(ITEM);
