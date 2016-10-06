local BASH = BASH;
local ITEM = {};
ITEM.ID =				"sneakers_purple";
ITEM.Name =				"Purple Sneakers";
ITEM.Description =		"A pair of purple sneakers for casual use.";
ITEM.FlavorText =		"";
ITEM.WorldModel =		Model("models/props_junk/garbage_bag001a.mdl");
ITEM.ModelColor =       Color(255, 0, 127);
ITEM.ModelScale =       0.75;
ITEM.Weight =           1.5;
ITEM.DefaultStock = 	50;
ITEM.DefaultPrice = 	75;

ITEM.IsClothing =		true;
ITEM.BodyPos =          "Feet";
BASH:ProcessItem(ITEM);
