local BASH = BASH;
local ITEM = {};
ITEM.ID =				"belt_leather";
ITEM.Name =				"Leather Belt";
ITEM.Description =		"A thick leather belt, for holding up pants of course!";
ITEM.FlavorText =		"";
ITEM.WorldModel =		Model("models/props_canal/canal_cap001.mdl");
ITEM.ModelScale =       0.1;
ITEM.ModelColor =       Color(209, 139, 89);
ITEM.Tier =             2;
ITEM.Weight =           2;
ITEM.DefaultStock = 	30;
ITEM.DefaultPrice = 	50;

ITEM.IsClothing =		true;
ITEM.BodyPos =          "Waist";
BASH:ProcessItem(ITEM);
