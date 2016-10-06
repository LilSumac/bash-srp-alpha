local BASH = BASH;
local ITEM = {};
ITEM.ID =				"shemagh_woodland";
ITEM.Name =				"Woodland Shemagh";
ITEM.Description =		"A woodland-patterend shemagh that's wrapped around the head and shoulders.";
ITEM.FlavorText =		"";
ITEM.WorldModel =		Model("models/props_junk/garbage_bag001a.mdl");
ITEM.ModelScale =       0.7;
ITEM.ModelColor =       Color(50, 200, 50);
ITEM.Weight =			0.5;
ITEM.DefaultStock = 	25;
ITEM.DefaultPrice = 	50;
ITEM.FabricYield =		3;

ITEM.IsClothing =		true;
ITEM.BodyPos =          "Head";
BASH:ProcessItem(ITEM);
