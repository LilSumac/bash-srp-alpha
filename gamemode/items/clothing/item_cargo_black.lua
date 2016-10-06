local BASH = BASH;
local ITEM = {};
ITEM.ID =				"cargo_black";
ITEM.Name =				"Black Camo Pants";
ITEM.Description =		"A pair of black cargo pants, complete with extra pockets.";
ITEM.FlavorText =		"";
ITEM.WorldModel =		Model("models/props_c17/SuitCase001a.mdl");
ITEM.ModelScale =       0.75;
ITEM.ModelColor =       Color(0, 0, 0);
ITEM.Weight =           2;
ITEM.DefaultStock = 	50;
ITEM.DefaultPrice = 	250;

ITEM.IsClothing =		true;
ITEM.BodyPos =          "Legs";
BASH:ProcessItem(ITEM);
