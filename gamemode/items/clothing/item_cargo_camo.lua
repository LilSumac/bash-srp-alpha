local BASH = BASH;
local ITEM = {};
ITEM.ID =				"cargo_camo";
ITEM.Name =				"Cargo Camo Pants";
ITEM.Description =		"A pair of cargo pants in camoflauge fashion, complete with extra pockets.";
ITEM.FlavorText =		"";
ITEM.WorldModel =		Model("models/props_c17/SuitCase001a.mdl");
ITEM.ModelScale =       0.75;
ITEM.ModelColor =       Color(0, 200, 0);
ITEM.Weight =           2;
ITEM.DefaultStock = 	50;
ITEM.DefaultPrice = 	250;

ITEM.IsClothing =		true;
ITEM.BodyPos =          "Legs";
BASH:ProcessItem(ITEM);
