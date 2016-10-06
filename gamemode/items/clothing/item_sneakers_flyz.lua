local BASH = BASH;
local ITEM = {};
ITEM.ID =				"sneakers_flyz";
ITEM.Name =				"\'Flyz\' Sneakers";
ITEM.Description =		"The latest craze for trendy European youths. A pair of fashionable black and red basketball sneakers.";
ITEM.FlavorText =		"\"\'Ey, don\'t scuff my Flyz!\'";
ITEM.WorldModel =		Model("models/props_junk/garbage_bag001a.mdl");
ITEM.ModelColor =       Color(0, 0, 0);
ITEM.ModelScale =       0.75;
ITEM.Weight =           1.5;
ITEM.DefaultStock = 	2;
ITEM.DefaultPrice = 	3000;

ITEM.IsClothing =		true;
ITEM.BodyPos =          "Feet";
BASH:ProcessItem(ITEM);
