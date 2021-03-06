local BASH = BASH;
local ITEM = {};
ITEM.ID =				"balaclava_black";
ITEM.Name =				"Black Balaclava";
ITEM.Description =		"A black balaclava worn by robbers and STALKERs alike.";
ITEM.FlavorText =		"";
ITEM.WorldModel =		Model("models/props_junk/garbage_bag001a.mdl");
ITEM.ModelScale =       0.7;
ITEM.ModelColor =       Color(0, 0, 0);
ITEM.Weight =			0.5;
ITEM.DefaultStock = 	25;
ITEM.DefaultPrice = 	50;
ITEM.FabricYield =		3;

ITEM.IsClothing =		true;
ITEM.BodyPos =          "Head";
BASH:ProcessItem(ITEM);
