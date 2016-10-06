local BASH = BASH;
local ITEM = {};
ITEM.ID =				"fedora_black";
ITEM.Name =				"Black Fedora";
ITEM.Description =		"A plain, black fedora. Out of stock for a reason.";
ITEM.FlavorText =		"M\'lady.";
ITEM.WorldModel =		Model("models/props_junk/garbage_bag001a.mdl");
ITEM.ModelColor =       Color(0, 0, 0);
ITEM.ModelScale =       0.7;
ITEM.Tier =             5;
ITEM.Weight =			0.5;
ITEM.DefaultStock = 	0;
ITEM.DefaultPrice = 	50000;
ITEM.FabricYield =		2;
ITEM.LootHidden =       true;

ITEM.IsClothing =		true;
ITEM.BodyPos =          "Head";
BASH:ProcessItem(ITEM);
