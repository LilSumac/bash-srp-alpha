local BASH = BASH;
local ITEM = {};
ITEM.ID =				"cargo_wheat";
ITEM.Name =				"Wheat Camo Pants";
ITEM.Description =		"A pair of wheat cargo pants, complete with extra pockets.";
ITEM.FlavorText =		"";
ITEM.WorldModel =		Model("models/props_c17/SuitCase001a.mdl");
ITEM.ModelScale =       0.75;
ITEM.ModelColor =       Color(204, 102, 0);
ITEM.Weight =           2;
ITEM.DefaultStock = 	50;
ITEM.DefaultPrice = 	250;

ITEM.IsClothing =		true;
ITEM.BodyPos =          "Legs";
BASH:ProcessItem(ITEM);
