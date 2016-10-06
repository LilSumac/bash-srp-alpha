local BASH = BASH;
local ITEM = {};
ITEM.ID =				"kneepads_black";
ITEM.Name =				"Black Kneepads";
ITEM.Description =		"A pair of black combat kneepads. These'll relieve some discomfort from crouching for sure.";
ITEM.FlavorText =		"";
ITEM.WorldModel =		Model("models/props_junk/garbage_bag001a.mdl");
ITEM.ModelScale =       0.5;
ITEM.ModelColor =       Color(0, 0, 0);
ITEM.Weight =           0.75;
ITEM.DefaultStock = 	20;
ITEM.DefaultPrice = 	50;

ITEM.IsClothing =		true;
ITEM.BodyPos =          "Knees";
BASH:ProcessItem(ITEM);
