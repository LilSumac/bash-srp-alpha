local BASH = BASH;
local ITEM = {};
ITEM.ID =				"glasses_aviators";
ITEM.Name =				"Aviator Sunglasses";
ITEM.Description =		"A pair of chrome, reflective sunglasses, often worn by pilots.";
ITEM.FlavorText =		"";
ITEM.WorldModel =		Model("models/props/cs_office/phone_p2.mdl");
ITEM.ModelColor =       Color(0, 0, 0);
ITEM.ModelScale =       0.7;
ITEM.Tier =             2;
ITEM.DefaultStock = 	0;
ITEM.DefaultPrice = 	500;
ITEM.LootHidden =       true;

ITEM.IsClothing =		true;
ITEM.BodyPos =          "Eyes";
BASH:ProcessItem(ITEM);
