local BASH = BASH;
local ITEM = {};
ITEM.ID =				"glasses_framed";
ITEM.Name =				"Framed Glasses";
ITEM.Description =		"A pair of perscription glasses for the visually-challenged.";
ITEM.FlavorText =		"";
ITEM.WorldModel =		Model("models/props/cs_office/phone_p2.mdl");
ITEM.ModelColor =       Color(0, 0, 0);
ITEM.ModelScale =       0.7;
ITEM.Tier =             2;
ITEM.DefaultStock = 	20;
ITEM.DefaultPrice = 	250;

ITEM.IsClothing =		true;
ITEM.BodyPos =          "Eyes";
BASH:ProcessItem(ITEM);
