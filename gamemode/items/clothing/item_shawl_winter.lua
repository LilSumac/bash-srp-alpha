local BASH = BASH;
local ITEM = {};
ITEM.ID =				"shawl_winter";
ITEM.Name =				"Winter Shawl";
ITEM.Description =		"A white-and-black patterned shawl to be draped around the neck and shoulders.";
ITEM.FlavorText =		"";
ITEM.WorldModel =		Model("models/props_junk/garbage_bag001a.mdl");
ITEM.ModelScale =       0.7;
ITEM.ModelColor =       Color(100, 100, 100);
ITEM.DefaultStock = 	35;
ITEM.DefaultPrice = 	75;

ITEM.IsClothing =		true;
ITEM.BodyPos =          "Back";
BASH:ProcessItem(ITEM);
