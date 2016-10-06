local BASH = BASH;
local ITEM = {};
ITEM.ID =				"shawl_tribal";
ITEM.Name =				"Tribal Shawl";
ITEM.Description =		"A shawl with a very complex tribal pattern to be draped around the neck and shoulders.";
ITEM.FlavorText =		"";
ITEM.WorldModel =		Model("models/props_junk/garbage_bag001a.mdl");
ITEM.ModelScale =       0.7;
ITEM.ModelColor =       Color(200, 100, 100);
ITEM.DefaultStock = 	25;
ITEM.DefaultPrice = 	75;

ITEM.IsClothing =		true;
ITEM.BodyPos =          "Back";
BASH:ProcessItem(ITEM);
