local BASH = BASH;
local ITEM = {};
ITEM.ID =				"belt_utility";
ITEM.Name =				"Utility Belt";
ITEM.Description =		"A handy little belt with loops for tools and the likes.";
ITEM.FlavorText =		"";
ITEM.WorldModel =		Model("models/props_canal/canal_cap001.mdl");
ITEM.ModelScale =       0.1;
ITEM.ModelColor =       Color(0, 0, 0);
ITEM.Tier =             2;
ITEM.Weight =           2;
ITEM.DefaultStock = 	1;
ITEM.DefaultPrice = 	200;

ITEM.IsClothing =		true;
ITEM.BodyPos =          "Waist";
BASH:ProcessItem(ITEM);
